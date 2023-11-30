open Core

module Input = struct
  let read = In_channel.read_lines
  let split = String.split ~on: ','

  let parse file_contents =
    List.map file_contents ~f: split
    |> Caml.List.flatten
    |> List.map ~f: Int.of_string
end

module Simulation = struct
  type t = int array

  (* count occurences of fish timers *)
  (* position 0 = count of fishes with timer = 0 *)
  (* position 1 = count of fishes with timer = 1 *)
  (* and so forth *)
  let make input =
    let f i = List.count input ~f:((=) i) in
    List.init 9 ~f: f

  (* shift all counts left *)
  (* add all 0's to 6 *)
  (* create a new fish for every 0 (pos 0 -> pos 8) *)
  let tick' = function
  | [i0; i1; i2; i3; i4; i5; i6; i7; i8;] ->
    [i1; i2; i3; i4; i5; i6; i7 + i0; i8; i0;]
  | _ -> raise @@ Failure "unreachable"

  let rec tick t ~n = match n with
  | 0 -> t
  | _ -> tick (tick' t) ~n:(n - 1)

  let number_of_fishes =
    List.fold ~init: 0 ~f:(+)
end

let limit = match Sys.get_argv() with
| [|_; limit|] -> limit |> int_of_string
| _ -> raise @@ Failure "Missing argument <limit>"

let () =
  Input.read "input"
  |> Input.parse
  |> Simulation.make
  |> Simulation.tick ~n: limit
  |> Simulation.number_of_fishes
  |> (fun n -> printf "%d \n" n)
