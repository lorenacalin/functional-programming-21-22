
module Countries exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (checked, style, type_)
import Html.Events exposing (..)
import Http
import Json.Decode as Dec


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }

type alias Country =
    { name : String
    , area : Float
    , region : String
    , population: Int
    }


decodeCountry : Dec.Decoder Country
decodeCountry =
    Dec.map4 Country
        (Dec.at  ["name", "common"] Dec.string)
        (Dec.field "area" Dec.float)
        (Dec.field "region" Dec.string)
        (Dec.field "population" Dec.int)

{-So for the Success model I added one more variable - a boolean one, to be able to perform 2 different operation based
on the fact that the user wants to see the countries in ascending order or not-}
type Model
    = Initial
    | RequestSent
    | Success (List Country, Bool)
    | Error Http.Error

init : () -> ( Model, Cmd Msg )
init _ =
    ( Initial
    , Cmd.none
    )

{-ActivateAscending activates when the checkbox is checked-}
type Msg
    = GetCountries
    | GotCountries (Result Http.Error (List Country))
    | ActivateAscending Bool


getCountries : Cmd Msg
getCountries = Http.get
    { url = "https://restcountries.com/v3.1/all"
    , expect = Http.expectJson GotCountries (Dec.list decodeCountry)
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetCountries ->
            ( RequestSent
            , getCountries
            )

        GotCountries (Ok countries) ->
            ( Success (countries, False)
            , Cmd.none
            )

        GotCountries (Err err) ->
            ( Error err
            , Cmd.none
            )

        ActivateAscending yes ->case model of
                                        Success (countries,yes1)-> (Success(countries,yes),Cmd.none)
                                        _ -> (Initial,Cmd.none)




subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



view : Model -> Html Msg
view model =
    case model of
        Initial ->
            viewInitial

        RequestSent ->
            div [] [ text "Loading..." ]

        Success (countries, yes) ->
            (viewSuccess countries yes)

        Error err ->
            viewError err

viewInitial : Html Msg
viewInitial =
    div []
        [ button [ onClick GetCountries ] [ text "Get countries" ]
        ]

viewCountry : Country -> Html msg
viewCountry {name, area, region, population} =
    div [style "border" "solid 1px", style "margin" "2px"]
        [ p [] [text <| "Name:" ++ name]
        , p [] [text <| "Area: " ++ String.fromFloat area]
        , p [] [text <| "Population: " ++ String.fromInt population]
        , p [] [text <| "Density: " ++ String.fromFloat (toFloat(population)/area)]
        ]


{- So here I have 2 cases now, depending on the boolean which describes if the ascending order of the countries is
activated or not. If it is True, then I don't apply the reverse function anymore.-}
viewSuccess : List Country -> Bool -> Html Msg
viewSuccess countries yes=
    if yes == True then
        div [] ((h2 [] [ activateAscendingView True ])::List.map viewCountry (List.sortBy .area countries))
    else
        div [] ((h2 [] [ activateAscendingView False ])::List.map viewCountry (List.reverse(List.sortBy .area countries)))


{-This is the function which helps see the checkbox -}
activateAscendingView : Bool -> Html Msg
activateAscendingView yes =
    div []
        [ input [ type_ "checkbox", onCheck ActivateAscending, checked yes ] []
        , text "See the countries in ascending order"
        ]

httpErrorToString : Http.Error -> String
httpErrorToString err =
    case err of
        Http.BadUrl _ ->
            "Bad Url"

        Http.Timeout ->
            "Timeout"

        Http.NetworkError ->
            "Network Error"

        Http.BadStatus status ->
            "BadS tatus: " ++ String.fromInt status

        Http.BadBody _ ->
            "Bad Body"


viewError : Http.Error -> Html msg
viewError err =
    div [] [ h2 [] [ text "Rip" ], p [] [ text <| httpErrorToString err ] ]


