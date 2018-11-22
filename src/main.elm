import Html exposing (..)
import Browser 
import Browser.Events exposing (onKeyUp) 
import Rand exposing (randNum)
import Random
import Html.Events exposing (onClick)
import Http 
import Array

type Msg = RightAnswer | NextWord Int | NextPuzzle | DataReceived (Result Http.Error String)
type alias Model = { randomNumber : Int , message : String , words : List String }

init : () -> (Model, Cmd Msg)
init _ =
  ( Model 1 "" ["ashok","kumar"] 
  , Http.send DataReceived (Http.getString url)
  )

url = "http://localhost:8001/words.txt"

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = 
        case msg of
                NextPuzzle -> (model, Random.generate NextWord (randNum 100) )
                NextWord randomIndex -> ({ model | randomNumber = randomIndex } , Cmd.none)
                RightAnswer -> ({ model | message = "You win"} , Cmd.none)
                DataReceived (Ok sentences) -> let words = String.split " " sentences in ({model| words = words}, Cmd.none)
                DataReceived (Err _) ->  (model , Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

view : Model -> Html Msg
view model = div[][ h1[] (viewWord model.randomNumber model) , button [ onClick NextPuzzle ] [text  "Next Puzzle"] ] 
viewWord idx model = [text (getWord idx model.words)]
getWord idx words = Array.get idx (Array.fromList words) |> Maybe.withDefault "black"

main = Browser.element { init = init , view = view, update = update , subscriptions = subscriptions }
