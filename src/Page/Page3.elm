module Page.Page3 exposing (view)

import Html exposing (Html, button, div, h1, span, strong, text)
import Html.Attributes as Html exposing (class, classList)
import Html.Events as Events exposing (onClick)
import Main.Route as Route exposing (Route)
import Page.Page
    exposing
        ( Transition
        , animationClass
        )
import Transit exposing (Step(..))


view : (Route -> msg) -> Transition -> Html msg
view clickMsg transition =
    div []
        [ div [ class "pt-triggers" ]
            [ button
                [ onClick (clickMsg Route.Page4)
                , class "pt-touch-button"
                ]
                [ text "Go Forward" ]
            , button
                [ onClick (clickMsg Route.Page2)
                , class "pt-touch-button"
                ]
                [ text "Go back" ]
            ]
        , div
            [ class "pt-page pt-page-3 pt-page-current"
            , animationClass transition
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
