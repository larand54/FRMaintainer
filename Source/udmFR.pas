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
    qryParam: TFDQuery;
    qryParamSR: TFDQuery;
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmFR: TdmFR;

implementation

{$R *.dfm}

end.
