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
  private
    { Private declarations }
  public
    { Public declarations }
    function updateRecord(aTable: string; aRepNo: integer; name: string): boolean;
    function getNextAvalableReportNumber: integer;
    function reportExist(aRepno:integer): boolean;
    function subReportExist(aRepno: integer; aName: string): boolean;
    function deleteAllSubReports(aRepno: integer): boolean;
    function deleteSubReport(aRepno: integer; aName: string): boolean;
    function deleteReport(aRepno: integer): boolean;
    function upDateReport(aRepno: integer; aReportData: TCMMReportData): boolean;
    function upDateSubReport(aRepno: integer; aName: string; aReportData: TCMSReportData): boolean;
    function addReport(aRepno: integer; aReportData: TCMMReportData): boolean;
    function addSubReport(aRepno: integer; aSubReportData: TCMSReportData): boolean;
    function addallSubReports(aRepno: integer; aSubReportsData: TCMSReportsData): boolean;
  end;

var
  dmFR: TdmFR;

implementation

{$R *.dfm}

{ TdmFR }

function TdmFR.addallSubReports(aRepno: integer;
  aSubReportsData: TCMSReportsData): boolean;
begin

end;

function TdmFR.addReport(aRepno: integer; aReportData: TCMMReportData): boolean;
begin
  qryInsertFastReport.Active := false;
  qryInsertFastReport.Prepare;
  qryInsertFastReport.ParamByName('')
end;

function TdmFR.addSubReport(aRepno: integer;
  aSubReportData: TCMSReportData): boolean;
begin

end;

function TdmFR.deleteAllSubReports(aRepno: integer): boolean;
begin

end;

function TdmFR.deleteReport(aRepno: integer): boolean;
begin

end;

function TdmFR.deleteSubReport(aRepno: integer; aName: string): boolean;
begin

end;

function TdmFR.getNextAvalableReportNumber: integer;
var
  error : integer;
  RepNo : integer;
begin
  try
   spGetNextReportNumber.ExecProc;
   error := spGetNextReportNumber.Params[0].AsInteger;
   if error <> 0 then
      Result := -1
   else
   result := spGetNextReportNumber.ParamByName('@MaxNo').AsInteger;
  finally
    spGetNextReportNumber.Active := false;
  end;
end;

function TdmFR.reportExist(aRepno: integer): boolean;
begin
try
  qryFastReport.active := false;
  qryFastReport.Prepare;
  qryFastReport.ParamByName('REPNO').AsInteger := aRepno;
  qryFastReport.Active := true;
finally
  result := (qryFastReport.RecordCount > 0);
  qryFastReport.Active := false;
end;
end;

function TdmFR.subReportExist(aRepno: integer; aName: string): boolean;
begin
try
  qrySubReport.active := false;
  qrySubReport.Prepare;
  qrySubReport.ParamByName('REPNO').AsInteger := aRepno;
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
{SqlConnection conn = new SqlConnection("...");
SqlCommand cmd = new SqlCommand(@"IF EXISTS(SELECT 0 FROM SomeTable
WHERE ID = 0) BEGIN UPDATE SomeTable SET ID = ID + 1 END
ELSE BEGIN INSERT INTO SomeTable(ID) VALUES(0) END", conn);
conn.Open();
cmd.ExecuteNonQuery();
conn.Close();}
end;

function TdmFR.upDateReport(aRepno: integer; aReportData: TCMMReportData): boolean;
begin

end;

function TdmFR.upDateSubReport(aRepno: integer; aName: string; aReportData: TCMSReportData): boolean;
begin

end;

end.
