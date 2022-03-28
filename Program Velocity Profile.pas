(*Windows Free Pascal is developed by dr J.Szymanda under the GPL License*)
(*************************************************************************)
{
Programming Basics - Physics ITB 
Wulan Silvani
}

program FDM;

uses crt,sysutils,math;

//const


//Global variables
var
L,ubot,utop,errmax,Re,mu,rho,h,err,A,f,v_avg:double;
i,N,count:integer;
v,v_new,conv,y:array of real;
fileout:TextFile;


//Functions here

//Procedures here

// ***** MAIN PROGRAM BEGIN *****
begin
writeln('----- Program Started');
writeln;
writeln('----- Please press ENTER to continue...');
readln;

//Initialization
N:=20;
L:=1.0e-2; h:=L/N;
ubot:=-0.025; utop:=0.05;
errmax:=1.0e-6;
Re:=500;
mu:=1.0e-3;
rho:=1000;

//setlength the array
setlength(v,N+1); setlength(conv,N+1);
setlength(y,N+1); setlength(v_new,N+1);

//Boundary Condition
v[1]:=ubot; y[1]:=0; v_new[1]:=v[1];
v[N+1]:=utop; y[N+1]:=L; v_new[N+1]:=v[N+1];

//Guess and converge initialization
for i:=2 to (N) do
begin
v[i]:=(utop-ubot)/2;
 if v[i]=0 then
  begin
   v[i]:=0.5;
  end;
y[i]:=y[i-1]+h;
conv[i]:=1;
end;

v_avg:=Re*mu/(rho*L);
f:=24/Re;
A:=(f*rho*(v_avg)**2)/(2*L);

assign(fileout,'output.txt');
rewrite(fileout);
count:=0;

//Do the processes here
writeln('Process...');
repeat
 for i:=2 to (N) do
 begin
  v_new[i]:=((v[i+1]+v[i-1])/2)+A*h**2/(2*mu); 
  err:=abs((v_new[i]-v[i])/v[i]);
  v[i]:=v_new[i];
  if (err<=errmax) then
   begin
    conv[i]:=0;
   end;
 end;
 count:=count+1;
 writeln('Process... ','[',count:3,']');
until sum(conv) = 0;

writeln('   y    v');
writeln(fileout,'##   y    v');
for i:=1 to (N+1) do
begin
 writeln(fileout,y[i]:8:4,v[i]:8:4); 
 writeln(y[i]:8:3,v[i]:8:3);                      
end;

close(fileout);
writeln('----- output saved');
writeln;
writeln('----- Program Finished');
readln;
end.
// ***** MAIN PROGRAM END *****