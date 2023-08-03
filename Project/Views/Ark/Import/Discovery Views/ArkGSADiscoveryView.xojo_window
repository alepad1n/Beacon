#tag DesktopWindow
Begin ArkDiscoveryView ArkGSADiscoveryView
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
   Height          =   402
   Index           =   -2147483648
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   False
   LockLeft        =   True
   LockRight       =   False
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Tooltip         =   ""
   Top             =   0
   Transparent     =   True
   Visible         =   True
   Width           =   576
   Begin DesktopLabel TemplatesMessage
      AllowAutoDeactivate=   True
      Bold            =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Select Config Templates"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   536
   End
   Begin BeaconListbox List
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   True
      AllowInfiniteScroll=   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   2
      ColumnWidths    =   "26,*"
      DefaultRowHeight=   "#BeaconListbox.StandardRowHeight"
      DefaultSortColumn=   0
      DefaultSortDirection=   0
      DropIndicatorVisible=   False
      EditCaption     =   "Edit"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLineStyle   =   0
      HasBorder       =   True
      HasHeader       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   282
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   " 	Name"
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PageSize        =   100
      PreferencesKey  =   ""
      RequiresSelection=   False
      RowSelectionType=   0
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   60
      Transparent     =   False
      TypeaheadColumn =   0
      Underline       =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   536
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin UITweaks.ResizedPushButton ActionButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Next"
      Default         =   True
      Enabled         =   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   476
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   362
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton CancelButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   True
      Caption         =   "Cancel"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   384
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   362
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin DesktopButton TokensRefreshButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Refresh"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   9
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   -49
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin DesktopProgressWheel TokensRefreshSpinner
      Active          =   False
      AllowAutoDeactivate=   True
      AllowTabStop    =   True
      Enabled         =   True
      Height          =   16
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   7
      TabPanelIndex   =   0
      Tooltip         =   ""
      Top             =   364
      Transparent     =   False
      Visible         =   False
      Width           =   16
      _mIndex         =   0
      _mInitialParent =   ""
      _mName          =   ""
      _mPanelIndex    =   0
   End
   Begin DesktopLabel TokensRefreshLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   48
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Authorizing…"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   362
      Transparent     =   False
      Underline       =   False
      Visible         =   False
      Width           =   324
   End
   Begin Thread TokenLookupThread
      DebugIdentifier =   ""
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   2
      StackSize       =   0
      TabPanelIndex   =   0
      ThreadID        =   0
      ThreadState     =   0
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Begin()
		  Self.DesiredHeight = 480
		  Self.RefreshTokens()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Self.SwapButtons()
		  RaiseEvent Opening
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function Busy() As Boolean
		  Return Self.mPendingListActions > 0 Or Self.mFetchingTokens = True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mEngines = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Engine_Discovered(Sender As Ark.GSAIntegrationEngine, Data() As Beacon.DiscoveredData)
		  Self.mPendingListActions = Self.mPendingListActions - 1
		  
		  If Sender.Errored Then
		    Self.ShowAlert("Unable to retrieve server list from GameServerApp.com", "The error message provided was:" + EndOfLine + EndOfLine + Sender.ErrorMessage + EndOfLine + EndOfLine + "This error may be temporary, so try again in a few minutes. If the problem persists, make sure your antivirus or malware protection is not blocking Beacon from contacting GameServerApp.com's servers.")
		    Self.ShouldCancel()
		    Return
		  End If
		  
		  For Each Server As Beacon.DiscoveredData In Data
		    Self.List.AddRow("", Server.Profile.Name)
		    Self.List.RowTagAt(Self.List.LastAddedRowIndex) = Server
		  Next
		  
		  If Self.Busy = False And Self.List.RowCount = 0 Then
		    Self.ShowAlert("No eligible templates were found", "Beacon could not find any templates on any of the connected GameServerApp.com accounts.")
		    Self.ShouldCancel()
		    Return
		  End If
		  
		  Self.List.SortingColumn = 1
		  Self.List.Sort
		  Self.UpdateUI()
		  
		  If Self.Busy = False Then
		    App.FrontmostMBS = True
		    Self.TrueWindow.ActivateWindowMBS
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Engine_Wait(Sender As Ark.GSAIntegrationEngine, Controller As Beacon.TaskWaitController) As Boolean
		  #Pragma Unused Sender
		  
		  Controller.Cancelled = True
		  Controller.ShouldResume = True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ListTemplatesForAccount(Token As BeaconAPI.ProviderToken)
		  Var Profile As New Ark.GSAServerProfile
		  Profile.ProviderTokenId = Token.TokenId
		  
		  Var Engine As New Ark.GSAIntegrationEngine(Profile)
		  Self.mEngines.Value(Token.TokenId) = Engine
		  AddHandler Engine.Discovered, WeakAddressOf Engine_Discovered
		  AddHandler Engine.Wait, WeakAddressOf Engine_Wait
		  Engine.BeginDiscovery(Self.Project)
		  
		  Self.mPendingListActions = Self.mPendingListActions + 1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RefreshTokens()
		  Self.List.RemoveAllRows()
		  Self.mFetchingTokens = False
		  Self.mPendingListActions = 0
		  Self.mCancelled = False
		  
		  Self.TokenLookupThread.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ShouldCancel()
		  Self.mCancelled = True
		  Super.ShouldCancel()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateUI()
		  Var Refreshing As Boolean = Self.Busy
		  If Self.TokensRefreshLabel.Visible <> Refreshing Then
		    Self.TokensRefreshLabel.Visible = Refreshing
		  End If
		  If Self.TokensRefreshSpinner.Visible <> Refreshing Then
		    Self.TokensRefreshSpinner.Visible = Refreshing
		  End If
		  If Self.TokensRefreshButton.Visible = Refreshing Then
		    Self.TokensRefreshButton.Visible = Not Refreshing
		  End If
		  
		  Var ActionEnabled As Boolean
		  If Refreshing Then
		    Var RefreshLabel As String
		    If Self.mFetchingTokens Then
		      RefreshLabel = "Retrieving GameServerApp.com tokens…"
		    Else
		      RefreshLabel = "Listing templates on " + Language.NounWithQuantity(Self.mPendingListActions, "GameServerApp.com account", "GameServerApp.com accounts") + "…"
		    End If
		    
		    If Self.TokensRefreshLabel.Text <> RefreshLabel Then
		      Self.TokensRefreshLabel.Text = RefreshLabel
		    End If
		  Else
		    For I As Integer = 0 To Self.List.RowCount - 1
		      If Self.List.CellCheckBoxValueAt(I, 0) Then
		        ActionEnabled = True
		        Exit For I
		      End If
		    Next
		  End If
		  
		  If Self.ActionButton.Enabled <> ActionEnabled Then
		    Self.ActionButton.Enabled = ActionEnabled
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Opening()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEngines As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFetchingTokens As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPendingListActions As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTokens() As BeaconAPI.ProviderToken
	#tag EndProperty


#tag EndWindowCode

#tag Events List
	#tag Event
		Sub Opening()
		  Me.ColumnTypeAt(0) = DesktopListbox.CellTypes.CheckBox
		  Me.TypeaheadColumn = 1
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  #Pragma Unused Row
		  #Pragma Unused Column
		  
		  Self.UpdateUI()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Pressed()
		  Var Data() As Beacon.DiscoveredData
		  For I As Integer = 0 To Self.List.RowCount - 1
		    If Not Self.List.CellCheckBoxValueAt(I, 0) Then
		      Continue
		    End If
		    
		    Data.Add(Self.List.RowTagAt(I))
		  Next
		  Self.ShouldFinish(Data)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelButton
	#tag Event
		Sub Pressed()
		  Self.ShouldCancel()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TokensRefreshButton
	#tag Event
		Sub Pressed()
		  Self.RefreshTokens()
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.Top = Self.TokensRefreshLabel.Top
		  Me.Left = Self.TokensRefreshSpinner.Left
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TokenLookupThread
	#tag Event
		Sub Run()
		  If Self.Busy Then
		    Return
		  End If
		  Self.mFetchingTokens = True
		  Me.AddUserInterfaceUpdate(New Dictionary("UpdateUI": true))
		  
		  Var UserId As String = App.IdentityManager.CurrentUserId
		  Var Tokens() As BeaconAPI.ProviderToken = BeaconAPI.GetProviderTokens(UserId)
		  Var Cache As New Dictionary
		  For Idx As Integer = Tokens.LastIndex DownTo 0
		    If Self.mCancelled Then
		      Return
		    End If
		    Cache.Value(Tokens(Idx).TokenId) = Tokens(Idx)
		    
		    If Tokens(Idx).Provider = BeaconAPI.ProviderToken.ProviderGameServerApp Then
		      Self.ListTemplatesForAccount(Tokens(Idx))
		      Me.AddUserInterfaceUpdate(New Dictionary("UpdateUI": true))
		    Else
		      Tokens.RemoveAt(Idx)
		    End If
		  Next
		  
		  Var TokenIds() As String = Self.Project.ProviderTokenIds
		  For Each TokenId As String In TokenIds
		    If Self.mCancelled Then
		      Return
		    End If
		    If Cache.HasKey(TokenId) Then
		      Continue
		    End If
		    
		    Var Token As BeaconAPI.ProviderToken = BeaconAPI.GetProviderToken(TokenId)
		    If Token.Provider = BeaconAPI.ProviderToken.ProviderGameServerApp And Token.Decrypt(Self.Project.ProviderTokenKey(TokenId)) Then
		      Tokens.Add(Token)
		      Cache.Value(Token.TokenId) = Token
		      Self.ListTemplatesForAccount(Token)
		      Me.AddUserInterfaceUpdate(New Dictionary("UpdateUI": true))
		    End If
		  Next
		  If Self.mCancelled Then
		    Return
		  End If
		  
		  Self.mTokens = Tokens
		  Self.mFetchingTokens = False
		  Me.AddUserInterfaceUpdate(New Dictionary("UpdateUI": true, "Finished": true))
		End Sub
	#tag EndEvent
	#tag Event
		Sub UserInterfaceUpdate(data() as Dictionary)
		  For Each Update As Dictionary In Data
		    If Update.Lookup("UpdateUI", False).BooleanValue = True Then
		      Self.UpdateUI()
		    End If
		    If Update.Lookup("Finished", false).BooleanValue = True And Self.mTokens.Count = 0 Then
		      If Self.ShowConfirm("No GameServerApp.com services are available. Would you like to a GameServerApp.com token to your Beacon account?", "Your web browser will be opened so you can add a token.", "Connect", "Cancel") Then
		        System.GotoURL(Beacon.WebURL("/account/#services", True))
		      End If
		      Self.ShouldCancel()
		    End If
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
		Type="ColorGroup"
		EditorType="ColorGroup"
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
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
