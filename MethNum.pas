unit MethNum;

interface

uses
  Math, readf0nd;

const
  {�������� �������� ����� (���/�)}
  EARTH_ROT_SPEED = 2*PI/86400;

  {������ ����� � ��}
  EARTH_RAD = 6371;

  {����������� ����� (��������� ���)}
  STANDRD_ERA = 2451545.0;

  {��������� �����, ��� �������� ��������� �������}
  EPS = 10E-12;

  {���-�� ���������� � 1 �.�.}
  AU_KM = 1.49597870691E+8;

  {��������� ��� �������� �������� � ������� � �������}
  RAD = PI/180.0;

  {������ ��������� � �������� (�������)}
  ECL_EQ = 84381.412/3600*rad;


  MU = 2.9591220828559110225E-4;

type
  {�������� ������ ����������: a,e,i,Om,w,v}
  ElementsOfOrbit = record
    a,e,i,Om,w,v: extended;
  end;

  {��������� ���������� � �������� ����������: X,Y,Z,Vx,Vy,Vz}
  DacartCoords = record
    X,Y,Z,Vx,Vy,Vz: extended;
  end;


  {��������������� ��� ������ ��� ���� � �������}
  DateTime = record
    day,month,year,hour,minute: integer;
    second: extended;
  end;

  {�������������� ���������� (������ �����������, ���������)}
  EquatorCoords = record
    alpha,delta: extended;
  end;

  {�������������� ���������� (������, ������ ��� ����������)}
  HorizontalCoords = record
    Az,h: extended;
  end;

  {������������� ���������� (������� � ������)}
  EclipticCoords = record
    lamda,betta: extended;
  end;

  {�������������� ���������� (������� � ������)}
  GeogrCoords = record
    long,lat: extended;
  end;


{========================================================
���� �������� � ������� ��� ������������� � �����.

��� ������������� ���� ��������� ���� ��������� �����������
���������� .emeth � .cmeth, ����� �������� �������� �����������������
�������, �� ����, ������ ������ � ������������ ������� ���
���������� ��������� �����.

.emeth ������ � ���� �������� ������ ������� � ������ ������
� ��������� �������: a,e,i,Om,w,v.
.cmeth ������ � ���� ���������� � �������� � ������ ������ �
��������� �������: X,Y,Z,Vx,Vy,Vz.
�� ������ ������ ����� ������ �������� ���� ���������� �
������� dd mm yy hh mm ss.
� ������ ������ ����� ������ �������� �������������� ����������
������������ ������� � ��������� �������: alpha delta.
� ����������� �� ����, ����� ����������� � ������� ��������
������������, ����� ���������� ������� ��� �����.

��� ������� (��� ��������� � ������������ ��� ���������� ������)
����������� ������. ��������������, �� ����� ����� ���� �������
���� ������ ������, ������ ��� ��� ��� ���.
=========================================================}

{+���� ���������� ��������� �������, ������� ���������� � �������������� ���������}
procedure inputCMeth(filename: String; var meth: DecartCoords; time: DateTime;
          eqCords: EquatorCoords); overload;

{+���� ���������� ��������� ������� � ������� ����������}
procedure inputCMeth(filename: String; var meth: DecartCoords; time: DateTime); overload;

{+���� ���������� ��������� �������}
procedure inputCMeth(filename: String; var meth: DecartCoords); overload;

{���� ��������� ������ �������, ������� ���������� � �������������� ���������}
procedure inputEMeth(filename: String; var meth: ElementsOfOrbit; time: DateTime;
          eqCords: EquatorCoords); overload;

{���� ��������� ������ ������� � ������� ��� ����������}
procedure inputEMeth(filename: String; var meth: ElementsOfOrbit; time: DateTime); overload;

{���� ������ ��������� ������  �������}
procedure inputEMeth(filename: String; var meth: ElementsOfOrbit); overload;

{������������� ���� � ������� ��� ����������� ������������� �
���������}
function initDateTime(day,month,year,hour,minute,second): DateTime;

{������������� ��������� ������ �������}
function initElems(a,e,i,Om,w,v: extended): ElementsOfOrbit;

{������������� ���������� ��������� �������}
function initDecartCoords(X,Y,Z,Vx,Vy,Vz: extended): DecartCoords;

{������������� �������������� ���������}
function initEquatorCoords(alpha,delta: extended): EquatorCoords;

{������������� ������������� ���������}
function initEclipticCoords(lamda,betta: extended): EclipticCoords;

{������������� �������������� ���������}
function initHorizontalCoords(Az,h: extended): HorizontalCoords;

{������������� ��������������� ���������}
function initGeogrCoords(long,lat: extended): GeogrCoords;

{����� ���������� � ����}
procedure printCoords(coords: DecartCoords; fileName: string); overload;

{����� ��������� �� �����}
procedure printCoords(coords: DecartCoords); overload;

{������� � ���� �������� ������}
procedure printElements(elem: ElementsOfOrbit; fileName: string); overload;

{������� �� ����� �������� ������}
procedure printElements(elem: ElementsOfOrbit); overload;

{����� � ���� �������� ��������� (���������, ��������������)}
procedure printCelCoords(coords: EquatorCoords; fileName: string); overload;

{����� � ���� �������� ��������� (���������, ��������������)}
procedure printCelCoords(coords: HorizontalCoords; fileName: string); overload;

{����� � ���� �������� ��������� (���������, �������������)}
procedure printCelCoords(coords: EclipticCoords; fileName: string); overload;

{����� �� ����� �������� ��������� (���������, ��������������)}
procedure printCelCoords(coords: EquatorCoords); overload;

{����� �� ����� �������� ��������� (���������, ��������������)}
procedure printCelCoords(coords: HorizontalCoords); overload;

{����� �� ����� �������� ��������� (���������, �������������)}
procedure printCelCoords(coords: EclipticCoords); overload;


{================================================================
           ����� ����� �������� �������������� � �����
=================================================================}


{=================================================================
���� ��������������� �������� � �������, ��������� � ���������� �� ����� ��
� ������, ���������� �� ��������� ������ � ���������� ����������� � �������,
�����������, ���������� � ��������.
==================================================================}

{������� �������� �� ��������� ������ � ���������� �����������}
function fromOrbitToDecart(elems: ElementsOfOrbit): DecartCoords;

{������� �������� �� ���������� ��������� � ��������� ������}
function fromDecartToOrbit(coord: DecartCoords): ElementsOfOrbit;

{������� ������������� ���� � ���������}
function JDate(dt: DateTime): extended;

{�������� ����� �� ������� ��������� ����}
function siderealTime(year,month,day: integer): extended;

{������ ��������� ������� ������� �������}
function keplerSolution(e,M: extended): extended;

{������� ��������� ���� � �������������}
function grDate(JD: extended): DateTime;

{�������� ����� �� ����� ���� �� ������ �������}
function sidTimeOnLong(date: DateTime; long: extended): extended;

{������� �� �������������� ��������� � ������������� (������ �����)}
function fromEqToEcl(eq: EquatorCoords): EclipticCoords;

{������� �� ������������� ��������� � �������������� (������ �����)}
function fromEclToEq(ecl: EclipticCoords): EquatorCoords;

{������� �� �������������� ��������� � �������������� (������ �����)}
function fromHorToEq(hor: HorizontalCoords): EquatorCoords;

{������� �� �������������� ��������� � �������������� (������ �����)}
function fromEqToHor(eq: EquatorCoords): HorizontalCoords;

{������� �� �������������� ��������� � �������������� (�������� ������)}
function fromEqToEclDecart(eq: DecatrCoords): DecartCoords;

{������� �� ������������� ��������� � �������������� (�������� ������)}
function fromEclToEqDecart(ecl: DecartCoords): DecartCoords;

{���������� ������� �������}
function getRadiant(meth: DecartCoords): extended;


{=====================================================================
            ����� ����� ��������������� �������� � �������
======================================================================}


{=====================================================================
���� �������������� �������� � �������. �������� ������ ���������,
������ ��������, ������� ����� ������ � ������.
======================================================================}

{������� ������� ��������� ������ ��� � �� ���� angle (� ��������)}
function rotateSCX(angle: extended; dc: DecartCoords): DecartCoords;

{������� ������� ��������� ������ ��� Y �� ���� angle (� ��������)}
function rotateSCY(angle: extended; dc: DecartCoords): DecartCoords;

{������� ������� ��������� ������ ��� Z �� ���� angle (� ��������)}
function rotateSCZ(angle: extended; dc: DecartCoords): DecartCoords;

{������� �� ���������� ��������� � �����������}
procedure fromDecartToSphere(A: DecartCoords; var fi,lam: extended);

function fromSphereToDecart(fi,lam,r: extended): DecartCoords;

{����� ���� �������� (� ���������, � ���������)}
function sumOfVectors(A,B: DecartCoords): DecartCoords;

{�������� ���� �������� (� ���������, � ���������)}
function differenceOfVectors(A,B: DecartCoords): DecartCoords;

{������ ������� ��������� (�����, ���������� �� ����������)}
function moduleOfCoords(A: DecartCoords): extended;

{������ ������� �������� (�����, ���������� �� ��������)}
function moduleOfVelocity(A: DecartCoords): extended;

{������� � ������������� ������� � ���� ���������� �����}
function timeToDotTime(t: DateTime): extended;

{������� � ����������� ������������� ������� (����, ������, �������) ��
���� ����������� ����� (���� ���������� �� ���� ����� ����)}
function dotTimeToTime(t: extended): DateTime;

{������� �������� � �������}
function toRadians(x: extended): extended;

{������� ������ � �������}
function toDegree(x: extended): extended;

{������� ���������� � ��������������� �������}
function toAu(x: extended): extended;

{������� ��������������� ������ � ���������}
function toKm(x: extended): extended;

{������� �������� � ����}
function toHour(x: extended): extended;

{������� ����� � �������}
function toDegFromHour(x: extended): extended;

{=====================================================================
            ����� ����� �������������� �������� � �������
======================================================================}


{=====================================================================
   ���� �������� � �������, ���������� �� �������� �������.
   ����� ������ � ������� ������� ������. �� ���������� � �������������
   ��������� ��������� ����� �����������.
======================================================================}

{�������� ���������� ����� �� 430 ����� ������� ������}
function getEarthCoords(): DecartCoords;

{=====================================================================
    ����� ����� �������� � �������, ���������� �� �������� �������
======================================================================}

implementation

procedure inputCMeth(filename: String; var meth: DecartCoords; time: DateTime;
          eqCoords: EquatorCoords); overload;
var infile: text;
begin
  try
    Assign(infile,filename);
    Reset(infile);
  except
    Writeln('���� �� ������. ��������� ������������ ����.');
    Readln;
    Halt;
  end;

  try
    Readln(infile,meth.X,meth.Y,meth.Z,meth.Vx,meth.Vy,meth.Vz);
  except
    Writeln('���������� ������� ����������. ��������� ������������ �����.');
    Readln;
    Halt;
  end;

  try
    Readln(infile,time.day,time.month,time.year,time.hour,time.minute,time.second);
  except
    Writeln('���������� ������� ����. ��������� ������������ �����.');
    Readln;
    Halt;
  end;

  try
    Readln(infile,eqCoords.alpha,eqCoords.delta);
  except
    Writeln('���������� ������� �������������� ����������. ��������� ������������ �����.');
    Readln;
    Halt;
  end;

  Close(infile);
end;

procedure inputCMeth(filename: String; var meth: DecartCoords; time: DateTime); overload;
var infile: text;
begin
  try
    Assign(infile,filename);
    Reset(infile);
  except
    Writeln('���� �� ������. ��������� ������������ ����.');
    Readln;
    Halt;
  end;

  try
    Readln(infile,meth.X,meth.Y,meth.Z,meth.Vx,meth.Vy,meth.Vz);
  except
    Writeln('���������� ������� ����������. ��������� ������������ �����.');
    Readln;
    Halt;
  end;

  try
    Readln(infile,time.day,time.month,time.year,time.hour,time.minute,time.second);
  except
    Writeln('���������� ������� ����. ��������� ������������ �����.');
    Readln;
    Halt;
  end;

  Close(infile);
end;

procedure inputCMeth(filename: String; var meth: DecartCoords); overload;
var infile: text;
begin
  try
    Assign(infile,filename);
    Reset(infile);
  except
    Writeln('���� �� ������. ��������� ������������ ����.');
    Readln;
    Halt;
  end;

  try
    Readln(infile,meth.X,meth.Y,meth.Z,meth.Vx,meth.Vy,meth.Vz);
  except
    Writeln('���������� ������� ����������. ��������� ������������ �����.');
    Readln;
    Halt;
  end;

  Close(infile);
end;

end.
