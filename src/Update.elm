module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model, Player)
import Routing
import Browser
import Browser.Navigation as Navigation
import Commands
import Url
import RemoteData


updatePlayer : Model -> Player -> Model
updatePlayer model updatedPlayer =
    let
        pick currentPlayer =
            if updatedPlayer.id == currentPlayer.id then
                updatedPlayer
            else
                currentPlayer

        updatePlayerList players =
            List.map pick players

        updatedPlayers =
            RemoteData.map updatePlayerList model.players
    in
        { model | players = updatedPlayers }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PlayerSelected recordId ->
            let
                newUrl = "/#/players/" ++ recordId
            in
            ( { model | route = Models.PlayerRoute recordId }
            , Cmd.batch
                [ Navigation.pushUrl model.key newUrl
                , Commands.fetchPlayer recordId
                ]
            )

        OnFetchPlayer response ->
            ( { model | playerDetail = response }
            , Cmd.none
            )

        OnFetchPlayers response ->
            ( { model | players = response }, Cmd.none )

        UrlChanged url ->
            let
                newRoute = Routing.parseUrl url
                cmd =
                    case newRoute of
                        Models.PlayerRoute recordId ->
                            if model.playerDetail == RemoteData.NotAsked then
                                Commands.fetchPlayer recordId
                            else
                                Cmd.none

                        _ ->
                            Cmd.none
            in
            ( { model | route = newRoute }
            , cmd
            )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Navigation.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Navigation.load href )

        Messages.ChangeLevel player howMuch ->
            let
                updatedPlayer =
                    { player | level = player.level + howMuch }
            in
                ( model, Commands.savePlayerCmd updatedPlayer )

        Messages.OnPlayerSave (Ok player) ->
            ( updatePlayer model player, Cmd.none )

        Messages.OnPlayerSave (Err _) ->
            ( model, Cmd.none )
