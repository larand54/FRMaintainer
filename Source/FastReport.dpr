program FastReport;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Vcl.Forms,
  ufrmMain in 'ufrmMain.pas' {frmMain},
  ufrmAddParams in 'ufrmAddParams.pas' {frmAddParams},
  ufrmSubReportSettings in 'ufrmSubReportSettings.pas' {frmSubReportSettings},
  ufrmReportSettings in 'ufrmReportSettings.pas' {frmReportSettings},
  udmFR in '..\..\CommonSources\FastReport\udmFR.pas' {dmFR: TDataModule},
  uReport in '..\..\CommonSources\FastReport\uReport.pas',
  uReportController in '..\..\CommonSources\FastReport\uReportController.pas',
  ufrmCheckOrderNo in 'ufrmCheckOrderNo.pas' {frmCheckOrderNo},
  uFR_Log in '..\..\CommonSources\FastReport\uFR_Log.pas',
  ufrmCopyTables in 'ufrmCopyTables.pas' {frmCopyTables},
  ufrmDocType in 'ufrmDocType.pas' {frmDocType},
  ufrmTranslations in 'ufrmTranslations.pas' {frmTranslations},
  uFRConstants in '..\..\CommonSources\FastReport\uFRConstants.pas',
  uDBLogg in '..\..\CommonSources\DelphiLogg\uDBLogg.pas',
  uIDBConnector in '..\..\CommonSources\DelphiLogg\uIDBConnector.pas',
  uIDBLogg in '..\..\CommonSources\DelphiLogg\uIDBLogg.pas',
  uILogger in '..\..\CommonSources\DelphiLogg\uILogger.pas',
  uLogger in '..\..\CommonSources\DelphiLogg\uLogger.pas',
  uVIS_UTILS in '..\..\CommonSources\uVIS_UTILS.pas',
  uIdmFR in '..\..\CommonSources\FastReport\uIdmFR.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmFR, dmFR);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmAddParams, frmAddParams);
  Application.CreateForm(TfrmSubReportSettings, frmSubReportSettings);
  Application.CreateForm(TfrmReportSettings, frmReportSettings);
  Application.CreateForm(TfrmCopyTables, frmCopyTables);
  Application.CreateForm(TfrmDocType, frmDocType);
  Application.CreateForm(TfrmTranslations, frmTranslations);
  //  Application.CreateForm(TfrmCheckOrderNo, frmCheckOrderNo);
  Application.Run;
end.
