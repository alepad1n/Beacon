#tag Window
Begin DocumentsComponentView CloudDocumentsComponent Implements NotificationKit.Receiver
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   DoubleBuffer    =   True
   Enabled         =   True
   EraseBackground =   True
   HasBackgroundColor=   False
   Height          =   508
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
   Width           =   804
   Begin PagePanel Pages
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   508
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   5
      Panels          =   ""
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   804
      Begin ProgressBar LoadingProgressBar
         AllowAutoDeactivate=   True
         Enabled         =   True
         Height          =   20
         Indeterminate   =   True
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   277
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumValue    =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   256
         Transparent     =   False
         Value           =   0.0
         Visible         =   True
         Width           =   250
      End
      Begin Label LoadingLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   277
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   232
         Transparent     =   False
         Underline       =   False
         Value           =   "Loading projects…"
         Visible         =   True
         Width           =   250
      End
      Begin DocumentFilterControl FilterBar
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF00
         ConsoleSafe     =   False
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   True
         HasBackgroundColor=   False
         Height          =   62
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Mask            =   ""
         RequireAllMaps  =   False
         Scope           =   2
         SearchDelayPeriod=   250
         ShowFullControls=   True
         TabIndex        =   0
         TabPanelIndex   =   4
         TabStop         =   True
         Tooltip         =   ""
         Top             =   0
         Transparent     =   True
         Visible         =   True
         Width           =   804
      End
      Begin BeaconListbox List
         AllowAutoDeactivate=   True
         AllowAutoHideScrollbars=   True
         AllowExpandableRows=   False
         AllowFocusRing  =   False
         AllowInfiniteScroll=   False
         AllowResizableColumns=   False
         AllowRowDragging=   False
         AllowRowReordering=   False
         Bold            =   False
         ColumnCount     =   6
         ColumnWidths    =   "46,2*,*,100,70,220"
         DataField       =   ""
         DataSource      =   ""
         DefaultRowHeight=   26
         DefaultSortColumn=   "#ColumnUpdated"
         DefaultSortDirection=   -1
         DropIndicatorVisible=   False
         EditCaption     =   "Open"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         GridLinesHorizontalStyle=   0
         GridLinesVerticalStyle=   0
         HasBorder       =   False
         HasHeader       =   True
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
         HeadingIndex    =   -1
         Height          =   445
         Index           =   -2147483648
         InitialParent   =   "Pages"
         InitialValue    =   " 	Name	Map	Console Safe	Revision	Last Updated"
         Italic          =   False
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         PreferencesKey  =   "Cloud Documents"
         RequiresSelection=   False
         RowSelectionType=   1
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   4
         TabStop         =   True
         Tooltip         =   ""
         Top             =   63
         Transparent     =   False
         TypeaheadColumn =   "#ColumnName"
         Underline       =   False
         Visible         =   True
         VisibleRowCount =   0
         Width           =   804
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin Label LoginMessageLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   213
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Looks like there was a problem signing you in."
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   228
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   379
      End
      Begin UITweaks.ResizedPushButton LoginActionButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Log In"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   362
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   260
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin Label PermissionMessageLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   75
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "Your cloud features are disabled. Turn them on to access projects stored in the cloud."
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   228
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   655
      End
      Begin UITweaks.ResizedPushButton PermissionActionButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Turn On"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   362
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   260
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin Label ErrorMessageLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   74
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   5
         TabStop         =   True
         Text            =   "There was an error loading your cloud projects."
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   212
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   655
      End
      Begin UITweaks.ResizedPushButton ErrorActionButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Try Again"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   357
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   5
         TabStop         =   True
         Tooltip         =   ""
         Top             =   276
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   90
      End
      Begin Label ErrorExplanationLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Italic          =   False
         Left            =   74
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   2
         TabPanelIndex   =   5
         TabStop         =   True
         Text            =   "This is a placeholder"
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   244
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   655
      End
      Begin FadedSeparator FadedSeparator1
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         ContentHeight   =   0
         DoubleBuffer    =   False
         Enabled         =   True
         Height          =   1
         Index           =   -2147483648
         InitialParent   =   "Pages"
         Left            =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   1
         TabPanelIndex   =   4
         TabStop         =   True
         Tooltip         =   ""
         Top             =   62
         Transparent     =   True
         Visible         =   True
         Width           =   804
      End
   End
   Begin BeaconAPI.Socket APISocket
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Close()
		  If Self.mVersionProgressKey.IsEmpty = False Then
		    CallLater.Cancel(Self.mVersionProgressKey)
		    Self.mVersionProgressKey = ""
		  End If
		  
		  If (Self.mVersionProgress Is Nil) = False Then
		    Self.mVersionProgress.Close
		    Self.mVersionProgress = Nil
		  End If
		  
		  NotificationKit.Ignore(Self, IdentityManager.Notification_IdentityChanged, Preferences.Notification_OnlineStateChanged, Preferences.Notification_OnlineTokenChanged)
		  
		  RaiseEvent Close
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  NotificationKit.Watch(Self, IdentityManager.Notification_IdentityChanged, Preferences.Notification_OnlineStateChanged, Preferences.Notification_OnlineTokenChanged)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resize(Initial As Boolean)
		  #Pragma Unused Initial
		  
		  Var LoadingGroup As New ControlGroup(Self.LoadingLabel, Self.LoadingProgressBar)
		  LoadingGroup.Left = (Self.Width - LoadingGroup.Width) / 2
		  LoadingGroup.Top = (Self.Height - LoadingGroup.Height) / 2
		  
		  Var LoginGroup As New ControlGroup(Self.LoginMessageLabel, Self.LoginActionButton)
		  LoginGroup.Left = (Self.Width - LoginGroup.Width) / 2
		  LoginGroup.Top = (Self.Height - LoginGroup.Height) / 2
		  
		  Var PermissionGroup As New ControlGroup(Self.PermissionMessageLabel, Self.PermissionActionButton)
		  PermissionGroup.Left = (Self.Width - PermissionGroup.Width) / 2
		  PermissionGroup.Top = (Self.Height - PermissionGroup.Height) / 2
		  
		  Var ErrorGroup As New ControlGroup(Self.ErrorMessageLabel, Self.ErrorExplanationLabel, Self.ErrorActionButton)
		  ErrorGroup.Left = (Self.Width - ErrorGroup.Width) / 2
		  ErrorGroup.Top = (Self.Height - ErrorGroup.Height) / 2
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown(UserData As Variant = Nil)
		  #Pragma Unused UserData
		  
		  Self.RefreshList()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub APICallback_DeleteDocument(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  If Response.Success Then
		    // Remove from recents
		    Var Recents() As Beacon.ProjectURL = Preferences.RecentDocuments
		    Var Changed As Boolean
		    For Idx As Integer = Recents.LastIndex DownTo 0
		      If Recents(Idx).URL(Beacon.ProjectURL.URLTypes.Writing) = Request.URL Then
		        Recents.RemoveAt(Idx)
		        Changed = True
		      End If
		    Next
		    If Changed Then
		      Preferences.RecentDocuments = Recents
		    End If
		    
		    Return
		  End If
		  
		  Var Message As String = Response.Message
		  If Message.IsEmpty Then
		    Message = "An unknown error occurred."
		  End If
		  
		  Self.ShowAlert("A project was not deleted.", Message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_ListDocuments(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  Self.mRefreshing = False
		  
		  If Response.HTTPStatus = 401 Then
		    Self.Pages.SelectedPanelIndex = Self.PageLogin
		    Return
		  End If
		  
		  Self.UpdateList(Response)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_ListVersions(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  If Self.mVersionProgressKey.IsEmpty = False Then
		    CallLater.Cancel(Self.mVersionProgressKey)
		    Self.mVersionProgressKey = ""
		  End If
		  
		  If (Self.mVersionProgress Is Nil) = False Then
		    Var Cancel As Boolean = Self.mVersionProgress.CancelPressed
		    Self.mVersionProgress.Close
		    Self.mVersionProgress = Nil
		    If Cancel Then
		      Return
		    End If
		  End If
		  
		  If Response.Success = False Then
		    If Response.HTTPStatus = 0 Then
		      Self.ShowAlert("Could not list versions due to a connection error", Response.Message)
		      Return
		    End If
		    
		    If Response.Message.IsEmpty = False Then
		      Self.ShowAlert("Could not list versions", Response.Message)
		    Else
		      Self.ShowAlert("Could not list versions", "There was an HTTP " + Response.HTTPStatus.ToString(Locale.Current, "0") + " error.")
		    End If
		    Return
		  End If
		  
		  If Not Response.JSONParsed Then
		    Self.ShowAlert("Could not list versions", "The server replied with something that is not JSON.")
		    Return
		  End If
		  
		  Var Parsed As Variant = Response.JSON
		  Var Versions() As Dictionary
		  Try
		    Versions = Parsed.DictionaryArrayValue
		  Catch Err As RuntimeException
		    Self.ShowAlert("Could not find any older versions", "There are no older versions of this project available.")
		    Return
		  End Try
		  
		  DocumentVersionListWindow.Present(Self, Versions)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case IdentityManager.Notification_IdentityChanged, Preferences.Notification_OnlineStateChanged, Preferences.Notification_OnlineTokenChanged
		    Self.RefreshList()
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RefreshList()
		  If Self.mRefreshing Then
		    Return
		  End If
		  
		  If Preferences.OnlineEnabled = False Or App.IdentityManager.CurrentIdentity Is Nil Then
		    Self.Pages.SelectedPanelIndex = Self.PagePermission
		    Return
		  End If
		  
		  Var Params As New Dictionary
		  Params.Value("user_id") = App.IdentityManager.CurrentIdentity.UserID
		  
		  Var Request As New BeaconAPI.Request("project", "GET", Params, AddressOf APICallback_ListDocuments)
		  Request.Authenticate(Preferences.OnlineToken)
		  Self.APISocket.Start(Request)
		  
		  Self.Pages.SelectedPanelIndex = Self.PageLoading
		  Self.mRefreshing = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowVersionProgress()
		  Self.mVersionProgressKey = ""
		  
		  Var Progress As New ProgressWindow("Finding older versions…", "Just a moment…")
		  Progress.ShowWithin(Self.TrueWindow)
		  Self.mVersionProgress = Progress
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateFilter()
		  Var SelectedDocuments() As String
		  For I As Integer = 0 To Self.List.LastRowIndex
		    If Self.List.Selected(I) Then
		      Var Document As BeaconAPI.Document = Self.List.RowTagAt(I)
		      SelectedDocuments.Add(Document.ResourceURL)
		    End If
		  Next
		  
		  Var SearchText As String = Self.FilterBar.SearchText
		  Var Mask As UInt64 = Self.FilterBar.Mask
		  Var ConsoleSafe As Boolean = Self.FilterBar.ConsoleSafe
		  Var RequireAllMaps As Boolean = Self.FilterBar.RequireAllMaps
		  Var FilteredDocuments() As BeaconAPI.Document
		  
		  For Each Document As BeaconAPI.Document In Self.mDocuments
		    If ConsoleSafe = True And Document.ConsoleSafe = False Then
		      Continue
		    End If
		    
		    If Mask > CType(0, UInt64) And ((RequireAllMaps And (Document.MapMask And Mask) <> Mask) Or (RequireAllMaps = False And (Document.MapMask And Mask) = CType(0, UInt64))) Then
		      Continue
		    End If
		    
		    If Document.Name.IndexOf(SearchText) = -1 Then
		      Continue
		    End If
		    
		    FilteredDocuments.Add(Document)
		  Next
		  
		  Self.List.RowCount = FilteredDocuments.Count
		  
		  For I As Integer = 0 To FilteredDocuments.LastIndex
		    Var Document As BeaconAPI.Document = FilteredDocuments(I)
		    
		    Self.List.CellValueAt(I, Self.ColumnName) = Document.Name
		    Self.List.CellValueAt(I, Self.ColumnMaps) = Ark.Maps.ForMask(Document.MapMask).Label
		    Self.List.CellValueAt(I, Self.ColumnConsole) = If(Document.ConsoleSafe, "Yes", "")
		    Self.List.CellValueAt(I, Self.ColumnUpdated) = Document.LastUpdated(TimeZone.Current).ToString(Locale.Current, DateTime.FormatStyles.Medium, DateTime.FormatStyles.Medium)
		    Self.List.CellValueAt(I, Self.ColumnRevision) = Document.Revision.ToString(Locale.Current, ",##0")
		    Self.List.RowTagAt(I) = Document
		    Self.List.Selected(I) = SelectedDocuments.IndexOf(Document.ResourceURL) > -1
		  Next
		  
		  Self.List.Sort
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(Response As BeaconAPI.Response)
		  Self.mDocuments.ResizeTo(-1)
		  
		  If Response.Success = False Then
		    Self.Pages.SelectedPanelIndex = Self.PageError
		    Self.ErrorExplanationLabel.Text = Response.Message
		    Return
		  End If
		  
		  Var Dicts() As Variant = Response.JSON
		  For Each Dict As Dictionary In Dicts
		    Var Document As New BeaconAPI.Document(Dict)
		    Self.mDocuments.Add(Document)
		  Next
		  
		  Self.UpdateFilter()
		  Self.Pages.SelectedPanelIndex = Self.PageList
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function URLForDocument(Document As BeaconAPI.Document) As Beacon.ProjectURL
		  Return Beacon.ProjectURL.TypeCloud + "://" + Document.ResourceURL.Middle(Document.ResourceURL.IndexOf("://") + 3)
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Close()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mDocuments() As BeaconAPI.Document
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRefreshing As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mVersionProgress As ProgressWindow
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mVersionProgressKey As String
	#tag EndProperty


	#tag Constant, Name = ColumnConsole, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnIcon, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnMaps, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnName, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnRevision, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnUpdated, Type = Double, Dynamic = False, Default = \"5", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageError, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageList, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageLoading, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageLogin, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PagePermission, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events FilterBar
	#tag Event
		Sub Changed()
		  Self.UpdateFilter
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  Me.Mask = Ark.Maps.UniversalMask
		End Sub
	#tag EndEvent
	#tag Event
		Sub NewDocument()
		  Self.NewDocument()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events List
	#tag Event
		Sub CellBackgroundPaint(G As Graphics, Row As Integer, Column As Integer, BackgroundColor As Color, TextColor As Color, IsHighlighted As Boolean)
		  #Pragma Unused BackgroundColor
		  #Pragma Unused IsHighlighted
		  
		  If Column <> Self.ColumnIcon Or Row >= Me.RowCount Then
		    Return
		  End If
		  
		  Var Document As BeaconAPI.Document = Me.RowTagAt(Row)
		  If Document Is Nil Then
		    Return
		  End If
		  
		  Var IconColor As Color = TextColor.AtOpacity(0.5)
		  Var Icon As Picture
		  If Document.IsGuest Then
		  Else
		    Icon = BeaconUI.IconWithColor(IconCloudDocument, IconColor)
		  End If
		  
		  If Icon Is Nil Then
		    Return
		  End If
		  
		  G.DrawPicture(Icon, (G.Width - Icon.Width) / 2, (G.Height - Icon.Height) / 2)
		End Sub
	#tag EndEvent
	#tag Event
		Function CellTextPaint(G As Graphics, Row As Integer, Column As Integer, Line As String, ByRef TextColor As Color, HorizontalPosition As Integer, VerticalPosition As Integer, IsHighlighted As Boolean) As Boolean
		  #Pragma Unused G
		  #Pragma Unused Row
		  #Pragma Unused Line
		  #Pragma Unused TextColor
		  #Pragma Unused HorizontalPosition
		  #Pragma Unused VerticalPosition
		  #Pragma Unused IsHighlighted
		  
		  Return Column = Self.ColumnIcon
		End Function
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function CompareRows(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer) As Boolean
		  Select Case Column
		  Case Self.ColumnUpdated
		    Var Row1Document As BeaconAPI.Document = Me.RowTagAt(Row1)
		    Var Row2Document As BeaconAPI.Document = Me.RowTagAt(Row2)
		    
		    If Row1Document.LastUpdated.SecondsFrom1970 > Row2Document.LastUpdated.SecondsFrom1970 Then
		      Result = 1
		    ElseIf Row1Document.LastUpdated.SecondsFrom1970 < Row2Document.LastUpdated.SecondsFrom1970 Then
		      Result = -1
		    Else
		      Result = 0
		    End If
		    
		    Return True
		  Case Self.ColumnRevision
		    Var Row1Document As BeaconAPI.Document = Me.RowTagAt(Row1)
		    Var Row2Document As BeaconAPI.Document = Me.RowTagAt(Row2)
		    
		    If Row1Document.Revision > Row2Document.Revision Then
		      Result = 1
		    ElseIf Row1Document.Revision < Row2Document.Revision Then
		      Result = -1
		    Else
		      Result = 0
		    End If
		    
		    Return True
		  End Select
		End Function
	#tag EndEvent
	#tag Event
		Function CanEdit() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Var URLs() As Beacon.ProjectURL
		  For Row As Integer = 0 To Me.LastRowIndex
		    If Me.Selected(Row) = False Then
		      Continue
		    End If
		    
		    Var Document As BeaconAPI.Document = Me.RowTagAt(Row)
		    URLs.Add(Self.URLForDocument(Document))
		  Next
		  
		  If URLs.Count = 0 Then
		    Return
		  End If
		  
		  If Warn Then
		    Var Names() As String
		    For Each URL As Beacon.ProjectURL In URLs
		      Names.Add(URL.Name)
		    Next
		    
		    If Self.ShowDeleteConfirmation(Names, "project", "projects") = False Then
		      Return
		    End If
		  End If
		  
		  Var ShouldRefresh As Boolean
		  Var Token As String = Preferences.OnlineToken
		  For Each URL As Beacon.ProjectURL In URLs
		    If Self.CloseDocument(URL) = False Then
		      Continue
		    End If
		    
		    Var Request As New BeaconAPI.Request(URL.URL(Beacon.ProjectURL.URLTypes.Writing), "DELETE", AddressOf APICallback_DeleteDocument)
		    Request.Authenticate(Token)
		    Self.APISocket.Start(Request)
		    ShouldRefresh = True
		  Next
		  
		  If ShouldRefresh Then
		    Self.RefreshList()
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformEdit()
		  For Row As Integer = 0 To Me.LastRowIndex
		    If Me.Selected(Row) = False Then
		      Continue
		    End If
		    
		    Var Document As BeaconAPI.Document = Me.RowTagAt(Row)
		    Self.OpenDocument(Self.URLForDocument(Document))
		  Next
		End Sub
	#tag EndEvent
	#tag Event
		Function ConstructContextualMenu(Base As MenuItem, X As Integer, Y As Integer) As Boolean
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  Var VersionsItem As New MenuItem("Older Versions…", "versions")
		  VersionsItem.Enabled = Me.SelectedRowCount = 1 And Preferences.OnlineToken.IsEmpty = False
		  Base.AddMenu(VersionsItem)
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuAction(HitItem As MenuItem) As Boolean
		  If HitItem Is Nil Then
		    Return False
		  End If
		  
		  If HitItem.Tag.IsNull = False And HitItem.Tag.Type = Variant.TypeString And HitItem.Tag.StringValue = "versions" Then
		    If Me.SelectedRowCount = 1 Then
		      Var Document As BeaconAPI.Document = Me.RowTagAt(Me.SelectedRowIndex)
		      Var Request As New BeaconAPI.Request("project/" + Document.DocumentID + "/versions", "GET", WeakAddressOf APICallback_ListVersions)
		      Request.Authenticate(Preferences.OnlineToken)
		      BeaconAPI.Send(Request)
		      
		      Self.mVersionProgressKey = CallLater.Schedule(2000, WeakAddressOf ShowVersionProgress)
		    End If
		    Return True
		  End If
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events LoginActionButton
	#tag Event
		Sub Action()
		  UserWelcomeWindow.Present(True)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PermissionActionButton
	#tag Event
		Sub Action()
		  UserWelcomeWindow.Present(False)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ErrorActionButton
	#tag Event
		Sub Action()
		  Self.RefreshList()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events APISocket
	#tag Event
		Sub WorkCompleted()
		  Self.Progress = BeaconSubview.ProgressNone
		End Sub
	#tag EndEvent
	#tag Event
		Sub WorkProgress(Request As BeaconAPI.Request, BytesReceived As Int64, BytesTotal As Int64)
		  #Pragma Unused Request
		  
		  Self.Progress = BytesReceived / BytesTotal
		End Sub
	#tag EndEvent
	#tag Event
		Sub WorkStarted()
		  Self.Progress = BeaconSubview.ProgressIndeterminate
		End Sub
	#tag EndEvent
#tag EndEvents
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
		Name="LockLeft"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
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
		Name="TabPanelIndex"
		Visible=false
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
		Name="AllowAutoDeactivate"
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
		Name="Tooltip"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
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
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
		EditorType="Color"
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
		Name="EraseBackground"
		Visible=false
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
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
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
