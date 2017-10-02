unit iClock;

{$mode objfpc}{$H+}

interface

uses
  Threads,
  Console,
  Classes,
  OpenVG,       {Include the OpenVG unit so we can use the various types and structures}
  VGShapes,     {Include the VGShapes unit to give us access to all the functions}
  VC4,
  SysUtils;

var
 CenterX:VGfloat;
 CenterY:VGfloat;
 Dialsize:VGfloat;

 dialrim:VGfloat;

 startickX:VGfloat;
 startickY:VGfloat;
 stoptickX:VGfloat;
 stoptickY:VGfloat;

 min5stroke:VGfloat;
 minstroke:VGfloat;

 handOffsetX:VGfloat;
 handOffsetY:VGfloat;
 secOffsetX:VGfloat;
 secOffsetY:VGfloat;

 secDotsize:VGfloat;
 minDotsize:VGfloat;

 sechandwidth:VGfloat;
 minhandwidth:VGfloat;
 hourhandwidth:VGfloat;

 Count:Integer;
 Countmin:Integer;

 clkHours:Integer;
 clkMinutes:Integer;
 clkSeconds:Integer;

 Fontsize:Integer;

const
 {The names of dial text}
 Dialnames:array[0..11] of String = (
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '10',
  '11',
  '12');

procedure clock(var CenterX, CenterY, Dialsize, clkHours,clkMinutes,clkSeconds: Integer);


implementation


procedure clock(var CenterX, CenterY, Dialsize, clkHours,clkMinutes,clkSeconds: Integer);
begin

 dialrim:= Trunc(Dialsize * 0.02);
 min5stroke:= Trunc(Dialsize * 0.02);
 minstroke:= Trunc(Dialsize * 0.01);

 secDotsize:=Trunc(Dialsize * 0.01);
 minDotsize:=Trunc(Dialsize * 0.07);

 sechandwidth:=Trunc(Dialsize * 0.01);
 minhandwidth:=Trunc(Dialsize * 0.022);
 hourhandwidth:=Trunc(Dialsize * 0.03);

 Fontsize:=Trunc(Dialsize * 0.02);


       {Circle}
       VGShapesStrokeWidth(dialrim);
       VGShapesStroke(0,0,0,1);
       VGShapesFill(255,255,255,1);
       VGShapesCircle(CenterX,CenterY,Dialsize);

       VGShapesFill(0,0,0,1);
       VGShapesStroke(0,0,0,1);
       VGShapesStrokeWidth(minstroke);

       for Countmin:= 0 to 59 do
        begin

         startickX:= Dialsize / 2.4 * sin((Countmin * 6) * pi / 180 + pi / 6);
         startickY:= Dialsize / 2.4 * cos((Countmin * 6) * pi / 180 + pi / 6 ) ;

         stoptickX:= Dialsize / 2.1 * sin((Countmin * 6) * pi / 180 + pi / 6);
         stoptickY:= Dialsize / 2.1 * cos((Countmin * 6) * pi / 180 + pi / 6 ) ;

         VGShapesLine(CenterX  + startickX, CenterY + startickY,CenterX + stoptickX, CenterY + stoptickY);

        end;


       for Count:= 0 to 11 do
        begin

         startickX:= Dialsize / 2.8 * sin((Count * 30) * pi / 180 + pi / 6);
         startickY:= Dialsize / 2.8 * cos((Count * 30) * pi / 180 + pi / 6 ) ;
         stoptickX:= Dialsize / 2.1 * sin((Count * 30) * pi / 180 + pi / 6);
         stoptickY:= Dialsize / 2.1 * cos((Count * 30) * pi / 180 + pi / 6 ) ;

         VGShapesStrokeWidth(min5stroke);
         VGShapesLine(CenterX  + startickX, CenterY + startickY,CenterX + stoptickX , CenterY + stoptickY);

        end;

       vgSeti(VG_STROKE_CAP_STYLE,VG_CAP_ROUND);
       VGShapesStroke(0,0,0,1);
       VGShapesFill(0,0,0,1);
       VGShapesCircle(CenterX,CenterY,minDotsize);

       //hours

       VGShapesStrokeWidth(hourhandwidth);
       VGShapesStroke(0,0,0,1);
       handOffsetX:= Dialsize / 4 * sin((clkHours * 30 + (clkMinutes / 2)) * pi / 180 );
       handOffsetY:= Dialsize / 4 * cos((clkHours * 30 + (clkMinutes / 2)) * pi / 180 );
       VGShapesLine(CenterX , CenterY, CenterX + handOffsetX, CenterY + handOffsetY);

       //minutes

       VGShapesStrokeWidth(minhandwidth);
       VGShapesStroke(0,0,0,1);
       handOffsetX:= Dialsize / 3 * sin((clkMinutes * 6) * pi / 180 );
       handOffsetY:= Dialsize / 3 * cos((clkMinutes * 6) * pi / 180 );
       VGShapesLine(CenterX , CenterY, CenterX + handOffsetX, CenterY + handOffsetY);

       //Seconds:= 0 ;

       VGShapesStroke(200,0,0,1);
       VGShapesFill(200,0,0,1);
       VGShapesCircle(CenterX,CenterY,secDotsize);

       VGShapesStrokeWidth(sechandwidth);

       secOffsetX:= Dialsize / 2.5 * sin((clkSeconds * 6) * pi / 180 );
       secOffsetY:= Dialsize / 2.5 * cos((clkSeconds * 6) * pi / 180 );
       handOffsetX:= Dialsize / 10 * sin((clkSeconds * 6) * pi / 180 );
       handOffsetY:= Dialsize / 10 * cos((clkSeconds * 6) * pi / 180 );

       VGShapesLine(CenterX , CenterY, CenterX + secOffsetX, CenterY + secOffsetY);
       VGShapesLine(CenterX, CenterY, CenterX - handOffsetX, CenterY - handOffsetY);



 end;

end.


