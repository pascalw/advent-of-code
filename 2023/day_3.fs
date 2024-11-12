module Day3

type EngineSchematic = char[][]

let findNeighbours (schematic: EngineSchematic) (row: int) (s: int) (e: int) =
    // Array.sub schematic[row] s (e-s) |> printfn "%A"

    let sMax = max 0 (s - 1)
    let eMin = min (Array.length schematic[row] - 1) (e + 1)
    let length = (eMin - sMax) + 1

    let neighboursAbove =
        if (row - 1) >= 0 then
            Some(Array.sub schematic[row - 1] sMax length)
        else
            None

    let neighboursBelow =
        if (row + 1) <= (Array.length schematic - 1) then
            Some(Array.sub schematic[row + 1] sMax length)
        else
            None

    let before = Array.tryItem (s - 1) (schematic[row]) |> Option.map (fun x -> [| x |])
    let after = Array.tryItem (e + 1) (schematic[row]) |> Option.map (fun x -> [| x |])

    let all = [ before; after; neighboursAbove; neighboursBelow ]
    List.filter Option.isSome all |> List.map Option.get |> Array.concat

let findNumberRanges input =
    input
    |> Array.indexed
    |> Array.fold
        (fun (prev, acc) (i, c) ->
            if not (System.Char.IsNumber c) then
                (Some c, acc)
            else
                match prev with
                | Some p when (System.Char.IsNumber p) ->
                    let (curNumberIdx, curNumber) = List.last acc
                    let curNumber = List.append curNumber [ c ]

                    let acc = acc |> List.updateAt ((List.length acc) - 1) (curNumberIdx, curNumber)

                    (Some c, acc)
                | _ -> (Some c, acc @ [ (i, [ c ]) ]))
        (Some '.', [])
    |> snd

let peek fn array =
    fn array
    array

let inline charToInt c = int c - int '0'

let toPartNumber (chars: char[]) = chars |> System.String |> int

let findPartNumber schematic row (startPos, chars) =
    findNeighbours schematic row startPos (startPos + (List.length chars))
    |> Array.filter (fun c -> c <> '.')
    |> Array.exists (fun c -> not (System.Char.IsNumber c))
    |> function
        | true -> Some(toPartNumber (chars |> List.toArray))
        | false -> None


let findPartNumbers schematic =
    schematic
    |> Array.mapi (fun i row -> (i, findNumberRanges row))
    |> Array.map (fun (row, ranges) ->
        ranges
        |> List.map (fun range -> findPartNumber schematic row range)
        |> List.toArray)
    |> Array.concat
    |> Array.filter Option.isSome
    |> Array.map Option.get
    |> peek (printfn "%A")
    |> Array.reduce (+)

let readInput = System.IO.File.ReadLines "input/day3.txt"
let parseInput =
  readInput |> Seq.map Seq.toArray |> Seq.toArray

let run () =
    let input = parseInput

    let input = Array.sub input 0 4
    // let input = "..........917..
    // 722...323.-...." |> fun (s: System.String) -> s.Split "\n" |> Seq.map (Seq.toArray) |> Seq.toArray

    findNeighbours input 3 10 12 |> printfn "%A"

    // input
    // |> findPartNumbers
    // |> printfn "%d"

    // parseInput
    // |> findPartNumbers
    // |> printfn "%d"

    0
