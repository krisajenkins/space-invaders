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
