#tag Class
Protected Class LocalServerProfile
Inherits Ark.ServerProfile
	#tag Event
		Sub ReadFromDictionary(Dict As Dictionary)
		  If Dict.HasKey(Ark.ConfigFileGame) Then
		    Var File As BookmarkedFolderItem = BookmarkedFolderItem.FromSaveInfo(Dict.Value(Ark.ConfigFileGame).StringValue)
		    If File <> Nil Then
		      Self.mGameIniFile = File
		    End If
		  End If
		  If Dict.HasKey(Ark.ConfigFileGameUserSettings) Then
		    Var File As BookmarkedFolderItem = BookmarkedFolderItem.FromSaveInfo(Dict.Value(Ark.ConfigFileGameUserSettings).StringValue)
		    If File <> Nil Then
		      Self.mGameUserSettingsIniFile = File
		    End If
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub UpdateDetailsFrom(Profile As Beacon.ServerProfile)
		  If Not Profile IsA Ark.LocalServerProfile Then
		    Return
		  End If
		  
		  Var LocalProfile As Ark.LocalServerProfile = Ark.LocalServerProfile(Profile)
		  If LocalProfile.GameIniFile <> Nil Then
		    Self.GameIniFile = LocalProfile.GameIniFile
		  End If
		  If LocalProfile.GameUserSettingsIniFile <> Nil Then
		    Self.GameUserSettingsIniFile = LocalProfile.GameUserSettingsIniFile
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteToDictionary(Dict As Dictionary)
		  If Self.mGameIniFile <> Nil Then
		    Dict.Value(Ark.ConfigFileGame) = Self.mGameIniFile.SaveInfo
		  End If
		  If Self.mGameUserSettingsIniFile <> Nil Then
		    Dict.Value(Ark.ConfigFileGameUserSettings) = Self.mGameUserSettingsIniFile.SaveInfo
		  End If
		  Dict.Value("Provider") = "Local"
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  // Do not call Super.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DeployCapable() As Boolean
		  Return Self.mGameIniFile <> Nil And Self.mGameUserSettingsIniFile <> Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LinkPrefix() As String
		  Return "File"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SecondaryName() As String
		  If Self.mGameIniFile <> Nil And Self.mGameIniFile.Exists Then
		    Return Self.mGameIniFile.NativePath
		  End If
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mGameIniFile
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mGameIniFile <> Value Then
			    Self.mGameIniFile = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		GameIniFile As BookmarkedFolderItem
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mGameUserSettingsIniFile
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mGameUserSettingsIniFile <> Value Then
			    Self.mGameUserSettingsIniFile = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		GameUserSettingsIniFile As BookmarkedFolderItem
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mGameIniFile As BookmarkedFolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameUserSettingsIniFile As BookmarkedFolderItem
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Mask"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="UInt64"
			EditorType=""
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
			Name="AdminNotes"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="MessageDuration"
			Visible=false
			Group="Behavior"
			InitialValue=""
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
	#tag EndViewBehavior
End Class
#tag EndClass
