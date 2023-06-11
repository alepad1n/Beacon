#tag DesktopWindow
Begin BeaconDialog ArkBreedingTunerDialog
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Composite       =   False
   Frame           =   8
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   400
   ImplicitInstance=   False
   LiveResize      =   "True"
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   600
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   400
   MinimizeButton  =   False
   MinWidth        =   600
   Placement       =   1
   Resizable       =   "True"
   Resizeable      =   False
   SystemUIVisible =   "True"
   Title           =   "Auto Compute Imprinting Multiplier"
   Visible         =   True
   Width           =   600
   Begin DesktopLabel MessageLabel
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
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Auto Compute Imprinting Multiplier"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   560
   End
   Begin DesktopLabel ExplanationLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   36
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   True
      Scope           =   2
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Choose the creatures that are important for hitting 100% imprint, and Beacon will compute the best imprint period multiplier."
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   560
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
      Left            =   408
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   360
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedPushButton ActionButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "OK"
      Default         =   True
      Enabled         =   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   500
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   360
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin BeaconListbox CreaturesList
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
      ColumnWidths    =   "22,*"
      DefaultRowHeight=   22
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
      HasHeader       =   False
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   216
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PreferencesKey  =   ""
      RequiresSelection=   False
      RowSelectionType=   0
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   132
      Transparent     =   False
      TypeaheadColumn =   0
      Underline       =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   560
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin UITweaks.ResizedPushButton MajorCreaturesButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   True
      Caption         =   "Major Creatures"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   236
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   100
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   129
   End
   Begin UITweaks.ResizedPushButton AllCreaturesButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   True
      Caption         =   "All Creatures"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   95
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   100
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   129
   End
   Begin UITweaks.ResizedPushButton ClearCreaturesButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   True
      Caption         =   "Clear Creatures"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   377
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   100
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   129
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Self.CreaturesList.ColumnTypeAt(Self.ColumnChecked) = DesktopListbox.CellTypes.CheckBox
		  
		  For Each Creature As Ark.Creature In Self.mCreatures
		    If Creature.IncubationTime = 0 Or Creature.MatureTime = 0 Then
		      Continue
		    End If
		    
		    Self.CreaturesList.AddRow("", Creature.Label)
		    Self.CreaturesList.RowTagAt(Self.CreaturesList.LastAddedRowIndex) = Creature
		  Next
		  
		  Self.CheckCreatures(Preferences.BreedingTunerCreatures)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub CheckCreatures(List As String)
		  Self.mAutoCheckingCreatures = True
		  If List = "*" Then
		    For I As Integer = 0 To Self.CreaturesList.RowCount - 1
		      Self.CreaturesList.CellCheckBoxValueAt(I, Self.ColumnChecked) = True
		    Next
		  Else
		    Var Creatures() As String = List.Split(",")
		    For I As Integer = 0 To Creatures.LastIndex
		      Creatures(I) = Creatures(I).Trim
		    Next
		    
		    For I As Integer = 0 To Self.CreaturesList.RowCount - 1
		      Var ClassString As String = Ark.Creature(Self.CreaturesList.RowTagAt(I)).ClassString
		      Self.CreaturesList.CellCheckBoxValueAt(I, Self.ColumnChecked) = Creatures.IndexOf(ClassString) > -1
		    Next
		  End If
		  Self.mAutoCheckingCreatures = False
		  
		  Self.mLastCheckedList = List
		  Self.CheckEnabled()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckEnabled()
		  Var Enabled As Boolean = Self.mLastCheckedList <> ""
		  If Self.ActionButton.Enabled <> Enabled Then
		    Self.ActionButton.Enabled = Enabled
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(BaselineRates As Dictionary, MatureSpeedMultiplier As Double, ImprintAmountMultiplier As Double, Creatures() As Ark.Creature)
		  // Calling the overridden superclass constructor.
		  Self.mBaselineRates = BaselineRates
		  Self.mMatureSpeedMultiplier = MatureSpeedMultiplier
		  Self.mCreatures = Creatures
		  Self.mImprintAmountMultiplier = ImprintAmountMultiplier
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As DesktopWindow, BaselineRates As Dictionary, MatureSpeedMultiplier As Double, ImprintAmountMultiplier As Double, Creatures() As Ark.Creature) As Double
		  If Parent = Nil Then
		    Return 0
		  End If
		  
		  Var Win As New ArkBreedingTunerDialog(BaselineRates, MatureSpeedMultiplier, ImprintAmountMultiplier, Creatures)
		  Win.ShowModal(Parent)
		  Var Multiplier As Double = Win.mChosenMultiplier
		  Win.Close
		  
		  Return Multiplier
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mAutoCheckingCreatures As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBaselineRates As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mChosenMultiplier As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCreatures() As Ark.Creature
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImprintAmountMultiplier As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastCheckedList As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMatureSpeedMultiplier As Double
	#tag EndProperty


	#tag Constant, Name = ColumnChecked, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnName, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events CancelButton
	#tag Event
		Sub Pressed()
		  Self.mChosenMultiplier = 0
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Pressed()
		  Const Threshold = 0.90
		  
		  Var Creatures() As Ark.Creature
		  For I As Integer = 0 To Self.CreaturesList.RowCount - 1
		    If Self.CreaturesList.CellCheckBoxValueAt(I, Self.ColumnChecked) Then
		      Creatures.Add(Self.CreaturesList.RowTagAt(I))
		    End If
		  Next
		  
		  // Get fastest maturing creature
		  Var FastestMature As Double
		  For Each Creature As Ark.Creature In Creatures
		    Var MatureSeconds As Double = Creature.MatureTime / (Self.mMatureSpeedMultiplier * Self.mBaselineRates.Value("BabyMatureSpeedMultiplier").DoubleValue)
		    If FastestMature = 0 Or MatureSeconds < FastestMature Then
		      FastestMature = MatureSeconds
		    End If
		  Next
		  
		  // Reduce the target by a set amount and compute the imprint multiplier
		  Var TargetCuddleSeconds As Double = FastestMature * Threshold
		  Var OfficialCuddlePeriod As Integer = Round(Ark.DataSource.Pool.Get(False).GetIntegerVariable("Cuddle Period") * Self.mBaselineRates.Value("BabyCuddleIntervalMultiplier").DoubleValue)
		  Var ImprintMultiplier As Double = (TargetCuddleSeconds / (Self.mImprintAmountMultiplier * Self.mBaselineRates.Value("BabyImprintAmountMultiplier").DoubleValue)) / OfficialCuddlePeriod
		  
		  Preferences.BreedingTunerCreatures = Self.mLastCheckedList
		  Self.mChosenMultiplier = ImprintMultiplier
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CreaturesList
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  #Pragma Unused row
		  
		  If Self.mAutoCheckingCreatures Or Column <> Self.ColumnChecked Then
		    Return
		  End If
		  
		  Var Classes() As String
		  For I As Integer = 0 To Self.CreaturesList.RowCount - 1
		    If Self.CreaturesList.CellCheckBoxValueAt(I, Column) Then
		      Classes.Add(Ark.Creature(Self.CreaturesList.RowTagAt(I)).ClassString)
		    End If
		  Next
		  Self.mLastCheckedList = Classes.Join(",")
		  Self.CheckEnabled()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MajorCreaturesButton
	#tag Event
		Sub Pressed()
		  Self.CheckCreatures(Ark.DataSource.Pool.Get(False).GetStringVariable("Major Imprint Creatures"))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AllCreaturesButton
	#tag Event
		Sub Pressed()
		  Self.CheckCreatures("*")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ClearCreaturesButton
	#tag Event
		Sub Pressed()
		  Self.CheckCreatures("")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Locations"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
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
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="ColorGroup"
		EditorType="ColorGroup"
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
		Name="Interfaces"
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
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=false
		Group="Behavior"
		InitialValue="False"
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
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="DesktopMenuBar"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
