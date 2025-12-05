open Base
open Stdio

module Range = struct
  type t = int * int

  let make l = List.nth_exn l 0, List.nth_exn l 1
  let parse str = str |> String.split ~on:'-' |> List.map ~f:Int.of_string |> make
  let contains (s, e) n = n >= s && n <= e
end

let parse_ranges = List.map ~f:Range.parse
let parse_available available = 1 |> List.drop available |> List.map ~f:Int.of_string

let parse_file file =
  let fresh_ranges, available =
    file |> In_channel.read_lines |> List.split_while ~f:(String.( <> ) "")
  in
  parse_ranges fresh_ranges, parse_available available
;;

let is_ingredient_fresh fresh ingredient =
  List.exists fresh ~f:(fun r -> Range.contains r ingredient)
;;

let fresh_ingredients (fresh, available) =
  List.filter available ~f:(is_ingredient_fresh fresh)
;;

let () = "input/day_5_1" |> parse_file |> fresh_ingredients |> List.length |> printf "%d"
