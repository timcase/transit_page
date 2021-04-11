module Page.Page1 exposing (view)

import Html exposing (Html, button, div, h1, span, strong, text)
import Html.Attributes as Html exposing (class, classList)
import Html.Events as Events exposing (onClick)
import Main.Route as Route exposing (Route)
import Page.Page exposing (Direction(..), Page(..), PageState(..))
import Transit exposing (Step(..))


view : Page -> Step -> PageState -> (Route -> m) -> Direction -> Html m
view page step state clickMsg direction =
    let
        -- _ =
        --     Debug.log "page" page
        _ =
            Debug.log "step" step

        _ =
            Debug.log "state" state

        _ =
            Debug.log "direction" direction
    in
    div []
        [ div [ class "pt-triggers" ]
            [ button
                [ onClick (clickMsg Route.Page2)
                , class "pt-touch-button"
                ]
                [ text "Go Forward" ]
            ]
        , div
            [ class "pt-page pt-page-1"
            , classList
                [ ( "pt-page-current", page == Page1 )
                , ( "pt-page-moveFromLeft"
                  , step == Exit && state == Incoming && direction == Backward
                  )
                , ( "pt-page-moveToLeft"
                  , step == Exit && state == Outgoing && direction == Forward
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
        ]
