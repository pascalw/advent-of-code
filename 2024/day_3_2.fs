module Day3_2

open System.Text.RegularExpressions

type Operation =
    | Do
    | Dont
    | Mul of a: int * b: int

let opsPattern =
    Regex(@"(?<mul>mul\(([0-9]{1,3}),([0-9]{1,3})\))|(?<do>do\(\))|(?<dont>don't\(\))", RegexOptions.Compiled)

let compute operations =
    let rec compute' operations mulEnabled acc =
        match (mulEnabled, operations) with
        | (_, []) -> acc
        | (Dont, Do :: tail) -> compute' tail Do acc
        | (Do, Dont :: tail) -> compute' tail Dont acc
        | (Do, Mul(a, b) :: tail) -> compute' tail mulEnabled (acc + (a * b))
        | (_, _ :: tail) -> compute' tail mulEnabled acc

    compute' operations Do 0

let parseMatch (m: Match) =
    let Parse = System.Int32.Parse
    let parseMul = fun () -> Mul(Parse(m.Groups.[1].Value), Parse(m.Groups[2].Value))

    match () with
    | _ when m.Groups.["mul"].Success -> parseMul ()
    | _ when m.Groups.["do"].Success -> Do
    | _ when m.Groups.["dont"].Success -> Dont
    | _ -> failwith "invalid match"


let parse (input: seq<string>) =
    input |> Seq.collect opsPattern.Matches |> Seq.map parseMatch |> Seq.toList

let readInput = System.IO.File.ReadLines "input/day3.txt"

let run () =
    readInput |> parse |> compute |> printfn "%d"

    0
