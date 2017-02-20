module View.Svg exposing (..)

import Svg exposing (..)
import Svg.Attributes exposing (..)
import Types exposing (..)


root : Model -> Svg Msg
root model =
    svg
        [ width "500"
        , height "500"
        , viewBox "-2500 -4500 5000 5000"
        ]
        [ g []
            (List.map drawShot model.shots)
        , drawShip model.ship
        , g []
            (model.aliens
                |> List.filter .isAlive
                |> List.map drawAlien
            )
        ]


drawShip : Ship -> Svg Msg
drawShip ship =
    circle
        [ cx <| toString ship.position.x
        , cy <| toString ship.position.y
        , r <| toString shipSize
        , stroke "black"
        , fill "green"
        ]
        []


drawAlien : Alien -> Svg Msg
drawAlien alien =
    rect
        [ x <| toString <| alien.position.x - alienSize
        , y <| toString <| alien.position.y - alienSize
        , width <| toString alienSize
        , height <| toString alienSize
        , fill "red"
        ]
        []


drawShot : Shot -> Svg Msg
drawShot shot =
    rect
        [ x <| toString <| shot.position.x - shotWidth
        , y <| toString <| shot.position.y - shotHeight
        , width <| toString shotWidth
        , height <| toString shotHeight
        , fill "blue"
        ]
        []
