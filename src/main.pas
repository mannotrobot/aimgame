program main;
uses
    game_objects,
    handler_game_objects,
    crt;

const
    live = 3;

procedure get_key(var code: integer);
var
    symbol: char;
begin
    symbol := readkey;
    if symbol = #0 then
    begin
        symbol := readkey;
        code := -ord((symbol))
    end
    else
    begin
        code := ord(symbol);
    end;
end;

procedure update_aim(var new_aim: aim; delta: integer);
begin
    case delta of
    -1: begin
            new_aim.coords[0].x := new_aim.coords[0].x - 1;
            new_aim.coords[1].x  := new_aim.coords[1].x - 1;
            new_aim.coords[2].x := new_aim.coords[2].x - 1;
            new_aim.coords[3].x  := new_aim.coords[3].x - 1;
            new_aim.main.x := new_aim.main.x - 1;
        end;
     1: begin
            new_aim.coords[0].x := new_aim.coords[0].x + 1;
            new_aim.coords[1].x  := new_aim.coords[1].x + 1;
            new_aim.coords[2].x := new_aim.coords[2].x + 1;
            new_aim.coords[3].x  := new_aim.coords[3].x + 1;
            new_aim.main.x := new_aim.main.x + 1;
        end;
    -2: begin
            new_aim.coords[0].y := new_aim.coords[0].y - 1;
            new_aim.coords[1].y  := new_aim.coords[1].y - 1;
            new_aim.coords[2].y := new_aim.coords[2].y - 1;
            new_aim.coords[3].y  := new_aim.coords[3].y - 1;
            new_aim.main.y := new_aim.main.y - 1;
        end;
     2: begin
            new_aim.coords[0].y := new_aim.coords[0].y + 1;
            new_aim.coords[1].y  := new_aim.coords[1].y + 1;
            new_aim.coords[2].y := new_aim.coords[2].y + 1;
            new_aim.coords[3].y  := new_aim.coords[3].y + 1;
            new_aim.main.y := new_aim.main.x + 1;
        end;
     end;
end;

procedure draw_aim(var new_aim: aim);
var
    coord: xy;
begin
    for coord in new_aim.coords do
    begin
        gotoxy(coord.x, coord.y);
        write(new_aim.c);
        gotoxy(1, 1);
    end;
end;

procedure clear_aim(var new_aim: aim);
var
    coord: xy;
begin
    for coord in new_aim.coords do
    begin
        gotoxy(coord.x, coord.y);
        write(' ');
        gotoxy(1, 1);
    end;
end;

procedure show_target(var new_target: target);
begin
    gotoxy(new_target.x, new_target.y);
    textcolor(new_target.col);
    write(new_target.symbol);
    textcolor(7);
    gotoxy(1, 1)
end;

procedure hide_target(var new_target: target);
begin
    gotoxy(new_target.x, new_target.y);
    write(' ');
    gotoxy(1, 1);
end;


procedure one_moving(var new_target: target);
begin
    hide_target(new_target);
    new_target.y := new_target.y + 1;
    show_target(new_target);
    delay(new_target.speed);
end;

procedure game_loop;
var
     new_target: target;
     new_aim: aim;
     height: integer;
     width: integer;
     code : integer;
begin
    height := screenheight div 2;
    width  := screenwidth div 2;
    new_aim := create_aim(width, height);
    new_target := create_target;
    while True do
    begin
        while not keypressed do
        begin
             if new_target. y = screenheight then
             begin
                 hide_target(new_target);
                 new_target := create_target;
             end;
             one_moving(new_target);
             draw_aim(new_aim);
        end;
        get_key(code);
        case code of
            27 : break;
            -75: begin
                     clear_aim(new_aim);
                     update_aim(new_aim, -1);
                     draw_aim(new_aim);
                 end;
            -77: begin
                     clear_aim(new_aim);
                     update_aim(new_aim, 1);
                     draw_aim(new_aim);
                 end;
            -72: begin
                     clear_aim(new_aim);
                     update_aim(new_aim, -2);
                     draw_aim(new_aim);
                 end;
            -80: begin
                     clear_aim(new_aim);
                     update_aim(new_aim, 2);
                     draw_aim(new_aim);
                 end;
            32: begin
                    if (new_aim.main.x = new_target.x) and (new_aim.main.y = new_target.y) then
                    begin
                        clrscr;
                        gotoxy(1, 1);
                        write('you win');
                        break;
                    end; 
                end;
        end;
    end; 
end;

begin
    clrscr;
    game_loop;
    delay(3000);
    clrscr;
end.
