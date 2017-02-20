module Types exposing (..)

import Time exposing (Time)


type Msg
    = MoveLeft
    | MoveRight
    | Tick Time
    | Fire
    | Noop


type alias Position =
    { x : Int
    , y : Int
    }


type alias Ship =
    { position : Position }


type alias Alien =
    { position : Position
    , isAlive : Bool
    }


type alias Shot =
    { position : Position
    , direction : Position
    , isAlive : Bool
    }


type alias Model =
    { ship : Ship
    , aliens : List Alien
    , shots : List Shot
    }


shipSize : Int
shipSize =
    100


alienSize : Int
alienSize =
    180


shotWidth : Int
shotWidth =
    20


shotHeight : Int
shotHeight =
    180


perRow : Int
perRow =
    10


wavePosition : Int -> Position
wavePosition n =
    { x = (n % perRow)
    , y = (n // perRow)
    }


scale : Position -> Position -> Position
scale d { x, y } =
    { x = x * d.x
    , y = y * d.y
    }


translate : Position -> Position -> Position
translate d { x, y } =
    { x = x + d.x
    , y = y + d.y
    }


move : Position -> { a | position : Position } -> { a | position : Position }
move delta thing =
    let
        position =
            thing.position
    in
        { thing | position = translate delta position }


moveShot : Shot -> Shot
moveShot shot =
    { shot | position = translate shot.direction shot.position }
