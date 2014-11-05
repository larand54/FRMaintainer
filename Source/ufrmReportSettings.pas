unit ufrmReportSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
   uReport, uReportController;

type
  TfrmReportSettings = class(TForm)
    lblTemplate_Name: TLabel;
    lblDocType: TLabel;
    lblSP_Name: TLabel;
    lblDS_Name: TLabel;
    edTemplate: TEdit;
    edDoctype: TEdit;
    edStoredProc: TEdit;
    edDataset: TEdit;
    ListBox1: TListBox;
    lblSubreports: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    edDescription: TEdit;
    lblDescription: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    function Execute(TCMC: TCMReportController): TCMMReportData;
  end;

var
  frmReportSettings: TfrmReportSettings;

implementation

{$R *.dfm}

uses udmFR;

{ TfrmReportSettings }

function TfrmReportSettings.Execute(TCMC: TCMReportController): TCMMReportData;
begin
  if (ShowModal = mrOK) then begin
    Result := TCMC.NewReport(edTemplate.Text, edDoctype.Text, edStoredProc.Text,
     edDataset.Text, edDescription.Text);
  end
  else
    Result := nil;

end;

end.
