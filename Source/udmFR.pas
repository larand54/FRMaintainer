unit udmFR;

interface

uses
  System.Generics.Collections, System.Variants,
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.MSSQL,
  Data.DB, FireDAC.Comp.Client, FireDAC.Comp.DataSet, frxClass, frxExportPDF,
  uReport;

type
  TCMDocType = TDictionary<integer, string>;

  TdmFR = class(TDataModule)
    tblDBProps: TFDTable;
    tblDBPropsFastPath: TStringField;
    qryFastReports: TFDQuery;
    qrySubreports: TFDQuery;
    qryParamInfo: TFDQuery;
    qryParamInfoPARAMETER_NAME: TWideStringField;
    qryParamInfoDATA_TYPE: TWideStringField;
    qryFastReportsReportNo: TIntegerField;
    qryFastReportsDocType: TIntegerField;
    qryFastReportsReportName: TStringField;
    qryFastReportsStoredProcName: TStringField;
    qryFastReportsDatasetUserName: TStringField;
    qrySubreportsReportNo: TIntegerField;
    qrySubreportsSubReportName: TStringField;
    qrySubreportsStoredProcName: TStringField;
    qrySubreportsDatasetUserName: TStringField;
    qrySubreportsDescription: TStringField;
    qryFastReport: TFDQuery;
    qryFastReportsDescription: TStringField;
    frxPDFExport1: TfrxPDFExport;
    qryInsertFastReport: TFDQuery;
    spGetNextReportNumber: TFDStoredProc;
    qrySubReport: TFDQuery;
    qryUpdateFastReport: TFDQuery;
    qryInsertSubReport: TFDQuery;
    qryUpdateSubReport: TFDQuery;
    qryDeleteReport: TFDQuery;
    qryDeleteSubreport: TFDQuery;
    qryDeleteSubreports: TFDQuery;
    tblDBPropsLangPath: TStringField;
    qryDocType: TFDQuery;
    qryDocTypeid: TIntegerField;
    qryDocTypeName: TStringField;
    qryFRByName: TFDQuery;
    qryFRByNameReportNo: TIntegerField;
    sqGetDocs: TFDQuery;
    sqGetDocsNoOfCopy: TIntegerField;
    sqGetDocspromptUser: TIntegerField;
    sqGetDocscollated: TIntegerField;
    sqGetDocsPrinterSetup: TIntegerField;
    sqGetDocsReportName: TStringField;
    qryFastReportsName: TStringField;
    FDConnection1: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FLangPath: string;
    FDocType: TCMDocType;
  public
    { Public declarations }
    property DocType: TCMDocType read FDocType;
    function getNextAvalableReportNumber: integer;
    function reportExist(aRepNo: integer): boolean;
    function subReportExist(aRepNo: integer; aName: string): boolean;
    function deleteAllSubReports(aRepNo: integer): boolean;
    function deleteSubReport(aRepNo: integer; aName: string): boolean;
    function deleteReport(aRepNo: integer): boolean;
    function upDateReport(aRepNo: integer; aReportData: TCMMReportData)
      : boolean;
    function upDateSubReport(aRepNo: integer; aName: string;
      aSubReportData: TCMSReportData): boolean;
    function addReport(aRepNo: integer; aReportData: TCMMReportData): boolean;
    function addSubReport(aRepNo: integer;
      aSubReportData: TCMSReportData): boolean;
    function addallSubReports(aRepNo: integer;
      aSubReportsData: TCMSReportsData): boolean;
    function getLangPath: string;
    function getDocTypeName(aDocType: integer): string;
    function reportByName(aName: string): integer;
    function getClientDocPref(const ClientNo, RoleType, DocType: integer;
      var ReportName: string; var NoOfCopy, PromptUser, Collated,
      PrinterSetup: integer): boolean;
    function GetReportNameByDocTyp(const DocTyp: integer): String;
    function getReportDataField(aRepNo: integer; aField: string): string;
    function getSubReportsDataField(aRepNo: integer; aField: string)
      : TStringList;
  end;

var
  dmFR: TdmFR;

implementation

{$R *.dfm}

{ TdmFR }
uses Vcl.dialogs;

const
  EC_DUPLICATE_KEY = 2627;

function TdmFR.addallSubReports(aRepNo: integer;
  aSubReportsData: TCMSReportsData): boolean;
begin

end;

function TdmFR.addReport(aRepNo: integer; aReportData: TCMMReportData): boolean;
var
  subRepData: TCMSReportData;
  i: integer;
begin
  try
    try
      qryInsertFastReport.Active := false;
      qryInsertFastReport.Prepare;
      qryInsertFastReport.ParamByName('REPNO').AsInteger := aRepNo;
      qryInsertFastReport.ParamByName('DOCTYPE').AsInteger :=
        aReportData.DocType;
      qryInsertFastReport.ParamByName('DESCR').AsString :=
        aReportData.description;
      qryInsertFastReport.ParamByName('TEMPLATE').AsString :=
        aReportData.Template;
      qryInsertFastReport.ParamByName('STPROC').AsString :=
        aReportData.storedProcName;
      qryInsertFastReport.ParamByName('DATASET').AsString :=
        aReportData.datasetUserName;
      qryInsertFastReport.ExecSQL;
    except
      ON E: EDatabaseError do begin
        MessageDlg('Could not add report to database!  --- Cause:' + sLineBreak
          + E.Message, mtError, [mbOK], 0);
        Result := false;
      end;
    end;

    if assigned(aReportData.subReportsData) then
      for subRepData in aReportData.subReportsData do
        addSubReport(aRepNo, subRepData);
  finally
    Result := true;
  end;
end;

function TdmFR.addSubReport(aRepNo: integer;
  aSubReportData: TCMSReportData): boolean;
begin
  try
    qryInsertSubReport.Active := false;
    qryInsertSubReport.Prepare;
    qryInsertSubReport.ParamByName('REPNO').AsInteger := aRepNo;
    qryInsertSubReport.ParamByName('DESCR').AsString :=
      aSubReportData.description;
    qryInsertSubReport.ParamByName('SRNAME').AsString := aSubReportData.name;
    qryInsertSubReport.ParamByName('STPROC').AsString :=
      aSubReportData.storedProcName;
    qryInsertSubReport.ParamByName('DATASET').AsString :=
      aSubReportData.datasetUserName;
    qryInsertSubReport.ExecSQL;
    Result := true;

  except
    ON E: EDatabaseError do begin
      Result := false;
      MessageDlg('Could not add subreport to database!  --- Cause:' + sLineBreak
        + E.Message, mtError, [mbOK], 0);
    end;

  end;

end;

procedure TdmFR.DataModuleCreate(Sender: TObject);
begin
  try
    FDocType := TCMDocType.Create();
    qryDocType.Active := true;
    qryDocType.First;
    while not qryDocType.Eof do begin
      FDocType.Add(qryDocType['Id'], qryDocType['Name']);
      qryDocType.Next;
    end;
  finally
    qryDocType.Close
  end;
end;

function TdmFR.deleteAllSubReports(aRepNo: integer): boolean;
begin
  qryDeleteSubreports.Active := false;
  qryDeleteSubreports.Prepare;
  qryDeleteSubreports.ParamByName('REPNO').AsInteger := aRepNo;
  qryDeleteSubreports.ExecSQL;
end;

function TdmFR.deleteReport(aRepNo: integer): boolean;
begin
  qryDeleteReport.Active := false;
  qryDeleteReport.Prepare;
  qryDeleteReport.ParamByName('REPNO').AsInteger := aRepNo;
  qryDeleteReport.ExecSQL;
end;

function TdmFR.deleteSubReport(aRepNo: integer; aName: string): boolean;
begin
  qryDeleteSubreport.Active := false;
  qryDeleteSubreport.Prepare;
  qryDeleteSubreport.ParamByName('REPNO').AsInteger := aRepNo;
  qryDeleteSubreport.ParamByName('SRNAME').AsString := aName;
  qryDeleteSubreport.ExecSQL;
end;

function TdmFR.getClientDocPref(const ClientNo, RoleType, DocType: integer;
  var ReportName: string; Var NoOfCopy, PromptUser, Collated,
  PrinterSetup: integer): boolean;
begin
  sqGetDocs.ParamByName('ClientNo').AsInteger := ClientNo;
  sqGetDocs.ParamByName('RoleType').AsInteger := RoleType;
  sqGetDocs.ParamByName('DocType').AsInteger := DocType;

  sqGetDocs.Open;
  ReportName := sqGetDocsReportName.AsString;
  NoOfCopy := sqGetDocsNoOfCopy.AsInteger;
  PromptUser := sqGetDocspromptUser.AsInteger;
  Collated := sqGetDocscollated.AsInteger;
  PrinterSetup := sqGetDocsPrinterSetup.AsInteger;
  sqGetDocs.Close;
end;

function TdmFR.GetReportNameByDocTyp(const DocTyp: integer): String;
Begin
  Case DocTyp of
    100:
      Result := 'LASTORDER_VERK_NOTE_ver3.fr3';
  End;
End;

function TdmFR.getSubReportsDataField(aRepNo: integer; aField: string)
  : TStringList;
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  qrySubreports.Prepare;
  qrySubreports.ParamByName('REPNO').AsInteger := aRepNo;
  qrySubreports.Active := true;
  qrySubreports.First;
  while not qrySubreports.Eof do begin
    if (qrySubreports[aField] <> null) then begin
      sl.Add(qrySubreports[aField]);
      qrySubreports.Next;
    end

    else begin
      ShowMessage('Subrapport f�r rapport nr:' + intToStr(aRepNo) +
        ' saknar uppgift om ' + aField + '!');
      Result := nil;
    end;
  end;
end;

function TdmFR.getDocTypeName(aDocType: integer): string;
begin
  if FDocType.ContainsKey(aDocType) then
    Result := FDocType.Items[aDocType]
  else
    Result := intToStr(aDocType);
end;

function TdmFR.getLangPath: string;
begin
  Try
    if FLangPath = '' then begin
      tblDBProps.Open;
      if not tblDBProps.Eof then Begin
        FLangPath := tblDBPropsLangPath.AsString;
      End
      else
        Result := '';
    end;
  Finally
    tblDBProps.Close;
    Result := FLangPath;
  end;
  if FLangPath = '' then
    FLangPath := ExtractFilePath(ParamStr(0)) + '\';

  Result := FLangPath;
end;

function TdmFR.getNextAvalableReportNumber: integer;
var
  Error: integer;
  RepNo: integer;
begin
  try
    spGetNextReportNumber.ExecProc;
    Error := spGetNextReportNumber.Params[0].AsInteger;
    if Error <> 0 then
      Result := -1
    else
      Result := spGetNextReportNumber.ParamByName('@MaxNo').AsInteger;
  finally
    spGetNextReportNumber.Active := false;
  end;
end;

function TdmFR.getReportDataField(aRepNo: integer; aField: string): string;
begin
  qryFastReport.Prepare;
  qryFastReport.ParamByName('REPNO').AsInteger := aRepNo;
  qryFastReport.Active := true;
  qryFastReport.First;
  if qryFastReport.Eof then
    ShowMessage('Rapport nr:' + intToStr(aRepNo) + ' finns ej i databasen!')
  else if (qryFastReport[aField] <> null) then
    Result := qryFastReport[aField]
  else begin
    ShowMessage('Rapport nr:' + intToStr(aRepNo) + ' saknar uppgift om ' +
      aField + '!');
    Result := '';
  end;
end;

function TdmFR.reportByName(aName: string): integer;
begin
  try
    qryFRByName.Active := false;
    qryFRByName.Prepare;
    qryFRByName.ParamByName('NAME').AsString := aName;
    qryFRByName.Active := true;
  finally
    if qryFRByName.RecordCount = 1 then
      Result := qryFRByName['ReportNo']
    else
      Result := -1;
    qryFRByName.Active := false;
  end;
end;

function TdmFR.reportExist(aRepNo: integer): boolean;
begin
  try
    qryFastReport.Active := false;
    qryFastReport.Prepare;
    qryFastReport.ParamByName('REPNO').AsInteger := aRepNo;
    qryFastReport.Active := true;
  finally
    Result := (qryFastReport.RecordCount > 0);
    qryFastReport.Active := false;
  end;
end;

function TdmFR.subReportExist(aRepNo: integer; aName: string): boolean;
begin
  try
    qrySubReport.Active := false;
    qrySubReport.Prepare;
    qrySubReport.ParamByName('REPNO').AsInteger := aRepNo;
    qrySubReport.ParamByName('NAME').AsString := aName;
    qrySubReport.Active := true;
  finally
    Result := (qrySubReport.RecordCount > 0);
    qrySubReport.Active := false;
  end;
end;

function TdmFR.upDateReport(aRepNo: integer;
  aReportData: TCMMReportData): boolean;
var
  subRepData: TCMSReportData;
  srName: string;
begin
  try
    qryUpdateFastReport.Active := false;
    qryUpdateFastReport.Prepare;
    qryUpdateFastReport.ParamByName('REPNO').AsInteger := aRepNo;
    qryUpdateFastReport.ParamByName('DOCTYPE').AsInteger := aReportData.DocType;
    qryUpdateFastReport.ParamByName('DESCR').AsString :=
      aReportData.description;
    qryUpdateFastReport.ParamByName('TEMPLATE').AsString :=
      aReportData.Template;
    qryUpdateFastReport.ParamByName('STPROC').AsString :=
      aReportData.storedProcName;
    qryUpdateFastReport.ParamByName('DATASET').AsString :=
      aReportData.datasetUserName;
    qryUpdateFastReport.ExecSQL;
    Result := true;
  except
    ON E: EDatabaseError do
      MessageDlg('Could not update report to database!  --- Cause:' + sLineBreak
        + E.Message, mtError, [mbOK], 0);
  end;

  deleteAllSubReports(aRepNo);
  if assigned(aReportData.subReportsData) then
    for subRepData in aReportData.subReportsData do begin
      srName := subRepData.name;
      addSubReport(aRepNo, subRepData);
    end;
end;

function TdmFR.upDateSubReport(aRepNo: integer; aName: string;
  aSubReportData: TCMSReportData): boolean;
begin
  try
    qryUpdateSubReport.Active := false;
    qryUpdateSubReport.Prepare;
    qryUpdateSubReport.ParamByName('REPNO').AsInteger := aRepNo;
    qryUpdateSubReport.ParamByName('DESCR').AsString :=
      aSubReportData.description;
    qryUpdateSubReport.ParamByName('SRNAME').AsString := aSubReportData.name;
    qryUpdateSubReport.ParamByName('STPROC').AsString :=
      aSubReportData.storedProcName;
    qryUpdateSubReport.ParamByName('DATASET').AsString :=
      aSubReportData.datasetUserName;
    qryUpdateSubReport.ExecSQL;
    Result := true;

  except
    ON E: EDatabaseError do begin
      Result := false;
      MessageDlg('Could not add subreport to database!  --- Cause:' + sLineBreak
        + E.Message, mtError, [mbOK], 0);
    end;

  end;

end;

end.
