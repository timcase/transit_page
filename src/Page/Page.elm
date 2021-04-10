module Page.Page exposing
    ( Direction(..)
    , Page(..)
    , PageState(..)
    , pageDirection
    , routeToPage
    )

import Main.Route as Route exposing (Route)


type Page
    = Page1
    | Page2
    | Page3
    | Page4
    | Page5
    | Page6


type PageState
    = Current
    | Incoming
    | Outgoing


type Direction
    = Forward
    | Backward
    | None


routeToPage : Route -> Page
routeToPage route =
    case route of
        Route.Page1 ->
            Page1

        Route.Page2 ->
            Page2

        Route.Page3 ->
            Page3

        Route.Page4 ->
            Page4

        Route.Page5 ->
            Page5

        Route.Page6 ->
            Page6


pageDirection : Maybe Page -> Maybe Page -> Direction
pageDirection incomingPage outgoingPage =
    case ( incomingPage, outgoingPage ) of
        ( Just Page1, Just Page2 ) ->
            Backward

        ( Just Page2, Just Page3 ) ->
            Backward

        ( Just Page3, Just Page4 ) ->
            Backward

        ( Just Page4, Just Page5 ) ->
            Backward

        ( Just Page5, Just Page6 ) ->
            Backward

        ( Just Page2, Just Page1 ) ->
            Forward

        ( Just Page3, Just Page2 ) ->
            Forward

        ( Just Page4, Just Page3 ) ->
            Forward

        ( Just Page5, Just Page4 ) ->
            Forward

        ( Just Page6, Just Page5 ) ->
            Forward

        ( _, _ ) ->
            None
