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
  object Label3: TLabel
    Left = 192
    Top = 522
    Width = 104
    Height = 13
    Caption = 'Change Language to:'
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = ReportTreeClick
      OnHint = ReportTreeHint
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
  object bbnClose: TBitBtn
    Left = 457
    Top = 538
    Width = 75
    Height = 25
    Kind = bkClose
    NumGlyphs = 2
    TabOrder = 2
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
      Left = 42
      Top = 268
      Width = 100
      Height = 25
      Action = acnRemove
      TabOrder = 0
    end
    object btnPreview: TButton
      Left = 42
      Top = 148
      Width = 100
      Height = 25
      Action = acnPreview
      TabOrder = 1
    end
    object btnDesignReport: TButton
      Left = 42
      Top = 108
      Width = 100
      Height = 25
      Action = acnDesign
      TabOrder = 2
    end
    object btnNewReport: TButton
      Left = 42
      Top = 28
      Width = 100
      Height = 25
      Action = acnNew
      TabOrder = 3
    end
    object btnProperties: TButton
      Left = 42
      Top = 68
      Width = 100
      Height = 25
      Action = acnEdit
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
    end
    object btnPrint: TButton
      Left = 42
      Top = 188
      Width = 100
      Height = 25
      Action = acnPrint
      TabOrder = 5
    end
    object btnFile: TButton
      Left = 42
      Top = 228
      Width = 100
      Height = 25
      Action = acnPDF
      TabOrder = 6
    end
  end
  object btnLanguage: TButton
    Left = 192
    Top = 536
    Width = 75
    Height = 25
    Action = acnChgLanguage
    TabOrder = 4
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
      494C010103000400580010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object siLangLinked_frmMain: TsiLangLinked
    Version = '7.2'
    StringsTypes.Strings = (
      'TIB_STRINGLIST'
      'TSTRINGLIST')
    NumOfLanguages = 2
    LangDispatcher = dmFR.siLangDispatcher1
    LangDelim = 1
    LangNames.Strings = (
      'English'
      'Swedish')
    Language = 'English'
    CommonContainer = dmFR.siLang1
    ExcludedProperties.Strings = (
      'Category'
      'SecondaryShortCuts'
      'HelpKeyword'
      'InitialDir'
      'HelpKeyword'
      'ActivePage'
      'ImeName'
      'DefaultExt'
      'FileName'
      'FieldName'
      'PickList'
      'DisplayFormat'
      'EditMask'
      'KeyList'
      'LookupDisplayFields'
      'DropDownSpecRow'
      'TableName'
      'DatabaseName'
      'IndexName'
      'MasterFields'
      'SQL'
      'DeleteSQL'
      'UpdateSQL'
      'ModifySQL'
      'KeyFields'
      'LookupKeyFields'
      'LookupResultField'
      'DataField'
      'KeyField'
      'ListField')
    Left = 272
    Top = 296
    TranslationData = {
      73007400430061007000740069006F006E0073005F0055006E00690063006F00
      640065000D000A005400660072006D004D00610069006E000100460061007300
      740020005200650070006F007200740020004D00610069006E00740065006500
      6E0061006E0063006500010001000D000A004C006100620065006C0031000100
      4C0069007300740020006F006600200061007600610069006C00610062006C00
      650020007200650070006F00720074007300010001000D000A004C0061006200
      65006C00320001004400650073006300720069007000740069006F006E000100
      01000D000A004C006100620065006C00330001004300680061006E0067006500
      20004C0061006E0067007500610067006500200074006F003A00010001000D00
      0A00500061006E0065006C0031000100500061006E0065006C00310001000100
      0D000A00500061006E0065006C0032000100500061006E0065006C0032000100
      01000D000A00620062006E0043006C006F00730065000100260043006C006F00
      73006500010001000D000A00470072006F007500700042006F00780031000100
      5200650070006F007200740020006F007000650072006100740069006F006E00
      7300010001000D000A00620074006E00520065006D006F007600650052006500
      70006F00720074000100520065006D006F0076006500010001000D000A006200
      74006E0050007200650076006900650077000100500072006500760069006500
      7700010001000D000A00620074006E00440065007300690067006E0052006500
      70006F00720074000100440065007300690067006E00010001000D000A006200
      74006E004E00650077005200650070006F007200740001004E00650077000100
      01000D000A00620074006E00500072006F007000650072007400690065007300
      0100500072006F007000650072007400690065007300010001000D000A006200
      74006E005000720069006E00740001005000720069006E007400010001000D00
      0A00620074006E00460069006C0065000100500044004600010001000D000A00
      610063006E004E006500770001004E0065007700010001000D000A0061006300
      6E0043006C006F0073006500010043006C006F0073006500010001000D000A00
      610063006E00450064006900740001004500640069007400010001000D000A00
      610063006E00440065007300690067006E000100440065007300690067006E00
      010001000D000A00610063006E00500072006500760069006500770001005000
      720065007600690065007700010001000D000A00610063006E00500072006900
      6E00740001005000720069006E007400010001000D000A00610063006E005000
      440046000100500044004600010001000D000A00610063006E00520065006D00
      6F00760065000100520065006D006F0076006500010001000D000A0061006300
      6E004300680067004C0061006E00670075006100670065000100430068006100
      6E006700650020004C0061006E0067007500610067006500010001000D000A00
      73007400480069006E00740073005F0055006E00690063006F00640065000D00
      0A00620074006E00500072006F00700065007200740069006500730001005300
      68006F0077002F0045006400690074002000540065006D0070006C0061007400
      650020006E0061006D0065002C00200044006100740061007300650074002C00
      2000530074006F007200650064002000700072006F0063006500640075007200
      65002C00200050006100720061006D0065007400650072007300200065007400
      6300010001000D000A007300740044006900730070006C00610079004C006100
      620065006C0073005F0055006E00690063006F00640065000D000A0073007400
      46006F006E00740073005F0055006E00690063006F00640065000D000A005400
      660072006D004D00610069006E0001005400610068006F006D00610001000100
      0D000A00730074004D0075006C00740069004C0069006E00650073005F005500
      6E00690063006F00640065000D000A004D0065006D006F0031002E004C006900
      6E006500730001004D0065006D006F003100010001000D000A00660072007800
      5200650070006F007200740031002E0053006300720069007000740054006500
      78007400010062006500670069006E002C002C0065006E0064002E0001000100
      0D000A007300740053007400720069006E00670073005F0055006E0069006300
      6F00640065000D000A004900440053005F003000010059006F00750020006100
      72006500200067006F0069006E006700200074006F0020006300720065006100
      740065002000610020006E00650077002000740065006D0070006C0061007400
      6500200077006900740068006F0075007400200061006E007900200073007000
      650063006900660069006500640020007200650070006F007200740001000100
      0D000A004900440053005F003100010044006100740061007300650074002000
      6900730020006D0069007300730069006E006700010001000D000A0049004400
      53005F0032000100530074006F007200650064002000700072006F0063006500
      640075007200650020006900730020006D0069007300730069006E0067000100
      01000D000A004900440053005F003300010041007600610069006C0061006200
      6C00650020005200650070006F007200740073002E002E002E00010001000D00
      0A004900440053005F003400010050006C006500610073006500200073006500
      6C006500630074002000610020007200650070006F0072007400210001000100
      0D000A004900440053005F003500010059006F00750020006100720065002000
      67006F0069006E006700200074006F002000720065006D006F00760065002000
      74006800650020007200650070006F00720074003A002000010001000D000A00
      730074004F00740068006500720053007400720069006E00670073005F005500
      6E00690063006F00640065000D000A0046004400470055004900780057006100
      6900740043007500720073006F00720031002E00500072006F00760069006400
      65007200010046006F0072006D007300010001000D000A006600720078004400
      65007300690067006E006500720031002E00440065006600610075006C007400
      5300630072006900700074004C0061006E006700750061006700650001005000
      61007300630061006C00530063007200690070007400010001000D000A006600
      72007800440065007300690067006E006500720031002E00540065006D007000
      6C0061007400650073004500780074000100660072003300010001000D000A00
      6600720078005200650070006F007200740031002E0049006E00690046006900
      6C00650001005C0053006F006600740077006100720065005C00460061007300
      740020005200650070006F00720074007300010001000D000A00660072007800
      5200650070006F007200740031002E005300630072006900700074004C006100
      6E00670075006100670065000100500061007300630061006C00530063007200
      690070007400010001000D000A006600720078005200650070006F0072007400
      31002E00560065007200730069006F006E00010034002E00310035002E003100
      3300010001000D000A007300740043006F006C006C0065006300740069006F00
      6E0073005F0055006E00690063006F00640065000D000A007300740043006800
      6100720053006500740073005F0055006E00690063006F00640065000D000A00
      5400660072006D004D00610069006E000100440045004600410055004C005400
      5F004300480041005200530045005400010001000D000A00}
  end
  object ActionList1: TActionList
    Left = 48
    Top = 208
    object acnNew: TAction
      Category = 'Report'
      Caption = 'New'
      OnExecute = acnNewExecute
    end
    object acnClose: TAction
      Category = 'Application'
      Caption = 'Close'
      OnExecute = acnCloseExecute
    end
    object acnEdit: TAction
      Category = 'Report'
      Caption = 'Edit'
      OnExecute = acnEditExecute
    end
    object acnDesign: TAction
      Category = 'Report'
      Caption = 'Design'
      OnExecute = acnDesignExecute
    end
    object acnPreview: TAction
      Category = 'Report'
      Caption = 'Preview'
      OnExecute = acnPreviewExecute
    end
    object acnPrint: TAction
      Category = 'Report'
      Caption = 'Print'
      OnExecute = acnPrintExecute
    end
    object acnPDF: TAction
      Category = 'Report'
      Caption = 'PDF'
      OnExecute = acnPDFExecute
    end
    object acnRemove: TAction
      Category = 'Report'
      Caption = 'Remove'
      OnExecute = acnRemoveExecute
    end
    object acnChgLanguage: TAction
      Category = 'Application'
      Caption = 'Change Language'
      OnExecute = acnChgLanguageExecute
    end
  end
end
