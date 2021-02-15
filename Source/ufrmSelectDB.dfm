object frmSelectDB: TfrmSelectDB
  Left = 0
  Top = 0
  Caption = 'Select a database'
  ClientHeight = 200
  ClientWidth = 266
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object rgDatabases: TRadioGroup
    Left = 33
    Top = 32
    Width = 151
    Height = 97
    Caption = 'rgDatabases'
    ItemIndex = 0
    Items.Strings = (
      'VIS_VIDA'
      'WOODSUPPORT')
    TabOrder = 0
  end
  object btnOK: TBitBtn
    Left = 33
    Top = 160
    Width = 75
    Height = 25
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 1
  end
  object btnCancel: TBitBtn
    Left = 168
    Top = 160
    Width = 75
    Height = 25
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 2
  end
end
