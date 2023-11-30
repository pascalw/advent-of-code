open Core

module Input = struct
  let read = In_channel.read_lines
  let split = String.split ~on: ','

  let parse file_contents =
    List.map file_contents ~f: split
    |> Caml.List.flatten
    |> List.map ~f: Int.of_string
end

module Crabs = struct
  type t = { positions : int array }

  let make positions = { positions }

  let target_position t =
    t.positions
    |> Array.map ~f: float_of_int
    |> Owl_base.Stats.median
    |> int_of_float

  let required_fuel t target_pos =
    let abs n = if n < 0 then n * -1 else n in
    let diff a b = a - b |> abs in
    Array.fold t.positions ~init: 0 ~f: (fun acc v -> acc + diff v target_pos)
end

let () =
  let crabs = Input.read "input"
  |> Input.parse
  |> Array.of_list
  |> Crabs.make in
  let target_position = Crabs.target_position crabs in
  let required_fuel = Crabs.required_fuel crabs target_position in
  required_fuel |> string_of_int |> print_endline
