unit ufrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  System.Generics.Collections,
  Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait, frxDesgn, FireDAC.Comp.UI, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ComCtrls, frxClass, frxExportRTF,
  frxRich, Vcl.ImgList, Vcl.Buttons, frxDBSet,
  uReport, Vcl.ButtonGroup, Vcl.ExtCtrls,
  uReportController, siComp, siLngLnk;

type
  TfrmMain = class(TForm)
    Label1: TLabel;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    frxDesigner1: TfrxDesigner;
    frxReport1: TfrxReport;
    frxRichObject1: TfrxRichObject;
    ImageList1: TImageList;
    Panel1: TPanel;
    ReportTree: TTreeView;
    Panel2: TPanel;
    Memo1: TMemo;
    BitBtn1: TBitBtn;
    GroupBox1: TGroupBox;
    btnRemoveReport: TButton;
    ptnPreview: TButton;
    btnDesignReport: TButton;
    btnNewReport: TButton;
    btnProperties: TButton;
    Label2: TLabel;
    Button1: TButton;
    btnPrint: TButton;
    btnFile: TButton;
    siLangLinked_frmMain: TsiLangLinked;
    btnLanguage: TButton;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnDesignReportClick(Sender: TObject);
    procedure ReportTreeClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure ptnPreviewClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnFileClick(Sender: TObject);
    procedure btnNewReportClick(Sender: TObject);
    procedure btnPropertiesClick(Sender: TObject);
    procedure btnRemoveReportClick(Sender: TObject);
    procedure btnLanguageClick(Sender: TObject);
  private
    { Private declarations }
    FReportPath: string;
    FfrxDataSet: TfrxDBDataset;
    FfdStoredProc: TFDStoredProc;
    FReportController: TCMReportController;

    FspList: TList<TFDStoredProc>;
    FfrxDSList: TList<TfrxDBDataset>;
    FReportData: TCMMReportData;
    FSReportData: TCMSReportData;
    FParams: TCMParams;

    procedure BuildTree;
    procedure getParameters;
    procedure freeUpDBComponents;
    procedure freeUpReport;
    function prepareForOutput: integer;

  public
    { Public declarations }
    Property report: TCMMReportData read FReportData write FReportData;
    Property frxDataset: TfrxDBDataset read FfrxDataSet write FfrxDataSet;
    Property fdStoredProc: TFDStoredProc read FfdStoredProc write FfdStoredProc;
    Property frxDSList: TList<TfrxDBDataset> read FfrxDSList write FfrxDSList;
    Property spList: TList<TFDStoredProc> read FspList write FspList;
    Property reportController: TCMReportController read FReportController;
  end;

var
  frmMain: TfrmMain;

implementation

uses udmFR, ufrmAddParams, ufrmReportSettings;
{$R *.dfm}

procedure TfrmMain.BitBtn1Click(Sender: TObject);
begin
  close;
end;

procedure TfrmMain.btnDesignReportClick(Sender: TObject);
var
  report: TCMMReportData;
  node: TTreeNode;
  templateFile: string;
begin
  report := ReportTree.Selected.Data;
  if report <> nil then
  begin
    reportController.DesignReport(report.ReportNo);
  end
  else
  begin
    // Create new template without any report connected
    if MessageDlg
      (siLangLinked_frmMain.GetTextOrDefault('IDS_0' (* 'You are going to create a new template without any specified report' *) ),
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      frxReport1.DataSet := nil;
      frxReport1.DesignReport;
    end;
  end;
end;

procedure TfrmMain.ptnPreviewClick(Sender: TObject);
begin
  reportController.RunReport(prepareForOutput, FParams, frPreview);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Memo1.Clear;
  FReportData := nil;
  try
    FReportController := TCMReportController.create;
    FReportPath := FReportController.TemplatePath;
    dmFR.qryFastReports.Active;
    BuildTree;
  finally
    dmFR.qryFastReports.close;
  end;
end;

procedure TfrmMain.freeUpDBComponents;
begin
  // Report.freeUpDBComponents;
end;

procedure TfrmMain.freeUpReport;
begin
  // FreeAndNil(FReport);
end;

procedure TfrmMain.getParameters;
begin
  FParams := frmAddParams.execute;
end;

function TfrmMain.prepareForOutput: integer;
var
  node: TTreeNode;
  RepNo: integer;
begin
  node := ReportTree.Selected;
  if (node.Data <> nil) then
  begin
    report := node.Data;
    RepNo := report.ReportNo;
    if RepNo > 0 then
    begin
      // getParameters;
      FParams := TCMParams.create;
      FParams.Add('@INVOICENO', 29366);
    end;
    result := RepNo;
  end;
end;

procedure TfrmMain.ReportTreeClick(Sender: TObject);
var
  node: TTreeNode;
  Descr: string;
begin
  node := ReportTree.Selected;
  if (node.Data <> nil) then
  begin
    report := node.Data;
    freeUpDBComponents;
    Memo1.Clear;
    Descr := TCMMReportData(node.Data).description;
    if Descr <> '' then
      Memo1.Lines.Add(Descr);
  end;
end;

procedure TfrmMain.BuildTree;
var
  node: TTreeNode;
  subItem: TTreeNode;
  qry: TFDQuery;
  sp_name: string;
  DsU_name: string;
  RepNo: integer;
  Descr: string;
  Template: string;
  docType, LastDocType: integer;
  subItmIndx: integer;
  Reportsdata: TCMMReportsdata;
  Reportdata: TCMMReportData;

begin
ReportTree.Items.Clear;
  node := ReportTree.Items.Add(nil, siLangLinked_frmMain.GetTextOrDefault('IDS_2' (* 'Avalable Reports...' *) ));
  node.ImageIndex := 0;
  try
    Reportsdata := reportController.AllReports;
  except
    on E: ETCMStoredProcNameMissing do
  end;
  LastDocType := -1; // To identify First record in the loop
  for Reportdata in Reportsdata do
  begin
    if Reportdata.StoredProcName = '' then
      subItmIndx := 2
    else
      subItmIndx := 1;
    docType := Reportdata.docType;
    Template := Reportdata.Template;
    if LastDocType <> docType then
    begin
      node := ReportTree.Items.AddChildObject(ReportTree.Selected,
        intToStr(docType), nil);
      LastDocType := docType;
    end;
    subItem := ReportTree.Items.AddChildObject(node, Template, Reportdata);

    subItem.ImageIndex := subItmIndx;
    subItem.SelectedIndex := subItmIndx;
  end;
  node.Free;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
var
  dic: TDictionary<String, string>;
  lb: TListbox;
  key: string;
begin
  // Test something -- TDictionary for instance
  dic := TDictionary<String, string>.create;
  try
    dic.Add('ABC', '123');
    dic.Add('DEF', '456');
    dic.Add('GHI', '789');
    dic.Add('JKL', '012');
    dic.Add('ABC', '776');
    dic.Add('MNO', '888');
  except
    on E: EListError do
  end;
  lb := TListbox.create(self);
  lb.parent := frmMain;
  for key in dic.Keys do

    lb.Items.Add(key + ':  ' + dic.Items[key]);
  if dmFR.reportExist(105) then
    MessageDlg('Rapport 105 existerar', mtInformation, [mbOK], 0)
  else
    MessageDlg('Rapport 105 existerar  I N T E !!!!', mtInformation, [mbOK], 0);
  if dmFR.reportExist(405) then
    MessageDlg('Rapport 405 existerar', mtInformation, [mbOK], 0)
  else
    MessageDlg('Rapport 405 existerar  I N T E !!!!', mtInformation, [mbOK], 0);

  if dmFR.subReportExist(105, 'CertWoodInv') then
    MessageDlg('Rapport CertWoodInv existerar', mtInformation, [mbOK], 0)
  else
    MessageDlg('Rapport CertWoodInv existerar  I N T E !!!!', mtInformation,
      [mbOK], 0);

  if dmFR.subReportExist(105, 'CertWood') then
    MessageDlg('Rapport CertWood existerar', mtInformation, [mbOK], 0)
  else
    MessageDlg('Rapport CertWood existerar  I N T E !!!!', mtInformation,
      [mbOK], 0);
  dmFR.addReport(105, FReportData);
end;

procedure TfrmMain.btnLanguageClick(Sender: TObject);
var
  nol: integer;
begin
  nol := dmFR.siLang1.NumOfLanguages;
  if dmFR.siLang1.ActiveLanguage = nol - 1 then
    dmFR.siLang1.ActiveLanguage := 1
  else
    dmFR.siLang1.ActiveLanguage := dmFR.siLang1.ActiveLanguage + 1;
  btnLanguage.Caption := dmFR.siLang1.Language;
end;

procedure TfrmMain.btnPrintClick(Sender: TObject);
begin
  reportController.RunReport(prepareForOutput, FParams, frPrint);
end;

procedure TfrmMain.btnPropertiesClick(Sender: TObject);
var
  node: TTreeNode;
  subItem: TTreeNode;
begin
  if not assigned(FReportData) then
  begin
    MessageDlg(siLangLinked_frmMain.GetTextOrDefault('IDS_25' (* 'Please select a report!' *) ), mtInformation, [mbOK], 0);
    exit;
  end;

  FReportData := frmReportSettings.execute(reportController, FReportData);
  if FReportData <> nil then
  begin
    if dmFR.upDateReport(FReportData.ReportNo, FReportData) then
    begin
      BuildTree;
      ReportTree.Refresh;
    end;
  end;
end;

procedure TfrmMain.btnRemoveReportClick(Sender: TObject);
var
  report: TCMMReportData;
  node: TTreeNode;
  templateFile: string;
begin
  report := ReportTree.Selected.Data;
  if report <> nil then
  begin
    if MessageDlg(siLangLinked_frmMain.GetTextOrDefault('IDS_26' (* 'You are going to remove the report: ' *) ) + report.Template,
      mtWarning, [mbOK, mbCancel], 0) = mrOK then
    begin
      if reportController.DeleteReport(report.ReportNo) then
        ReportTree.Selected.Delete;
      ReportTree.Refresh;
    end;
  end;
end;

procedure TfrmMain.btnFileClick(Sender: TObject);
begin
  reportController.RunReport(prepareForOutput, FParams, frFile);
end;

procedure TfrmMain.btnNewReportClick(Sender: TObject);
var
  node: TTreeNode;
  subItem: TTreeNode;
begin
  FReportData := frmReportSettings.execute(reportController);
  if FReportData <> nil then
  begin
    if dmFR.addReport(FReportData.ReportNo, FReportData) then
    begin
      BuildTree;
      ReportTree.Refresh
    end;
  end;
end;

end.
