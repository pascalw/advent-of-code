module Day2_2

type Cube =
    | Red of int
    | Green of int
    | Blue of int

module CubeSet =
    type t = { R: int; G: int; B: int }

    let empty = { R = 0; G = 0; B = 0 }

    let power { R = r; G = g; B = b } = r * g * b

module Game =
    type t = { id: int; sets: seq<seq<Cube>> }

    let minCubesRequired game =
        let allCubes = Seq.collect (fun s -> s) game.sets

        Seq.fold
            (fun (acc: CubeSet.t) ->
                function
                | Red n when n > acc.R -> { acc with R = n }
                | Green n when n > acc.G -> { acc with G = n }
                | Blue n when n > acc.B -> { acc with B = n }
                | _ -> acc)
            CubeSet.empty
            allCubes

module Parser =
    let parseGameId (gamePrefix: System.String) = int (gamePrefix.Split " ").[1]

    let (|SetValue|_|) (suffix: string) (s: string) =
        match s.EndsWith(suffix) with
        | true -> Some(s.Substring(0, s.Length - suffix.Length))
        | false -> None

    let parseSet (setData: System.String) =
        setData.Split ", "
        |> Seq.map (function
            | SetValue "red" n -> Red(int n)
            | SetValue "green" n -> Green(int n)
            | SetValue "blue" n -> Blue(int n)
            | _ -> failwith "invalid set")

    let parseSets (setsData: System.String) = setsData.Split "; " |> Seq.map parseSet

    let parseGame (line: System.String) =
        match line.Split ": " with
        | [| gamePrefix; sets |] ->
            { Game.id = parseGameId gamePrefix
              Game.sets = parseSets sets }
        | _ -> failwith "Invalid game"

module Input =
    let read = System.IO.File.ReadLines "input/day2.txt"
    let parse input = input |> Seq.map Parser.parseGame


let run () =
    Input.read
    |> Input.parse
    |> Seq.map Game.minCubesRequired
    |> Seq.map CubeSet.power
    |> Seq.reduce (+)
    |> printfn "%d"

    0
