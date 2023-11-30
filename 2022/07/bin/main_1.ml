open Core

type fs =
| File of string * int
| Directory of string

type cmd =
| Cd of string
| Cd_up
| Ls of string list

type parse_state = string list

let x = [
  Directory "/",
  File ("a", 1000),
  File ("b", 1000),
  [
    Directory "c",
    File ("c", 1000),
    File ("d", 1000),
    [
      Directory "d",
      File ("d", 2000)
    ]
  ]
]

module Input = struct
  let parse (lines: string list) : fs list =
    let rec parse' lines result =
      match lines with
      | [] -> result
      | line :: rest when String.is_prefix line ~prefix: "$ cd /" -> parse' rest (Directory "/" :: result)
      | line :: rest when String.is_prefix line ~prefix: "$ ls" -> parse' rest result
      | line :: rest when String.is_prefix line ~prefix: "$ cd .." -> parse' rest result
      | line :: rest when String.is_prefix line ~prefix: "dir" -> parse' rest (Directory line :: result)
      | _ -> result in
    parse' lines []

  (* let parse_cmds (lines: string list) : cmd list =
    let rec p lines

  let _parse (lines: string list) : fs =
    let rec _parse' lines fs parse_state =
      match lines with
      | line :: rest when String.is_prefix line ~prefix: "$ cd /" -> _parse' rest fs parse_state (* skip *)
      | line :: rest when String.is_prefix line ~prefix: "$ ls" -> _parse' rest fs parse_state (* skip *)
      | line :: rest when String.is_prefix line ~prefix: "$ cd .." -> _parse' rest fs parse_state
      | line :: rest when String.is_prefix line ~prefix: "$ cd" ->
        _parse' rest fs parse_state
      | line :: rest -> _parse' rest fs (line :: parse_state)
      | _ -> fs
  in
    _parse' lines (Directory ("/", [], None)) []

  let parse'' (lines: string list) : parse_state =
    List.fold lines ~init: { fs = Directory ("/", [], None); output = []} ~f: (fun acc line ->
      match line with
      | line when String.is_prefix line ~prefix: "$ cd /" -> acc
      | line when String.is_prefix line ~prefix: "$ ls" -> { acc with output = line :: acc.output }
      | line when String.is_prefix line ~prefix: "$ cd .." -> acc
      | line when String.is_prefix line ~prefix: "$ cd" -> acc
      | _ -> acc
      ) *)

  let parse file =
    file
    |> In_channel.read_lines
    |> parse
end

let () =
  let _ = print_endline "" in
  Input.parse "sample2"
  |> List.iter ~f: (function
  | Directory name -> print_endline ("Dir:" ^ name)
  | File (name, _size) -> print_endline ("File:" ^ name)
  )

