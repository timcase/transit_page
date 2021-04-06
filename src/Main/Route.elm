module Main.Route exposing
    ( Route(..)
    , backOne
    , href
    , match
    , modifyUrl
    , newUrl
    )

import Browser.Navigation as Navigation
import Html exposing (Attribute)
import Html.Attributes as Attr
import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), (<?>), Parser, s, string)


type Route
    = Page1
    | Page2
    | Page3
    | Page4
    | Page5
    | Page6


routes : Parser (Route -> a) a
routes =
    Parser.oneOf
        [ Parser.map Page1 Parser.top
        , Parser.map Page2 (s "page2")
        , Parser.map Page3 (s "page3")
        , Parser.map Page4 (s "page4")
        , Parser.map Page5 (s "page5")
        , Parser.map Page6 (s "page6")
        ]


routeToString : Route -> String
routeToString page =
    let
        pieces =
            case page of
                Page1 ->
                    [ "/" ]

                Page2 ->
                    [ "/page2" ]

                Page3 ->
                    [ "/page3" ]

                Page4 ->
                    [ "/page4" ]

                Page5 ->
                    [ "/page5" ]

                Page6 ->
                    [ "/page6" ]
    in
    String.join "/" pieces


href : Route -> Attribute msg
href route =
    Attr.href (routeToString route)


modifyUrl : Navigation.Key -> Route -> Cmd msg
modifyUrl navigationKey route =
    pushUrl navigationKey route


newUrl : Navigation.Key -> Route -> Cmd msg
newUrl navigationKey route =
    pushUrl navigationKey route


backOne : Navigation.Key -> Cmd msg
backOne navigationKey =
    Navigation.back navigationKey 1


pushUrl : Navigation.Key -> Route -> Cmd msg
pushUrl key route =
    Navigation.pushUrl key (routeToString route)


fromUrl : Url -> Maybe Route
fromUrl url =
    -- The RealWorld spec treats the fragment like a path.
    -- This makes it *literally* the path, so we can proceed
    -- with parsing as if it had been a normal path all along.
    { url | path = Maybe.withDefault "" url.fragment, fragment = Nothing }
        |> Parser.parse routes


match : Url -> Maybe Route
match url =
    Parser.parse routes url
