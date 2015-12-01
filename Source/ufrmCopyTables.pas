unit ufrmCopyTables;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Data.DB, FireDAC.Comp.Client, Bde.DBTables,
  FireDAC.Phys.MSSQL;

type
  TfrmCopyTables = class(TForm)
    BatchMove1: TBatchMove;
    tblSource: TTable;
    tblDest: TTable;
    destConnection: TFDConnection;
    srcConnection: TFDConnection;
    rgDest: TRadioGroup;
    rgSource: TRadioGroup;
    rgDBTable: TRadioGroup;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    procedure rgSourceClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rgDestClick(Sender: TObject);
    procedure rgDBTableClick(Sender: TObject);
    procedure tblDestAfterPost(DataSet: TDataSet);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    procedure setUpConnection(aConnection: TFDConnection; aServer: string);
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
  BatchMove1.Execute;
end;

procedure TfrmCopyTables.FormCreate(Sender: TObject);
begin
  rgSource.Items.Clear;
  rgSource.Items.AddObject(cAlvesql01, tblSource);
  rgSource.Items.AddObject(cAlvesql03, tblSource);
  rgSource.Items.AddObject(cAlvesqlTest, tblSource);

  rgDest.Items.Clear;
  rgDest.Items.AddObject(cAlvesql01, tblDest);
  rgDest.Items.AddObject(cAlvesql03, tblDest);
  rgDest.Items.AddObject(cAlvesqlTest, tblDest);

end;

procedure TfrmCopyTables.rgDBTableClick(Sender: TObject);
begin
  tblSource.TableName := rgDBTable.Items[rgDBTable.ItemIndex];
  tblDest.TableName := rgDBTable.Items[rgDBTable.ItemIndex];
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

procedure TfrmCopyTables.tblDestAfterPost(DataSet: TDataSet);
begin
  label1.Caption := intToStr(BatchMove1.RecordCount) + ' records copied!';
end;

end.
