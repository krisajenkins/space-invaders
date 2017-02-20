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
        , viewBox "-250 -450 500 500"
        ]
        [ circle
            [ cx <| toString model.ship.position.x
            , cy <| toString model.ship.position.y
            , r "10.0"
            , stroke "black"
            , fill "green"
            ]
            []
        ]
