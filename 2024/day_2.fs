module Day2

let isSafe report =
    let pairs = Array.pairwise report

    let increasing = fun () -> pairs |> Array.forall (fun (x, y) -> x > y)
    let decreasing = fun () -> pairs |> Array.forall (fun (x, y) -> x < y)

    let safeLevelDistance =
        pairs
        |> Array.map (fun (x, y) -> abs (x - y))
        |> Array.forall (fun d -> d >= 1 && d <= 3)

    safeLevelDistance && (increasing () || decreasing ())

let parse (input: seq<string>) =
    input
    |> Seq.map (fun line -> line.Split " ")
    |> Seq.map (Array.map System.Int32.Parse)

let countSafeReports reports =
    reports |> Seq.map isSafe |> Seq.filter (fun b -> b) |> Seq.length

let readInput = System.IO.File.ReadLines "input/day2.txt"

let run () =
    readInput |> parse |> countSafeReports |> printfn "%d"

    0
