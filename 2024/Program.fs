[<EntryPoint>]
let main = function
  | [| "1" |] -> Day1.run()
  | [| "1_2" |] -> Day1_2.run()
  | [| "2" |] -> Day2.run()
  | [| "3" |] -> Day3.run()
  | [| "3_2" |] -> Day3_2.run()
  | _ -> 1
