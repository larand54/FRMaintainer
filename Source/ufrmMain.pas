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
  uReportController, siComp, siLngLnk, System.Actions, Vcl.ActnList;

type
  TErrorCode = class
  private
    FErrorCode: integer;
  public
    property ec: integer read FErrorCode;
    constructor create(aErrorCode: integer);
  end;

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
    bbnClose: TBitBtn;
    GroupBox1: TGroupBox;
    btnRemoveReport: TButton;
    btnPreview: TButton;
    btnDesignReport: TButton;
    btnNewReport: TButton;
    btnProperties: TButton;
    Label2: TLabel;
    btnPrint: TButton;
    btnFile: TButton;
    siLangLinked_frmMain: TsiLangLinked;
    btnLanguage: TButton;
    Label3: TLabel;
    ActionList1: TActionList;
    acnNew: TAction;
    acnClose: TAction;
    acnEdit: TAction;
    acnDesign: TAction;
    acnPreview: TAction;
    acnPrint: TAction;
    acnPDF: TAction;
    acnRemove: TAction;
    acnChgLanguage: TAction;
    procedure FormCreate(Sender: TObject);
    procedure ReportTreeClick(Sender: TObject);
    procedure ReportTreeHint(Sender: TObject; const Node: TTreeNode;
      var Hint: string);
    procedure acnCloseExecute(Sender: TObject);
    procedure acnChgLanguageExecute(Sender: TObject);
    procedure acnRemoveExecute(Sender: TObject);
    procedure acnPDFExecute(Sender: TObject);
    procedure acnPrintExecute(Sender: TObject);
    procedure acnPreviewExecute(Sender: TObject);
    procedure acnDesignExecute(Sender: TObject);
    procedure acnEditExecute(Sender: TObject);
    procedure acnNewExecute(Sender: TObject);
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
    FErrors: TStringList;
    DefReportTreeWndProc: TWndMethod;

    procedure ReportTreeWndProc(var Message: TMessage);

    procedure BuildTree;
    procedure getParameters;
    procedure freeUpDBComponents;
    procedure freeUpReport;
    function prepareForOutput: integer;
    function validateReportData(aReportData: TCMMReportData;
      errors: TStringList): boolean;

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
const
  TTS_ALWAYSTIP           = $01;
  TTS_NOPREFIX            = $02;
  { For IE >= 0x0500 }
  TTS_NOANIMATE           = $10;
  TTS_NOFADE              = $20;
  TTS_BALLOON             = $40;
  TTS_CLOSE               = $80;
  { For Windows >= Vista }
  TTS_USEVISUALSTYLE      = $100;  // Use themed hyperlinks

  TTF_IDISHWND            = $0001;
  TTF_CENTERTIP           = $0002;
  TTF_RTLREADING          = $0004;
  TTF_SUBCLASS            = $0010;
  TTF_TRACK               = $0020;
  TTF_ABSOLUTE            = $0080;
  TTF_TRANSPARENT         = $0100;
  TTF_PARSELINKS          = $1000;  // For IE >= 0x0501
  TTF_DI_SETITEM          = $8000;  // valid only on the TTN_NEEDTEXT callback

  TTDT_AUTOMATIC      = 0;
  TTDT_RESHOW         = 1;
  TTDT_AUTOPOP        = 2;
  TTDT_INITIAL        = 3;

  // ToolTip Icons (Set with TTM_SETTITLE)
  TTI_NONE            = 0;
  TTI_INFO            = 1;
  TTI_WARNING         = 2;
  TTI_ERROR           = 3;
  { For Windows >= Vista }
  TTI_INFO_LARGE      = 4;
  TTI_WARNING_LARGE   = 5;
  TTI_ERROR_LARGE     = 6;

  // Tool Tip Messages
  TTM_ACTIVATE        = WM_USER + 1;
  TTM_SETDELAYTIME    = WM_USER + 3;
  TTM_ADDTOOLA        = WM_USER + 4;
  TTM_DELTOOLA        = WM_USER + 5;
  TTM_NEWTOOLRECTA    = WM_USER + 6;
  TTM_GETTOOLINFOA    = WM_USER + 8;
  TTM_SETTOOLINFOA    = WM_USER + 9;
  TTM_HITTESTA        = WM_USER + 10;
  TTM_GETTEXTA        = WM_USER + 11;
  TTM_UPDATETIPTEXTA  = WM_USER + 12;
  TTM_ENUMTOOLSA      = WM_USER + 14;
  TTM_GETCURRENTTOOLA = WM_USER + 15;
  TTM_ADDTOOLW        = WM_USER + 50;
  TTM_DELTOOLW        = WM_USER + 51;
  TTM_NEWTOOLRECTW    = WM_USER + 52;
  TTM_GETTOOLINFOW    = WM_USER + 53;
  TTM_SETTOOLINFOW    = WM_USER + 54;
  TTM_HITTESTW        = WM_USER + 55;
  TTM_GETTEXTW        = WM_USER + 56;
  TTM_UPDATETIPTEXTW  = WM_USER + 57;
  TTM_ENUMTOOLSW      = WM_USER + 58;
  TTM_GETCURRENTTOOLW = WM_USER + 59;
  TTM_WINDOWFROMPOINT = WM_USER + 16;
  TTM_TRACKACTIVATE   = WM_USER + 17;
  TTM_TRACKPOSITION   = WM_USER + 18;
  TTM_SETTIPBKCOLOR   = WM_USER + 19;
  TTM_SETTIPTEXTCOLOR = WM_USER + 20;
  TTM_GETDELAYTIME    = WM_USER + 21;
  TTM_GETTIPBKCOLOR   = WM_USER + 22;
  TTM_GETTIPTEXTCOLOR = WM_USER + 23;
  TTM_SETMAXTIPWIDTH  = WM_USER + 24;
  TTM_GETMAXTIPWIDTH  = WM_USER + 25;
  TTM_SETMARGIN       = WM_USER + 26;
  TTM_GETMARGIN       = WM_USER + 27;
  TTM_POP             = WM_USER + 28;
  TTM_UPDATE          = WM_USER + 29;
  { For IE >= 0X0500 }
  TTM_GETBUBBLESIZE   = WM_USER + 30;
  TTM_ADJUSTRECT      = WM_USER + 31;
  TTM_SETTITLEA       = WM_USER + 32;
  TTM_SETTITLEW       = WM_USER + 33;
  { For Windows >= XP }
  TTM_POPUP           = WM_USER + 34;
  TTM_GETTITLE        = WM_USER + 35;

  TTM_ADDTOOL        = {$IFDEF UNICODE}TTM_ADDTOOLW{$ELSE}TTM_ADDTOOLA{$ENDIF};
  TTM_DELTOOL        = {$IFDEF UNICODE}TTM_DELTOOLW{$ELSE}TTM_DELTOOLA{$ENDIF};
  TTM_NEWTOOLRECT    = {$IFDEF UNICODE}TTM_NEWTOOLRECTW{$ELSE}TTM_NEWTOOLRECTA{$ENDIF};
  TTM_GETTOOLINFO    = {$IFDEF UNICODE}TTM_GETTOOLINFOW{$ELSE}TTM_GETTOOLINFOA{$ENDIF};
  TTM_SETTOOLINFO    = {$IFDEF UNICODE}TTM_SETTOOLINFOW{$ELSE}TTM_SETTOOLINFOA{$ENDIF};
  TTM_HITTEST        = {$IFDEF UNICODE}TTM_HITTESTW{$ELSE}TTM_HITTESTA{$ENDIF};
  TTM_GETTEXT        = {$IFDEF UNICODE}TTM_GETTEXTW{$ELSE}TTM_GETTEXTA{$ENDIF};
  TTM_UPDATETIPTEXT  = {$IFDEF UNICODE}TTM_UPDATETIPTEXTW{$ELSE}TTM_UPDATETIPTEXTA{$ENDIF};
  TTM_ENUMTOOLS      = {$IFDEF UNICODE}TTM_ENUMTOOLSW{$ELSE}TTM_ENUMTOOLSA{$ENDIF};
  TTM_GETCURRENTTOOL = {$IFDEF UNICODE}TTM_GETCURRENTTOOLW{$ELSE}TTM_GETCURRENTTOOLA{$ENDIF};
  { For IE >= 0X0500 }
  TTM_SETTITLE       = TTM_SETTITLEW;
  { For Windows >= XP }
//  TTM_SETWINDOWTHEME = CCM_SETWINDOWTHEME;
  TTM_RELAYEVENT     = WM_USER + 7;
  TTM_GETTOOLCOUNT   = WM_USER + 13;

  TTN_FIRST = 0 - 520;
  TTN_LAST  = 0 - 549;

  TTN_NEEDTEXTA = TTN_FIRST - 0;
  TTN_NEEDTEXTW = TTN_FIRST - 10;
  TTN_NEEDTEXT  = {$IFDEF UNICODE}TTN_NEEDTEXTW{$ELSE}TTN_NEEDTEXTA{$ENDIF};
  TTN_SHOW      = TTN_FIRST - 1;
  TTN_POP       = TTN_FIRST - 2;
  TTN_LINKCLICK = TTN_FIRST - 3;

procedure TfrmMain.ReportTreeWndProc(var Message: TMessage);
var
  MaxWidth: Integer;
begin
  if Message.Msg = WM_NOTIFY then
  begin
    with TWMNotify(Message).Nmhdr^ do
    begin
      if code = TTN_NEEDTEXTW then
      begin
        MaxWidth := SendMessage(hwndFrom, TTM_GETMAXTIPWIDTH, 0, 0);
        if MaxWidth = -1 then
          SendMessage(hwndFrom, TTM_SETMAXTIPWIDTH, 100, 0);
      end;
    end;
  end;

  DefReportTreeWndProc(Message);
end;

procedure TfrmMain.acnChgLanguageExecute(Sender: TObject);
var
  nol: integer;
begin
  nol := dmFR.siLangDispatcher1.NumOfLanguages;
  if dmFR.siLangDispatcher1.ActiveLanguage = nol then
    dmFR.siLangDispatcher1.ActiveLanguage := 1
  else
    dmFR.siLangDispatcher1.ActiveLanguage :=
      dmFR.siLangDispatcher1.ActiveLanguage + 1;
  if Sender is TAction then
     TAction(sender).Caption := dmFR.siLangDispatcher1.Language;
  BuildTree;
end;

procedure TfrmMain.acnCloseExecute(Sender: TObject);
begin
  close;
end;

procedure TfrmMain.acnDesignExecute(Sender: TObject);
var
  report: TCMMReportData;
  Node: TTreeNode;
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
    if MessageDlg(siLangLinked_frmMain.GetTextOrDefault(
       siLangLinked_frmMain.GetTextOrDefault('IDS_0' (* 'You are going to create a new template without any specified report' *) ) ),
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      frxReport1.DataSet := nil;
      frxReport1.DesignReport;
    end;
  end;
end;

procedure TfrmMain.acnEditExecute(Sender: TObject);
var
  Node: TTreeNode;
  subItem: TTreeNode;
begin
  if not Assigned(FReportData) then
  begin
    MessageDlg(siLangLinked_frmMain.GetTextOrDefault('IDS_4' (* 'Please select a report!' *) ), mtInformation, [mbOK], 0);
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

procedure TfrmMain.acnNewExecute(Sender: TObject);
var
  Node: TTreeNode;
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

procedure TfrmMain.acnPDFExecute(Sender: TObject);
begin
  reportController.RunReport(prepareForOutput, FParams, frFile);
end;

procedure TfrmMain.acnPreviewExecute(Sender: TObject);
begin
  reportController.RunReport(prepareForOutput, FParams, frPreview);
end;

procedure TfrmMain.acnPrintExecute(Sender: TObject);
begin
  reportController.RunReport(prepareForOutput, FParams, frPrint);
end;

procedure TfrmMain.acnRemoveExecute(Sender: TObject);
var
  report: TCMMReportData;
  Node: TTreeNode;
  templateFile: string;
begin
  report := ReportTree.Selected.Data;
  if report <> nil then
  begin
    if MessageDlg(siLangLinked_frmMain.GetTextOrDefault('IDS_5' (* 'You are going to remove the report: ' *) ) +
      report.Template, mtWarning, [mbOK, mbCancel], 0) = mrOK then
    begin
      if reportController.DeleteReport(report.ReportNo) then
        ReportTree.Selected.Delete;
      ReportTree.Refresh;
    end;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  // Make treeview enable multiple lined hint
  DefReportTreeWndProc := ReportTree.WindowProc;
  ReportTree.WindowProc := ReportTreeWndProc;

  // Initialization
  Memo1.Clear;
  FReportData := nil;
  FErrors := TStringList.create;
  acnChgLanguage.Caption := dmFR.siLangDispatcher1.Language;
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
  Node: TTreeNode;
  RepNo: integer;
begin
  Node := ReportTree.Selected;
  if (Node.Data <> nil) then
  begin
    report := Node.Data;
    RepNo := report.ReportNo;
    if RepNo > 0 then
    begin
      getParameters;
      if Assigned(FParams) then
        Result := RepNo
      else
        Result := -1;
      { FParams := TCMParams.create;
        FParams.Add('@INVOICENO', 29366); }
    end;
  end;
end;

procedure TfrmMain.ReportTreeClick(Sender: TObject);
var
  Node: TTreeNode;
  Descr: string;
begin
  Node := ReportTree.Selected;
  if (Node.Data <> nil) then
  begin
    report := Node.Data;
    freeUpDBComponents;
    Memo1.Clear;
    Descr := TCMMReportData(Node.Data).description;
    if Descr <> '' then
      Memo1.Lines.Add(Descr);
  end;
end;

procedure TfrmMain.ReportTreeHint(Sender: TObject; const Node: TTreeNode;
  var Hint: string);
var
  rd: TCMMReportData;
  errMsg: string;
begin
  Hint := '';
  rd := TCMMReportData(Node.Data);
  if Assigned(rd) then
  begin
    hint := 'ReportNo: ' + intToStr(rd.ReportNo);
    FErrors.Clear;
    validateReportData(rd, FErrors);
    for errMsg in FErrors do
      Hint := Hint + sLineBreak + errMsg;
  end;
end;

function TfrmMain.validateReportData(aReportData: TCMMReportData;
  errors: TStringList): boolean;
begin
  if aReportData.datasetUserName = '' then
    errors.AddObject(siLangLinked_frmMain.GetTextOrDefault('IDS_1' (* 'Dataset is missing' *) ), TErrorCode.create(1));
  if aReportData.storedProcName = '' then
    errors.AddObject(siLangLinked_frmMain.GetTextOrDefault('IDS_2' (* 'Stored procedure is missing' *) ), TErrorCode.create(2));
  Result := (errors.Count > 0);
end;

procedure TfrmMain.BuildTree;
var
  Node: TTreeNode;
  subItem: TTreeNode;
  qry: TFDQuery;
  sp_name: string;
  DsU_name: string;
  RepNo: integer;
  errMsg: String;
  Descr: string;
  Template: string;
  docType, LastDocType: integer;
  subItmIndx: integer;
  Reportsdata: TCMMReportsdata;
  Reportdata: TCMMReportData;

begin
  ReportTree.Items.Clear;
  Node := ReportTree.Items.Add(nil,
    siLangLinked_frmMain.GetTextOrDefault('IDS_3' (* 'Available Reports...' *) ) );
  Node.ImageIndex := 0;
  try
    Reportsdata := reportController.AllReports;
  except
    on E: ETCMStoredProcNameMissing do
  end;
  LastDocType := -1; // To identify First record in the loop
  for Reportdata in Reportsdata do
  begin
    if Reportdata.storedProcName = '' then
      subItmIndx := 2
    else
      subItmIndx := 1;
    docType := Reportdata.docType;
    Template := Reportdata.Template;
    if LastDocType <> docType then
    begin
      Node := ReportTree.Items.AddChildObject(ReportTree.Selected,
        intToStr(docType), nil);
      LastDocType := docType;
    end;
    subItem := ReportTree.Items.AddChildObject(Node, Template, Reportdata);

    subItem.ImageIndex := subItmIndx;
    subItem.SelectedIndex := subItmIndx;
    FErrors.Clear;
    if validateReportData(Reportdata, FErrors) then
    begin
      subItmIndx := 2;
    end;
  end;
  Node.Free;
end;


{ TErrorCode }

constructor TErrorCode.create(aErrorCode: integer);
begin
  FErrorCode := aErrorCode;
end;

end.
