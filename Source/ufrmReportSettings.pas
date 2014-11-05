unit ufrmReportSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  uReport, uReportController, ufrmSubReportSettings;

type
  TfrmReportSettings = class(TForm)
    lblTemplate_Name: TLabel;
    lblDocType: TLabel;
    lblSP_Name: TLabel;
    lblDS_Name: TLabel;
    edTemplate: TEdit;
    edDoctype: TEdit;
    edStoredProc: TEdit;
    edDataset: TEdit;
    lbxSubReports: TListBox;
    lblSubreports: TLabel;
    sbtnAddSR: TSpeedButton;
    sbtnRemoveSR: TSpeedButton;
    bbnApply: TBitBtn;
    bbnCancel: TBitBtn;
    edDescription: TEdit;
    lblDescription: TLabel;
    bbnCrtMain: TBitBtn;
    procedure bbnCrtMainClick(Sender: TObject);
    procedure sbtnAddSRClick(Sender: TObject);
  private
    { Private declarations }
    FReportData: TCMMReportData;
    FReportController: TCMReportController;
  public
    { Public declarations }
    function Execute(TCMC: TCMReportController): TCMMReportData;
  end;

var
  frmReportSettings: TfrmReportSettings;

implementation

{$R *.dfm}

uses udmFR;

{ TfrmReportSettings }

procedure TfrmReportSettings.bbnCrtMainClick(Sender: TObject);
begin
  FReportData := FReportController.NewReport(edTemplate.Text, edDoctype.Text,
    edStoredProc.Text, edDataset.Text, edDescription.Text);
  if FReportData <> nil then
  begin
    bbnApply.Enabled := true;
    sbtnAddSR.Enabled := true;
    sbtnRemoveSR.Enabled := true;
  end;

end;

function TfrmReportSettings.Execute(TCMC: TCMReportController): TCMMReportData;
var
  srName: string;
  srl: TCMSReportsData;
  i: integer;
begin
  FReportController := TCMC;
  bbnApply.Enabled := false;
  sbtnAddSR.Enabled := false;
  sbtnRemoveSR.Enabled := false;
  FReportData := nil;
  if (ShowModal = mrOK) then
  begin
     srl := TCMSReportsData.Create;
     for i := 0 to lbxSubreports.Items.Count-1 do begin
       srl.Add(TCMSReportData(lbxSubReports.Items.Objects[i]));
     end;
     FReportData.subReportsData := srl;
     Result := FReportData;
  end
  else
    Result := nil;
end;

procedure TfrmReportSettings.sbtnAddSRClick(Sender: TObject);
var
  srd: TCMSReportData;
begin
  srd := frmSubReportSettings.execute(FReportController,FReportData.ReportNo);
  lbxSubReports.Items.AddObject(srd.name, srd);
end;

end.
