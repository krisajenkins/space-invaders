module State exposing (..)

import Keyboard exposing (KeyCode)
import Response exposing (..)
import Types exposing (..)


init : Response Model Msg
init =
    ( { ship =
            { position =
                { x = 0
                , y = 0
                }
            }
      }
    , Cmd.none
    )


update : Msg -> Model -> Response Model Msg
update msg model =
    case msg of
        MoveLeft ->
            ( { model | ship = moveShip -10 model.ship }
            , Cmd.none
            )

        MoveRight ->
            ( { model | ship = moveShip 10 model.ship }
            , Cmd.none
            )

        Noop ->
            ( model
            , Cmd.none
            )


moveShip : Int -> Ship -> Ship
moveShip delta ship =
    let
        position =
            ship.position
    in
        { ship | position = { position | x = position.x + delta } }


subscriptions : Model -> Sub Msg
subscriptions model =
    Keyboard.presses readKey


readKey : KeyCode -> Msg
readKey keyCode =
    case Debug.log "KC" keyCode of
        97 ->
            MoveLeft

        100 ->
            MoveRight

        _ ->
            Noop
