module Main.Route exposing
    ( Route(..)
    , Slug
    , Uuid
    , backOne
    , href
    , match
    , modifyUrl
    , newUrl
    )

import Browser.Navigation as Navigation
import Data.User as User
import Html exposing (Attribute)
import Html.Attributes as Attr
import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), (<?>), Parser, s, string)
import Url.Parser.Query as Query


type Route
    = Home
    | Contexts
    | Context Slug
    | ForgotPassword
    | Login
    | Logout
    | NewTask
    | EditContext Slug
    | Projects
    | Search
    | Signup
    | Settings
    | Tags
    | HomeTask Uuid
    | Task Uuid
    | Tag Slug
    | VirtualTag Slug
    | ChangePassword User.PasswordResetToken
    | ChangePasswordWithoutToken
    | NewContext
    | Project Slug
    | ProjectNewTask Slug
    | TagNewTask Slug
    | ProjectTask Slug Uuid
    | ProjectTaskEdit Slug Uuid
    | TagTask Slug Uuid
    | VirtualTagTask Slug Uuid
    | TagTaskEdit Slug Uuid
    | VirtualTagTaskEdit Slug Uuid
    | HomeTaskEdit Uuid
    | Discourse (Maybe String) (Maybe String)
    | SkipToMain


type alias Slug =
    String


type alias Uuid =
    String


routes : Parser (Route -> a) a
routes =
    Parser.oneOf
        [ Parser.map Home Parser.top
        , Parser.map Login (s "login")
        , Parser.map Logout (s "logout")
        , Parser.map Signup (s "signup")
        , Parser.map ForgotPassword (s "forgot_password")
        , Parser.map ChangePassword (s "change_password" </> string)
        , Parser.map ChangePasswordWithoutToken (s "change_password")
        , Parser.map Discourse (s "discourse" <?> Query.string "sso" <?> Query.string "sig")
        , Parser.map Projects (s "projects")
        , Parser.map Project (s "projects" </> string)
        , Parser.map ProjectNewTask (s "projects" </> string </> s "tasks" </> s "new")
        , Parser.map Settings (s "settings")
        , Parser.map Tags (s "tags")
        , Parser.map Tag (s "tags" </> string)
        , Parser.map TagNewTask (s "tags" </> string </> s "tasks" </> s "new")
        , Parser.map VirtualTag (s "virtual_tags" </> string)
        , Parser.map Contexts (s "contexts")
        , Parser.map NewContext (s "contexts" </> s "new")
        , Parser.map Context (s "contexts" </> string)
        , Parser.map EditContext (s "contexts" </> string </> s "edit")
        , Parser.map Search (s "search")
        , Parser.map NewTask (s "tasks" </> s "new")
        , Parser.map HomeTask (s "tasks" </> string)
        , Parser.map Task (s "tasks" </> string)
        , Parser.map ProjectTask (s "projects" </> string </> s "tasks" </> string)
        , Parser.map TagTask (s "tags" </> string </> s "tasks" </> string)
        , Parser.map VirtualTagTask (s "virtual_tags" </> string </> s "tasks" </> string)
        , Parser.map HomeTaskEdit (s "tasks" </> string </> s "edit")
        , Parser.map ProjectTaskEdit (s "projects" </> string </> s "tasks" </> string </> s "edit")
        , Parser.map TagTaskEdit (s "tags" </> string </> s "tasks" </> string </> s "edit")
        , Parser.map VirtualTagTaskEdit (s "virtual_tags" </> string </> s "tasks" </> string </> s "edit")
        ]


routeToString : Route -> String
routeToString page =
    let
        pieces =
            case page of
                SkipToMain ->
                    [ "#main" ]

                Home ->
                    [ "/" ]

                Signup ->
                    [ "/signup" ]

                Login ->
                    [ "/login" ]

                Logout ->
                    [ "/logout" ]

                Settings ->
                    [ "/settings" ]

                ForgotPassword ->
                    [ "/forgot_password" ]

                ChangePassword str ->
                    [ "/change_password", str ]

                ChangePasswordWithoutToken ->
                    [ "/change_password" ]

                Projects ->
                    [ "/projects" ]

                Project str ->
                    [ "/projects", str ]

                ProjectNewTask str ->
                    [ "/projects", str, "tasks", "new" ]

                Tags ->
                    [ "/tags" ]

                Tag str ->
                    [ "/tags", str ]

                TagNewTask str ->
                    [ "/tags", str, "tasks", "new" ]

                VirtualTag str ->
                    [ "/virtual_tags", str ]

                Contexts ->
                    [ "/contexts" ]

                Context str ->
                    [ "/contexts", str ]

                NewContext ->
                    [ "/contexts", "new" ]

                EditContext str ->
                    [ "/contexts", str, "edit" ]

                Search ->
                    [ "/search" ]

                NewTask ->
                    [ "/tasks", "new" ]

                Task str ->
                    [ "/tasks", str ]

                HomeTask str ->
                    [ "/tasks", str ]

                TagTask tagId taskId ->
                    [ "/tags", tagId, "tasks", taskId ]

                VirtualTagTask tagId taskId ->
                    [ "/virtual_tags", tagId, "tasks", taskId ]

                TagTaskEdit tagId taskId ->
                    [ "/tags", tagId, "tasks", taskId, "edit" ]

                VirtualTagTaskEdit tagId taskId ->
                    [ "/virtual_tags", tagId, "tasks", taskId, "edit" ]

                ProjectTask projectId taskId ->
                    [ "/projects", projectId, "tasks", taskId ]

                ProjectTaskEdit projectId taskId ->
                    [ "/projects", projectId, "tasks", taskId, "edit" ]

                HomeTaskEdit taskId ->
                    [ "/tasks", taskId, "edit" ]

                Discourse _ sig ->
                    case sig of
                        Just sig_ ->
                            [ "discourse", sig_ ]

                        Nothing ->
                            [ "discourse" ]
    in
    String.join "/" pieces



-- PUBLIC HELPERS --


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
