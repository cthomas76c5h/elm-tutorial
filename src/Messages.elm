module Messages exposing (..)

import Models exposing (Player)
import RemoteData exposing (WebData)
import Browser
import Url exposing (Url)
import Http


type Msg
    = UrlChanged Url
    | LinkClicked Browser.UrlRequest
    | OnFetchPlayers (WebData (List Player))
    | OnFetchPlayer (WebData Player)
    | PlayerSelected String
    | ChangeLevel Player Int
    | OnPlayerSave (Result Http.Error Player)
