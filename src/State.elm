module State exposing (..)

import AnimationFrame
import Keyboard exposing (KeyCode)
import Response exposing (..)
import Types exposing (..)


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


initAlien : Position -> Alien
initAlien position =
    { position = position
    , isAlive = True
    }


init : Response Model Msg
init =
    ( { ship =
            { position =
                { x = 0
                , y = 0
                }
            }
      , aliens =
            (List.range 0 20)
                |> List.map wavePosition
                |> List.map (scale { x = 400, y = 300 })
                |> List.map (translate { x = -2000, y = -4000 })
                |> List.map initAlien
      , shots = []
      }
    , Cmd.none
    )


update : Msg -> Model -> Response Model Msg
update msg model =
    case msg of
        MoveLeft ->
            ( { model | ship = move { x = -10, y = 0 } model.ship }
            , Cmd.none
            )

        MoveRight ->
            ( { model | ship = move { x = 10, y = 0 } model.ship }
            , Cmd.none
            )

        Tick delta ->
            ( { model | aliens = List.map (move { x = 0, y = 1 }) model.aliens }
            , Cmd.none
            )

        Noop ->
            ( model
            , Cmd.none
            )


move : Position -> { a | position : Position } -> { a | position : Position }
move delta thing =
    let
        position =
            thing.position
    in
        { thing | position = translate delta position }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Keyboard.presses readKey
        , AnimationFrame.diffs Tick
        ]


readKey : KeyCode -> Msg
readKey keyCode =
    case keyCode of
        97 ->
            MoveLeft

        100 ->
            MoveRight

        _ ->
            Noop
