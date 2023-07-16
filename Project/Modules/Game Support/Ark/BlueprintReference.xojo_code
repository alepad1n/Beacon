#tag Class
Protected Class BlueprintReference
	#tag Method, Flags = &h0
		Function ClassString() As String
		  If (Self.mBlueprint Is Nil) = False Then
		    Return Self.mBlueprint.ClassString
		  Else
		    Return Self.mSaveData.Value("Class")
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Blueprint As Ark.Blueprint)
		  Self.mBlueprint = Blueprint
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(SaveData As Dictionary)
		  Self.mSaveData = SaveData
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackId() As String
		  If (Self.mBlueprint Is Nil) = False Then
		    Return Self.mBlueprint.ContentPackId
		  Else
		    Return Self.mSaveData.Value("ModUUID")
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateFromDict(Kind As String, Dict As Dictionary, ObjectIDKey As String, PathKey As String, ClassStringKey As String, ContentPackIdKey As String) As Ark.BlueprintReference
		  Var ObjectID, Path, ClassString, ContentPackId As String
		  If ObjectIDKey.IsEmpty = False And Dict.HasKey(ObjectIDKey) Then
		    ObjectID = Dict.Value(ObjectIDKey)
		  End If
		  If PathKey.IsEmpty = False And Dict.HasKey(PathKey) Then
		    Path = Dict.Value(PathKey)
		  End If
		  If ClassStringKey.IsEmpty = False And Dict.HasKey(ClassStringKey) Then
		    ClassString = Dict.Value(ClassStringKey)
		  End If
		  If ContentPackIdKey.IsEmpty = False And Dict.HasKey(ContentPackIdKey) Then
		    ContentPackId = Dict.Value(ContentPackIdKey)
		  End If
		  Return CreateFromDict(Kind, ObjectID, Path, ClassString, ContentPackId)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateFromDict(Kind As String, ObjectID As String, Path As String, ClassString As String, ContentPackId As String) As Ark.BlueprintReference
		  Var Dict As New Dictionary
		  Dict.Value("Schema") = "Beacon.BlueprintReference"
		  Dict.Value("Version") = Version
		  Dict.Value("Kind") = Kind
		  Dict.Value("UUID") = ObjectID
		  Dict.Value("Path") = Path
		  Dict.Value("Class") = ClassString
		  Dict.Value("ModUUID") = ContentPackId
		  Return New Ark.BlueprintReference(Dict)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateSaveData(Blueprint As Ark.Blueprint) As Dictionary
		  Var Ref As New Ark.BlueprintReference(Blueprint)
		  Return Ref.SaveData
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(Dict As Dictionary, AlreadyValidated As Boolean = False) As Ark.BlueprintReference
		  If AlreadyValidated = False And IsSaveData(Dict) = False Then
		    Return Nil
		  End If
		  
		  Return New Ark.BlueprintReference(Dict)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsCreature() As Boolean
		  Return Self.Kind = Self.KindCreature
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsEngram() As Boolean
		  Return Self.Kind = Self.KindEngram
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsLootContainer() As Boolean
		  Return Self.Kind = Self.KindLootContainer
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function IsSaveData(Value As Variant) As Boolean
		  If Value.IsNull Or Value.IsArray Or (Value IsA Dictionary) = False Then
		    Return False
		  End If
		  
		  Var Dict As Dictionary = Value
		  If Dict.HasKey("Version") = False Or Dict.HasKey("Schema") = False Then
		    Return False
		  End If
		  
		  Var SchemaValue As Variant = Dict.Value("Schema")
		  If SchemaValue.IsNull Or SchemaValue.Type <> Variant.TypeString Or SchemaValue.StringValue <> "Beacon.BlueprintReference" Then
		    Return False
		  End If
		  
		  Var VersionValue As Variant = Dict.Value("Version")
		  If VersionValue.IsNull Or VersionValue.IsNumeric = False Or VersionValue.IntegerValue > Ark.BlueprintReference.Version Then
		    Return False
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsSpawnPoint() As Boolean
		  Return Self.Kind = Self.KindSpawnPoint
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Kind() As String
		  If (Self.mSaveData Is Nil) = False Then
		    Return Self.mSaveData.Value("Kind")
		  End If
		  
		  Select Case Self.mBlueprint
		  Case IsA Ark.Engram
		    Return Self.KindEngram
		  Case IsA Ark.Creature
		    Return Self.KindCreature
		  Case IsA Ark.SpawnPoint
		    Return Self.KindSpawnPoint
		  Case IsA Ark.LootContainer
		    Return Self.KindLootContainer
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ObjectID() As String
		  If (Self.mBlueprint Is Nil) = False Then
		    Return Self.mBlueprint.BlueprintId
		  Else
		    Return Self.mSaveData.Value("UUID")
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Ark.Blueprint) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  If Self.ObjectID = Other.BlueprintId Then
		    Return 0
		  End If
		  
		  Return Self.ObjectID.Compare(Other.BlueprintId, ComparisonOptions.CaseInsensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Ark.BlueprintReference) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  If Self.ObjectID = Other.ObjectID Then
		    Return 0
		  End If
		  
		  Return Self.ObjectID.Compare(Other.ObjectID, ComparisonOptions.CaseInsensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Path() As String
		  If (Self.mBlueprint Is Nil) = False Then
		    Return Self.mBlueprint.Path
		  Else
		    Return Self.mSaveData.Value("Path")
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Resolve() As Ark.Blueprint
		  If Self.mBlueprint Is Nil Then
		    Try
		      Var Version As Integer = Self.mSaveData.Value("Version")
		      Var Packs As Beacon.StringList
		      If Self.mSaveData.HasKey("ModUUID") And v4UUID.IsValid(Self.mSaveData.Value("ModUUID").StringValue) Then
		        Packs = New Beacon.StringList
		        Packs.Append(Self.mSaveData.Value("ModUUID").StringValue)
		      End If
		      Select Case Version
		      Case 1
		        Var Kind As String = Self.mSaveData.Value("Kind")
		        Select Case Kind
		        Case Self.KindEngram
		          Self.mBlueprint = Ark.ResolveEngram(Self.mSaveData, "UUID", "Path", "Class", Packs)
		        Case Self.KindCreature
		          Self.mBlueprint = Ark.ResolveCreature(Self.mSaveData, "UUID", "Path", "Class", Packs)
		        Case Self.KindSpawnPoint
		          Self.mBlueprint = Ark.ResolveSpawnPoint(Self.mSaveData, "UUID", "Path", "Clas", Packs)
		        Case Self.KindLootContainer
		          Self.mBlueprint = Ark.ResolveLootContainer(Self.mSaveData, "UUID", "Path", "Class", Packs)
		        End Select
		      End Select
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  Return Self.mBlueprint
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  If Self.mSaveData Is Nil Then
		    Var Dict As New Dictionary
		    Dict.Value("Schema") = "Beacon.BlueprintReference"
		    Dict.Value("Version") = Self.Version
		    Select Case Self.mBlueprint
		    Case IsA Ark.Engram
		      Dict.Value("Kind") = Self.KindEngram
		    Case IsA Ark.Creature
		      Dict.Value("Kind") = Self.KindCreature
		    Case IsA Ark.SpawnPoint
		      Dict.Value("Kind") = Self.KindSpawnPoint
		    Case IsA Ark.LootContainer
		      Dict.Value("Kind") = Self.KindLootContainer
		    End Select
		    Dict.Value("UUID") = Self.mBlueprint.BlueprintId
		    Dict.Value("Path") = Self.mBlueprint.Path
		    Dict.Value("Class") = Self.mBlueprint.ClassString
		    Dict.Value("ModUUID") = Self.mBlueprint.ContentPackId
		    Self.mSaveData = Dict
		  End If
		  Return Self.mSaveData
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBlueprint As Ark.Blueprint
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSaveData As Dictionary
	#tag EndProperty


	#tag Constant, Name = KindCreature, Type = String, Dynamic = False, Default = \"Creature", Scope = Public
	#tag EndConstant

	#tag Constant, Name = KindEngram, Type = String, Dynamic = False, Default = \"Engram", Scope = Public
	#tag EndConstant

	#tag Constant, Name = KindLootContainer, Type = String, Dynamic = False, Default = \"Loot Container", Scope = Public
	#tag EndConstant

	#tag Constant, Name = KindSpawnPoint, Type = String, Dynamic = False, Default = \"Spawn Point", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Version, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant


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
