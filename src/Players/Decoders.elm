module Players.Decoders exposing (playerDecoder, playersDecoder)

import Json.Decode as Decode exposing (Decoder)
import Models exposing (Player)


playerDecoder : Decoder Player
playerDecoder =
    Decode.map4 Player
        (Decode.field "id"       Decode.string)
        (Decode.field "playerId" Decode.int)
        (Decode.field "name"     Decode.string)
        (Decode.field "level"    Decode.int)


playersDecoder : Decoder (List Player)
playersDecoder =
    Decode.field "items" (Decode.list playerDecoder)
