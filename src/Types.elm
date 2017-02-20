module Types exposing (..)


type Msg
    = MoveLeft
    | MoveRight
    | Noop


type alias Position =
    { x : Int
    , y : Int
    }


type alias Ship =
    { position : Position }


type alias Model =
    { ship : Ship }
