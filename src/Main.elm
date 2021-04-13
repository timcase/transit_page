module Main exposing (Model, Msg(..), init, main, subscriptions, update, view)

import Browser exposing (UrlRequest)
import Browser.Navigation as Navigation
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Main.Route as Route exposing (Route)
import Page.Page as Page
    exposing
        ( Direction(..)
        , Page(..)
        , PageState(..)
        , Transition(..)
        , pageDirection
        , routeToPage
        )
import Page.Page1
import Page.Page2
import Page.Page3
import Page.Page4
import Page.Page5
import Page.Page6
import Transit exposing (Step(..), Transition)
import Update.Extra exposing (andThen)
import Url exposing (Url)


type alias Model =
    { page : Page
    , outgoingPage : Maybe Page
    , incomingPage : Maybe Page
    , navKey : Navigation.Key
    , useTransitions : Bool
    , transition : Transition
    }


type Msg
    = Click Page
    | SetPage Page
    | TransitMsg (Transit.Msg Msg)
    | ClickedLink UrlRequest
    | SetRoute (Maybe Route)
    | StartTransit Page
    | GoTo Route
    | GoBack


type alias Flags =
    {}


init : Flags -> Url -> Navigation.Key -> ( Model, Cmd Msg )
init flags url navKey =
    setRoute
        (Route.match url)
        { page = Page1
        , outgoingPage = Nothing
        , incomingPage = Nothing
        , transition = Transit.empty
        , navKey = navKey
        , useTransitions = True
        }


setRoute : Maybe Route -> Model -> ( Model, Cmd Msg )
setRoute maybeRoute model =
    case maybeRoute of
        Nothing ->
            ( model, Cmd.none )

        Just Route.Page1 ->
            ( { model
                | page = Page1
                , incomingPage = Just Page1
                , outgoingPage = Just model.page
              }
            , Cmd.none
            )
                |> andThen update (StartTransit Page1)

        Just Route.Page2 ->
            ( { model
                | page = Page2
                , incomingPage = Just Page2
                , outgoingPage = Just model.page
              }
            , Cmd.none
            )
                |> andThen update (StartTransit Page2)

        Just Route.Page3 ->
            ( { model
                | page = Page3
                , incomingPage = Just Page3
                , outgoingPage = Just model.page
              }
            , Cmd.none
            )
                |> andThen update (StartTransit Page3)

        Just Route.Page4 ->
            ( { model
                | page = Page4
                , incomingPage = Just Page4
                , outgoingPage = Just model.page
              }
            , Cmd.none
            )
                |> andThen update (StartTransit Page4)

        Just Route.Page5 ->
            ( { model
                | page = Page5
                , incomingPage = Just Page5
                , outgoingPage = Just model.page
              }
            , Cmd.none
            )
                |> andThen update (StartTransit Page5)

        Just Route.Page6 ->
            ( { model
                | page = Page6
                , incomingPage = Just Page6
                , outgoingPage = Just model.page
              }
            , Cmd.none
            )
                |> andThen update (StartTransit Page6)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        StartTransit page ->
            case model.useTransitions of
                True ->
                    Transit.start TransitMsg (SetPage page) ( 600, 600 ) model

                False ->
                    ( model, Cmd.none )
                        |> andThen update (SetPage page)

        SetRoute maybeRoute ->
            setRoute maybeRoute model

        ClickedLink urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Navigation.pushUrl model.navKey (Url.toString url) )

                Browser.External href ->
                    case href of
                        "" ->
                            ( model, Cmd.none )

                        _ ->
                            ( model, Navigation.load href )

        Click page ->
            ( { model
                | incomingPage = Just page
                , outgoingPage = Just model.page
              }
            , Cmd.none
            )
                |> andThen update (StartTransit page)

        GoBack ->
            ( model, Cmd.none )

        GoTo route ->
            ( model, Route.newUrl model.navKey route )

        SetPage page ->
            ( { model
                | page = page
                , incomingPage = Nothing
                , outgoingPage = Nothing
              }
            , Cmd.none
            )

        TransitMsg transitMsg ->
            Transit.tick TransitMsg transitMsg model


viewPage : Maybe Page -> Step -> PageState -> Direction -> Html Msg
viewPage page step state direction =
    let
        transition =
            Transition step state direction
    in
    case page of
        Just Page1 ->
            Page.Page1.view GoTo transition

        Just Page2 ->
            Page.Page2.view GoTo transition

        Just Page3 ->
            Page.Page3.view GoTo transition

        Just Page4 ->
            Page.Page4.view GoTo transition

        Just Page5 ->
            Page.Page5.view GoTo transition

        Just Page6 ->
            Page.Page6.view GoTo transition

        Nothing ->
            span [] []


view : Model -> Html Msg
view model =
    let
        { page, incomingPage, outgoingPage } =
            model

        step =
            Transit.getStep model.transition
    in
    div [ class "body" ]
        [ div [ class "pt-perspective", id "pt-main" ]
            [ viewPage (Just page) step Current None
            , viewPage incomingPage step Incoming (pageDirection incomingPage outgoingPage)
            , viewPage outgoingPage step Outgoing (pageDirection incomingPage outgoingPage)
            ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Transit.subscriptions TransitMsg model


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , view =
            \m ->
                { title = "Transit demo"
                , body = [ view m ]
                }
        , subscriptions = subscriptions
        , onUrlChange = Route.match >> SetRoute
        , onUrlRequest = ClickedLink
        }


pageToString : Page -> String
pageToString page =
    case page of
        Page1 ->
            "Page1"

        Page2 ->
            "Page2"

        Page3 ->
            "Page3"

        Page4 ->
            "Page4"

        Page5 ->
            "Page5"

        Page6 ->
            "Page 6"
