unit ufrmSelectDB;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TfrmSelectDB = class(TForm)
    rgDatabases: TRadioGroup;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
    function Execute: string;
  end;

var
  frmSelectDB: TfrmSelectDB;

implementation

{$R *.dfm}

{ TForm1 }

function TfrmSelectDB.Execute: string;
begin
  if ShowModal = mrOk  then
  begin
    Result := rgDatabases.Items[rgDatabases.ItemIndex];
  end
  else Result := '';
end;

end.
