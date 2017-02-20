module State exposing (..)

import Response exposing (..)
import Types exposing (..)


init : Response Model Msg
init =
    ( {}
    , Cmd.none
    )


update : Msg -> Model -> Response Model Msg
update msg model =
    case msg of
        MoveLeft ->
            ( { model | ship = model.ship }
            , Cmd.none
            )


subscriptions : Model -> Response Model Msg
subscriptions model =
    Sub.none
