module Page.Page2 exposing (view)

import Html exposing (Html, div, h1, span, strong, text)
import Html.Attributes as Html exposing (class, classList)
import Page.Page exposing (Page(..), PageState(..))
import Transit exposing (Step(..))


view : Page -> Step -> PageState -> Html msg
view page step state =
    div
        [ class "pt-page pt-page-2"
        , classList
            [ ( "pt-page-current", page == Page2 )
            , ( "pt-page-moveFromRight", page == Page2 && step == Exit && state == Incoming )
            , ( "pt-page-moveToRight", page == Page2 && step == Exit && state == Outgoing )
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
