module MediumEditor
    exposing
        ( Options
        , ToolbarOptions
        , editor
        , editorWithOptions
        , defaultOptions
        , defaultToolbarOptions
        , placeholder
        , onInput
        , onBlur
        )

import Html exposing (Html, Attribute)
import Html.Attributes exposing (attribute)
import Html.Events exposing (on)
import Json.Decode as Decode exposing (Decoder)
import Native.MediumEditor


type alias Options =
    { toolbar : Maybe ToolbarOptions }


type alias ToolbarOptions =
    {}


defaultOptions : Options
defaultOptions =
    { toolbar = Just defaultToolbarOptions }


defaultToolbarOptions : ToolbarOptions
defaultToolbarOptions =
    {}


editor : List (Attribute msg) -> String -> Html msg
editor =
    editorWithOptions defaultOptions


editorWithOptions : Options -> List (Attribute msg) -> String -> Html msg
editorWithOptions =
    Native.MediumEditor.editor


placeholder : String -> Attribute msg
placeholder =
    attribute "data-placeholder"


onInput : (String -> msg) -> Attribute msg
onInput =
    on "input" << sendInnerHTML


onBlur : (String -> msg) -> Attribute msg
onBlur =
    on "blur" << sendInnerHTML


sendInnerHTML : (String -> msg) -> Decoder msg
sendInnerHTML send =
    Decode.string
        |> Decode.at [ "target", "innerHTML" ]
        |> Decode.map send
