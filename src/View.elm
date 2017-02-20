module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)
import View.Svg


root : Model -> Html Msg
root model =
    div []
        [ code [] [ text <| toString model ]
        , View.Svg.root model
        ]
