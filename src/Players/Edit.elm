module Players.Edit exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Messages exposing (Msg)
import Models exposing (Player)


view : Player -> Html Msg
view model =
    div []
        [ nav model
        , form model
        ]


nav : Player -> Html Msg
nav _ =
    div [ class "clearfix mb2 white bg-black p1" ]
        []


form : Player -> Html Msg
form player =
    div [ class "m3" ]
        [ h1 [] [ text player.name ]
        , formLevel player
        ]


formLevel : Player -> Html Msg
formLevel player =
    div
        [ class "clearfix py1"
        ]
        [ div [ class "col col-5" ] [ text "Level" ]
        , div [ class "col col-7" ]
            [ span [ class "h2 bold" ] [ text (String.fromInt player.level) ]
            , btnLevelDecrease player
            , btnLevelIncrease player
            ]
        ]


btnLevelDecrease : Player -> Html Msg
btnLevelDecrease player =
    button [ class "btn ml1 h1"
           , onClick (Messages.ChangeLevel player -1) ]
        [ text "-" ]


btnLevelIncrease : Player -> Html Msg
btnLevelIncrease player =
    button [ class "btn ml1 h1"
           , onClick (Messages.ChangeLevel player 1) ]
        [ text "+" ]
