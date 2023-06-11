#tag Class
Protected Class PopoverController
	#tag Method, Flags = &h0
		Sub Constructor(Title As String, Container As DesktopContainer)
		  Self.mContainer = Container
		  
		  If Container IsA PopoverContainer Then
		    Var L, R, T, B As Integer
		    PopoverContainer(Container).GetPadding(L, T, R, B)
		    Self.mPaddingLeft = 20 - L
		    Self.mPaddingTop = 20 - T
		    Self.mPaddingRight = 20 - R
		    Self.mPaddingBottom = 20 - B
		  Else
		    Var MinX, MinY As Integer
		    Var ContainerBound As Integer = Container.ControlCount - 1
		    Var Initial As Boolean = True
		    For Idx As Integer = 0 To ContainerBound
		      If (Container.ControlAt(Idx) IsA RectControl) = False Then
		        Continue
		      End If
		      
		      Var Ctl As DesktopUIControl = DesktopUIControl(Container.ControlAt(Idx))
		      If Initial Then
		        MinX = Ctl.Left
		        MinY = Ctl.Top
		        Initial = False
		      Else
		        MinX = Min(MinX, Ctl.Left)
		        MinY = Min(MinY, Ctl.Top)
		      End If
		    Next
		    Self.mPaddingLeft = 20 - MinX
		    Self.mPaddingTop = 20 - MinY
		    Self.mPaddingRight = Self.mPaddingLeft
		    Self.mPaddingBottom = Self.mPaddingTop
		  End If
		  
		  Self.mDialog = New PopoverDialog(Self)
		  Self.mDialog.Visible = False
		  Self.mDialog.Title = Title
		  Self.mDialog.Embed(Container, Self.mPaddingLeft, Self.mPaddingTop)
		  
		  If Container IsA BeaconSubview Then
		    Try
		      AddHandler BeaconSubview(Container).Resize, WeakAddressOf Subview_Resize
		    Catch Err As RuntimeException
		    End Try
		  Else
		    Try
		      AddHandler Container.Resizing, WeakAddressOf Container_Resize
		      AddHandler Container.Resized, WeakAddressOf Container_Resize
		    Catch AnotherErr As RuntimeException
		    End Try
		  End If
		  
		  #if TargetMacOS
		    If NSPopoverMBS.Available Then
		      Var ViewController As New NSViewControllerMBS
		      ViewController.View = Container.NSViewMBS
		      ViewController.View.SetBoundsOrigin(New NSPointMBS(Self.mPaddingLeft * -1, Self.mPaddingBottom)) // No idea why the X should be negative here
		      
		      Self.mPopover = New BeaconPopover
		      Self.mPopover.ContentViewController = ViewController
		      Self.mPopover.ContentSize = New NSSizeMBS(Container.Width + (Self.mPaddingLeft + Self.mPaddingRight), Container.Height + (Self.mPaddingTop + Self.mPaddingBottom))
		      Self.mPopover.Animates = True
		      Self.mPopover.Behavior = NSPopoverMBS.NSPopoverBehaviorSemitransient
		      
		      AddHandler mPopover.popoverWillClose, WeakAddressOf mPopover_WillDismiss
		    End If
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Container() As DesktopContainer
		  Return Self.mContainer
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Container_Resize(Sender As DesktopContainer)
		  Var CurrentWidth As Integer = Self.mDialog.Width
		  Var TargetWidth As Integer = Sender.Width + Self.mPaddingLeft + Self.mPaddingRight
		  Var TargetHeight As Integer = Sender.Height + Self.mPaddingTop + Self.mPaddingBottom + 40
		  Var DeltaX As Integer = CurrentWidth - TargetWidth
		  
		  Self.mDialog.MaximumWidth = TargetWidth
		  Self.mDialog.MaximumHeight = TargetHeight
		  Self.mDialog.Width = TargetWidth
		  Self.mDialog.Height = TargetHeight
		  Self.mDialog.MinimumWidth = TargetWidth
		  Self.mDialog.MinimumHeight = TargetHeight
		  
		  Self.mDialog.Left = Self.mDialog.Left + Floor(DeltaX / 2)
		  #if Not TargetMacOS
		    Var CurrentHeight As Integer = Self.mDialog.Height
		    Var DeltaY As Integer = CurrentHeight - TargetHeight
		    Self.mDialog.Top = Self.mDialog.Top + Floor(DeltaY / 2)
		  #endif
		  
		  If (Self.mPopover Is Nil) = False Then
		    Self.mPopover.Animates = False
		    Self.mPopover.ContentViewController.View.SetBoundsOrigin(New NSPointMBS(0, 0))
		    Self.mPopover.ContentSize = New NSSizeMBS(Sender.Width + Self.mPaddingLeft + Self.mPaddingRight, Sender.Height + Self.mPaddingTop + Self.mPaddingBottom)
		    Self.mPopover.Animates = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  Var UseDelayedClosing As Boolean
		  If (Self.mPopover Is Nil) = False Then
		    If Self.mPopover.IsShown Then
		      UseDelayedClosing = True
		      Self.mPopover.PerformClose
		    End If
		    Self.mPopover = Nil
		  End If
		  
		  // Needs to close the dialog after the popover animation
		  If (Self.mDialog Is Nil) = False Then
		    If UseDelayedClosing Then
		      Call CallLater.Schedule(2000, AddressOf mDialog.Close)
		    Else
		      Self.mDialog.Close
		      Self.mDialog = Nil
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Dismiss(Cancelled As Boolean)
		  If Not Self.Visible Then
		    Return
		  End If
		  
		  If Self.mPopover Is Nil Then
		    RaiseEvent Finished(Cancelled)
		    Self.mVisible = False
		    Self.mDialog.Hide
		  Else
		    Self.mPopover.PerformClose
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mPopover_WillDismiss(Sender As BeaconPopover, Notification As NSNotificationMBS)
		  #Pragma Unused Sender
		  #Pragma Unused Notification
		  
		  RaiseEvent Finished(False)
		  Self.mVisible = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Show(Parent As DesktopUIControl)
		  Self.Show(Parent, New Rect(0, 0, Parent.Width, Parent.Height))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Show(Parent As DesktopUIControl, InsetRect As Rect)
		  If Self.Visible Or Parent Is Nil Or Parent.Window Is Nil Then
		    Return
		  End If
		  
		  Self.mVisible = True
		  
		  If Self.mPopover Is Nil Then
		    Self.mDialog.Show(Parent.Window)
		  Else
		    Var ParentView As NSViewMBS = Parent.NSViewMBS
		    Var PositionRect As NSRectMBS
		    If InsetRect Is Nil Then
		      PositionRect = ParentView.Bounds
		    Else
		      PositionRect = New NSRectMBS(InsetRect.Left, InsetRect.Top, InsetRect.Width, InsetRect.Height)
		    End If
		    Self.mPopover.ShowRelativeToRect(PositionRect, ParentView, NSPopoverMBS.MinYEdge)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Subview_Resize(Sender As BeaconSubview, Initial As Boolean)
		  #Pragma Unused Sender
		  #Pragma Unused Initial
		  
		  Self.Container_Resize(Sender)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Visible() As Boolean
		  If Self.mPopover Is Nil Then
		    Return Self.mVisible
		  Else
		    Return Self.mPopover.isShown
		  End If
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Finished(Cancelled As Boolean)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mContainer As DesktopContainer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDialog As PopoverDialog
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPaddingBottom As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPaddingLeft As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPaddingRight As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPaddingTop As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPopover As BeaconPopover
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mVisible As Boolean
	#tag EndProperty


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
