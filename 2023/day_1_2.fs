module Day1_2

let replacements =
    Map
        [ "one", "o1e"
          "two", "t2o"
          "three", "t3e"
          "four", "f4r"
          "five", "f5e"
          "six", "s6x"
          "seven", "s7n"
          "eight", "e8t"
          "nine", "n9e" ]

let readInput = System.IO.File.ReadLines "input/day1.txt"

let inline charToInt c = int c - int '0'

let replaceWrittenDigits string =
    Map.fold (fun (acc: System.String) (key: System.String) value -> acc.Replace(key, value)) string replacements

let extractDigits line =
    line
    |> replaceWrittenDigits
    |> Seq.filter System.Char.IsDigit
    |> Seq.map charToInt

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
