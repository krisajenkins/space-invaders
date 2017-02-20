module View exposing (..)

import Html exposing (..)
import Types exposing (..)
import View.Svg


root : Model -> Html Msg
root model =
    if List.isEmpty model.aliens then
        h1 [] [ text "EM DEAD" ]
    else if model.ship.isAlive then
        View.Svg.root model
    else
        h1 [] [ text "Y U NO ALIVE???" ]
