open Core

module Input = struct
  let read = In_channel.read_lines
  let split = String.split ~on: ','

  let parse file_contents =
    List.map file_contents ~f: split
    |> Caml.List.flatten
    |> List.map ~f: Int.of_string
end

let () =
  let _input' = Input.read "input" in
  print_endline "Hello, world!"
