unit uReportController;

interface

uses
  System.Generics.Collections, System.Variants, System.SysUtils,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.MSSQL,
  Data.DB, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  frxClass, frxExportRTF,
  frxRich, Vcl.ImgList, Vcl.Buttons, frxDBSet,
  uReport, udmFR;

type
  TCMMediaType = (frPreview, frFile, frPrint);

  TCMReportController = class
  private
    frxReport: TfrxReport;
    procedure Preview;
    procedure Print;
    procedure ReportOnFile;
    procedure CollectParameters_ForReportData(aReportData: TCMReportData);
    function createSubReports(aReport: TCMMReport): TCMSubReports;
    function setUpFastReport: TfrxReport;
    procedure addParams(aReport: TCMReport; aParams: TCMParams);
    function RemoveDBObject(proc: String): string;
  public
    constructor create(aRepNo: integer; aParams: TCMParams; media: TCMMediaType);
    function createReport(aReportData: TCMMReportData): TCMMReport;
    procedure RunReport(aReport: TCMMReport; aMedia: TCMMediaType);
    function NewReport(aTemplate: string; aReportNo: integer; aDataType: integer;
                       aStoredProcName: string; aDatasetName: string): TCMMReportData;
    procedure AddSubreport(aReportNo: integer; aSubReportName: string;
                           aStoreProcName: string; aDatasetName: string);
  end;

implementation

{ TCMReportController }

uses ufrmMain;

procedure TCMReportController.addParams(aReport: TCMReport; aParams: TCMParams);
var
  qry: TFDQuery;
  wantedParams: TCMParamsInfo;
  wantedParam: TCMParamInfo;
  offeredParams: TCMParams;
  i: integer;
  key: string;
  Value: Variant;
begin
  wantedParams := TCMParamsInfo.create();
  offeredParams := TCMParams.create();
  qry := dmFR.qryParamInfo;
  qry.Prepare;
  qry.ParamByName('SP_NAME').AsString := RemoveDBObject(aReport.storedProcName);
  qry.Active := true;
  qry.First;
  while not qry.Eof do
  begin
    wantedParam := TCMParamInfo.create;
    wantedParam.pair.create(qry['PARAMETER_NAME'], qry['DATA_TYPE']);
    wantedParams.Add(wantedParam.pair.key, wantedParam.pair.Value);
    key := wantedParam.pair.key;
    aParams.TryGetValue(wantedParam.pair.key, Value);
    if aParams.ContainsKey(wantedParam.pair.key) then
    begin
      offeredParams.Add(key, Value);
    end;
    qry.Next;
  end;
  qry.close;
  aReport.paramsInfo := wantedParams;
  aReport.params := offeredParams;
end;

constructor TCMReportController.create(aRepNo: integer; aParams: TCMParams;
  media: TCMMediaType);
begin
  try
    FMedia := media;
    FParams := aParams;
    FReport := createReport(aRepNo, aParams);
    if FReport <> nil then
    begin
      dmFR.tblDBProps.Active := true;
      FTemplatePath := dmFR.tblDBProps['FastPath'];
      if (FTemplatePath[FTemplatePath.Length - 1] <> '\') then
        FTemplatePath := FTemplatePath + '\';
      dmFR.tblDBProps.close;
      FSubReports := createSubReports(aRepNo);
      FReport.Subreports := FSubReports;
      frxReport := setUpFastReport;
    end;
  except
    destroy;
  end;
end;

function TCMReportController.createReport(aRepNo: integer; aParams: TCMParams)
  : TCMMReport;
var
  qry: TFDQuery;
  SP_Name: string;
  DsU_name: string;
  Descr: string;
  Template: string;

begin
  try
    qry := dmFR.qryFastReport;
    qry.Prepare;
    qry.ParamByName('REPNO').AsInteger := aRepNo;
    qry.Active := true;
    qry.First;

    if (qry['DatasetUserName'] <> null) then
      DsU_name := qry['DatasetUserName']
    else
      DsU_name := '';
    if (qry['StoredProcName'] <> null) then
      SP_Name := qry['StoredProcName']
    else
      SP_Name := '';
    Template := qry['ReportName'];
    result := TCMMReport.create(Template, aRepNo, '', 0, SP_Name, DsU_name,
      Descr, dmFR.FDConnection1);
    if aParams <> nil then
      addParams(result, aParams);
    result.Subreports := createSubReports(aRepNo);
  finally
    qry.close;
  end;
end;

function TCMReportController.createSubReports(aRepNo: integer): TCMSubReports;
var
  qry: TFDQuery;
  SP_Name: string;
  DsU_name: string;
  Descr: string;
  SubR_Name: string;
  srs: TCMSubReports;
  sr: TCMSubReport;

begin
  try
    srs := TCMSubReports.create;
    qry := dmFR.qrySubreports;
    qry.Active := true;
    qry.First;
    while not qry.Eof do
    begin
      if (qry['DatasetUserName'] <> null) then
        DsU_name := qry['DatasetUserName']
      else
        DsU_name := '';
      if (qry['StoredProcName'] <> null) then
        SP_Name := qry['StoredProcName']
      else
        SP_Name := '';

      if (qry['SubReportName'] <> null) then
        SubR_Name := qry['SubReportName']
      else
        SubR_Name := '';
      sr := TCMSubReport.create(aRepNo, SubR_Name, SP_Name, DsU_name, '',
        dmFR.FDConnection1);

      srs.Add(SubR_Name, sr);
      qry.Next;
    end;
  finally
    qry.close;
    result := srs;
  end;
end;

procedure TCMReportController.Preview;
begin

end;

procedure TCMReportController.Print;
begin

end;

function TCMReportController.RemoveDBObject(proc: String): string;
var
  i: integer;
begin
  i := proc.IndexOf('.');
  result := proc.Substring(i + 1, proc.Length - i - 1);
end;

procedure TCMReportController.ReportOnFile;
begin

end;

procedure TCMReportController.RunReport(mt: TCMMediaType);
var
  i: integer;
  srArr: TArray<TPair<string, TCMSubReport>>;
  sr: TCMSubReport;
begin
  report.storedProc.Active := true;
  srArr := report.Subreports.ToArray;
  for i := 0 to report.Subreports.Count - 1 do
  begin
    sr := srArr[i].Value;
    sr.storedProc.Active := true;
  end;
  frxReport.ShowReport;
end;

function TCMReportController.setUpFastReport: TfrxReport;
begin
  freeAndNil(frxReport);
  frxReport := TfrxReport.create(frmMain);
  frxReport.LoadFromFile(FTemplatePath + report.Template);
  frxReport.DataSet := report.DataSet;
  result := frxReport;
end;

end.
