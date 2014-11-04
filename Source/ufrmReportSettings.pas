unit ufrmReportSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmReportSettings = class(TForm)
    lblTemplate_Name: TLabel;
    lblDataType: TLabel;
    lblSP_Name: TLabel;
    lblDS_Name: TLabel;
    edTemplate: TEdit;
    edDatatype: TEdit;
    edStoredProc: TEdit;
    edDataset: TEdit;
    ListBox1: TListBox;
    lblSubreports: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmReportSettings: TfrmReportSettings;

implementation

{$R *.dfm}

end.
