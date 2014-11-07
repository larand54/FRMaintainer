unit uReportController;

interface

uses
  System.Generics.Collections, System.Variants, System.SysUtils,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait, frxDesgn, FireDAC.Comp.UI, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,

  frxClass, frxExportRTF,
  frxRich, Vcl.ImgList, Vcl.Buttons, frxDBSet,
  uReport, udmFR;

type
  ETCMReportNotFound = class(Exception);
  TCMMediaType = (frPreview, frFile, frPrint);

  TCMSubReport = class
  private
    FStoredProc: TFDStoredProc;
    FDataset: TfrxDBDataset;
    FParams: TCMParams;
  public
    constructor create(aSP: TFDStoredProc; aDS: TfrxDBDataset);
    property StoredProc: TFDStoredProc read FStoredProc;
    property DataSet: TfrxDBDataset read FDataset;
  end;

  TCMSubReports = TDictionary<string, TCMSubReport>;

  TCMReportController = class
  private
    frxReport: TfrxReport;
    FReportData: TCMMReportData;
    FTemplatePath: string;
    FParams: TCMParams;
    FSubReports: TCMSubReports;

    FStoredProc: TFDStoredProc;
    FDataset: TfrxDBDataset;

    procedure cleanUpFromDB_components;
    function setUpFastReport: TfrxReport;
    procedure addParams(var aSP: TFDStoredProc; aParams: TCMParams);
    function RemoveDBObject(proc: String): string;
    function getReportNo: integer;
    function GetReportData(ReportNo: integer): TCMMReportData;
    function getParamsInfo(spName: string): TCMParamsInfo;
    procedure createDBComponents(var aSP: TFDStoredProc; var aDS: TfrxDBDataset;
      anameSuffix: string; aSp_Name, aDs_Name: string; aParams: TCMParams);

    { FetchReportData fetches data from database about actual report and builds
      an object of type TReportData containing fetched data
    }
    function FetchReportData(aRepNo: integer): TCMMReportData;

    { SetupReport and SetUpSubReports builds Datasets and Stored procedures,
      of the mainreport and its subreports used by the frxReport object.
      It also add parameters to the stored procedures.
    }
    procedure setupReport(var aReportData: TCMMReportData; aParams: TCMParams);

    function setUpSubReports(var aReportData: TCMMReportData;
      aParams: TCMParams): TCMSubReports;

    { }
  public
    constructor create;
    procedure RunReport(aReportData: TCMMReportData;
      aMedia: TCMMediaType)overload;
    procedure RunReport(aReportNo: integer; aParams: TCMParams;
      aMedia: TCMMediaType)overload;

    procedure DesignReport(aReportNo: integer);

    function NewReport(aTemplate: string; aDocType: string;
      aStoredProcName: string; aDatasetName: string; aDescription: string)
      : TCMMReportData;

    function UpdateReport(aRepNo: integer; aTemplate: string; aDocType: string;
      aStoredProcName: string; aDatasetName: string; aDescription: string)
      : TCMMReportData;

    function NewSubReport(aRepNo: integer; aName: string;
      aStoredProcName: string; aDatasetName: string): TCMSReportData;

    function DeleteReport(aReportNo: integer): boolean;

    function AllReports: TList<TCMMReportData>;
    procedure prepareReport(var aReportData: TCMMReportData;
      aParams: TCMParams);
    procedure initController;

    property ReportData: TCMMReportData read FReportData;
    property ReportNo: integer read getReportNo;
    property TemplatePath: string read FTemplatePath;

  end;

implementation

{ TCMReportController }

uses Vcl.dialogs, ufrmMain;

procedure TCMReportController.addParams(var aSP: TFDStoredProc;
  aParams: TCMParams);
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
  qry.ParamByName('SP_NAME').AsString := RemoveDBObject(aSP.StoredProcName);
  qry.Active := true;
  qry.First;
  while not qry.Eof do
  begin
    wantedParams.Add(qry['PARAMETER_NAME'], qry['DATA_TYPE']);
    qry.Next;
  end;
  qry.close;
  for key in wantedParams.keys do
  begin
    if aParams.ContainsKey(key) then
    begin
      aParams.TryGetValue(key, Value);
      aSP.Params.ParamByName(key).Value := Value;
    end;
  end;
end;

function TCMReportController.AllReports: TCMMReportsData;
var
  paramsInfo: TCMParamsInfo;
  ReportData: TCMMReportData;
  SubReportData: TCMSReportData;
  ReportDataList: TCMMReportsData;
  SubRepDataList: TCMSReportsData;
  RepNo: integer;

  function getReportDataFromDB(isSubreport: boolean): TCMMReportsData;
  var
    name: string;
    qry: TFDQuery;
    sp_name: string;
    DsU_name: string;
    Descr: string;
    Template: string;
    docType: integer;
  begin
    if isSubreport then
    begin
      qry := dmFR.qrySubreports;
      qry.Prepare;
      qry.ParamByName('REPNO').AsInteger := RepNo;
    end
    else
    begin
      qry := dmFR.qryFastReports;
      ReportDataList := TList<TCMMReportData>.create;
    end;
    qry.Active := true;
    qry.First;
    while not qry.Eof do
    begin
      RepNo := qry['ReportNo'];
      if (qry['DatasetUserName'] <> null) then
        DsU_name := qry['DatasetUserName']
      else
        DsU_name := '';
      if (qry['StoredProcName'] <> null) then
        sp_name := qry['StoredProcName']
      else
        sp_name := '';
      if (qry['Description'] <> null) then
        Descr := qry['Description']
      else
        Descr := '';
      try
        if isSubreport then
        begin
          if not Assigned(SubRepDataList) then
            SubRepDataList := TList<TCMSReportData>.create;

          if (qry['SubReportName'] <> null) then
            name := qry['SubReportName']
          else
            name := '';
          SubReportData := TCMSReportData.create(RepNo, DsU_name, sp_name,
            Descr, name, paramsInfo);
          if SubReportData <> nil then
            SubRepDataList.Add(SubReportData);
        end
        else
        begin
          docType := qry['DocType'];
          Template := qry['ReportName'];
          ReportData := TCMMReportData.create(RepNo, DsU_name, sp_name, Descr,
            Template, docType, paramsInfo);
          if ReportData <> nil then
          begin
            getReportDataFromDB(true);

            ReportData.subReportsData := SubRepDataList;
            SubRepDataList := nil; // Clean before next report
            ReportDataList.Add(ReportData);
          end;

        end;
      except
        on E: ETCMStoredProcNameMissing do
          FreeAndNil(ReportData);
      end;
      qry.Next;
    end;
    qry.close;
    Result := ReportDataList;
  end;

begin
  SubRepDataList := nil;
  Result := getReportDataFromDB(false);
end;

function TCMReportController.setUpSubReports(var aReportData: TCMMReportData;
  aParams: TCMParams): TCMSubReports;
var
  srs: TCMSubReports;
  sr: TCMSubReport;
  srd: TCMSReportData;
  sp: TFDStoredProc;
  sd: TfrxDBDataset;
  spName, dsName: string;

begin
  srs := TCMSubReports.create;
  with aReportData do
  begin
    for srd in subReportsData do
    begin
      spName := srd.StoredProcName;
      dsName := srd.DatasetUserName;
      createDBComponents(sp, sd, name, spName, dsName, aParams);
      srs.Add(srd.name, TCMSubReport.create(sp, sd));
    end;
  end;
  Result := srs;
end;

function TCMReportController.UpdateReport(aRepNo: integer; aTemplate, aDocType, aStoredProcName,
  aDatasetName, aDescription: string): TCMMReportData;
var
  docType: integer;
  RepData: TCMMReportData;
  parInf: TCMParamsInfo;
begin
  try
    Result := nil;
    docType := strToInt(aDocType);
    RepData := TCMMReportData.create(aRepNo, aDatasetName, aStoredProcName,
      aDescription, aTemplate, docType, parInf);
    Result := RepData;
  except
    on E: EConvertError do
      MessageDlg('Datatype is not numeric!', mtError, [mbOK], 0);
    on E: Exception do
      MessageDlg('Could not create report!  --- Cause:' + sLineBreak +
        E.Message, mtError, [mbOK], 0);
  end;
end;

function TCMReportController.DeleteReport(aReportNo: integer): boolean;
begin
  Result := false;
  try
    dmFR.DeleteReport(aReportNo);
    dmFR.deleteAllSubReports(aReportNo);
    Result := true;
  finally

  end;
end;

procedure TCMReportController.DesignReport(aReportNo: integer);
begin
  try
    if (aReportNo > -1) then
    begin
      FReportData := FetchReportData(aReportNo);
      if FReportData <> nil then
      begin
        with FReportData do
        begin
          createDBComponents(FStoredProc, FDataset, 'mainRep', StoredProcName,
            DatasetUserName, nil);
        end;
        FSubReports := setUpSubReports(FReportData, nil);
        frxReport := setUpFastReport;
        frxReport.DesignReport;
      end
      else
        raise ETCMReportNotFound.create('Requested report number: ' +
          intToStr(aReportNo) + ' was not found in the database!');
    end;
  finally
    cleanUpFromDB_components;
  end;
end;

function TCMReportController.FetchReportData(aRepNo: integer): TCMMReportData;
var
  paramsInfo: TCMParamsInfo;
  RepData: TCMMReportData;
  SubReportData: TCMSReportData;
  SubRepDataList: TCMSReportsData;
  closeThis: boolean;
  RepNo: integer;
  function getReportDataFromDB(isSubreport: boolean): TCMMReportData;
  var
    name: string;
    qry: TFDQuery;
    sp_name: string;
    DsU_name: string;
    Descr: string;
    Template: string;
    docType: integer;
  begin
    Result := nil;
    if isSubreport then
    begin
      qry := dmFR.qrySubreports;
      qry.Prepare;
      qry.ParamByName('REPNO').AsInteger := RepNo;
      SubRepDataList := TList<TCMSReportData>.create;
    end
    else
    begin
      qry := dmFR.qryFastReport;
      qry.Prepare;
      qry.ParamByName('REPNO').AsInteger := RepNo;
    end;
    qry.Active := true;
    qry.First;
    while not qry.Eof do
    begin
      if (qry['DatasetUserName'] <> null) then
        DsU_name := qry['DatasetUserName']
      else
        DsU_name := '';
      if (qry['StoredProcName'] <> null) then
        sp_name := qry['StoredProcName']
      else
        sp_name := '';
      { if (qry['Description'] <> null) then
        Descr := qry['Description']
        else
        Descr := '';
      }
      if isSubreport then
      begin
        if (qry['SubReportName'] <> null) then
          name := qry['SubReportName']
        else
          name := '';
        SubReportData := TCMSReportData.create(RepNo, DsU_name, sp_name, Descr,
          name, paramsInfo);
        if SubReportData <> nil then
          SubRepDataList.Add(SubReportData);
      end
      else
      begin
        // docType := qry['DocType'];
        Template := qry['ReportName'];
        RepData := TCMMReportData.create(RepNo, DsU_name, sp_name, Descr,
          Template, 0, paramsInfo);
        if RepData <> nil then
        begin
          getReportDataFromDB(true);
          if SubRepDataList <> nil then
            RepData.subReportsData := SubRepDataList;
          Result := RepData;
          closeThis := true;
        end;

      end;
      if not closeThis then
        qry.Next
      else
      begin
        qry.close;
        exit;
      end;
    end;
    qry.close;
  end;

begin
  paramsInfo := nil;
  SubReportData := nil;
  SubRepDataList := nil;
  closeThis := false;
  RepNo := aRepNo;
  RepData := nil;
  Result := getReportDataFromDB(false);
end;

function TCMReportController.getParamsInfo(spName: string): TCMParamsInfo;
var
  qry: TFDQuery;
  Pi: TCMParamsInfo;
begin
  qry := dmFR.qryParamInfo;
  qry.Active := true;
  qry.First;
  if Pi = nil then
    Pi := TCMParamsInfo.create();
  while not qry.Eof do
  begin
    Pi.Add(qry['PARAMETER_NAME'], qry['DATA_TYPE']);
  end;
  Result := Pi;
end;

function TCMReportController.GetReportData(ReportNo: integer): TCMMReportData;
begin
  if (FReportData <> nil) and (FReportData.ReportNo = ReportNo) then
    Result := FReportData
  else
    Result := FetchReportData(ReportNo);
end;

function TCMReportController.getReportNo: integer;
begin
  Result := ReportData.ReportNo
end;

procedure TCMReportController.initController;
begin
  try
    dmFR.tblDBProps.Open;
    FTemplatePath := dmFR.tblDBProps['FastPath'];
    if (FTemplatePath[FTemplatePath.Length - 1] <> '\') then
      FTemplatePath := FTemplatePath + '\';
  finally
    dmFR.tblDBProps.close;
    dmFR.qryFastReports.close;
  end;

end;

function TCMReportController.NewReport(aTemplate: string; aDocType: string;
  aStoredProcName, aDatasetName: string; aDescription: string): TCMMReportData;
var
  RepNo: integer;
begin
    RepNo := dmFR.getNextAvalableReportNumber;
    Result := UpdateReport(RepNo,aTemplate,aDocType,aStoredProcName,aDatasetName, aDescription);
end;

function TCMReportController.NewSubReport(aRepNo: integer; aName: string;
  aStoredProcName, aDatasetName: string): TCMSReportData;
var
  parInf: TCMParamsInfo;
begin
  Result := TCMSReportData.create(aRepNo, aDatasetName, aStoredProcName, '',
    aName, parInf);
end;

procedure TCMReportController.prepareReport(var aReportData: TCMMReportData;
  aParams: TCMParams);
begin
  FreeAndNil(FStoredProc);
  FreeAndNil(FDataset);
  setupReport(aReportData, aParams);
end;

function TCMReportController.RemoveDBObject(proc: String): string;
var
  i: integer;
begin
  i := proc.IndexOf('.');
  Result := proc.Substring(i + 1, proc.Length - i - 1);
end;

procedure TCMReportController.RunReport(aReportData: TCMMReportData;
  aMedia: TCMMediaType);
begin
  try
    frxReport := setUpFastReport;
    frxReport.showReport;
  finally
    cleanUpFromDB_components;
  end;
end;

procedure TCMReportController.RunReport(aReportNo: integer; aParams: TCMParams;
  aMedia: TCMMediaType);
begin
  try
    if (aReportNo > -1) then
    begin
      FReportData := FetchReportData(aReportNo);
      if FReportData <> nil then
      begin
        prepareReport(FReportData, aParams);
        frxReport := setUpFastReport;
        if aMedia = frPrint then
        begin
          frxReport.prepareReport;
          frxReport.Print
        end
        else if aMedia = frPreview then
          frxReport.showReport
        else if aMedia = frFile then
        begin
          frxReport.prepareReport;
          frxReport.Export(dmFR.frxPDFExport1);
        end;
      end
      else
        raise ETCMReportNotFound.create('Requested report number: ' +
          intToStr(aReportNo) + ' was not found in the database!');
    end;
  finally
    cleanUpFromDB_components;
  end;
end;

function TCMReportController.setUpFastReport: TfrxReport;
begin
  FreeAndNil(frxReport);
  frxReport := TfrxReport.create(frmMain);
  frxReport.LoadFromFile(FTemplatePath + ReportData.Template);
  frxReport.DataSet := nil;
  Result := frxReport;
end;

procedure TCMReportController.setupReport(var aReportData: TCMMReportData;
  aParams: TCMParams);
begin
  with aReportData do
  begin
    createDBComponents(FStoredProc, FDataset, 'mainRep', StoredProcName,
      DatasetUserName, aParams);
  end;
  FSubReports := setUpSubReports(aReportData, aParams);
end;

procedure TCMReportController.cleanUpFromDB_components;
var
  sr: TCMSubReport;
begin
  FreeAndNil(FReportData);
  FreeAndNil(FStoredProc);
  FreeAndNil(FDataset);
  for sr in FSubReports.Values do
  begin
    FreeAndNil(sr.FStoredProc);
    FreeAndNil(sr.FDataset);
  end;
end;

constructor TCMReportController.create;
begin
  initController;
end;

procedure TCMReportController.createDBComponents(var aSP: TFDStoredProc;
  var aDS: TfrxDBDataset; anameSuffix: string; aSp_Name, aDs_Name: string;
  aParams: TCMParams);
begin
  // Create and prepare the TFDStoredProc component

  aSP := TFDStoredProc.create(nil);
  aSP.name := anameSuffix;
  aSP.Connection := dmFR.FDConnection1;
  aSP.Active := false;
  aSP.StoredProcName := aSp_Name;
  aSP.Prepare;
  if assigned(aParams) then
    addParams(aSP, aParams);
  aSP.Active := true;

  // Create and prepare the TfrxDBDataset component

  aDS := TfrxDBDataset.create(nil);
  aDS.name := 'DS' + anameSuffix;
  aDS.DataSet := aSP;
  aDS.UserName := aDs_Name;

end;

{ TCMSubReport }

constructor TCMSubReport.create(aSP: TFDStoredProc; aDS: TfrxDBDataset);
begin
  FStoredProc := aSP;
  FDataset := aDS;
end;

end.
