module Main exposing (Model, Msg(..), init, main, subscriptions, update, view)

import Browser exposing (UrlRequest)
import Browser.Navigation as Navigation
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Main.Route as Route exposing (Route)
import Page.Page
    exposing
        ( Direction(..)
        , Page(..)
        , PageState(..)
        , pageDirection
        )
import Page.Page1
import Page.Page2
import Page.Page3
import Page.Page4
import Page.Page5
import Page.Page6
import Transit exposing (Step(..))
import Update.Extra exposing (andThen)
import Url exposing (Url)


type alias Model =
    Transit.WithTransition
        { page : Maybe Page
        , outgoingPage : Maybe Page
        , incomingPage : Maybe Page
        }


type Msg
    = Click Page
    | SetPage Page
    | TransitMsg (Transit.Msg Msg)
    | ClickedLink UrlRequest
    | SetRoute (Maybe Route)
    | StartTransit Page


type alias Flags =
    {}


init : Flags -> Url -> Navigation.Key -> ( Model, Cmd Msg )
init flags url navKey =
    ( { page = Just Page1
      , outgoingPage = Nothing
      , incomingPage = Nothing
      , transition = Transit.empty
      }
    , Cmd.none
    )



--setRoute : Maybe Route -> Model -> ( Model, Cmd Msg )
--setRoute maybeRoute model =
--    case maybeRoute of
--        Nothing ->
--            ( model, Cmd.none )
--        Just Route.Page1 ->
--            --forward or back
--            ( { model | page = Just Page1 }, Cmd.none )
--        Just Route.Page2 ->
--            ( { model | page = Just Page2 }, Cmd.none )
--        Just Route.Page3 ->
--            ( { model | page = Just Page3 }, Cmd.none )
--        Just Route.Page4 ->
--            ( { model | page = Just Page4 }, Cmd.none )
--        Just Route.Page5 ->
--            ( { model | page = Just Page5 }, Cmd.none )
--        Just Route.Page6 ->
--            ( { model | page = Just Page6 }, Cmd.none )
-- page 1 page 2
-- page 1 is outgoing page direction is forward
-- page 2 is incoming page direction is forward
-- page 2 page 1
-- page 2 is outgoing page direciton is backwar
-- page 1 is incoming page direciton is backward
-- page 2 page 3
-- page 2 is outgoing page direction is forward
-- page 3 is incomig page direction is forward


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        StartTransit page ->
            Transit.start TransitMsg (SetPage page) ( 600, 600 ) model

        Click page ->
            ( { model
                | page = Nothing
                , incomingPage = Just page
                , outgoingPage = model.page
              }
            , Cmd.none
            )
                |> andThen update (StartTransit page)

        SetPage page ->
            ( { model
                | page = Just page
                , incomingPage = Nothing
                , outgoingPage = Nothing
              }
            , Cmd.none
            )

        TransitMsg transitMsg ->
            Transit.tick TransitMsg transitMsg model

        _ ->
            ( model, Cmd.none )


viewPage : Maybe Page -> Step -> PageState -> Direction -> Html Msg
viewPage page step state direction =
    case page of
        Just Page1 ->
            Page.Page1.view Page1 step state Click direction

        Just Page2 ->
            Page.Page2.view Page2 step state Click direction

        Just Page3 ->
            Page.Page3.view Page3 step state Click direction

        Just Page4 ->
            Page.Page4.view Page4 step state Click direction

        Just Page5 ->
            Page.Page5.view Page5 step state Click direction

        Just Page6 ->
            Page.Page6.view Page6 step state Click direction

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
        [ div [ class "pt-triggers" ]
            [ text (stepToString (Transit.getStep model.transition))
            ]
        , div [ class "pt-perspective", id "pt-main" ]
            [ viewPage page step Current None
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



-- helper


stepToString : Step -> String
stepToString step =
    case step of
        Exit ->
            "Exit"

        Enter ->
            "Enter"

        Done ->
            "Done"


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
