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
  TCMMediaType = (frPreview, frFile, frPrint);

  TCMSubReport = class
  private
    FStoredProc: TFDStoredProc;
    FDataset: TfrxDBDataset;
    FParams: TCMParams;
  public
    constructor create(aSP: TFDStoredProc; aDS: TfrxDBDataset);
    property StoredProc: TFDStoredProc read FStoredProc write FStoredProc;
    property DataSet: TfrxDBDataset read FDataset write FDataset;
  end;

  TCMSubReports = TDictionary<string, TCMSubReport>;

  TCMReportController = class
  private
    class var frxReport: TfrxReport;
    class var FReportData: TCMMReportData;
    class var FTemplatePath: string;
    class var FParams: TCMParams;
    class var FSubReports: TCMSubReports;

    class var FStoredProc: TFDStoredProc;
    class var FDataset: TfrxDBDataset;

    class procedure Preview;
    class procedure Print;
    class procedure ReportOnFile;

    class function setUpFastReport: TfrxReport;
    class procedure addParams(var asp: TFDStoredProc; aParams:TCMParams);
    class function RemoveDBObject(proc: String): string;
    class function getReportNo: integer; static;
    class function GetReportData(ReportNo: integer): TCMMReportData; static;
    class function getParamsInfo(spName: string): TCMParamsInfo;
    class procedure createDBComponents(var aSP: TFDStoredProc; var aDS: TfrxDBDataset;
      aSp_Name, aDs_Name: string; aParams: TCMParams);

    { FetchReportData fetches data from database about actual report and builds
      an object of type TReportData containing fetched data
    }
    class function FetchReportData(aRepNo: integer): TCMMReportData;

    { CreateReport builds an object containing Datasets, Stored procedures,
      of the mainreport and its subreports used by the frxReport object.
      It also contains parameters needed by the stored procedures.
    }
    class procedure setupReport(var aReportData: TCMMReportData; aParams: TCMParams);
    class function setUpSubReports(var aReportData: TCMMReportData;
                      aParams: TCMParams): TCMSubReports;
  public
    { }
    class procedure RunReport(aReportData: TCMMReportData;
      aMedia: TCMMediaType)overload;  static;
    class procedure RunReport(aReportNo: integer; aMedia: TCMMediaType)overload; static;

    class function NewReport(aTemplate: string; aReportNo: integer;
      aDataType: integer; aStoredProcName: string; aDatasetName: string)
      : TCMMReportData;

    class procedure AddSubreport(aReportNo: integer; aSubReportName: string;
      aStoreProcName: string; aDatasetName: string);
    class procedure DeleteReport(aReportNo: integer);

    class function AllReports: TList<TCMMReportData>;
    class procedure prepareReport(aReportData: TCMMReportData; aParams: TCMParams);
    class procedure initController;

    class property ReportData: TCMMReportData
      read FReportData;
    class property ReportNo: integer read getReportNo;

  end;

implementation

{ TCMReportController }

uses ufrmMain;

class procedure TCMReportController.addParams(var asp: TFDStoredProc; aParams:TCMParams );
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
  qry.ParamByName('SP_NAME').AsString := RemoveDBObject(asp.StoredProcName);
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
      asp.Params.ParamByName(key).value := Value;
    end;
  end;
end;

class procedure TCMReportController.AddSubreport(aReportNo: integer;
  aSubReportName, aStoreProcName, aDatasetName: string);
begin

end;

class function TCMReportController.AllReports: TCMMReportsData;
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

class function TCMReportController.setUpSubReports(var aReportData: TCMMReportData; aParams: TCMParams)
  : TCMSubReports;
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
      spName := srd.storedProcName;
      dsName := srd.DatasetUserName;
      createDBComponents(sp, sd, spName, dsName, aParams);
      srs.Add(srd.name, TCMSubReport.create(sp, sd));
    end;
  end;
  Result := srs;
end;
{ TCMSubReport }

constructor TCMSubReport.create(aSP: TFDStoredProc; aDS: TfrxDBDataset);
begin
  FStoredProc := aSP;
  FDataset := aDS;
end;

class procedure TCMReportController.DeleteReport(aReportNo: integer);
begin

end;

class function TCMReportController.FetchReportData(aRepNo: integer): TCMMReportData;
var
  paramsInfo: TCMParamsInfo;
  ReportData: TCMMReportData;
  SubReportData: TCMSReportData;
  SubRepDataList: TCMSReportsData;
  closeThis : boolean;
function getReportDataFromDB(isSubreport: boolean): TCMMReportData;
 var
    name: string;
    qry: TFDQuery;
    sp_name: string;
    DsU_name: string;
    RepNo: integer;
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
      qry.prepare;
      qry.ParamByName('REPNO').AsInteger := RepNo;
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
            name := qry['Name']
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
            result := ReportData;
            closeThis := true;
          end;

        end;
      except
        on E: ETCMStoredProcNameMissing do
          FreeAndNil(ReportData);
      end;
      if not closeThis then  qry.Next
      else begin
        qry.close;
        exit;
      end;
    end;
    qry.close;
  end;

begin
  closeThis := false;
  Result := getReportDataFromDB(false);
end;

class function TCMReportController.getParamsInfo(spName: string): TCMParamsInfo;
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

class function TCMReportController.GetReportData(ReportNo: integer): TCMMReportData;
begin
  if (FReportData <> nil) and (FReportData.ReportNo = ReportNo) then
    Result := FReportData
  else
    Result := FetchReportData(ReportNo);
end;

class function TCMReportController.getReportNo: integer;
begin
  Result := ReportData.ReportNo
end;

class procedure TCMReportController.initController;
begin
  dmFR.tblDBProps.Active := true;
  FTemplatePath := dmFR.tblDBProps['FastPath'];
  if (FTemplatePath[FTemplatePath.Length - 1] <> '\') then
    FTemplatePath := FTemplatePath + '\';
  dmFR.tblDBProps.close;
end;

class function TCMReportController.NewReport(aTemplate: string;
  aReportNo, aDataType: integer; aStoredProcName, aDatasetName: string)
  : TCMMReportData;
begin

end;

class procedure TCMReportController.prepareReport( aReportData: TCMMReportData; aParams: TCMParams);
begin
  FReportData := aReportData;
  setupReport(aReportData, aParams);
end;

class procedure TCMReportController.Preview;
begin

end;

class procedure TCMReportController.Print;
begin

end;

class function TCMReportController.RemoveDBObject(proc: String): string;
var
  i: integer;
begin
  i := proc.IndexOf('.');
  Result := proc.Substring(i + 1, proc.Length - i - 1);
end;

class procedure TCMReportController.ReportOnFile;
begin

end;

class procedure TCMReportController.RunReport(aReportData: TCMMReportData;
  aMedia: TCMMediaType);
begin
    frxReport := setUpFastReport;
    frxReport.showReport;
end;

class procedure TCMReportController.RunReport(aReportNo: integer;  aMedia: TCMMediaType);
begin
  if (aReportNo = -1) and ( ReportData <> nil) then begin
    frxReport := setUpFastReport;
    frxReport.showReport;
  end;
end;

class function TCMReportController.setUpFastReport: TfrxReport;
begin
  FreeAndNil(frxReport);
  frxReport := TfrxReport.create(frmMain);
  frxReport.LoadFromFile(FTemplatePath + ReportData.Template);
  frxReport.DataSet := FDataSet;
  Result := frxReport;
end;

class procedure TCMReportController.setupReport(var aReportData: TCMMReportData; aParams: TCMParams);
begin
  with aReportData do
  begin
    createDBComponents(FStoredProc, FDataset, storedProcName, DatasetUserName, aParams);
  end;
  FStoredProc.Active := true;
  FSubReports := setUpSubReports( aReportData, aParams);
end;

class procedure TCMReportController.createDBComponents(var aSP: TFDStoredProc;
  var aDS: TfrxDBDataset; aSp_Name, aDs_Name: string; aParams: TCMParams);
begin
  // Create and prepare the TFDStoredProc component
  aSP := TFDStoredProc.create(frmMain);
  aSP.Connection := dmFR.FDConnection1;
  aSP.Active := false;
  aSP.storedProcName := aSp_Name;
  aSP.Prepare;
  addParams(aSP, aParams);

  // Create and prepare the TfrxDBDataset component
  aDS := TfrxDBDataset.create(frmMain);
  aDS.CloseDataSource := false;
  aDS.BCDToCurrency := false;
  aDS.DataSet := aSP;
  aDS.UserName := aDs_Name;
  aSP.Active := true;
end;

end.
