open Core

module Move = struct
  type t = Rock | Paper | Scissors

  let parse = function
    | "A" | "X" -> Rock
    | "B" | "Y" -> Paper
    | "C" | "Z" -> Scissors
    | _ -> failwith "not a valid move"

  let display = function
    | Rock -> "Rock"
    | Paper -> "Paper"
    | Scissors -> "Scissors"
end

module Round = struct
  type t = (Move.t * Move.t)

  (* A X *)
  let parse line_str =
    line_str
    |> String.split ~on: ' '
    |> function
    | [move1; move2] -> (Move.parse move1, Move.parse move2)
    | _ -> failwith "not a valid line"
end

module Game = struct
  type outcome = Draw | Win | Loose

  let score_for_outcome = function
    | Win -> 6
    | Draw -> 3
    | Loose -> 0

  let score_for_move = function
    | (_, Move.Rock) -> 1
    | (_, Move.Paper) -> 2
    | (_, Move.Scissors) -> 3

  let outcome = function
    | (Move.Rock, Move.Paper) -> Win
    | (Move.Paper, Move.Scissors) -> Win
    | (Move.Scissors, Move.Rock) -> Win
    | (x, y) when phys_same x y -> Draw
    | _ -> Loose

  let play_round round =
    let outcome = outcome round in
      score_for_move round + score_for_outcome outcome

  let play rounds =
    rounds
    |> List.map ~f: play_round
    |> List.reduce ~f: (+)
end

module Input = struct
  let parse file =
    file
    |> In_channel.read_lines
    |> List.map ~f: Round.parse
end

let () =
  Input.parse "input"
  |> Game.play
  |> Option.value_exn
  |> printf "%d\n"
