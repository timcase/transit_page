module Page.Page4 exposing (view)

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
                [ onClick (clickMsg Route.Page3)
                , class "pt-touch-button"
                ]
                [ text "Go back" ]
            , button
                [ onClick (clickMsg Route.Page5)
                , class "pt-touch-button"
                ]
                [ text "Go Forward" ]
            ]
        , div
            [ class "pt-page pt-page-4"
            , classList
                [ ( "pt-page-current", page == Page4 )
                , ( "pt-page-moveFromRight"
                  , page
                        == Page4
                        && step
                        == Exit
                        && state
                        == Incoming
                        && direction
                        == Forward
                  )
                , ( "pt-page-moveToRight"
                  , page == Page4 && step == Exit && state == Outgoing && direction == Backward
                  )
                , ( "pt-page-moveFromLeft"
                  , page == Page4 && step == Exit && state == Incoming && direction == Backward
                  )
                , ( "pt-page-moveToLeft"
                  , page == Page4 && step == Exit && state == Outgoing && direction == Forward
                  )
                ]
            ]
            [ h1 []
                [ span []
                    [ text "A collection of" ]
                , strong []
                    [ text "Page" ]
                , text "Transition 4"
                ]
            ]
        ]
