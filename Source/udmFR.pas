unit udmFR;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.MSSQL,
  Data.DB, FireDAC.Comp.Client, FireDAC.Comp.DataSet, frxClass, frxExportPDF;

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
  private
    { Private declarations }
  public
    { Public declarations }
    function getNextAvalableReportNumber: integer;
  end;

var
  dmFR: TdmFR;

implementation

{$R *.dfm}

{ TdmFR }

function TdmFR.getNextAvalableReportNumber: integer;
var
  error : integer;
  RepNo : integer;
begin
  try
   spGetNextReportNumber.Active := true;
   error := spGetNextReportNumber.Params[0].AsInteger;
   if error <> 0 then
      Result := -1
   else
   result := spGetNextReportNumber['@MaxNo'].AsInteger;
  finally
    spGetNextReportNumber.Active := false;
  end;
end;

end.
