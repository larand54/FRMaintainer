object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Fast Report Mainteenance'
  ClientHeight = 583
  ClientWidth = 554
  Color = 9471349
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 26
    Top = 15
    Width = 112
    Height = 13
    Caption = 'List of available reports'
  end
  object Label2: TLabel
    Left = 349
    Top = 17
    Width = 53
    Height = 13
    Caption = 'Description'
  end
  object Panel1: TPanel
    Left = 24
    Top = 32
    Width = 289
    Height = 484
    BevelOuter = bvLowered
    BevelWidth = 2
    Caption = 'Panel1'
    TabOrder = 0
    object ReportTree: TTreeView
      Left = 2
      Top = 2
      Width = 285
      Height = 480
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BevelWidth = 2
      BorderWidth = 2
      Color = 7695199
      Images = ImageList1
      Indent = 19
      TabOrder = 0
      OnClick = ReportTreeClick
    end
  end
  object Panel2: TPanel
    Left = 347
    Top = 34
    Width = 185
    Height = 151
    BevelOuter = bvLowered
    BevelWidth = 2
    Caption = 'Panel2'
    Color = 7695199
    ParentBackground = False
    TabOrder = 1
    object Memo1: TMemo
      Left = 2
      Top = 2
      Width = 181
      Height = 147
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = 7695199
      Lines.Strings = (
        'Memo1')
      TabOrder = 0
    end
  end
  object BitBtn1: TBitBtn
    Left = 457
    Top = 538
    Width = 75
    Height = 25
    Kind = bkClose
    NumGlyphs = 2
    TabOrder = 2
    OnClick = BitBtn1Click
  end
  object GroupBox1: TGroupBox
    Left = 347
    Top = 200
    Width = 183
    Height = 316
    Caption = 'Report operations'
    Color = 7695199
    ParentBackground = False
    ParentColor = False
    TabOrder = 3
    StyleElements = [seFont, seClient]
    object btnRemoveReport: TButton
      Left = 54
      Top = 264
      Width = 75
      Height = 25
      Caption = 'Remove'
      TabOrder = 0
    end
    object btnRunReport: TButton
      Left = 54
      Top = 208
      Width = 75
      Height = 25
      Caption = 'Run'
      TabOrder = 1
      OnClick = btnRunReportClick
    end
    object btnDesignReport: TButton
      Left = 54
      Top = 152
      Width = 75
      Height = 25
      Caption = 'Design'
      TabOrder = 2
      OnClick = btnDesignReportClick
    end
    object btnNewReport: TButton
      Left = 54
      Top = 40
      Width = 75
      Height = 25
      Caption = 'New'
      TabOrder = 3
    end
    object btnProperties: TButton
      Left = 54
      Top = 95
      Width = 75
      Height = 25
      Hint = 
        'Show/Edit Template name, Dataset, Stored procedure, Parameters e' +
        'tc'
      Caption = 'Properties'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
    end
  end
  object Button1: TButton
    Left = 64
    Top = 536
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 4
    OnClick = Button1Click
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    ScreenCursor = gcrHourGlass
    Left = 216
    Top = 88
  end
  object frxDesigner1: TfrxDesigner
    DefaultScriptLanguage = 'PascalScript'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -13
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    DefaultLeftMargin = 10.000000000000000000
    DefaultRightMargin = 10.000000000000000000
    DefaultTopMargin = 10.000000000000000000
    DefaultBottomMargin = 10.000000000000000000
    DefaultPaperSize = 9
    DefaultOrientation = poPortrait
    GradientEnd = 11982554
    GradientStart = clWindow
    TemplatesExt = 'fr3'
    Restrictions = []
    RTLLanguage = False
    MemoParentFont = False
    Left = 72
    Top = 104
  end
  object frxReport1: TfrxReport
    Version = '4.15.13'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41937.819650486110000000
    ReportOptions.LastChange = 41937.819650486110000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 144
    Top = 96
    Datasets = <>
    Variables = <>
    Style = <>
  end
  object frxRichObject1: TfrxRichObject
    Left = 136
    Top = 152
  end
  object ImageList1: TImageList
    Left = 174
    Top = 228
    Bitmap = {
      494C0101030004002C0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B6A8
      990077614D0071625200716354007162540070625300706153006F6152006E5F
      4F006F574200735E480000000000000000000000000000000000000000000000
      0000000000000000000100000008000000100000001000000008000000010000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000708890007078
      8000607070005060600040505000303840002028300010202000101020001010
      200010102000101020001010200010102000000000000000000000000000B7A9
      9A00F1E1DE00E8D5C500D9C4B200D7BCAF00C9B4A300C8ADA000BCA79500BDAB
      9B00B49786006D553F0000000000000000000000000000000000000000000000
      00000000000000000006301D125F8A4C2DED854526ED28140B60000000070000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000070889000A0E0
      F00070D0F00050B8E00030B0E00030A8E00020A0D0002098C0002090C0002080
      B0002080B0001080B0002070900010202000000000000000000000000000B9AC
      9E00FDF2E800F5BFA300E5AA7F00E49C7200D6957000D4926100D5916700DEC4
      B900B09F90006D57410000000000000000000000000000000000000000000000
      0000000000000000000D9F6A49EAD8A471FFD3985FFF834527EA0000000E0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080889000B0E8
      F00090E8FF0080E0FF0070D8FF0070D0F00060C8F00050C0F00040B8F00030A8
      F00030A8E0002098E0002078A00020283000000000000000000000000000B9AA
      9C00FAF2EA00FDEAE500FCE4D200FBDDCF00F9DACD00ECD3BE00ECD3BE00E0D0
      C000AE9D8D006D57410000000000000000000000000000000000000000000000
      0000000000000000000CAC7F5EECF5D9AEFFDEB285FF8D5030EC0000000D0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008090A000B0E8
      F000A0E8FF0090E8FF0080E0FF0070D8FF0070D0F00060C8F00050C0F00040B8
      F00030A8F00030A0E0001080B00030384000000000000000000000000000BAAB
      9E00F9F1F400F5D2C000F2BB9E00E5AC9000E3A48200D5957000D89B6C00EBD2
      C600B09F90006D57410000000000000000000000000000000000000000000000
      0000000000000000000532271F50A28368D29E7D61D22F231A51000000050000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008090A000B0F0
      FF00B0F0FF00A0E8FF0090E0FF0080E0FF0070D8FF0070D0F00060C8F00050C0
      F00040B0F00030A8F0001080B00040405000000000000000000000000000C7B2
      9E00FBF8F900FEF4F500FDEDE300FBE6DF00EEE3CF00ECD9CB00ECD4C000EED7
      CD00AF9E8E006D57410000000000000000000000000000000000000000000000
      000000000000000000010000000600000011000000140000000A000000020000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008098A000C0F0
      FF00B0F0F000A0F0FF00A0E8FF0090E0FF0080E0FF0070D8FF0060D0F00060C8
      F00050B8F00040B0F0001088C00050506000000000000000000000000000C7B3
      AB00FBF7F700FFDACD00F3C8AD00F2BB9E00E5AC8300E19D7200D89C7A00EBD8
      C900B0A090006D57410000000000000000000000000000000000000000000000
      000000000000000000000000000670503AA999532EFF4528187A000000070000
      0001000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008098A000C0F0
      FF00B0F0FF00B0F0FF00A0E8FF0090E8FF0090E0FF0080E0FF0070D8FF0060D0
      F00060C8F00050B8F0001090C00050607000000000000000000000000000C8B9
      AB00FBFAF900FEF4F600FDF0E500FDEEE200FAE5DE00EEE2CF00EDDCD000EEDF
      DC00AF9E8F006D57400000000000000000000000000000000000000000000000
      00000000000000000000000000079F795AD7E5BF92FFAF724AF724150D490000
      0008000000020000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000090A0A000C0F0
      FF00B0F0FF00B0F0FF00B0F0F000A0F0FF0090E8FF0090E0FF0080E0FF0070D0
      FF0060D0F00050C0F0002098D00060708000000000000000000000000000D5BA
      AC00FBF8F700F4DACE00F2CFBB00F2C9AE00E6BBA000E3AD8F00E6AA8A00ECDE
      D500B0A192006D57400000000000000000000000000000000000000000000000
      000100000004000000060000000868534089D6AD86FFF1D09FFFB4774BFF693D
      24AE0D0805200000000200000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000090A0B000C0F0
      FF00C0F0FF00C0F0FF00C0F0FF00B0F0FF00B0F0FF00A0E8FF0090E8FF0090E0
      FF0080D8FF0070D0FF0060C0F00060708000000000000000000000000000D6C0
      AC00FCFBF900FDF8F600FDF6F300FDEFF000FAEDE200FBEBDF00F7E0D900BFA9
      9400A69584006B553F0000000000000000000000000000000000000000000000
      00034C301E7A7B4526D0522F1A8F0A09071A9A6745E0ECD2AAFFF6D39CFFD8A4
      70FF75452ABD0000000600000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000090A0B00090A0
      B00090A0B00090A0B00090A0B00090A0B00090A0A0009098A0008098A0008098
      A0008098A0008098A0008098A00000000000000000000000000000000000D6C1
      B900FBF8F700F4DACD00F2CFBA00F1C8AD00E5BA9E00E6AD9100DA9D7A007460
      4F00624B34007059440000000000000000000000000000000000000000000000
      0005B6855FF7E8D4B2FFAF7A53FF2D1C1154745C489EC59B76FFF8E7BCFFF3CC
      95FFA0623BF70000000700000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000090A8B000B0E8
      F000B0F0FF00B0F0F00090E0F00090A0B0000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D7C7
      B900FCFCFB00FFFDFC00FEFCFA00FEFBF900FDFAF800FAEEEF00C6AD9700B6AA
      9E00735C47000000000000000000000000000000000000000000000000000000
      00039C7D5EC9EFDDBFFFCAA682FF7E5E45B2917C61B4C19770FFF9ECC4FFE8CC
      A4FF845435C70000000500000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000090A8
      B00090A8B00090A8B00090A8B000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E2C7
      B800FBF7F600FDFCFB00FDFCFC00FDFCFC00FDFDFC00FBF8F800BEA79D007A64
      4E00000000000000000000000000000000000000000000000000000000000000
      00012B241D38CFAF8CF7E8D2B3FFCBA888FFBF9674FFF0E1C5FFDDBF9EFFAF7D
      58F01F140D340000000100000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E4C7
      B900E4C7B800E4C7B900E4C7B900E3C7B900D7C7B900D5BFB700D3B6A8000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000001231E182D877158A5C3A07DEED9BA96FFBA9977E570533B9A1710
      0A25000000020000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000100000001000000020000000300000002000000020000
      0001000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000FFFFE00300000000
      C000E00300000000C000E00300000000C000E00300000000C000E00300000000
      C000E00300000000C000E00300000000C000E00300000000C000E00300000000
      C000E00300000000C001E00300000000C0FFE00700000000E1FFE00F00000000
      FFFFE01F00000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
end
