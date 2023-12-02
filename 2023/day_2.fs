module Day2

type Cube =
    | Red of int
    | Green of int
    | Blue of int

type Game = { id: int; sets: seq<seq<Cube>> }

let inline charToInt c = int c - int '0'

let (|SetValue|_|) (suffix: string) (s: string) =
    match s.EndsWith(suffix) with
    | true -> Some(s.Substring(0, s.Length - suffix.Length))
    | false -> None

let readInput = System.IO.File.ReadLines "input/day2.txt"

let parseGameId (gamePrefix: System.String) = int (gamePrefix.Split " ").[1]

let parseSet (setData: System.String) =
    setData.Split ", "
    |> Seq.map (function
        | SetValue "red" n -> Red(int n)
        | SetValue "green" n -> Green(int n)
        | SetValue "blue" n -> Blue(int n)
        | _ -> failwith "invalid set")

let parseSets (setsData: System.String) =
    setsData.Split "; " |> Seq.map parseSet

let parseGame (line: System.String) =
    match line.Split ": " with
    | [| gamePrefix; sets |] ->
        { id = parseGameId gamePrefix
          sets = parseSets sets }
    | _ -> failwith "Invalid game"

let gameIsPossible (game: Game) (configR, configG, configB) =
    game.sets
    |> Seq.collect (fun set -> set)
    |> Seq.exists (function
        | Red r -> r > configR
        | Green g -> g > configG
        | Blue b -> b > configB)
    |> not

let parse input = input |> Seq.map parseGame

let run () =
    let gameConfig = (12, 13, 14)

    readInput
    |> parse
    |> Seq.map (fun game -> (game, gameIsPossible game gameConfig))
    |> Seq.filter (fun (_, possible) -> possible = true)
    |> Seq.map (fun (game, _) -> game.id)
    |> Seq.reduce (+)
    |> printfn "%d"

    0
