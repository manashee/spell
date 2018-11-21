import Html exposing (..)
import Browser
import Rand exposing (randNum)
import Random
import Html.Events exposing (onClick)
import Http 

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
                NextWord randomIndex -> ({ randomNumber = randomIndex ,  message = "Choosing Puzzle", words = model.words } , Cmd.none)
                RightAnswer -> ({ randomNumber = 0, message = "You win", words = model.words } , Cmd.none)
                DataReceived (Ok sentences) -> let words = String.split " " sentences in ({model| words = words}, Cmd.none)
                DataReceived (Err _) ->  (model , Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

view : Model -> Html Msg
view model = div[][ h1[] [ text (model.message ++ " " ++ String.fromInt model.randomNumber) ] , button [ onClick NextPuzzle ] [text  "Next Puzzle"] , ul [] (List.map viewWord model.words)  ] 

viewWord : String -> Html Msg
viewWord word = li [] [text word]

main = Browser.element { init = init , view = view, update = update , subscriptions = subscriptions }
