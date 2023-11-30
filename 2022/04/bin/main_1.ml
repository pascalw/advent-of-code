open Core
open Aoc_04.Lib

module Input = struct
  let parse file =
    file
    |> In_channel.read_lines
    |> List.map ~f: SectionAssignments.parse
    |> List.map ~f: (fun (r1, r2) -> SectionAssignments.has_full_overlap r1 r2)
end

let () =
  Input.parse "input"
  |> List.count ~f: (equal_bool true)
  |> Out_channel.printf "%d"
