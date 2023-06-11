#tag DesktopWindow
Begin BeaconDialog ArkSpawnPointCreatureDialog
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   DefaultLocation =   1
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   False
   HasFullScreenButton=   False
   HasMaximizeButton=   False
   HasMinimizeButton=   False
   Height          =   486
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   486
   MaximumWidth    =   524
   MenuBar         =   0
   MenuBarVisible  =   True
   MinimumHeight   =   486
   MinimumWidth    =   524
   Resizeable      =   False
   Title           =   "Creature Entry"
   Type            =   8
   Visible         =   True
   Width           =   524
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
      Text            =   "Creature Entry"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   484
   End
   Begin UITweaks.ResizedPushButton CreatureChooseButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Choose…"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   160
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   86
   End
   Begin UITweaks.ResizedLabel CreatureLabel
      AllowAutoDeactivate=   True
      Bold            =   False
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
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Creature:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   128
   End
   Begin UITweaks.ResizedLabel CreatureNameLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   True
      Left            =   258
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   True
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Not Selected"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   246
   End
   Begin RangeField OffsetFields
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
      DoubleValue     =   0.0
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   ""
      Index           =   0
      Italic          =   False
      Left            =   160
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   2
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   84
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   80
   End
   Begin RangeField OffsetFields
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
      DoubleValue     =   0.0
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   ""
      Index           =   1
      Italic          =   False
      Left            =   252
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   2
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   84
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   80
   End
   Begin RangeField OffsetFields
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
      DoubleValue     =   0.0
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   ""
      Index           =   2
      Italic          =   False
      Left            =   344
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   2
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   84
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedLabel OffsetLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Offset (X, Y, Z):"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   84
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   128
   End
   Begin RangeField SpawnChanceField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
      DoubleValue     =   0.0
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   160
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   2
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   118
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   80
   End
   Begin UITweaks.ResizedLabel SpawnChanceLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Spawn Chance:"
      TextAlignment   =   3
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   118
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   128
   End
   Begin UITweaks.ResizedPushButton ActionButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "OK"
      Default         =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   424
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   446
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
      Left            =   332
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   446
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin DesktopLabel OptionalLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   True
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "All fields optional"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   446
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   300
   End
   Begin DesktopGroupBox GroupBox1
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Wild Levels"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   274
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   152
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   332
      Begin DesktopLabel Label1
         AllowAutoDeactivate=   True
         Bold            =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "GroupBox1"
         Italic          =   False
         Left            =   160
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   5
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Or"
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   254
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   172
      End
      Begin UITweaks.ResizedLabel EffectiveLevelLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "GroupBox1"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   13
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Level Range:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   386
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   108
      End
      Begin DesktopLabel EffectiveMaxLevelField
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "GroupBox1"
         Italic          =   False
         Left            =   252
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   15
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "30"
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   386
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin DesktopLabel EffectiveMinLevelField
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "GroupBox1"
         Italic          =   False
         Left            =   160
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   14
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "1"
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   386
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedLabel LevelMultiplierLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "GroupBox1"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   9
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Level Multiplier:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   320
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   108
      End
      Begin UITweaks.ResizedLabel LevelOffsetLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "GroupBox1"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   6
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Level Offset:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   286
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   108
      End
      Begin UITweaks.ResizedLabel LevelRangeLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "GroupBox1"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   2
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Override Range:"
         TextAlignment   =   3
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   220
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   108
      End
      Begin RangeField LevelMultiplierMaxField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DoubleValue     =   0.0
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "GroupBox1"
         Italic          =   False
         Left            =   252
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   11
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   320
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   80
      End
      Begin RangeField LevelMultiplierMinField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DoubleValue     =   0.0
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "GroupBox1"
         Italic          =   False
         Left            =   160
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   10
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   320
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   80
      End
      Begin RangeField LevelOffsetMaxField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DoubleValue     =   0.0
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "GroupBox1"
         Italic          =   False
         Left            =   252
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   8
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   286
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   80
      End
      Begin RangeField LevelOffsetMinField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DoubleValue     =   0.0
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "GroupBox1"
         Italic          =   False
         Left            =   160
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   7
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   286
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   80
      End
      Begin RangeField LevelOverrideMaxField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DoubleValue     =   0.0
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "GroupBox1"
         Italic          =   False
         Left            =   252
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   220
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   80
      End
      Begin RangeField LevelOverrideMinField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF00
         Bold            =   False
         DoubleValue     =   0.0
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "GroupBox1"
         Italic          =   False
         Left            =   160
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   220
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   80
      End
      Begin DesktopLabel MaxLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "GroupBox1"
         Italic          =   False
         Left            =   252
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Max"
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   188
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin DesktopLabel MinLabel
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "GroupBox1"
         Italic          =   False
         Left            =   160
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Min"
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   188
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin DesktopLabel Label2
         AllowAutoDeactivate=   True
         Bold            =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "GroupBox1"
         Italic          =   False
         Left            =   160
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   12
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "="
         TextAlignment   =   2
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   354
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   172
      End
   End
   Begin UITweaks.ResizedLabel SpawnChancePercentLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   246
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   14
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "%"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   118
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   20
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Self.SwapButtons()
		  
		  If Self.mTargetCreature <> Nil Then
		    Self.CreatureNameLabel.Text = Self.mTargetCreature.Label
		    Self.CreatureNameLabel.Italic = False
		  ElseIf Self.mMultiEditMode Then
		    Var Names() As String
		    For Each Entry As Ark.MutableSpawnPointSetEntry In Self.mEntries
		      Names.Add(Entry.Label)
		    Next
		    Names.Sort
		    Self.CreatureNameLabel.Text = Language.EnglishOxfordList(Names)
		  End If
		  
		  Var CommonOffset As Beacon.Point3D
		  Var CommonSpawnChance, CommonMinLevelMultiplier, CommonMaxLevelMultiplier, CommonMinLevelOffset, CommonMaxLevelOffset As NullableDouble
		  Var CommonLevelRange As Beacon.Range
		  
		  If Self.mEntries.LastIndex > -1 Then
		    CommonOffset = Self.mEntries(0).Offset
		    CommonSpawnChance = Self.mEntries(0).SpawnChance
		    CommonMinLevelMultiplier = Self.mEntries(0).MinLevelMultiplier
		    CommonMaxLevelMultiplier = Self.mEntries(0).MaxLevelMultiplier
		    CommonMinLevelOffset = Self.mEntries(0).MinLevelOffset
		    CommonMaxLevelOffset = Self.mEntries(0).MaxLevelOffset
		    If Self.mEntries(0).HasCustomLevelRange Then
		      CommonLevelRange = Self.mEntries(0).LevelRangeForDifficulty(Self.mDifficulty, Self.mOffsetBeforeMultiplier)
		    End If
		  End If
		  
		  If Self.mEntries.LastIndex > 0 Then
		    For I As Integer = 1 To Self.mEntries.LastIndex
		      If CommonOffset <> Nil And Self.mEntries(I).Offset <> CommonOffset Then
		        CommonOffset = Nil
		      End If
		      If CommonSpawnChance <> Nil And Self.mEntries(I).SpawnChance <> CommonSpawnChance Then
		        CommonSpawnChance = Nil
		      End If
		      If CommonMinLevelMultiplier <> Nil And Self.mEntries(I).MinLevelMultiplier <> CommonMinLevelMultiplier Then
		        CommonMinLevelMultiplier = Nil
		      End If
		      If CommonMaxLevelMultiplier <> Nil And Self.mEntries(I).MaxLevelMultiplier <> CommonMaxLevelMultiplier Then
		        CommonMaxLevelMultiplier = Nil
		      End If
		      If CommonMinLevelOffset <> Nil And Self.mEntries(I).MinLevelOffset <> CommonMinLevelOffset Then
		        CommonMinLevelOffset = Nil
		      End If
		      If CommonMaxLevelOffset <> Nil And Self.mEntries(I).MaxLevelOffset <> CommonMaxLevelOffset Then
		        CommonMaxLevelOffset = Nil
		      End If
		      If CommonLevelRange <> Nil And Self.mEntries(I).LevelRangeForDifficulty(Self.mDifficulty, Self.mOffsetBeforeMultiplier) <> CommonLevelRange Then
		        CommonLevelRange = Nil
		      End If
		    Next
		  End If
		  
		  If CommonOffset <> Nil Then
		    Self.OffsetFields(0).DoubleValue = CommonOffset.X
		    Self.OffsetFields(1).DoubleValue = CommonOffset.Y
		    Self.OffsetFields(2).DoubleValue = CommonOffset.Z
		  End If
		  If CommonSpawnChance <> Nil Then
		    Var Percent As Double = Max(Min(CommonSpawnChance.DoubleValue, 1.0), 0.0) * 100
		    Self.SpawnChanceField.DoubleValue = Percent
		  End If
		  If CommonMinLevelMultiplier <> Nil Then
		    Self.LevelMultiplierMinField.DoubleValue = CommonMinLevelMultiplier
		  End If
		  If CommonMaxLevelMultiplier <> Nil Then
		    Self.LevelMultiplierMaxField.DoubleValue = CommonMaxLevelMultiplier
		  End If
		  If CommonMinLevelOffset <> Nil Then
		    Self.LevelOffsetMinField.DoubleValue = CommonMinLevelOffset
		  End If
		  If CommonMaxLevelOffset <> Nil Then
		    Self.LevelOffsetMaxField.DoubleValue = CommonMaxLevelOffset
		  End If
		  If CommonLevelRange <> Nil Then 
		    Self.LevelOverrideMinField.DoubleValue = CommonLevelRange.Min
		    Self.LevelOverrideMaxField.DoubleValue = CommonLevelRange.Max
		  End If
		  
		  Self.UpdateEffectiveLevel()
		  
		  Self.mSettingUp = False
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor(Project As Ark.Project, Entries() As Ark.MutableSpawnPointSetEntry, OffsetBeforeMultiplier As Boolean)
		  Self.mSettingUp = True
		  
		  Self.mDifficulty = Project.Difficulty.DifficultyValue
		  Self.mMods = Project.ContentPacks
		  Self.mEntries = Entries
		  Self.mMultiEditMode = Entries.LastIndex > 0
		  Self.mOffsetBeforeMultiplier = OffsetBeforeMultiplier
		  
		  If Entries.LastIndex > 0 Then
		    Self.mMultiEditMode = True
		    
		    Var CommonCreature As Ark.Creature = Entries(0).Creature
		    For I As Integer = 1 To Entries.LastIndex
		      If Entries(I).Creature <> CommonCreature Then
		        CommonCreature = Nil
		        Exit For I
		      End If
		    Next
		    
		    Self.mTargetCreature = CommonCreature
		  ElseIf Entries.LastIndex = 0 Then
		    Self.mTargetCreature = Entries(0).Creature
		  End If
		  
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CreateEntry() As Ark.MutableSpawnPointSetEntry
		  // For the purposes of this method, we don't need a creature, but the class does. So give it one that will always exist. A dodo.
		  Var Entry As New Ark.MutableSpawnPointSetEntry(Ark.DataSource.Pool.Get(False).GetCreatureByUUID("08d6f1c5-6b8a-48b0-9232-e2705864c87c"))
		  
		  If Self.LevelOverrideMinField.Text <> "" And Self.LevelOverrideMaxField.Text <> "" Then
		    Entry.Append(Ark.SpawnPointLevel.FromUserLevel(Self.LevelOverrideMinField.DoubleValue, Self.LevelOverrideMaxField.DoubleValue, Self.mDifficulty))
		  End If
		  If Self.LevelMultiplierMinField.Text <> "" Then
		    Entry.MinLevelMultiplier = Self.LevelMultiplierMinField.DoubleValue
		  End If
		  If Self.LevelMultiplierMaxField.Text <> "" Then
		    Entry.MaxLevelMultiplier = Self.LevelMultiplierMaxField.DoubleValue
		  End If
		  If Self.LevelOffsetMinField.Text <> "" Then
		    Entry.MinLevelOffset = Self.LevelOffsetMinField.DoubleValue
		  End If
		  If Self.LevelOffsetMaxField.Text <> "" Then
		    Entry.MaxLevelOffset = Self.LevelOffsetMaxField.DoubleValue
		  End If
		  
		  Return Entry
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As DesktopWindow, Project As Ark.Project, Set As Ark.SpawnPointSet, Entry As Ark.MutableSpawnPointSetEntry = Nil) As Ark.MutableSpawnPointSetEntry
		  Var Entries() As Ark.MutableSpawnPointSetEntry
		  If Entry <> Nil Then
		    Entries.Add(Entry)
		  End If
		  
		  Var Results() As Ark.MutableSpawnPointSetEntry = Present(Parent, Project, Set, Entries)
		  If Results = Nil Or Results.LastIndex = -1 Then
		    Return Nil
		  End If
		  
		  Return Results(0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Present(Parent As DesktopWindow, Project As Ark.Project, Set As Ark.SpawnPointSet, Entries() As Ark.MutableSpawnPointSetEntry) As Ark.MutableSpawnPointSetEntry()
		  Var NewEntries() As Ark.MutableSpawnPointSetEntry
		  
		  If Parent = Nil Then
		    Return NewEntries
		  End If
		  
		  Var Win As New ArkSpawnPointCreatureDialog(Project, Entries, Set.LevelOffsetBeforeMultiplier)
		  Win.ShowModal(Parent)
		  If Win.mCancelled Then
		    Win.Close
		    Return NewEntries
		  End If
		  
		  NewEntries = Win.mEntries
		  
		  Win.Close
		  Return NewEntries
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateEffectiveLevel()
		  If IsNumeric(Self.LevelOverrideMinField.Text) And IsNumeric(Self.LevelOverrideMaxField.Text) Then
		    Self.LevelOverrideMinField.Enabled = True
		    Self.LevelOverrideMaxField.Enabled = True
		    Self.LevelOffsetMinField.Enabled = False
		    Self.LevelOffsetMaxField.Enabled = False
		    Self.LevelMultiplierMinField.Enabled = False
		    Self.LevelMultiplierMaxField.Enabled = False
		  ElseIf (IsNumeric(Self.LevelOffsetMinField.Text) And IsNumeric(Self.LevelOffsetMaxField.Text)) Or (IsNumeric(Self.LevelMultiplierMinField.Text) And IsNumeric(Self.LevelMultiplierMaxField.Text)) Then
		    Self.LevelOverrideMinField.Enabled = False
		    Self.LevelOverrideMaxField.Enabled = False
		    Self.LevelOffsetMinField.Enabled = True
		    Self.LevelOffsetMaxField.Enabled = True
		    Self.LevelMultiplierMinField.Enabled = True
		    Self.LevelMultiplierMaxField.Enabled = True
		  Else
		    Self.LevelOverrideMinField.Enabled = True
		    Self.LevelOverrideMaxField.Enabled = True
		    Self.LevelOffsetMinField.Enabled = True
		    Self.LevelOffsetMaxField.Enabled = True
		    Self.LevelMultiplierMinField.Enabled = True
		    Self.LevelMultiplierMaxField.Enabled = True
		  End If
		  
		  Var Entry As Ark.MutableSpawnPointSetEntry = Self.CreateEntry
		  If (Entry Is Nil) = False Then
		    Var Range As Beacon.Range = Entry.LevelRangeForDifficulty(Self.mDifficulty, Self.mOffsetBeforeMultiplier)
		    Self.EffectiveMinLevelField.Text = Range.Min.PrettyText
		    Self.EffectiveMaxLevelField.Text = Range.Max.PrettyText
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDifficulty As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEditedFields() As RangeField
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEntries() As Ark.MutableSpawnPointSetEntry
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMods As Beacon.StringList
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMultiEditMode As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOffsetBeforeMultiplier As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSettingUp As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTargetCreature As Ark.Creature
	#tag EndProperty


#tag EndWindowCode

#tag Events CreatureChooseButton
	#tag Event
		Sub Pressed()
		  Var Exclude() As Ark.Creature
		  Var Creatures() As Ark.Creature = ArkBlueprintSelectorDialog.Present(Self, "", Exclude, Self.mMods, ArkBlueprintSelectorDialog.SelectModes.Single)
		  If Creatures = Nil Or Creatures.LastIndex <> 0 Then
		    Return
		  End If
		  
		  Self.mTargetCreature = Creatures(0)
		  Self.CreatureNameLabel.Text = Self.mTargetCreature.Label
		  Self.CreatureNameLabel.Italic = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events OffsetFields
	#tag Event
		Sub ValueChanged(index as Integer)
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  If Self.mEditedFields.IndexOf(Me) = -1 Then
		    Self.mEditedFields.Add(Me)
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub RangeError(index as Integer, DesiredValue As Double, NewValue As Double)
		  #Pragma Unused DesiredValue
		  #Pragma Unused NewValue
		  
		  System.Beep
		End Sub
	#tag EndEvent
	#tag Event
		Sub GetRange(index as Integer, ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = -1000000
		  MaxValue = 1000000
		End Sub
	#tag EndEvent
	#tag Event
		Function AllowContents(index as Integer, Value As String) As Boolean
		  Return Value = ""
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events SpawnChanceField
	#tag Event
		Function AllowContents(Value As String) As Boolean
		  Return Value = ""
		End Function
	#tag EndEvent
	#tag Event
		Sub GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = 0.01
		  MaxValue = 100
		End Sub
	#tag EndEvent
	#tag Event
		Sub RangeError(DesiredValue As Double, NewValue As Double)
		  #Pragma Unused DesiredValue
		  #Pragma Unused NewValue
		  
		  System.Beep
		End Sub
	#tag EndEvent
	#tag Event
		Sub ValueChanged()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  If Self.mEditedFields.IndexOf(Me) = -1 Then
		    Self.mEditedFields.Add(Me)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ActionButton
	#tag Event
		Sub Pressed()
		  If Self.Focus IsA RangeField And RangeField(Self.Focus).Validate = False Then
		    Return
		  End If
		  
		  If Self.mTargetCreature = Nil And Self.mMultiEditMode = False Then
		    Self.ShowAlert("Please select a creature", "Use the ""Choose…"" button to select a target creature if you wish to continue.")
		    Return
		  End If
		  
		  If Self.mEntries.LastIndex = -1 Then
		    Self.mEntries.Add(New Ark.MutableSpawnPointSetEntry(Self.mTargetCreature))
		  End If
		  
		  For Each Entry As Ark.MutableSpawnPointSetEntry In Self.mEntries
		    If Self.mTargetCreature <> Nil Then
		      Entry.Creature = Self.mTargetCreature
		    End If
		    
		    Var OffsetX, OffsetY, OffsetZ As Double
		    
		    Var Offset As Beacon.Point3D = Entry.Offset
		    If Offset <> Nil Then
		      OffsetX = Offset.X
		      OffsetY = Offset.Y
		      OffsetZ = Offset.Z
		    End If
		    
		    If Self.mEditedFields.IndexOf(Self.OffsetFields(0)) > -1 Then
		      If Self.OffsetFields(0).Text <> "" Then
		        OffsetX = Self.OffsetFields(0).DoubleValue
		      Else
		        OffsetX = 0
		      End If
		    End If
		    If Self.mEditedFields.IndexOf(Self.OffsetFields(1)) > -1 Then
		      If Self.OffsetFields(1).Text <> "" Then
		        OffsetY = Self.OffsetFields(1).DoubleValue
		      Else
		        OffsetY = 0
		      End If
		    End If
		    If Self.mEditedFields.IndexOf(Self.OffsetFields(2)) > -1 Then
		      If Self.OffsetFields(2).Text <> "" Then
		        OffsetZ = Self.OffsetFields(2).DoubleValue
		      Else
		        OffsetZ = 0
		      End If
		    End If
		    
		    If OffsetX = 0 And OffsetY = 0 And OffsetZ = 0 Then
		      Entry.Offset = Nil
		    Else
		      Entry.Offset = New Beacon.Point3D(OffsetX, OffsetY, OffsetZ)
		    End If
		    
		    If Self.mEditedFields.IndexOf(Self.SpawnChanceField) > -1 Then
		      If Self.SpawnChanceField.Text <> "" Then
		        Entry.SpawnChance = Self.SpawnChanceField.DoubleValue / 100
		      Else
		        Entry.SpawnChance = Nil
		      End If
		    End If
		    
		    If Self.mEditedFields.IndexOf(Self.LevelOverrideMinField) > -1 Or Self.mEditedFields.IndexOf(Self.LevelOverrideMaxField) > -1 Then
		      Var MinLevel As Integer = Round(Self.mDifficulty)
		      Var MaxLevel As Integer = Round(Self.mDifficulty) * 30
		      
		      If Self.LevelOverrideMinField.Text <> "" Then
		        MinLevel = Round(Self.LevelOverrideMinField.DoubleValue)
		      End If
		      If Self.LevelOverrideMaxField.Text <> "" Then
		        MaxLevel = Round(Self.LevelOverrideMaxField.DoubleValue)
		      End If
		      
		      Entry.LevelCount = 0
		      Entry.Append(Ark.SpawnPointLevel.FromUserLevel(MinLevel, MaxLevel, Self.mDifficulty))
		      Entry.LevelOverride = Nil
		      Entry.MinLevelOffset = Nil
		      Entry.MaxLevelOffset = Nil
		      Entry.MinLevelMultiplier = Nil
		      Entry.MaxLevelMultiplier = Nil
		    ElseIf Self.mEditedFields.IndexOf(Self.LevelOffsetMinField) > -1 Or Self.mEditedFields.IndexOf(Self.LevelOffsetMaxField) > -1 Or Self.mEditedFields.IndexOf(Self.LevelMultiplierMinField) > -1 Or Self.mEditedFields.IndexOf(Self.LevelMultiplierMaxField) > -1 Then
		      Entry.LevelCount = 0
		      Entry.LevelOverride = Nil
		      If IsNumeric(Self.LevelOffsetMinField.Text) And IsNumeric(Self.LevelOffsetMaxField.Text) Then
		        Entry.MinLevelOffset = Self.LevelOffsetMinField.DoubleValue
		        Entry.MaxLevelOffset = Self.LevelOffsetMaxField.DoubleValue
		      Else
		        Entry.MinLevelOffset = Nil
		        Entry.MaxLevelOffset = Nil
		      End If
		      If IsNumeric(Self.LevelMultiplierMinField.Text) And IsNumeric(Self.LevelMultiplierMaxField.Text) Then
		        Entry.MinLevelMultiplier = Self.LevelMultiplierMinField.DoubleValue
		        Entry.MaxLevelMultiplier = Self.LevelMultiplierMaxField.DoubleValue
		      Else
		        Entry.MinLevelMultiplier = Nil
		        Entry.MaxLevelMultiplier = Nil
		      End If
		    End If
		    
		    If Self.mEditedFields.IndexOf(Self.LevelMultiplierMinField) > -1 Then
		      If Self.LevelMultiplierMinField.Text <> "" Then
		        Entry.MinLevelMultiplier = Self.LevelMultiplierMinField.DoubleValue
		      Else
		        Entry.MinLevelMultiplier = Nil
		      End If
		    End If
		    
		    If Self.mEditedFields.IndexOf(Self.LevelMultiplierMaxField) > -1 Then
		      If Self.LevelMultiplierMaxField.Text <> "" Then
		        Entry.MaxLevelMultiplier = Self.LevelMultiplierMaxField.DoubleValue
		      Else
		        Entry.MaxLevelMultiplier = Nil
		      End If
		    End If
		    
		    If Self.mEditedFields.IndexOf(Self.LevelOffsetMinField) > -1 Then
		      If Self.LevelOffsetMinField.Text <> "" Then
		        Entry.MinLevelOffset = Self.LevelOffsetMinField.DoubleValue
		      Else
		        Entry.MinLevelOffset = Nil
		      End If
		    End If
		    
		    If Self.mEditedFields.IndexOf(Self.LevelOffsetMaxField) > -1 Then
		      If Self.LevelOffsetMaxField.Text <> "" Then
		        Entry.MaxLevelOffset = Self.LevelOffsetMaxField.DoubleValue
		      Else
		        Entry.MaxLevelOffset = Nil
		      End If
		    End If
		  Next
		  
		  Self.mCancelled = False
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelButton
	#tag Event
		Sub Pressed()
		  Self.mCancelled = True
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LevelMultiplierMaxField
	#tag Event
		Function AllowContents(Value As String) As Boolean
		  Return Value = ""
		End Function
	#tag EndEvent
	#tag Event
		Sub GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = 0.00001
		  MaxValue = 1000000
		End Sub
	#tag EndEvent
	#tag Event
		Sub RangeError(DesiredValue As Double, NewValue As Double)
		  #Pragma Unused DesiredValue
		  #Pragma Unused NewValue
		  
		  System.Beep
		End Sub
	#tag EndEvent
	#tag Event
		Sub ValueChanged()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Self.UpdateEffectiveLevel()
		  If Self.mEditedFields.IndexOf(Me) = -1 Then
		    Self.mEditedFields.Add(Me)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LevelMultiplierMinField
	#tag Event
		Function AllowContents(Value As String) As Boolean
		  Return Value = ""
		End Function
	#tag EndEvent
	#tag Event
		Sub GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = 0.00001
		  MaxValue = 1000000
		End Sub
	#tag EndEvent
	#tag Event
		Sub RangeError(DesiredValue As Double, NewValue As Double)
		  #Pragma Unused DesiredValue
		  #Pragma Unused NewValue
		  
		  System.Beep
		End Sub
	#tag EndEvent
	#tag Event
		Sub ValueChanged()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Self.UpdateEffectiveLevel()
		  If Self.mEditedFields.IndexOf(Me) = -1 Then
		    Self.mEditedFields.Add(Me)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LevelOffsetMaxField
	#tag Event
		Function AllowContents(Value As String) As Boolean
		  Return Value = ""
		End Function
	#tag EndEvent
	#tag Event
		Sub GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = -1000000
		  MaxValue = 1000000
		End Sub
	#tag EndEvent
	#tag Event
		Sub RangeError(DesiredValue As Double, NewValue As Double)
		  #Pragma Unused DesiredValue
		  #Pragma Unused NewValue
		  
		  System.Beep
		End Sub
	#tag EndEvent
	#tag Event
		Sub ValueChanged()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Self.UpdateEffectiveLevel()
		  If Self.mEditedFields.IndexOf(Me) = -1 Then
		    Self.mEditedFields.Add(Me)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LevelOffsetMinField
	#tag Event
		Function AllowContents(Value As String) As Boolean
		  Return Value = ""
		End Function
	#tag EndEvent
	#tag Event
		Sub GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = -1000000
		  MaxValue = 1000000
		End Sub
	#tag EndEvent
	#tag Event
		Sub RangeError(DesiredValue As Double, NewValue As Double)
		  #Pragma Unused DesiredValue
		  #Pragma Unused NewValue
		  
		  System.Beep
		End Sub
	#tag EndEvent
	#tag Event
		Sub ValueChanged()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Self.UpdateEffectiveLevel()
		  If Self.mEditedFields.IndexOf(Me) = -1 Then
		    Self.mEditedFields.Add(Me)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LevelOverrideMaxField
	#tag Event
		Function AllowContents(Value As String) As Boolean
		  Return Value = ""
		End Function
	#tag EndEvent
	#tag Event
		Sub GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = 0.00001
		  MaxValue = 1000000
		End Sub
	#tag EndEvent
	#tag Event
		Sub RangeError(DesiredValue As Double, NewValue As Double)
		  #Pragma Unused DesiredValue
		  #Pragma Unused NewValue
		  
		  System.Beep
		End Sub
	#tag EndEvent
	#tag Event
		Sub ValueChanged()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Self.UpdateEffectiveLevel()
		  If Self.mEditedFields.IndexOf(Me) = -1 Then
		    Self.mEditedFields.Add(Me)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LevelOverrideMinField
	#tag Event
		Function AllowContents(Value As String) As Boolean
		  Return Value = ""
		End Function
	#tag EndEvent
	#tag Event
		Sub GetRange(ByRef MinValue As Double, ByRef MaxValue As Double)
		  MinValue = 0.00001
		  MaxValue = 1000000
		End Sub
	#tag EndEvent
	#tag Event
		Sub RangeError(DesiredValue As Double, NewValue As Double)
		  #Pragma Unused DesiredValue
		  #Pragma Unused NewValue
		  
		  System.Beep
		End Sub
	#tag EndEvent
	#tag Event
		Sub ValueChanged()
		  If Self.mSettingUp Then
		    Return
		  End If
		  
		  Self.UpdateEffectiveLevel()
		  If Self.mEditedFields.IndexOf(Me) = -1 Then
		    Self.mEditedFields.Add(Me)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
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
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
