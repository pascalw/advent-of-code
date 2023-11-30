open Core

module SectionAssignments = struct
  type t = (int * int) * (int * int)

  let _parse_range range =
    range
    |> String.split ~on: '-'
    |> function
    | [a; b] -> (int_of_string a, int_of_string b)
    | _ -> failwith "invalid range"

  let parse line =
    line
    |> String.split ~on: ','
    |> function
    | [a; b] -> (_parse_range a, _parse_range b)
    | _ -> failwith "invalid line"

  let has_full_overlap r1 r2 = match r1, r2 with
  | (r1a, r1b) , (r2a, r2b) when r2a >= r1a && r2b <= r1b -> true
  | (r1a, r1b) , (r2a, r2b) when r1a >= r2a && r1b <= r2b -> true
  | _ -> false

  let has_overlap r1 r2 = match r1, r2 with
  | (r1s, r1e) , (r2s, _r2e) when r2s >= r1s && r2s <= r1e -> true
  | (r1s, _r1e) , (r2s, r2e) when r1s >= r2s && r1s <= r2e -> true
  | _ -> false
end
