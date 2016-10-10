module Example exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import MediumEditor as Medium


main : Program Never
main =
    App.beginnerProgram
        { model = ""
        , view = view
        , update = update
        }


type Msg
    = Update String


view : String -> Html Msg
view content =
    div [ class "container" ]
        [ Medium.editor {} [ Medium.onChange Update ] content
        , div [ class "echo" ] [ text content ]
        ]


update : Msg -> String -> String
update (Update message) =
    always message
