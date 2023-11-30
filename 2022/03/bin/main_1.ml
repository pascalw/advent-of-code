open Core

module Rucksack = struct
  type t = {left: string; right: string}

  let parse input =
    let mid = (String.length input / 2) in
    let left = String.sub input ~pos: 0 ~len: mid in
    let right = String.sub input ~pos: mid ~len: mid in
      { left; right}

  let display t =
    sprintf "l:%s r:%s" t.left t.right

  let duplicate_item t =
    let left_list = String.to_list t.left in
    let right_list = String.to_list t.right in
      List.find_exn left_list ~f:(fun c ->
          List.exists right_list ~f:(fun cc -> phys_equal cc c))
end

module Reorganization = struct
  let priority rucksack =
    let downcase = "abcdefghijklmnopqrstuvwxyz" in
    let upcase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" in
      let item = Rucksack.duplicate_item rucksack in
        String.index downcase item
        |> Option.map ~f: (fun i -> i+1)
        |> Option.first_some (String.index upcase item |> Option.map ~f: (fun i -> i + 27))
        |> Option.value_exn

  let priorities rucksacks = List.map rucksacks ~f: priority
end

module Input = struct
  let parse file =
    file
    |> In_channel.read_lines
    |> List.map ~f: Rucksack.parse
    |> Reorganization.priorities
    |> List.reduce_exn ~f: (+)
end

let () =
  Input.parse "input"
  |> printf "%d\n"
