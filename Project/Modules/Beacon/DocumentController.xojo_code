#tag Class
Protected Class DocumentController
	#tag Method, Flags = &h21
		Private Sub APICallback_DocumentDelete(Success As Boolean, Message As Text, Details As Auto, HTTPStatus As Integer, RawReply As Xojo.Core.MemoryBlock)
		  #Pragma Unused Details
		  #Pragma Unused HTTPStatus
		  #Pragma Unused RawReply
		  
		  If Success Then
		    RaiseEvent DeleteSuccess
		  Else
		    RaiseEvent DeleteError(Message)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_DocumentDownload(Success As Boolean, Message As Text, Details As Auto, HTTPStatus As Integer, RawReply As Xojo.Core.MemoryBlock)
		  // Reminder: this will happen on the main thread
		  #Pragma Unused Message
		  #Pragma Unused Details
		  #Pragma Unused HTTPStatus
		  
		  If Not Success Then
		    Self.mBusy = False
		    Return
		  End If
		  
		  Try
		    Self.mTextContent = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(RawReply)
		  Catch Err As RuntimeException
		    Self.mBusy = False
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_DocumentUpload(Success As Boolean, Message As Text, Details As Auto, HTTPStatus As Integer, RawReply As Xojo.Core.MemoryBlock)
		  #Pragma Unused Details
		  #Pragma Unused HTTPStatus
		  #Pragma Unused RawReply
		  
		  Self.mBusy = False
		  
		  If Success Then
		    If Self.mClearModifiedOnWrite Then
		      Self.mDocument.Modified = False
		    End If
		    RaiseEvent WriteSuccess
		  Else
		    RaiseEvent WriteError(Message)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Busy() As Boolean
		  Return Self.mBusy
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CanWrite() As Boolean
		  If Self.mDocumentURL.Scheme = Beacon.DocumentURL.TypeWeb Then
		    Return False
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckAPISocket()
		  If Self.mAPISocket <> Nil Then
		    Return
		  End If
		  
		  Self.mAPISocket = New BeaconAPI.Socket
		  AddHandler Self.mAPISocket.WorkProgress, WeakAddressOf Self.mAPISocket_WorkProgress
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckSocket()
		  If Self.mSocket <> Nil Then
		    Return
		  End If
		  
		  Self.mSocket = New Xojo.Net.HTTPSocket
		  AddHandler Self.mSocket.Error, WeakAddressOf Self.mSocket_Error
		  AddHandler Self.mSocket.PageReceived, WeakAddressOf Self.mSocket_PageReceived
		  AddHandler Self.mSocket.ReceiveProgress, WeakAddressOf Self.mSocket_ReceiveProgress
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.Constructor(Beacon.DocumentURL.TypeTransient + "://" + Beacon.CreateUUID)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Document As Beacon.Document)
		  Self.mDocumentURL = Beacon.DocumentURL.TypeTransient + "://" + Document.DocumentID + "?name=" + Beacon.EncodeURLComponent(Document.Title)
		  Self.mLoaded = True
		  Self.mDocument = Document
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(URL As Beacon.DocumentURL)
		  Self.mDocumentURL = URL
		  
		  Self.mLoadThread = New Beacon.Thread
		  AddHandler Self.mLoadThread.Run, WeakAddressOf Self.mLoadThread_Run
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Delete()
		  If Not Self.CanWrite Then
		    RaiseEvent DeleteError("Document is not writable")
		    Return
		  End If
		  
		  Select Case Self.mDocumentURL.Scheme
		  Case Beacon.DocumentURL.TypeCloud
		    Dim Request As New BeaconAPI.Request(Self.mDocumentURL.WithScheme("https"), "DELETE", AddressOf APICallback_DocumentDelete)
		    Request.Sign(App.Identity)
		    Self.CheckAPISocket()
		    Self.mAPISocket.Start(Request)
		  Case Beacon.DocumentURL.TypeLocal
		    Try
		      Dim File As New Beacon.FolderItem(Self.mDocumentURL.Path)
		      If File.Exists Then
		        File.Delete  
		      End If
		      RaiseEvent DeleteSuccess
		    Catch Err As RuntimeException
		      RaiseEvent DeleteError(Err.Explanation)
		    End Try
		  Case Beacon.DocumentURL.TypeTransient
		    Dim Path As Text = Self.mDocumentURL.URL.Mid(Beacon.DocumentURL.TypeTransient.Length + 3)
		    Try
		      Dim File As Beacon.FolderItem = Beacon.FolderItem.Temporary.Child(Path + BeaconFileTypes.BeaconDocument.PrimaryExtension.ToText)
		      If File.Exists Then
		        File.Delete
		      End If
		      RaiseEvent DeleteSuccess
		    Catch Err As RuntimeException
		      RaiseEvent DeleteError(Err.Explanation)
		    End Try
		  Else
		    RaiseEvent DeleteError("Unknown storage scheme " + Self.mDocumentURL.Scheme)
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  Xojo.Core.Timer.CancelCall(WeakAddressOf TriggerLoadStarted)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Document() As Beacon.Document
		  Return Self.mDocument
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Document(Assigns Replacement As Beacon.Document)
		  Self.mDocument = Replacement
		  Self.mLoaded = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Load(WithIdentity As Beacon.Identity)
		  If Self.Loaded Then
		    RaiseEvent Loaded(Self.mDocument)
		    Return
		  End If
		  
		  If Self.mBusy Then
		    Return
		  End If
		  
		  Self.mBusy = True
		  Self.mIdentity = WithIdentity
		  Self.mLoadThread.Run
		  
		  Xojo.Core.Timer.CallLater(1500, WeakAddressOf TriggerLoadStarted)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Loaded() As Boolean
		  Return Self.mLoaded
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mAPISocket_WorkProgress(Sender As BeaconAPI.Socket, Request As BeaconAPI.Request, BytesReceived As Int64, BytesTotal As Int64)
		  #Pragma Unused Sender
		  #Pragma Unused Request
		  
		  RaiseEvent LoadProgress(BytesReceived, BytesTotal)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mLoadThread_Run(Sender As Thread)
		  Select Case Self.mDocumentURL.Scheme
		  Case Beacon.DocumentURL.TypeCloud
		    // authenticated api request
		    Self.CheckAPISocket()
		    
		    Dim Request As New BeaconAPI.Request(Self.mDocumentURL.WithScheme("https"), "GET", AddressOf APICallback_DocumentDownload)
		    Request.Sign(Self.mIdentity)
		    Self.mAPISocket.Start(Request)
		  Case Beacon.DocumentURL.TypeWeb
		    // basic https request
		    Self.CheckSocket()
		    
		    Self.mSocket.Send("GET", Self.mDocumentURL.URL)
		  Case Beacon.DocumentURL.TypeLocal
		    // just a local file
		    Dim Success As Boolean
		    Try
		      Dim File As Beacon.FolderItem
		      If Self.mDocumentURL.HasParam("saveinfo") Then
		        File = Beacon.FolderItem.FromSaveInfo(Self.mDocumentURL.Param("saveinfo"))
		      Else
		        File = New Beacon.FolderItem(Self.mDocumentURL.Path)
		      End If
		      If File <> Nil And File.Exists Then
		        Self.mTextContent = File.Read(Xojo.Core.TextEncoding.UTF8)
		        Self.mFileRef = File // Just to keep the security scoped bookmark open
		        Success = True
		      End If
		    Catch Err As RuntimeException
		      
		    End Try
		    
		    If Not Success Then
		      Self.mBusy = False
		      Xojo.Core.Timer.CallLater(1, AddressOf TriggerLoadError)
		      Return
		    End If
		  Case Beacon.DocumentURL.TypeTransient
		    // just a local file stored in the the temp directory
		    Dim File As Beacon.FolderItem = Beacon.FolderItem.Temporary.Child(Self.mDocumentURL.Path + BeaconFileTypes.BeaconDocument.PrimaryExtension.ToText)
		    If File.Exists Then
		      Self.mTextContent = File.Read(Xojo.Core.TextEncoding.UTF8)
		    Else
		      Dim Temp As New Beacon.Document
		      Self.mTextContent = Xojo.Data.GenerateJSON(Temp.ToDictionary(Self.mIdentity))
		    End If
		  Else
		    Self.mBusy = False
		    Return
		  End Select
		  
		  // Wait for the loading to finish or error
		  While Self.mTextContent = "" And Self.mBusy
		    Sender.Sleep(50)
		  Wend
		  
		  Dim TextContent As Text = Self.mTextContent
		  Self.mTextContent = ""
		  
		  If Not Self.mBusy Then
		    Xojo.Core.Timer.CallLater(1, AddressOf TriggerLoadError)
		    Return
		  End If
		  Self.mBusy = False
		  
		  Dim Document As Beacon.Document = Beacon.Document.FromText(TextContent, Self.mIdentity)
		  If Document = Nil Then
		    Xojo.Core.Timer.CallLater(1, AddressOf TriggerLoadError)
		    Return
		  End If
		  
		  If Document.Title.Trim = "" Then
		    Document.Title = Self.Name
		  End If
		  If Self.mClearPublishStatus Then
		    Document.IsPublic = False
		  End If
		  
		  Self.mDocument = Document
		  Self.mLoaded = True
		  Xojo.Core.Timer.CallLater(1, AddressOf TriggerLoadSuccess)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSocket_Error(Sender As Xojo.Net.HTTPSocket, Err As RuntimeException)
		  #Pragma Unused Sender
		  #Pragma Unused Err
		  
		  Self.mBusy = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSocket_PageReceived(Sender As Xojo.Net.HTTPSocket, URL As Text, HTTPStatus As Integer, Content As Xojo.Core.MemoryBlock)
		  #Pragma Unused Sender
		  #Pragma Unused URL
		  
		  If HTTPStatus < 200 Or HTTPStatus >= 300 Then
		    Self.mBusy = False
		    Return
		  End If
		  
		  Try
		    Self.mTextContent = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Content)
		    Self.mClearPublishStatus = True
		  Catch Err As RuntimeException
		    Self.mBusy = False
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSocket_ReceiveProgress(Sender As Xojo.Net.HTTPSocket, BytesReceived As Int64, TotalBytes As Int64, NewData As Xojo.Core.MemoryBlock)
		  #Pragma Unused Sender
		  #Pragma Unused NewData
		  
		  RaiseEvent LoadProgress(BytesReceived, TotalBytes)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As Text
		  If Self.mDocument <> Nil Then
		    Return Self.mDocument.Title
		  Else
		    Return Self.mDocumentURL.Name
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Save(WithIdentity As Beacon.Identity)
		  If Self.mBusy Or Self.Loaded = False Then
		    Return
		  End If
		  
		  If Self.mDocument.Title <> "" Then
		    Self.mDocumentURL.Name = Self.mDocument.Title
		  End If
		  Self.WriteTo(Self.mDocumentURL, WithIdentity, True)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveACopy(Destination As Beacon.DocumentURL, WithIdentity As Beacon.Identity) As Beacon.DocumentController
		  // Like Save As, but the destination is not saved
		  If Self.Loaded = False Then
		    Return Nil
		  End If
		  
		  Dim Controller As New Beacon.DocumentController(Self.mDocument)
		  Controller.mDocumentURL = Destination
		  If Self.mDocument.Title <> "" Then
		    Destination.Name = Self.mDocument.Title
		  End If
		  Controller.WriteTo(Destination, WithIdentity, False)
		  Return Controller
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SaveAs(Destination As Beacon.DocumentURL, WithIdentity As Beacon.Identity)
		  If Self.mBusy Or Self.Loaded = False Then
		    Return
		  End If
		  
		  Self.mDocumentURL = Destination
		  Self.Save(WithIdentity)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TriggerLoadError()
		  Xojo.Core.Timer.CancelCall(WeakAddressOf TriggerLoadStarted)
		  
		  RaiseEvent LoadError()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TriggerLoadStarted()
		  RaiseEvent LoadStarted()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TriggerLoadSuccess()
		  Xojo.Core.Timer.CancelCall(WeakAddressOf TriggerLoadStarted)
		  
		  RaiseEvent Loaded(Self.mDocument)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UploadThread_Run(Sender As Beacon.Thread)
		  Self.CheckAPISocket()
		  
		  Sender.LockUserData()
		  Dim WithIdentity As Beacon.Identity = Sender.UserData
		  
		  Dim Body As Text = Xojo.Data.GenerateJSON(Self.mDocument.ToDictionary(WithIdentity))
		  Dim Request As New BeaconAPI.Request(Self.mDocumentURL.WithScheme("https"), "POST", Body, "application/json", AddressOf APICallback_DocumentUpload)
		  Request.Sign(WithIdentity)
		  Sender.UnlockUserData()
		  
		  Self.mAPISocket.Start(Request)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function URL() As DocumentURL
		  Return Self.mDocumentURL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Writer_Finished(Sender As Beacon.JSONWriter, Destination As Beacon.FolderItem)
		  Self.mBusy = False
		  
		  If Sender.Success Then
		    If Self.mClearModifiedOnWrite And Self.mDocument <> Nil Then
		      Self.mDocument.Modified = False
		    End If
		    
		    // Update the document url to regenerate saveinfo/bookmarks
		    Self.mDocumentURL = Beacon.DocumentURL.URLForFile(Destination)
		    
		    RaiseEvent WriteSuccess()
		  Else
		    Dim Reason As Text
		    Dim Err As RuntimeException = Sender.Error
		    If Err <> Nil Then
		      If Err.Reason <> "" Then
		        Reason = Err.Reason
		      ElseIf Err.Message <> "" Then
		        Reason = Err.Message.ToText
		      Else
		        Dim Info As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Err)
		        Reason = Info.Name + " from JSONWriter"
		      End If
		    Else
		      Reason = "Unknown JSONWriter error"
		    End If
		    RaiseEvent WriteError(Reason)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub WriteTo(Destination As Beacon.DocumentURL, WithIdentity As Beacon.Identity, ClearModified As Boolean)
		  If Self.mBusy Or Self.Loaded = False Or Destination.Scheme = Beacon.DocumentURL.TypeWeb Then
		    Return
		  End If
		  
		  Self.mBusy = True
		  Self.mClearModifiedOnWrite = ClearModified
		  
		  Select Case Destination.Scheme
		  Case Beacon.DocumentURL.TypeCloud
		    Dim UploadThread As New Beacon.Thread
		    UploadThread.Priority = Beacon.Thread.PriorityLow
		    UploadThread.UserData = WithIdentity
		    AddHandler UploadThread.Run, AddressOf UploadThread_Run
		    UploadThread.Run
		  Case Beacon.DocumentURL.TypeLocal
		    Dim Writer As New Beacon.JSONWriter(Self.mDocument, WithIdentity, New Beacon.FolderItem(Destination.Path))
		    AddHandler Writer.Finished, AddressOf Writer_Finished
		    Writer.Run
		  End Select
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event DeleteError(Reason As Text)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DeleteSuccess()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Loaded(Document As Beacon.Document)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event LoadError()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event LoadProgress(BytesReceived As Int64, BytesTotal As Int64)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event LoadStarted()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event WriteError(Reason As Text)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event WriteSuccess()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mAPISocket As BeaconAPI.Socket
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBusy As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mClearModifiedOnWrite As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mClearPublishStatus As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDocument As Beacon.Document
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDocumentURL As Beacon.DocumentURL
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFileRef As Beacon.FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIdentity As Beacon.Identity
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLoaded As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLoadThread As Beacon.Thread
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSocket As Xojo.Net.HTTPSocket
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTextContent As Text
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
