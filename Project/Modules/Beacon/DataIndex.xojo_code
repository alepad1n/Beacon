#tag Class
Protected Class DataIndex
	#tag Method, Flags = &h21
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(TableName As String, Unique As Boolean, ParamArray Columns() As String)
		  Var WhereClause As String
		  Var IndexName As String = TableName.Lowercase + "_" + EncodeHex(Crypto.MD5(String.FromArray(Columns, ";").Lowercase)).Lowercase + If(Unique, "_uidx", "_idx")
		  Var EscapedColumns() As String
		  EscapedColumns.ResizeTo(Columns.LastIndex)
		  For Idx As Integer = Columns.LastIndex DownTo 0
		    If Columns(Idx).BeginsWith("Where") = False Then
		      Continue
		    End If
		    WhereClause = Columns(Idx)
		    Columns.RemoveAt(Idx)
		    EscapedColumns.RemoveAt(Idx)
		    Continue
		  Next
		  For Idx As Integer = 0 To Columns.LastIndex
		    EscapedColumns(Idx) = Beacon.DataSource.EscapeIdentifier(Columns(Idx))
		  Next
		  
		  Self.mCreateStatement = "CREATE " + If(Unique, "UNIQUE ", "") + "INDEX IF NOT EXISTS " + Beacon.DataSource.EscapeIdentifier(IndexName) + " ON " + Beacon.DataSource.EscapeIdentifier(TableName) + "(" + String.FromArray(EscapedColumns, ", ") + ")"
		  If WhereClause.IsEmpty = False Then
		    Self.mCreateStatement = Self.mCreateStatement + " " + WhereClause
		  End If
		  Self.mCreateStatement = Self.mCreateStatement + ";"
		  Self.mDropStatement = "DROP INDEX IF EXISTS " + Beacon.DataSource.EscapeIdentifier(IndexName) + ";"
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateCustom(CreateStatement As String, DropStatement As String) As Beacon.DataIndex
		  Var Index As New Beacon.DataIndex
		  Index.mCreateStatement = CreateStatement
		  Index.mDropStatement = DropStatement
		  Return Index
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateStatement() As String
		  Return Self.mCreateStatement
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DropStatement() As String
		  Return Self.mDropStatement
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCreateStatement As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDropStatement As String
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
