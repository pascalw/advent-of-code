module Day1_2

let readInput = System.IO.File.ReadLines "input/day1.txt"

let parse (input: seq<string>) =
    input
    |> Seq.map (fun line -> line.Split "   ")
    |> Seq.map (Array.map System.Int32.Parse)
    |> Seq.map (fun arr -> (arr.[0], arr.[1]))
    |> Seq.toArray
    |> Array.unzip

let occurenceCounter list =
    let occurences = Seq.countBy id list

    fun n ->
        occurences
        |> Seq.tryFind (fun (i, _) -> i = n)
        |> function
            | Some((_, n)) -> n
            | None -> 0

let similarityScores (left, right) =
    let countOccurences' = occurenceCounter right
    let score = fun number -> number * (countOccurences' number)

    left |> Seq.map score |> Seq.reduce (+)


let findDinstances (left, right) =
    Array.zip (Array.sort left) (Array.sort right)
    |> Array.map (fun (l, r) -> abs (l - r))

let run () =
    readInput |> parse |> similarityScores |> printfn "%d"

    0
