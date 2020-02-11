-module(two).
-export([partOne/0]).

input() ->
    % [1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,10,1,19,1,19,5,23,1,23,9,27,2,27,6,31,1,31,6,35,2,35,9,39,1,6,39,43,2,10,43,47,1,47,9,51,1,51,6,55,1,55,6,59,2,59,10,63,1,6,63,67,2,6,67,71,1,71,5,75,2,13,75,79,1,10,79,83,1,5,83,87,2,87,10,91,1,5,91,95,2,95,6,99,1,99,6,103,2,103,6,107,2,107,9,111,1,111,5,115,1,115,6,119,2,6,119,123,1,5,123,127,1,127,13,131,1,2,131,135,1,135,10,0,99,2,14,0,0]
    [1,12,2,3,1,1,2,3,1,3,4,3,1,5,0,3,2,10,1,19,1,19,5,23,1,23,9,27,2,27,6,31,1,31,6,35,2,35,9,39,1,6,39,43,2,10,43,47,1,47,9,51,1,51,6,55,1,55,6,59,2,59,10,63,1,6,63,67,2,6,67,71,1,71,5,75,2,13,75,79,1,10,79,83,1,5,83,87,2,87,10,91,1,5,91,95,2,95,6,99,1,99,6,103,2,103,6,107,2,107,9,111,1,111,5,115,1,115,6,119,2,6,119,123,1,5,123,127,1,127,13,131,1,2,131,135,1,135,10,0,99,2,14,0,0]
    % [1,1,1,4,99,5,6,0,99]
  % [2,4,4,5,99,0]
.

partOne() -> 
  % TODO: try using dict instead of list for storage
  R = processCodeBlock(1, input()),
  io:format("~p~n",[R])
.

print(L) -> 
  io:format("Values:~p~n",[L])
.
  
add(X,Y) -> X + Y.
multiply(X,Y) -> X * Y.  

processCodeBlock(StartingPosition, Intcodes) -> 
  Block = lists:sublist(Intcodes, StartingPosition, 4),
  case Block of
    [] -> throw("shouldn't be empty");
    [OptCode, ValPosition1, ValPosition2, Pos] -> 
      Val1 = lists:nth(ValPosition1+1, Intcodes),
      Val2 = lists:nth(ValPosition2+1, Intcodes),
      NewValue = case OptCode of
          99 -> print(Intcodes),
                throw("Halt, you've had enough fun");
          1 -> add(Val1, Val2);
          2 -> multiply(Val1, Val2);
          _ -> 'poop'
      end,
      % https://stackoverflow.com/questions/4776033/how-to-change-an-element-in-a-list-in-erlang
      % TODO: try using dict instead of list for storage
      io:format("V:~p @ P:~p StartingPosition:~p~n",[NewValue,Pos,StartingPosition]),      
      UpdatedList = lists:sublist(Intcodes,Pos) ++ [NewValue] ++ lists:nthtail(Pos+1,Intcodes),
      % print(UpdatedList),
      processCodeBlock(StartingPosition + 4, UpdatedList);
    _ -> throw("bad mmkay")
  end.

