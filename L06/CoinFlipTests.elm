
module CoinFlipTests exposing (..)

import CoinFlip exposing (initModel)
import Expect exposing (Expectation)
import Html exposing (text)
import Test exposing (..)
import Fuzz
import Test.Html.Query as Q
import Test.Html.Selector as S
import Html.Attributes as Attr

initialViewTest : Test
initialViewTest =
    test "view contains the initial text" <|
        \_ ->
            CoinFlip.view initModel
                |> Q.fromHtml
                |> Q.has [ S.text "Press the flip button to get started" ]