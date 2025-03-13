module Utils exposing (..)


find : (a -> Bool) -> List a -> Maybe a
find predicate list =
    list
        |> List.filter predicate
        |> List.head
