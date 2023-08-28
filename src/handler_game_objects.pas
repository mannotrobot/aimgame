unit handler_game_objects;
interface

uses
    game_objects,
    crt;

function create_aim(x: integer; y: integer): aim;
function create_target(): target;
implementation

function create_aim(x: integer; y: integer): aim;
var
    naim : aim;
begin
    naim.coords[0].x := x - 1;
    naim.coords[0].y := y;

    naim.coords[1].x := x + 1;
    naim.coords[1].y := y;

    naim.coords[2].x := x;
    naim.coords[2].y := y - 1;

    naim.coords[3].x := x;
    naim.coords[3].y := y + 1;

    naim.main.x := x;
    naim.main.y := y;

    naim.c := '+';

    create_aim := naim;
end;

function create_target() : target;
var
    ntarget : target;
begin
    ntarget.speed := 300;
    ntarget.delta := 1;

    randomize;
    ntarget.symbol := '*';
    ntarget.col := random(14) + 1;
 
    ntarget.x := random(screenwidth-2) + 3;
    ntarget.y := 1;
    

    create_target := ntarget;
end;
end.
