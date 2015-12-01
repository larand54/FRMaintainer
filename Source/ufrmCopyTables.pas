unit ufrmCopyTables;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Data.DB, FireDAC.Comp.Client, Bde.DBTables,
  FireDAC.Phys.MSSQL, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.VCLUI.Wait, Vcl.DBCtrls,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.UI;

type
  TfrmCopyTables = class(TForm)
    destConnection: TFDConnection;
    srcConnection: TFDConnection;
    rgDest: TRadioGroup;
    rgSource: TRadioGroup;
    rgDBTable: TRadioGroup;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    qrySrc: TFDQuery;
    qryDest: TFDQuery;
    qryTruncTarget: TFDQuery;
    tblSrc: TFDTable;
    tblDest: TFDTable;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    DataSource1: TDataSource;
    procedure rgSourceClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rgDestClick(Sender: TObject);
    procedure rgDBTableClick(Sender: TObject);
    procedure tblDestAfterPost(DataSet: TDataSet);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    FsrcTableName: string;
    FdstTableName: string;
    FNoOfRecCopied: integer;
    procedure setUpConnection(aConnection: TFDConnection; aServer: string);
    procedure startCopy;
  public
    { Public declarations }
  end;

var
  frmCopyTables: TfrmCopyTables;

implementation

{$R *.dfm}
const
  cAlvesql01 = 'Alvesql01';
  cAlvesql03 = 'Alvesql03';
  cAlvesqlTest = 'AlvesqlTest01';

procedure TfrmCopyTables.BitBtn1Click(Sender: TObject);
begin
  tblDest.Active := true;
  if MessageDlg('Are you sure Copy table?',
    mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
  begin
    if tblDest.RecordCount > 0 then
      if MessageDlg('Destinationtable not empty! Want to empty it?',
    mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then begin
      ShowMessage('You need to do it manually - Take backup first!');
      exit;
    end;

    StartCopy;
  end;

end;


procedure TfrmCopyTables.FormCreate(Sender: TObject);
begin
(*  rgSource.Items.Clear;
  rgSource.Items.AddObject(cAlvesql01, tblSrc);
  rgSource.Items.AddObject(cAlvesql03, tblSrc);
  rgSource.Items.AddObject(cAlvesqlTest, tblSrc);

  rgDest.Items.Clear;
  rgDest.Items.AddObject(cAlvesql01, tblDest);
  rgDest.Items.AddObject(cAlvesql03, tblDest);
  rgDest.Items.AddObject(cAlvesqlTest, tblDest);
  *)
  SetupConnection(destConnection, rgDest.Items[rgDest.ItemIndex]);
  SetupConnection(srcConnection, rgSource.Items[rgSource.ItemIndex]);

end;

procedure TfrmCopyTables.rgDBTableClick(Sender: TObject);
begin
  tblDest.Active := false;
  tblSrc.TableName := rgDBTable.Items[rgDBTable.ItemIndex];
  tblDest.TableName := rgDBTable.Items[rgDBTable.ItemIndex];
  tblDest.Active := true;
end;

procedure TfrmCopyTables.rgDestClick(Sender: TObject);
begin
  SetupConnection(destConnection, rgDest.Items[rgDest.ItemIndex]);
end;

procedure TfrmCopyTables.rgSourceClick(Sender: TObject);
begin
  TRadioButton(rgDest.Controls[rgSource.ItemIndex]).Checked := false;
  TRadioButton(rgDest.Controls[rgSource.ItemIndex]).Enabled := false;
  SetupConnection(srcConnection, rgSource.Items[rgSource.ItemIndex]);
end;

procedure TfrmCopyTables.setUpConnection(aConnection: TFDConnection;
  aServer: string);
begin
      with aConnection do begin
        Params.Clear;
        Params.Add('Server='+aServer);
        Params.Add('Database=vis_vida');
        Params.Add('OSAuthent=No');
        Params.add('MetaDefCatalog=vis_vida');
        Params.Add('MetaDefSchema=dbo');
        Params.Add('User_Name=Lars');
        Params.Add('Password=woods2011');
        Params.Add('DriverID=MSSQL');
      end;
end;

procedure TfrmCopyTables.startCopy;
begin
  FNoOfRecCopied := 0;
  tblDest.Active := true;
  tblDest.EmptyDataset;
  tblSrc.Active := true;
  tblSrc.First;
  while not tblSrc.EOF do begin
    tblDest.Insert;
    tblDest.CopyRecord(tblSrc);
    tblDest.Post;
    inc(FNoOfRecCopied);
    tblSrc.Next;
  end;
  tblSrc.Active := false;
  tblDest.Active := false;
end;

procedure TfrmCopyTables.tblDestAfterPost(DataSet: TDataSet);
begin
  label1.Caption := intToStr(FNoOfRecCopied) + ' records copied!';
end;

end.
