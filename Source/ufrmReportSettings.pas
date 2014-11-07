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
    procedure bbnUpdMainClick(Sender: TObject);
    procedure sbtnAddSRClick(Sender: TObject);
    procedure sbtnRemoveSRClick(Sender: TObject);
  private
    { Private declarations }
    FRepNo: integer;
    FReportData: TCMMReportData;
    FReportController: TCMReportController;
  public
    { Public declarations }
    property RepNo: integer read FRepNo;
    function Execute(TCMC: TCMReportController): TCMMReportData; OVERLOAD;
    function Execute(TCMC: TCMReportController; aRepData: TCMMReportData)
      : TCMMReportData; OVERLOAD;
  end;

var
  frmReportSettings: TfrmReportSettings;

implementation

{$R *.dfm}

uses udmFR;

{ TfrmReportSettings }

procedure TfrmReportSettings.bbnCrtMainClick(Sender: TObject);
begin
  FreeAndNil(FReportData);
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
  frmReportSettings.Caption := 'Report settings  -- Create New Report';
  bbnCrtMain.Caption := 'Create Main';
  bbnCrtMain.OnClick := bbnCrtMainClick;
  FReportController := TCMC;
  bbnApply.Enabled := false;
  sbtnAddSR.Enabled := false;
  sbtnRemoveSR.Enabled := false;
  if (ShowModal = mrOK) then
  begin
    Result := FReportData;
    if lbxSubReports.Items.Count > 0 then
    begin

      srl := TCMSReportsData.Create;
      for i := 0 to lbxSubReports.Items.Count - 1 do
      begin
        srl.Add(TCMSReportData(lbxSubReports.Items.Objects[i]));
      end;
      FReportData.subReportsData := srl;
      FreeAndNil(srl);
      for i := 0 to lbxSubReports.Items.Count - 1 do
        TCMSubReport(lbxSubReports.Items.Objects[i]).Free;
      lbxSubReports.Items.Clear;
    end;
  end
  else
    Result := nil;
end;

procedure TfrmReportSettings.bbnUpdMainClick(Sender: TObject);
var
  RepNo: integer;
begin
  RepNo := FReportData.ReportNo;
  FreeAndNil(FReportData);
  FReportData := FReportController.UpdateReport(RepNo, edTemplate.Text, edDoctype.Text,
    edStoredProc.Text, edDataset.Text, edDescription.Text);
  if FReportData <> nil then
  begin
    bbnApply.Enabled := true;
    sbtnAddSR.Enabled := true;
    sbtnRemoveSR.Enabled := true;
  end;
end;

function TfrmReportSettings.Execute(TCMC: TCMReportController;
  aRepData: TCMMReportData): TCMMReportData;
var
  srName: string;
  srl: TCMSReportsData;
  sr: TCMReportData;
  i: integer;
begin
  try
    FReportData := aRepData;
    bbnApply.Enabled := false;
    bbnCrtMain.Caption := 'Update Main';
    bbnCrtMain.OnClick := bbnUpdMainClick;
    frmReportSettings.Caption := 'Report settings  -- Update Report';
    FReportController := TCMC;

    // Fill form with data
    FRepNo := FReportData.ReportNo;
    edTemplate.Text := FReportData.Template;
    edDoctype.Text := intToStr(FReportData.docType);
    edStoredProc.Text := FReportData.storedProcName;
    edDataset.Text := FReportData.datasetUserName;
    edDescription.Text := FReportData.description;

    // Fill listbox with existing subReports
    srl := FReportData.subReportsData;
    if Assigned(srl) then
      for sr in srl do
      begin
        lbxSubReports.Items.AddObject(sr.name, sr);
      end;

    if (ShowModal = mrOK) then

    // Report now updated - add subreports and move on
    begin
      if lbxSubReports.Items.Count > 0 then
      begin
        srl := TCMSReportsData.Create;
        for i := 0 to lbxSubReports.Items.Count - 1 do
        begin
          srl.Add(TCMSReportData(lbxSubReports.Items.Objects[i]));
        end;
      end;
      FReportData.subReportsData := srl;
      Result := FReportData;
    end
    else
      Result := nil;
  finally
//    FreeAndNil(srl);
//    for i := 0 to lbxSubReports.Items.Count - 1 do
//      TCMSubReport(lbxSubReports.Items.Objects[i]).Free;
    lbxSubReports.Items.Clear;
  end;
end;

procedure TfrmReportSettings.sbtnAddSRClick(Sender: TObject);
var
  srd: TCMSReportData;
begin
  srd := frmSubReportSettings.Execute(FReportController, FReportData.ReportNo);
  lbxSubReports.Items.AddObject(srd.name, srd);
end;

procedure TfrmReportSettings.sbtnRemoveSRClick(Sender: TObject);
begin
  lbxSubReports.Items.Delete(lbxSubReports.ItemIndex);
end;

end.
