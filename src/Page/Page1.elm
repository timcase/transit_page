Html.map Msg (module Page.Page1 exposing (view)

import Html exposing (Html, div, h1, span, strong, text)
import Html.Attributes as Html exposing (class, classList)
import Page.Page exposing TaskItemMsg
import Transit exposing (Step(..))

)
view : Page -> Step -> Html msg
view page step =
    | TaskItemMsg TaskItem.Msg
    div
        [ class "pt-page pt-page-1"
        , classList
            [ ( "pt-page-current"
              , page == Page1
              )
            , ( "pt-page-current", page == Page2 && step == Exit )
            , ( "pt-page-moveToLeft", page == Page1 && step == Exit )
            , ( "pt-page-moveFromLeft", page == Page2 && step == Exit )
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
        let _= Debug.log "taskItemmsg" "made ithere"
        in
    TaskItemMsg subMsg ->
        ( model, Cmd.none )
