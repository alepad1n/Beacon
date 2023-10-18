#tag Class
Protected Class Map
	#tag Method, Flags = &h0
		Sub Constructor(HumanName As String, Identifier As String, Mask As UInt64, DifficultyScale As Double, Official As Boolean, ProvidedByContentPackId As String)
		  Self.mName = HumanName
		  Self.mIdentifier = Identifier
		  Self.mMask = Mask
		  Self.mDifficultyScale = DifficultyScale
		  Self.mOfficial = Official
		  Self.mProvidedByContentPackId = ProvidedByContentPackId
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DifficultyOffset(DifficultyValue As Double) As Double
		  #Pragma StackOverflowChecking False
		  Return Min((DifficultyValue - 0.5) / (Self.mDifficultyScale - 0.5), 1.0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DifficultyScale() As Double
		  #Pragma StackOverflowChecking False
		  Return Self.mDifficultyScale
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DifficultyValue(DifficultyOffset As Double) As Double
		  #Pragma StackOverflowChecking False
		  DifficultyOffset = Min(DifficultyOffset, 1.0)
		  Return (DifficultyOffset * (Self.mDifficultyScale - 0.5)) + 0.5
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identifier() As String
		  #Pragma StackOverflowChecking False
		  Return Self.mIdentifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Mask() As UInt64
		  #Pragma StackOverflowChecking False
		  Return Self.mMask
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Matches(Value As UInt64) As Boolean
		  #Pragma StackOverflowChecking False
		  Return (Value And Self.mMask) = Self.mMask
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  Return Self.mName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Official() As Boolean
		  #Pragma StackOverflowChecking False
		  Return Self.mOfficial
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Ark.Map) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  If Self.mMask > Other.mMask Then
		    Return 1
		  ElseIf Self.mMask < Other.mMask Then
		    Return -1
		  Else
		    Return 0
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As UInt64
		  #Pragma StackOverflowChecking False
		  Return Self.mMask
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProvidedByContentPackId() As String
		  #Pragma StackOverflowChecking False
		  Return Self.mProvidedByContentPackId
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mDifficultyScale As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIdentifier As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMask As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOfficial As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProvidedByContentPackId As String
	#tag EndProperty


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
End Class
#tag EndClass
