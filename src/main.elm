module Spell exposing (..)
import Html exposing (text)
import Rand exposing (rand)

main = text ("hello" ++ String.fromInt rand)

