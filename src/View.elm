module View exposing (..)

import Html exposing (Html, div, text)
import RemoteData exposing (WebData)
import Messages exposing (Msg)
import Models exposing (Model, Player)
import Utils exposing (find)
import Players.List as PL
import Players.Edit as PE


playerList : WebData (List Player) -> Html Msg
playerList response =
    div []
        [ PL.nav
        , maybeList response
        ]


maybeList : WebData (List Player) -> Html Msg
maybeList response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success players ->
            PL.list (PL.sortedPlayers players)

        RemoteData.Failure error ->
            text (error |> Debug.toString)

viewPlayerList : Model -> Html Msg
viewPlayerList model =
    playerList model.players


viewPlayerEdit : Model -> String -> Html Msg
viewPlayerEdit model playerId =
    case String.toInt playerId of
        Nothing ->
            text "Invalid player id."

        Just pid ->
            case model.players of
                RemoteData.NotAsked ->
                    text "No players loaded yet."

                RemoteData.Loading ->
                    text "Loading players..."

                RemoteData.Failure error ->
                    text ("Error: " ++ (error |> Debug.toString))

                RemoteData.Success players ->
                    case find (\p -> p.playerId == pid) players of
                    Nothing ->
                        text "Player not found."

                    Just player ->
                        PE.view player
