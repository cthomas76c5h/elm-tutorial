module Players.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Models exposing (Player)


sortedPlayers : List Player -> List Player
sortedPlayers players =
    List.sortBy .playerId players


view : List Player -> Html Msg
view players =
    div []
        [ nav
        , list players
        ]


nav : Html Msg
nav =
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2" ] [ text "Players" ] ]


list : List Player -> Html Msg
list players =
    div [ class "p2" ]
        [ table []
            [ thead []
                [ tr []
                    [ th [] [ text "Id" ]
                    , th [] [ text "Name" ]
                    , th [] [ text "Level" ]
                    , th [] [ text "Actions" ]
                    ]
                ]
            , tbody [] (List.map playerRow players)
            ]
        ]


playerRow : Player -> Html Msg
playerRow player =
    tr [ onClick (PlayerSelected player.id) ]
        [ td [] [ text (String.fromInt player.playerId) ]
        , td [] [ text player.name ]
        , td [] [ text (String.fromInt player.level) ]
        , td [] []
        ]
