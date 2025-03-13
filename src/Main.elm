module Main exposing (main)

import Browser
import Browser.Navigation as Navigation
import Html exposing (Html)
import Models exposing (Model)
import Messages exposing (Msg(..))
import Routing
import Update exposing (update)
import View exposing (viewPlayerList, viewPlayerEdit)
import Url exposing (Url)
import RemoteData
import Commands


init : flags -> Url -> Navigation.Key -> ( Model, Cmd Msg )
init _ url key =
    let
        route =
            Routing.parseUrl url

        fetchPlayerCmd =
            case route of
                Models.PlayerRoute recordId ->
                    Commands.fetchPlayer recordId

                _ ->
                    Cmd.none
    in
    ( { players = RemoteData.NotAsked
      , route = route
      , key = key
      , playerDetail = RemoteData.NotAsked
      }
    , Cmd.batch [ Commands.fetchPlayers, fetchPlayerCmd ]
    )


view : Model -> Browser.Document Msg
view model =
    let
        pageContent =
            case model.route of
                Models.PlayersRoute ->
                    viewPlayerList model

                Models.PlayerRoute recordId ->
                    viewPlayerEdit model recordId

                Models.NotFoundRoute ->
                    Html.text "Page not found"
    in
    { title = "My App"
    , body = [ pageContent ]
    }


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }
