#tag Module
Protected Module UITweaks
	#tag Method, Flags = &h1
		Protected Sub SwapButtons(ActionButton As DesktopButton, CancelButton As DesktopButton)
		  Var ActionRect As New Rect(ActionButton.Left, ActionButton.Top, ActionButton.Width, ActionButton.Height)
		  Var CancelRect As New Rect(CancelButton.Left, CancelButton.Top, CancelButton.Width, CancelButton.Height)
		  Var ActionIsLeft As Boolean = ActionRect.Left < CancelButton.Left
		  
		  If (ActionIsLeft And TargetMacOS) Or (ActionIsLeft = False And TargetWindows) Then
		    ActionButton.Left = CancelRect.Left
		    ActionButton.Top = CancelRect.Top
		    ActionButton.Width = CancelRect.Width
		    ActionButton.Height = CancelRect.Height
		    CancelButton.Left = ActionRect.Left
		    CancelButton.Top = ActionRect.Top
		    CancelButton.Width = ActionRect.Width
		    CancelButton.Height = ActionRect.Height
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SwapButtons(Extends Win As DesktopWindow, PanelIndex As Integer = -1)
		  Var DefaultButton As DesktopButton
		  Var CancelButton As DesktopButton
		  Var ControlCount As Integer = Win.ControlCount
		  For I As Integer = 0 To ControlCount - 1
		    Var Ctl As Object = Win.ControlAt(I)
		    If (Ctl IsA DesktopUIControl) = False Then
		      Continue
		    End If
		    
		    Var ControlPanelIndex As Integer = DesktopUIControl(Ctl).PanelIndex
		    #if TargetWindows And Target64Bit
		      // Bug <feedback://showreport?report_id=54283>
		      #if XojoVersion >= 2018.03 And XojoVersion < 2018.04
		        If ControlPanelIndex = 4294967295 Then
		          ControlPanelIndex = -1
		        End If
		      #endif
		    #endif
		    If ControlPanelIndex <> PanelIndex Then
		      Continue
		    End If
		    If Ctl IsA DesktopButton Then
		      If DesktopButton(Ctl).Default And DefaultButton Is Nil Then
		        DefaultButton = DesktopButton(Ctl)
		      ElseIf DesktopButton(Ctl).Cancel And CancelButton Is Nil Then
		        CancelButton = DesktopButton(Ctl)
		      End If
		    ElseIf Ctl IsA DesktopPagePanel Then
		      Var PanelCount As Integer = DesktopPagePanel(Ctl).PanelCount
		      For Idx As Integer = 0 To PanelCount - 1
		        Win.SwapButtons(Idx)
		      Next
		    End If
		  Next
		  If DefaultButton Is Nil Or CancelButton Is Nil Then
		    Return
		  End If
		  
		  Var LeftButton As DesktopButton = if(DefaultButton.Left < CancelButton.Left, DefaultButton, CancelButton)
		  Var RightButton As DesktopButton = if(DefaultButton.Left < CancelButton.Left, CancelButton, DefaultButton)
		  Var LeftRect As New Rect(LeftButton.Left, LeftButton.Top, LeftButton.Width, LeftButton.Height)
		  Var RightRect As New Rect(RightButton.Left, RightButton.Top, RightButton.Width, RightButton.Height)
		  
		  #if TargetWindows
		    DefaultButton.Left = LeftRect.Left
		    DefaultButton.Top = LeftRect.Top
		    DefaultButton.Width = LeftRect.Width
		    DefaultButton.Height = LeftRect.Height
		    CancelButton.Left = RightRect.Left
		    CancelButton.Top = RightRect.Top
		    CancelButton.Width = RightRect.Width
		    CancelButton.Height = RightRect.Height
		  #else
		    DefaultButton.Left = RightRect.Left
		    DefaultButton.Top = RightRect.Top
		    DefaultButton.Width = RightRect.Width
		    DefaultButton.Height = RightRect.Height
		    CancelButton.Left = LeftRect.Left
		    CancelButton.Top = LeftRect.Top
		    CancelButton.Width = LeftRect.Width
		    CancelButton.Height = LeftRect.Height
		  #endif
		End Sub
	#tag EndMethod


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
