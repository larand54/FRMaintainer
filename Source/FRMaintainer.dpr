program FRMaintainer;

uses
  Vcl.Forms,
  udmFR in 'udmFR.pas' {dmFR: TDataModule},
  uReport in 'uReport.pas',
  ufrmMain in 'ufrmMain.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmFR, dmFR);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
