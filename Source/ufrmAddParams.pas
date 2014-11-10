unit ufrmAddParams;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,
  uReport, siComp, siLngLnk;


type
  TfrmAddParams = class(TForm)
    edName: TEdit;
    edValue: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    bbnAdd: TBitBtn;
    bbnRemove: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    lvParameters: TListView;
    bbnClear: TBitBtn;
    siLangLinked_frmAddParams: TsiLangLinked;
    procedure bbnAddClick(Sender: TObject);
    procedure bbnClearClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bbnRemoveClick(Sender: TObject);
  private
    { Private declarations }
    FParams : TCMParams;
    procedure CreateParams;
  public
    { Public declarations }
    function execute: TCMParams;
  end;

var
  frmAddParams: TfrmAddParams;

implementation

{$R *.dfm}


procedure TfrmAddParams.bbnAddClick(Sender: TObject);
var
  listItem : TListItem;

begin
  listItem := lvParameters.Items.Add;
  if edName.Text[1] <> '@' then
    edName.Text := '@'+edName.Text;
  listItem.Caption := edName.Text;
  listItem.SubItems.Add(edValue.Text);
end;

procedure TfrmAddParams.bbnRemoveClick(Sender: TObject);
var
  i: integer;
begin
  for i  := lvParameters.Items.Count-1 downto 0 do begin
    if lvParameters.Items[i].Checked then lvParameters.Items[i].Delete;
  end;
end;

procedure TfrmAddParams.CreateParams;
var
  i: integer;
  Items: TListItems;
  name, value: string;
begin
  FParams := TCMParams.Create();
  Items := lvParameters.Items;
  for I := 0 to Items.Count-1 do begin
    name := Items[i].Caption;
    value := Items[i].SubItems[0];
    FParams.add(name,value);
  end;
end;

function TfrmAddParams.execute: TCMParams;
begin
  FreeandNil(FParams);
  if (ShowModal = mrOK) then begin
    CreateParams;
    Result := FParams
  end
  else
    Result := nil;
end;

procedure TfrmAddParams.bbnClearClick(Sender: TObject);
begin
  lvParameters.Clear;
end;

procedure TfrmAddParams.FormCreate(Sender: TObject);
begin
  edName.Text := '';
  edValue.Text := '';
  lvParameters.Clear;
end;

end.
