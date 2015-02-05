object frmAddParams: TfrmAddParams
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Enter Parameters!'
  ClientHeight = 222
  ClientWidth = 394
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
  object bbnOk: TBitBtn
    Left = 32
    Top = 184
    Width = 75
    Height = 25
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 0
  end
  object bbnCancel: TBitBtn
    Left = 280
    Top = 184
    Width = 75
    Height = 25
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 1
    OnClick = bbnCancelClick
  end
  object lvParameters: TListView
    Left = 16
    Top = 16
    Width = 361
    Height = 150
    Columns = <
      item
        Caption = 'Parameter Name'
        Width = 200
      end
      item
        Caption = 'Parameter Value'
        Width = 157
      end>
    Items.ItemData = {
      05640000000200000000000000FFFFFFFFFFFFFFFF01000000FFFFFFFF000000
      00044E0061006D006500043100300030003900A832E52F00000000FFFFFFFFFF
      FFFFFF01000000FFFFFFFF0000000005560061006C0075006500043100300030
      0038001833E52FFFFFFFFF}
    SortType = stText
    TabOrder = 2
    ViewStyle = vsReport
    OnClick = lvParametersClick
  end
end
