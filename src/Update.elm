module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import Routing
import Browser
import Browser.Navigation as Navigation
import Commands
import Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PlayerSelected recordId ->
            let
                newUrl = "/#/players/" ++ recordId
            in
            ( { model | route = Models.PlayerRoute recordId }
            , Cmd.batch
                [ Navigation.pushUrl model.key newUrl
                , Commands.fetchPlayer recordId
                ]
            )

        OnFetchPlayer response ->
            ( { model | playerDetail = response }
            , Cmd.none
            )

        OnFetchPlayers response ->
            ( { model | players = response }, Cmd.none )
    
        UrlChanged url ->
                ( { model | route = Routing.parseUrl url }
                , Cmd.none
                )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Navigation.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Navigation.load href )
