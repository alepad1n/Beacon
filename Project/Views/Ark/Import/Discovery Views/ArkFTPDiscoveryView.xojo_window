#tag Window
Begin ArkDiscoveryView ArkFTPDiscoveryView
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackgroundColor=   False
   Height          =   310
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
   Width           =   600
   Begin PagePanel ViewPanel
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   310
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   3
      Panels          =   ""
      Scope           =   2
      TabIndex        =   17
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   False
      Value           =   2
      Visible         =   True
      Width           =   600
      Begin UITweaks.ResizedLabel ServerModeLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
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
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Mode:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   238
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   126
      End
      Begin UITweaks.ResizedPopupMenu ServerModeMenu
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         InitialValue    =   "Autodetect\nFTP\nFTP with TLS\nSFTP"
         Italic          =   False
         Left            =   158
         ListIndex       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   238
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   142
      End
      Begin Label ExplanationLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   38
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   True
         Scope           =   2
         Selectable      =   False
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Beacon will securely send this information to the Beacon API server, which will perform the FTP work. The server will not store or log FTP information in any way."
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   52
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin Label ServerMessageLabel
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
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
         TabIndex        =   3
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Server Settings"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   20
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin UITweaks.ResizedLabel ServerHostLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
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
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Host:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   102
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   126
      End
      Begin UITweaks.ResizedTextField ServerHostField
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   158
         LimitText       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Mask            =   ""
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   5
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   102
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   422
      End
      Begin UITweaks.ResizedLabel ServerPortLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
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
         TabIndex        =   6
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Port:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   136
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   126
      End
      Begin UITweaks.ResizedTextField ServerPortField
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   158
         LimitText       =   5
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Mask            =   "#####"
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   7
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "21"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   136
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   101
      End
      Begin UITweaks.ResizedLabel ServerUserLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
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
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Username:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   170
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   126
      End
      Begin UITweaks.ResizedTextField ServerUserField
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   158
         LimitText       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Mask            =   ""
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   9
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   170
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   422
      End
      Begin UITweaks.ResizedLabel ServerPassLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
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
         TabIndex        =   10
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Password:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   204
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   126
      End
      Begin UITweaks.ResizedTextField ServerPassField
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   158
         LimitText       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Mask            =   ""
         Password        =   True
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   11
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   204
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   422
      End
      Begin Label DiscoveringMessage
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
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
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Connecting to Server…"
         TextAlign       =   1
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   129
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin ProgressBar DiscoveringProgress
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Indeterminate   =   False
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Maximum         =   0
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   True
         Top             =   161
         Transparent     =   False
         Value           =   0.0
         Visible         =   True
         Width           =   560
      End
      Begin Label BrowseMessage
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
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
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "Please locate your Game.ini file"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin UITweaks.ResizedPushButton BrowseActionButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "Next"
         Default         =   True
         Enabled         =   False
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   500
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   270
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton BrowseCancelButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   True
         Caption         =   "Cancel"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   408
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   270
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin ColumnBrowser Browser
         AcceptFocus     =   False
         AcceptTabs      =   True
         AutoDeactivate  =   True
         BackColor       =   &cFFFFFF00
         Backdrop        =   0
         CurrentPath     =   ""
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   True
         HasBackColor    =   False
         Height          =   204
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Left            =   21
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   7
         TabPanelIndex   =   3
         TabStop         =   True
         Top             =   53
         Transparent     =   True
         UseFocusRing    =   False
         Visible         =   True
         Width           =   558
      End
      Begin ProgressWheel BrowseSpinner
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   16
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         Scope           =   2
         TabIndex        =   9
         TabPanelIndex   =   3
         TabStop         =   True
         Top             =   274
         Transparent     =   False
         Visible         =   False
         Width           =   16
      End
      Begin UITweaks.ResizedPushButton ServerCancelButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   True
         Caption         =   "Cancel"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   408
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   12
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   270
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin UITweaks.ResizedPushButton ServerActionButton
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "Next"
         Default         =   True
         Enabled         =   False
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   500
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   13
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   270
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin FadedSeparator BrowseBorders
         AcceptFocus     =   False
         AcceptTabs      =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         ContentHeight   =   0
         DoubleBuffer    =   False
         Enabled         =   True
         Height          =   1
         HelpTag         =   ""
         Index           =   0
         InitialParent   =   "ViewPanel"
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   3
         TabPanelIndex   =   3
         TabStop         =   True
         Top             =   52
         Transparent     =   True
         UseFocusRing    =   True
         Visible         =   True
         Width           =   560
      End
      Begin FadedSeparator BrowseBorders
         AcceptFocus     =   False
         AcceptTabs      =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         ContentHeight   =   0
         DoubleBuffer    =   False
         Enabled         =   True
         Height          =   1
         HelpTag         =   ""
         Index           =   1
         InitialParent   =   "ViewPanel"
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   4
         TabPanelIndex   =   3
         TabStop         =   True
         Top             =   257
         Transparent     =   True
         UseFocusRing    =   True
         Visible         =   True
         Width           =   560
      End
      Begin FadedSeparator BrowseBorders
         AcceptFocus     =   False
         AcceptTabs      =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         ContentHeight   =   0
         DoubleBuffer    =   False
         Enabled         =   True
         Height          =   204
         HelpTag         =   ""
         Index           =   2
         InitialParent   =   "ViewPanel"
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   5
         TabPanelIndex   =   3
         TabStop         =   True
         Top             =   53
         Transparent     =   True
         UseFocusRing    =   True
         Visible         =   True
         Width           =   1
      End
      Begin FadedSeparator BrowseBorders
         AcceptFocus     =   False
         AcceptTabs      =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         ContentHeight   =   0
         DoubleBuffer    =   False
         Enabled         =   True
         Height          =   204
         HelpTag         =   ""
         Index           =   3
         InitialParent   =   "ViewPanel"
         Left            =   579
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   6
         TabPanelIndex   =   3
         TabStop         =   True
         Top             =   53
         Transparent     =   True
         UseFocusRing    =   True
         Visible         =   True
         Width           =   1
      End
      Begin CheckBox VerifyCertificateCheck
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Verify Certificate (TLS Only)"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "ViewPanel"
         Italic          =   False
         Left            =   312
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         State           =   1
         TabIndex        =   14
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   238
         Transparent     =   False
         Underline       =   False
         Value           =   True
         Visible         =   True
         Width           =   268
      End
   End
   Begin Timer StatusWatcher
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   50
      RunMode         =   0
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin ClipboardWatcher URLWatcher
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   1000
      RunMode         =   2
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Begin()
		  Self.DesiredHeight = 310
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  RaiseEvent Open
		  Self.SwapButtons()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub CheckHostForPort()
		  Var Checker As New Regex
		  Checker.SearchPattern = ":(\d{1,5})$"
		  Checker.ReplacementPattern = ""
		  
		  Var CheckedValue As String = Self.ServerHostField.Text.Trim
		  
		  Var Matches As RegexMatch = Checker.Search(CheckedValue)
		  If Matches Is Nil Then
		    If Self.ServerHostField.Text <> CheckedValue Then
		      Self.ServerHostField.Text = CheckedValue
		    End If
		    Return
		  End If
		  
		  Self.ServerHostField.Text = CheckedValue.Left(CheckedValue.Length - Matches.SubExpressionString(0).Length)
		  Self.ServerPortField.Text = Matches.SubExpressionString(1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckServerActionButton()
		  Var Enabled As Boolean = Self.ServerHostField.Text.Length > 0 And Val(Self.ServerPortField.Text) > 0 And Self.ServerUserField.Text.Length > 0 And Self.ServerPassField.Text.Length > 0
		  If Self.ServerActionButton.Enabled <> Enabled Then
		    Self.ServerActionButton.Enabled = Enabled
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mEngine_Discovered(Sender As Ark.FTPIntegrationEngine, Data() As Beacon.DiscoveredData)
		  #Pragma Unused Sender
		  
		  Self.StatusWatcher.RunMode = Timer.RunModes.Off
		  Self.ShouldFinish(Data)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mEngine_FileListError(Sender As Ark.FTPIntegrationEngine, Err As RuntimeException)
		  #Pragma Unused Sender
		  
		  Self.StatusWatcher.RunMode = Timer.RunModes.Off
		  Self.Browser.Enabled = True
		  Self.BrowseSpinner.Visible = False
		  
		  Var Reason As String
		  If Err.Message.IsEmpty Then
		    Var Info As Introspection.TypeInfo = Introspection.GetType(Err)
		    Reason = "Unhandled " + Info.FullName
		  Else
		    Reason = Err.Message
		  End If
		  
		  Self.ShowAlert("Beacon was unable to retrieve the file list.", Reason)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mEngine_FilesListed(Sender As Ark.FTPIntegrationEngine, Path As String, Files() As Beacon.FTPFileListing)
		  #Pragma Unused Sender
		  #Pragma Unused Path
		  
		  Self.StatusWatcher.RunMode = Timer.RunModes.Off
		  Self.Browser.Enabled = True
		  Self.BrowseSpinner.Visible = False
		  
		  Var Children() As String
		  For Each File As Beacon.FTPFileListing In Files
		    If File.Filename = "." Or File.Filename = ".." Then
		      Continue
		    End If
		    
		    Var Child As String = File.Filename
		    If File.IsDirectory Then
		      Child = Child + "/"
		    End If
		    Children.Add(Child)
		  Next
		  Self.Browser.AppendChildren(Children)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function mEngine_Wait(Sender As Ark.FTPIntegrationEngine, Controller As Beacon.TaskWaitController) As Boolean
		  #Pragma Unused Sender
		  
		  Select Case Controller.Action
		  Case "Locate Game.ini"
		    // Beacon could not find anything, so we need to show a file browser
		    Self.mActiveController = Controller
		    Self.mBrowserRoot = Dictionary(Controller.UserData).Value("Root")
		    Self.ViewPanel.SelectedPanelIndex = Self.PageBrowse
		    Self.Browser.Reset()
		    Return True
		  End Select
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mActiveController As Beacon.TaskWaitController
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBrowserRoot As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEngine As Ark.FTPIntegrationEngine
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProfile As Ark.FTPServerProfile
	#tag EndProperty


	#tag Constant, Name = PageBrowse, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageDiscovering, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PageGeneral, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events ViewPanel
	#tag Event
		Sub Change()
		  If Me.SelectedPanelIndex = Self.PageDiscovering Then
		    Self.StatusWatcher.RunMode = Timer.RunModes.Multiple
		  Else
		    Self.StatusWatcher.RunMode = Timer.RunModes.Off
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ServerModeMenu
	#tag Event
		Sub Change()
		  Self.VerifyCertificateCheck.Visible = Me.SelectedRowIndex = 0 Or Me.SelectedRowIndex = 2
		  Self.VerifyCertificateCheck.Caption = If(Me.SelectedRowIndex = 0, "Verify Certificate (TLS Only)", "Verify Certificate")
		  
		  Self.CheckServerActionButton
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ServerHostField
	#tag Event
		Sub TextChange()
		  Self.CheckServerActionButton()
		End Sub
	#tag EndEvent
	#tag Event
		Sub LostFocus()
		  Self.CheckHostForPort()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ServerPortField
	#tag Event
		Sub TextChange()
		  Self.CheckServerActionButton()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ServerUserField
	#tag Event
		Sub TextChange()
		  Self.CheckServerActionButton()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ServerPassField
	#tag Event
		Sub TextChange()
		  Self.CheckServerActionButton()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events BrowseActionButton
	#tag Event
		Sub Action()
		  Var GameIniPath As String = Self.Browser.CurrentPath
		  Var Components() As String = GameIniPath.Split("/")
		  If Components.LastIndex <= 2 Then
		    Self.ShowAlert("FTP Access Too Restrictive", "Beacon needs to be able to access this server's ""Logs"" folder too, to learn more about the server than the config files can provide. The path to this server's Game.ini does not allow access to other directories needed within Ark's ""Saved"" directory.")
		    Return
		  End If
		  Components.RemoveAt(Components.LastIndex) // Remove Game.ini
		  Components.RemoveAt(Components.LastIndex) // Remove WindowsServer
		  Components.RemoveAt(Components.LastIndex) // Remove Config
		  
		  // Should now equal the "Saved" directory
		  Dictionary(Self.mActiveController.UserData).Value("path") = Components.Join("/")
		  Self.mActiveController.Cancelled = False
		  Self.mActiveController.ShouldResume = True
		  
		  Self.ViewPanel.SelectedPanelIndex = Self.PageDiscovering
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events BrowseCancelButton
	#tag Event
		Sub Action()
		  Self.ViewPanel.SelectedPanelIndex = Self.PageGeneral
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Browser
	#tag Event
		Sub NeedsChildrenForPath(Path As String)
		  If Self.mEngine = Nil Then
		    Return
		  End If
		  
		  Self.Browser.Enabled = False
		  Self.BrowseSpinner.Visible = True
		  
		  Var Empty() As String
		  Me.AppendChildren(Empty)
		  
		  Self.mEngine.ListFiles(Path)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PathSelected(Path As String)
		  Self.BrowseActionButton.Enabled = Path.EndsWith(Ark.ConfigFileGame)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ServerCancelButton
	#tag Event
		Sub Action()
		  Self.StatusWatcher.RunMode = Timer.RunModes.Off
		  
		  Self.ShouldCancel()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ServerActionButton
	#tag Event
		Sub Action()
		  Self.CheckHostForPort()
		  
		  Self.mProfile = New Ark.FTPServerProfile()
		  Self.mProfile.Host = Self.ServerHostField.Text
		  Self.mProfile.Port = CDbl(Self.ServerPortField.Text)
		  Self.mProfile.Username = Self.ServerUserField.Text
		  Self.mProfile.Password = Self.ServerPassField.Text
		  Self.mProfile.VerifyHost = Self.VerifyCertificateCheck.Value
		  
		  Select Case Self.ServerModeMenu.SelectedRowIndex
		  Case 1
		    Self.mProfile.Mode = Ark.FTPServerProfile.ModeFTP
		  Case 2
		    Self.mProfile.Mode = Ark.FTPServerProfile.ModeFTPTLS
		  Case 3
		    Self.mProfile.Mode = Ark.FTPServerProfile.ModeSFTP
		  Else
		    Self.mProfile.Mode = Ark.FTPServerProfile.ModeAuto
		  End Select
		  
		  Self.ViewPanel.SelectedPanelIndex = Self.PageDiscovering
		  
		  Self.mEngine = New Ark.FTPIntegrationEngine(Self.mProfile)
		  Self.mEngine.VerifyHost = Self.VerifyCertificateCheck.Value
		  AddHandler mEngine.Wait, WeakAddressOf mEngine_Wait
		  AddHandler mEngine.Discovered, WeakAddressOf mEngine_Discovered
		  AddHandler mEngine.FilesListed, WeakAddressOf mEngine_FilesListed
		  AddHandler mEngine.FileListError, WeakAddressOf mEngine_FileListError
		  Self.mEngine.BeginDiscovery(Self.Project)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events StatusWatcher
	#tag Event
		Sub Action()
		  If Self.ViewPanel.SelectedPanelIndex = Self.PageDiscovering And Self.mEngine <> Nil Then
		    If Self.mEngine.Errored And Self.mEngine.Finished Then
		      Me.RunMode = Timer.RunModes.Off
		      
		      Var ErrorMessage As String = Self.mEngine.Logs(True)
		      Self.ShowAlert("There was a problem connecting to the FTP server", ErrorMessage)
		      Self.ViewPanel.SelectedPanelIndex = Self.PageGeneral
		    Else
		      Self.DiscoveringMessage.Text = Self.mEngine.Logs(True)
		    End If
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events URLWatcher
	#tag Event
		Sub ClipboardChanged(Content As String)
		  Var Matcher As New Regex
		  Matcher.SearchPattern = "^((ftp|ftps|sftp)://)?(([^@:\s]+):([^@:\s]+)@)?([^/:\s]+\.[^/:\s]+)(:(\d{1,5}))?"
		  
		  Var Matches As RegexMatch = Matcher.Search(Content)
		  If Matches Is Nil Then
		    Return
		  End If
		  
		  Var Protocol As String = If(Matches.SubExpressionCount >= 2, DecodeURLComponent(Matches.SubExpressionString(2)), "")
		  Var Username As String = If(Matches.SubExpressionCount >= 4, DecodeURLComponent(Matches.SubExpressionString(4)), "")
		  Var Password As String = If(Matches.SubExpressionCount >= 5, DecodeURLComponent(Matches.SubExpressionString(5)), "")
		  Var Host As String = If(Matches.SubExpressionCount >= 6, DecodeURLComponent(Matches.SubExpressionString(6)), "")
		  Var Port As String = If(Matches.SubExpressionCount >= 8, DecodeURLComponent(Matches.SubExpressionString(8)), "")
		  
		  Select Case Protocol
		  Case "ftp"
		    Self.ServerModeMenu.SelectedRowIndex = 1
		    If Port.IsEmpty Then
		      Port = "21"
		    End If
		  Case "ftps"
		    Self.ServerModeMenu.SelectedRowIndex = 2
		    If Port.IsEmpty Then
		      Port = "21"
		    End If
		  Case "sftp"
		    Self.ServerModeMenu.SelectedRowIndex = 3
		    If Port.IsEmpty Then
		      Port = "22"
		    End If
		  Else
		    Self.ServerModeMenu.SelectedRowIndex = 0
		  End Select
		  
		  If Host.IsEmpty = False Then
		    Self.ServerHostField.Text = Host
		  End If
		  If Port.IsEmpty = False Then
		    Self.ServerPortField.Text = Port
		  End If
		  If Username.IsEmpty = False Then
		    Self.ServerUserField.Text = Username
		  End If
		  If Password.IsEmpty = False Then
		    Self.ServerPassField.Text = Password
		  End If
		  
		  Exception Err As RuntimeException
		    Return
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
		Name="EraseBackground"
		Visible=false
		Group="Behavior"
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
		Type="Color"
		EditorType="Color"
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
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
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
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
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
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
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
		Name="LockRight"
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
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Integer"
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
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
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
#tag EndViewBehavior
