#tag Class
Protected Class IntegrationTransfer
	#tag Method, Flags = &h0
		Sub Constructor(Path As String)
		  Self.mPath = Path
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Path As String, Content As String)
		  Self.Constructor(Path)
		  Self.Content = Content
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Path() As String
		  Return Self.mPath
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetError(Err As RuntimeException)
		  Self.Success = False
		  
		  If Err Is Nil Then
		    Self.ErrorMessage = "Nil exception"
		    Return
		  End If
		  
		  Var Info As Introspection.TypeInfo = Introspection.GetType(Err)
		  Self.ErrorMessage = "Unhandled " + Info.Name + ": " + Err.Message
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetError(Message As String)
		  Self.ErrorMessage = Message
		  Self.Success = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SHA256() As String
		  Return EncodeHex(Crypto.SHA2_256(Self.Content)).Lowercase
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Size() As Integer
		  Return Self.Content.Bytes
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Content As String
	#tag EndProperty

	#tag Property, Flags = &h0
		ErrorMessage As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPath As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Success As Boolean
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
		#tag ViewProperty
			Name="Content"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ErrorMessage"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Success"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
