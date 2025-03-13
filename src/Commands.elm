module Commands exposing (..)

import Http
import Players.Decoders exposing (playersDecoder, playerDecoder)
import Messages exposing (Msg(..))
import RemoteData


fetchPlayers : Cmd Msg
fetchPlayers =
    Http.get
        { url = fetchPlayersUrl
        , expect = Http.expectJson (OnFetchPlayers << RemoteData.fromResult) playersDecoder
        }


fetchPlayersUrl : String
fetchPlayersUrl =
    "http://localhost:8090/api/collections/players/records"


fetchPlayer : String -> Cmd Msg
fetchPlayer recordId =
    Http.get
        { url = fetchPlayersUrl ++ "/" ++ recordId
        , expect = Http.expectJson (OnFetchPlayer << RemoteData.fromResult) playerDecoder
        }
