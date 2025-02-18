#tag Module
Protected Module Preferences
	#tag Method, Flags = &h1
		Protected Sub AddToRecentDocuments(URL As Beacon.ProjectURL)
		  If URL.Type = Beacon.ProjectURL.TypeTransient Then
		    Return
		  End If
		  
		  Var Recents() As Beacon.ProjectURL = RecentDocuments
		  For I As Integer = Recents.LastIndex DownTo 0
		    If Recents(I) = URL Then
		      Recents.RemoveAt(I)
		    End If
		  Next
		  Recents.AddAt(0, URL)
		  
		  While Recents.LastIndex > 19
		    Recents.RemoveAt(20)
		  Wend
		  
		  RecentDocuments = Recents
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub EncryptPrivateKey()
		  mManager.StringValue("Device Public Key") = EncodeBase64(DecodeHex(mDevicePublicKey), 0)
		  mManager.StringValue("Device Private Key") = BeaconEncryption.SlowEncrypt("2f5dda1e-458c-4945-82cd-884f59c12f9b" + " " + Beacon.SystemAccountName + " " + Beacon.HardwareId, DecodeHex(mDevicePrivateKey))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function HiddenTags() As String()
		  Init
		  Return mManager.StringValue("Hidden Tags", "").Split(",")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub HiddenTags(Assigns Value() As String)
		  Init
		  mManager.StringValue("Hidden Tags") = String.FromArray(Value, ",")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Init()
		  If (mManager Is Nil) = False Then
		    Return
		  End If
		  
		  mManager = New PreferencesManager(App.ApplicationSupport.Child("Preferences.json"))
		  mManager.ClearValue("Last Used Config")
		  
		  // Cleanup project states
		  Var Dict As Dictionary = mManager.DictionaryValue("Project State", New Dictionary)
		  Var Timestamps() As Double
		  Var Map As New Dictionary
		  For Each Entry As DictionaryEntry In Dict
		    Try
		      Var ProjectId As String = Entry.Key.StringValue
		      Var State As Dictionary = Entry.Value
		      Var Timestamp as Double = State.Value("Timestamp").DoubleValue
		      
		      Timestamps.Add(Timestamp)
		      Map.Value(Timestamp) = ProjectId
		    Catch Err As RuntimeException
		    End Try
		  Next Entry
		  
		  Var Changed As Boolean
		  Timestamps.Sort
		  Var Cutoff As DateTime = DateTime.Now - New DateInterval(0, 6)
		  Var CutoffSeconds As Double = Cutoff.SecondsFrom1970
		  For Idx As Integer = Timestamps.LastIndex DownTo Timestamps.FirstIndex
		    If Timestamps(Idx) < CutoffSeconds Then
		      Timestamps.RemoveAt(Idx)
		      Changed = True
		    End If
		  Next Idx
		  While Timestamps.Count > 20
		    Timestamps.RemoveAt(Timestamps.LastIndex)
		    Changed = True
		  Wend
		  
		  If Changed Then
		    Var Replacement As New Dictionary
		    For Each Timestamp As Double In Timestamps
		      Var ProjectId As String = Map.Value(Timestamp)
		      Replacement.Value(ProjectId) = Dict.Value(ProjectId)
		    Next Timestamp
		    mManager.DictionaryValue("Project State") = Replacement
		  End If
		  
		  If mManager.StringValue("Device Private Key").IsEmpty = False Then
		    Try
		      Var PrivateKey As String = EncodeHex(BeaconEncryption.SlowDecrypt("2f5dda1e-458c-4945-82cd-884f59c12f9b" + " " + Beacon.SystemAccountName + " " + Beacon.HardwareId, mManager.StringValue("Device Private Key")))
		      Var PublicKey As String = EncodeHex(DecodeBase64(mManager.StringValue("Device Public Key", "")))
		      If Crypto.RSAVerifyKey(PublicKey) And Crypto.RSAVerifyKey(PrivateKey) Then
		        mDevicePublicKey = PublicKey
		        mDevicePrivateKey = PrivateKey
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If mDevicePrivateKey.IsEmpty Then
		    Var PublicKey, PrivateKey As String
		    Call Crypto.RSAGenerateKeyPair(4096, PrivateKey, PublicKey)
		    mDevicePublicKey = PublicKey
		    mDevicePrivateKey = PrivateKey
		    EncryptPrivateKey()
		  End If
		  
		  Var NewestUsedBuild As Integer = NewestUsedBuild
		  If NewestUsedBuild < 10604000 And NewestUsedBuild > 0 Then
		    HardwareIdVersion = 4
		  End If
		  
		  Var DefaultGameId As String = NewProjectGameId
		  If DefaultGameID.IsEmpty = False Then
		    Var Found As Boolean
		    Var Games() As Beacon.Game = Beacon.Games
		    For Each Game As Beacon.Game In Games
		      If Game.Identifier = DefaultGameId Then
		        Found = True
		        Exit
		      End If
		    Next
		    If Not Found Then
		      NewProjectGameId = ""
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Sub ListSortColumn(Key As String, Assigns Idx As Integer)
		  Init
		  mManager.IntegerValue(Key + " Sort Column") = Idx
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Function ListSortColumn(Key As String, Default As Integer) As Integer
		  Init
		  Return mManager.IntegerValue(Key + " Sort Column", Default)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Sub ListSortDirection(Key As String, Assigns Direction As DesktopListBox.SortDirections)
		  Init
		  mManager.IntegerValue(Key + " Sort Direction") = CType(Direction, Integer)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Function ListSortDirection(Key As String, Default As DesktopListBox.SortDirections) As DesktopListbox.SortDirections
		  Init
		  Return CType(mManager.IntegerValue(Key + " Sort Direction", CType(Default, Integer)), DesktopListbox.SortDirections)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Sub LoadWindowPosition(Extends Win As DesktopWindow)
		  Var Info As Introspection.TypeInfo = Introspection.GetType(Win)
		  
		  Init
		  
		  Var Bounds As Rect = mManager.RectValue(Info.Name + " Position")
		  If Bounds <> Nil Then
		    // Find the best screen
		    Var IdealScreen As DesktopDisplay = DesktopDisplay.DisplayAt(0)
		    Var Bound As Integer = DesktopDisplay.DisplayCount - 1
		    If Bound > 0 Then
		      Var MaxArea As Integer
		      For I As Integer = 0 To Bound
		        Var Display As DesktopDisplay = DesktopDisplay.DisplayAt(I)
		        Var ScreenBounds As New Rect(Display.AvailableLeft, Display.AvailableTop, Display.AvailableWidth, Display.AvailableHeight)
		        Var Intersection As Rect = ScreenBounds.Intersection(Bounds)
		        If Intersection = Nil Then
		          Continue
		        End If
		        Var Area As Integer = Intersection.Width * Intersection.Height
		        If Area <= 0 Then
		          Continue
		        End If
		        If Area > MaxArea Then
		          MaxArea = Area
		          IdealScreen = Display
		        End If
		      Next
		    End If
		    
		    Var AvailableBounds As New Rect(IdealScreen.AvailableLeft, IdealScreen.AvailableTop, IdealScreen.AvailableWidth, IdealScreen.AvailableHeight)
		    
		    Var Width As Integer = Min(Max(Bounds.Width, Win.MinimumWidth), Win.MaximumWidth, AvailableBounds.Width)
		    Var Height As Integer = Min(Max(Bounds.Height, Win.MinimumHeight), Win.MaximumHeight, AvailableBounds.Height)
		    Var Left As Integer = Min(Max(Bounds.Left, AvailableBounds.Left), AvailableBounds.Right - Width)
		    Var Top As Integer = Min(Max(Bounds.Top, AvailableBounds.Top), AvailableBounds.Bottom - Height)
		    Win.Bounds = New Rect(Left, Top, Width, Height)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function NewDeploySettings() As Beacon.DeploySettings
		  Var Settings As New Beacon.DeploySettings
		  If Preferences.DeployCreateBackup Then
		    Settings.Options = Settings.Options Or CType(Beacon.DeploySettings.OptionBackup, UInt64)
		  End If
		  If Preferences.DeployReviewChanges Then
		    Settings.Options = Settings.Options Or CType(Beacon.DeploySettings.OptionReview, UInt64)
		  End If
		  If Preferences.DeployRunAdvisor Then
		    Settings.Options = Settings.Options Or CType(Beacon.DeploySettings.OptionAdvise, UInt64)
		  End If
		  Return Settings
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ProjectState(ProjectUUID As String, Key As String, Assigns Value As Variant)
		  Var Dict As Dictionary = mManager.DictionaryValue("Project State", New Dictionary)
		  Var State As Dictionary
		  If Dict.HasKey(ProjectUUID) Then
		    State = Dict.Value(ProjectUUID)
		  Else
		    State = New Dictionary
		  End If
		  
		  State.Value("Timestamp") = DateTime.Now.SecondsFrom1970
		  State.Value(Key) = Value
		  Dict.Value(ProjectUUID) = State
		  mManager.DictionaryValue("Project State") = Dict
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ProjectState(ProjectUUID As String, Key As String, Default As Variant) As Variant
		  Var Dict As Dictionary = mManager.DictionaryValue("Project State", New Dictionary)
		  Var State As Dictionary
		  If Dict.HasKey(ProjectUUID) Then
		    State = Dict.Value(ProjectUUID)
		  Else
		    State = New Dictionary
		  End If
		  
		  If State.HasKey(Key) Then
		    Return State.Value(Key)
		  Else
		    Return Default
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function RecentDocuments() As Beacon.ProjectURL()
		  Init
		  
		  // When used with a freshly parsed file, the return type will be Auto()
		  // Once the array is updated, the local copy will return Text()
		  
		  Var Temp As Variant = mManager.VariantValue("Documents")
		  Var Values() As Beacon.ProjectURL
		  If (Temp Is Nil) = False Then
		    If Temp.IsArray Then
		      Select Case Temp.ArrayElementType
		      Case Variant.TypeString
		        Try
		          Var StringValues() As String = Temp
		          For Each StringValue As String In StringValues
		            Values.Add(New Beacon.ProjectUrl(StringValue))
		          Next
		        Catch Err As RuntimeException
		        End Try
		      Case Variant.TypeObject
		        Try
		          Var Members() As Variant = Temp
		          For Each Member As Variant In Members
		            If Member.Type = Variant.TypeString Then
		              Values.Add(New Beacon.ProjectUrl(Member.StringValue))
		            ElseIf Member.Type = Variant.TypeObject And Member.ObjectValue IsA Dictionary Then
		              Values.Add(New Beacon.ProjectUrl(Dictionary(Member.ObjectValue)))
		            End If
		          Next
		        Catch Err As RuntimeException
		        End Try
		      End Select
		    Else
		      Try
		        Values.Add(New Beacon.ProjectUrl(Temp.StringValue))
		      Catch Err As RuntimeException
		      End Try
		    End If
		  End If
		  Return Values
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RecentDocuments(Assigns Values() As Beacon.ProjectURL)
		  Var Urls() As Variant
		  Urls.ResizeTo(Values.LastIndex)
		  For Idx As Integer = 0 To Values.LastIndex
		    URLs(Idx) = Values(Idx).DictionaryValue
		  Next
		  
		  Init
		  mManager.VariantValue("Documents") = URLs
		  NotificationKit.Post(Notification_RecentsChanged, Values)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ReleaseConnection()
		  If Thread.Current Is Nil Or mConnectionLock Is Nil Then
		    Return
		  End If
		  
		  mConnectionLockCount = mConnectionLockCount
		  mConnectionLock.Release
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Sub SaveWindowPosition(Extends Win As DesktopWindow)
		  Var Info As Introspection.TypeInfo = Introspection.GetType(Win)
		  
		  Init
		  mManager.RectValue(Info.Name + " Position") = Win.Bounds
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SelectedTag(Category As String, Subgroup As String) As String
		  Var Key As String = "Selected " + Category.TitleCase
		  If Subgroup <> "" Then
		    Key = Key + "." + Subgroup.TitleCase
		  End If
		  Key = Key + " Tags"
		  
		  Var Default As String
		  
		  Select Case Category
		  Case Ark.CategoryEngrams
		    Select Case Subgroup
		    Case "Harvesting"
		      Default = "{""required"":[""harvestable""],""excluded"":[""deprecated"",""cheat""]}"
		    Case "Crafting"
		      Default = "{""required"":[],""excluded"":[""deprecated"",""cheat""]}"
		    Case "Resources"
		      Default = "{""required"":[""resource""],""excluded"":[""deprecated"",""cheat""]}"
		    Else
		      Default = "{""required"":[],""excluded"":[""deprecated"",""cheat"",""event"",""reward"",""generic"",""blueprint""]}"
		    End Select
		  Case Ark.CategoryCreatures
		    Default = "{""required"":[],""excluded"":[""minion"",""boss"",""event"",""generic""]}"
		  End Select
		  
		  Init
		  Return mManager.StringValue(Key, Default)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SelectedTag(Category As String, Subgroup As String, Assigns Value As String)
		  Var Key As String = "Selected " + Category.TitleCase
		  If Subgroup <> "" Then
		    Key = Key + "." + Subgroup.TitleCase
		  End If
		  Key = Key + " Tags"
		  
		  mManager.StringValue(Key) = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SignalConnection() As Boolean
		  If Thread.Current Is Nil Then
		    Return False
		  End If
		  
		  If mConnectionLock Is Nil Then
		    mConnectionLock = New Semaphore(MaxConnections)
		  End If
		  
		  mConnectionLock.Signal
		  mConnectionLockCount = mConnectionLockCount + 1
		  
		  Return True
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.DictionaryValue("Ark Loot Item Set Entry Defaults", Nil)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.DictionaryValue("Ark Loot Item Set Entry Defaults") = Value
			End Set
		#tag EndSetter
		Protected ArkLootItemSetEntryDefaults As Dictionary
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.DictionaryValue("ArkSA Loot Item Set Entry Defaults", Nil)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.DictionaryValue("ArkSA Loot Item Set Entry Defaults") = Value
			End Set
		#tag EndSetter
		Protected ArkSALootItemSetEntryDefaults As Dictionary
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		#tag Getter
			Get
			  Init
			  Return mManager.IntegerValue("ArkSA Spawn Point Editor Limits Splitter Position", ArkSpawnPointEditor.LimitsListDefaultHeight)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.IntegerValue("ArkSA Spawn Point Editor Limits Splitter Position") = Value
			End Set
		#tag EndSetter
		Protected ArkSASpawnPointEditorLimitsSplitterPosition As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		#tag Getter
			Get
			  Init
			  Return mManager.IntegerValue("ArkSA Spawn Point Editor Sets Splitter Position", ArkSpawnPointEditor.SetsListDefaultWidth)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.IntegerValue("ArkSA Spawn Point Editor Sets Splitter Position") = Value
			End Set
		#tag EndSetter
		Protected ArkSASpawnPointEditorSetsSplitterPosition As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Var Default As String
			  #if TargetWindows
			    Default = "C:\Program Files (x86)\Steam\steamapps\common\ARK"
			  #elseif TargetLinux
			    Default = SpecialFolder.UserHome + "/.steam/steam/steamapps/common/ARK"
			  #elseif TargetMacOS
			    // This is pointless, but whatever
			    Default = SpecialFolder.ApplicationData.NativePath + "/Steam/SteamApps/common/ARK"
			  #endif
			  Return mManager.StringValue("ArkSA Steam Path", Default)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If ArkSteamPath = Value Then
			    Return
			  End If
			  
			  mManager.StringValue("ArkSA Steam Path") = Value
			End Set
		#tag EndSetter
		Protected ArkSASteamPath As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		#tag Getter
			Get
			  Init
			  Return mManager.IntegerValue("Spawn Point Editor Limits Splitter Position", ArkSpawnPointEditor.LimitsListDefaultHeight)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.IntegerValue("Spawn Point Editor Limits Splitter Position") = Value
			End Set
		#tag EndSetter
		Protected ArkSpawnPointEditorLimitsSplitterPosition As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		#tag Getter
			Get
			  Init
			  Return mManager.IntegerValue("Spawn Point Editor Sets Splitter Position", ArkSpawnPointEditor.SetsListDefaultWidth)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.IntegerValue("Spawn Point Editor Sets Splitter Position") = Value
			End Set
		#tag EndSetter
		Protected ArkSpawnPointEditorSetsSplitterPosition As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Var Default As String
			  #if TargetWindows
			    Default = "C:\Program Files (x86)\Steam\steamapps\common\ARK"
			  #elseif TargetLinux
			    Default = SpecialFolder.UserHome + "/.steam/steam/steamapps/common/ARK"
			  #elseif TargetMacOS
			    // This is pointless, but whatever
			    Default = SpecialFolder.ApplicationData.NativePath + "/Steam/SteamApps/common/ARK"
			  #endif
			  Return mManager.StringValue("Ark Steam Path", Default)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If ArkSteamPath = Value Then
			    Return
			  End If
			  
			  mManager.StringValue("Ark Steam Path") = Value
			End Set
		#tag EndSetter
		Protected ArkSteamPath As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.BooleanValue("Automatically Downloads Updates", True)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.BooleanValue("Automatically Downloads Updates") = Value
			  UpdatesKit.RefreshSettings()
			End Set
		#tag EndSetter
		Protected AutomaticallyDownloadsUpdates As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  
			  If mAuthToken Is Nil Then
			    Var AccountName As String = Beacon.SystemAccountName
			    Var HardwareId As String = Beacon.HardwareId
			    Var TokenSource As String
			    Try
			      Var TokenEncrypted As String = mManager.StringValue("Beacon Auth")
			      TokenSource = BeaconEncryption.SlowDecrypt("cae5a061-1700-4ec4-8eee-d2f7c17a34e5 " + AccountName + " " + HardwareId, TokenEncrypted)
			    Catch Err As RuntimeException
			      App.Log("Failed to decrypt token using account name `" + AccountName + "` and hardware id `" + HardwareId + "`: `" + Err.Message + "`.")
			      Return Nil
			    End Try
			    
			    Try
			      mAuthToken = BeaconAPI.OAuthToken.Load(TokenSource)
			    Catch Err As RuntimeException
			      App.Log("OAuth token was decrypted, but could not be loaded.")
			      Return Nil
			    End Try
			  End If
			  
			  Return mAuthToken
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  
			  Try
			    If (Value Is Nil) = False Then
			      Var TokenSource As String = Value.StringValue
			      mManager.StringValue("Beacon Auth") = BeaconEncryption.SlowEncrypt("cae5a061-1700-4ec4-8eee-d2f7c17a34e5 " + Beacon.SystemAccountName + " " + Beacon.HardwareId, TokenSource)
			    Else
			      mManager.StringValue("Beacon Auth") = ""
			    End If
			    mAuthToken = Value
			  Catch Err As RuntimeException
			    App.Log(Err, CurrentMethodName, "Saving new auth token")
			  End Try
			End Set
		#tag EndSetter
		Protected BeaconAuth As BeaconAPI.OAuthToken
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.StringValue("Breeding Tuner Creatures", "*")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If BreedingTunerCreatures = Value Then
			    Return
			  End If
			  
			  mManager.StringValue("Breeding Tuner Creatures") = Value
			End Set
		#tag EndSetter
		Protected BreedingTunerCreatures As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		#tag Getter
			Get
			  Init
			  Return mManager.IntegerValue("Crafting Costs Splitter Position", ArkCraftingCostsEditor.ListDefaultWidth)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.IntegerValue("Crafting Costs Splitter Position") = Value
			End Set
		#tag EndSetter
		Protected CraftingSplitterPosition As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  
			  Var Default As Integer = CType(DarkModeOptions.FollowSystem, Integer)
			  #if TargetWindows
			    If SystemInformationMBS.IsWindows11(True) = False Then
			      Default = CType(DarkModeOptions.ForceLight, Integer)
			    End If
			  #endif
			  
			  Var IntValue As Integer = mManager.IntegerValue("Dark Mode", Default)
			  Return CType(IntValue, DarkModeOptions)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Value = DarkMode Then
			    Return
			  End If
			  
			  mManager.IntegerValue("Dark Mode") = CType(Value, Integer)
			  
			  #if TargetMacOS
			    Select Case Value
			    Case DarkModeOptions.ForceLight
			      NSAppearanceMBS.SetAppearance(App, NSAppearanceMBS.AppearanceNamed(NSAppearanceMBS.NSAppearanceNameAqua))
			    Case DarkModeOptions.ForceDark
			      NSAppearanceMBS.SetAppearance(App, NSAppearanceMBS.AppearanceNamed(NSAppearanceMBS.NSAppearanceNameDarkAqua))
			    Case DarkModeOptions.FollowSystem
			      NSAppearanceMBS.SetAppearance(App, Nil)
			    End Select
			    
			    App.AppearanceChanged()
			  #endif
			End Set
		#tag EndSetter
		Protected DarkMode As Preferences.DarkModeOptions
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.BooleanValue("Deploy: Create Backup", True)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.BooleanValue("Deploy: Create Backup") = Value
			End Set
		#tag EndSetter
		Protected DeployCreateBackup As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.BooleanValue("Deploy: Review Changes", False)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.BooleanValue("Deploy: Review Changes") = Value
			End Set
		#tag EndSetter
		Protected DeployReviewChanges As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.BooleanValue("Deploy: Run Advisor", False)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.BooleanValue("Deploy: Run Advisor") = Value
			End Set
		#tag EndSetter
		Protected DeployRunAdvisor As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Return mDevicePrivateKey
			End Get
		#tag EndGetter
		Protected DevicePrivateKey As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Return mDevicePublicKey
			End Get
		#tag EndGetter
		Protected DevicePublicKey As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		#tag Getter
			Get
			  Init
			  Return mManager.SizeValue("Entry Editor Size", New Size(900, 500))
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.SizeValue("Entry Editor Size") = Value
			End Set
		#tag EndSetter
		Protected EntryEditorSize As Size
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.IntegerValue("Hardware Id Version", 5)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.IntegerValue("Hardware Id Version") = Value
			  
			  // Update private key encryption in case the hardware id changes
			  EncryptPrivateKey()
			End Set
		#tag EndSetter
		Protected HardwareIdVersion As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.BooleanValue("Has Shown Experimental Warning", False)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.BooleanValue("Has Shown Experimental Warning") = Value
			End Set
		#tag EndSetter
		Protected HasShownExperimentalWarning As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		#tag Getter
			Get
			  Init
			  Return mManager.IntegerValue("Item Sets Splitter Position", ArkLootDropEditor.ListDefaultWidth)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.IntegerValue("Item Sets Splitter Position") = Value
			End Set
		#tag EndSetter
		Protected ItemSetsSplitterPosition As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.VariantValue("Last Preset Map Filter", Ark.Maps.UniversalMask)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.VariantValue("Last Preset Map Filter") = Value
			End Set
		#tag EndSetter
		Protected LastPresetMapFilter As UInt64
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.StringValue("Last Stop Message", "Server is now stopping for a few minutes for changes.")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.StringValue("Last Stop Message") = Value
			End Set
		#tag EndSetter
		Protected LastStopMessage As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		#tag Getter
			Get
			  Init
			  Return mManager.SizeValue("Last Used Screen Size", Nil)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.SizeValue("Last Used Screen Size") = Value
			End Set
		#tag EndSetter
		Protected LastUsedScreenSize As Size
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		#tag Getter
			Get
			  Init
			  Return mManager.RectValue("Main Window Size", Nil)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.RectValue("Main Window Size") = Value
			End Set
		#tag EndSetter
		Protected MainWindowPosition As Rect
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mAuthToken As BeaconAPI.OAuthToken
	#tag EndProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.IntegerValue("Max Connections", 3)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If MaxConnections = Value Then
			    Return
			  End If
			  
			  mManager.IntegerValue("Max Connections") = Value
			  
			  If mConnectionLockCount = 0 Then
			    mConnectionLock = New Semaphore(Value)
			  End If
			End Set
		#tag EndSetter
		Protected MaxConnections As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mConnectionLock As Semaphore
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConnectionLockCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDevicePrivateKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDevicePublicKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mManager As PreferencesManager
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOnlineToken As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Var HasLaunchedBefore As Boolean = mManager.BooleanValue("Has Shown Subscribe Dialog", False)
			  Return mManager.IntegerValue("Newest Used Build", If(HasLaunchedBefore, 10408304, 0))
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  // Don't need Init here because NewestUsedBuild will do that
			  Var OldValue As Integer = NewestUsedBuild
			  If Value > OldValue Then
			    mManager.IntegerValue("Newest Used Build") = Value
			  End If
			End Set
		#tag EndSetter
		Protected NewestUsedBuild As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.StringValue("New Project Game Id", "")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.StringValue("New Project Game Id") = Value
			End Set
		#tag EndSetter
		Protected NewProjectGameId As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.BooleanValue("Online Enabled", False)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Value = OnlineEnabled Then
			    Return
			  End If
			  
			  mManager.BooleanValue("Online Enabled") = Value
			  NotificationKit.Post(Notification_OnlineStateChanged, Value)
			  UpdatesKit.RefreshSettings()
			End Set
		#tag EndSetter
		Protected OnlineEnabled As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.BooleanValue("Play Sound After Deploy", True)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mManager.BooleanValue("Play Sound After Deploy") = Value
			End Set
		#tag EndSetter
		Protected PlaySoundAfterDeploy As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.BooleanValue("Play Sound After Import", True)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mManager.BooleanValue("Play Sound After Import") = Value
			End Set
		#tag EndSetter
		Protected PlaySoundAfterImport As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.BooleanValue("Play Sound For Update", True)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mManager.BooleanValue("Play Sound For Update") = Value
			End Set
		#tag EndSetter
		Protected PlaySoundForUpdate As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		#tag Getter
			Get
			  Init
			  Return mManager.SizeValue("Preset Selector Editor Size", New Size(600, 400))
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.SizeValue("Preset Selector Editor Size") = Value
			End Set
		#tag EndSetter
		Protected PresetSelectorEditorSize As Size
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.DictionaryValue("Presets Enabled Mods", Nil)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.DictionaryValue("Presets Enabled Mods") = Value
			End Set
		#tag EndSetter
		Protected PresetsEnabledMods As Dictionary
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  
			  Var Default As Integer = CType(ProfileIconChoices.WithoutPonytail, Integer)
			  Var IntValue As Integer = mManager.IntegerValue("Profile Icon", Default)
			  Return CType(IntValue, ProfileIconChoices)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Value = ProfileIcon Then
			    Return
			  End If
			  
			  mManager.IntegerValue("Profile Icon") = CType(Value, Integer)
			  NotificationKit.Post(Notification_ProfileIconChanged, Value)
			End Set
		#tag EndSetter
		Protected ProfileIcon As Preferences.ProfileIconChoices
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.DictionaryValue("Saved Passwords", New Dictionary)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Value Is Nil Then
			    Value = New Dictionary
			  End If
			  
			  Init
			  mManager.DictionaryValue("Saved Passwords") = Value
			End Set
		#tag EndSetter
		Protected SavedPasswords As Dictionary
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.StringValue("Servers List Name Style", ServersListbox.NamesFull)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mManager.StringValue("Servers List Name Style") = Value
			End Set
		#tag EndSetter
		Protected ServersListNameStyle As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.BooleanValue("Servers List Show Ids", False)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mManager.BooleanValue("Servers List Show Ids") = Value
			End Set
		#tag EndSetter
		Protected ServersListShowIds As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.StringValue("Servers List Sorted Value", ServersListbox.SortByName)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mManager.StringValue("Servers List Sorted Value") = Value
			End Set
		#tag EndSetter
		Protected ServersListSortedValue As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.BooleanValue("Show Experimental Sources", False)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If ShowExperimentalLootSources = Value Then
			    Return
			  End If
			  
			  mManager.BooleanValue("Show Experimental Sources") = Value
			End Set
		#tag EndSetter
		Protected ShowExperimentalLootSources As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		#tag Getter
			Get
			  Init
			  Return mManager.IntegerValue("Simulator Size", 200)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.IntegerValue("Simulator Size") = Value
			End Set
		#tag EndSetter
		Protected SimulatorSize As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		#tag Getter
			Get
			  Init
			  Return mManager.BooleanValue("Simulator Visible")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.BooleanValue("Simulator Visible") = Value
			End Set
		#tag EndSetter
		Protected SimulatorVisible As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		#tag Getter
			Get
			  Init
			  Return mManager.IntegerValue("Sources Splitter Position", ArkLootDropsEditor.ListDefaultWidth)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.IntegerValue("Sources Splitter Position") = Value
			End Set
		#tag EndSetter
		Protected SourcesSplitterPosition As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		#tag Getter
			Get
			  Init
			  Return mManager.IntegerValue("Spawn Points Splitter Position", ArkCreatureSpawnsEditor.ListDefaultWidth)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.IntegerValue("Spawn Points Splitter Position") = Value
			End Set
		#tag EndSetter
		Protected SpawnPointsSplitterPosition As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.BooleanValue("Switches Show Captions")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Value = SwitchesShowCaptions Then
			    Return
			  End If
			  
			  mManager.BooleanValue("Switches Show Captions") = Value
			  NotificationKit.Post(Notification_SwitchCaptionVisibilityChanged, Value)
			End Set
		#tag EndSetter
		Protected SwitchesShowCaptions As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Init
			  Return mManager.IntegerValue("Updates Channel", 0)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Init
			  mManager.IntegerValue("Updates Channel") = Value
			  UpdatesKit.RefreshSettings()
			End Set
		#tag EndSetter
		Protected UpdateChannel As Integer
	#tag EndComputedProperty


	#tag Constant, Name = Notification_OnlineStateChanged, Type = String, Dynamic = False, Default = \"Online State Changed", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Notification_OnlineTokenChanged, Type = String, Dynamic = False, Default = \"Online Token Changed", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Notification_ProfileIconChanged, Type = String, Dynamic = False, Default = \"Profile Icon Changed", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Notification_RecentsChanged, Type = String, Dynamic = False, Default = \"Recent Documents Changed", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Notification_SwitchCaptionVisibilityChanged, Type = String, Dynamic = False, Default = \"Switch Caption Visibility Changed", Scope = Protected
	#tag EndConstant


	#tag Enum, Name = DarkModeOptions, Type = Integer, Flags = &h1
		FollowSystem
		  ForceLight
		ForceDark
	#tag EndEnum

	#tag Enum, Name = ProfileIconChoices, Type = Integer, Flags = &h1
		WithoutPonytail
		  WithPonytail
		Cat
	#tag EndEnum


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
End Module
#tag EndModule
