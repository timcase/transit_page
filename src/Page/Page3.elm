module Page.Page3 exposing (view)

import Html exposing (Html, button, div, h1, span, strong, text)
import Html.Attributes as Html exposing (class, classList)
import Html.Events as Events exposing (onClick)
import Main.Route as Route exposing (Route)
import Page.Page exposing (Direction(..), Page(..), PageState(..))
import Transit exposing (Step(..))


view : Page -> Step -> PageState -> (Route -> msg) -> Direction -> Html msg
view page step state clickMsg direction =
    div []
        [ div [ class "pt-triggers" ]
            [ button
                [ onClick (clickMsg Route.Page2)
                , class "pt-touch-button"
                ]
                [ text "Go back" ]
            , button
                [ onClick (clickMsg Route.Page4)
                , class "pt-touch-button"
                ]
                [ text "Go Forward" ]
            ]
        , div
            [ class "pt-page"
            , classList
                [ ( "pt-page-current", page == Page3 )
                , ( "pt-page-3", True )
                , ( "pt-page-moveFromRight"
                  , page == Page3 && step == Exit && state == Incoming && direction == Forward
                  )
                , ( "pt-page-moveToRight"
                  , page == Page3 && step == Exit && state == Outgoing && direction == Backward
                  )
                , ( "pt-page-moveFromLeft"
                  , page == Page3 && step == Exit && state == Incoming && direction == Backward
                  )
                , ( "pt-page-moveToLeft"
                  , page == Page3 && step == Exit && state == Outgoing && direction == Forward
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
        ]
