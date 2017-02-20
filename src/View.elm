module View exposing (..)

import Html exposing (..)
import Types exposing (..)
import View.Svg


root : Model -> Html Msg
root model =
    if model.ship.isAlive then
        View.Svg.root model
    else
        h1 [] [ text "Y U NO ALIVE???" ]
