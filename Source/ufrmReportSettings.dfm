object frmReportSettings: TfrmReportSettings
  Left = 0
  Top = 0
  Caption = 'Report settings  -- Create New Report'
  ClientHeight = 366
  ClientWidth = 436
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblTemplate_Name: TLabel
    Left = 32
    Top = 32
    Width = 77
    Height = 13
    Caption = 'Template name:'
  end
  object lblDocType: TLabel
    Left = 32
    Top = 64
    Width = 44
    Height = 13
    Caption = 'Doctype:'
  end
  object lblSP_Name: TLabel
    Left = 34
    Top = 96
    Width = 88
    Height = 13
    Caption = 'Stored procedure:'
  end
  object lblDS_Name: TLabel
    Left = 32
    Top = 128
    Width = 42
    Height = 13
    Caption = 'Dataset:'
  end
  object lblSubreports: TLabel
    Left = 32
    Top = 200
    Width = 57
    Height = 13
    Caption = 'Subreports:'
  end
  object sbtnAddSR: TSpeedButton
    Left = 288
    Top = 208
    Width = 17
    Height = 22
    Hint = 'Add new subreport'
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000002000000070000
      000D0000000F0000000D00000007000000020000000000000000000000020000
      00090000000F00000010000000110000001100000014020101214C28168E8648
      27DAA55831FF854627DB4A28158C020100150000000400000000000000098B63
      56C1C18977FFC08976FFC08875FFC59584FFCFAFA3FFB0704EFFC07C4AFFDEA6
      69FFF4D3A1FFDEA76AFFBF7C4BFF844728D406030217000000020000000CC38E
      79FFFDFBFAFFFBF7F4FFFCF6F3FFF7F4F1FFC8A28CFFC48656FFEDBC7CFFEEBF
      7FFF83400EFFF2CC94FFEFC181FFC38657FF58321C93000000070000000DC591
      7EFFFDFCFBFFF8EFE8FFF7EEE8FFF2EDE9FFBA7D57FFE4B377FFF5D9ABFFF5DA
      AFFF8B4914FFF7E3BEFFF6DBB2FFE5B77FFF995C36E30000000B0000000CC794
      81FFFEFCFBFFF9F0EAFFF8F0EAFFF3EFECFFBC784FFFF1CE95FF995420FF9752
      1DFF934F1CFF904C19FF8D4917FFF5DBAEFFB16F45FA0000000B0000000BC997
      86FFFEFDFCFFF9F2EDFFF9F2EDFFF5F0EDFFC68C65FFEFDDB7FFF3CF98FFF5D5
      9FFF9B5622FFF7E0B2FFF5D7A4FFEFDDB8FFA46942E2000000080000000ACB9C
      8BFFFEFDFDFFFAF3EFFFFAF4EEFFF8F3F0FFDBB9A4FFD8AE86FFF9F3D1FFF8E1
      B5FFA35D28FFFAEAC6FFFAF6D5FFD8AF89FF5E3E29850000000400000009CFA0
      8DFFFEFEFDFFFBF5F1FFFBF5F0FFFAF4F1FFF6F2EFFFD5A785FFDCB48DFFF2E9
      CAFFFAFDE1FFF2E9CAFFDCB38CFF996B4AC80202010A0000000100000009D0A3
      93FFFEFEFDFFFAF5F3FFFBF6F2FFFBF5F1FFFBF6F2FFF8F4F0FFE4C9B4FFDAAF
      8AFFD8A578FFDBAE8AFFD7B098FF02020117000000010000000000000008D3A8
      97FFFEFEFEFFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F3FFFCF5F4FFFAF6F3FFFAF6
      F3FFF8F6F3FFFBF9F8FFDAB9ADFF0000000E000000000000000000000007D3AB
      9AFFFFFEFEFFFCF8F6FFFCF7F5FFFCF7F5FFFBF6F4FFFBF6F4FFFCF6F3FFFCF6
      F2FFFBF6F1FFFDFBF9FFD0A493FF0000000C000000000000000000000006D8AE
      9DFFFFFFFEFFFDF9F7FFFDF9F7FFFCF8F7FFFCF8F6FFFCF7F5FFFBF7F5FFFBF7
      F4FFFCF7F3FFFDFCFAFFD2A897FF0000000B000000000000000000000006D8B0
      A0FFFFFFFFFFFDFAF9FFFDFAF8FFFDFAF8FFFDF9F7FFFCF8F7FFFBF8F6FFFBF7
      F6FFFCF7F5FFFEFCFCFFD5AA9AFF0000000B000000000000000000000005D9B3
      A3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFEFEFFFEFEFEFFFFFEFEFFFEFE
      FEFFFEFEFEFFFEFEFDFFD7AE9EFF00000009000000000000000000000003A386
      7AC0DBB5A5FFDAB5A4FFDAB5A4FFDAB4A4FFD9B3A3FFD9B3A3FFD9B3A2FFD9B2
      A2FFD8B2A2FFD8B1A1FFA08277C2000000060000000000000000}
    ParentShowHint = False
    ShowHint = True
    OnClick = sbtnAddSRClick
  end
  object sbtnRemoveSR: TSpeedButton
    Left = 288
    Top = 232
    Width = 17
    Height = 22
    Hint = 'Remove selected subreport'
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000002000000070000
      000D0000000F0000000D00000007000000020000000000000000000000020000
      00090000000F00000010000000110000001100000014020101214C28168E8648
      27DAA55831FF854627DB4A28158C020100150000000400000000000000098B63
      56C1C18977FFC08976FFC08875FFC59584FFCFAFA3FFB0704EFFC07C4AFFDEA6
      69FFEDBC78FFDEA76AFFBF7C4BFF844728D406030217000000020000000CC38E
      79FFFDFBFAFFFBF7F4FFFCF6F3FFF7F4F1FFC8A28CFFC48656FFEDBC7CFFEEBF
      7FFFEEC183FFEFC383FFEFC181FFC38657FF58321C93000000070000000DC591
      7EFFFDFCFBFFF8EFE8FFF7EEE8FFF2EDE9FFBA7D57FFE4B377FFF5D9ABFFF5DA
      AFFFF6DCB2FFF6DEB3FFF6DBB2FFE5B77FFF995C36E30000000B0000000CC794
      81FFFEFCFBFFF9F0EAFFF8F0EAFFF3EFECFFBC784FFFF1CE95FF99541FFF944E
      1BFF8E4A16FF894512FF85400EFFF5DBAEFFB16F45FA0000000B0000000BC997
      86FFFEFDFCFFF9F2EDFFF9F2EDFFF5F0EDFFC68C65FFEFDDB7FFF3CF98FFF5D5
      9FFFF5D7A4FFF6DAA5FFF5D7A4FFEFDDB8FFA46942E2000000080000000ACB9C
      8BFFFEFDFDFFFAF3EFFFFAF4EEFFF8F3F0FFDBB9A4FFD8AE86FFF9F3D1FFF8E1
      B5FFF9DFAFFFF9E6BCFFFAF6D5FFD8AF89FF5E3E29850000000400000009CFA0
      8DFFFEFEFDFFFBF5F1FFFBF5F0FFFAF4F1FFF6F2EFFFD5A785FFDCB48DFFF2E9
      CAFFFAFDE1FFF2E9CAFFDCB38CFF996B4AC80202010A0000000100000009D0A3
      93FFFEFEFDFFFAF5F3FFFBF6F2FFFBF5F1FFFBF6F2FFF8F4F0FFE4C9B4FFDAAF
      8AFFD8A578FFDBAE8AFFD7B098FF02020117000000010000000000000008D3A8
      97FFFEFEFEFFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F3FFFCF5F4FFFAF6F3FFFAF6
      F3FFF8F6F3FFFBF9F8FFDAB9ADFF0000000E000000000000000000000007D3AB
      9AFFFFFEFEFFFCF8F6FFFCF7F5FFFCF7F5FFFBF6F4FFFBF6F4FFFCF6F3FFFCF6
      F2FFFBF6F1FFFDFBF9FFD0A493FF0000000C000000000000000000000006D8AE
      9DFFFFFFFEFFFDF9F7FFFDF9F7FFFCF8F7FFFCF8F6FFFCF7F5FFFBF7F5FFFBF7
      F4FFFCF7F3FFFDFCFAFFD2A897FF0000000B000000000000000000000006D8B0
      A0FFFFFFFFFFFDFAF9FFFDFAF8FFFDFAF8FFFDF9F7FFFCF8F7FFFBF8F6FFFBF7
      F6FFFCF7F5FFFEFCFCFFD5AA9AFF0000000B000000000000000000000005D9B3
      A3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFEFEFFFEFEFEFFFFFEFEFFFEFE
      FEFFFEFEFEFFFEFEFDFFD7AE9EFF00000009000000000000000000000003A386
      7AC0DBB5A5FFDAB5A4FFDAB5A4FFDAB4A4FFD9B3A3FFD9B3A3FFD9B3A2FFD9B2
      A2FFD8B2A2FFD8B1A1FFA08277C2000000060000000000000000}
    ParentShowHint = False
    ShowHint = True
    OnClick = sbtnRemoveSRClick
  end
  object lblDescription: TLabel
    Left = 32
    Top = 160
    Width = 53
    Height = 13
    Caption = 'Description'
  end
  object sbnAddDocType: TSpeedButton
    Left = 342
    Top = 60
    Width = 17
    Height = 22
    Hint = 'Add new subreport'
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000002000000070000
      000D0000000F0000000D00000007000000020000000000000000000000020000
      00090000000F00000010000000110000001100000014020101214C28168E8648
      27DAA55831FF854627DB4A28158C020100150000000400000000000000098B63
      56C1C18977FFC08976FFC08875FFC59584FFCFAFA3FFB0704EFFC07C4AFFDEA6
      69FFF4D3A1FFDEA76AFFBF7C4BFF844728D406030217000000020000000CC38E
      79FFFDFBFAFFFBF7F4FFFCF6F3FFF7F4F1FFC8A28CFFC48656FFEDBC7CFFEEBF
      7FFF83400EFFF2CC94FFEFC181FFC38657FF58321C93000000070000000DC591
      7EFFFDFCFBFFF8EFE8FFF7EEE8FFF2EDE9FFBA7D57FFE4B377FFF5D9ABFFF5DA
      AFFF8B4914FFF7E3BEFFF6DBB2FFE5B77FFF995C36E30000000B0000000CC794
      81FFFEFCFBFFF9F0EAFFF8F0EAFFF3EFECFFBC784FFFF1CE95FF995420FF9752
      1DFF934F1CFF904C19FF8D4917FFF5DBAEFFB16F45FA0000000B0000000BC997
      86FFFEFDFCFFF9F2EDFFF9F2EDFFF5F0EDFFC68C65FFEFDDB7FFF3CF98FFF5D5
      9FFF9B5622FFF7E0B2FFF5D7A4FFEFDDB8FFA46942E2000000080000000ACB9C
      8BFFFEFDFDFFFAF3EFFFFAF4EEFFF8F3F0FFDBB9A4FFD8AE86FFF9F3D1FFF8E1
      B5FFA35D28FFFAEAC6FFFAF6D5FFD8AF89FF5E3E29850000000400000009CFA0
      8DFFFEFEFDFFFBF5F1FFFBF5F0FFFAF4F1FFF6F2EFFFD5A785FFDCB48DFFF2E9
      CAFFFAFDE1FFF2E9CAFFDCB38CFF996B4AC80202010A0000000100000009D0A3
      93FFFEFEFDFFFAF5F3FFFBF6F2FFFBF5F1FFFBF6F2FFF8F4F0FFE4C9B4FFDAAF
      8AFFD8A578FFDBAE8AFFD7B098FF02020117000000010000000000000008D3A8
      97FFFEFEFEFFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F3FFFCF5F4FFFAF6F3FFFAF6
      F3FFF8F6F3FFFBF9F8FFDAB9ADFF0000000E000000000000000000000007D3AB
      9AFFFFFEFEFFFCF8F6FFFCF7F5FFFCF7F5FFFBF6F4FFFBF6F4FFFCF6F3FFFCF6
      F2FFFBF6F1FFFDFBF9FFD0A493FF0000000C000000000000000000000006D8AE
      9DFFFFFFFEFFFDF9F7FFFDF9F7FFFCF8F7FFFCF8F6FFFCF7F5FFFBF7F5FFFBF7
      F4FFFCF7F3FFFDFCFAFFD2A897FF0000000B000000000000000000000006D8B0
      A0FFFFFFFFFFFDFAF9FFFDFAF8FFFDFAF8FFFDF9F7FFFCF8F7FFFBF8F6FFFBF7
      F6FFFCF7F5FFFEFCFCFFD5AA9AFF0000000B000000000000000000000005D9B3
      A3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFEFEFFFEFEFEFFFFFEFEFFFEFE
      FEFFFEFEFEFFFEFEFDFFD7AE9EFF00000009000000000000000000000003A386
      7AC0DBB5A5FFDAB5A4FFDAB5A4FFDAB4A4FFD9B3A3FFD9B3A3FFD9B3A2FFD9B2
      A2FFD8B2A2FFD8B1A1FFA08277C2000000060000000000000000}
    ParentShowHint = False
    ShowHint = True
    OnClick = sbnAddDocTypeClick
  end
  object edTemplate: TEdit
    Left = 128
    Top = 29
    Width = 161
    Height = 21
    TabOrder = 0
  end
  object edDoctype: TEdit
    Left = 128
    Top = 61
    Width = 57
    Height = 21
    TabOrder = 1
  end
  object edStoredProc: TEdit
    Left = 128
    Top = 93
    Width = 161
    Height = 21
    TabOrder = 2
    OnChange = edStoredProcChange
  end
  object edDataset: TEdit
    Left = 128
    Top = 125
    Width = 161
    Height = 21
    TabOrder = 3
  end
  object lbxSubReports: TListBox
    Left = 128
    Top = 208
    Width = 161
    Height = 97
    ItemHeight = 13
    TabOrder = 5
    OnDblClick = lbxSubReportsDblClick
  end
  object bbnApply: TBitBtn
    Left = 342
    Top = 327
    Width = 75
    Height = 25
    Caption = 'Apply'
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 7
  end
  object bbnCancel: TBitBtn
    Left = 32
    Top = 327
    Width = 75
    Height = 25
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 8
  end
  object edDescription: TEdit
    Left = 128
    Top = 157
    Width = 300
    Height = 21
    TabOrder = 4
  end
  object bbnCrtMain: TBitBtn
    Left = 200
    Top = 327
    Width = 131
    Height = 25
    Caption = 'Create Main'
    TabOrder = 6
    OnClick = bbnCrtMainClick
  end
  object cboDocType: TComboBox
    Left = 191
    Top = 61
    Width = 145
    Height = 21
    TabOrder = 9
    Text = 'cboDocType'
    OnChange = cboDocTypeChange
  end
  object BindSourceDB1: TBindSourceDB
    ScopeMappings = <>
    Left = 1392
    Top = 592
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 20
    Top = 5
  end
end
