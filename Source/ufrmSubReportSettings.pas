unit ufrmSubReportSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmSubReportSettings = class(TForm)
    lblTemplate_Name: TLabel;
    lblSP_Name: TLabel;
    lblDS_Name: TLabel;
    edTemplate: TEdit;
    edStoredProc: TEdit;
    edDataset: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSubReportSettings: TfrmSubReportSettings;

implementation

{$R *.dfm}

end.
