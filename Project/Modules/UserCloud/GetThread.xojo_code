#tag Class
Private Class GetThread
Inherits Thread
	#tag Event
		Sub Run()
		  If Self.mResponse.Success = False Or App.IdentityManager.CurrentIdentity Is Nil Then
		    // Do what?
		    CleanupRequest(Self.mRequest)
		    Return
		  End If
		  
		  Var URL As String = Self.mResponse.URL
		  Var BaseURL As String = BeaconAPI.URL("/files")
		  If Not URL.BeginsWith(BaseURL) Then
		    // What the hell is going on here?
		    CleanupRequest(Self.mRequest)
		    Return
		  End If
		  Var RemotePath As String = URL.Middle(BaseURL.Length)
		  
		  Var LocalFile As FolderItem = LocalFile(RemotePath)
		  Var Filename As String
		  If (LocalFile Is Nil) = False Then
		    Filename = LocalFile.Name
		  End If
		  
		  Var Content As MemoryBlock = Self.mResponse.Content
		  If BeaconEncryption.IsEncrypted(Content) Then
		    Try
		      Content = BeaconEncryption.SymmetricDecrypt(App.IdentityManager.CurrentIdentity.UserCloudKey, Content)
		    Catch Err As RuntimeException
		      // Ok?
		      CleanupRequest(Self.mRequest)
		      Return
		    End Try
		    
		    If Filename.EndsWith(Beacon.FileExtensionDelta) = False Then
		      Content = Beacon.Decompress(Content)
		    End If
		  End If
		  
		  If (LocalFile Is Nil) = False Then
		    Try
		      If LocalFile.Exists Then
		        #if Not TargetLinux
		          Var CreationDate As DateTime = LocalFile.CreationDateTime
		        #endif
		        Var ModificationDate As DateTime = LocalFile.ModificationDateTime
		        Var Stream As BinaryStream = BinaryStream.Open(LocalFile, True)
		        Stream.BytePosition = 0
		        Stream.Length = 0
		        Stream.Write(Content)
		        Stream.Close
		        #if Not TargetLinux
		          LocalFile.CreationDateTime = CreationDate
		        #endif
		        LocalFile.ModificationDateTime = ModificationDate
		      Else
		        Var Stream As BinaryStream = BinaryStream.Create(LocalFile, True)
		        Stream.Write(Content)
		        Stream.Close
		      End If
		    Catch Err As RuntimeException
		      App.Log("Unable to write to " + LocalFile.NativePath + ", Error " + Err.ErrorNumber.ToString + ": " + Err.Explanation)
		    End Try
		  End If
		  
		  CleanupRequest(Self.mRequest)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  Self.mRequest = Request
		  Self.mResponse = Response
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mRequest As BeaconAPI.Request
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mResponse As BeaconAPI.Response
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
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
		#tag ViewProperty
			Name="DebugIdentifier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ThreadID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ThreadState"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ThreadStates"
			EditorType="Enum"
			#tag EnumValues
				"0 - Running"
				"1 - Waiting"
				"2 - Paused"
				"3 - Sleeping"
				"4 - NotRunning"
			#tag EndEnumValues
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
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="Integer"
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
			Name="Priority"
			Visible=true
			Group="Behavior"
			InitialValue="5"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StackSize"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
