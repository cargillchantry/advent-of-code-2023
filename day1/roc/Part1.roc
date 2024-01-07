interface Part1
    exposes [process]
    imports []

process = \str ->
    Str.split str "\n"
    |> List.keepOks parseIntoNumber
    |> List.sum
    |> Num.toStr

parseIntoNumber = \line ->
    Str.graphemes line
    |> List.keepOks Str.toU8
    |> combineFirstAndLast

combineFirstAndLast = \digits ->
    when digits is
        [first, .., last] -> Num.toStr first |> Str.concat (Num.toStr last) |> Str.toU32
        [first] -> Num.toStr first |> Str.concat (Num.toStr first) |> Str.toU32
        _ -> Err NotEnoughDigits

expect 
    out = process "1abc2\npqr3stu8vwx\na1b2c3d4e5f\ntreb7uchet"
    out == "142"