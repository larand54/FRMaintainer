unit ufrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait, frxDesgn, FireDAC.Comp.UI, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TfrmMain = class(TForm)
    GroupBox1: TGroupBox;
    Button4: TButton;
    Button3: TButton;
    Button2: TButton;
    Button1: TButton;
    ReportTree: TTreeView;
    Label1: TLabel;
    FDQuery1: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    frxDesigner1: TfrxDesigner;
    procedure FormCreate(Sender: TObject);
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
uses udmFR;
{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
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



procedure TfrmMain.BuildTree;
var
  node : TTreeNode;
  subItem : TTreeNode;
  qry : TFDQuery;
begin
  node := ReportTree.Items.Add(nil,'Avalable Reports...');
  node.ImageIndex := 0;

  qry := dmFR.qryFastReports;
  qry.Active := true;
  qry.First;
  while not qry.Eof do begin
     node := ReportTree.Items.AddChild(ReportTree.Selected, qry['ReportName']);
//     node.Parent := ReportTree;
     qry.Next;
  end;
  node.Free;
  qry.Close;
end;

end.
