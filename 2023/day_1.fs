module Day1

let readInput = System.IO.File.ReadLines "input/day1.txt"

let inline charToInt c = int c - int '0'

let extractDigits: string -> seq<int> =
    Seq.filter System.Char.IsDigit >> (Seq.map charToInt)

let buildCalibrationValue values =
    let hd = Seq.head values
    let tl = Seq.last values

    hd * 10 + tl

let run () =
    readInput
    |> Seq.map extractDigits
    |> Seq.map buildCalibrationValue
    |> Seq.reduce (+)
    |> printfn "%d"

    0
