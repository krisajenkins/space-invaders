module View exposing (..)

import Html exposing (..)
import Types exposing (..)
import View.Svg


root : Model -> Html Msg
root model =
    div []
        [ View.Svg.root model
        , div [] [ code [] [ text <| toString model ] ]
        ]
