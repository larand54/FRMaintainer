unit uReport;

interface
uses System.Generics.Collections;

type
  TCMMSubReport = class;

  TCMParam = class
    pair: TPair<string, variant>;
  end;

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

  TCMMReport = class
  private
    FReportNo: integer;
    FdatasetUserName: String;
    FstoredProc: string;
    Fname: string;
    Fdescription: string;
    Fparams: TCMParams;
    FparamsInfo: TCMParamsInfo;
    FSubreports: TDictionary<string, TCMMSubReport>;
    procedure SetdatasetUserName(val: String);
    procedure SetstoredProc(val: string);
    procedure Setname(val: string);
    procedure Setdescription(val: string);
    procedure SetParams(val: TCMParams);
    procedure SetparamsInfo(val: TCMParamsInfo);
    procedure SetSubreports(val: TDictionary<string, TCMMSubReport>);
  public
    property datasetUserName: String read FdatasetUserName
      write SetdatasetUserName;
    property storedProc: string read FstoredProc write SetstoredProc;
    property name: string read Fname write Setname;
    property description: string read Fdescription write Setdescription;
    property params: TCMParams read Fparams write SetParams;
    procedure addParam(aKey: string; aValue: variant);
    property paramsInfo: TCMParamsInfo read FparamsInfo write SetparamsInfo;
    function GetParamType(paramName: string): string;
    constructor Create(aReportNo: integer; aStoredProc: string;
      aDatasetUserName: string; aDescription: string);
    procedure addParamInfo(aParamInfo: TCMParamInfo);
    property Subreports: TDictionary<string, TCMMSubReport> read FSubreports
      write SetSubreports;
  end;

  TCMMMReport = class(TCMMReport)
  private
    FTemplate: string;
    FdocType: integer;
    procedure SetTemplate(val: string);
    procedure SetdocType(val: integer);
  public
    constructor Create(aTemplate: string; aReportNo: integer; adocType: integer;
          aStoredProc: string; aDatasetUserName: string; aDescription: string);
    property Template: string read FTemplate write SetTemplate;
    property docType: integer read FdocType write SetdocType;
  end;

  TCMMSubReport = class(TCMMReport)
  public
    /// <clientCardinality>0..*</clientCardinality>
    /// <supplierCardinality>1</supplierCardinality>
    Mainreport: TCMMMReport;
    constructor Create(aReportNo: integer; name: string; aStoredProc: string;
      aDatasetUserName: string; aDescription: string);
  end;

implementation

procedure TCMMReport.SetdatasetUserName(val: String);
begin
  FdatasetUserName := val;
end;

procedure TCMMReport.SetstoredProc(val: string);
begin
  FStoredProc := val;
end;

procedure TCMMReport.SetSubreports(val: TDictionary<string, TCMMSubReport>);
begin
  FSubReports := val;
end;

procedure TCMMReport.Setname(val: string);
begin
  FName := val;
end;

procedure TCMMReport.Setdescription(val: string);
begin
  FDescription := val;
end;

procedure TCMMReport.SetParams(val: TCMParams);
begin
  FParams := val
end;

procedure TCMMReport.addParam(aKey: string; aValue: variant);
begin
  params.add(aKey, aValue);
end;

procedure TCMMReport.SetparamsInfo(val: TCMParamsInfo);
begin
end;

function TCMMReport.GetParamType(paramName: string): string;
begin
  Result := ParamsInfo.GetParamType(paramName);
end;

function TCMParamsInfo.GetParamType(paramName: string): string;
begin
  result := Items[paramName];
end;

constructor TCMMMReport.Create(aTemplate: string; aReportNo: integer; adocType: integer; aStoredProc: string; aDatasetUserName: string; aDescription: string);
begin
  FTemplate := aTemplate;
  FDocType := adocType;
  inherited Create(aReportNo, aStoredProc, aDatasetUserName, aDescription);
end;

procedure TCMMReport.addParamInfo(aParamInfo: TCMParamInfo);
begin

end;

constructor TCMMReport.Create(aReportNo: integer; aStoredProc: string; aDatasetUserName: string; aDescription: string);
begin
  inherited Create;
  FStoredProc := aStoredProc;
  FDatasetUserName := aDatasetUserName;
  FDescription := aDescription;
end;

procedure TCMMMReport.SetdocType(val: integer);
begin
  FdocType := val;
end;

procedure TCMMMReport.SetTemplate(val: string);
begin
  FTemplate := val;
end;

procedure TCMParams.add(aKey: string; aValue: variant);
begin
  inherited add(aKey, aValue);
end;

constructor TCMMSubReport.Create(aReportNo: integer; name: string;
  aStoredProc: string; aDatasetUserName: string; aDescription: string);
begin
  inherited Create(aReportNo, aStoredProc, aDatasetUserName, aDescription);
end;

end.
