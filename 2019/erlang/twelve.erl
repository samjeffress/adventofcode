-module(twelve).
-export([partOne/0]).

-record(spaceythingy, {x=0, y=0, z=0 }).

-record(moonPosition, {
    name=nil,
    position=#spaceythingy{},
    velocity=#spaceythingy{}
  }).

print(L) -> 
  io:format("Values:~p~n",[L])
.


input() -> [
  #moonPosition{name='Io', position=#spaceythingy{x=16, y=-11, z=-2}},
  #moonPosition{name='Europa', position=#spaceythingy{x=0, y=-4, z=7}},
  #moonPosition{name='Ganymede', position=#spaceythingy{x=6, y=4, z=-10}},
  #moonPosition{name='Callisto', position=#spaceythingy{x=-3, y=-2, z=-4}}
].

gravityForAxisPrimaryMinusSecondary(G) when G > 0 -> 1;
gravityForAxisPrimaryMinusSecondary(G) when G < 0 -> -1;
gravityForAxisPrimaryMinusSecondary(G) when G == 0 -> 0.

g(CurrentMoon, [HeadMoon|TailMoons]) -> 
  case CurrentMoon#moonPosition.name == HeadMoon#moonPosition.name of 
    true -> 
      % skip this one
      g(CurrentMoon, TailMoons);
    
    false -> 
      % do the calculation, then go to next result
      CurrentMoonWithG = #moonPosition{
        name=CurrentMoon#moonPosition.name,
        velocity=#spaceythingy{
            x=CurrentMoon#moonPosition.velocity#spaceythingy.x + gravityForAxisPrimaryMinusSecondary(CurrentMoon#moonPosition.position#spaceythingy.x - HeadMoon#moonPosition.position#spaceythingy.x),
            y=CurrentMoon#moonPosition.velocity#spaceythingy.y + gravityForAxisPrimaryMinusSecondary(CurrentMoon#moonPosition.position#spaceythingy.y - HeadMoon#moonPosition.position#spaceythingy.y),
            z=CurrentMoon#moonPosition.velocity#spaceythingy.z + gravityForAxisPrimaryMinusSecondary(CurrentMoon#moonPosition.position#spaceythingy.z - HeadMoon#moonPosition.position#spaceythingy.z)
          },
        position=CurrentMoon#moonPosition.position
      },
      g(CurrentMoonWithG, TailMoons)
  end
;

g(CurrentMoon, []) ->
  #moonPosition{
    name=CurrentMoon#moonPosition.name,
    velocity=CurrentMoon#moonPosition.velocity,
    position=#spaceythingy{
      x=CurrentMoon#moonPosition.velocity#spaceythingy.x + CurrentMoon#moonPosition.position#spaceythingy.x,
      y=CurrentMoon#moonPosition.velocity#spaceythingy.y + CurrentMoon#moonPosition.position#spaceythingy.y,
      z=CurrentMoon#moonPosition.velocity#spaceythingy.z + CurrentMoon#moonPosition.position#spaceythingy.z
      }
  }
.

applyGravityForOneMoon(AllMoonPositions) -> 
  F = fun(MoonToGravitate) ->
    print(MoonToGravitate),
    g(MoonToGravitate, AllMoonPositions)
  end,
  F
.

applyGravity(PositionRecords) -> 
  Partial = applyGravityForOneMoon(PositionRecords),
  print(Partial),
  lists:map(Partial, PositionRecords)
.

partOne() -> 
    Input = input(),
    print(Input),
    applyGravity(Input)
  .
