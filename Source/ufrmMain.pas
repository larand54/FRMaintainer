unit ufrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait, frxDesgn, FireDAC.Comp.UI, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ComCtrls, frxClass, frxExportRTF,
  frxRich, Vcl.ImgList, Vcl.Buttons;

type
  TfrmMain = class(TForm)
    GroupBox1: TGroupBox;
    btnRemoveReport: TButton;
    btnRunReport: TButton;
    btnDesignReport: TButton;
    btnNewReport: TButton;
    ReportTree: TTreeView;
    Label1: TLabel;
    FDQuery1: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    frxDesigner1: TfrxDesigner;
    frxReport1: TfrxReport;
    frxRichObject1: TfrxRichObject;
    Memo1: TMemo;
    ImageList1: TImageList;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btnDesignReportClick(Sender: TObject);
    procedure ReportTreeClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
        FReportPath : string;
        procedure BuildTree;

  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation
uses udmFR, uReport;
{$R *.dfm}

procedure TfrmMain.BitBtn1Click(Sender: TObject);
begin
  close;
end;

procedure TfrmMain.btnDesignReportClick(Sender: TObject);
var
  report: TCMMMReport;
  node: TTreeNode;
  templateFile: string;
begin
   Report := ReportTree.Selected.Data;
   if Report <> nil then begin

   TemplateFile := FReportPath+'\'+Report.Template;
   frxReport1.LoadFromFile(TemplateFile);
   frxReport1.DesignReport;
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
    dmFR.tblDBProps.Close;
    dmFR.qryFastReports.Close;
  end;
end;



procedure TfrmMain.ReportTreeClick(Sender: TObject);
var
  node : TTreeNode;
  Descr: string;
begin
  node := ReportTree.Selected;
  if (node.data <> nil) then begin

  Memo1.Clear;
  Descr := TCMMReport(Node.Data).description;
  if Descr <> '' then Memo1.Lines.Add(Descr);
  end;
end;

procedure TfrmMain.BuildTree;
var
  node : TTreeNode;
  subItem : TTreeNode;
  qry : TFDQuery;
  sp_name : string;
  DsU_name: string;
  RepNo: integer;
  Descr: string;
  Template: string;
  docType, LastDocType: integer;
  report: TCMMMReport;

begin
  node := ReportTree.Items.Add(nil,'Avalable Reports...');
  node.ImageIndex := 0;

  qry := dmFR.qryFastReports;
  qry.Active := true;
  qry.First;
  lastDocType := -1; // To identify First record in the loop
  while not qry.Eof do begin
    if(qry['DatasetUserName']<> null) then DsU_name := qry['DatasetUserName']
    else DsU_name := '';
    if(qry['StoredProcName'] <> null) then sp_name := qry['StoredProcName']
    else sp_name := '';
    RepNo := qry['ReportNo'];
    docType := qry['DocType'];
    Template :=  qry['ReportName'];
    if (qry['Beskrivning'] <> null) then Descr := qry['Beskrivning'];
    Report := TCMMMReport.Create(Template, RepNo, docType, sp_name, DsU_name, Descr);
      if lastDocType <> docType then begin
        node := ReportTree.Items.AddChildObject(ReportTree.Selected, intToStr(docType),nil);
        lastDocType := docType;
      end;
      subItem := ReportTree.Items.AddChildObject(node, Template,Report);

      subItem.ImageIndex := 1;
      subItem.SelectedIndex := 1;

//     node.Parent := ReportTree;
     qry.Next;
  end;
  node.Free;
  qry.Close;
end;

end.
