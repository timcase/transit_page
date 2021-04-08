module Update.Extra exposing (andThen)

{-| Allows update call composition. Can be used with the pipeline operator (|>)
to chain updates.

For example:

    update msg model =
      ( model, Cmd.none )
        |> andThen update SomeMessage
        |> andThen update SomeOtherMessage
        |> andThen update (MessageWithArguments "Hello")
        ...

-}


andThen : (msg -> model -> ( model, Cmd a )) -> msg -> ( model, Cmd a ) -> ( model, Cmd a )
andThen update msg ( model, cmd ) =
    let
        ( model_, cmd_ ) =
            update msg model
    in
    ( model_, Cmd.batch [ cmd, cmd_ ] )
