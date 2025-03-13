module Commands exposing (fetchPlayers, fetchPlayersUrl, fetchPlayer, savePlayerUrl, savePlayerCmd, playerEncoder)

import Http
import Players.Decoders exposing (playersDecoder, playerDecoder)
import Messages exposing (Msg(..))
import RemoteData
import Models exposing (Player)
import Json.Encode as Encode


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


savePlayerUrl : String -> String
savePlayerUrl recordId =
    "http://localhost:8090/api/collections/players/records/" ++ recordId


savePlayerCmd : Player -> Cmd Msg
savePlayerCmd player =
    Http.request
        { method = "PATCH"
        , headers = []
        , url = savePlayerUrl player.id
        , body = playerEncoder player |> Http.jsonBody
        , expect = Http.expectJson OnPlayerSave playerDecoder
        , timeout = Nothing
        , tracker = Nothing
        }


playerEncoder : Player -> Encode.Value
playerEncoder player =
    Encode.object
        [ ( "name", Encode.string player.name )
        , ( "level", Encode.int player.level )
        ]
