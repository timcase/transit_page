module Page.Page2 exposing (view)

import Html exposing (Html, div, h1, span, strong, text)
import Html.Attributes as Html exposing (class, classList)
import Page.Page exposing (Page(..))
import Transit exposing (Step(..))


view : Page -> Step -> Html msg
view page step =
    div
        [ class "pt-page pt-page-2"
        , classList
            [ ( "pt-page-current", page == Page2 )
            , ( "pt-page-current", page == Page1 && step == Exit )
            , ( "pt-page-moveFromRight", page == Page1 && step == Exit )
            , ( "pt-page-moveToRight", page == Page2 && step == Exit )
            ]
        ]
        [ h1 []
            [ span []
                [ text "A collection of" ]
            , strong []
                [ text "Page" ]
            , text "Transition 2"
            ]
        ]
