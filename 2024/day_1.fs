module Day1

let readInput = System.IO.File.ReadLines "input/day1.txt"

let parse (input: seq<string>) =
  input
  |> Seq.map (fun line -> line.Split "   ")
  |> Seq.map (Array.map System.Int32.Parse)
  |> Seq.map (fun arr -> (arr.[0], arr.[1]))
  |> Seq.toArray
  |> Array.unzip

let findDinstances (left, right) =
  Array.zip (Array.sort left) (Array.sort right)
  |> Array.map (fun (l, r) -> abs(l - r))

let run () =
  readInput
  |> parse
  |> findDinstances
  |> Array.sum
  |> printfn "%d"

  0
