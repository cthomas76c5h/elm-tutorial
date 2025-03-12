module Commands exposing (..)

import Http
import Players.Decoders exposing (playersDecoder)
import Messages exposing (Msg)
import RemoteData


fetchPlayers : Cmd Msg
fetchPlayers =
    Http.get
        { url = fetchPlayersUrl
        , expect = Http.expectJson (Messages.OnFetchPlayers << RemoteData.fromResult) playersDecoder
        }


fetchPlayersUrl : String
fetchPlayersUrl =
    "http://localhost:8090/api/collections/players/records"
