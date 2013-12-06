
#include "share/atspre_staload.hats"

// NOTE: Assuming card (i: int, color: int, number: int, shading: int, shape: int)
// color, number, shading, shape represented as ints 1, 2, or 3 only to simplify
// and generalize check_type function.

// Define: valid sets include 111, 222, 333, and any non-repeating permutation of 123
// Conjecture: within a set of repeating permutations of 123, the sum of valid sets
//             is either 3, 6, or 9, i.e. divisible by 3.

//
// Tests to see if 3 cards form a valid SET
//
fun is_set (c1: card, c2: card, c3: card): int = let

  fun check_type (i: int, j: int, k: int): bool = (
    if ((i + j + k) % 3 = 0) then true else false
  )

in
  if (check_type (c1.1, c2.1, c3.1))              // checks 1st type: color
    then if (check_type (c1.2, c2.2, c3.2))       // checks 2nd type: number
      then if (check_type (c1.3, c2.3, c3.3))     // checks 3rd type: shading
        then if (check_type (c1.4, c2.4, c3.4))   // checks 4th type: shape
          then 1                                  // passes all checks
        else 0
      else 0
    else 0
  else 0
end // end of [is_set]
