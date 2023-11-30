open OUnit2
open Aoc_04.Lib

let test_full_overlap _ctx =
  assert_equal true (SectionAssignments.has_full_overlap (2,8) (3,7));
  assert_equal true (SectionAssignments.has_full_overlap (3,7) (2,8));
  assert_equal false (SectionAssignments.has_full_overlap (1,6) (4,7))

let test_overlap _ctx =
  assert_equal true (SectionAssignments.has_overlap (5,7) (7,9));
  assert_equal true (SectionAssignments.has_overlap (3,7) (2,8));
  assert_equal false (SectionAssignments.has_overlap (1,3) (4,7))


let suite =
"suite">:::
 [
  "full overlap">:: test_full_overlap;
  "overlap">:: test_overlap;
 ]
;;

let () =
  run_test_tt_main suite
;;
