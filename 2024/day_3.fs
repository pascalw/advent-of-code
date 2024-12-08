module Day3

open System.Text.RegularExpressions

let mulPattern = Regex(@"mul\(([0-9]{1,3}),([0-9]{1,3})\)", RegexOptions.Compiled)

let compute' (a, b) = a * b

let compute instructions = Seq.map compute' instructions

let parseMatch (m: Match) =
    let Parse = System.Int32.Parse
    (Parse(m.Groups.[1].Value), Parse(m.Groups[2].Value))

let parse (input: seq<string>) =
    input |> Seq.collect mulPattern.Matches |> Seq.map parseMatch

let readInput = System.IO.File.ReadLines "input/day3.txt"

let run () =
    readInput |> parse |> compute |> Seq.reduce (+) |> printfn "%d"

    0
