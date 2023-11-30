open Core

let is_marker chars = not (List.contains_dup chars ~compare:compare_char)

let marker_finder marker_length =
  let rec find_marker ?(pos = 0) stream =
    let header = List.take stream marker_length in
    if is_marker header then (pos + marker_length, String.of_char_list header)
    else find_marker (List.drop stream 1) ~pos:(pos + 1)
  in
  find_marker
