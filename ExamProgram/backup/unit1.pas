unit Unit1;

{$mode objfpc}{$H+}
//{$IfDef windows}{$AppType console}{$EndIf}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, LCLType;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure formkeypress(Sender: TObject; var key: char);
  private

  public

  end;

var
  Form1: TForm1;
  Dx, Dy, x, y, dir, i, j, Score: integer;
  HighScore,Count: integer;
  WallX, SnakeX: array[0..160] of integer;
  WallY, SnakeY: array[0..160] of integer;
  w: word;
  c: char;
  Map: boolean;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);

  procedure ReadHighScore();
  var
    f: Text;
  begin
    AssignFile(f, 'HighScore.txt');
    reset(f);
    Read(f, HighScore);
    closeFile(f);

    label2.color := clwhite;
    label2.Caption := 'High Score: ' + IntToStr(HighScore);
  end;

   procedure CreateNewGem();
  var
    Succes: boolean;
    i:integer;
  begin
    //Create gem on random spot until it isn´t on same coordinates as snake or wall
    Succes := False;
    repeat
      Succes := True;
      Dx := random(39) * 10 + 10;
      Dy := random(39) * 10 + 10;
      for j := 0 to score do
      begin
        if (SnakeX[j] = Dx) and (SnakeY[j] = Dy) then
          Succes := False;
      end;

      if map=true then begin
      for i:=0 to count-1 do begin
      if ((WallX[i]=Dx) and (WallY[i]=Dy)) then
        succes:=false;
      end;
      end;
    until Succes;
    Canvas.Brush.Color := TColor($FF0000);
    Canvas.fillrect(dx, dy, dx + 9, dy + 9);
  end;

  procedure DrawMap();
  var
  i:integer;
  begin
      Canvas.brush.Color := Clsilver;
  for i:=0 to count-1 do begin
  Canvas.fillrect(WallX[i],WallY[i],WallX[i]+9,WallY[i]+9);
    end;
  end;

begin
  randomize;
  Canvas.brush.Color := Clsilver;
  Canvas.fillrect(0, 0, 9, 400);
  Canvas.fillrect(0, 0, 400, 9);
  canvas.fillrect(391, 0, 400, 400);
  Canvas.fillrect(0, 391, 400, 400);

  Score := 0;
  label1.color := clwhite;
  label1.Caption := 'Score: ' + IntToStr(Score);
  dir := 0;
  CreateNewGem();
  if map = true then DrawMap();
  x := 200;
  Y := 200;
  ReadHighScore;

  Button1.Visible := False;
  Button2.Visible := False;
  Button7.Visible := False;
  Button8.Visible := False;
  timer1.Enabled := True;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if dir <> 2 then
    dir := 0;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  if dir <> 1 then
    dir := 3;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  if dir <> 0 then
    dir := 2;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  if dir <> 3 then
    dir := 1;
end;

procedure TForm1.Button7Click(Sender: TObject);
//Write highscore to file
var
  g: Text;
begin
  assignfile(g, 'HighScore.txt');
  rewrite(g);
  Write(g, score);
  closefile(g);
  Button7.Visible := False;
end;

procedure TForm1.Button8Click(Sender: TObject);
var
  a: Text;
  i: integer;
begin
  map := True;
  button8.Visible := False;
  AssignFile(a, 'map.txt');
  reset(a);
  Read(a, Count);
  if Count >= 1 then
  begin
    for i := 0 to Count - 1 do
    begin
      Read(a, WallX[i]);
      Read(a, WallY[i]);
    end;
  end;
  closefile(a);

end;

procedure TForm1.FormCreate(Sender: TObject);

begin
  form1.color := ClBlack;
  KeyPreview := True;
  Button1.Visible := True;
  Button1.Caption := 'Start';
  Button2.Visible := True;
  Button2.Caption := 'exit';
  Button7.Visible := False;
  Button7.Caption := 'Write highscore';

  map := False;
  timer1.Enabled := False;

end;




procedure TForm1.Timer1Timer(Sender: TObject);

    procedure CreateNewGem();
  var
    Succes: boolean;
    i:integer;
  begin
    //Create gem on random spot until it isn´t on same coordinates as snake or wall
    Succes := False;
    repeat
      Succes := True;
      Dx := random(39) * 10 + 10;
      Dy := random(39) * 10 + 10;
      for j := 0 to score do
      begin
        if (SnakeX[j] = Dx) and (SnakeY[j] = Dy) then
          Succes := False;
      end;

      if map=true then begin
      for i:=0 to count-1 do begin
      if ((WallX[i]=Dx) and (WallY[i]=Dy)) then
        succes:=false;
      end;
      end;
    until Succes;
    Canvas.Brush.Color := TColor($FF0000);
    Canvas.fillrect(dx, dy, dx + 9, dy + 9);
  end;

  procedure EraseMap();
  var
  i:integer;
  begin
  Canvas.brush.Color := Clblack;
  for i:=0 to count-1 do begin
  Canvas.fillrect(WallX[i],WallY[i],WallX[i]+9,WallY[i]+9);
  map:=false;
    end;
  end;

  procedure GameOver();
  var
  i:integer;
  begin
    timer1.Enabled := False;
    //erase whole snake
    Canvas.Brush.Color := clblack;
    for j := 0 to score do
    begin
      canvas.FillRect(SnakeX[j], SnakeY[j], SnakeX[j] + 10, SnakeY[j] + 10);
    end;

    //Return screen to start setting
    if map=true then EraseMap();
    Canvas.fillrect(0, 0, 9, 400);
    Canvas.fillrect(0, 0, 400, 9);
    canvas.fillrect(391, 0, 400, 400);
    Canvas.fillrect(0, 391, 400, 400);
    Canvas.fillrect(dx, dy, dx + 10, dy + 10);
    button1.Visible := True;
    Button2.Visible := True;
    Button8.Visible := True;
    if score > Highscore then
      Button7.Visible := True;
  end;


begin
  //Move Head in correct dirrection
  case dir of
    0: x := x + 10;
    1: y := y + 10;
    2: x := x - 10;
    3: y := y - 10;
  end;

  //check if the snake is in the cage if not then game over
  if (x < 10) or (y < 10) or (y >= 390) or (x >= 390) then
    GameOver();

  //check if the snake isn´t hitting wall
   if map=true then begin
     for i:=0 to count -1 do begin
       if ((WallX[i]=x) and (WallY[i]=y)) then GameOver();
     end;
   end;

  //If coordinates of snake are same as gem then change score, create new gem
  if (Dx = x) and (Dy = y) then
  begin
    Score := Score + 1;
    Label1.Caption := 'Score: ' + IntToStr(Score);
    CreateNewGem();
  end
  else //else erase last part of snake
  if ((snakeX[0] <> 0) or (snakeY[0] <> 0)) then
  begin
    Canvas.Brush.Color := clBlack;
    canvas.FillRect(SnakeX[Score], SnakeY[Score], SnakeX[Score] + 9,
      SnakeY[Score] + 9);
  end;

  //Check if Snake isn't bitting itself, and make room for new head
  for i := score - 1 downto 0 do
  begin
    SnakeX[i + 1] := SnakeX[i];
    SnakeY[i + 1] := SnakeY[i];
    if ((i > 0) and (SnakeX[i] = x) and (SnakeY[i] = y)) then
      GameOver();
  end;

  //If isn´t game over then put head to array and draw rectangle on its position.
  if timer1.Enabled = True then
  begin
    SnakeX[0] := x;
    SnakeY[0] := y;
    Canvas.Brush.Color := clwhite;
    canvas.FillRect(SnakeX[0], SnakeY[0], SnakeX[0] + 9, SnakeY[0] + 9);
  end;
end;

//so far doing nothing
procedure Tform1.formkeypress(Sender: TObject; var key: char);
begin
  if Ord(Key) = VK_F1 then
    Close;
end;

end.
