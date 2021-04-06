module Page.Page3 exposing (view)

import Html exposing (Html, div, h1, span, strong, text)
import Html.Attributes as Html exposing (class, classList)


view : Html msg
view =
    div
        [ class "pt-page pt-page-3"
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
            , text "Transition 3"
            ]
        ]
