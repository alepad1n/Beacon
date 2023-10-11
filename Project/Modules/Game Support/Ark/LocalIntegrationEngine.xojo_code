#tag Class
Protected Class LocalIntegrationEngine
Inherits Ark.IntegrationEngine
	#tag CompatibilityFlags = (TargetDesktop and (Target32Bit))
	#tag Event
		Sub DownloadFile(Transfer As Beacon.IntegrationTransfer, FailureMode As DownloadFailureMode, Profile As Beacon.ServerProfile)
		  #Pragma Unused FailureMode
		  #Pragma Unused Profile
		  
		  Var File As FolderItem
		  Select Case Transfer.Filename
		  Case Ark.ConfigFileGame
		    File = Self.Profile.GameIniFile
		  Case Ark.ConfigFileGameUserSettings
		    File = Self.Profile.GameUserSettingsIniFile
		  Else
		    Transfer.SetError("Unknown file " + Transfer.Filename)
		    Return
		  End Select
		  
		  If (File Is Nil) = False And File.Exists Then
		    Try
		      Transfer.Content = File.Read
		      Transfer.Success = True
		    Catch Err As RuntimeException
		      Transfer.SetError(Err.Message)
		    End Try
		  Else
		    Transfer.SetError("File " + Transfer.Filename + " does not exist.")
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub UploadFile(Transfer As Beacon.IntegrationTransfer)
		  Var File As FolderItem
		  Select Case Transfer.Filename
		  Case Ark.ConfigFileGame
		    File = Self.Profile.GameIniFile
		  Case Ark.ConfigFileGameUserSettings
		    File = Self.Profile.GameUserSettingsIniFile
		  Else
		    Transfer.SetError("Unknown file " + Transfer.Filename)
		    Return
		  End Select
		  
		  If File Is Nil Then
		    Transfer.SetError("Destination is invalid")
		    Return
		  End If
		  
		  Try
		    If File.Write(Transfer.Content) = False Then
		      Transfer.SetError("Could not write to " + File.NativePath)
		      Return
		    End If
		    
		    Transfer.Success = True
		  Catch Err As RuntimeException
		    Transfer.SetError(Err.Message)
		  End Try
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor(Profile As Beacon.ServerProfile)
		  // Simply changing the scope of the constructor
		  Super.Constructor(Nil, Profile)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Profile() As Ark.LocalServerProfile
		  Return Ark.LocalServerProfile(Super.Profile)
		End Function
	#tag EndMethod


	#tag ViewBehavior
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
			InitialValue="-2147483648"
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
	#tag EndViewBehavior
End Class
#tag EndClass
