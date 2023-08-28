unit game_objects;
interface
type
    xy = record
	x: integer;
	y: integer;
    end;

    aim = record
        coords: array [0..3] of xy;
	c: char;
	main: xy;
        col: integer;
    end;

    target = record
	speed:integer;
	x: integer;
        y: integer;
	col: integer;
        symbol: char;
        delta: integer;
    end;
implementation
end.

 
