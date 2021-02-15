unit ufrmTranslations;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, udmFR, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinWhiteprint, dxSkinVS2010, dxSkinXmas2008Blue,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxGridDBDataDefinitions,
  System.Actions, Vcl.ActnList, Vcl.StdCtrls, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.MSSQL, Vcl.ExtCtrls;

type
  TfrmTranslations = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edTextID: TEdit;
    edEnglish: TEdit;
    edSwedish: TEdit;
    btnAdd: TButton;
    btnExit: TButton;
    btnReplicate: TButton;
    btnDltSelected: TButton;
    ActionList1: TActionList;
    acnUpdate: TAction;
    acnAdd: TAction;
    acnCancel: TAction;
    acnExit: TAction;
    acnFromFile: TAction;
    acnReplicateTable: TAction;
    acnDeleteSelected: TAction;
    tblTextTranslations: TFDTable;
    tblTextTranslationsTextID: TStringField;
    tblTextTranslationsEnglish: TStringField;
    tblTextTranslationsSwedish: TStringField;
    tblTextTranslationslastChanged: TSQLTimeStampField;
    dscTranslation: TDataSource;
    qryExist: TFDQuery;
    qryExistTextID: TStringField;
    qryExistEnglish: TStringField;
    qryExistSwedish: TStringField;
    qryExistlastChanged: TSQLTimeStampField;
    qryUpd: TFDQuery;
    qryAdd: TFDQuery;
    FDConnection1: TFDConnection;
    qryReplicateSrc: TFDQuery;
    qryReplicateSrcTextID: TStringField;
    qryReplicateSrcEnglish: TStringField;
    qryReplicateSrcSwedish: TStringField;
    qryReplicateSrclastChanged: TSQLTimeStampField;
    qryReplicateTarget: TFDQuery;
    qryTruncTarget: TFDQuery;
    qryDelete: TFDQuery;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1DBTableView1TextID: TcxGridDBColumn;
    cxGrid1DBTableView1English: TcxGridDBColumn;
    cxGrid1DBTableView1Swedish: TcxGridDBColumn;
    cxGrid1DBTableView1lastChanged: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    cbbSelectDBServer: TComboBox;
    lblSelectDBServer: TLabel;
    procedure edTextIDExit(Sender: TObject);
    procedure edTextIDChange(Sender: TObject);
    procedure edEnglishExit(Sender: TObject);
    procedure edSwedishExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure acnAddExecute(Sender: TObject);
    procedure acnUpdateExecute(Sender: TObject);
    procedure acnExitExecute(Sender: TObject);
    procedure acnCancelExecute(Sender: TObject);
    procedure cxGrid1DBTableView1FocusedRecordChanged(
      Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure acnReplicateTableExecute(Sender: TObject);
    procedure acnDeleteSelectedExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbbSelectDBServerChange(Sender: TObject);
  private
    { Private declarations }
    FTextID_Changed: Boolean;
    FEnglish_Changed: Boolean;
    FSwedish_Changed: Boolean;
    FTextID_Origin: string;
    FEnglish_Origin: string;
    FSwedish_Origin: string;
    procedure addTranslation(aTextID, aEng, aSwe: string);
    procedure updTranslation(aTextID, aEng, aSwe: string);
    procedure btnAddToUpd;
    procedure btnUpdToAdd;
    procedure btnExitToCancel;
    procedure btnCancelToExit;
    procedure updTextFields;
    function Exist(aTextID: string): Boolean;
    procedure ReconnectDBServer(const aDBServer: string);
    procedure setCaption;

  public
    { Public declarations }
  end;

var
  frmTranslations: TfrmTranslations;

implementation

{$R *.dfm}


procedure TfrmTranslations.acnAddExecute(Sender: TObject);
begin
  addTranslation(edTextID.Text, edEnglish.Text, edSwedish.Text);
end;

procedure TfrmTranslations.acnCancelExecute(Sender: TObject);
begin
  acnExitExecute(Sender);
end;

procedure TfrmTranslations.acnDeleteSelectedExecute(Sender: TObject);
var
  RecIdx, Col1Idx: integer;
  DC: TcxGridDBDataController;
  ID: string;
begin
  If cxGrid1DBTableView1.DataController.FocusedRowIndex > -1 then
  begin
    DC := cxGrid1DBTableView1.DataController;
    IF DC = NIL then exit;
    with cxGrid1DBTableView1 do
    begin
      RecIdx := Controller.SelectedRecords[0].RecordIndex;
      Col1Idx := DC.GetItemByFieldName('TextID').Index;
      ID := DC.Values[RecIdx, Col1Idx];
      If messageDlg('Do you want to delete: '+ID+ ' ?',mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
      begin
        qryDelete.Active := false;
        qryDelete.Prepare;
        qryDelete.ParamByName('TextID').AsString := ID;
        qryDelete.ExecSQL;
        tblTextTranslations.Refresh;
      end;
    end;
  end;
end;

procedure TfrmTranslations.acnExitExecute(Sender: TObject);
begin
  tblTextTranslations.Close;
  qryExist.Close;
  qryUpd.Close;
  qryAdd.Close;
end;

procedure TfrmTranslations.acnReplicateTableExecute(Sender: TObject);
begin
  qryTruncTarget.ExecSQL;
  qryReplicateTarget.prepare;
  qryReplicateSrc.Active := false;
  qryReplicateSrc.Active := true;
  while not qryReplicateSrc.Eof do begin
    qryReplicateTarget.ParamByName('TextID').AsString := qryReplicateSrc['TextID'];
    qryReplicateTarget.ParamByName('English').AsString := qryReplicateSrc['English'];
    qryReplicateTarget.ParamByName('Swedish').AsString := qryReplicateSrc['Swedish'];
    qryReplicateTarget.ParamByName('lastChanged').AsDateTime := qryReplicateSrc['lastChanged'];
    qryReplicateTarget.ExecSQL;
    qryReplicateSrc.Next;
  end;
end;

procedure TfrmTranslations.acnUpdateExecute(Sender: TObject);
begin
  updTranslation(edTextID.Text, edEnglish.Text, edSwedish.Text);
  tblTextTranslations.Refresh;
end;

procedure TfrmTranslations.addTranslation(aTextID, aEng, aSwe: string);
begin
  try
    qryAdd.Close;
    qryAdd.prepare;
    qryAdd.ParamByName('TextID').AsString := aTextID;
    qryAdd.ParamByName('ENG').AsString := aEng;
    qryAdd.ParamByName('SWE').AsString := aSwe;
    qryAdd.ExecSQL;
    if Exist(aTextID) then
    begin
      updTextFields();
      tblTextTranslations.Refresh;
    end;
  finally
    btnExit.Enabled := true;
    btnCancelToExit;
    btnAdd.Enabled := false;
  end;
end;

procedure TfrmTranslations.btnAddToUpd;
begin
  btnAdd.Caption := 'Update';
  btnAdd.Action := acnUpdate;
  btnAdd.Enabled := true;
end;

procedure TfrmTranslations.btnCancelToExit;
begin
  btnExit.Caption := 'Exit';
  btnExit.Action := acnExit;
  btnExit.Enabled := true;
end;

procedure TfrmTranslations.btnExitToCancel;
begin
  btnExit.Caption := 'Cancel';
  btnExit.Action := acnCancel;
  btnExit.Enabled := true;
end;

procedure TfrmTranslations.btnUpdToAdd;
begin
  btnAdd.Caption := 'Add';
  btnAdd.Action := acnAdd;
  btnAdd.Enabled := true;
  btnExit.Enabled := true;
end;

procedure TfrmTranslations.cbbSelectDBServerChange(Sender: TObject);
begin
  ReconnectDBServer(cbbSelectDBServer.Text);
end;

procedure TfrmTranslations.cxGrid1DBTableView1FocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
var
  RecIdx, Col1Idx, Col2Idx, Col3Idx: integer;
  DC: TcxGridDBDataController;
begin
  If AFocusedRecord <> NIL then
  begin
    DC := TcxGridDBDataController(Sender.DataController);
    IF Sender.DataController = NIL then exit;
    with TcxCustomGridTableView(Sender) do
    begin
      RecIdx := Controller.SelectedRecords[0].RecordIndex;
      Col1Idx := DC.GetItemByFieldName('TextID').Index;
      Col2Idx := DC.GetItemByFieldName('English').Index;
      Col3Idx := DC.GetItemByFieldName('Swedish').Index;
      If Exist(DataController.Values[RecIdx, Col1Idx]) then begin
        updTextFields;
        btnAddToUpd;
        btnExitToCancel;
      end;
    end;
  end;
end;

procedure TfrmTranslations.edEnglishExit(Sender: TObject);
begin
  FEnglish_Changed := FEnglish_Origin <> edEnglish.Text;
  if FEnglish_Changed then btnExitToCancel;
end;

procedure TfrmTranslations.edSwedishExit(Sender: TObject);
begin
  FSwedish_Changed := FSwedish_Origin <> edSwedish.Text;
  if FSwedish_Changed then btnExitToCancel;
end;

procedure TfrmTranslations.edTextIDChange(Sender: TObject);
begin
  FTextID_Changed := FTextID_Origin <> edTextID.Text;
end;

procedure TfrmTranslations.edTextIDExit(Sender: TObject);
begin
  if FTextID_Changed then
    if Exist(edTextID.Text) then
    begin
      updTextFields;
      btnAddToUpd
    end
    else
    begin
      edEnglish.Text := '';
      edSwedish.Text := '';
      btnUpdToAdd;
      qryUpd.prepare;
    end;
end;

function TfrmTranslations.Exist(aTextID: string): Boolean;
begin
  try
    qryExist.Close;
    qryExist.prepare;
//    qryExist.ParamByName('TextID').AsString := edTextID.Text;
    qryExist.ParamByName('TextID').AsString := aTextID;
    qryExist.Active := true;
  finally
    Result := qryExist.RecordCount > 0;
  end;
end;

procedure TfrmTranslations.FormCreate(Sender: TObject);
begin
  edTextID.Text := '';
  edEnglish.Text := '';
  edSwedish.Text := '';
  btnExitToCancel;
  tblTextTranslations.Open();
  btnReplicate.Enabled := true;
end;

procedure TfrmTranslations.FormShow(Sender: TObject);
begin
  cbbSelectDBServer.ItemIndex := 0;
  ReconnectDBServer(cbbSelectDBServer.Text);
  tblTextTranslations.Open;
end;

procedure TfrmTranslations.ReconnectDBServer(const aDBServer: string);
var
  ix : integer;
begin
  FDConnection1.Close;
  ix := FDConnection1.Params.IndexOfName('Server');
  FDConnection1.Params[ix] := 'server='+aDBServer;
  setCaption;
  tblTextTranslations.Open;
end;

procedure TfrmTranslations.setCaption;
begin
  Caption := 'FASTREPORT TRANSLATIONS' + '   Server: ' + FDConnection1.Params.Values['Server']+'   Database: ' + FDConnection1.Params.Values['Database'];
end;

procedure TfrmTranslations.updTextFields;
begin
  edTextID.Text := qryExist['TextID'];
  edEnglish.Text := qryExist['English'];
  edSwedish.Text := qryExist['Swedish'];
  FEnglish_Origin := edEnglish.Text;
  FSwedish_Origin := edSwedish.Text;
  FEnglish_Changed := false;
  FSwedish_Changed := false;
end;

procedure TfrmTranslations.updTranslation(aTextID, aEng, aSwe: string);
begin
  try
    qryUpd.Close;
    qryUpd.prepare;
    qryUpd.ParamByName('TextID').AsString := aTextID;
    qryUpd.ParamByName('ENG').AsString := aEng;
    qryUpd.ParamByName('SWE').AsString := aSwe;
    qryUpd.ExecSQL;
    if Exist(aTextID) then
    begin
      updTextFields();
      tblTextTranslations.Refresh;
    end;
  finally
    btnExit.Enabled := true;
    btnCancelToExit;
    btnAdd.Enabled := false;
  end;
end;

end.
