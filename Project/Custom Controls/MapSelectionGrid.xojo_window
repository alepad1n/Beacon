#tag DesktopWindow
Begin DesktopContainer MapSelectionGrid
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composited      =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   300
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
   Width           =   300
   Begin MapCheckBox Boxes
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Untitled"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   0
      InitialParent   =   ""
      Italic          =   False
      Left            =   6
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   6
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   0
      Width           =   140
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  If Self.mFetchMaps Then
		    Self.mMaps = RaiseEvent GetMaps()
		  End If
		  
		  Var Disambiguation As New Dictionary
		  For Each Map As Beacon.Map In Self.mMaps
		    Var Siblings() As Beacon.Map
		    If Disambiguation.HasKey(Map.Name) Then
		      Siblings = Disambiguation.Value(Map.Name)
		    End If
		    Siblings.Add(Map)
		    Disambiguation.Value(Map.Name) = Siblings
		  Next
		  
		  Var GameNames As New Dictionary
		  Var Games() As Beacon.Game = Beacon.Games
		  For Each Game As Beacon.Game In Games
		    GameNames.Value(Game.Identifier) = Game.Name
		  Next
		  
		  Var SortValues() As String
		  Var Maps() As Beacon.Map
		  Var Names As New Dictionary
		  For Each Entry As DictionaryEntry In Disambiguation
		    Var Siblings() As Beacon.Map = Entry.Value
		    
		    If Siblings.Count = 1 Then
		      Var Map As Beacon.Map = Siblings(0)
		      Var Sort As Integer = If(Map.Official, Map.Sort + 100, Map.Sort)
		      SortValues.Add(Sort.ToString(Locale.Raw, "0000") + ":" + Map.Name + ":" + GameNames.Value(Map.GameId).StringValue)
		      Maps.Add(Map)
		      Names.Value(Map.MapId) = Map.Name
		    Else
		      For Each Map As Beacon.Map In Siblings
		        Var Sort As Integer = If(Map.Official, Map.Sort + 100, Map.Sort)
		        SortValues.Add(Sort.ToString(Locale.Raw, "0000") + ":" + Map.Name + ":" + GameNames.Value(Map.GameId).StringValue)
		        Maps.Add(Map)
		        Names.Value(Map.MapId) = Map.Name + " (" + GameNames.Value(Map.GameId).StringValue + ")"
		      Next
		    End If
		  Next
		  SortValues.SortWith(Maps)
		  
		  Var OfficialMaps(), OtherMaps() As Beacon.Map
		  For Each Map As Beacon.Map In Maps
		    If Map.Official Then
		      OfficialMaps.Add(Map)
		    Else
		      OtherMaps.Add(Map)
		    End If
		  Next
		  
		  Var OfficialLeft As Integer = Boxes(0).Left
		  Var OfficialNextTop As Integer = Boxes(0).Top
		  Var OtherLeft As Integer = Boxes(0).Left + Boxes(0).Width + 12
		  Var OtherNextTop As Integer = Boxes(0).Top
		  
		  Boxes(0).Close
		  
		  Var LeftBoxes(), RightBoxes() As MapCheckBox
		  For Each Map As Beacon.Map In OfficialMaps
		    Var Box As New Boxes
		    Box.Map = Map
		    Box.Caption = Names.Value(Map.MapId)
		    Box.Top = OfficialNextTop
		    Box.Left = OfficialLeft
		    OfficialNextTop = OfficialNextTop + Box.Height + 12
		    Self.mBoxes.Add(Box)
		    LeftBoxes.Add(Box)
		  Next
		  For Each Map As Beacon.Map In OtherMaps
		    Var Box As New Boxes
		    Box.Map = Map
		    Box.Caption = Names.Value(Map.MapId)
		    Box.Top = OtherNextTop
		    Box.Left = OtherLeft
		    OtherNextTop = OtherNextTop + Box.Height + 12
		    Self.mBoxes.Add(Box)
		    RightBoxes.Add(Box)
		  Next
		  
		  BeaconUI.SizeToFit(Self.mBoxes)
		  Var LeftGroup As New ControlGroup(LeftBoxes)
		  Var RightGroup As New ControlGroup(RightBoxes)
		  RightGroup.Left = LeftGroup.Right + 12
		  
		  Self.mDesiredHeight = Max(LeftGroup.Height, RightGroup.Height) + 12
		  Self.mDesiredWidth = If(LeftGroup.Width > 0 And RightGroup.Width > 0, LeftGroup.Width + 12 + RightGroup.Width, Max(LeftGroup.Width, RightGroup.Width)) + 12
		  
		  Self.Height = Self.mDesiredHeight
		  Self.Width = Self.mDesiredWidth
		  
		  RaiseEvent Open
		  Self.mSettingUp = False
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function CheckedMaps() As Beacon.Map()
		  Var Maps() As Beacon.Map
		  For Each Box As MapCheckBox In Self.mBoxes
		    If Box.VisualState = DesktopCheckBox.VisualStates.Checked Then
		      Maps.Add(Box.Map)
		    End If
		  Next
		  Return Maps
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mFetchMaps = True
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Maps() As Beacon.Map)
		  Self.mMaps = Maps
		  Self.mFetchMaps = False
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetMapStates(Maps() As Beacon.Map, State As DesktopCheckbox.VisualStates)
		  Var Dict As New Dictionary
		  If (Maps Is Nil) = False Then
		    For Each Map As Beacon.Map In Maps
		      Dict.Value(Map.MapId) = True
		    Next
		  End If
		  
		  For Each Box As MapCheckBox In Self.mBoxes
		    If Dict.HasKey(Box.Map.MapId) Then
		      Box.VisualState = State
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetWithMaps(Maps() As Beacon.Map)
		  Var Dict As New Dictionary
		  If (Maps Is Nil) = False Then
		    For Each Map As Beacon.Map In Maps
		      Dict.Value(Map.MapId) = True
		    Next
		  End If
		  
		  For Each Box As MapCheckBox In Self.mBoxes
		    If Dict.HasKey(Box.Map.MapId) Then
		      Box.VisualState = DesktopCheckbox.VisualStates.Checked
		    Else
		      Box.VisualState = DesktopCheckbox.VisualStates.Unchecked
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UncheckedMaps() As Beacon.Map()
		  Var Maps() As Beacon.Map
		  For Each Box As MapCheckBox In Self.mBoxes
		    If Box.VisualState = DesktopCheckBox.VisualStates.Unchecked Then
		      Maps.Add(Box.Map)
		    End If
		  Next
		  Return Maps
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Changed()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event GetMaps() As Beacon.Map()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mDesiredHeight
			End Get
		#tag EndGetter
		DesiredHeight As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mDesiredWidth
			End Get
		#tag EndGetter
		DesiredWidth As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mBoxes() As MapCheckBox
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDesiredHeight As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDesiredWidth As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFetchMaps As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMaps() As Beacon.Map
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSettingUp As Boolean = True
	#tag EndProperty


#tag EndWindowCode

#tag Events Boxes
	#tag Event
		Sub ValueChanged(index as Integer)
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  If (TargetMacOS And Keyboard.CommandKey) Or (TargetWindows And Keyboard.ControlKey) Then
		    Self.mSettingUp = True
		    For Each Box As MapCheckBox In Self.mBoxes
		      If Box = Me Then
		        Continue
		      End If
		      
		      Box.Value = Me.Value
		    Next
		    Self.mSettingUp = False
		  End If
		  
		  RaiseEvent Changed
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
	#tag ViewProperty
		Name="DesiredWidth"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DesiredHeight"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
