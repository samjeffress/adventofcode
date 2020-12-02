import Debug.Trace

data Position = Position {x :: Int, y :: Int, z :: Int} deriving (Show)
data Velocity = Velocity {xv :: Int, yv :: Int, zv :: Int} deriving (Show)
data MoonPosition = MoonPosition { name :: String
                                 , position :: Position
                                 , velocity :: Velocity
                                 } deriving (Show)

energyOfMoon :: MoonPosition -> Int
energyOfMoon moon = do
  let kinetic = (abs (xv (velocity moon))) + (abs (yv (velocity moon))) + (abs (zv (velocity moon)))
  let potential = (abs (x (position moon))) + (abs (y (position moon))) + (abs (z (position moon)))
  (kinetic * potential)

initialVelocity :: Velocity
initialVelocity =  Velocity { xv = 0, yv = 0, zv = 0 }


initialMoons :: [MoonPosition]
initialMoons = 
    [ MoonPosition { name="Io", position= Position { x =16, y=(-11), z=(2)}, velocity = initialVelocity}
    , MoonPosition { name="Europa", position= Position { x =0, y=(-4), z=7}, velocity = initialVelocity}
    , MoonPosition { name="Ganymede", position= Position { x =6, y=4, z=(10)}, velocity= initialVelocity}
    , MoonPosition { name="Callisto", position= Position { x =(-3), y=(-2), z=(-4)}, velocity = initialVelocity}
    ]
    
testMoons :: [MoonPosition]
testMoons = 
    [ MoonPosition { name="Io", position= Position { x =(-8), y=(-10), z=(0)}, velocity = initialVelocity}
    , MoonPosition { name="Europa", position= Position { x =5, y=(5), z=(10)}, velocity = initialVelocity}
    , MoonPosition { name="Ganymede", position= Position { x =2, y=(-7), z=(3)}, velocity= initialVelocity}
    , MoonPosition { name="Callisto", position= Position { x =(9), y=(-8), z=(-3)}, velocity = initialVelocity}
    ]

-- testMoons :: [MoonPosition]
-- testMoons = 
--     [ MoonPosition { name="Io", position= Position { x =(-1), y=(0), z=(2)}, velocity = initialVelocity}
--     , MoonPosition { name="Europa", position= Position { x =2, y=(-10), z=(-7)}, velocity = initialVelocity}
--     , MoonPosition { name="Ganymede", position= Position { x =4, y=(-8), z=(8)}, velocity= initialVelocity}
--     , MoonPosition { name="Callisto", position= Position { x =(3), y=(5), z=(-1)}, velocity = initialVelocity}
--     ]
    

-- progress time
--update velocity (apply gravity)

compareAxisPosition :: Int -> Int -> Int
compareAxisPosition primaryMoonPosition secondaryMoonPosition
  | diff > 0 = (-1)
  | diff < 0 = 1
  | otherwise = 0
  where diff = primaryMoonPosition - secondaryMoonPosition

velocityFromTwoPositions :: Position -> Position -> Velocity
velocityFromTwoPositions primaryPosition secondaryPosition =
  Velocity {
    xv = compareAxisPosition (x primaryPosition) (x secondaryPosition),
    yv = compareAxisPosition (y primaryPosition) (y secondaryPosition),
    zv = compareAxisPosition (z primaryPosition) (z secondaryPosition)
  }

velocityFromTwoMoons :: MoonPosition -> MoonPosition -> Velocity
velocityFromTwoMoons primaryMoon secondaryMoon =
  velocityFromTwoPositions (position primaryMoon) (position secondaryMoon)

combinedVelocities :: [Velocity] -> Velocity
combinedVelocities relativeVelocities =
  Velocity { 
    xv = foldr (+) 0 (map xv relativeVelocities), -- fold all values of xv from relativeVelocities
    yv = foldr (+) 0 (map yv relativeVelocities), -- fold all values of xv from relativeVelocities
    zv = foldr (+) 0 (map zv relativeVelocities) -- fold all values of xv from relativeVelocities
  }

oneCycleOfGravity :: MoonPosition -> [MoonPosition] -> MoonPosition
oneCycleOfGravity mainMoon otherMoons = 
  MoonPosition { 
    name= name mainMoon, 
    position= Position 
    { 
      x = sum [x (position mainMoon), xv updatedVelocity, xv (velocity mainMoon)],
      y=  sum [y (position mainMoon), yv updatedVelocity, yv (velocity mainMoon)],
      z=  sum [z (position mainMoon), zv updatedVelocity, zv (velocity mainMoon)]
    }, 
    velocity = combinedVelocities([velocity mainMoon, updatedVelocity])
  }
  -- TODO: Add the preexisting velocity of the moon
  where updatedVelocity = combinedVelocities (map (velocityFromTwoMoons mainMoon) otherMoons) 

oneCycleOfGravityForAll :: [MoonPosition] -> [MoonPosition]
oneCycleOfGravityForAll (io:europa:ganymede:callisto:_) = [
    oneCycleOfGravity io [europa, ganymede, callisto],
    oneCycleOfGravity europa [io, ganymede, callisto],
    oneCycleOfGravity ganymede [io, europa, callisto],
    oneCycleOfGravity callisto [io, europa, ganymede]
  ]
oneCycleOfGravityForAll _ = []


runRound :: Int -> [MoonPosition] -> [MoonPosition]
runRound 100 moonPositions = do
    -- let finalPositions = oneCycleOfGravityForAll moonPositions
    -- let energies = map energyOfMoon finalPositions
    let energies = map energyOfMoon moonPositions
    let totalEnergy = sum energies
    trace (show totalEnergy) "hi"
    -- finalPositions
    moonPositions
runRound x moonPositions = 
  trace ("round " ++ show x)
  trace (show moonPositions)
    runRound (x + 1) (oneCycleOfGravityForAll moonPositions)


run :: [MoonPosition]
run = runRound 0 testMoons