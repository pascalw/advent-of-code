open Core

module Point = struct
  let make = function
    | [x; y] -> (x,y)
    | _ -> failwith "not a valid point"

  let parse str = str
    |> String.split ~on: ','
    |> List.map ~f: int_of_string
    |> make

  let (==) (x1,y1) (x2,y2) = x1 = x2 && y1 = y2
  let (<>) p1 p2 = Caml.Bool.not (p1 == p2)

  let compare = Tuple2.compare ~cmp1: Int.compare ~cmp2: Int.compare

  let display (x, y) = Printf.sprintf "(%d,%d)" x y 
end

module Line = struct
  type t = (int * int) list

  (* takes two points and expands it into lines *)
  let make = function
    (* vertical lines *)
    | ((x1, y1), (x2, y2)) when x1 = x2 ->
      List.init (Int.abs(y1 - y2) + 1) ~f: (fun i -> (x1, (Int.min y1 y2) + i))

    (* horizontal lines *)
    | ((x1, y1), (x2, y2)) when y1 = y2 ->
      List.init (Int.abs(x1 - x2) + 1) ~f: (fun i -> ((Int.min x1 x2) + i, y1))

    | _ -> []

  (* 1,1 -> 1,3 *)
  let parse line_str =
    line_str
    |> String.split ~on: ' '
    |> function
    | [part1; "->"; part2] -> make (Point.parse part1, Point.parse part2)
    | _ -> failwith "not a valid line"
end

module Lines = struct
  let points_with_overlap ~n (lines : (int * int) list list) =
    lines
    |> Caml.List.flatten
    |> List.sort ~compare: Point.compare
    |> List.group ~break: Point.(<>)
    |> List.filter ~f: (fun l -> (List.length l >= n))
end

module Input = struct
  let parse file =
    file
    |> In_channel.read_lines
    |> List.map ~f: Line.parse
end

let () =
  Input.parse "input"
  |> Lines.points_with_overlap ~n: 2
  |> List.map ~f: (fun list -> List.map list ~f: Point.display)
  |> List.map ~f: (fun l -> String.concat l ~sep: " ")
  |> List.iter ~f: print_endline
