unit udmFR;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.MSSQL,
  Data.DB, FireDAC.Comp.Client, FireDAC.Comp.DataSet, frxClass, frxExportPDF,
  uReport;

type
  TdmFR = class(TDataModule)
    tblDBProps: TFDTable;
    FDConnection1: TFDConnection;
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
  private
    { Private declarations }
  public
    { Public declarations }
    function updateRecord(aTable: string; aRepNo: integer;
      name: string): boolean;
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
    qryInsertFastReport.Active := false;
    qryInsertFastReport.Prepare;
    qryInsertFastReport.ParamByName('REPNO').AsInteger := aRepNo;
    qryInsertFastReport.ParamByName('DOCTYPE').AsInteger := aReportData.docType;
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
    ON E: EDatabaseError do
      MessageDlg('Could not add report to database!  --- Cause:' + sLineBreak +
        E.Message, mtError, [mbOK], 0);
  end;
  if assigned(aReportData.subReportsData) then
    for subRepData in aReportData.subReportsData do
      addSubReport(aRepNo, subRepData);
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
    result := true;

  except
    ON E: EDatabaseError do
    begin
      result := false;
      MessageDlg('Could not add subreport to database!  --- Cause:' + sLineBreak
        + E.Message, mtError, [mbOK], 0);
    end;

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

function TdmFR.getNextAvalableReportNumber: integer;
var
  Error: integer;
  RepNo: integer;
begin
  try
    spGetNextReportNumber.ExecProc;
    Error := spGetNextReportNumber.Params[0].AsInteger;
    if Error <> 0 then
      result := -1
    else
      result := spGetNextReportNumber.ParamByName('@MaxNo').AsInteger;
  finally
    spGetNextReportNumber.Active := false;
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
    result := (qryFastReport.RecordCount > 0);
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
    result := (qrySubReport.RecordCount > 0);
    qrySubReport.Active := false;
  end;
end;

function TdmFR.updateRecord(aTable: string; aRepNo: integer;
  name: string): boolean;
begin
  { SqlConnection conn = new SqlConnection("...");
    SqlCommand cmd = new SqlCommand(@"IF EXISTS(SELECT 0 FROM SomeTable
    WHERE ID = 0) BEGIN UPDATE SomeTable SET ID = ID + 1 END
    ELSE BEGIN INSERT INTO SomeTable(ID) VALUES(0) END", conn);
    conn.Open();
    cmd.ExecuteNonQuery();
    conn.Close(); }
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
    qryUpdateFastReport.ParamByName('DOCTYPE').AsInteger := aReportData.docType;
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
    for subRepData in aReportData.subReportsData do
    begin
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
    result := true;

  except
    ON E: EDatabaseError do
    begin
      result := false;
      MessageDlg('Could not add subreport to database!  --- Cause:' + sLineBreak
        + E.Message, mtError, [mbOK], 0);
    end;

  end;

end;

end.
