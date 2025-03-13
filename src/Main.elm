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
    ( { players = RemoteData.Loading, route = Routing.parseUrl url, key = key }
    , Commands.fetchPlayers
    )


view : Model -> Browser.Document Msg
view model =
    let
        pageContent =
            case model.route of
                Models.PlayersRoute ->
                    viewPlayerList model

                Models.PlayerRoute playerId ->
                    viewPlayerEdit model playerId

                Models.NotFoundRoute ->
                    Html.text "Page not found"
    in
    { title = "My App"
    , body = [ pageContent ]
    }



subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }
