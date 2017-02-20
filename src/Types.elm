module Types exposing (..)

import Time exposing (Time)


type Msg
    = MoveLeft
    | MoveRight
    | Tick Time
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
    }


type alias Model =
    { ship : Ship
    , aliens : List Alien
    , shots : List Shot
    }
