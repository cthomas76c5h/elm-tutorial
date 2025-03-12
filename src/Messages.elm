module Messages exposing (..)

import Models exposing (Player)
import RemoteData exposing (WebData)
import Browser
import Url exposing (Url)



type Msg
    = UrlChanged Url
    | LinkClicked Browser.UrlRequest
    | OnFetchPlayers (WebData (List Player))
