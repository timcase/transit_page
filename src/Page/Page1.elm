module Page.Page1 exposing (view)

import Html exposing (Html, div, h1, span, strong, text)
import Html.Attributes as Html exposing (class, classList)


view : Html msg
view =
    div
        [ class "pt-page pt-page-1"
        , classList
            [ ( "pt-page-current"
              , False
              )
            ]
        ]
        [ h1 []
            [ span []
                [ text "A collection of" ]
            , strong []
                [ text "Page" ]
            , text "Transition 1"
            ]
        ]
