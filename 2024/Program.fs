﻿[<EntryPoint>]
let main = function
  | [| "1" |] -> Day1.run()
  | [| "1_2" |] -> Day1_2.run()
  | [| "2" |] -> Day2.run()
  | _ -> 1
