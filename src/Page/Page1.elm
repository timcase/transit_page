module Page.Page1 exposing (view)

import Html exposing (Html, a, button, div, h1, span, strong, text)
import Html.Attributes as Html exposing (class, classList)
import Html.Events as Events exposing (onClick)
import Main.Route as Route exposing (Route)
import Page.Page
    exposing
        ( Transition
        , animationClass
        )
import Transit exposing (Step(..))


view : (Route -> m) -> Transition -> Html m
view clickMsg transition =
    div []
        [ div [ class "pt-triggers" ]
            [ button
                [ onClick (clickMsg Route.Page2)
                , class "pt-touch-button"
                ]
                [ text "Go Forward" ]
            , a [ Route.href Route.Page2 ] [ text "Page 2" ]
            ]
        , div
            [ class "pt-page pt-page-1 pt-page-current"
            , animationClass transition
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
