Program DEMONSTRATION_DE_FIGURES_EN_3D;
{*** Programmé par xxx, Mai 199x ***}

USES crt,Graph;

VAR Driver,Mode,Err   : Integer;
    x,y,z,a,b         : real;
    fin               : char;
    xo,yo,couleur,p,q : integer;

{ ***  Sous-Routines de tracé point par point  *** }

Procedure TRACE_TORE(x,y:real);
  begin
    z:=sin(x);
    a:=(10*cos(x)+50)*cos(y);
    b:=(10*cos(x)+50)*sin(y);
    p:=round((a*0.3+b*0.2)*5);
    q:=round((z+b*0.2)*5);
    putpixel(xo+p,yo-q,couleur);
  end;

Procedure TRACE_PLAN_TORDU(x,y:real);
  begin
    z:=y*x*x;
    p:=round((x+y*0.7)*50);
    q:=round((z+y*0.7)*50);
    putpixel(xo+p,yo-q,couleur);
  end;

Procedure TRACE_SPHERE(x,y:real);
  begin
    z:=sin(x);
    a:=cos(x)*cos(y);
    b:=cos(x)*sin(y);
    p:=round((a+b*0.2)*70);
    q:=round((z+b*0.2)*70);
    putpixel(xo+p,yo-q,couleur);
  end;

Procedure TRACE_TUNNEL(x,y:real);
  begin
    z:=x*x*x*x;
    p:=round((x+y*0.7)*50);
    q:=round(10-(z+y*0.7)*50);
    putpixel(xo+p,yo-q,couleur);
  end;

{ ***  Routines des objets 3D  *** }

Procedure TORE;
begin
couleur:=2;
x:=-pi;
  while (x<pi) do
   begin
    x:=x+pi/6;
    y:=-pi;
      while (y<2*pi) do
       begin
        y:=y+pi/25;
        trace_tore(x,y);
       end;
   end;
y:=-pi;
  while (y<pi) do
   begin
    y:=y+pi/6;
    x:=-pi;
      while (x<pi) do
       begin
        x:=x+pi/20;
        trace_tore(x,y);
       end;
   end;
end;

Procedure PLAN_TORDU;
begin
couleur:=lightblue;
x:=-1-1/5;
  while (x<0.8) do
   begin
    x:=x+1/5;
    y:=-1;
      while (y<1) do
       begin
        y:=y+1/75;
        trace_plan_tordu(x,y);
       end;
   end;
y:=-1-1/5;
  while (y<0.8) do
   begin
    y:=y+1/5;
    x:=-1;
      while (x<1) do
       begin
        x:=x+1/75;
        trace_plan_tordu(x,y);
       end;
   end;
end;

Procedure SPHERE;
begin
couleur:=4;
x:=-pi;
  while (x<pi/4+pi/12) do
   begin
    x:=x+pi/12;
    y:=-pi;
      while (y<pi) do
       begin
        y:=y+pi/50;
        trace_sphere(x,y);
       end;
   end;
y:=-pi;
  while (y<pi/4) do
   begin
    y:=y+pi/12;
    x:=-pi;
      while (x<pi) do
       begin
        x:=x+pi/50;
        trace_sphere(x,y);
       end;
   end;
end;

Procedure ASTROIDE;
var i:real;
begin
setcolor(14);
i:=0;
  while (i<2*pi) do
    begin
      p:=round(80*cos(i)*cos(i)*cos(i));
      q:=round(80*sin(i)*sin(i)*sin(i));
      line(xo+p,yo+q,xo+25+p,yo+10+q);
      i:=i+pi/75;
    end;
setcolor(15);
end;

Procedure DOME;
begin
couleur:=13;
x:=-pi/10;
  while (x<pi/2) do
   begin
    x:=x+pi/10;
    y:=0;
      while (y<2*pi) do
       begin
        y:=y+pi/100;
        trace_sphere(x,y);
       end;
   end;
y:=0;
  while (y<pi) do
   begin
    y:=y+pi/10;
    x:=0;
      while (x<pi) do
       begin
        x:=x+pi/100;
        trace_sphere(x,y);
       end;
   end;
end;

Procedure TUNNEL;
begin
couleur:=7;
x:=-1-1/5;
  while (x<0.8) do
   begin
    x:=x+1/5;
    y:=-1;
      while (y<1) do
       begin
        y:=y+1/75;
        trace_tunnel(x,y);
       end;
   end;
y:=-1-1/5;
  while (y<0.8) do
   begin
    y:=y+1/5;
    x:=-1;
      while (x<1) do
       begin
        x:=x+1/75;
        trace_tunnel(x,y);
       end;
   end;
end;

{********  Début Du Programme Principal  ********}

BEGIN
  Clrscr;
  Writeln;
  DetectGraph(Driver,Mode);
  if (Driver<>VGA) or (Mode<>VGAHi) then
    begin
      Writeln(' Ce programme nécessite un écran VGA');
      Write(' en mode 640x480, 16 couleurs.');
      repeat until keypressed;
      halt;
    end;
  InitGraph(Driver,Mode,' '); { Mettre ici le chemin des BGI }
  Err := GraphResult;
  if not Err = grOk then
    begin
      Writeln('Erreur d''initialisation graphique : ');
      Write(GraphErrorMsg(Err));
      repeat until keypressed;
      halt;
    end;
  setcolor(15);
  line(1,1,640,1);line(1,450,640,450);line(1,1,1,450);line(639,1,639,450);
  line(1,230,640,230);
  line(440,1,440,450);
  line(200,1,200,450);
  settextstyle(TriplexFont,0,4);

  xo:=105;yo:=115;
  plan_tordu;

  xo:=322;yo:=130;
  tore;
  outtextXY(290,20,'Tore');

  xo:=540;yo:=130;
  sphere;
  outtextXY(495,12,'Sphère');

  xo:=100;yo:=385;
  dome;
  outtextXY(65,265,'Dome');

  xo:=310;yo:=355;
  astroide;
  outtextXY(260,232,'Astroide');

  xo:=540;yo:=330;
  tunnel;

  setcolor(11);
  settextstyle(3,0,1);
  outtextXY(100,455,'xxx, 199x. Appuyez sur une touche.');
  fin:=readkey;
END.
