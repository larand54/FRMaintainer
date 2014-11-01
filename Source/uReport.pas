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

  // Subreport(s)
  TCMSReportData = class; // Forward declaration
  TCMSReportsData = TList<TCMSReportData>;

  // Mainreport(s)
  TCMMReportData = class; // Forward declaration
  TCMMReportsData = TList<TCMMReportData>;

  TCMParam = class
    pair: TPair<string, variant>;
  end;

  // TODO!! Test this what happends if it exists same Parametername in two different subreports or mainreport.
  // An exception is likely - we want to know, in such case, what exception is thrown so that we can ignore that exception.

  TCMParams = TDictionary<string, variant>;

  TCMParamInfo = TPair<string, string>;

  TCMParamsInfo = TDictionary<string, string>;


  TCMReportData = class
  private
    FReportNo: integer;
    FdatasetUserName: string;
    FstoredProcName: string;
    Fname: string;
    Fdescription: string;
    FparamsInfo: TCMParamsInfo;
    FParams: TCMParams;
    FSubreportsData: TCMSReportsData;
  public
    constructor Create(aReportNo: integer; aDatasetName: string;
      aStoredProcName: string; aDescription: string; aname: string;
      aParamsInfo: TCMParamsInfo);
    property ReportNo: integer read FReportNo write FReportNo;
    property datasetUserName: string read FdatasetUserName
      write FDatasetUserName;
    property storedProcName: string read FStoredProcName
      write FStoredProcName;
    property name: string read Fname write Fname;
    property description: string read Fdescription write Fdescription;
    property paramsInfo: TCMParamsInfo read FparamsInfo write FParamsInfo;
    property params: TCMParams read Fparams write FParams;
    property subReportsData: TCMSReportsData read FSubreportsData write FSubreportsData;
  end;

  TCMSReportData = class(TCMReportData)
  end;

  TCMMReportData = class(TCMReportData)
  private
    FTemplate: string;
    FdocType: integer;
  public
    constructor Create(aReportNo: integer; aDatasetName: string;
      aStoredProcName: string; aDescription: string; aTemplate: string;
      adocType: integer; aParamsInfo: TCMParamsInfo);
    function getAllParameters: TCMParamsInfo;
    property Template: string read FTemplate write FTemplate;
    property docType: integer read FdocType write FdocType;
  end;

implementation

uses udmFR;

function TCMMReportData.getAllParameters: TCMParamsInfo;
var
  allPar, MainPar: TCMParamsInfo;
  SRName, parName, keys: string;
  i: integer;
begin
  { Gather all parameters from mainreport and all subreports in
    this report }
  allPar := TCMParamsInfo.Create();

  if FparamsInfo <> nil then
  begin
    for parName in FparamsInfo.keys do
    begin
      allPar.add(parName, FparamsInfo.Items[parName]);
    end;
  end;
  if FSubreportsData <> nil then
  begin
    for i := 0 to FSubReportsData.Count-1 do
    begin
      with FSubreportsData[i] do
      begin
        if FparamsInfo <> nil then
        begin
          for parName in FparamsInfo.keys do
          begin
            allPar.add(parName, FparamsInfo.Items[parName]);
          end;
        end;
      end;
    end;

  end;
  result := AllPar;
end;




constructor TCMReportData.Create(aReportNo: integer;
  aDatasetName, aStoredProcName, aDescription, aname: string;
  aParamsInfo: TCMParamsInfo);
begin
  FReportNo := aReportNo;
  FdatasetUserName := aDatasetName;
  FstoredProcName := aStoredProcName;
  Fdescription := aDescription;
  Fname := aname;
  FparamsInfo := aParamsInfo;
end;




constructor TCMMReportData.Create(aReportNo: integer;
  aDatasetName, aStoredProcName, aDescription, aTemplate: string;
  adocType: integer; aParamsInfo: TCMParamsInfo);
begin
  inherited Create(aReportNo, aDatasetName, aStoredProcName, aDescription, '',
    aParamsInfo);
  FdocType := adocType;
  FTemplate := aTemplate;
end;


end.
