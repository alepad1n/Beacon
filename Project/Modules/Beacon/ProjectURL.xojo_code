#tag Class
Protected Class ProjectURL
	#tag Method, Flags = &h0
		Sub Constructor(URL As String)
		  Var Pos As Integer = URL.IndexOf("://")
		  If Pos = -1 Then
		    #if Not TargetIOS
		      // Try as Xojo SaveInfo
		      Try
		        Var StringValue As String = URL
		        Var File As FolderItem = FolderItem.DriveAt(0).FromSaveInfo(DecodeBase64(StringValue))
		        If File <> Nil Then
		          URL = URLForFile(New BookmarkedFolderItem(File))
		          Pos = URL.IndexOf("://")
		        End If
		      Catch Err As RuntimeException
		        
		      End Try
		    #endif
		    
		    If Pos = -1 Then
		      Var Err As New UnsupportedFormatException
		      Err.Message = "Unable to determine scheme from URL " + URL
		      Raise Err
		    End If
		  End If
		  
		  Self.mOriginalURL = URL
		  Self.mQueryParams = New Dictionary
		  
		  Self.mScheme = URL.Left(Pos)
		  Self.mPath = URL.Middle(Pos + 3)
		  Select Case Self.mScheme
		  Case Self.TypeWeb, Self.TypeCloud, Self.TypeLocal, Self.TypeTransient
		    // official types
		  Case "http", "beacon"
		    // also supported, change the scheme
		    Self.mScheme = Self.TypeWeb
		    Self.mOriginalURL = Self.TypeWeb + URL.Middle(Pos)
		  Else
		    Var Err As New UnsupportedFormatException
		    Err.Message = "Unknown url scheme " + Scheme
		    Raise Err
		  End Select
		  
		  Pos = Self.mPath.IndexOf("?")
		  If Pos > -1 Then
		    Self.mQueryString = Self.mPath.Middle(Pos + 1)
		    Self.mPath = Self.mPath.Left(Pos)
		    Var Parts() As String = Self.mQueryString.Split("&")
		    For Each Part As String In Parts
		      Pos = Part.IndexOf("=")
		      If Pos = -1 Then
		        Continue
		      End If
		      
		      Var Key As String = DecodeURLComponent(Part.Left(Pos)).DefineEncoding(Encodings.UTF8)
		      Var Value As String = DecodeURLComponent(Part.Middle(Pos + 1)).DefineEncoding(Encodings.UTF8)
		      
		      Self.mQueryParams.Value(Key.Lowercase) = Value
		    Next
		  End If
		  
		  Var HashData As String = Self.URL(Beacon.ProjectURL.URLTypes.Comparison)
		  Self.mHash = EncodeHex(Crypto.MD5(HashData))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function File() As BookmarkedFolderItem
		  // Will return Nil if the scheme is not file
		  If Self.Scheme <> Self.TypeLocal Then
		    Return Nil
		  End If
		  
		  Var Result As BookmarkedFolderItem
		  If Self.HasParam("saveinfo") Then
		    Result = BookmarkedFolderItem.FromSaveInfo(Self.Param("saveinfo"))
		  Else
		    Result = New BookmarkedFolderItem(Self.Path, FolderItem.PathModes.URL)
		  End If
		  
		  Return Result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameID() As String
		  Var Value As String
		  
		  If Self.HasParam("game") Then
		    Value = Self.Param("game").Lowercase
		  End If
		  
		  If Value = "" Then
		    // Assume Ark
		    Value = Ark.Identifier.Lowercase
		  End If
		  
		  Return DecodeURLComponent(Value.ReplaceAll("+", " ")).DefineEncoding(Encodings.UTF8)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GameID(Assigns Value As String)
		  If Value.IsEmpty Then
		    Self.mQueryParams.Value("name") = Ark.Identifier.Lowercase
		  Else
		    Self.mQueryParams.Value("name") = Value.Lowercase
		  End If
		  
		  Self.mQueryString = SimpleHTTP.BuildFormData(Self.mQueryParams)
		  
		  Var Pos As Integer = Self.mOriginalURL.IndexOf("?")
		  If Pos > -1 Then
		    Self.mOriginalURL = Self.mOriginalURL.Left(Pos)
		  End If
		  If Self.mQueryString <> "" Then
		    Self.mOriginalURL = Self.mOriginalURL + "?" + Self.mQueryString
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hash() As String
		  Return Self.mHash
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasParam(Key As String) As Boolean
		  Return Self.mQueryParams.HasKey(Key.Lowercase)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HumanPath() As String
		  // Not suitable for restoring a file, just a visual reference
		  
		  Select Case Self.Scheme
		  Case TypeLocal
		    Var File As FolderItem = Self.File
		    If (File Is Nil) = False Then
		      Return File.NativePath
		    End If
		    
		    Return "Invalid Path"
		  Case TypeWeb, TypeCloud
		    Return Self.URL(URLTypes.Reading)
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  Var Name As String
		  
		  If Self.HasParam("name") Then
		    Name = Self.Param("name")
		  End If
		  
		  If Name = "" Then
		    // Get the last path component
		    Var Components() As String = Self.Path.Split("/")
		    Name = Components(Components.LastIndex)
		    
		    If Name.EndsWith(".beacon") Then
		      Name = Name.Left(Name.Length - 7)
		    End If
		  End If
		  
		  Return DecodeURLComponent(Name.ReplaceAll("+", " ")).DefineEncoding(Encodings.UTF8)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Name(Assigns Value As String)
		  If Value = "" Then
		    If Self.mQueryParams.HasKey("name") Then
		      Self.mQueryParams.Remove("name")
		    End If
		  Else
		    Self.mQueryParams.Value("name") = Value
		  End If
		  
		  Self.mQueryString = SimpleHTTP.BuildFormData(Self.mQueryParams)
		  
		  Var Pos As Integer = Self.mOriginalURL.IndexOf("?")
		  If Pos > -1 Then
		    Self.mOriginalURL = Self.mOriginalURL.Left(Pos)
		  End If
		  If Self.mQueryString <> "" Then
		    Self.mOriginalURL = Self.mOriginalURL + "?" + Self.mQueryString
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.ProjectURL) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  Return Self.mHash.Compare(Other.mHash, ComparisonOptions.CaseSensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As String
		  Return Self.URL(Beacon.ProjectURL.URLTypes.Unmodified)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(Source As String)
		  Self.Constructor(Source)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Param(Key As String) As String
		  If Not Self.mQueryParams.HasKey(Key.Lowercase) Then
		    Var Err As New KeyNotFoundException
		    Err.Message = "Key " + Key + " not found in query parameters"
		    Raise Err
		  End If
		  
		  Return Self.mQueryParams.Value(Key.Lowercase)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Path() As String
		  Return Self.mScheme + "://" + Self.mPath
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Scheme() As String
		  Return Self.mScheme
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function URL(Purpose As Beacon.ProjectURL.URLTypes) As String
		  If Purpose = Beacon.ProjectURL.URLTypes.Unmodified Or Self.mScheme = Self.TypeLocal Or Self.mScheme = Self.TypeTransient Then
		    Return Self.mOriginalURL
		  End If
		  
		  Var Pattern As New Regex
		  Pattern.SearchPattern = "((beaconapp\.cc)|(usebeacon\.app))/v\d/([0-9A-Za-z]+/)?((document)|(project))/([0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-4[0-9A-Fa-f]{3}-[89ABab][0-9A-Fa-f]{3}-[0-9A-Fa-f]{12})(/versions/([^\?/]+))?"
		  
		  Var Matches As RegexMatch = Pattern.Search(Self.mOriginalURL)
		  If Matches Is Nil Then
		    Return Self.mOriginalURL
		  End If
		  
		  Var UUID As String = Matches.SubExpressionString(8)
		  Var Path As String = "project/" + UUID.Lowercase
		  
		  Select Case Purpose
		  Case Beacon.ProjectURL.URLTypes.Reading
		    // Return simplified url with version
		    If Matches.SubExpressionCount >= 10 Then
		      Path = Path + "/versions/" + Matches.SubExpressionString(10)
		    End If
		    Return BeaconAPI.URL(Path)
		  Case Beacon.ProjectURL.URLTypes.Writing
		    // Return simplified url
		    Return BeaconAPI.URL(Path)
		  Case Beacon.ProjectURL.URLTypes.Comparison
		    // Simplify the url, but keep the scheme
		    Var FullURL As String = BeaconAPI.URL(Path)
		    Var OriginalScheme As String = Self.mOriginalURL.Left(Self.mOriginalURL.IndexOf("://"))
		    Return OriginalScheme + FullURL.Middle(FullURL.IndexOf("://"))
		  Case Beacon.ProjectURL.URLTypes.Storage
		    // Same as comparison, but we append the name
		    Var FullURL As String = BeaconAPI.URL(Path)
		    Var OriginalScheme As String = Self.mOriginalURL.Left(Self.mOriginalURL.IndexOf("://"))
		    Return OriginalScheme + FullURL.Middle(FullURL.IndexOf("://")) + "?name=" + EncodeURLComponent(Self.Name)
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function URLForFile(File As BookmarkedFolderItem) As Beacon.ProjectURL
		  Var Path As String = File.URLPath
		  #if TargetMacOS
		    Var SaveInfo As String = File.SaveInfo
		    If SaveInfo <> "" Then
		      If Path.IndexOf("?") = -1 Then
		        Path = Path + "?saveinfo=" + SaveInfo
		      Else
		        Path = Path + "&saveinfo=" + SaveInfo
		      End If
		    End If
		  #endif
		  Return New Beacon.ProjectURL(Path)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mHash As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOriginalURL As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPath As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mQueryParams As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mQueryString As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mScheme As String
	#tag EndProperty


	#tag Constant, Name = TypeCloud, Type = String, Dynamic = False, Default = \"beacon-cloud", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeLocal, Type = String, Dynamic = False, Default = \"file", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeTransient, Type = String, Dynamic = False, Default = \"temp", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeWeb, Type = String, Dynamic = False, Default = \"https", Scope = Public
	#tag EndConstant


	#tag Enum, Name = URLTypes, Type = Integer, Flags = &h0
		Comparison
		  Writing
		  Reading
		  Unmodified
		Storage
	#tag EndEnum


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
