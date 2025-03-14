module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import Routing
import Browser
import Browser.Navigation as Navigation
import Commands
import Url
import RemoteData

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

        Messages.OnPlayerSave result ->
            case result of
                Ok updatedPlayer ->
                    let
                        newPlayerDetail =
                            RemoteData.Success updatedPlayer

                        newPlayers =
                            case model.players of
                                RemoteData.Success players ->
                                    RemoteData.Success
                                        (List.map (\p -> if p.id == updatedPlayer.id then updatedPlayer else p) players)

                                _ ->
                                    model.players
                    in
                    ( { model | playerDetail = newPlayerDetail, players = newPlayers }
                    , Cmd.none
                    )

                Err error ->
                    ( { model | playerDetail = RemoteData.Failure error }
                    , Cmd.none
                    )
