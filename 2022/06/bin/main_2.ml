open Core
open Aoc_06

module Input = struct
  let parse file =
    file
    |> In_channel.read_lines
    |> Fn.flip List.nth_exn 0
    |> String.to_list
end

let () =
  Input.parse "input"
  |> Datastream.marker_finder 14
  |> fun (pos, marker) -> printf "%d %s\n" pos marker
