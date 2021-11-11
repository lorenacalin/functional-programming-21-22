--METHOD 1

--module CoinFlip exposing (..)
--
--import Browser
--import Html exposing (..)
--import Html.Attributes exposing (style)
--import Html.Events exposing (..)
--import Random
--
--main =
--  Browser.element
--    { init = init
--    , update = update
--    , subscriptions = subscriptions
--    , view = view
--    }
--
--type CoinSide
--  = Heads
--  | Tails
--
--{- Model contains the current flip and a list of previous flips-}
--type alias Model =
--  { currentFlip : Maybe CoinSide
--  , flips: List CoinSide
--  , nrOfTails : Int
--  , nrOfHeads : Int
--  }
--
--initModel = Model Nothing [] 0 0
----nrOfTailsInit = 0
----nrOfHeadsInit = 0
--
--init : () -> (Model, Cmd Msg)
--init _ =
--  (initModel, Cmd.none)
--
--type Msg
--  = Flip
--  | AddFlip CoinSide
--
--{- update function returns a tuple now: the new model and a command for the "outside world" -}
--update : Msg -> Model -> (Model, Cmd Msg)
--update msg model =
--  case msg of
--    Flip ->
--      ( model, Random.generate AddFlip coinFlip)
--
--    AddFlip coin ->
--        if coin == Tails then ( Model (Just coin) (coin::model.flips) (model.nrOfHeads) (model.nrOfTails + 1), Cmd.none)
--        else if coin == Heads then ( Model (Just coin) (coin::model.flips) (model.nrOfHeads + 1) (model.nrOfTails), Cmd.none)
--        else ( Model (Just coin) (coin::model.flips) (model.nrOfHeads) (model.nrOfTails), Cmd.none)
--
--coinFlip : Random.Generator CoinSide
--coinFlip =
--  Random.uniform Heads
--    [ Tails ]
--
--subscriptions : Model -> Sub Msg
--subscriptions model =
--  Sub.none
--
--view : Model -> Html Msg
--view model =
--  let
--    currentFlip =
--      model.currentFlip
--      |> Maybe.map viewCoin
--      |> Maybe.withDefault (text "Press the flip button to get started")
--    flips =
--      model.flips
--      |> List.map coinToString
--      |> List.intersperse " "
--      |> List.map text
--    display = viewHeadsAndTails model
--  in
--    div []
--      [ button [ onClick Flip ] [ text "Flip" ]
--      , currentFlip
--      , div [] flips
--      , display
--      ]
--
--coinToString : CoinSide -> String
--coinToString coin =
--  case coin of
--    Heads -> "h"
--    Tails -> "t"
--
--viewCoin : CoinSide -> Html Msg
--viewCoin coin =
--  let
--    name = coinToString coin
--  in
--    div [ style "font-size" "4em" ] [ text name ]
--
--
--
--viewHeadsAndTails : Model -> Html Msg
--viewHeadsAndTails model =
--  --let
--  --  name = coinToString coin
--  --in
--    div [ style "font-size" "1em" ]
--    [ text (String.concat["Nb of tails = ", (String.fromInt model.nrOfTails), " Nb of heads = ", (String.fromInt model.nrOfHeads)]) ]



--METHOD 2

--module CoinFlip exposing (..)
--
--import Browser
--import Html exposing (..)
--import Html.Attributes exposing (style)
--import Html.Events exposing (..)
--import Random
--
--main =
--  Browser.element
--    { init = init
--    , update = update
--    , subscriptions = subscriptions
--    , view = view
--    }
--
--type CoinSide
--  = Heads
--  | Tails
--
--type alias Model =
--  { currentFlip : Maybe CoinSide
--  , flips: List CoinSide
--  , nrOfTails : Int
--  , nrOfHeads : Int
--  }
--
--initModel = Model Nothing [] 0 0
--
--init : () -> (Model, Cmd Msg)
--init _ =
--  ( initModel
--  , Cmd.none
--  )
--
--type Msg
--  = Flip
--  | AddFlip CoinSide
--
--update : Msg -> Model -> (Model, Cmd Msg)
--update msg model =
--  case msg of
--    Flip ->
--      ( model
--      , Random.generate AddFlip coinFlip
--      )
--
--    AddFlip coin ->
--      ( Model (Just coin) (coin::model.flips) model.nrOfTails model.nrOfHeads
--      , Cmd.none
--      )
--
--coinFlip : Random.Generator CoinSide
--coinFlip =
--  Random.uniform Heads
--    [ Tails ]
--
--subscriptions : Model -> Sub Msg
--subscriptions model =
--  Sub.none
--
--
--partitionHeadsAndTails : Model -> Html Msg
--partitionHeadsAndTails model =
--    let
--        (heads , tails) = List.partition (\x -> x==Heads) model.flips
--        nrOfHeads = List.length heads
--        nrOfTails = List.length tails
--    in
--        div [ style "font-size" "4em" ] [ text (String.concat["Nb of tails = ", (String.fromInt nrOfTails), " Nb of heads = ", (String.fromInt nrOfHeads)]) ]
--
--
--
--view : Model -> Html Msg
--view model =
--  let
--    currentFlip =
--      model.currentFlip
--      |> Maybe.map viewCoin
--      |> Maybe.withDefault (text "Press the flip button to get started")
--    flips =
--      model.flips
--      |> List.map coinToString
--      |> List.intersperse " "
--      |> List.map text
--    display =
--        partitionHeadsAndTails model
--  in
--    div []
--      [ button [ onClick Flip ] [ text "Flip" ]
--      , currentFlip
--      , div [] flips
--      , partitionHeadsAndTails model
--      ]
--
--coinToString : CoinSide -> String
--coinToString coin =
--  case coin of
--    Heads -> "h"
--    Tails -> "t"
--
--viewCoin : CoinSide -> Html Msg
--viewCoin coin =
--  let
--    name = coinToString coin
--  in
--    div [ style "font-size" "4em" ] [ text name ]


module CoinFlip exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (..)
import Random

main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }

type CoinSide
  = Heads
  | Tails

type alias Model =
  { currentFlip : Maybe CoinSide
  , flips: List CoinSide
  }

initModel = Model Nothing []

init : () -> (Model, Cmd Msg)
init _ =
  ( initModel
  , Cmd.none
  )

type Msg
  = Flip
  | AddFlip CoinSide

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Flip ->
      ( model
      , Random.generate AddFlip coinFlip
      )

    AddFlip coin ->
      ( Model (Just coin) (coin::model.flips)
      , Cmd.none
      )

coinFlip : Random.Generator CoinSide
coinFlip =
  Random.uniform Heads
    [ Tails ]

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

view : Model -> Html Msg
view model =
  let
    currentFlip =
      model.currentFlip
      |> Maybe.map viewCoin
      |> Maybe.withDefault (text "Press the flip button to get started")
    flips =
      model.flips
      |> List.map coinToString
      |> List.intersperse " "
      |> List.map text
  in
    div []
      [ button [ onClick Flip ] [ text "Flip" ]
      , currentFlip
      , div [] flips
      ]

coinToString : CoinSide -> String
coinToString coin =
  case coin of
    Heads -> "h"
    Tails -> "t"

viewCoin : CoinSide -> Html Msg
viewCoin coin =
  let
    name = coinToString coin
  in
    div [ style "font-size" "4em" ] [ text name ]
