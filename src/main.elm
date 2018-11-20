import Html exposing (..)
import Browser
import Rand exposing (randNum)
import Random
import Html.Events exposing (onClick)

type Msg = RightAnswer | NextWord Int | NextPuzzle
type alias Model = { randomNumber : Int , message : String }

init : () -> (Model, Cmd Msg)
init _ =
  ( Model 1 ""
  , Cmd.none
  )

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = 
        case msg of
                NextPuzzle -> (model, Random.generate NextWord (randNum 100) )
                NextWord randomIndex -> (Model randomIndex "Choosing puzzle ... " , Cmd.none) 
                RightAnswer -> (Model 0 "You win", Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

view : Model -> Html Msg
view model = div[][ h1[] [ text (model.message ++ " " ++ String.fromInt model.randomNumber) ] , button [ onClick NextPuzzle ] [text  "Next Puzzle"] ] 

main = Browser.element { init = init , view = view, update = update , subscriptions = subscriptions }
