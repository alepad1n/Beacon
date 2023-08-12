#tag Class
Protected Class Project
Implements ObservationKit.Observable
	#tag Method, Flags = &h0
		Function ActiveConfigSet() As Beacon.ConfigSet
		  Return Self.mActiveConfigSet
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ActiveConfigSet(Assigns Set As Beacon.ConfigSet)
		  If Set Is Nil Then
		    Set = Beacon.ConfigSet.BaseConfigSet
		  End If
		  
		  Var Idx As Integer = Self.IndexOf(Set)
		  If Idx = -1 Then
		    Self.mActiveConfigSet = Beacon.ConfigSet.BaseConfigSet
		  Else
		    Self.mActiveConfigSet = Self.mConfigSets(Idx)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddConfigSet(Set As Beacon.ConfigSet)
		  If Set Is Nil Then
		    Return
		  End If
		  
		  Var Idx As Integer = Self.IndexOf(Set)
		  If Idx > -1 Then
		    Return
		  End If
		  
		  If Self.HasConfigSet(Set.Name) Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "There is already a config set named " + Set.Name + "."
		    Raise Err
		  End If
		  
		  Self.mConfigSets.Add(Set)
		  Self.mConfigSetData.Value(Set.ConfigSetId) = New Dictionary
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddFile(Filename As String, Contents As String)
		  Self.mAdditionalFiles.Value(Filename) = Contents
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AddGuest(Identity As Beacon.Identity) As Boolean
		  If Identity Is Nil Then
		    Return False
		  End If
		  
		  Return Self.AddGuest(New Beacon.ProjectGuest(Identity))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AddGuest(Guest As Beacon.ProjectGuest) As Boolean
		  If Guest Is Nil Then
		    Return False
		  End If
		  
		  // Need to set the password to generate the fingerprint
		  Guest.SetPassword(Self.mProjectPassword)
		  
		  Var ExistingGuest As Beacon.ProjectGuest = Self.mEncryptedPasswords.Lookup(Guest.UserId.Lowercase, Nil)
		  If (ExistingGuest Is Nil) = False And Guest.Fingerprint = ExistingGuest.Fingerprint Then
		    // No change
		    Return False
		  End If
		  
		  Self.mEncryptedPasswords.Value(Guest.UserId.Lowercase) = Guest
		  Self.Modified = True
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub AdditionalFilesLoaded()
		  RaiseEvent AdditionalFilesLoaded()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddObserver(Observer As ObservationKit.Observer, Key As String)
		  // Part of the ObservationKit.Observable interface.
		  
		  If Self.mObservers Is Nil Then
		    Self.mObservers = New Dictionary
		  End If
		  
		  Var Refs() As WeakRef
		  If Self.mObservers.HasKey(Key) Then
		    Refs = Self.mObservers.Value(Key)
		  End If
		  
		  For I As Integer = Refs.LastIndex DownTo 0
		    If Refs(I).Value = Nil Then
		      Refs.RemoveAt(I)
		      Continue
		    End If
		    
		    If Refs(I).Value = Observer Then
		      // Already being watched
		      Return
		    End If
		  Next
		  
		  Refs.Add(New WeakRef(Observer))
		  Self.mObservers.Value(Key) = Refs
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddServerProfile(Profile As Beacon.ServerProfile)
		  If Profile Is Nil Then
		    Return
		  End If
		  
		  For Idx As Integer = 0 To Self.mServerProfiles.LastIndex
		    If Self.mServerProfiles(Idx).ProfileID = Profile.ProfileID Then
		      Self.mServerProfiles(Idx) = Profile // They might compare to the same UUID, but could be different objects.
		      If Profile.Modified Then
		        Self.Modified = True
		      End If
		      Return
		    End If
		  Next
		  
		  RaiseEvent AddingProfile(Profile)
		  
		  Self.mServerProfiles.Add(Profile)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone(Identity As Beacon.Identity) As Beacon.Project
		  // Yes, run this through JSON first to ensure parsing is exactly as compatible as coming from the
		  // disk or cloud. The object types put into the dictionary are not always the same as comes back
		  // in the parsed JSON.
		  
		  Try
		    Var SaveData As MemoryBlock = Self.SaveData(Identity)
		    Return FromSaveData(SaveData, Identity)
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigSetCount() As Integer
		  Return Self.mConfigSets.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ConfigSetData(Set As Beacon.ConfigSet) As Dictionary
		  If Set Is Nil Then
		    Set = Self.ActiveConfigSet
		  End If
		  
		  If Self.mConfigSetData.HasKey(Set.ConfigSetId) = False Then
		    Self.mConfigSetData.Value(Set.ConfigSetId) = New Dictionary
		    Self.Modified = True
		  End If
		  
		  Return Self.mConfigSetData.Value(Set.ConfigSetId)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ConfigSetData(Set As Beacon.ConfigSet, Assigns Dict As Dictionary)
		  If Set Is Nil Then
		    Set = Self.ActiveConfigSet
		  End If
		  
		  // Nil dict should remove the config set
		  If Dict Is Nil Then
		    If Self.mConfigSetData.HasKey(Set.ConfigSetId) Then
		      Self.mConfigSetData.Remove(Set.ConfigSetId)
		    End If
		    
		    Var Idx As Integer = Self.IndexOf(Set)
		    If Idx > -1 Then
		      Self.mConfigSets.RemoveAt(Idx)
		    End If
		    
		    For Idx = 0 To Self.mConfigSetPriorities.LastIndex
		      If Self.mConfigSetPriorities(Idx) = Set Then
		        Self.mConfigSetPriorities.RemoveAt(Idx)
		        Exit
		      End If
		    Next
		    
		    Self.Modified = True
		    Return
		  End If
		  
		  // Set will not be added unless necessary
		  Self.AddConfigSet(Set)
		  
		  Self.mConfigSetData.Value(Set.ConfigSetId) = Dict
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigSetNames() As String()
		  Var Names() As String
		  For Each Set As Beacon.ConfigSet In Self.mConfigSets
		    Names.Add(Set.Name)
		  Next
		  Return Names
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigSetPriorities() As Beacon.ConfigSetState()
		  Return Beacon.ConfigSetState.CloneArray(Self.mConfigSetPriorities)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ConfigSetPriorities(Assigns List() As Beacon.ConfigSetState)
		  If Beacon.ConfigSetState.AreArraysEqual(Self.mConfigSetPriorities, List) Then
		    Return
		  End If
		  
		  Self.mConfigSetPriorities = Beacon.ConfigSetState.CloneArray(List)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigSets() As Beacon.ConfigSet()
		  // Make sure to return a clone of the array.
		  Var Clone() As Beacon.ConfigSet
		  For Each Set As Beacon.ConfigSet In Self.mConfigSets
		    Clone.Add(New Beacon.ConfigSet(Set))
		  Next
		  Return Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConsoleSafe() As Boolean
		  Return Self.mConsoleSafe
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ConsoleSafe(Assigns Value As Boolean)
		  If Self.mConsoleSafe <> Value Then
		    Self.mConsoleSafe = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  // This class should only be created as a subclass
		  
		  Self.mEncryptedPasswords = New Dictionary
		  Self.mProjectPassword = Crypto.GenerateRandomBytes(32)
		  Self.mProjectId = Beacon.UUID.v4
		  
		  Self.mConfigSetData = New Dictionary
		  Var BaseSet As Beacon.ConfigSet = Beacon.ConfigSet.BaseConfigSet
		  Self.AddConfigSet(BaseSet)
		  Self.mActiveConfigSet = BaseSet
		  Self.mConfigSetPriorities.ResizeTo(0)
		  Self.mConfigSetPriorities(0) = New Beacon.ConfigSetState(BaseSet, True)
		  
		  Self.mProviderTokenKeys = New Dictionary
		  Self.mAdditionalFiles = New Dictionary
		  Self.mEmbeddedContentPacks = New Dictionary
		  
		  Self.mContentPacks = New Dictionary
		  Var DataSource As Beacon.DataSource = Self.DataSource(False)
		  If (DataSource Is Nil) = False Then
		    Var Packs() As Beacon.ContentPack = DataSource.GetContentPacks
		    For Idx As Integer = 0 To Packs.LastIndex
		      Self.mContentPacks.Value(Packs(Idx).ContentPackId) = Packs(Idx).IsDefaultEnabled
		    Next
		  End If
		  
		  Self.mUseCompression = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackEnabled(Pack As Beacon.ContentPack) As Boolean
		  Return Self.ContentPackEnabled(Pack.ContentPackId)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ContentPackEnabled(Pack As Beacon.ContentPack, Assigns Value As Boolean)
		  If Pack Is Nil Then
		    Return
		  End If
		  
		  Self.ContentPackEnabled(Pack.ContentPackId) = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackEnabled(ContentPackId As String) As Boolean
		  Return Self.mContentPacks.Lookup(ContentPackId, False)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ContentPackEnabled(ContentPackId As String, Assigns Value As Boolean)
		  Var WasEnabled As Boolean = Self.mContentPacks.Lookup(ContentPackId, False)
		  If WasEnabled = Value Then
		    Return
		  End If
		  
		  Self.mContentPacks.Value(ContentPackId) = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPacks() As Beacon.StringList
		  Var List As New Beacon.StringList
		  For Each Entry As DictionaryEntry In Self.mContentPacks
		    If Entry.Value.BooleanValue = True Then
		      List.Append(Entry.Key.StringValue)
		    End If
		  Next
		  Return List
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateForGameId(GameId As String) As Beacon.Project
		  Select Case GameId
		  Case Ark.Identifier
		    Return New Ark.Project()
		  Case SDTD.Identifier
		    Return New SDTD.Project()
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DataSource(AllowWriting As Boolean) As Beacon.DataSource
		  // Subclasses should override
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Decrypt(Data As String) As String
		  Return BeaconEncryption.SymmetricDecrypt(Self.mProjectPassword, DecodeBase64(Data))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Description() As String
		  Return Self.mDescription
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Description(Assigns Value As String)
		  If Self.mDescription.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
		    Var OldValue As String = Self.mDescription
		    Self.mDescription = Value
		    Self.Modified = True
		    Self.NotifyObservers("Description", OldValue, Value)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EmbeddedContentPacks() As Beacon.ContentPack()
		  Var Packs() As Beacon.ContentPack
		  For Each Entry As DictionaryEntry In Self.mEmbeddedContentPacks
		    Packs.Add(Entry.Value)
		  Next
		  Return Packs
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Encrypt(Data As String) As String
		  Return EncodeBase64(BeaconEncryption.SymmetricEncrypt(Self.mProjectPassword, Data), 0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Files() As String()
		  Var Filenames() As String
		  For Each Entry As DictionaryEntry In Self.mAdditionalFiles
		    Filenames.Add(Entry.Key)
		  Next
		  Return Filenames
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindConfigSet(NameOrId As String) As Beacon.ConfigSet
		  For Each Set As Beacon.ConfigSet In Self.mConfigSets
		    If Set.Name = NameOrId Or Set.ConfigSetId = NameOrId Then
		      Return Set
		    End If
		  Next
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(SaveData As Dictionary, Identity As Beacon.Identity) As Beacon.Project
		  Var AdditionalProperties As New Dictionary
		  Return FromSaveData(SaveData, Identity, AdditionalProperties)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(SaveData As Dictionary, Identity As Beacon.Identity, AdditionalProperties As Dictionary) As Beacon.Project
		  Var Version As Integer = SaveData.FirstValue("version", "Version", 0).IntegerValue
		  Var MinVersion As Integer = SaveData.FirstValue("minVersion", "MinVersion", Beacon.Project.SaveDataVersion).IntegerValue
		  Var SavedWithVersion As Integer = SaveData.FirstValue("savedWith", "SavedWith", 10501399).IntegerValue // Max possible version before the value should exist
		  Var GameId As String = SaveData.FirstValue("gameId", "Game", Ark.Identifier).StringValue
		  
		  Var ProjectId As String = SaveData.FirstValue("projectId", "Identifier", "").StringValue
		  If Beacon.UUID.Validate(ProjectId) = False Then
		    ProjectId = Beacon.UUID.v4
		  End If
		  
		  If MinVersion > Beacon.Project.SaveDataVersion Then
		    Var Err As New Beacon.ProjectLoadException
		    Err.Message = "This is a v" + Version.ToString(Locale.Raw, "0") + " project, but this version of Beacon only supports up to v" + MinVersion.ToString(Locale.Raw, "0") + " projects. There may be an update available."
		    Raise Err
		  End If
		  
		  Var Project As Beacon.Project
		  Select Case GameId
		  Case Ark.Identifier
		    Project = New Ark.Project
		  Else
		    Var Err As New Beacon.ProjectLoadException
		    Err.Message = "Unknown game " + GameID + "."
		    Raise Err
		  End Select
		  
		  Project.mProjectId = ProjectId
		  
		  Var DescriptionKey As Variant = SaveData.FirstKey("description", "Description")
		  If DescriptionKey.IsNull = False Then
		    Project.mDescription = SaveData.Value(DescriptionKey)
		  End If
		  
		  Var TitleKey As Variant = SaveData.FirstKey("name", "Title")
		  If TitleKey.IsNull = False Then
		    Project.mTitle = SaveData.Value(TitleKey)
		  End If
		  
		  Var LegacyTrustKey As Variant = SaveData.FirstKey("legacyTrustKey", "LegacyTrustKey", "Trust")
		  If LegacyTrustKey.IsNull = False Then
		    Project.mLegacyTrustKey = SaveData.Value(LegacyTrustKey)
		  End If
		  
		  If SaveData.HasKey("keepLocalBackup") Then
		    Project.mKeepLocalBackup = SaveData.Value("keepLocalBackup")
		  End If
		  
		  Project.mConsoleSafe = SaveData.FirstValue("isConsole", "IsConsole", Project.mConsoleSafe).BooleanValue
		  
		  Var UseCompressionKey As Variant = SaveData.FirstKey("useCompression", "UseCompression")
		  If UseCompressionKey.IsNull = False Then
		    Project.mUseCompression = SaveData.Value(UseCompressionKey)
		  End If
		  
		  Var Passwords As Dictionary = SaveData.FirstValue("encryptionKeys", "EncryptionKeys", Nil)
		  If Version >= 4 And (Passwords Is Nil) = False Then
		    Var PossibleIdentities(0) As Beacon.Identity
		    PossibleIdentities(0) = Identity
		    
		    Var Temp As New Dictionary
		    For Each Entry As DictionaryEntry In Passwords
		      If Entry.Value.Type = Variant.TypeString Then
		        Temp.Value(Entry.Key) = New Beacon.ProjectGuest(Entry.Key.StringValue, "", "", Entry.Value.StringValue)
		      Else
		        Temp.Value(Entry.Key) = New Beacon.ProjectGuest(Dictionary(Entry.Value))
		      End If
		      
		      Var UserId As String = Entry.Key
		      If UserId = Identity.UserId Then
		        Continue
		      End If
		      
		      Var MergedIdentity As Beacon.Identity = App.IdentityManager.Fetch(UserId)
		      If (MergedIdentity Is Nil) = False Then
		        PossibleIdentities.Add(MergedIdentity)
		      End If
		    Next
		    Passwords = Temp
		    
		    For Each PossibleIdentity As Beacon.Identity In PossibleIdentities
		      Var UserId As String = PossibleIdentity.UserId.Lowercase
		      If Passwords.HasKey(UserId) = False Then
		        Continue
		      End If
		      
		      Try
		        Var Guest As Beacon.ProjectGuest = Passwords.Value(UserId)
		        Var DocumentPassword As String = Crypto.RSADecrypt(DecodeBase64MBS(Guest.EncryptedPassword), PossibleIdentity.PrivateKey)
		        Project.mProjectPassword = DocumentPassword
		        Project.mEncryptedPasswords = Passwords
		        
		        If Passwords.HasKey(UserId) = False Then
		          // Add a password for the current user
		          Call Project.AddGuest(New Beacon.ProjectGuest(PossibleIdentity))
		        End If
		        
		        Exit
		      Catch Err As RuntimeException
		        // Leave the encryption fresh
		        Break
		      End Try
		    Next
		  End If
		  
		  Var SecureDict As Dictionary
		  #Pragma BreakOnExceptions False
		  If SaveData.HasAnyKey("encryptedData", "EncryptedData") Then
		    Try
		      Project.mLastSecureData = SaveData.FirstValue("encryptedData", "EncryptedData", "")
		      Var Decrypted As String = Project.Decrypt(Project.mLastSecureData)
		      Project.mLastSecureHash = Beacon.Hash(Decrypted)
		      SecureDict = Beacon.ParseJSON(Decrypted)
		    Catch Err As RuntimeException
		      // No secure data
		    End Try
		  ElseIf SaveData.HasKey("Secure") Then
		    SecureDict = ReadLegacySecureData(SaveData.Value("Secure"), Identity)
		  End If
		  #Pragma BreakOnExceptions Default
		  If SecureDict Is Nil Then
		    SecureDict = New Dictionary
		  End If
		  
		  If SaveData.HasKey("additionalFiles") Then
		    If Project.mUseCompression Then
		      Project.mAdditionalFiles = SaveData.Value("additionalFiles")
		    Else
		      Var AdditionalFiles As Dictionary = SaveData.Value("additionalFiles")
		      For Each Entry As DictionaryEntry In AdditionalFiles
		        Project.mAdditionalFiles.Value(Entry.Key) = Beacon.Decompress(DecodeBase64(Entry.Value.StringValue))
		      Next
		    End If
		  End If
		  Project.AdditionalFilesLoaded()
		  Project.ProcessEmbeddedContent()
		  
		  If SaveData.HasKey("modSelections") Or SaveData.HasKey("ModSelections") Then
		    // Newest mod, keys are uuids and values are boolean
		    Var AllPacks() As Beacon.ContentPack = Project.DataSource(False).GetContentPacks()
		    Var Selections As Dictionary = SaveData.FirstValue("modSelections", "ModSelections", Nil)
		    Var ConsoleMode As Boolean = Project.ConsoleSafe
		    For Each Pack As Beacon.ContentPack In AllPacks
		      If Selections.HasKey(Pack.ContentPackId) = False Then
		        Selections.Value(Pack.ContentPackId) = Pack.IsDefaultEnabled And (Pack.IsConsoleSafe Or ConsoleMode = False)
		      End If
		    Next
		    Project.mContentPacks = Selections
		  End If
		  
		  If SaveData.HasKey("configSetData") Then
		    Project.mConfigSets.ResizeTo(-1)
		    Var Definitions() As Variant = SaveData.Value("configSets")
		    For Each Definition As Variant In Definitions
		      If Definition.Type = Variant.TypeObject And Definition.ObjectValue IsA Dictionary Then
		        Var ConfigSet As Beacon.ConfigSet = Beacon.ConfigSet.FromSaveData(Dictionary(Definition.ObjectValue))
		        Project.mConfigSets.Add(ConfigSet)
		      End If
		    Next
		    
		    Project.mConfigSetPriorities = Beacon.ConfigSetState.DecodeArray(SaveData.Value("configSetPriorities"))
		    
		    Var SetDicts As Dictionary = SaveData.Value("configSetData")
		    Var EncryptedDicts As Dictionary
		    If SecureDict.HasKey("configSetData") Then
		      Try
		        EncryptedDicts = SecureDict.Value("configSetData")
		      Catch Err As RuntimeException
		      End Try
		    End If
		    If EncryptedDicts Is Nil Then
		      EncryptedDicts = New Dictionary
		    End If
		    
		    Project.mConfigSetData = New Dictionary
		    For Each Entry As DictionaryEntry In SetDicts
		      Var SetId As String = Entry.Key
		      
		      If Entry.Value IsA Dictionary Then
		        Var EncryptedSetData As Dictionary
		        If EncryptedDicts.HasKey(SetId) Then
		          Try
		            EncryptedSetData = EncryptedDicts.Value(SetId)
		          Catch Err As RuntimeException
		          End Try
		        End If
		        
		        Project.mConfigSetData.Value(SetId) = Project.LoadConfigSet(Dictionary(Entry.Value), EncryptedSetData)
		      Else
		        Project.mConfigSetData.Value(SetId) = New Dictionary
		      End If
		    Next
		  ElseIf SaveData.HasKey("Config Sets") Then
		    Var Sets As Dictionary = SaveData.Value("Config Sets")
		    Var EncryptedSets As Dictionary
		    If SecureDict.HasKey("Config Sets") Then
		      Try
		        EncryptedSets = SecureDict.Value("Config Sets")
		      Catch Err As RuntimeException
		      End Try
		    End If
		    If EncryptedSets Is Nil Then
		      EncryptedSets = New Dictionary
		    End If
		    
		    Project.mConfigSets.ResizeTo(-1)
		    Project.mConfigSetData = New Dictionary
		    Project.mConfigSetPriorities.ResizeTo(-1)
		    Var SetsMap As New Dictionary
		    For Each Entry As DictionaryEntry In Sets
		      Var SetName As String = Entry.Key
		      Var Set As Beacon.ConfigSet
		      If SetName = "Base" Then
		        Set = Beacon.ConfigSet.BaseConfigSet
		      Else
		        Set = New Beacon.ConfigSet(SetName)
		      End If
		      SetsMap.Value(Set.Name) = Set
		      Project.mConfigSets.Add(Set)
		      
		      If Entry.Value IsA Dictionary Then
		        Var EncryptedSetData As Dictionary
		        If EncryptedSets.HasKey(SetName) Then
		          Try
		            EncryptedSetData = EncryptedSets.Value(SetName)
		          Catch Err As RuntimeException
		          End Try
		        End If
		        
		        Project.mConfigSetData.Value(Set.ConfigSetId) = Project.LoadConfigSet(Dictionary(Entry.Value), EncryptedSetData)
		      Else
		        Project.mConfigSetData.Value(Set.ConfigSetId) = New Dictionary
		      End If
		    Next
		    
		    If SaveData.HasKey("Config Set Priorities") Then
		      Var States() As Variant = SaveData.Value("Config Set Priorities")
		      For Each State As Variant In States
		        Try
		          If State.Type = Variant.TypeObject And State.ObjectValue IsA Dictionary Then
		            Var StateDict As Dictionary = Dictionary(State.ObjectValue)
		            Var Name As String = StateDict.Value("Name")
		            Var Enabled As Boolean = StateDict.Value("Enabled")
		            If SetsMap.HasKey(Name) = False Then
		              Continue
		            End If
		            Var Set As Beacon.ConfigSet = SetsMap.Value(Name)
		            
		            Project.mConfigSetPriorities.Add(New Beacon.ConfigSetState(Set, Enabled))
		          End If
		        Catch Err As RuntimeException
		        End Try
		      Next
		    End If
		  ElseIf SaveData.HasKey("Configs") Then
		    Project.mConfigSets.ResizeTo(0)
		    Project.mConfigSets(0) = Beacon.ConfigSet.BaseConfigSet
		    Project.mConfigSetPriorities.ResizeTo(0)
		    Project.mConfigSetPriorities(0) = New Beacon.ConfigSetState(Beacon.ConfigSet.BaseConfigSetId, True)
		    Project.mConfigSetData = New Dictionary
		    Project.mConfigSetData.Value(Beacon.ConfigSet.BaseConfigSetId) = Project.LoadConfigSet(SaveData.Value("Configs"), Nil)
		  End If
		  
		  Var ServerDicts() As Variant
		  If SecureDict.HasKey("servers") And SecureDict.Value("servers").IsArray Then
		    ServerDicts = SecureDict.Value("servers")
		  ElseIf SecureDict.HasKey("Servers") And SecureDict.Value("Servers").IsArray Then
		    ServerDicts = SecureDict.Value("Servers")
		  End If
		  For Each ServerDict As Variant In ServerDicts
		    Try
		      Var Dict As Dictionary = ServerDict
		      Var Profile As Beacon.ServerProfile = Beacon.ServerProfile.FromSaveData(Dict, Project)
		      If Profile Is Nil Then
		        Continue
		      End If
		      
		      // Something about migrating the nitrado account?
		      
		      Project.mServerProfiles.Add(Profile)
		    Catch Err As RuntimeException
		    End Try
		  Next
		  
		  If SecureDict.HasKey("providerTokenKeys") Then
		    Var KeysDict As Dictionary = SecureDict.Value("providerTokenKeys")
		    For Each Entry As DictionaryEntry In KeysDict
		      Project.mProviderTokenKeys.Value(Entry.Key) = DecodeBase64(Entry.Value)
		    Next
		  End If
		  
		  Project.ReadSaveData(SaveData, SecureDict, Version, SavedWithVersion)
		  
		  If SaveData.HasKey("otherProperties") And (AdditionalProperties Is Nil) = False Then
		    Var Dict As Dictionary = SaveData.Value("otherProperties")
		    For Each Entry As DictionaryEntry In Dict
		      AdditionalProperties.Value(Entry.Key) = Entry.Value
		    Next
		  End If
		  
		  Project.Modified = Version < Beacon.Project.SaveDataVersion
		  
		  Return Project
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(SaveData As MemoryBlock, Identity As Beacon.Identity) As Beacon.Project
		  Var AdditionalProperties As New Dictionary
		  Return FromSaveData(SaveData, Identity, AdditionalProperties)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(SaveData As MemoryBlock, Identity As Beacon.Identity, AdditionalProperties As Dictionary) As Beacon.Project
		  If SaveData Is Nil Or SaveData.Size = 0 Then
		    Var Err As New Beacon.ProjectLoadException
		    Err.Message = "File is empty."
		    Raise Err
		  End If
		  
		  Var UseCompression As Boolean
		  Var ProjectDict As Dictionary
		  If SaveData.Size >= 8 And (SaveData.UInt64Value(0) = CType(Beacon.Project.BinaryFormatBEBOM, UInt64) Or SaveData.UInt64Value(0) = CType(Beacon.Project.BinaryFormatLEBOM, UInt64)) Then
		    SaveData = SaveData.Middle(8, SaveData.Size - 8)
		    
		    Var Archive As Beacon.Archive = Beacon.Archive.Open(SaveData)
		    Var ManifestData As Dictionary = Beacon.ParseJSON(Archive.GetFile("Manifest.json"))
		    Var Version As Integer = ManifestData.Value("version")
		    Var ProjectData As Dictionary = Beacon.ParseJSON(Archive.GetFile("v" + Version.ToString(Locale.Raw, "0") + ".json"))
		    
		    If ManifestData.HasKey("additionalFiles") Then
		      Var AdditionalFiles As New Dictionary
		      Var Filenames() As Variant = ManifestData.Value("additionalFiles")
		      For Each Filename As Variant In Filenames
		        If Filename.Type <> Variant.TypeString Then
		          Continue
		        End If
		        
		        Var Contents As String = Archive.GetFile(Filename)
		        If Contents.IsEmpty = False Then
		          AdditionalFiles.Value(Filename) = Contents
		        End If
		      Next
		      ProjectData.Value("additionalFiles") = AdditionalFiles
		      ManifestData.Remove("additionalFiles") // Don't want to replace the loaded files with the list from the manifest
		    End If
		    
		    For Each Entry As DictionaryEntry In ManifestData
		      ProjectData.Value(Entry.Key) = Entry.Value
		    Next
		    
		    ProjectDict = ProjectData
		    UseCompression = True
		  Else
		    If SaveData.Size >= 2 And SaveData.UInt8Value(0) = &h1F And SaveData.UInt8Value(1) = &h8B Then
		      Var Decompressed As String = Beacon.Decompress(SaveData)
		      If Decompressed.IsEmpty = False Then
		        SaveData = Decompressed.DefineEncoding(Encodings.UTF8)
		        UseCompression = True
		      Else
		        Var Err As New Beacon.ProjectLoadException
		        Err.Message = "Failed to decompress project."
		        Raise Err
		      End If
		    End If
		    
		    ProjectDict = Beacon.ParseJSON(SaveData)
		  End If
		  
		  ProjectDict.Value("useCompression") = UseCompression
		  
		  Return FromSaveData(ProjectDict, Identity, AdditionalProperties)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameId() As String
		  Var Err As New UnsupportedOperationException
		  Err.Message = "Project.GameID not overridden"
		  Raise Err
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetFile(Filename As String) As String
		  If Self.mAdditionalFiles.HasKey(Filename) Then
		    Return Self.mAdditionalFiles.Value(Filename)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetGuests() As Beacon.ProjectGuest()
		  Var Guests() As Beacon.ProjectGuest
		  For Each Entry As DictionaryEntry In Self.mEncryptedPasswords
		    Guests.Add(Entry.Value)
		  Next
		  Return Guests
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasConfigSet(Set As Beacon.ConfigSet) As Boolean
		  Return Self.IndexOf(Set) > -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasConfigSet(Named As String) As Boolean
		  For Idx As Integer = 0 To Self.mConfigSets.LastIndex
		    If Self.mConfigSets(Idx).Name = Named Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasEmbeddedContentPacks() As Boolean
		  Return Self.mEmbeddedContentPacks.KeyCount > 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasGuest(Identity As Beacon.Identity) As Boolean
		  If Identity Is Nil Then
		    Return False
		  End If
		  
		  Return Self.HasGuest(Identity.UserId)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasGuest(UserId As String) As Boolean
		  Return Self.mEncryptedPasswords.HasKey(UserId.Lowercase)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IndexOf(Set As Beacon.ConfigSet) As Integer
		  If Set Is Nil Then
		    Return -1
		  End If
		  
		  For Idx As Integer = 0 To Self.mConfigSets.LastIndex
		    If Self.mConfigSets(Idx) = Set Then
		      Return Idx
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function KeepLocalBackup() As Boolean
		  Return Self.mKeepLocalBackup
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub KeepLocalBackup(Assigns Value As Boolean)
		  If Self.mKeepLocalBackup <> Value Then
		    Self.mKeepLocalBackup = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LegacyTrustKey() As String
		  Return Self.mLegacyTrustKey
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function LoadConfigSet(PlainData As Dictionary, EncryptedData As Dictionary) As Dictionary
		  If EncryptedData Is Nil Then
		    EncryptedData = New Dictionary
		  End If
		  
		  Return RaiseEvent LoadConfigSet(PlainData, EncryptedData)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  If Self.mModified Then
		    Return True
		  End If
		  
		  For Each Profile As Beacon.ServerProfile In Self.mServerProfiles
		    If Profile.Modified Then
		      Return True
		    End If
		  Next Profile
		  
		  For Each Set As Beacon.ConfigSet In Self.mConfigSets
		    If Set.Modified Then
		      Return True
		    End If
		  Next
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Self.mModified = Value
		  
		  If Value = False Then
		    For Each Profile As Beacon.ServerProfile In Self.mServerProfiles
		      Profile.Modified = False
		    Next Profile
		    
		    For Each Set As Beacon.ConfigSet In Self.mConfigSets
		      Set.Modified = False
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NewIdentifier()
		  Self.mProjectId = Beacon.UUID.v4
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotifyObservers(Key As String, OldValue As Variant, NewValue As Variant)
		  // Part of the ObservationKit.Observable interface.
		  
		  If Self.mObservers Is Nil Then
		    Return
		  End If
		  
		  Var Refs() As WeakRef
		  If Self.mObservers.HasKey(Key) Then
		    Refs = Self.mObservers.Value(Key)
		  End If
		  
		  For I As Integer = Refs.LastIndex DownTo 0
		    If Refs(I).Value = Nil Then
		      Refs.RemoveAt(I)
		      Continue
		    End If
		    
		    Var Observer As ObservationKit.Observer = ObservationKit.Observer(Refs(I).Value)
		    Observer.ObservedValueChanged(Self, Key, OldValue, NewValue)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.Project) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  If Self.mProjectId = Other.mProjectId Then
		    Return 0
		  End If
		  
		  Var MySort As String = Self.mTitle + ":" + Self.mDescription + ":" + Self.mProjectId
		  Var OtherSort As String = Other.mTitle + ":" + Other.mDescription + ":" + Other.mProjectId
		  Return MySort.Compare(OtherSort, ComparisonOptions.CaseInsensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ProcessEmbeddedContent()
		  Var ContentPacksJson As String = Self.GetFile("Content Packs.json")
		  If ContentPacksJson.IsEmpty Then
		    Return
		  End If
		  
		  Var PackSaveData() As Variant
		  Try
		    PackSaveData = Beacon.ParseJSON(ContentPacksJson)
		  Catch Err As RuntimeException
		    Return
		  End Try
		  
		  Self.mEmbeddedContentPacks = New Dictionary
		  
		  Var DataSource As Beacon.DataSource = Self.DataSource(False)
		  For Each SaveData As Variant In PackSaveData
		    If SaveData.Type <> Variant.TypeObject Or (SaveData.ObjectValue IsA Dictionary) = False Then
		      Continue
		    End If
		    
		    Var Pack As Beacon.ContentPack = Beacon.ContentPack.FromSaveData(Dictionary(SaveData.ObjectValue))
		    If Pack Is Nil Then
		      Continue
		    End If
		    
		    Var Filename As String = Pack.ContentPackId + ".json"
		    Var FileContent As String = Self.GetFile(Filename)
		    If FileContent.IsEmpty Then
		      Continue
		    End If
		    
		    If RaiseEvent ProcessEmbeddedContentPack(Pack, FileContent) Then
		      Self.mEmbeddedContentPacks.Value(Pack.ContentPackId) = Pack
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProjectId() As String
		  Return Self.mProjectId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProviderTokenIds() As String()
		  Var TokenIds() As String
		  For Each Entry As DictionaryEntry In Self.mProviderTokenKeys
		    TokenIds.Add(Entry.Key)
		  Next
		  Return TokenIds
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProviderTokenKey(TokenId As String) As String
		  Return Self.mProviderTokenKeys.Lookup(TokenId, "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ProviderTokenKey(TokenId As String, Assigns Key As String)
		  If Key.IsEmpty Then
		    Self.RemoveProviderTokenKey(TokenId)
		    Return
		  End If
		  
		  If Self.mProviderTokenKeys.HasKey(TokenId) And Self.mProviderTokenKeys.Value(TokenId).StringValue.Compare(Key, ComparisonOptions.CaseSensitive) = 0 Then
		    Return
		  End If
		  
		  Self.mProviderTokenKeys.Value(TokenId) = Key
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProviderTokenKeyCount() As Integer
		  Return Self.mProviderTokenKeys.KeyCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ReadLegacySecureData(SecureDict As Dictionary, Identity As Beacon.Identity, SkipHashVerification As Boolean = False) As Dictionary
		  If Not SecureDict.HasAllKeys("Key", "Vector", "Content", "Hash") Then
		    Return Nil
		  End If
		  
		  Var Key As MemoryBlock = Identity.Decrypt(DecodeHex(SecureDict.Value("Key")))
		  If Key Is Nil Then
		    Return Nil
		  End If
		  
		  Var ExpectedHash As String = SecureDict.Lookup("Hash", "")
		  Var Vector As MemoryBlock = DecodeHex(SecureDict.Value("Vector"))
		  Var Encrypted As MemoryBlock = DecodeHex(SecureDict.Value("Content"))
		  Var Crypt As CipherMBS = CipherMBS.aes_256_cbc
		  If Not Crypt.DecryptInit(BeaconEncryption.FixSymmetricKey(Key, Crypt.KeyLength), Vector) Then
		    Return Nil
		  End If
		  
		  Var Decrypted As String
		  Try
		    Decrypted = Crypt.Process(Encrypted)
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		  
		  If SkipHashVerification = False Then
		    Var ComputedHash As String = Beacon.Hash(Decrypted)
		    If ComputedHash <> ExpectedHash Then
		      Return Nil
		    End If
		  End If
		  
		  If Decrypted = "" Or Not Encodings.UTF8.IsValidData(Decrypted) Then
		    Return Nil
		  End If
		  Decrypted = Decrypted.DefineEncoding(Encodings.UTF8)
		  
		  Var DecryptedDict As Dictionary
		  Try
		    DecryptedDict = Beacon.ParseJSON(Decrypted)
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		  
		  Return DecryptedDict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ReadSaveData(PlainData As Dictionary, EncryptedData As Dictionary, SavedDataVersion As Integer, SavedWithVersion As Integer)
		  RaiseEvent ReadSaveData(PlainData, EncryptedData, SavedDataVersion, SavedWithVersion)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveConfigSet(Set As Beacon.ConfigSet)
		  If Set Is Nil Or Set.IsBase Then
		    Return
		  End If
		  
		  Var Idx As Integer = Self.IndexOf(Set)
		  If Idx = -1 Then
		    Return
		  End If
		  
		  Self.mConfigSets.RemoveAt(Idx)
		  Self.mConfigSetData.Remove(Set.ConfigSetId)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveFile(Filename As String)
		  If Self.mAdditionalFiles.HasKey(Filename) Then
		    Self.mAdditionalFiles.Remove(Filename)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RemoveGuest(Identity As Beacon.Identity) As Boolean
		  If Identity Is Nil Then
		    Return False
		  End If
		  
		  Return Self.RemoveGuest(Identity.UserId)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RemoveGuest(Guest As Beacon.ProjectGuest) As Boolean
		  If Guest Is Nil Then
		    Return False
		  End If
		  
		  Return Self.RemoveGuest(Guest.UserId)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RemoveGuest(UserId As String) As Boolean
		  UserId = UserId.Lowercase
		  If Self.mEncryptedPasswords.HasKey(UserId) Then
		    Self.mEncryptedPasswords.Remove(UserId)
		    Self.Modified = True
		    Return True
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveObserver(Observer As ObservationKit.Observer, Key As String)
		  // Part of the ObservationKit.Observable interface.
		  
		  If Self.mObservers Is Nil Then
		    Return
		  End If
		  
		  Var Refs() As WeakRef
		  If Self.mObservers.HasKey(Key) Then
		    Refs = Self.mObservers.Value(Key)
		  End If
		  
		  For I As Integer = Refs.LastIndex DownTo 0
		    If Refs(I).Value = Nil Or Refs(I).Value = Observer Then
		      Refs.RemoveAt(I)
		      Continue
		    End If
		  Next
		  
		  Self.mObservers.Value(Key) = Refs
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveProviderTokenKey(TokenId As String)
		  If Self.mProviderTokenKeys.HasKey(TokenId) Then
		    Self.mProviderTokenKeys.Remove(TokenId)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveServerProfile(Profile As Beacon.ServerProfile)
		  For Idx As Integer = 0 To Self.mServerProfiles.LastIndex
		    If Self.mServerProfiles(Idx) = Profile Then
		      Self.mServerProfiles.RemoveAt(Idx)
		      Self.Modified = True
		      Return
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RenameConfigSet(Set As Beacon.ConfigSet, NewName As String)
		  Var OldNameIdx As Integer = Self.IndexOf(Set)
		  If OldNameIdx = -1 Then
		    Return
		  End If
		  
		  Set = Self.mConfigSets(OldNameIdx)
		  If Set.Name = NewName Then
		    Return
		  End If
		  
		  If Self.HasConfigSet(NewName) Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "There is already a config set named " + NewName + "."
		    Raise Err
		  End If
		  
		  Set.Name = NewName
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData(Identity As Beacon.Identity, AdditionalProperties As Dictionary = Nil) As MemoryBlock
		  Call Self.AddGuest(Identity) // Adds self, does nothing if nothing is changing
		  
		  Var EncryptedPasswords As New Dictionary
		  For Each Entry As DictionaryEntry In Self.mEncryptedPasswords
		    EncryptedPasswords.Value(Entry.Key) = Beacon.ProjectGuest(Entry.Value).DictionaryValue()
		  Next
		  
		  Var Manifest, ProjectData As Dictionary = New Dictionary // Intentionally assigning both to the same dictionary
		  If Self.mUseCompression Then
		    ProjectData = New Dictionary
		  End If
		  
		  Manifest.Value("version") = Self.SaveDataVersion
		  Manifest.Value("minVersion") = 7
		  Manifest.Value("projectId") = Self.mProjectId
		  Manifest.Value("userId") = Identity.UserId
		  Manifest.Value("name") = Self.mTitle
		  Manifest.Value("description") = Self.mDescription
		  Manifest.Value("gameId") = Self.GameID()
		  Manifest.Value("encryptionKeys") = EncryptedPasswords
		  Manifest.Value("savedWidth") = App.BuildNumber
		  Manifest.Value("timestamp") = DateTime.Now.SecondsFrom1970
		  Manifest.Value("modSelections") = Self.mContentPacks
		  Manifest.Value("isConsole") = Self.mConsoleSafe
		  If Self.mLegacyTrustKey.IsEmpty = False Then
		    Manifest.Value("legacyTrustKey") = Self.mLegacyTrustKey
		  End If
		  
		  Var EncryptedData As New Dictionary
		  RaiseEvent AddSaveData(Manifest, ProjectData, EncryptedData)
		  
		  Self.SaveEmbeddedContent(Manifest)
		  
		  If Self.mServerProfiles.Count > 0 Then
		    Var Profiles() As Dictionary
		    For Each Profile As Beacon.ServerProfile In Self.mServerProfiles
		      Profiles.Add(Profile.SaveData)
		    Next
		    EncryptedData.Value("servers") = Profiles
		  End If
		  
		  Var Sets As New Dictionary
		  Var EncryptedSets As New Dictionary
		  Var Definitions() As Dictionary
		  For Each Set As Beacon.ConfigSet In Self.mConfigSets
		    Definitions.Add(Set.SaveData)
		    
		    Var SetDict As Dictionary = Self.mConfigSetData.Value(Set.ConfigSetId)
		    Var SetPlainData As New Dictionary
		    Var SetEncryptedData As New Dictionary
		    RaiseEvent SaveConfigSet(SetDict, SetPlainData, SetEncryptedData)
		    
		    If SetPlainData.KeyCount > 0 Then
		      Sets.Value(Set.ConfigSetId) = SetPlainData
		      If SetEncryptedData.KeyCount > 0 Then
		        EncryptedSets.Value(Set.ConfigSetId) = SetEncryptedData
		      End If
		    End If
		  Next
		  ProjectData.Value("configSets") = Definitions
		  ProjectData.Value("configSetPriorities") = Beacon.ConfigSetState.EncodeArray(Self.mConfigSetPriorities)
		  
		  ProjectData.Value("configSetData") = Sets
		  If EncryptedSets.KeyCount > 0 Then
		    EncryptedData.Value("configSetData") = EncryptedSets
		  End If
		  
		  If Self.mProviderTokenKeys.KeyCount > 0 Then
		    Var KeysDict As New Dictionary
		    For Each Entry As DictionaryEntry In Self.mProviderTokenKeys
		      KeysDict.Value(Entry.Key) = EncodeBase64(Entry.Value)
		    Next
		    EncryptedData.Value("providerTokenKeys") = KeysDict
		  End If
		  
		  If EncryptedData.KeyCount > 0 Then
		    Var Content As String = Beacon.GenerateJSON(EncryptedData, False)
		    Var Hash As String = Beacon.Hash(Content)
		    If Hash <> Self.mLastSecureHash Then
		      Self.mLastSecureData = Self.Encrypt(Content)
		      Self.mLastSecureHash = Hash
		    End If
		    ProjectData.Value("encryptedData") = Self.mLastSecureData
		  End If
		  
		  If (AdditionalProperties Is Nil) = False And AdditionalProperties.KeyCount > 0 Then
		    ProjectData.Value("otherProperties") = AdditionalProperties
		  End If
		  
		  ProjectData.Value("keepLocalBackup") = Self.mKeepLocalBackup
		  
		  If Self.mUseCompression Then
		    Var Archive As Beacon.Archive = Beacon.Archive.Create()
		    Var AdditionalFiles() As String
		    For Each Entry As DictionaryEntry In Self.mAdditionalFiles
		      Var Filename As String = Entry.Key
		      Var Contents As String = Entry.Value
		      AdditionalFiles.Add(Filename)
		      Archive.AddFile(Filename, Contents)
		    Next
		    Manifest.Value("additionalFiles") = AdditionalFiles
		    Archive.AddFile("Manifest.json", Beacon.GenerateJSON(Manifest, True))
		    Archive.AddFile("v" + Beacon.Project.SaveDataVersion.ToString(Locale.Raw, "0") + ".json", Beacon.GenerateJSON(ProjectData, False))
		    Var ArchiveData As MemoryBlock = Archive.Finalize
		    Var BOM As New MemoryBlock(8)
		    BOM.LittleEndian = ArchiveData.LittleEndian
		    BOM.UInt64Value(0) = If(ArchiveData.LittleEndian, CType(Beacon.Project.BinaryFormatLEBOM, UInt64), CType(Beacon.Project.BinaryFormatBEBOM, UInt64))
		    Return BOM + ArchiveData
		  Else
		    Var AdditionalFiles As New Dictionary
		    For Each Entry As DictionaryEntry In Self.mAdditionalFiles
		      AdditionalFiles.Value(Entry.Key) = EncodeBase64(Beacon.Compress(Entry.Value.StringValue), 0)
		    Next
		    ProjectData.Value("additionalFiles") = AdditionalFiles
		    
		    Return Beacon.GenerateJSON(ProjectData, True)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SaveEmbeddedContent(ManifestData As Dictionary)
		  Var PackSaveData() As Variant
		  Var PackSaveJson As String = Self.GetFile("Content Packs.json")
		  If PackSaveJson.IsEmpty = False Then
		    Try
		      PackSaveData = Beacon.ParseJSON(PackSaveJson)
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  Var PacksCache As New Dictionary
		  Var PackSaveDicts As New Dictionary
		  For Idx As Integer = PackSaveData.LastIndex DownTo 0
		    If PackSaveData(Idx).Type = Variant.TypeObject And PackSaveData(Idx).ObjectValue IsA Dictionary Then
		      Var Pack As Beacon.ContentPack = Beacon.ContentPack.FromSaveData(PackSaveData(Idx))
		      If Pack Is Nil Then
		        PackSaveData.RemoveAt(Idx)
		        Continue
		      End If
		      
		      If Self.ContentPackEnabled(Pack) = False Then
		        PackSaveData.RemoveAt(Idx)
		        Self.RemoveFile(Pack.ContentPackId + ".json")
		        Continue
		      End If
		      
		      PacksCache.Value(Pack.ContentPackId) = Pack
		      PackSaveDicts.Value(Pack.ContentPackId) = PackSaveData(Idx)
		    Else
		      PackSaveData.RemoveAt(Idx)
		    End If
		  Next
		  
		  Var DataSource As Beacon.DataSource = Self.DataSource(False)
		  Var LocalPacks() As Beacon.ContentPack = DataSource.GetContentPacks(Beacon.ContentPack.Types.Custom)
		  For Each LocalPack As Beacon.ContentPack In LocalPacks
		    If Self.ContentPackEnabled(LocalPack) = False Then
		      Continue
		    End If
		    
		    If PacksCache.HasKey(LocalPack.ContentPackId) = True And Beacon.ContentPack(PacksCache.Value(LocalPack.ContentPackId)).LastUpdate >= LocalPack.LastUpdate Then
		      Continue
		    End If
		    
		    Var PackContent As String = RaiseEvent ExportContentPack(LocalPack)
		    If PackContent.IsEmpty = False Then
		      Self.AddFile(LocalPack.ContentPackId + ".json", PackContent)
		      PackSaveDicts.Value(LocalPack.ContentPackId) = LocalPack.SaveData
		    Else
		      Self.RemoveFile(LocalPack.ContentPackId + ".json")
		      If PackSaveDicts.HasKey(LocalPack.ContentPackId) Then
		        PackSaveDicts.Remove(LocalPack.ContentPackId)
		      End If
		    End If
		  Next
		  
		  If PackSaveDicts.KeyCount = 0 Then
		    Self.RemoveFile("Content Packs.json")
		  Else
		    PackSaveData.ResizeTo(-1)
		    For Each Entry As DictionaryEntry In PackSaveDicts
		      PackSaveData.Add(Entry.Value)
		    Next
		    Self.AddFile("Content Packs.json", Beacon.GenerateJSON(PackSaveData, False))
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ServerProfile(Idx As Integer) As Beacon.ServerProfile
		  Return Self.mServerProfiles(Idx)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ServerProfile(Idx As Integer, Assigns Profile As Beacon.ServerProfile)
		  Self.mServerProfiles(Idx) = Profile
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ServerProfile(ProfileId As String) As Beacon.ServerProfile
		  For Each Profile As Beacon.ServerProfile In Self.mServerProfiles
		    If Profile.ProfileID = ProfileId Then
		      Return Profile
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ServerProfileCount() As Integer
		  Return Self.mServerProfiles.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ServerProfiles(Filter As String = "") As Beacon.ServerProfile()
		  Filter = Filter.Trim
		  
		  Var Results() As Beacon.ServerProfile
		  For Each Profile As Beacon.ServerProfile In Self.mServerProfiles
		    If Filter.IsEmpty = False And Profile.Name.IndexOf(Filter) = -1 And Profile.SecondaryName.IndexOf(Filter) = -1 And Profile.Nickname.IndexOf(Filter) = -1 Then
		      Continue
		    End If
		    
		    Results.Add(Profile)
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Title() As String
		  Return Self.mTitle
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Title(Assigns Value As String)
		  If Self.mTitle.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
		    Var OldValue As String = Self.mTitle
		    Self.mTitle = Value
		    Self.Modified = True
		    Self.NotifyObservers("Title", OldValue, Value)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UseCompression() As Boolean
		  Return Self.mUseCompression
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UseCompression(Assigns Value As Boolean)
		  If Self.mUseCompression <> Value Then
		    Self.mUseCompression = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Validate() As Beacon.ProjectValidationResults
		  Var Issues As New Beacon.ProjectValidationResults
		  RaiseEvent Validate(Issues)
		  Return Issues
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event AddingProfile(Profile As Beacon.ServerProfile)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event AdditionalFilesLoaded()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event AddSaveData(ManifestData As Dictionary, PlainData As Dictionary, EncryptedData As Dictionary)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ExportContentPack(Pack As Beacon.ContentPack) As String
	#tag EndHook

	#tag Hook, Flags = &h0
		Event LoadConfigSet(PlainData As Dictionary, EncryptedData As Dictionary) As Dictionary
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ProcessEmbeddedContentPack(Pack As Beacon.ContentPack, FileContent As String) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ReadSaveData(PlainData As Dictionary, EncryptedData As Dictionary, SaveDataVersion As Integer, SavedWithVersion As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SaveComplete()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SaveConfigSet(SetDict As Dictionary, PlainData As Dictionary, EncryptedData As Dictionary)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Validate(Issues As Beacon.ProjectValidationResults)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mActiveConfigSet As Beacon.ConfigSet
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAdditionalFiles As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfigSetData As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfigSetPriorities() As Beacon.ConfigSetState
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfigSets() As Beacon.ConfigSet
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConsoleSafe As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContentPacks As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDescription As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEmbeddedContentPacks As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEncryptedPasswords As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mKeepLocalBackup As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastSecureData As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastSecureHash As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLegacyTrustKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mObservers As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProjectId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProjectPassword As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProviderTokenKeys As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mServerProfiles() As Beacon.ServerProfile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTitle As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUseCompression As Boolean
	#tag EndProperty


	#tag Constant, Name = BinaryFormatBEBOM, Type = Double, Dynamic = False, Default = \"3470482855257601832", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BinaryFormatLEBOM, Type = Double, Dynamic = False, Default = \"2916000471902660912", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SaveDataVersion, Type = Double, Dynamic = False, Default = \"7", Scope = Protected
	#tag EndConstant


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
