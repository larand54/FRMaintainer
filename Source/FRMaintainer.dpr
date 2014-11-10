program FRMaintainer;

uses
  Vcl.Forms,
  udmFR in 'udmFR.pas' {dmFR: TDataModule},
  uReport in 'uReport.pas',
  ufrmMain in 'ufrmMain.pas' {frmMain},
  uReportController in 'uReportController.pas',
  ufrmAddParams in 'ufrmAddParams.pas' {frmAddParams},
  ufrmSubReportSettings in 'ufrmSubReportSettings.pas' {frmSubReportSettings},
  ufrmReportSettings in 'ufrmReportSettings.pas' {frmReportSettings},
  udmLanguage in 'udmLanguage.pas' {dmLanguage: TDataModule},
  ufrmChangeLanguage in '..\..\CommonUnits\ufrmChangeLanguage.pas' {frmChangeLanguage},
  UnitAboutBox in '..\..\CommonUnits\UnitAboutBox.pas' {AboutBox};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmFR, dmFR);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmAddParams, frmAddParams);
  Application.CreateForm(TfrmSubReportSettings, frmSubReportSettings);
  Application.CreateForm(TfrmReportSettings, frmReportSettings);
  Application.CreateForm(TdmLanguage, dmLanguage);
  Application.CreateForm(TfrmChangeLanguage, frmChangeLanguage);
  Application.Run;
end.
