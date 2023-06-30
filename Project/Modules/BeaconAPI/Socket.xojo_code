#tag Class
Protected Class Socket
	#tag Method, Flags = &h1
		Protected Sub AdvanceQueue()
		  If Self.Queue.LastIndex = -1 Then
		    Self.Working = False
		    Return
		  End If
		  
		  Var Request As BeaconAPI.Request = Self.Queue(0)
		  Self.Queue.RemoveAt(0)
		  
		  Self.ActiveRequest = Request
		  
		  Self.Constructor()
		  
		  Var URL As String = Request.URL
		  Var Headers() As String = Request.RequestHeaders
		  For Each Header As String In Headers
		    Self.Socket.RequestHeader(Header) = Request.RequestHeader(Header)
		  Next
		  Self.Socket.RequestHeader("Cache-Control") = "no-cache"
		  Self.Socket.RequestHeader("User-Agent") = App.UserAgent
		  
		  If Request.Method = "GET" Then
		    Var Query As String = Request.Query
		    If Query <> "" Then
		      URL = URL + "?" + Query
		    End If
		    #if DebugBuild
		      App.Log("GET " + URL)
		    #endif
		    Self.Socket.Send("GET", URL)
		  Else
		    Self.Socket.SetRequestContent(Request.Payload, Request.ContentType)
		    #if DebugBuild
		      App.Log(Request.Method + " " + URL)
		    #endif
		    Self.Socket.Send(Request.Method, URL)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_RequestChallenge(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  If Response.HTTPStatus = 200 And (Response.JSON Is Nil) = False And Response.JSON IsA Dictionary Then
		    Var Dict As Dictionary = Response.JSON
		    Var Challenge As String = Dict.Lookup("challenge", "")
		    
		    Var TokenRequest As BeaconAPI.Request = BeaconAPI.Request.CreateSessionRequest(AddressOf APICallback_RequestToken)
		    TokenRequest.Sign(App.IdentityManager.CurrentIdentity, Challenge)
		    TokenRequest.HasBeenRetried = True // Lie to prevent it from being tried again
		    
		    Self.Queue.AddAt(0, TokenRequest)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_RequestToken(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  If Response.HTTPStatus = 200 And (Response.JSON Is Nil) = False And Response.JSON IsA Dictionary Then
		    Var Dict As Dictionary = Response.JSON
		    Var SessionToken As String = Dict.Lookup("session_id", "")
		    If SessionToken.IsEmpty Then
		      Return
		    End If
		    
		    //Preferences.OnlineToken = SessionToken
		    
		    For Idx As Integer = 0 To Self.Queue.LastIndex
		      If Self.Queue(Idx).AuthType = BeaconAPI.Request.AuthTypes.Token Then
		        Self.Queue(Idx).Authenticate(SessionToken)
		      End If
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.Socket = New URLConnection
		  Self.Socket.AllowCertificateValidation = True
		  AddHandler Self.Socket.Error, WeakAddressOf Socket_Error
		  AddHandler Self.Socket.ContentReceived, WeakAddressOf Socket_ContentReceived
		  AddHandler Self.Socket.ReceivingProgressed, WeakAddressOf Socket_ReceivingProgressed
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  CallLater.Cancel(Self.mAdvanceQueueCallbackKey)
		  
		  Self.Socket.Disconnect
		  Self.Socket = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Socket_ContentReceived(Sender As URLConnection, URL As String, HTTPStatus As Integer, Content As String)
		  #Pragma Unused URL
		  
		  If HTTPStatus = 403 Then
		    Var ShouldRetry As Boolean = Self.ActiveRequest.HasBeenRetried = False And (App.IdentityManager.CurrentIdentity Is Nil) = False
		    
		    If ShouldRetry Then
		      #Pragma BreakOnExceptions False
		      Try
		        Var Dict As Dictionary = Beacon.ParseJSON(Content.DefineEncoding(Encodings.UTF8))
		        Var ReasonCode As String = Dictionary(Dict.Value("details").ObjectValue).Value("code").StringValue
		        If ReasonCode = "2FA_ENABLED" Then
		          ShouldRetry = False
		        End If
		      Catch Err As RuntimeException
		        App.Log(Err, CurrentMethodName, "Looking for reason code in 403 response")
		      End Try
		      #Pragma BreakOnExceptions Default
		    End If
		    
		    If ShouldRetry Then
		      // Going to try to get a valid session token
		      Var ChallengeRequest As New BeaconAPI.Request(BeaconAPI.URL("challenge/" + App.IdentityManager.CurrentIdentity.UserId), "GET", AddressOf APICallback_RequestChallenge)
		      ChallengeRequest.HasBeenRetried = True // Lie to prevent it from being tried again
		      
		      Var OriginalRequest As BeaconAPI.Request = Self.ActiveRequest
		      OriginalRequest.HasBeenRetried = True
		      
		      Self.Queue.AddAt(0, ChallengeRequest)
		      Self.Queue.AddAt(1, OriginalRequest)
		      
		      Self.ActiveRequest = Nil
		      Self.mAdvanceQueueCallbackKey = CallLater.Schedule(50, WeakAddressOf AdvanceQueue)
		      Return
		    End If
		  End If
		  
		  Var Headers As New Dictionary
		  For Each Header As Pair In Sender.ResponseHeaders
		    Headers.Value(Header.Left) = Header.Right
		  Next
		  
		  Var Response As New BeaconAPI.Response(URL, HTTPStatus, Content, Headers)
		  #if DebugBuild
		    System.DebugLog(Self.ActiveRequest.Method + " " + URL + ": " + HTTPStatus.ToString(Locale.Raw, "0"))
		  #endif
		  Self.ActiveRequest.InvokeCallback(Response)
		  Self.ActiveRequest = Nil
		  
		  Self.mAdvanceQueueCallbackKey = CallLater.Schedule(10, WeakAddressOf AdvanceQueue)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Socket_Error(Sender As URLConnection, Err As RuntimeException)
		  #Pragma Unused Sender
		  
		  Self.ActiveRequest.InvokeCallback(New BeaconAPI.Response(Err))
		  Self.ActiveRequest = Nil
		  Self.mAdvanceQueueCallbackKey = CallLater.Schedule(10, WeakAddressOf AdvanceQueue)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Socket_ReceivingProgressed(Sender As URLConnection, BytesReceived As Int64, BytesTotal As Int64, NewData As String)
		  #Pragma Unused Sender
		  #Pragma Unused NewData
		  
		  RaiseEvent WorkProgress(Self.ActiveRequest, BytesReceived, BytesTotal)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Start(Request As BeaconAPI.Request)
		  Self.Queue.Add(Request)
		  If Self.Queue.LastIndex = 0 And Self.Working = False Then
		    Self.mAdvanceQueueCallbackKey = CallLater.Schedule(50, WeakAddressOf AdvanceQueue)
		    Self.Working = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Working() As Boolean
		  Return Self.mWorking
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Working(Assigns Value As Boolean)
		  If Self.mWorking = Value Then
		    Return
		  End If
		  
		  Self.mWorking = Value
		  If Self.mWorking Then
		    RaiseEvent WorkStarted
		  Else
		    RaiseEvent WorkCompleted
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event WorkCompleted()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event WorkProgress(Request As BeaconAPI.Request, BytesReceived As Int64, BytesTotal As Int64)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event WorkStarted()
	#tag EndHook


	#tag Property, Flags = &h21
		Private ActiveRequest As BeaconAPI.Request
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAdvanceQueueCallbackKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWorking As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Queue() As BeaconAPI.Request
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Socket As URLConnection
	#tag EndProperty


	#tag Constant, Name = Notification_Unauthorized, Type = String, Dynamic = False, Default = \"Beacon API Unauthorized", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
