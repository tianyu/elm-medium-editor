module MediumEditor exposing (Options, editor, onChange)

import Html exposing (Html, Attribute)
import Html.Events exposing (on)
import Json.Decode as Json
import Native.MediumEditor


type alias Options =
    {}


editor : Options -> List (Attribute msg) -> String -> Html msg
editor =
    Native.MediumEditor.editor


onChange : (String -> msg) -> Attribute msg
onChange =
    on "input" << sendInnerHTML


sendInnerHTML : (String -> msg) -> Json.Decoder msg
sendInnerHTML send =
    Json.string
        |> Json.at [ "target", "innerHTML" ]
        |> Json.map send
