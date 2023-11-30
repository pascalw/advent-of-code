open Core

module Fish = struct
  type t = { timer : int }

  let age t = match t with
  | { timer = 0 } -> [ { timer = 6 } ; { timer = 8 } ]
  | t -> [ { timer = t.timer - 1 } ]

  let from_string value =
    let timer = Int.of_string value in
    { timer }

  let to_string f = Printf.sprintf "Fish{ timer: %d }" f.timer
end

module Simulation = struct
  type t = { fishes : Fish.t list }

  let make fishes = { fishes }

  let tick' t =
    let next_fishes = List.map t.fishes ~f: Fish.age in
    { fishes = Caml.List.flatten next_fishes }

  let rec tick t ~n = match n with
  | 0 -> t
  | _ -> tick (tick' t) ~n:(n - 1)
end

module Input = struct
  let read = In_channel.read_lines
  let split = String.split ~on: ','

  let parse file_contents =
    List.map file_contents ~f: split
    |> Caml.List.flatten
    |> List.map ~f: Fish.from_string
end

let () =
  let simulation =
  Input.read "input"
  |> Input.parse
  |> Simulation.make
  |> Simulation.tick ~n: 80 in
  print_endline (string_of_int (List.length simulation.fishes)) ;;
