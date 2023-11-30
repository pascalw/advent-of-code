open Core

module Move = struct
  type t = Rock | Paper | Scissors

  let parse = function
    | "A" -> Rock
    | "B" -> Paper
    | "C" -> Scissors
    | _ -> failwith "not a valid move"

  let display = function
    | Rock -> "Rock"
    | Paper -> "Paper"
    | Scissors -> "Scissors"
end

module Outcome = struct
  type t = Draw | Win | Loose
end

module Response = struct
  open Outcome

  let parse = function
    | "X" -> Loose
    | "Y" -> Draw
    | "Z" -> Win
    | _ -> failwith "not a valid response"
end

module Round = struct
  type t = (Move.t * Outcome.t)

  (* A X *)
  let parse line_str =
    line_str
    |> String.split ~on: ' '
    |> function
    | [opp_move; response] -> (Move.parse opp_move, Response.parse response)
    | _ -> failwith "not a valid line"
end

module Game = struct
  open Outcome

  let score_for_outcome = function
    | Win -> 6
    | Draw -> 3
    | Loose -> 0

  let score_for_move = function
    | Move.Rock -> 1
    | Move.Paper -> 2
    | Move.Scissors -> 3

  let outcome = function
    | (Move.Rock, Move.Paper) -> Win
    | (Move.Paper, Move.Scissors) -> Win
    | (Move.Scissors, Move.Rock) -> Win
    | (x, y) when phys_same x y -> Draw
    | _ -> Loose

  let determine_move = function
    | (Move.Rock, Win) -> Move.Paper
    | (Move.Paper, Win) -> Move.Scissors
    | (Move.Scissors, Win) -> Move.Rock
    | (Move.Rock, Loose) -> Move.Scissors
    | (Move.Paper, Loose) -> Move.Rock
    | (Move.Scissors, Loose) -> Move.Paper
    | (move, Draw) -> move

  let play_round (opp_move, response) =
    let my_move = determine_move (opp_move, response) in
    let outcome = outcome (opp_move, my_move) in
      score_for_move my_move + score_for_outcome outcome

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
