open Base
open Stdio

type instruction =
  | Left of int
  | Right of int

let parse_instruction str =
  match str.[0], Int.of_string (String.sub str ~pos:1 ~len:(String.length str - 1)) with
  | 'L', n -> Left n
  | 'R', n -> Right n
  | _ -> failwith ("Unexpected input: " ^ str)
;;

let parse file = file |> In_channel.read_lines |> List.map ~f:parse_instruction

let move_dial instruction dial =
  let wrap n = ((n % 100) + 100) % 100 in
  match instruction with
  | Left n -> wrap (dial - n)
  | Right n -> wrap (dial + n)
;;

let move_dial instructions dial =
  let _, results =
    List.fold_map instructions ~init:dial ~f:(fun dial instr ->
      let next = move_dial instr dial in
      next, next)
  in
  results
;;

let () =
  let dial = 50 in
  let instructions = parse "input/day_1_1" in
  dial |> move_dial instructions |> List.count ~f:(Int.equal 0) |> printf "%d\n"
;;
