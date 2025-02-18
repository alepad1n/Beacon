#tag Class
Protected Class ContentPack
	#tag Method, Flags = &h21
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.ContentPack)
		  Self.mContentPackId = Source.mContentPackId
		  Self.mGameId = Source.mGameId
		  Self.mIsConsoleSafe = Source.mIsConsoleSafe
		  Self.mIsDefaultEnabled = Source.mIsDefaultEnabled
		  Self.mIsLocal = Source.mIsLocal
		  Self.mLastUpdate = Source.mLastUpdate
		  Self.mMarketplace = Source.mMarketplace
		  Self.mMarketplaceId = Source.mMarketplaceId
		  Self.mName = Source.mName
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(GameId As String, Name As String, ContentPackId As String = "")
		  If ContentPackId.IsEmpty Then
		    ContentPackId = Beacon.UUID.v4
		  End If
		  
		  Self.mGameId = GameId
		  Self.mContentPackId = ContentPackId
		  Self.mIsConsoleSafe = False
		  Self.mIsDefaultEnabled = False
		  Self.mIsLocal = True
		  Self.mLastUpdate = DateTime.Now.SecondsFrom1970
		  Self.mName = Name
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackId() As String
		  Return Self.mContentPackId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromDatabase(Row As DatabaseRow) As Beacon.ContentPack
		  Try
		    Var Pack As New Beacon.ContentPack
		    Pack.mContentPackId = Row.Column("content_pack_id").StringValue
		    Pack.mGameId = Row.Column("game_id").StringValue
		    Pack.mIsConsoleSafe = Row.Column("console_safe").BooleanValue
		    Pack.mIsDefaultEnabled = Row.Column("default_enabled").BooleanValue
		    Pack.mIsLocal = Row.Column("is_local").BooleanValue
		    Pack.mName = Row.Column("name").StringValue
		    If Row.Column("marketplace").Value.IsNull = False And Row.Column("marketplace_id").Value.IsNull = False Then
		      Pack.mMarketplace = Row.Column("marketplace").StringValue
		      Pack.mMarketplaceId = Row.Column("marketplace_id").StringValue
		    End If
		    Pack.mLastUpdate = Row.Column("last_update").DoubleValue
		    Return Pack
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Building Beacon.ContentPack from DatabaseRow")
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromDatabase(Rows As RowSet) As Beacon.ContentPack()
		  Var Packs() As Beacon.ContentPack
		  For Each Row As DatabaseRow In Rows
		    Var Pack As Beacon.ContentPack = Beacon.ContentPack.FromDatabase(Row)
		    If (Pack Is Nil) = False Then
		      Packs.Add(Pack)
		    End If
		  Next
		  Return Packs
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(SaveData As Dictionary) As Beacon.ContentPack
		  If SaveData Is Nil Or SaveData.KeyCount = 0 Or SaveData.HasAllKeys("contentPackId", "gameId", "name", "isConsoleSafe", "isDefaultEnabled", "minVersion") = False Then
		    Return Nil
		  End If
		  
		  Try
		    If SaveData.Value("minVersion").IntegerValue > App.BuildNumber Then
		      Return Nil
		    End If
		    
		    Var Pack As New Beacon.ContentPack
		    Pack.mContentPackId = SaveData.Value("contentPackId")
		    Pack.mGameId = SaveData.Value("gameId")
		    Pack.mIsConsoleSafe = SaveData.Value("isConsoleSafe")
		    Pack.mIsDefaultEnabled = SaveData.Value("isDefaultEnabled")
		    Pack.mIsLocal = True
		    Pack.mName = SaveData.Value("name")
		    Pack.mLastUpdate = SaveData.Value("lastUpdate")
		    If SaveData.HasKey("marketplace") And SaveData.HasKey("marketplaceId") Then
		      Pack.mMarketplace = SaveData.Value("marketplace")
		      Pack.mMarketplaceId = SaveData.Value("marketplaceId")
		    End If
		    Return Pack
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Building Beacon.ContentPack from Dictionary")
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameId() As String
		  Return Self.mGameId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GenerateLocalContentPackId(Marketplace As String, MarketplaceId As String) As String
		  Return Beacon.UUID.v5("Local " + Marketplace + ": " + MarketplaceId).StringValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableCopy() As Beacon.ContentPack
		  Return New Beacon.ContentPack(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Beacon.ContentPack
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsConsoleSafe() As Boolean
		  Return Self.mIsConsoleSafe
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsDefaultEnabled() As Boolean
		  Return Self.mIsDefaultEnabled
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsLocal() As Boolean
		  Return Self.mIsLocal
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastUpdate() As Double
		  Return Self.mLastUpdate
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Marketplace() As String
		  Return Self.mMarketplace
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MarketplaceId() As String
		  Return Self.mMarketplaceId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableCopy() As Beacon.MutableContentPack
		  Return New Beacon.MutableContentPack(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As Beacon.MutableContentPack
		  Return Self.MutableCopy()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  Return Self.mName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.ContentPack) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  If Other.mContentPackId = Self.mContentPackId Then
		    Return 0
		  End If
		  
		  Var MyValue As String = Self.mName + ":" + Self.mContentPackId
		  Var OtherValue As String = Other.mName + ":" + Other.mContentPackId
		  Return MyValue.Compare(OtherValue, ComparisonOptions.CaseInsensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var SaveData As New Dictionary
		  SaveData.Value("contentPackId") = Self.mContentPackId
		  SaveData.Value("gameId") = Self.mGameId
		  If Self.mMarketplace.IsEmpty = False And Self.mMarketplaceId.IsEmpty = False Then
		    SaveData.Value("marketplace") = Self.mMarketplace
		    SaveData.Value("marketplaceId") = Self.mMarketplaceId
		  End If
		  SaveData.Value("name") = Self.mName
		  SaveData.Value("isConsoleSafe") = Self.mIsConsoleSafe
		  SaveData.Value("isDefaultEnabled") = Self.mIsDefaultEnabled
		  SaveData.Value("minVersion") = 20000000
		  SaveData.Value("lastUpdate") = Self.mLastUpdate
		  Return SaveData
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Type() As Beacon.ContentPack.Types
		  If Self.mIsLocal Then
		    Return Beacon.ContentPack.Types.Custom
		  ElseIf Self.mIsConsoleSafe Then
		    Return Beacon.ContentPack.Types.Official
		  Else
		    Return Beacon.ContentPack.Types.ThirdParty
		  End If
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mContentPackId As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mGameId As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mIsConsoleSafe As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mIsDefaultEnabled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mIsLocal As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLastUpdate As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMarketplace As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMarketplaceId As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mName As String
	#tag EndProperty


	#tag Enum, Name = Types, Type = Integer, Flags = &h0
		Official
		  ThirdParty
		Custom
	#tag EndEnum


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
