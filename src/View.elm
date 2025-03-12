module View exposing (..)

import Html exposing (Html, div, text)
import RemoteData exposing (WebData)
import Messages exposing (Msg)
import Models exposing (Model, Player)
import Players.List as PL


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
