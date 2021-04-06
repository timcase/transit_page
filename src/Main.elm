module Main exposing (Model, Msg(..), Page(..), init, main, subscriptions, update, view)

import Browser exposing (UrlRequest)
import Browser.Navigation as Navigation
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Main.Route as Route exposing (Route)
import Transit exposing (Step(..))
import Url exposing (Url)


type alias Model =
    Transit.WithTransition { page : Page }


type Page
    = Page1
    | Page2
    | Page3
    | Page4
    | Page5
    | Page6


type Msg
    = Click Page
    | SetPage Page
    | TransitMsg (Transit.Msg Msg)
    | ClickedLink UrlRequest
    | SetRoute (Maybe Route)


type alias Flags =
    {}


init : Flags -> Url -> Navigation.Key -> ( Model, Cmd Msg )
init flags url navKey =
    ( { page = Page1, transition = Transit.empty }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Click page ->
            Transit.start TransitMsg (SetPage page) ( 600, 600 ) model

        SetPage page ->
            ( { model | page = page }, Cmd.none )

        TransitMsg transitMsg ->
            Transit.tick TransitMsg transitMsg model

        _ ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div [ class "body" ]
        [ div [ class "pt-triggers" ]
            [ button [ onClick (Click Page1), class "pt-touch-button", id "iterateEffects" ]
                [ text "To Page 1" ]
            , button [ onClick (Click Page2), class "pt-touch-button", id "iterateEffects" ]
                [ text "To Page 2" ]
            , text (stepToString (Transit.getStep model.transition))
            ]
        , div [ class "pt-perspective", id "pt-main" ]
            [ div
                [ class "pt-page pt-page-1"
                , classList
                    [ ( "pt-page-current"
                      , model.page == Page1
                      )
                    , ( "pt-page-current", model.page == Page2 && Transit.getStep model.transition == Exit )
                    , ( "pt-page-moveToLeft", model.page == Page1 && Transit.getStep model.transition == Exit )
                    , ( "pt-page-moveFromLeft", model.page == Page2 && Transit.getStep model.transition == Exit )
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
            , div
                [ class "pt-page pt-page-2"
                , classList
                    [ ( "pt-page-current", model.page == Page2 )
                    , ( "pt-page-current", model.page == Page1 && Transit.getStep model.transition == Exit )
                    , ( "pt-page-moveFromRight", model.page == Page1 && Transit.getStep model.transition == Exit )
                    , ( "pt-page-moveToRight", model.page == Page2 && Transit.getStep model.transition == Exit )
                    ]
                ]
                [ h1 []
                    [ span []
                        [ text "A collection of" ]
                    , strong []
                        [ text "Page" ]
                    , text "Transition 2"
                    ]
                ]
            , div [ class "pt-page pt-page-3" ]
                [ h1 []
                    [ span []
                        [ text "A collection of" ]
                    , strong []
                        [ text "Page" ]
                    , text "Transitions"
                    ]
                ]
            , div [ class "pt-page pt-page-4" ]
                [ h1 []
                    [ span []
                        [ text "A collection of" ]
                    , strong []
                        [ text "Page" ]
                    , text "Transitions"
                    ]
                ]
            , div [ class "pt-page pt-page-5" ]
                [ h1 []
                    [ span []
                        [ text "A collection of" ]
                    , strong []
                        [ text "Page" ]
                    , text "Transitions"
                    ]
                ]
            , div [ class "pt-page pt-page-6" ]
                [ h1 []
                    [ span []
                        [ text "A collection of" ]
                    , strong []
                        [ text "Page" ]
                    , text "Transitions"
                    ]
                ]
            ]
        , div [ class "pt-message" ]
            [ p []
                [ text "Your browser does not support CSS animations." ]
            ]
        , node "script"
            [ src "https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js" ]
            []
        , node "script"
            [ src "js/jquery.dlmenu.js" ]
            []
        , node "script"
            [ src "js/pagetransitions.js" ]
            []
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
