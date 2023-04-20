program ListArrayBenchmark;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Classes,
  DateUtils,
  Generics.Collections;

type
   TSimpleType = Integer;

   TComplexType = record
      FFieldA: Integer;
      FFieldB: string;
      procedure SetPropA(Value: Integer);
      procedure SetPropB(Value: string);
   public
      constructor Create(AValue: Integer; BValue: string);
      property PropA: Integer read FFieldA write SetPropA;
      property PropB: string read FFieldB write SetPropB;
   end;

   TObjectType = class
   private
      FA: Integer;
      FB: String;
   public
   public
      constructor Create(A: Integer; B: String);
      property A: Integer read FA;
      property B: String read FB;
   end;

   { TObjectType }

constructor TObjectType.Create(A: Integer; B: String);
begin
   FA := A;
   FB := B;
end;

constructor TComplexType.Create(AValue: Integer; BValue: string);
begin
   FFieldA := AValue;
   FFieldB := BValue;
end;

procedure TComplexType.SetPropA(Value: Integer);
begin
   FFieldA := Value;
end;

procedure TComplexType.SetPropB(Value: string);
begin
   FFieldB := Value;
end;

const
   NumElements = 5000000;

var
   i                 : Integer;
   StartTime, EndTime: TDateTime;
   SimpleArray       : array [0 .. NumElements - 1] of TSimpleType;
   ComplexArray      : array [0 .. NumElements - 1] of TComplexType;
   ObjectArray       : array [0 .. NumElements - 1] of TObjectType;
   SimpleList        : TList<TSimpleType>;
   ComplexList       : TList<TComplexType>;
   ObjectList        : TList<TObjectType>;
   F:Integer;
   S:String;

begin
   // Simple types: allocating, filling, accessing, iterating
   SimpleList := TList<TSimpleType>.Create;
   ComplexList := TList<TComplexType>.Create;
   ObjectList := TList<TObjectType>.Create;
   Writeln('SIMPLE TYPES:');
   StartTime := Now;
   for i := 0 to NumElements - 1 do
   begin
      SimpleArray[i] := i;
   end;
   EndTime := Now;
   Writeln('Array allocation and filling: ', MillisecondsBetween(StartTime, EndTime), ' ms');

   StartTime := Now;
   for i := 0 to NumElements - 1 do
   begin
      SimpleList.Add(i);
   end;
   EndTime := Now;
   Writeln('List allocation and filling: ', MillisecondsBetween(StartTime, EndTime), ' ms');

   StartTime := Now;
   for i := 0 to NumElements - 1 do
   begin
      SimpleArray[i] := SimpleArray[i] * 2;
   end;
   EndTime := Now;
   Writeln('Array accessing and modifying: ', MillisecondsBetween(StartTime, EndTime), ' ms');

   StartTime := Now;
   for i := 0 to SimpleList.Count - 1 do
   begin
      SimpleList[i] := SimpleList[i] * 2;
   end;
   EndTime := Now;
   Writeln('List accessing and modifying: ', MillisecondsBetween(StartTime, EndTime), ' ms');

   StartTime := Now;
   for i := 0 to NumElements - 1 do
   begin
     F := SimpleArray[i];
   end;
   EndTime := Now;
   Writeln('Array iteration: ', MillisecondsBetween(StartTime, EndTime), ' ms');

   StartTime := Now;
   for i := 0 to SimpleList.Count - 1 do
   begin
      F := SimpleList[i];
   end;
   EndTime := Now;
   Writeln('List iteration: ', MillisecondsBetween(StartTime, EndTime), ' ms');

   // Complex types: allocating, filling, accessing, iterating
   Writeln('COMPLEX TYPES:');
   StartTime := Now;
   for i := 0 to NumElements - 1 do
   begin
      ComplexArray[i].PropA := i;
      ComplexArray[i].PropB := IntToStr(i);
   end;
   EndTime := Now;
   Writeln('Array allocation and filling: ', MillisecondsBetween(StartTime, EndTime), ' ms');

   StartTime := Now;
   for i := 0 to NumElements - 1 do
   begin
      ComplexList.Add(TComplexType.Create(i, IntToStr(i)));
   end;
   EndTime := Now;
   Writeln('List allocation and filling: ', MillisecondsBetween(StartTime, EndTime), ' ms');

   StartTime := Now;
   for i := 0 to NumElements - 1 do
   begin
      ComplexArray[i].PropA := ComplexArray[i].PropA * 2;
      ComplexArray[i].PropB := ComplexArray[i].PropB + 'x2';
   end;
   EndTime := Now;
   Writeln('Array accessing and modifying: ', MillisecondsBetween(StartTime, EndTime), ' ms');

   StartTime := Now;
   for i := 0 to ComplexList.Count - 1 do
   begin
      ComplexList[i].PropA := ComplexList[i].PropA * 2;
      ComplexList[i].PropB := ComplexList[i].PropB + 'x2';
   end;
   EndTime := Now;
   Writeln('List accessing and modifying: ', MillisecondsBetween(StartTime, EndTime), ' ms');

   StartTime := Now;
   for i := 0 to NumElements - 1 do
   begin
      F := ComplexArray[i].PropA;
      S := ComplexArray[i].PropB;
   end;
   EndTime := Now;
   Writeln('Array iteration: ', MillisecondsBetween(StartTime, EndTime), ' ms');

   StartTime := Now;
   for i := 0 to ComplexList.Count - 1 do
   begin
      F := ComplexList[i].PropA;
      S := ComplexList[i].PropB;
   end;
   EndTime := Now;
   Writeln('List iteration: ', MillisecondsBetween(StartTime, EndTime), ' ms');

   // Objects: allocating, filling, accessing, iterating
   Writeln('OBJECTS:');
   StartTime := Now;
   for i := 0 to NumElements - 1 do
   begin
      ObjectArray[i] := TObjectType.Create(i, IntToStr(i));
   end;
   EndTime := Now;
   Writeln('Array allocation and filling: ', MillisecondsBetween(StartTime, EndTime), ' ms');

   StartTime := Now;
   for i := 0 to NumElements - 1 do
   begin
      ObjectList.Add(TObjectType.Create(i, IntToStr(i)));
   end;
   EndTime := Now;
   Writeln('List allocation and filling: ', MillisecondsBetween(StartTime, EndTime), ' ms');

   StartTime := Now;
   for i := 0 to NumElements - 1 do
   begin
      ObjectArray[i].FA := ObjectArray[i].FA * 2;
      ObjectArray[i].FB := ObjectArray[i].FB + 'x2';
   end;
   EndTime := Now;
   Writeln('Array accessing and modifying: ', MillisecondsBetween(StartTime, EndTime), ' ms');

   StartTime := Now;
   for i := 0 to ObjectList.Count - 1 do
   begin
      ObjectList[i].FA := ObjectList[i].A * 2;
      ObjectList[i].FB := ObjectList[i].B + 'x2';
   end;
   EndTime := Now;
   Writeln('List accessing and modifying: ', MillisecondsBetween(StartTime, EndTime), ' ms');

   StartTime := Now;
   for i := 0 to NumElements - 1 do
   begin
      F := ObjectArray[i].A;
      S := ObjectArray[i].B;
   end;
   EndTime := Now;
   Writeln('Array iteration: ', MillisecondsBetween(StartTime, EndTime), ' ms');

   StartTime := Now;
   for i := 0 to ObjectList.Count - 1 do
   begin
      F := ObjectList[i].A;
      S := ObjectList[i].B;
   end;
   EndTime := Now;
   Writeln('List iteration: ', MillisecondsBetween(StartTime, EndTime), ' ms');

   ReadLn;
end.
