unit uReport;

interface
uses System.Generics.Collections, System.SysUtils,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.MSSQL,
  Data.DB, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  frxDBset;

type
  ETCMStoredProcNameMissing = class(EDatabaseError);
  TCMSubReport = class; // Forward declaration
  TCMSubReports = TDictionary<string, TCMSubReport>;
  // List keyed by SubRep name

  TCMParam = class
    pair: TPair<string, variant>;
  end;

  //TODO!! Test this what happends if it exists same Parametername in two different subreports or mainreport.
  // An exception is likely - we want to know, in such case, what exception is thrown so that we can ignore that exception.

  TCMParams = class(TDictionary<string, variant>)
  public
    procedure add(aKey: string; aValue: variant);
  end;

  TCMParamInfo = class
    pair: TPair<string, string>;
  end;

  TCMParamsInfo = class(TDictionary<string, string>)
  public
    function GetParamType(paramName: string): string;
  end;

  TCMReport = class
  private
    FReportNo: integer;
    FdatasetUserName: String;
    FstoredProcName: string;
    Fname: string;
    Fdescription: string;
    Fparams: TCMParams;
    FSubreports: TCMSubReports;
    FparamsInfo: TCMParamsInfo;
    FDataset: TfrxDBDataset;
    FStoredProc: TFDStoredProc;
    FConnection : TFDConnection;
    procedure SetdatasetUserName(val: String);
    procedure SetstoredProcName(val: string);
    procedure Setname(val: string);
    procedure Setdescription(val: string);
    procedure SetParams(val: TCMParams);
    procedure SetparamsInfo(val: TCMParamsInfo);
    procedure SetSubreports(val: TCMSubReports);
    function createDataset: TfrxDBDataset;
    function createStoredProc: TFDStoredProc;
  public
    property ReportNo: integer read FReportNo write FReportNo;
    property datasetUserName: String read FdatasetUserName
      write SetdatasetUserName;
    property storedProcName: string read FstoredProcName write SetstoredProcName;
    property name: string read Fname write Setname;
    property description: string read Fdescription write Setdescription;
    property params: TCMParams read Fparams write SetParams;
    procedure addParam(aKey: string; aValue: variant);
    property paramsInfo: TCMParamsInfo read FparamsInfo write SetparamsInfo;
    function GetParamType(paramName: string): string;
    constructor Create(aReportNo: integer; aname: string;
                       aStoredProcName: string; aDatasetUserName: string;
                       aDescription: string; aConnection: TFDConnection);
    procedure addParamInfo(aParamInfo: TCMParamInfo);
    procedure freeUpDBComponents;
    property Subreports: TCMSubReports read FSubreports write SetSubreports;
    property DataSet: TfrxDBDataset read FDataset;
    property StoredProc: TFDStoredProc read FStoredProc;
    property Connection: TFDConnection read FConnection;
  end;

  TCMMReport = class(TCMReport)
  private
    FTemplate: string;
    FdocType: integer;
    procedure SetTemplate(val: string);
    procedure SetdocType(val: integer);
  public
    constructor Create(aTemplate: string; aReportNo: integer;
                       aname: string; adocType: integer;
                       aStoredProc: string; aDatasetUserName: string;
                       aDescription: string; aConnection: TFDConnection);
    property Template: string read FTemplate write SetTemplate;
    property docType: integer read FdocType write SetdocType;
  end;

  TCMSubReport = class(TCMReport)
  public
    constructor Create(aReportNo: integer; aname: string;
                       aStoredProcName: string;
                       aDatasetUserName: string;
                       aDescription: string;
                       aConnection: TFDConnection);
  end;

  TCMReportData = class
  private
    FReportNo: integer;
    FdatasetUserName: string;
    FstoredProcName: string;
    Fname: string;
    Fdescription: string;
    FparamsInfo: TCMParamsInfo;
    procedure SetdatasetUserName(val: string);
    procedure SetstoredProcName(val: string);
    procedure Setname(val: string);
    procedure Setdescription(val: string);
    procedure SetparamsInfo(val: TCMParamsInfo);
  public
    property ReportNo: integer read FReportNo write FReportNo;
    property datasetUserName: string read FdatasetUserName
      write SetdatasetUserName;
    property storedProcName: string read FstoredProcName
      write SetstoredProcName;
    property name: string read Fname write Setname;
    property description: string read Fdescription write Setdescription;
    property paramsInfo: TCMParamsInfo read FparamsInfo write SetparamsInfo;
  end;

  TCMSubReportData = class(TCMReportData)
  end;

  TCMMReportData = class(TCMReportData)
  private
    FTemplate: string;
    FdocType: integer;
    procedure SetTemplate(val: string);
    procedure SetdocType(val: integer);
  public
    property Template: string read FTemplate write SetTemplate;
    property docType: integer read FdocType write SetdocType;
  end;

implementation

uses udmFR;

procedure TCMReport.freeUpDBComponents;
var
  SRName: string;
  fs: TCMSubReports;
  sr: TCMSubReport;
begin
  FreeAndNil(FDataSet);
  FreeAndNil(FStoredProc);
  if FSubreports <> nil then begin
    fs := FSubreports;
    for SRName in fs.keys do begin
      sr := fs.Items[SRName];
      FreeAndNil(sr);
    end;
    FreeAndNil(fs);
  end;
end;

procedure TCMReport.SetdatasetUserName(val: String);
begin
  FdatasetUserName := val;
end;

procedure TCMReport.SetstoredProcName(val: string);
begin
  FStoredProcName := val;
end;

procedure TCMReport.SetSubreports(val: TCMSubReports);
begin
  FSubReports := val;
end;

procedure TCMReport.Setname(val: string);
begin
  FName := val;
end;

procedure TCMReport.Setdescription(val: string);
begin
  FDescription := val;
end;

procedure TCMReport.SetParams(val: TCMParams);
begin
  FParams := val
end;

procedure TCMReport.addParam(aKey: string; aValue: variant);
begin
  params.add(aKey, aValue);
end;

procedure TCMReport.SetparamsInfo(val: TCMParamsInfo);
begin
end;

function TCMReport.GetParamType(paramName: string): string;
begin
  Result := ParamsInfo.GetParamType(paramName);
end;

function TCMParamsInfo.GetParamType(paramName: string): string;
begin
  result := Items[paramName];
end;

constructor TCMMReport.Create(aTemplate: string; aReportNo: integer; aname: string; adocType: integer;
                               aStoredProc: string; aDatasetUserName: string;
                               aDescription: string; aConnection: TFDConnection);
begin
  inherited Create(aReportNo, aname, aStoredProc, aDatasetUserName, aDescription, aConnection);
  FTemplate := aTemplate;
  FDocType := adocType;
end;

procedure TCMReport.addParamInfo(aParamInfo: TCMParamInfo);
begin

end;

constructor TCMReport.Create(aReportNo: integer; aname: string; aStoredProcName: string; aDatasetUserName: string;
                              aDescription: string; aConnection: TFDConnection);
begin
  inherited Create;
  FStoredProcName := aStoredProcName;
  FDatasetUserName := aDatasetUserName;
  FDescription := aDescription;
  FReportNo := aReportNo;
  FName := aname;
  FConnection := aConnection;
  FStoredProc := createStoredProc;
  FDataset := createDataset;
end;

procedure TCMMReport.SetdocType(val: integer);
begin
  FdocType := val;
end;

procedure TCMMReport.SetTemplate(val: string);
begin
  FTemplate := val;
end;

procedure TCMParams.add(aKey: string; aValue: variant);
begin
  inherited add(aKey, aValue);
end;

constructor TCMSubReport.Create(aReportNo: integer; aname: string; aStoredProcName: string;
                                 aDatasetUserName: string;
                                 aDescription: string;
                                 aConnection: TFDConnection);
begin
  inherited Create(aReportNo, aname, aStoredProcName, aDatasetUserName, aDescription, aConnection);
  FStoredProc := createStoredProc;
  FDataset := createDataset;
end;

function TCMReport.createDataset: TfrxDBDataset;
var
  ds: TfrxDBDataset;
begin
  try
    ds := TfrxDBDataset.Create(nil);
    ds.CloseDataSource := false;
    ds.BCDToCurrency := false;
    ds.DataSet := StoredProc;
    ds.UserName := datasetUserName;
  except
    ds := nil;
  end;
  Result := ds;
end;

function TCMReport.createStoredProc: TFDStoredProc;
var
  sp: TFDStoredProc;
begin
  if StoredProcName = '' then
    raise ETCMStoredProcNameMissing.create('Name of Stored Procedure is missing - Check the database for report no: '+ intToStr(ReportNo));
  sp := TFDStoredProc.Create(nil);
  sp.Connection := Connection;
  sp.Active := false;
  sp.storedProcName := StoredProcName;
  sp.Prepare;
  Result := sp;
end;

procedure TCMReportData.SetdatasetUserName(val: string);
begin
  FdatasetUserName := val;
end;

procedure TCMReportData.SetstoredProcName(val: string);
begin
  FstoredProcName := val;
end;

procedure TCMReportData.Setname(val: string);
begin
  Fname := val;
end;

procedure TCMReportData.Setdescription(val: string);
begin
  Fdescription := val;
end;

procedure TCMReportData.SetparamsInfo(val: TCMParamsInfo);
begin
end;

procedure TCMMReportData.SetTemplate(val: string);
begin
  FTemplate := val;
end;

procedure TCMMReportData.SetdocType(val: integer);
begin
  FdocType := val;
end;

end.
