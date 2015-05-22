unit ufrmCheckOrderNo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, udmFR, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls;

type
  TfrmCheckOrderNo = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    FDQuery1: TFDQuery;
    FDQuery1OrderNo: TIntegerField;
    FDQuery1OrderNoText: TStringField;
    BitBtn2: TBitBtn;
    Label3: TLabel;
    Timer1: TTimer;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit1Enter(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Edit2Enter(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    FOrderNoText : string;
    FOrderNo: integer;
    procedure SetOrderNoText(const Value: string);
    procedure SetOrderNo(const Value: integer);
    procedure UpdateOrderNo;
    procedure UpdateLoginText;
  public
    { Public declarations }
    Property OrderNoText: string read FOrderNoText write SetOrderNoText;
    property OrderNo: integer read FOrderNo write SetOrderNo;
  end;

var
  frmCheckOrderNo: TfrmCheckOrderNo;

implementation

{$R *.dfm}


procedure TfrmCheckOrderNo.BitBtn1Click(Sender: TObject);
begin
  frmCheckOrderNo.Close;
end;

procedure TfrmCheckOrderNo.BitBtn2Click(Sender: TObject);
begin
  UpdateOrderNo;
end;

procedure TfrmCheckOrderNo.Edit1Enter(Sender: TObject);
begin
  OrderNoText := '';
end;

procedure TfrmCheckOrderNo.Edit1Exit(Sender: TObject);
begin
  OrderNo := strToInt(Edit1.Text);
end;

procedure TfrmCheckOrderNo.Edit2Enter(Sender: TObject);
begin
  OrderNo := -1;
end;

procedure TfrmCheckOrderNo.Edit2Exit(Sender: TObject);
begin
  OrderNoText := Edit2.Text;
end;

procedure TfrmCheckOrderNo.FormCreate(Sender: TObject);
begin
  UpdateLoginText;
  FOrderNoText := '';
  FOrderNo := -1;
  Edit1.Text := intToStr(ForderNo);
  Edit2.Text := FOrderNoText;
  Label4.ShowHint := true;
end;

procedure TfrmCheckOrderNo.SetOrderNo(const Value: integer);
begin
  FOrderNo := Value;
  Edit1.Text := intToStr(FOrderNo);
end;

procedure TfrmCheckOrderNo.SetOrderNoText(const Value: string);
begin
  FOrderNoText := Value;
  Edit2.Text := FOrderNoText;
end;

procedure TfrmCheckOrderNo.Timer1Timer(Sender: TObject);
begin
  UpdateLoginText;
end;

procedure TfrmCheckOrderNo.UpdateLoginText;
begin
  Label3.Caption := 'Inloggad på server: '+dmFR.FDConnection1.Params.Values['Server'];
end;

procedure TfrmCheckOrderNo.UpdateOrderNo;
begin
  UpdateLoginText;
  FDQuery1.Active := false;
  if (OrderNo <> -1) then begin
    FDQuery1.ParamByName('OrderNr').AsInteger := OrderNo;
    FDQuery1.ParamByName('OrderTxt').AsString := '';
    FDQuery1.Active := true;
    if not FDQuery1.EOF then
      Edit2.Text := FDQuery1['OrderNoText']
    else
      Edit2.Text := 'Ordern finns ej!';
  end
  else if OrderNoText <> '' then begin
    FDQuery1.ParamByName('OrderNr').AsInteger := -1;
    FDQuery1.ParamByName('OrderTxt').AsString := OrderNoText;
    FDQuery1.Active := true;
    if not FDQuery1.EOF then
      Edit1.Text := intToStr(FDQuery1['OrderNo'])
    else
      Edit1.Text := 'Ordern finns ej!';
  end
end;

end.
