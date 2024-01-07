interface Part2
    exposes [process]
    imports []

numbers = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
    |> List.map Str.graphemes

process = \str ->
    Str.split str "\n"
    |> List.keepOks parseIntoNumber
    |> List.sum
    |> Num.toStr

parseIntoNumber = \line ->
    Str.graphemes line
    |> toNumbers
    |> List.keepIf Result.isOk
    |> combineFirstAndLast

toNumbers = \graphemes ->
    List.mapWithIndex graphemes \chr, index ->
        Str.toU8 chr
        |> Result.onErr \_ -> List.findFirstIndex numbers (matchingArrayAtPosition graphemes index)
            |> Result.map Num.toU8
            

matchingArrayAtPosition = \graphemes, index ->
    \num -> 
        List.walkWithIndexUntil num Bool.false \_, x, offset ->
            matches = List.get graphemes (index + offset) |> Result.map (\y -> x == y) |> Result.withDefault Bool.false
            if matches then Continue Bool.true else Break Bool.false

combineFirstAndLast = \digits ->
    when digits is
        [Ok first, .., Ok last] -> Num.toStr first |> Str.concat (Num.toStr last) |> Str.toU32
        [Ok first] -> Num.toStr first |> Str.concat (Num.toStr first) |> Str.toU32
        _ -> Err NotEnoughDigits

expect 
    out = process "two1nine\neightwothree\nabcone2threexyz\nxtwone3four\n4nineeightseven2\nzoneight234\n7pqrstsixteen"
    out == "281"