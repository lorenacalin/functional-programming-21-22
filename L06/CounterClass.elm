
module CounterClass exposing (..)

import Browser
import Html exposing (Attribute, Html, button, div, text)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)
import Html.Attributes exposing (disabled)
import Html.Attributes exposing (class)

main =
  Browser.sandbox { init = 0, update = update, view = view }

type alias Model = Int

type Msg = Increment | Decrement

update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      model + 1

    Decrement ->
      model - 1

changeColor : Model -> Attribute Msg
changeColor model =
    if model > 8 || model < -8 then (style "color" "red") else ( style "color" "black")


view : Model -> Html Msg
view model =
  let
    bigFont = style "font-size" "20pt"
  in
    div []
      [ button [ disabled(model > 9), bigFont,onClick Increment ] [ text "+" ]
      , div [ bigFont, changeColor model ] [ text (String.fromInt model) ]
      , button [ disabled(model < -9), bigFont, onClick Decrement ] [ text "-" ]
      ]

