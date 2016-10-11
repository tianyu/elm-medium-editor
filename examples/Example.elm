module Example exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Lazy exposing (..)
import MediumEditor as Medium


main : Program Never
main =
    App.beginnerProgram
        { model = List.repeat 100 "" |> List.indexedMap (,)
        , view = view
        , update = update
        }


type alias Model =
    List ( Int, String )


type Msg
    = Update Int String


view : Model -> Html Msg
view model =
    List.map2
        (\data example -> example data)
        model
        examples
        |> div
            [ style
                [ "display" => "flex"
                , "flex-direction" => "column"
                , "align-items" => "center"
                ]
            ]


examples : List (( Int, String ) -> Html Msg)
examples =
    List.map (example >> lazy)
        [ \send ->
            "Update onInput"
                => Medium.editor [ Medium.onInput send ]
        , \send ->
            "Update onBlur"
                => Medium.editor [ Medium.onBlur send ]
        , \send ->
            "With dimensions (width & min-height)"
                => Medium.editor
                    [ Medium.onInput send
                    , style [ "width" => "30em", "min-height" => "10ex" ]
                    ]
        , \send ->
            "Custom placeholder"
                => Medium.editor
                    [ Medium.onInput send
                    , Medium.placeholder "Custom placeholder!"
                    ]
        , \send ->
            "Toolbar disabled"
                => Medium.editorWithOptions
                    { toolbar = Nothing }
                    [ Medium.onInput send ]
        ]


example : ((String -> Msg) -> ( String, String -> Html Msg )) -> ( Int, String ) -> Html Msg
example render ( index, content ) =
    let
        ( description, editor ) =
            render (Update index)
    in
        div [ style [ "min-width" => "60em" ] ]
            [ h2 []
                [ text description ]
            , div
                [ style
                    [ "display" => "flex"
                    , "justify-content" => "space-around"
                    ]
                ]
                [ editor content
                , div [] [ text content ]
                ]
            ]


update : Msg -> Model -> Model
update (Update index content) =
    List.map
        (\tuple ->
            if (fst tuple == index) then
                ( index, content )
            else
                tuple
        )


(=>) : a -> b -> ( a, b )
(=>) =
    (,)
