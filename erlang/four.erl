-module(four).
-export([partOne/0]).
-export([partTwo/0]).

neverDecrease(NumberList) -> 
  [H1,H2|Tail] = NumberList,
  case length(NumberList) of 
    1 -> throw("shouldn't get here");
    2 -> binary_to_integer(<<H1>>) =< binary_to_integer(<<H2>>);
    _ -> case binary_to_integer(<<H1>>) =< binary_to_integer(<<H2>>) of 
           false -> false;
           true -> neverDecrease([H2]++Tail)
         end
  end
.

areEqualValue(First, Second) ->
  binary_to_integer(<<First>>) == binary_to_integer(<<Second>>)
.

hasAdjacentDigitSame(NumberList) -> 
  [H1,H2|Tail] = NumberList,
  case length(NumberList) of 
    1 -> throw("shouldn't get here");
    2 -> areEqualValue(H1, H2);
    _ -> case areEqualValue(H1, H2) of 
           true -> true;
           _ -> hasAdjacentDigitSame([H2]++Tail)
         end
  end
.



hasDoubleRepeating(NumberList) -> 
  io:format("Cats:~p~n",[[NumberList]]),
  [H1,H2|Tail] = NumberList,
  case length(NumberList) of 
    1 -> throw("shouldn't get here");
    % 2 -> areEqualValue(H1,H2);
    3 ->
        [H3|FuzzyTail] = Tail, 
        case [areEqualValue(H1, H2), areEqualValue(H2, H3)] of 
          [false, true] -> true;
          _ -> false
        end;
    _ ->
        [H3|FuzzyTail] = Tail, 
        case [areEqualValue(H1, H2), areEqualValue(H2, H3)] of
          [true, false] -> true;
          _ -> hasDoubleRepeating([H2, H3]++FuzzyTail)
        end
  end
.

filter(Num) -> 
  NumList = integer_to_list(Num),
  AdjacentDigitsSame = hasAdjacentDigitSame(NumList),
  NeverDecrease = neverDecrease(NumList),
  NeverDecrease and AdjacentDigitsSame
.

filterTwo(Num) -> 
  NumList = integer_to_list(Num),
  NeverDecrease = neverDecrease(NumList),
  HasDouble = hasDoubleRepeating(NumList),
  NeverDecrease and HasDouble
.

partOne() -> 
  InputList = lists:seq(197487, 673251),
  GoodInput = lists:filter(fun filter/1, InputList),
  io:format("Number of possible passwords:~p~n",[[length(GoodInput)]])
.

partTwo() ->
  InputList = lists:seq(197487, 673251),
  GoodInput = lists:filter(fun filterTwo/1, InputList),
  io:format("Number of possible passwords:~p~n",[[length(GoodInput)]])
.