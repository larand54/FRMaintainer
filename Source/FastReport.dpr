program FastReport;

uses
  Vcl.Forms,
  ufrmMain in 'ufrmMain.pas' {frmMain},
  ufrmAddParams in 'ufrmAddParams.pas' {frmAddParams},
  ufrmSubReportSettings in 'ufrmSubReportSettings.pas' {frmSubReportSettings},
  ufrmReportSettings in 'ufrmReportSettings.pas' {frmReportSettings},
  udmFR in '..\..\CommonSources\FastReport\udmFR.pas' {dmFR: TDataModule},
  uReport in '..\..\CommonSources\FastReport\uReport.pas',
  uReportController in '..\..\CommonSources\FastReport\uReportController.pas',
  OKCANCL1 in 'c:\program files (x86)\embarcadero\studio\14.0\ObjRepos\EN\DelphiWin32\OKCANCL1.PAS' {OKBottomDlg},
  ufrmCheckOrderNo in 'ufrmCheckOrderNo.pas' {frmCheckOrderNo};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmFR, dmFR);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmAddParams, frmAddParams);
  Application.CreateForm(TfrmSubReportSettings, frmSubReportSettings);
  Application.CreateForm(TfrmReportSettings, frmReportSettings);
//  Application.CreateForm(TfrmCheckOrderNo, frmCheckOrderNo);
  Application.Run;
end.
