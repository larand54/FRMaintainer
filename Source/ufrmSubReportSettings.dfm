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
    ChangeLocales = True
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
    Left = 144
    Top = 88
    TranslationData = {
      73007400430061007000740069006F006E0073005F0055006E00690063006F00
      640065000D000A005400660072006D005300750062005200650070006F007200
      7400530065007400740069006E00670073000100530075006200520065007000
      6F0072007400530065007400740069006E006700730001005300750062005200
      650070006F0072007400530065007400740069006E006700730001000D000A00
      6C0062006C00540065006D0070006C006100740065005F004E0061006D006500
      01005300750062007200650070006F007200740020006E0061006D0065003A00
      010001000D000A006C0062006C00530050005F004E0061006D00650001005300
      74006F007200650064002000700072006F006300650064007500720065003A00
      010001000D000A006C0062006C00440053005F004E0061006D00650001004400
      6100740061007300650074003A00010001000D000A0042006900740042007400
      6E00310001004100700070006C007900010001000D000A004200690074004200
      74006E0032000100430061006E00630065006C00010001000D000A0073007400
      480069006E00740073005F0055006E00690063006F00640065000D000A007300
      740044006900730070006C00610079004C006100620065006C0073005F005500
      6E00690063006F00640065000D000A007300740046006F006E00740073005F00
      55006E00690063006F00640065000D000A005400660072006D00530075006200
      5200650070006F0072007400530065007400740069006E006700730001005400
      610068006F006D00610001005400610068006F006D00610001000D000A007300
      74004D0075006C00740069004C0069006E00650073005F0055006E0069006300
      6F00640065000D000A007300740053007400720069006E00670073005F005500
      6E00690063006F00640065000D000A00730074004F0074006800650072005300
      7400720069006E00670073005F0055006E00690063006F00640065000D000A00
      7300740043006F006C006C0065006300740069006F006E0073005F0055006E00
      690063006F00640065000D000A00730074004300680061007200530065007400
      73005F0055006E00690063006F00640065000D000A005400660072006D005300
      750062005200650070006F0072007400530065007400740069006E0067007300
      0100440045004600410055004C0054005F004300480041005200530045005400
      010001000D000A00}
  end
end
