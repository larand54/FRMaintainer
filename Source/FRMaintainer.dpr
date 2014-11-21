program FRMaintainer;

uses
  Vcl.Forms,
  ufrmMain in 'ufrmMain.pas' {frmMain},
  ufrmAddParams in 'ufrmAddParams.pas' {frmAddParams},
  ufrmSubReportSettings in 'ufrmSubReportSettings.pas' {frmSubReportSettings},
  ufrmReportSettings in 'ufrmReportSettings.pas' {frmReportSettings},
  udmFR in '..\..\CommonUnits\fastreport\udmFR.pas' {dmFR: TDataModule},
  uReport in '..\..\CommonUnits\fastreport\uReport.pas',
  uReportController in '..\..\CommonUnits\fastreport\uReportController.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmFR, dmFR);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmAddParams, frmAddParams);
  Application.CreateForm(TfrmSubReportSettings, frmSubReportSettings);
  Application.CreateForm(TfrmReportSettings, frmReportSettings);
  Application.Run;
end.
