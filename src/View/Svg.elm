module View.Svg exposing (..)

import Svg exposing (..)
import Svg.Attributes exposing (..)
import Svg.Events exposing (..)
import Types exposing (..)


root : Model -> Svg Msg
root model =
    svg
        [ width "500"
        , height "500"
        , viewBox "-2500 -4500 5000 5000"
        ]
        [ drawShip model.ship
        , g []
            (List.map drawAlien model.aliens)
        ]


drawShip : Ship -> Svg Msg
drawShip ship =
    let
        size =
            100
    in
        circle
            [ cx <| toString ship.position.x
            , cy <| toString ship.position.y
            , r <| toString size
            , stroke "black"
            , fill "green"
            ]
            []


drawAlien : Alien -> Svg Msg
drawAlien alien =
    let
        size =
            180
    in
        rect
            [ x <| toString <| alien.position.x - size
            , y <| toString <| alien.position.y - size
            , width <| toString size
            , height <| toString size
            , fill "red"
            ]
            []
