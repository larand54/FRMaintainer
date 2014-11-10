object frmSubReportSettings: TfrmSubReportSettings
  Left = 0
  Top = 0
  Caption = 'SubReportSettings'
  ClientHeight = 163
  ClientWidth = 293
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblTemplate_Name: TLabel
    Left = 32
    Top = 32
    Width = 81
    Height = 13
    Caption = 'Subreport name:'
  end
  object lblSP_Name: TLabel
    Left = 34
    Top = 56
    Width = 88
    Height = 13
    Caption = 'Stored procedure:'
  end
  object lblDS_Name: TLabel
    Left = 32
    Top = 81
    Width = 42
    Height = 13
    Caption = 'Dataset:'
  end
  object edName: TEdit
    Left = 128
    Top = 29
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object edStoredProc: TEdit
    Left = 128
    Top = 53
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object edDataset: TEdit
    Left = 128
    Top = 78
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object BitBtn1: TBitBtn
    Left = 174
    Top = 119
    Width = 75
    Height = 25
    Caption = 'Apply'
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 3
  end
  object BitBtn2: TBitBtn
    Left = 80
    Top = 119
    Width = 75
    Height = 25
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 4
  end
  object siLangLinked_frmSubReportSettings: TsiLangLinked
    Version = '7.2'
    StringsTypes.Strings = (
      'TIB_STRINGLIST'
      'TSTRINGLIST')
    NumOfLanguages = 2
    ActiveLanguage = 2
    ChangeLocales = True
    LangDispatcher = dmLanguage.siLangDispatcher1
    LangDelim = 1
    LangNames.Strings = (
      'Swedish'
      'English')
    Language = 'English'
    CommonContainer = dmLanguage.siLang1
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
    Left = 144
    Top = 88
    TranslationData = {
      73007400430061007000740069006F006E0073005F0055006E00690063006F00
      640065000D000A005400660072006D005300750062005200650070006F007200
      7400530065007400740069006E00670073000100530075006200520065007000
      6F0072007400530065007400740069006E0067007300010001000D000A006C00
      62006C00540065006D0070006C006100740065005F004E0061006D0065000100
      5300750062007200650070006F007200740020006E0061006D0065003A000100
      01000D000A006C0062006C00530050005F004E0061006D006500010053007400
      6F007200650064002000700072006F006300650064007500720065003A000100
      01000D000A006C0062006C00440053005F004E0061006D006500010044006100
      740061007300650074003A00010001000D000A00420069007400420074006E00
      310001004100700070006C007900010001000D000A0042006900740042007400
      6E0032000100430061006E00630065006C00010001000D000A00730074004800
      69006E00740073005F0055006E00690063006F00640065000D000A0073007400
      44006900730070006C00610079004C006100620065006C0073005F0055006E00
      690063006F00640065000D000A007300740046006F006E00740073005F005500
      6E00690063006F00640065000D000A005400660072006D005300750062005200
      650070006F0072007400530065007400740069006E0067007300010054006100
      68006F006D006100010001000D000A00730074004D0075006C00740069004C00
      69006E00650073005F0055006E00690063006F00640065000D000A0073007400
      53007400720069006E00670073005F0055006E00690063006F00640065000D00
      0A00730074004F00740068006500720053007400720069006E00670073005F00
      55006E00690063006F00640065000D000A007300740043006F006C006C006500
      6300740069006F006E0073005F0055006E00690063006F00640065000D000A00
      73007400430068006100720053006500740073005F0055006E00690063006F00
      640065000D000A005400660072006D005300750062005200650070006F007200
      7400530065007400740069006E00670073000100440045004600410055004C00
      54005F004300480041005200530045005400010001000D000A00}
  end
end
