[<EntryPoint>]
let main = function
  | [| "1" |] -> Day1.run()
  | [| "1:2" |] -> Day1_2.run()
  | [| "2" |] -> Day2.run()
  | [| "2:2" |] -> Day2_2.run()
  | [| "3" |] -> Day3.run()
  | _ -> 1
