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
  uReport, Vcl.ButtonGroup, Vcl.ExtCtrls;

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
    btnRunReport: TButton;
    btnDesignReport: TButton;
    btnNewReport: TButton;
    btnProperties: TButton;
    Label2: TLabel;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnDesignReportClick(Sender: TObject);
    procedure ReportTreeClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure btnRunReportClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FReportPath: string;
    FReport: TCMMReport;
    FfrxDataSet: TfrxDBDataset;
    FfdStoredProc: TFDStoredProc;

    FspList: TList<TFDStoredProc>;
    FfrxDSList: TList<TfrxDBDataset>;

    procedure BuildTree;
    procedure createDBComponents;
    procedure getParameters(aReport: TCMReport);
    procedure freeUpDBComponents;
    procedure freeUpReport;

  public
    { Public declarations }
    Property report: TCMMReport read FReport write FReport;
    Property frxDataset: TfrxDBDataset read FfrxDataSet write FfrxDataSet;
    Property fdStoredProc: TFDStoredProc read FfdStoredProc write FfdStoredProc;
    Property frxDSList: TList<TfrxDBDataset> read FfrxDSList write FfrxDSList;
    Property spList: TList<TFDStoredProc> read FspList write FspList;
  end;

var
  frmMain: TfrmMain;

implementation

uses udmFR, uReportController, ufrmAddParams;
{$R *.dfm}

procedure TfrmMain.BitBtn1Click(Sender: TObject);
begin
  close;
end;

procedure TfrmMain.btnDesignReportClick(Sender: TObject);
var
  report: TCMMReport;
  node: TTreeNode;
  templateFile: string;
begin
  report := ReportTree.Selected.Data;
  if report <> nil then
  begin
    templateFile := FReportPath + '\' + report.Template;
    frxReport1.DataSet := frxDataset;
    frxReport1.LoadFromFile(templateFile);
    frxReport1.DesignReport;
  end;
end;

procedure TfrmMain.btnRunReportClick(Sender: TObject);
var
  node: TTreeNode;
  RepNo: integer;
  RC: TCMReportController;
begin
  // Report.params := frmAddParams.execute;

  node := ReportTree.Selected;
  if (node.Data <> nil) then
  begin
    report := node.Data;
    RepNo := report.ReportNo;
    if RepNo > 0 then
    begin
      getParameters(report);
      RC := TCMReportController.Create(RepNo, report.params, frPreview);
      if (RC <> nil) then
      begin
        RC.RunReport(frPreview);
      end;
    end;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Memo1.Clear;
  try
    dmFR.tblDBProps.Open();
    dmFR.qryFastReports.Active;
    FReportPath := dmFR.tblDBProps['FastPath'];
    BuildTree;
  finally
    dmFR.tblDBProps.close;
    dmFR.qryFastReports.close;
  end;
end;

procedure TfrmMain.freeUpDBComponents;
begin
  Report.freeUpDBComponents;
end;

procedure TfrmMain.freeUpReport;
begin
  FreeAndNil(FReport);
end;

procedure TfrmMain.getParameters(aReport: TCMReport);
begin
  aReport.params := frmAddParams.execute;
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
    Descr := TCMMReport(node.Data).description;
    if Descr <> '' then
      Memo1.Lines.Add(Descr);
    createDBComponents;
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
  subItmIndx : integer;

begin
  node := ReportTree.Items.Add(nil, 'Avalable Reports...');
  node.ImageIndex := 0;

  qry := dmFR.qryFastReports;
  qry.Active := true;
  qry.First;
  LastDocType := -1; // To identify First record in the loop
  while not qry.Eof do
  begin
    if (qry['DatasetUserName'] <> null) then
      DsU_name := qry['DatasetUserName']
    else
      DsU_name := '';
    if (qry['StoredProcName'] <> null) then
      sp_name := qry['StoredProcName']
    else
      sp_name := '';
    RepNo := qry['ReportNo'];
    docType := qry['DocType'];
    Template := qry['ReportName'];
    if (qry['Beskrivning'] <> null) then
      Descr := qry['Beskrivning']
    else
      Descr := '';
    try
      report := TCMMReport.Create(Template, RepNo, '', docType, sp_name,
        DsU_name, Descr, dmFR.FDConnection1);
      subItmIndx := 1;
    except
      on E: ETCMStoredProcNameMissing do
      begin
        subItmIndx := 2;
      end;
    end;
    if LastDocType <> docType then
    begin
      node := ReportTree.Items.AddChildObject(ReportTree.Selected,
        intToStr(docType), nil);
      LastDocType := docType;
    end;
    subItem := ReportTree.Items.AddChildObject(node, Template, report);

    subItem.ImageIndex := subItmIndx;
    subItem.SelectedIndex := subItmIndx;


    // node.Parent := ReportTree;
    qry.Next;
  end;
  node.Free;
  qry.close;
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
  dic.Add('ABC','123');
  dic.Add('DEF','456');
  dic.Add('GHI','789');
  dic.Add('JKL','012');
  dic.Add('ABC','776');
  dic.Add('MNO','888');
  except on E: EListError do
  end;
  lb := TListBox.Create(self);
  lb.parent := frmMain;
  for key in dic.Keys do

  lb.Items.Add(key+':  '+dic.Items[key]);
end;

procedure TfrmMain.createDBComponents;
var

  srs: TCMSubReports;
  srArr: TArray<TPair<String, TCMSubReport>>;
  sr: TCMSubReport;
  srParams: TFDParams;
  i, k: integer;

begin
  // Create and prepare Stored procedure used by the Main report
  fdStoredProc := TFDStoredProc.Create(nil);
  fdStoredProc.Connection := dmFR.FDConnection1;
  fdStoredProc.Active := false;
  fdStoredProc.StoredProcName := FReport.StoredProcName;
  fdStoredProc.prepare;

  // Create and prepare the frxDBDataset component
  frxDataset := TfrxDBDataset.Create(nil);
  frxDataset.CloseDataSource := false;
  frxDataset.BCDToCurrency := false;
  frxDataset.DataSet := fdStoredProc;
  frxDataset.UserName := report.DatasetUserName;

  // Create components for the subreport(s)
  srs := FReport.subReports;
  if srs <> nil then
  begin
    srArr := srs.ToArray;

    if (spList <> nil) then
      spList.Clear
    else
      spList := TList<TFDStoredProc>.Create;

    if (frxDSList <> nil) then
      frxDSList.Clear
    else
      frxDSList := TList<TfrxDBDataset>.Create;

    i := 0;
    while (i < srs.Count) do
    begin
      sr := srArr[i].Value;
      if (sr.StoredProcName <> '') then
        if (sr.DatasetUserName <> '') then
        begin

          spList.Add(TFDStoredProc.Create(nil));
          spList[i].Connection := dmFR.FDConnection1;
          spList[i].Active := false;
          spList[i].StoredProcName := sr.StoredProcName;
          spList[i].prepare;

          frxDSList.Add(TfrxDBDataset.Create(nil));
          frxDSList[i].CloseDataSource := false;
          frxDSList[i].BCDToCurrency := false;
          frxDSList[i].DataSet := spList[i];
          frxDSList[i].UserName := sr.DatasetUserName;

          spList[i].Active := true;

        end;
      inc(i);
    end;

  end;
end;

end.
