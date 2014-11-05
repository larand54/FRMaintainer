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

    procedure Preview;
    procedure Print;
    procedure ReportOnFile;

    function setUpFastReport: TfrxReport;
    procedure addParams(var aSP: TFDStoredProc; aParams: TCMParams);
    function RemoveDBObject(proc: String): string;
    function getReportNo: integer;
    function GetReportData(ReportNo: integer): TCMMReportData;
    function getParamsInfo(spName: string): TCMParamsInfo;
    procedure createDBComponents(var aSP: TFDStoredProc;
      var aDS: TfrxDBDataset; anameSuffix: string; aSp_Name, aDs_Name: string;
      aParams: TCMParams);

    { FetchReportData fetches data from database about actual report and builds
      an object of type TReportData containing fetched data
    }
    function FetchReportData(aRepNo: integer): TCMMReportData;

    { SetupReport and SetUpSubReports builds Datasets and Stored procedures,
      of the mainreport and its subreports used by the frxReport object.
      It also add parameters to the stored procedures.
    }
    procedure setupReport(var aReportData: TCMMReportData;
      aParams: TCMParams);

    function setUpSubReports(var aReportData: TCMMReportData;
      aParams: TCMParams): TCMSubReports;

    { }
  public
    constructor create;
    procedure RunReport(aReportData: TCMMReportData; aMedia: TCMMediaType)
      overload;
    procedure RunReport(aReportNo: integer; aParams: TCMParams;
      aMedia: TCMMediaType)overload;

    function NewReport(aTemplate: string;
      aDocType: string; aStoredProcName: string; aDatasetName: string;
      aDescription: string)
      : TCMMReportData;

    procedure AddSubreport(aReportNo: integer; aSubReportName: string;
      aStoreProcName: string; aDatasetName: string);
    procedure DeleteReport(aReportNo: integer);

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

uses vcl.dialogs, ufrmMain;

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

procedure TCMReportController.AddSubreport(aReportNo: integer;
  aSubReportName, aStoreProcName, aDatasetName: string);
begin

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
      SubRepDataList := TList<TCMSReportData>.create;
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
            if SubRepDataList <> nil then

              ReportData.subReportsData := SubRepDataList;
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
  Result := getReportDataFromDB(false);
end;

function TCMReportController.setUpSubReports(var aReportData
  : TCMMReportData; aParams: TCMParams): TCMSubReports;
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

procedure TCMReportController.DeleteReport(aReportNo: integer);
begin

end;

function TCMReportController.FetchReportData(aRepNo: integer)
  : TCMMReportData;
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
      // RepNo := qry['ReportNo'];
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
  ParamsInfo := nil;
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

function TCMReportController.GetReportData(ReportNo: integer)
  : TCMMReportData;
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

function TCMReportController.NewReport(aTemplate: string;
  aDocType: string; aStoredProcName, aDatasetName: string;
  aDescription: string)
  : TCMMReportData;
var
  DocType, RepNo : integer;
  RepData: TCMMReportData;
  parInf: TCMParamsInfo;
begin
  try
  Result := nil;
  RepNo := dmFR.getNextAvalableReportNumber;
  DocType := strToInt(aDoctype);
  RepData := TCMMReportData.create(RepNo, aDatasetName, aStoredProcName,
                                   aDescription, aTemplate, DocType, parInf);
  Result := RepData;
  except on E: EConvertError do
    MessageDlg('Datatype is not numeric!',mtError, [mbOK],0);
  on E: Exception do
    MessageDlg('Could not create report!\n Cause: '+E.Message, mtError, [mbOK],0);
  end;
end;

procedure TCMReportController.prepareReport(var aReportData
  : TCMMReportData; aParams: TCMParams);
begin
  FreeAndNil(FStoredProc);
  FreeAndNil(FDataset);
  setupReport(aReportData, aParams);
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
  Result := proc.Substring(i + 1, proc.Length - i - 1);
end;

procedure TCMReportController.ReportOnFile;
begin

end;

procedure TCMReportController.RunReport(aReportData: TCMMReportData;
  aMedia: TCMMediaType);
begin
  frxReport := setUpFastReport;
  frxReport.showReport;
end;

procedure TCMReportController.RunReport(aReportNo: integer;
  aParams: TCMParams; aMedia: TCMMediaType);
begin
try
  if (aReportNo > -1) then
  begin
    FReportData := FetchReportData(aReportNo);
    if FReportData <> nil then
    begin
      prepareReport(FReportData, aParams);
      frxReport := setUpFastReport;
      if aMedia = frPrint then begin
        frxReport.PrepareReport;
        frxReport.Print
      end
      else if aMedia = frPreview then
        frxReport.showReport
      else if aMedia = frFile then begin
        frxReport.PrepareReport;
        frxReport.Export(dmFR.frxPDFExport1);
      end;
    end
    else
      raise ETCMReportNotFound.Create('Requested report number: '+intToStr(aReportNo)+' was not found in the database!');
  end;
finally
  FreeAndNil(FReportData);
  FreeAndNil(FStoredProc);
  FreeAndNil(FDataset);
end;
end;

function TCMReportController.setUpFastReport: TfrxReport;
begin
  FreeAndNil(frxReport);
  frxReport := TfrxReport.create(frmMain);
  frxReport.LoadFromFile(FTemplatePath + ReportData.Template);
  frxReport.DataSet :=nil;
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
