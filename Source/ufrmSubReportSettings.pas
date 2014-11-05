unit ufrmSubReportSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  uReportController, uReport;

type
  TfrmSubReportSettings = class(TForm)
    lblTemplate_Name: TLabel;
    lblSP_Name: TLabel;
    lblDS_Name: TLabel;
    edName: TEdit;
    edStoredProc: TEdit;
    edDataset: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
    function execute(TCMC: TCMReportController; aRepno: integer): TCMSReportData;
  end;

var
  frmSubReportSettings: TfrmSubReportSettings;

implementation

{$R *.dfm}

{ TfrmSubReportSettings }

function TfrmSubReportSettings.execute(
  TCMC: TCMReportController; aRepNo: integer): TCMSReportData;
begin
  if (ShowModal = mrOK) then begin
    Result := TCMC.NewSubReport( aRepNo, edName.Text, edStoredProc.Text, edDataset.Text);
  end
  else
    Result := nil;
end;

end.
