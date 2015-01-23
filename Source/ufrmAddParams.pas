unit ufrmAddParams;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,
  uReport;

Const
  USER_EDITLISTVIEW = WM_USER + 666;

type
  TfrmAddParams = class(TForm)
    bbnOk: TBitBtn;
    bbnCancel: TBitBtn;
    lvParameters: TListView;
    procedure FormCreate(Sender: TObject);
    procedure bbnCancelClick(Sender: TObject);
    procedure FListViewEditorExit(Sender: TObject);
    procedure lvParametersClick(Sender: TObject);
  private
    { Private declarations }
    FParams: TCMParams;
    FLastReportNo: integer;
    FListViewEditor: TEdit;
    FLItem: TListitem;
    procedure CreateParams;
    procedure loadParams(aReportData: TCMMReportData);

    procedure UserEditListView(Var Message: TMessage);
      message USER_EDITLISTVIEW;

  public
    { Public declarations }
    function execute(aReportData: TCMMReportData): TCMParams;
  end;

var
  frmAddParams: TfrmAddParams;

implementation

{$R *.dfm}

uses commctrl,
  uReportController;

const
  EDIT_COLUMN = 1; // Index of the column to Edit

procedure TfrmAddParams.bbnCancelClick(Sender: TObject);
begin
//  FreeAndNil(FParams);
end;

procedure TfrmAddParams.CreateParams;
var
  i: integer;
  Items: TListItems;
  name, value: string;
begin
  FParams.Clear;
  Items := lvParameters.Items;
  for i := 0 to Items.Count - 1 do
  begin
    name := Items[i].Caption;
    value := Items[i].SubItems[0];
    FParams.Add(name, value);
  end;
end;

function TfrmAddParams.execute(aReportData: TCMMReportData): TCMParams;
begin
  lvParameters.Clear;
  loadParams(aReportData);
  if (ShowModal = mrOK) then
  begin
    CreateParams;
    Result := FParams
  end
  else
    Result := nil;
end;

procedure TfrmAddParams.FListViewEditorExit(Sender: TObject);
begin
  If Assigned(FLItem) Then
  Begin
    // assign the vslue of the TEdit to the Subitem
    FLItem.SubItems[EDIT_COLUMN - 1] := FListViewEditor.Text;
    FLItem := nil;
    FListViewEditor.Visible := False;
  End;
end;

procedure TfrmAddParams.FormCreate(Sender: TObject);
begin
  lvParameters.Clear;
  FLastReportNo := -1;
  FParams := TCMParams.Create();
  // create the TEdit and assign the OnExit event
  FListViewEditor := TEdit.Create(Self);
  FListViewEditor.Parent := lvParameters;
  FListViewEditor.OnExit := FListViewEditorExit;
  FListViewEditor.Visible := False;
end;

procedure TfrmAddParams.loadParams(aReportData: TCMMReportData);
var
  params: TCMParamsInfo;
  listItem: TListitem;
  parName, keys: string;
begin
  if FLastReportNo <> aReportData.ReportNo then
  begin
    FParams.Clear;
    FLastReportNo := aReportData.ReportNo;
    FListViewEditor.Text := '';
    params := aReportData.getAllParameters;
    for parName in params.keys do begin
        listItem := lvParameters.Items.Add;
        listItem.Caption := parName;
        listItem.SubItems.Add('0');
    end;
  end else begin
    for parName in FParams.keys do begin
        listItem := lvParameters.Items.Add;
        listItem.Caption := parName;
        listItem.SubItems.Add(FParams.Items[parName]);
    end;
  end;
end;

procedure TfrmAddParams.lvParametersClick(Sender: TObject);
var
  LPoint: TPoint;
  LVHitTestInfo: TLVHitTestInfo;
begin
  LPoint := lvParameters.ScreenToClient(Mouse.CursorPos);
  ZeroMemory(@LVHitTestInfo, SizeOf(LVHitTestInfo));
  LVHitTestInfo.pt := LPoint;
  // Check if the click was made in the column to edit
  If (lvParameters.perform(LVM_SUBITEMHITTEST, 0, LPARAM(@LVHitTestInfo)) <> -1)
    and (LVHitTestInfo.iSubItem = EDIT_COLUMN) Then
    PostMessage(Self.Handle, USER_EDITLISTVIEW, LVHitTestInfo.iItem, 0)
  else
    FListViewEditor.Visible := False; // hide the TEdit
end;

procedure TfrmAddParams.UserEditListView(var Message: TMessage);
var
  LRect: TRect;
begin
  LRect.Top := EDIT_COLUMN;
  LRect.Left := LVIR_BOUNDS;
  lvParameters.perform(LVM_GETSUBITEMRECT, Message.wparam, LPARAM(@LRect));
  MapWindowPoints(lvParameters.Handle, FListViewEditor.Parent.Handle, LRect, 2);
  // get the current Item to edit
  FLItem := lvParameters.Items[Message.wparam];
  // set the text of the Edit
  FListViewEditor.Text := FLItem.SubItems[EDIT_COLUMN - 1];
  // set the bounds of the TEdit
  FListViewEditor.BoundsRect := LRect;
  // Show the TEdit
  FListViewEditor.Visible := True;
  FListViewEditor.SetFocus;
end;

end.
