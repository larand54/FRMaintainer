unit ufrmSubReportSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  uReportController, uReport, siComp, siLngLnk;

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
    siLangLinked_frmSubReportSettings: TsiLangLinked;
  private
    { Private declarations }
  public
    { Public declarations }
    function execute(TCMC: TCMReportController; aRepno: integer): TCMSReportData; overload;
    function execute(TCMC: TCMReportController; sr: TCMSReportData; aRepno: integer): TCMSReportData; overload;
  end;

var
  frmSubReportSettings: TfrmSubReportSettings;

implementation

{$R *.dfm}

uses udmFR;

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

function TfrmSubReportSettings.execute(TCMC: TCMReportController;
  sr: TCMSReportData; aRepno: integer): TCMSReportData;
begin
  edStoredProc.Text := sr.storedProcName;
  edDataset.Text := sr.datasetUserName;
  edName.Text := sr.name;
  if ShowModal = mrOK then begin
    sr.storedProcName := edStoredProc.Text;
    sr.datasetUserName := edDataset.Text;
    sr.name :=edName.Text;
  end;
  result := sr;
end;

end.
