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

{-| Rich text editing using the contenteditable API.

# Widgets
@docs editor, editorWithOptions

# Attributes
@docs placeholder

# Events
@docs onInput, onBlur

# Options
@docs Options, defaultOptions
@docs ToolbarOptions, defaultToolbarOptions
-}

import Html exposing (Html, Attribute)
import Html.Attributes exposing (attribute)
import Html.Events exposing (on)
import Json.Decode as Decode exposing (Decoder)
import Native.MediumEditor


{-| Editor options

- toolbar: Customizes the editor's toolbar. Set this to `Nothing` to disable the
  toolbar altogether. Disabling the toolbar will also disable anchor previews.
-}
type alias Options =
    { toolbar : Maybe ToolbarOptions }


{-| Editor toolbar options
-}
type alias ToolbarOptions =
    {}


{-| Default editor options

- toolbar: The toolbar is enabled and set to
[the default options](#defaultToolbarOptions).
-}
defaultOptions : Options
defaultOptions =
    { toolbar = Just defaultToolbarOptions }


{-| Default toolbar options
-}
defaultToolbarOptions : ToolbarOptions
defaultToolbarOptions =
    {}


{-| Create an editor with [default options](#defaultOptions)
-}
editor : List (Attribute msg) -> String -> Html msg
editor =
    editorWithOptions defaultOptions


{-| Create an editor with custom options
-}
editorWithOptions : Options -> List (Attribute msg) -> String -> Html msg
editorWithOptions =
    Native.MediumEditor.editor


{-| Customize the editor's placeholder. The default is `Type your text`.
-}
placeholder : String -> Attribute msg
placeholder =
    attribute "data-placeholder"


{-| Sends an event with the editor's innerHTML on every input event.
-}
onInput : (String -> msg) -> Attribute msg
onInput =
    on "input" << sendInnerHTML


{-| Sends an event with the editor's innerHTML when the editor loses focus.
-}
onBlur : (String -> msg) -> Attribute msg
onBlur =
    on "blur" << sendInnerHTML


sendInnerHTML : (String -> msg) -> Decoder msg
sendInnerHTML send =
    Decode.string
        |> Decode.at [ "target", "innerHTML" ]
        |> Decode.map send
