open Core

module Reorganization = struct
  let priority item =
    let downcase = "abcdefghijklmnopqrstuvwxyz" in
    let upcase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" in
      String.index downcase item
      |> Option.map ~f: (fun i -> i+1)
      |> Option.first_some (String.index upcase item |> Option.map ~f: (fun i -> i + 27))
      |> Option.value_exn

  let duplicate_item = function
    | [] -> failwith "empty group unsupported"
    | (first :: rest) ->
      first
      |> String.to_list
      |> List.find_exn ~f: (fun c ->
          List.for_all rest ~f: (Fn.flip String.mem c))

  let priorities rucksacks =
    rucksacks
    |> duplicate_item
    |> priority
end

module Input = struct
  let parse file =
    file
    |> In_channel.read_lines
    |> List.chunks_of ~length: 3
    |> List.map ~f: Reorganization.priorities
    |> List.reduce_exn ~f: (+)
end

let () =
  Input.parse "input"
  |> printf "%d\n"
