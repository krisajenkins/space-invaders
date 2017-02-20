module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


root : Model -> Html Msg
root model =
    div [] [ code [] [ text <| toString model ] ]
