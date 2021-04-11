module Page.Page1 exposing (view)

import Html exposing (Html, button, div, h1, span, strong, text)
import Html.Attributes as Html exposing (class, classList)
import Html.Events as Events exposing (onClick)
import Main.Route as Route exposing (Route)
import Page.Page
    exposing
        ( Direction(..)
        , Page(..)
        , PageState(..)
        , animationClass
        )
import Transit exposing (Step(..))


view : Page -> Step -> PageState -> (Route -> m) -> Direction -> Html m
view page step state clickMsg direction =
    div []
        [ div [ class "pt-triggers" ]
            [ button
                [ onClick (clickMsg Route.Page2)
                , class "pt-touch-button"
                ]
                [ text "Go Forward" ]
            ]
        , div
            [ class "pt-page pt-page-1 pt-page-current"
            , animationClass step state direction
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
