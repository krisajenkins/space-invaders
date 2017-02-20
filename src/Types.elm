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


type alias Model =
    { ship : Ship }
