module Routing exposing (parseUrl)

import Url exposing (Url)
import String
import Models exposing (Route(..))

trimLeadingSlash : String -> String
trimLeadingSlash s =
    if String.startsWith "/" s then
        String.dropLeft 1 s
    else
        s

parseUrl : Url -> Route
parseUrl url =
    let
        raw =
            case url.fragment of
                Just frag ->
                    frag

                Nothing ->
                    ""
        segments =
            raw
                |> trimLeadingSlash
                |> String.split "/"
                |> List.filter (\s -> s /= "")
    in
    case segments of
        [] ->
            PlayersRoute

        [ "players" ] ->
            PlayersRoute

        [ "players", playerId ] ->
            PlayerRoute playerId

        _ ->
            NotFoundRoute
