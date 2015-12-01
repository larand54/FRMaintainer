unit ufrmDocType;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids,
  udmFR;

type
  TfrmDocType = class(TForm)
    sgDocType: TStringGrid;
    lbxReports: TListBox;
    Replele: TLabel;
    Label1: TLabel;
    edDoctype: TEdit;
    edDescription: TEdit;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure sgDocTypeSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure sgDocTypeMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
    FSelectedRow: integer;
    procedure Sortgrid(Grid : TStringGrid; SortCol:integer);
    procedure FillDocTypeGrid;
    function GetReportsUsingDocType(aDocType: integer): TStringList;
  public
    { Public declarations }
    function Execute: integer;
  end;

var
  frmDocType: TfrmDocType;

implementation
{$R *.dfm}

procedure TfrmDocType.BitBtn1Click(Sender: TObject);
var
  DT: integer;
begin
  // Check if a valid number is entered as Doctype
  if edDoctype.Text = '' then
  begin
    // Give error message 'Enter a valid number first!'
    showMessage('Enter a valid number first!');
    exit;
  end;
  try
    // Give error message 'Valid number should be > 0'
     DT := strToInt(edDoctype.Text);
     if DT <= 0 then
     begin
       showmessage('Valid number is >  0');
       exit;
     end;
  except
    ShowMessage('Entered value is not a number!');
    exit;
  end;
  // Check that the entered doctype is unique
  if dmFR.getDocTypeByNumber(DT) <> '' then
  begin
    showMessage('Entered doctype already exists!');
    exit;
  end;
  // Check that a description is entered
  if edDescription.Text = '' then
  begin
    ShowMessage('Please enter some description!');
    exit;
  end;

  // Try update the database
  try
    dmFr.addDocType(DT,edDescription.Text);
    FillDocTypeGrid;
  finally

  end;
end;

procedure TfrmDocType.BitBtn2Click(Sender: TObject);
var
  iDt: integer;
  sDescr: string;
begin
  if FSelectedRow > 0 then
  begin
    iDt := strToInt(sgDocType.Cells[0,FSelectedRow]);
    sDescr := sgDocType.Cells[1,FSelectedRow];
    if MessageDlg('Are you shure to delete DocType: '+intToStr(iDt)+': '+sDescr+'?',mtWarning,[mbYes,mbNo],0)=mrYes then
    begin
      // Delete it
      dmFR.deleteDoctype(iDt);
      FillDocTypeGrid
    end
    else;
  end
  else
    showMessage('Select a DOCTYPE first!');
end;

procedure TfrmDocType.BitBtn3Click(Sender: TObject);
begin
  dmFR.updateDoctype(strToInt(edDoctype.Text), edDescription.Text);
  FillDocTypeGrid;
end;

function TfrmDocType.Execute: integer;
begin
  if ShowModal = mrOK then result := strToInt(sgDocType.Cells[0, FSelectedRow])
  else result := -1;
end;

procedure TfrmDocType.FillDocTypeGrid;
var
  iDocType: integer;
  sDocType: string;
  docType: TCMDocType;
  Row: integer;
  st : TStringList;
begin
  docType := dmFR.DocType;
  for Row:=0 to sgDocType.RowCount-1 do
    sgDocType.Rows[Row].Clear;
//  sgDocType.Options := sgDocType.Options + [goRowSelect];
  sgDocType.RowCount := 1 + docType.Count;
//  sgDocType.Options := sgDocType.Options - [goRowSelect];
  Row := 1;
  for idocType in docType.keys do begin
    st := TStringList.Create;
    sDocType := docType[iDocType];
    st.Add(intToStr(iDocType));
    st.Add(docType.Items[iDocType]);
    sgDocType.Rows[Row].AddStrings(st);
    inc(Row);
    freeandnil(st);
  end;
  sortGrid(sgDocType,0);
end;

procedure TfrmDocType.FormCreate(Sender: TObject);
begin
  FSelectedRow := -1;
end;

procedure TfrmDocType.FormShow(Sender: TObject);
begin
  FillDocTypeGrid;
end;

function TfrmDocType.GetReportsUsingDocType(aDocType: integer): TStringList;
begin
  Result := dmFR.getReportsUsingDoctype(aDocType);
end;

procedure TfrmDocType.sgDocTypeMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  c, j: Integer;
  rect: trect;
  docType: Integer;
  sl: TStringList;
  iRow, iCol: integer;
begin
  with sgDocType do
    if Y < rowheights[0] then { make sure row 0 was clicked }
    begin
      for j := 0 to colcount - 1 do { determine which column was clicked }
      begin
        rect := cellrect(j, 0);
        if (rect.Left < X) and (rect.Right > X) then
        begin
          c := j;
          break;
        end;
      end;
      Sortgrid(sgDocType, c);
    end
    else
    begin
      sgDocType.MouseToCell(X,Y,iCol, iRow);
      begin
        FSelectedRow := iRow;
        sl := TStringList.Create;
        docType := strToInt(sgDocType.Cells[0, iRow]);
        sl := GetReportsUsingDocType(docType);
        if sl = nil then
          lbxReports.Clear
        else
          lbxReports.Items := sl;
        edDoctype.Text := sgDocType.Cells[0, iRow];
        edDescription.Text := sgDocType.Cells[1, iRow];

      end;
    end;
end;

procedure TfrmDocType.sgDocTypeSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var
  DocType: integer;
  sl: TStringList;
begin
  FSelectedRow := ARow;
(*  sl := TStringList.Create;
  DocType := strToInt(sgDocType.Cells[0, ARow]);
  sl := getReportsUsingDocType(DocType);
  if sl = nil then
    lbxReports.clear
  else
    lbxReports.Items := sl;
  edDoctype.Text := sgDocType.Cells[0, ARow];
  edDescription.Text := sgDocType.Cells[1, ARow];
*)
end;

procedure TfrmDocType.Sortgrid(Grid: TStringGrid; SortCol: integer);
var
   i,j : integer;
   temp:tstringlist;
begin
  temp:=tstringlist.create;
  with Grid do
  for i := FixedRows to RowCount - 2 do  {because last row has no next row}
  for j:= i+1 to rowcount-1 do {from next row to end}
  if AnsiCompareText(Cells[SortCol, i], Cells[SortCol,j]) > 0
  then
  begin
    temp.assign(rows[j]);
    rows[j].assign(rows[i]);
    rows[i].assign(temp);
  end;
  temp.free;
end;

end.
