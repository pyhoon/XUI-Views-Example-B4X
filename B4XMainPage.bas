B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'GitHub Desktop ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=github&Args=..\..\
'Export as zip: ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private Dialog As B4XDialog
	Private B4XComboBox1 As B4XComboBox
	Private btnDate As SwiftButton
	Private DateTemplate As B4XDateTemplate
	Private LongTextTemplate As B4XLongTextTemplate
	Private ColorTemplate As B4XColorTemplate
	Private InputTemplate As B4XInputTemplate
	Private btnTime As SwiftButton
	Private AnimatedCounter1 As AnimatedCounter
	Private ImageView1 As B4XView
	Private SignatureTemplate As B4XSignatureTemplate
	Private B4XFloatTextField1 As B4XFloatTextField
	Private B4XFloatTextField2 As B4XFloatTextField
	Private btnListOfColors As SwiftButton
	Private ColorLabel As B4XView
	Private ColorPanel As B4XView
	Private CustomListView1 As CustomListView 'loaded from ListTemplate
	Private ListOfColorsPanel As B4XView
	Private btnSearch As SwiftButton
	Private SearchTemplate As B4XSearchTemplate
	Private AnotherProgressBar1 As AnotherProgressBar
	Private options As B4XListTemplate
	Private B4XBreadCrumb1 As B4XBreadCrumb
	Private B4XLoadingIndicator1 As B4XLoadingIndicator
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("1")
	Dialog.Initialize(Root)
	Dialog.Title = "XUI Views"
	
	Dim Items As List
	Items.Initialize
	Dim LoadingIndicatorStyles() As String = Array As String("Three Circles 1", "Three Circles 2", "Three Circles 3", "Single Circle", "Follow Circles", "Follow Circles 2", "Five Lines 1", "Five Ball", "Ten Lines", "Ten Circles", "Arc 1", "Arc 2", "X Arc", "PacMan", "Square", "Square Rounded")
	Items.AddAll(LoadingIndicatorStyles)
	B4XComboBox1.SetItems(Items)
	B4XLoadingIndicator1.SetStyle(B4XComboBox1.GetItem(0))
	
	DateTemplate.Initialize
	DateTemplate.MinYear = 2016
	DateTemplate.MaxYear = 2030
	LongTextTemplate.Initialize
	ColorTemplate.Initialize
	InputTemplate.Initialize
	SignatureTemplate.Initialize
	B4XFloatTextField1.Text = "Abcde"
	B4XComboBox1.DelayBeforeChangeEvent = 0
	'set the search items
	SearchTemplate.Initialize
	Dim Items As List
	Items.Initialize
	For Each line As String In File.ReadList(File.DirAssets, "colors.txt")
		Dim s() As String = Regex.Split(":", line)
		Dim Name As String = s(0)
		Items.Add(Name)
	Next
	SearchTemplate.SetItems(Items)
	B4XFloatTextField1.NextField = B4XFloatTextField2
	options.Initialize
	options.Options = Array("Cat", "Dog", "Fish", "Crocodile")
	options.AllowMultiSelection = True
	options.MultiSelectionMinimum = 1
	options.CustomListView1.DefaultTextColor = xui.Color_Red
End Sub

Private Sub B4XPage_Resize (Width As Int, Height As Int)
	If Dialog.Visible Then Dialog.Resize(Width, Height)
End Sub

#If B4A
Private Sub B4XPage_KeyPress (KeyCode As Int) As Boolean 'ignore
	Select KeyCode
		Case KeyCodes.KEYCODE_BACK
			'code to handle back key
		Case KeyCodes.KEYCODE_VOLUME_DOWN, KeyCodes.KEYCODE_VOLUME_UP
			'code to handle volume keys
		Case KeyCodes.KEYCODE_MEDIA_PLAY_PAUSE
			'code to handle media button
		Case Else
			Return False 'Pass to Android System
	End Select
End Sub

Private Sub B4XPage_CloseRequest As ResumableSub
	'If Drawer.LeftOpen Then
	'	Drawer.LeftOpen = False
	'	Return False
	'End If
	Return True
End Sub
#End If

Sub B4XComboBox1_SelectedIndexChanged (Index As Int)
	B4XLoadingIndicator1.SetStyle(B4XComboBox1.GetItem(Index))
End Sub

Sub RoundSlider1_ValueChanged (Value As Int)
	Log("RoundSlider value: " & Value)
End Sub

Sub btnDate_Click
	'only CANCEL needed
	Wait For (Dialog.ShowTemplate(DateTemplate, "", "", "CANCEL")) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		btnDate.xLBL.Text = DateTime.Date(DateTemplate.Date)
	End If
End Sub

Sub btnColors_Click
	'example of changing the buttons order and position
	Dim rs As ResumableSub = Dialog.ShowTemplate(ColorTemplate, "OK", "", "CANCEL")
	Dim ok As B4XView = Dialog.GetButton(xui.DialogResponse_Positive)
	Dim cancel As B4XView = Dialog.GetButton(xui.DialogResponse_Cancel)
	cancel.SetLayoutAnimated(0, 2dip, cancel.Top, cancel.Parent.Width / 2 - 4dip, cancel.Height)
	ok.SetLayoutAnimated(0, ok.Parent.Width / 2 + 2dip, ok.Top, ok.Parent.Width / 2 - 4dip, ok.Height)
	Wait For (rs) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		Root.Color = ColorTemplate.SelectedColor
	End If
End Sub

Sub btnTerms_Click
	LongTextTemplate.Text = $"Lorem ipsum dolor sit amet,
consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
Enim blandit volutpat maecenas volutpat blandit aliquam. In egestas erat imperdiet sed euismod nisi porta.
Arcu ac tortor dignissim convallis aenean et tortor. Elit pellentesque habitant morbi tristique senectus et netus et malesuada.
Ut tristique et egestas quis ipsum suspendisse ultrices. Mauris a diam maecenas sed enim ut sem viverra.
Mauris rhoncus aenean vel elit scelerisque. Volutpat consequat mauris nunc congue nisi vitae suscipit.
Tempor orci eu lobortis elementum nibh tellus molestie. Eleifend quam adipiscing vitae proin sagittis nisl rhoncus.
Faucibus turpis in eu mi bibendum neque egestas congue quisque. Vel eros donec ac odio tempor orci dapibus ultrices in.
Velit egestas dui id ornare arcu. Eget nunc lobortis mattis aliquam faucibus purus in massa. Arcu non sodales neque sodales.
Elementum nisi quis eleifend quam. Elementum nisi quis eleifend quam."$
	Dialog.ShowTemplate(LongTextTemplate, "OK", "", "")
End Sub

Sub btnOptions_Click
	'wrap it with a timed template
	Dim TimedTemplate As B4XTimedTemplate
	TimedTemplate.Initialize(options)
	TimedTemplate.TimeoutMilliseconds = 10000 'close after 10 seconds (this is the default value)
	Wait For (Dialog.ShowTemplate(TimedTemplate, "OK", "", "CANCEL")) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		Dialog.Show($"You selected: ${options.SelectedItems}"$, "OK", "", "")
	End If
End Sub

Sub btnTime_Click
	InputTemplate.lblTitle.Text = "Enter time (HH:MM)"
	InputTemplate.RegexPattern = "\d\d:\d\d" '<---optional. Remove if not needed
	Wait For (Dialog.ShowTemplate(InputTemplate, "OK", "", "CANCEL")) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		btnTime.xLBL.Text = InputTemplate.Text
	End If
End Sub

Sub btnCounter_Click
	AnimatedCounter1.Value = Rnd(0, 99999)
	AnotherProgressBar1.Value = Rnd(0, 101)
End Sub

Sub btnSignature_Click
	Dialog.ButtonsFont = xui.CreateFontAwesome(20)
	Dim rs As ResumableSub = Dialog.ShowTemplate(SignatureTemplate, Chr(0xF00C), "", Chr(0xF00D))
	Dialog.GetButton(xui.DialogResponse_Positive).TextColor = xui.Color_Green
	Dialog.GetButton(xui.DialogResponse_Cancel).TextColor = xui.Color_Red
	Dialog.ButtonsFont = xui.CreateDefaultBoldFont(15) 'return it to the default font. It will no longer affect the current dialog
	Wait For (rs) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		ImageView1.SetBitmap(SignatureTemplate.Bitmap.Resize(ImageView1.Width, ImageView1.Height, True))
		#If B4J
		Dim out As OutputStream = File.OpenOutput(File.DirApp, "signature.png", False) 'don't use File.DirApp in real applications
		#Else If B4i
		Dim out As OutputStream = File.OpenOutput(File.DirDocuments, "signature.png", False)
		#Else
		Dim out As OutputStream = File.OpenOutput(File.DirInternal, "signature.png", False)		
		#End If
		SignatureTemplate.Bitmap.WriteToStream(out, 100, "PNG")
		out.Close
	End If
End Sub

Sub B4XFloatTextField1_EnterPressed
	Log("enter pressed")
End Sub

Sub B4XFloatTextField1_TextChanged (Old As String, New As String)
	B4XPages.SetTitle(Me, New)
End Sub

Sub btnSearch_Click
	Wait For (Dialog.ShowTemplate(SearchTemplate, "", "", "CANCEL")) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		btnSearch.xLBL.Text = SearchTemplate.SelectedItem
	End If
End Sub

#Region List Of Colors custom Dialog
Sub CreateListOfColorsLayout
	ListOfColorsPanel = xui.CreatePanel("")
	ListOfColorsPanel.SetLayoutAnimated(0, 0, 0, 300dip, 300dip)
	ListOfColorsPanel.LoadLayout("ListTemplate") 'ListTemplate is part of XUI Views library.
	CustomListView1.sv.SetColorAndBorder(xui.Color_Transparent, 0, 0, 0)
	For Each line As String In File.ReadList(File.DirAssets, "colors.txt")
		Dim s() As String = Regex.Split(":", line)
		Dim Name As String = s(0)
		Dim Color As Int = Bit.Or(0xff000000, Bit.ParseInt(s(1), 16))
		Dim item As B4XView = xui.CreatePanel("")
		item.SetLayoutAnimated(0, 0, 0, ListOfColorsPanel.Width, 50dip)
		CustomListView1.Add(item, Array(Name,Color))
	Next
End Sub

'lazy creation of the items.
Sub CustomListView1_VisibleRangeChanged (FirstIndex As Int, LastIndex As Int)
	For i = Max(0, FirstIndex - 5) To Min(CustomListView1.Size - 1, LastIndex + 5)
		Dim p As B4XView = CustomListView1.GetPanel(i)
		If p.NumberOfViews = 0 Then
			p.LoadLayout("ListOfColors")
			Dim NameAndValue() As Object = CustomListView1.GetValue(i)
			ColorLabel.Text = NameAndValue(0)
			ColorPanel.Color = NameAndValue(1)
		End If
	Next
End Sub

Sub btnListOfColors_Click
	If ListOfColorsPanel.IsInitialized = False Then CreateListOfColorsLayout
	Wait For (Dialog.ShowCustom(ListOfColorsPanel, "", "", "CANCEL")) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		Root.Color = ListOfColorsPanel.Tag
	End If
End Sub

Sub CustomListView1_ItemClick (Index As Int, Value As Object)
	Dialog.Close(xui.DialogResponse_Positive)
	Dim NameAndValue() As Object = Value
	ListOfColorsPanel.Tag = NameAndValue(1)
End Sub
#End Region

Sub B4XSwitch_ValueChanged (Value As Boolean)
	'Example of finding all B4XSwitch instances based on the base view tag property. The designer tag goes to B4XSwitch.Tag.
	For Each v As B4XView In Root.GetAllViewsRecursive
		If v.Tag Is B4XSwitch Then
			Dim s As B4XSwitch = v.Tag
			s.Value = Value
		End If
	Next
End Sub

Sub B4XBreadCrumb1_CrumbClick (Crumbs As List)
	If Crumbs.Size = 1 Then
		For i = 1 To 3
			Crumbs.Add("Item " & i)
		Next
	End If
	B4XBreadCrumb1.Items = Crumbs
End Sub