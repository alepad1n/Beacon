#tag DesktopWindow
Begin ArkConfigEditor ServersConfigEditor
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composited      =   False
   DoubleBuffer    =   "False"
   Enabled         =   True
   EraseBackground =   "True"
   HasBackgroundColor=   False
   Height          =   506
   Index           =   -2147483648
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   True
   LockLeft        =   True
   LockRight       =   True
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Tooltip         =   ""
   Top             =   0
   Transparent     =   True
   Visible         =   True
   Width           =   856
   Begin ServersListbox ServerList
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   False
      AllowInfiniteScroll=   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   1
      ColumnWidths    =   ""
      DefaultRowHeight=   40
      DefaultSortColumn=   0
      DefaultSortDirection=   1
      DropIndicatorVisible=   False
      EditCaption     =   "Edit"
      Enabled         =   True
      Filter          =   ""
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLineStyle   =   0
      HasBorder       =   False
      HasHeader       =   False
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   0
      Height          =   424
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      PreferencesKey  =   ""
      RequiresSelection=   False
      RowSelectionType=   1
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   82
      Transparent     =   True
      TypeaheadColumn =   0
      Underline       =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   299
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin FadedSeparator FadedSeparator1
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      Enabled         =   True
      Height          =   506
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   299
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   1
   End
   Begin OmniBar ConfigToolbar
      Alignment       =   0
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      BackgroundColor =   ""
      ContentHeight   =   0
      Enabled         =   True
      Height          =   41
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LeftPadding     =   -1
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      RightPadding    =   -1
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   299
   End
   Begin DelayedSearchField FilterField
      Active          =   False
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowRecentItems=   False
      ClearMenuItemValue=   "Clear"
      DelayPeriod     =   250
      Enabled         =   True
      Height          =   22
      Hint            =   "Filter Servers"
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   9
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumRecentItems=   -1
      PanelIndex      =   0
      RecentItemsValue=   "Recent Searches"
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      Tooltip         =   ""
      Top             =   50
      Transparent     =   False
      Visible         =   True
      Width           =   280
      _mIndex         =   0
      _mInitialParent =   ""
      _mName          =   ""
      _mPanelIndex    =   0
   End
   Begin OmniBarSeparator FilterSeparator
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      Enabled         =   True
      Height          =   1
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   81
      Transparent     =   True
      Visible         =   True
      Width           =   299
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Hidden()
		  Var Container As ServerViewContainer = Self.CurrentView
		  If (Container Is Nil) = False Then
		    Container.SwitchedFrom()
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Self.ServerList.UpdateList()
		End Sub
	#tag EndEvent

	#tag Event
		Sub SetupUI()
		  Self.ServerList.UpdateList()
		  Self.UpdateRefreshButton()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant, ByRef FireSetupUI As Boolean)
		  #Pragma Unused FireSetupUI
		  
		  Var Container As ServerViewContainer = Self.CurrentView
		  If (Container Is Nil) = False Then
		    Container.SwitchedTo(UserData)
		  End If
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function CopyMOTDToAllServers() As Boolean Handles CopyMOTDToAllServers.Action
		  If Self.IsFrontmost = False Then
		    Return False
		  End If
		  
		  Var CurrentProfileID As String = Self.CurrentProfileID
		  If CurrentProfileID.IsEmpty Then
		    Return True
		  End If
		  Self.CurrentProfileID = ""
		  
		  Var SourceProfile As Ark.ServerProfile
		  Var Bound As Integer = Self.Project.ServerProfileCount - 1
		  For Idx As Integer = 0 To Bound
		    If Self.Project.ServerProfile(Idx).ProfileID = CurrentProfileID And Self.Project.ServerProfile(Idx) IsA Ark.ServerProfile Then
		      SourceProfile = Ark.ServerProfile(Self.Project.ServerProfile(Idx))
		      Exit
		    End If
		  Next
		  
		  If SourceProfile Is Nil Then
		    Self.CurrentProfileID = CurrentProfileID
		    Return True
		  End If
		  
		  Var Message As Ark.ArkML = SourceProfile.MessageOfTheDay
		  Var Duration As Integer = SourceProfile.MessageDuration
		  
		  For Idx As Integer = 0 To Bound
		    If Self.Project.ServerProfile(Idx).ProfileID <> CurrentProfileID And Self.Project.ServerProfile(Idx) IsA Ark.ServerProfile Then
		      Ark.ServerProfile(Self.Project.ServerProfile(Idx)).MessageOfTheDay = Message.Clone
		      Ark.ServerProfile(Self.Project.ServerProfile(Idx)).MessageDuration = Duration
		      Self.Modified = Self.Modified Or Self.Project.Modified
		    End If
		  Next
		  
		  Self.CurrentProfileID = CurrentProfileID
		  Return True
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h0
		Sub Constructor(Project As Ark.Project)
		  Self.mViews = New Dictionary
		  Super.Constructor(Project)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Engine_Discovered(Sender As Ark.IntegrationEngine, Data() As Beacon.DiscoveredData)
		  #Pragma Unused Sender
		  
		  Var Profiles As New Dictionary
		  Var AllProfiles() As Beacon.ServerProfile = Self.Project.ServerProfiles
		  For Each Profile As Beacon.ServerProfile In AllProfiles
		    Var ServiceId As Variant = Profile.ProviderServiceID
		    If IsNull(ServiceId) Then
		      Continue
		    End If
		    
		    Profiles.Value(ServiceId) = Profile
		  Next
		  
		  For Each DiscoveredData As Beacon.DiscoveredData In Data
		    Var DiscoveredProfile As Beacon.ServerProfile = DiscoveredData.Profile
		    Var ServiceId As Variant = DiscoveredProfile.ProviderServiceID
		    If IsNull(ServiceId) Or Profiles.HasKey(ServiceId) = False Then
		      Continue
		    End If
		    
		    Var ProjectProfile As Beacon.ServerProfile = Profiles.Value(ServiceId)
		    ProjectProfile.UpdateDetailsFrom(DiscoveredProfile)
		  Next
		  Self.Modified = Self.Project.Modified
		  
		  Var AllFinished As Boolean = True
		  For Each Entry As DictionaryEntry In Self.mEngines
		    Var Engine As Ark.IntegrationEngine = Entry.Value
		    
		    If Engine.Finished = False Then
		      AllFinished = False
		    End If
		  Next
		  
		  If AllFinished Then
		    Self.FinishRefreshingDetails()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Engine_Wait(Sender As Ark.IntegrationEngine, Controller As Beacon.TaskWaitController) As Boolean
		  #Pragma Unused Sender
		  
		  Select Case Controller.Action
		  Case "Auth External"
		    Var Profile As Ark.ServerProfile = Sender.Profile
		    Var Account As Beacon.ExternalAccount = Self.Project.Accounts.GetByUUID(Profile.ExternalAccountUUID)
		    If (Account Is Nil) = False Then
		      Self.ShowAlert("Authorization Expired", "Authorization for " + Account.Provider + " account '" + Account.Label + "' has expired. Please select a server which belongs to the account to refresh authorization.")
		    Else
		      Call ShowAlert("Authorization Expired", "The authorization for an unknown account has expired. It may be necessary to import again.")
		    End If
		  End Select
		  
		  Controller.ShouldResume = True
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub FinishRefreshingDetails()
		  Self.mRefreshing = False
		  Self.UpdateRefreshButton()
		  Self.ServerList.UpdateList()
		  
		  Var Explanation As String = "The information shown in the list is the most up-to-date Beacon has available."
		  If Self.Modified Then
		    Explanation = Explanation + " Don't forget to save your project."
		  End If 
		  Self.ShowAlert("Server Refresh Finished", Explanation)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleViewMenu(ItemRect As Rect)
		  Var Base As New DesktopMenuItem
		  
		  Var ViewFullNames As New DesktopMenuItem("Use Full Server Names", ServersListbox.NamesFull)
		  Var ViewAbbreviatedNames As New DesktopMenuItem("Use Abbreviated Server Names", ServersListbox.NamesAbbreviated)
		  Var SortByName As New DesktopMenuItem("Sort By Name", ServersListbox.SortByName)
		  Var SortByAddress As New DesktopMenuItem("Sort By Address", ServersListbox.SortByAddress)
		  Var SortByColor As New DesktopMenuItem("Sort By Color", ServersListbox.SortByColor)
		  Var ShowServerIds As New DesktopMenuItem("Show Server Ids")
		  ViewFullNames.HasCheckMark = Preferences.ServersListNameStyle = ServersListbox.NamesFull
		  ViewAbbreviatedNames.HasCheckMark = Preferences.ServersListNameStyle = ServersListbox.NamesAbbreviated
		  SortByName.HasCheckMark = Preferences.ServersListSortedValue = ServersListbox.SortByName
		  SortByAddress.HasCheckMark = Preferences.ServersListSortedValue = ServersListbox.SortByAddress
		  SortByColor.HasCheckMark = Preferences.ServersListSortedValue = ServersListbox.SortByColor
		  ShowServerIds.HasCheckMark = Preferences.ServersListShowIds
		  Base.AddMenu(ViewFullNames)
		  Base.AddMenu(ViewAbbreviatedNames)
		  Base.AddMenu(New DesktopMenuItem(MenuItem.TextSeparator))
		  Base.AddMenu(SortByName)
		  Base.AddMenu(SortByAddress)
		  Base.AddMenu(SortByColor)
		  Base.AddMenu(New DesktopMenuItem(MenuItem.TextSeparator))
		  Base.AddMenu(ShowServerIds)
		  
		  Var Position As Point = Self.ConfigToolbar.GlobalPosition
		  Var Choice As DesktopMenuItem = Base.PopUp(Position.X + ItemRect.Left, Position.Y + ItemRect.Bottom)
		  If Choice Is Nil Then
		    Return
		  End If
		  
		  Select Case Choice
		  Case ViewFullNames, ViewAbbreviatedNames
		    Preferences.ServersListNameStyle = Choice.Tag.StringValue
		    Self.ServerList.UpdateList()
		  Case SortByName, SortByAddress, SortByColor
		    Preferences.ServersListSortedValue = Choice.Tag.StringValue
		    Self.ServerList.UpdateList()
		  Case ShowServerIds
		    Preferences.ServersListShowIds = Not Preferences.ServersListShowIds
		    Self.ServerList.UpdateList()
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InternalName() As String
		  Return Ark.Configs.NameServersPseudo
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RefreshDetails()
		  If Self.mRefreshing = True Then
		    Return
		  End If
		  
		  Var Accounts() As Beacon.ExternalAccount = Self.Project.Accounts.All
		  Var Engines As New Dictionary
		  For Each Account As Beacon.ExternalAccount In Accounts
		    Var Engine As Ark.IntegrationEngine
		    
		    Select Case Account.Provider
		    Case Beacon.ExternalAccount.ProviderNitrado
		      Var Profile As New Ark.NitradoServerProfile
		      Profile.ExternalAccountUUID = Account.UUID
		      
		      Engine = New Ark.NitradoIntegrationEngine(Profile)
		    Case Beacon.ExternalAccount.ProviderGameServerApp
		      Engine = New Ark.GSAIntegrationEngine(Account)
		    End Select
		    
		    If Engine Is Nil Then
		      Continue
		    End If
		    
		    Engines.Value(Account.UUID.StringValue) = Engine
		    AddHandler Engine.Discovered, WeakAddressOf Engine_Discovered
		    AddHandler Engine.Wait, WeakAddressOf Engine_Wait
		    Engine.BeginDiscovery(Self.Project)
		  Next
		  Self.mEngines = Engines
		  Self.mRefreshing = True
		  Self.UpdateRefreshButton()
		  
		  If Self.mEngines.KeyCount = 0 Then
		    Self.FinishRefreshingDetails()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateRefreshButton()
		  If Self.ConfigToolbar Is Nil Then
		    Return
		  End If
		  
		  Var RefreshButton As OmniBarItem = Self.ConfigToolbar.Item("RefreshButton")
		  If RefreshButton Is Nil Then
		    Return
		  End If
		  
		  RefreshButton.HasProgressIndicator = Self.mRefreshing
		  RefreshButton.Progress = OmniBarItem.ProgressIndeterminate
		  RefreshButton.ActiveColor = If(Self.mRefreshing, OmniBarItem.ActiveColors.Blue, OmniBarItem.ActiveColors.Accent)
		  RefreshButton.AlwaysUseActiveColor = Self.mRefreshing
		  RefreshButton.Enabled = Self.mRefreshing = False And Self.Project.ServerProfileCount > 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub View_ContentsChanged(Sender As ServerViewContainer)
		  Self.Modified = Sender.Modified
		  Self.ServerList.UpdateList()
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ShouldDeployProfiles(SelectedProfiles() As Beacon.ServerProfile)
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mCurrentProfileID
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mCurrentProfileID = Value Then
			    Return
			  End If
			  
			  If Self.mCurrentProfileID <> "" Then
			    Var View As ServerViewContainer = Self.mViews.Value(Self.mCurrentProfileID)
			    View.Visible = False
			    View.SwitchedFrom()
			    Self.mCurrentProfileID = ""
			  End If
			  
			  If Not Self.mViews.HasKey(Value) Then
			    Return
			  End If
			  
			  Var View As ServerViewContainer = Self.mViews.Value(Value)
			  View.SwitchedTo()
			  View.Visible = True
			  Self.mCurrentProfileID = Value
			End Set
		#tag EndSetter
		CurrentProfileID As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.mViews.HasKey(Self.mCurrentProfileID) Then
			    Return ServerViewContainer(Self.mViews.Value(Self.mCurrentProfileID))
			  End If
			End Get
		#tag EndGetter
		CurrentView As ServerViewContainer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mCurrentProfileID As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEngines As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRefreshing As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mViews As Dictionary
	#tag EndProperty


#tag EndWindowCode

#tag Events ServerList
	#tag Event
		Sub SelectionChanged()
		  Select Case Me.SelectedRowCount
		  Case 0
		    Self.CurrentProfileID = ""
		    Return
		  Case 1
		    Var Profile As Ark.ServerProfile = Me.RowTagAt(Me.SelectedRowIndex)
		    Var ProfileID As String = Profile.ProfileID
		    If Not Self.mViews.HasKey(ProfileID) Then
		      // Create the view
		      Var View As ServerViewContainer
		      Select Case Profile
		      Case IsA Ark.NitradoServerProfile
		        View = New NitradoServerView(Self.Project, Ark.NitradoServerProfile(Profile))
		      Case IsA Ark.FTPServerProfile
		        View = New FTPServerView(Self.Project, Ark.FTPServerProfile(Profile))
		      Case IsA Ark.ConnectorServerProfile
		        View = New ConnectorServerView(Ark.ConnectorServerProfile(Profile))
		      Case IsA Ark.LocalServerProfile
		        View = New LocalServerView(Self.Project, Ark.LocalServerProfile(Profile))
		      Case IsA Ark.GSAServerProfile
		        View = New GSAServerView(Self.Project, Ark.GSAServerProfile(Profile))
		      Else
		        Self.CurrentProfileID = ""
		        Return
		      End Select
		      
		      View.EmbedWithin(Self, FadedSeparator1.Left + FadedSeparator1.Width, FadedSeparator1.Top, Self.Width - (FadedSeparator1.Left + FadedSeparator1.Width), FadedSeparator1.Height)
		      AddHandler View.ContentsChanged, WeakAddressOf View_ContentsChanged
		      Self.mViews.Value(ProfileID) = View
		    End If
		    Self.CurrentProfileID = ProfileID
		  Else
		    Var Profiles() As Ark.ServerProfile
		    Var Parts() As String
		    For Idx As Integer = 0 To Me.LastRowIndex
		      If Not Me.RowSelectedAt(Idx) Then
		        Continue
		      End If
		      
		      Profiles.Add(Me.RowTagAt(Idx))
		      Parts.Add(Profiles(Profiles.LastIndex).ProfileID)
		    Next
		    
		    Var ProfileID As String = Parts.Join(",")
		    If Not Self.mViews.HasKey(ProfileID) Then
		      Var View As New MultiServerView(Self.Project, Profiles)
		      View.EmbedWithin(Self, FadedSeparator1.Left + FadedSeparator1.Width, FadedSeparator1.Top, Self.Width - (FadedSeparator1.Left + FadedSeparator1.Width), FadedSeparator1.Height)
		      AddHandler View.ContentsChanged, WeakAddressOf View_ContentsChanged
		      Self.mViews.Value(ProfileID) = View
		    End If
		    
		    Self.CurrentProfileID = ProfileID
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Var SelCount As Integer = Me.SelectedRowCount
		  If SelCount = 0 Then
		    Return
		  End If
		  
		  If Warn Then
		    Var Subject As String = If(SelCount = 1, "server", "servers")
		    Var DemonstrativeAdjective As String = If(SelCount = 1, "this", "these " + SelCount.ToString)
		    If Not Self.ShowConfirm("Are you sure you want to delete " + DemonstrativeAdjective + " " + Subject + "?", "The " + Subject + " can be added again later using the ""Import"" feature next to the ""Config Type"" menu.", "Delete", "Cancel") Then
		      Return
		    End If
		  End If
		  
		  For I As Integer = Me.LastRowIndex DownTo 0
		    If Me.RowSelectedAt(I) Then
		      Var Profile As Ark.ServerProfile = Me.RowTagAt(I)
		      If Self.mViews.HasKey(Profile.ProfileID) Then
		        If Self.CurrentProfileID = Profile.ProfileID Then
		          Self.CurrentProfileID = ""
		        End If
		        
		        Var Panel As ServerViewContainer = Self.mViews.Value(Profile.ProfileID)
		        Panel.Close
		        Self.mViews.Remove(Profile.ProfileID)
		      End If
		      Self.Project.RemoveServerProfile(Profile)
		      Self.Modified = True
		      Me.RemoveRowAt(I)
		    End If
		  Next
		  
		  Self.UpdateRefreshButton()
		End Sub
	#tag EndEvent
	#tag Event
		Function ConstructContextualMenu(Base As DesktopMenuItem, X As Integer, Y As Integer) As Boolean
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  Var CopyProfileMenuItem As New DesktopMenuItem("Copy Profile ID")
		  CopyProfileMenuItem.Enabled = False
		  Base.AddMenu(CopyProfileMenuItem)
		  
		  Var DeployItem As DesktopMenuItem
		  If Me.SelectedRowCount > 1 Then
		    DeployItem = New DesktopMenuItem("Deploy These Servers…")
		  Else
		    DeployItem = New DesktopMenuItem("Deploy This Server…")
		  End If
		  Var DeployProfiles() As Beacon.ServerProfile
		  Var NitradoProfiles() As Ark.NitradoServerProfile
		  Var LocalProfiles() As Ark.LocalServerProfile
		  For Idx As Integer = 0 To Me.LastRowIndex
		    If Me.RowSelectedAt(Idx) = False Then
		      Continue
		    End If
		    Var Profile As Ark.ServerProfile = Me.RowTagAt(Idx)
		    If Profile.DeployCapable Then
		      DeployProfiles.Add(Profile)
		    End If
		    If Profile IsA Ark.NitradoServerProfile Then
		      NitradoProfiles.Add(Ark.NitradoServerProfile(Profile))
		    End If
		    If Profile IsA Ark.LocalServerProfile Then
		      LocalProfiles.Add(Ark.LocalServerProfile(Profile))
		    End If
		  Next Idx
		  DeployItem.Enabled = DeployProfiles.Count > 0
		  DeployItem.Tag = DeployProfiles
		  Base.AddMenu(DeployItem)
		  
		  Var BackupsItem As New DesktopMenuItem("Show Config Backups")
		  Base.AddMenu(BackupsItem)
		  
		  If NitradoProfiles.Count > 0 Then
		    Base.AddMenu(New DesktopMenuItem("Open Nitrado Dashboard", NitradoProfiles))
		  End If
		  
		  If LocalProfiles.Count > 0 Then
		    #if Not TargetMacOS
		      // Sandbox prevents this from working on macOS
		      Base.AddMenu(New DesktopMenuItem("Show Config Files", LocalProfiles))
		    #endif
		  End If
		  
		  If Me.SelectedRowCount = 1 Then
		    Var Profile As Ark.ServerProfile = Me.RowTagAt(Me.SelectedRowIndex)
		    CopyProfileMenuItem.Tag = Profile.ProfileID.Left(8)
		    CopyProfileMenuItem.Enabled = True
		    
		    BackupsItem.Tag = App.BackupsFolder.Child(Profile.BackupFolderName)
		  Else
		    BackupsItem.Tag = App.BackupsFolder
		  End If
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuItemSelected(HitItem As DesktopMenuItem) As Boolean
		  Select Case HitItem.Text
		  Case "Show Config Backups"
		    Var Folder As FolderItem = HitItem.Tag
		    If Folder = Nil Then
		      Return True
		    End If
		    If Not Folder.Exists Then
		      Folder.CreateFolder
		    End If
		    Folder.Open
		  Case "Copy Profile ID"
		    Var ProfileID As String = HitItem.Tag
		    Var Board As New Clipboard
		    Board.Text = ProfileID
		  Case "Deploy These Servers…", "Deploy This Server…"
		    Var SelectedProfiles() As Beacon.ServerProfile = HitItem.Tag
		    RaiseEvent ShouldDeployProfiles(SelectedProfiles)
		  Case "Open Nitrado Dashboard"
		    Var NitradoProfiles() As Ark.NitradoServerProfile = HitItem.Tag
		    For Idx As Integer = 0 To NitradoProfiles.LastIndex
		      System.GotoURL(Beacon.WebURL("/redirect?destination=nitradodash&serviceid=" + NitradoProfiles(Idx).ServiceID.ToString(Locale.Raw, "0")))
		    Next Idx
		  Case "Show Config Files"
		    Var LocalProfiles() As Ark.LocalServerProfile = HitItem.Tag
		    For Idx As Integer = 0 To LocalProfiles.LastIndex
		      Var File As FolderItem = LocalProfiles(Idx).GameIniFile
		      If File Is Nil Or File.Exists = False Then
		        File = LocalProfiles(Idx).GameUserSettingsIniFile
		      End If
		      If (File Is Nil) = False And File.Exists Then
		        File.Parent.Open
		      End If
		    Next Idx
		  End Select
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Function GetProject() As Beacon.Project
		  Return Self.Project
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events ConfigToolbar
	#tag Event
		Sub Opening()
		  Me.Append(OmniBarItem.CreateTitle("ConfigTitle", Self.ConfigLabel))
		  Me.Append(OmniBarItem.CreateSeparator("ConfigTitleSeparator"))
		  Me.Append(OmniBarItem.CreateButton("AddServerButton", "New Server", IconToolbarAdd, "Add a new simple server."))
		  Me.Append(OmniBarItem.CreateFlexibleSpace)
		  Me.Append(OmniBarItem.CreateButton("RefreshButton", "Refresh", IconToolbarRefresh, "Refresh server details.", Self.Project.ServerProfileCount > 0))
		  Me.Append(OmniBarItem.CreateButton("ViewOptionsButton", "View", IconToolbarView, "Change server list view options."))
		  
		  Me.Item("ConfigTitle").Priority = 5
		  Me.Item("ConfigTitleSeparator").Priority = 5
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  Select Case Item.Name
		  Case "AddServerButton"
		    Var Profile As New Ark.LocalServerProfile
		    Profile.Name = "An Ark Server"
		    
		    Self.Project.AddServerProfile(Profile)
		    Self.ServerList.UpdateList(Profile, True)
		    Self.UpdateRefreshButton()
		  Case "ViewOptionsButton"
		    Self.HandleViewMenu(ItemRect)
		  Case "RefreshButton"
		    Self.RefreshDetails()
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Function ItemHeld(Item As OmniBarItem, ItemRect As Rect) As Boolean
		  Select Case Item.Name
		  Case "ViewOptionsButton"
		    Self.HandleViewMenu(ItemRect)
		    Return True
		  End Select
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events FilterField
	#tag Event
		Sub TextChanged()
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Self.ServerList.Filter = Me.Text.Trim
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Modified"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composited"
		Visible=true
		Group="Window Behavior"
		InitialValue="False"
		Type="Boolean"
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
		Name="IsFrontmost"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ViewTitle"
		Visible=true
		Group="Behavior"
		InitialValue="Untitled"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ViewIcon"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Progress"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Double"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Tooltip"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowAutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowFocusRing"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="ColorGroup"
		EditorType="ColorGroup"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowFocus"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Behavior"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Behavior"
		InitialValue="300"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="InitialParent"
		Visible=false
		Group="Position"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
		Visible=false
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabStop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="CurrentProfileID"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
#tag EndViewBehavior
