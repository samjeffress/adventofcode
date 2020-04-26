-module(five).
% -import(two,[partOne/0]).
-export([partOne/0]).


input() ->
  [3,225,1,225,6,6,1100,1,238,225,104,0,1101,37,34,224,101,-71,224,224,4,224,1002,223,8,223,101,6,224,224,1,224,223,223,1002,113,50,224,1001,224,-2550,224,4,224,1002,223,8,223,101,2,224,224,1,223,224,223,1101,13,50,225,102,7,187,224,1001,224,-224,224,4,224,1002,223,8,223,1001,224,5,224,1,224,223,223,1101,79,72,225,1101,42,42,225,1102,46,76,224,101,-3496,224,224,4,224,102,8,223,223,101,5,224,224,1,223,224,223,1102,51,90,225,1101,11,91,225,1001,118,49,224,1001,224,-140,224,4,224,102,8,223,223,101,5,224,224,1,224,223,223,2,191,87,224,1001,224,-1218,224,4,224,1002,223,8,223,101,4,224,224,1,224,223,223,1,217,83,224,1001,224,-124,224,4,224,1002,223,8,223,101,5,224,224,1,223,224,223,1101,32,77,225,1101,29,80,225,101,93,58,224,1001,224,-143,224,4,224,102,8,223,223,1001,224,4,224,1,223,224,223,1101,45,69,225,4,223,99,0,0,0,677,0,0,0,0,0,0,0,0,0,0,0,1105,0,99999,1105,227,247,1105,1,99999,1005,227,99999,1005,0,256,1105,1,99999,1106,227,99999,1106,0,265,1105,1,99999,1006,0,99999,1006,227,274,1105,1,99999,1105,1,280,1105,1,99999,1,225,225,225,1101,294,0,0,105,1,0,1105,1,99999,1106,0,300,1105,1,99999,1,225,225,225,1101,314,0,0,106,0,0,1105,1,99999,7,226,226,224,102,2,223,223,1005,224,329,101,1,223,223,108,677,226,224,102,2,223,223,1005,224,344,1001,223,1,223,1108,226,677,224,102,2,223,223,1005,224,359,1001,223,1,223,8,677,226,224,102,2,223,223,1006,224,374,1001,223,1,223,107,226,226,224,102,2,223,223,1006,224,389,101,1,223,223,1108,677,226,224,1002,223,2,223,1005,224,404,1001,223,1,223,108,677,677,224,102,2,223,223,1005,224,419,101,1,223,223,7,226,677,224,1002,223,2,223,1006,224,434,1001,223,1,223,107,226,677,224,102,2,223,223,1005,224,449,101,1,223,223,1108,677,677,224,1002,223,2,223,1006,224,464,101,1,223,223,7,677,226,224,102,2,223,223,1006,224,479,101,1,223,223,1007,677,677,224,1002,223,2,223,1005,224,494,101,1,223,223,1008,226,226,224,102,2,223,223,1006,224,509,1001,223,1,223,107,677,677,224,102,2,223,223,1006,224,524,1001,223,1,223,8,226,226,224,1002,223,2,223,1005,224,539,1001,223,1,223,1007,677,226,224,102,2,223,223,1006,224,554,1001,223,1,223,1007,226,226,224,1002,223,2,223,1005,224,569,1001,223,1,223,8,226,677,224,1002,223,2,223,1006,224,584,101,1,223,223,108,226,226,224,1002,223,2,223,1006,224,599,101,1,223,223,1107,677,226,224,1002,223,2,223,1005,224,614,1001,223,1,223,1107,226,677,224,102,2,223,223,1006,224,629,1001,223,1,223,1008,226,677,224,102,2,223,223,1005,224,644,101,1,223,223,1107,226,226,224,102,2,223,223,1006,224,659,1001,223,1,223,1008,677,677,224,102,2,223,223,1006,224,674,1001,223,1,223,4,223,99,226]  
.

print(L) -> 
  % io:format("Values:~p~n",[L])
  noop
.

printOutput(L) -> 
  io:format("Output:~p~n",[L])
.
  
add(X,Y) -> X + Y.
multiply(X,Y) -> X * Y.  


partOne() -> 
  Input = input(),
  Size = length(Input)-1,
  print(Input),
  print(Size),
  InputMap = maps:from_list(lists:zip(lists:seq(0, Size), Input)),
  print(InputMap),
  processCodeBlockWithCheck(0, InputMap).


optCodeInParts(OptCode) -> 
  Stringed = integer_to_list(OptCode),
  Arr = [list_to_integer([Char]) || Char <- Stringed],
  print([Arr, "length:", length(Arr)]),
  case length(Arr) of 
    4 -> lists:append([0], Arr);
    3 -> lists:append([0,0], Arr);
    2 -> lists:append([0,0,0], Arr);
    1 -> lists:append([0,0,0,0], Arr);
    _ -> Arr
  end
.

valueAt(Position, Intcodes, immediate) ->
  maps:get(Position, Intcodes, "default kittens");

valueAt(Position, Intcodes, reference) ->
  maps:get(valueAt(Position, Intcodes, immediate), Intcodes, "default kittens")
.

intToMode(0) -> 
  reference;
intToMode(1) -> 
  immediate.


processCodeBlockWithCheck(StartingPosition, Intcodes) -> 
  print(["StartingPosition", StartingPosition]),
  Instructions = valueAt(StartingPosition, Intcodes, immediate),
  print(Instructions),

  R = optCodeInParts(Instructions),
  print(["R", R]),
  [_, B, C, OptCodeA, OptCodeB] = R,

  OptCode = OptCodeA * 10 + OptCodeB,

  Param1Value = valueAt(StartingPosition+1, Intcodes, intToMode(C)),
  Param2Value = valueAt(StartingPosition+2, Intcodes, intToMode(B)),
  OutputPosition = valueAt(StartingPosition+3, Intcodes, immediate),

  case OptCode of
      99 -> print(maps:get(0, Intcodes)),
            print('oh yeah'),
            Intcodes;
      1 -> processWithUpdates(OutputPosition, add(Param1Value, Param2Value), Intcodes, StartingPosition, 4);
      2 -> processWithUpdates(OutputPosition, multiply(Param1Value, Param2Value), Intcodes, StartingPosition, 4);
      3 -> Param3Immediate = valueAt(StartingPosition+1, Intcodes, immediate),
            print(["Param3Immediate",Param3Immediate]),
           InputValue = 1,
           processWithUpdates(Param3Immediate, InputValue, Intcodes, StartingPosition, 2);
      4 -> InputImmediate = valueAt(StartingPosition+1, Intcodes, immediate),
           InputVal = valueAt(StartingPosition+1, Intcodes, reference),
           printOutput(["StartingPosition", StartingPosition, "InputImmediate",InputImmediate, "Inputval:", InputVal]),
           processCodeBlockWithCheck(StartingPosition + 2, Intcodes);
      _ -> throw('poop - unexpected opt code')
  end 
.

processWithUpdates(KeyToUpdate, NewValue, Intcodes, StartingPosition, LengthOfInstructions) ->
  print(["Updating", KeyToUpdate, "With Value", NewValue]),
  UpdatedIntcodes = maps:put(KeyToUpdate, NewValue, Intcodes),
  processCodeBlockWithCheck(StartingPosition + LengthOfInstructions, UpdatedIntcodes)
.
