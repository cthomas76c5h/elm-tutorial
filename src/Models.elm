module Models exposing (Model, Route(..), initialModel, Player)

import RemoteData exposing (WebData)
import Browser.Navigation exposing (Key)

type Route
    = NotFoundRoute
    | PlayersRoute
    | PlayerRoute String

type alias Model =
    { key : Key
    , route : Route
    , players : WebData (List Player)
    , playerDetail : WebData Player
    }

initialModel : Key -> Model
initialModel key =
    { key = key
    , route = NotFoundRoute
    , players = RemoteData.NotAsked
    , playerDetail = RemoteData.NotAsked
    }


type alias Player =
    { id : String
    , playerId : Int
    , name : String
    , level : Int
    }
