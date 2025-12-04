open Base
open Stdio

let is_double_digit n =
  let s = Int.to_string n in
  let length = String.length s in
  if length % 2 <> 0
  then false
  else (
    let half = length / 2 in
    let left = String.sub s ~pos:0 ~len:half in
    let right = String.sub s ~pos:half ~len:half in
    String.equal left right)
;;

let parse_range str =
  str
  |> String.split ~on:'-'
  |> List.map ~f:Int.of_string
  |> fun l -> List.range (List.nth_exn l 0) (List.nth_exn l 1 + 1)
;;

let parse_ids str = str |> String.split ~on:',' |> List.concat_map ~f:parse_range
let parse file = file |> In_channel.read_lines

let () =
  "input/day_2_1"
  |> parse
  |> List.concat_map ~f:parse_ids
  |> List.filter ~f:is_double_digit
  |> List.reduce_exn ~f:( + )
  |> printf "%d"
;;
