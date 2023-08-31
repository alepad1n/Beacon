#tag Class
Protected Class ServerProfile
	#tag Method, Flags = &h0
		Function Clone() As Beacon.ServerProfile
		  // The project is not necessary since SaveData will always be modern
		  Return Beacon.ServerProfile.FromSaveData(Self.SaveData(), Nil)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigSetStates() As Beacon.ConfigSetState()
		  Beacon.ConfigSetState.Cleanup(Self.mConfigSetStates)
		  Return Beacon.ConfigSetState.CloneArray(Self.mConfigSetStates)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ConfigSetStates(Assigns States() As Beacon.ConfigSetState)
		  // First decide if the States() array is different from the mConfigSetStates() array. Then, 
		  // update mConfigSetStates() to match. Do not need to clone the members since they are immutable.
		  
		  Beacon.ConfigSetState.Cleanup(States)
		  
		  If Beacon.ConfigSetState.AreArraysEqual(Self.mConfigSetStates, States) Then
		    Return
		  End If
		  
		  Self.mConfigSetStates = Beacon.ConfigSetState.CloneArray(States)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigSetStates(ForProject As Beacon.Project) As Beacon.ConfigSetState()
		  // Make sure to return a clone of the array. Do not need to clone the members since they are immutable.
		  Return Beacon.ConfigSetState.FilterStates(Self.ConfigSetStates, ForProject.ConfigSets)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  Var Err As New UnsupportedOperationException
		  Err.Message = "Do not instantiate this class, only its subclasses."
		  Raise Err
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Dict As Dictionary, Project As Beacon.Project = Nil)
		  // Optional project is needed to correctly restore legacy config set states
		  
		  If Not Dict.HasAllKeys("Name", "Profile ID", "Enabled") Then
		    Var Err As New KeyNotFoundException
		    Err.Message = "Incomplete server profile"
		    Raise Err
		  End If
		  
		  Self.Name = Dict.Value("Name")
		  Self.NickName = Dict.Lookup("Nickname", "")
		  Self.Enabled = Dict.Value("Enabled")
		  Self.mProfileID = Dict.Value("Profile ID")
		  Self.mPlatform = Dict.Lookup("Platform", Self.PlatformUnknown)
		  Self.mAdminNotes = Dict.Lookup("Admin Notes", "")
		  Self.mProfileColor = CType(Dict.Lookup("Color", 0).IntegerValue, Beacon.ServerProfile.Colors)
		  Self.mProviderServiceID = Dict.Lookup("Provider Service ID", Nil)
		  Self.mProviderTokenId = Dict.Lookup("Provider Token Id", "")
		  
		  If Dict.HasKey("External Account") Then
		    Self.mExternalAccountId = Dict.Value("External Account").StringValue
		  End If
		  
		  If Dict.HasKey("Config Set Priorities") Then
		    Self.mConfigSetStates = Beacon.ConfigSetState.DecodeArray(Dict.Value("Config Set Priorities"))
		  ElseIf Dict.HasKey("Config Sets") Then
		    Var States() As Dictionary
		    Try
		      States = Dict.Value("Config Sets").DictionaryArrayValue
		    Catch Err As RuntimeException
		    End Try
		    
		    Var Sets() As Beacon.ConfigSet
		    If (Project Is Nil) = False Then
		      Sets = Project.ConfigSets
		    End If
		    Var SetsMap As New Dictionary
		    For Each Set As Beacon.ConfigSet In Sets
		      SetsMap.Value(Set.Name) = Set
		    Next
		    
		    Self.mConfigSetStates.ResizeTo(-1)
		    For Each State As Dictionary In States
		      Try
		        Var SetName As String = State.Value("Name").StringValue
		        If SetsMap.HasKey(SetName) = False Then
		          Continue
		        End If
		        Var Set As Beacon.ConfigSet = SetsMap.Value(SetName)
		        Self.mConfigSetStates.Add(New Beacon.ConfigSetState(Set, State.Value("Enabled").BooleanValue))
		      Catch Err As RuntimeException
		      End Try
		    Next
		  End If
		  
		  RaiseEvent ReadFromDictionary(Dict)
		  
		  Self.Modified = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DefaultName() As String
		  Return "An Unnamed Server"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DeployCapable() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DisplayName() As String
		  Var Nickname As String = Self.Nickname
		  If Nickname.IsEmpty = False Then
		    Return Nickname
		  End If
		  
		  Return Self.Name
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(Dict As Dictionary, Project As Beacon.Project) As Beacon.ServerProfile
		  // This isn't a great design because the factory needs to know about all its subclasses, but
		  // there aren't better alternatives. Xojo's dead code stripping prevents a lookup from working.
		  
		  If Not Dict.HasAllKeys("Name", "Provider", "Profile ID") Then
		    Return Nil
		  End If
		  
		  Var Provider As String = Dict.Value("Provider")
		  Var GameId As String = Dict.Lookup("Game", Ark.Identifier)
		  Select Case GameId
		  Case Ark.Identifier
		    Select Case Provider
		    Case "Nitrado"
		      Return New Ark.NitradoServerProfile(Dict, Project)
		    Case "FTP"
		      Return New Ark.FTPServerProfile(Dict, Project)
		    Case "Local", "Simple"
		      Return New Ark.LocalServerProfile(Dict, Project)
		    Case "GameServerApp"
		      Return New Ark.GSAServerProfile(Dict, Project)
		    End Select
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hash() As String
		  Var Raw As String
		  Try
		    Raw = Beacon.GenerateJSON(Self.SaveData, False)
		  Catch Err As RuntimeException
		    Raw = Self.Name + "    " + Self.ProfileID
		  End Try
		  Return EncodeHex(Crypto.SHA2_256(Raw)).Lowercase
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LinkPrefix() As String
		  Return "Server"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.ServerProfile) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  // Use the external identifier as the primary means of comparison, if present
		  If IsNull(Self.mProviderServiceID) = False And Self.mProviderServiceID = Other.mProviderServiceID Then
		    Return 0
		  End If
		  
		  Var MyHash As String = Self.Hash
		  Var TheirHash As String = Other.Hash
		  
		  If MyHash = TheirHash Then
		    Return 0
		  Else
		    // Don't just compare names. We know these are not equal, but we need them to be sortable.
		    Var SelfCompare As String = Self.Name + "    " + MyHash
		    Var OtherCompare As String = Other.Name + "    " + TheirHash
		    Return SelfCompare.Compare(OtherCompare, ComparisonOptions.CaseInsensitive)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Platform() As Integer
		  Return Self.mPlatform
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Platform(Assigns Value As Integer)
		  If Self.mPlatform <> Value Then
		    Self.mPlatform = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProfileID() As String
		  If Self.mProfileID = "" Then
		    Self.mProfileID = Beacon.UUID.v4
		  End If
		  Return Self.mProfileID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var Dict As New Dictionary
		  RaiseEvent WriteToDictionary(Dict)
		  If Dict.HasAllKeys("Provider", "Game") = False Then
		    Var Err As New KeyNotFoundException
		    Err.Message = "No provider and/or game was set in ServerProfile.WriteToDictionary"
		    Raise Err
		  End If
		  Dict.Value("Name") = Self.Name
		  Dict.Value("Nickname") = Self.Nickname
		  Dict.Value("Profile ID") = Self.ProfileID // Do not call mProfileID here in order to force generation
		  Dict.Value("Enabled") = Self.Enabled
		  Dict.Value("Platform") = Self.mPlatform
		  Dict.Value("Admin Notes") = Self.mAdminNotes
		  Dict.Value("Color") = CType(Self.mProfileColor, Integer)
		  Dict.Value("Provider Token Id") = Self.mProviderTokenId
		  If Self.mExternalAccountId.IsEmpty = False Then
		    Dict.Value("External Account") = Self.mExternalAccountId
		  End If
		  If Self.mConfigSetStates.Count > 0 Then
		    Dict.Value("Config Set Priorities") = Beacon.ConfigSetState.EncodeArray(Self.mConfigSetStates)
		  End If
		  If IsNull(Self.mProviderServiceID) = False Then
		    Dict.Value("Provider Service ID") = Self.mProviderServiceID
		  End If
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SecondaryName() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsCustomStopMessage() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsRestart() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateDetailsFrom(Profile As Beacon.ServerProfile)
		  Self.ProviderTokenId = Profile.ProviderTokenId
		  RaiseEvent UpdateDetailsFrom(Profile)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ReadFromDictionary(Dict As Dictionary)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event UpdateDetailsFrom(Profile As Beacon.ServerProfile)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event WriteToDictionary(Dict As Dictionary)
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mAdminNotes
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Value.Encoding Is Nil Then
			    Value = Value.GuessEncoding
			  ElseIf Value.Encoding <> Encodings.UTF8 Then
			    Value = Value.ConvertEncoding(Encodings.UTF8)
			  End If
			  Value = Value.Trim
			  If Self.mAdminNotes.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
			    Self.mAdminNotes = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		AdminNotes As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Beacon.SanitizeFilename(Self.Name, 60)
			End Get
		#tag EndGetter
		BackupFolderName As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mEnabled
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mEnabled <> Value Then
			    Self.mEnabled = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		Enabled As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mExternalAccountId
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mExternalAccountId <> Value Then
			    Self.mExternalAccountId = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		ExternalAccountId As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mPlatform = Beacon.ServerProfile.PlatformXbox Or Self.mPlatform = Beacon.ServerProfile.PlatformPlayStation Or Self.mPlatform = Beacon.ServerProfile.PlatformSwitch
			End Get
		#tag EndGetter
		IsConsole As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mAdminNotes As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfigSetStates() As Beacon.ConfigSetState
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEnabled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mExternalAccountId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNickname As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Modified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPlatform As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProfileColor As Beacon.ServerProfile.Colors
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProfileID As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProviderServiceID As Variant
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProviderTokenId As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.mName.IsEmpty = False Then
			    Return Self.mName.Trim
			  ElseIf Self.SecondaryName.IsEmpty = False Then
			    Return Self.SecondaryName.Trim
			  Else
			    Return Self.DefaultName
			  End If
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Value = Value.Trim
			  
			  If Self.mName.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
			    Self.mName = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		Name As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mNickname.Trim
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Value = Value.Trim
			  
			  If Self.Nickname.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
			    Self.mNickname = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		Nickname As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mProfileColor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mProfileColor <> Value Then
			    Self.mProfileColor = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		ProfileColor As Beacon.ServerProfile.Colors
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mProviderServiceID
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mProviderServiceID <> Value Then
			    Self.mProviderServiceID = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		ProviderServiceID As Variant
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mProviderTokenId
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mProviderTokenId <> Value Then
			    Self.mProviderTokenId = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		ProviderTokenId As String
	#tag EndComputedProperty


	#tag Constant, Name = PlatformPC, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PlatformPlayStation, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PlatformSwitch, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PlatformUnknown, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PlatformXbox, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant


	#tag Enum, Name = Colors, Type = Integer, Flags = &h0
		None
		  Blue
		  Brown
		  Grey
		  Green
		  Indigo
		  Orange
		  Pink
		  Purple
		  Red
		  Teal
		Yellow
	#tag EndEnum


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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Modified"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsConsole"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BackupFolderName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AdminNotes"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ProfileColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Beacon.ServerProfile.Colors"
			EditorType="Enum"
			#tag EnumValues
				"0 - None"
				"1 - Blue"
				"2 - Brown"
				"3 - Grey"
				"4 - Green"
				"5 - Indigo"
				"6 - Orange"
				"7 - Pink"
				"8 - Purple"
				"9 - Red"
				"10 - Teal"
				"11 - Yellow"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Nickname"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ProviderTokenId"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
