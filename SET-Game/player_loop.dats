//
// Player Loop:
//    OPT is a new output to the return array; it allows the c parser
//    to distinguish between entries or commands in the same command
//    line. For example, you can enter numbers directly to guess or
//    "cards" to print the board and "results" to print the current
//    results array. Error checking is done within the parser.
//
//    Additional commands can be added as necessary.
//

%{^
#include "parser.cats"
%}

#include "share/atspre_staload.hats"

extern fun get_user_input(): ptr = "mac#"

staload UN = "prelude/SATS/unsafe.sats"
staload "./SetGame.sats"
staload "./SetGame.dats"
staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/array0.sats"
staload "libats/ML/DATS/array0.dats"
staload "libc/SATS/stdlib.sats"
staload "libc/SATS/unistd.sats"

implement print_cards (A) = let
  val size = A.size
  val size = $UN.cast2int{size_t}(size)
  fun loop (i: int): void = (
    if (i = size) then ()
    else let
        val card = A[i]
        val () = print_card (card)
      in
        loop (i+1)
      end
  )
in
  loop(0)
end // end of [print_cards]

implement print_results (AA) = let
  val size = AA.size
  val size = $UN.cast2int{size_t}(size)
  fun loop (i: int): void = (
    if i != size then let
        val () = println! ("\t============== Set #", i+1, " ================")
        val cards = AA[i]
        val () = print_cards (cards)
      in
        loop (i+1)
      end
    else ()
  )
in
  loop(0)
end // end of [print_results]

implement is_unique_set (c1, c2, c3, AA) = let
  val size = AA.size
  val size = $UN.cast2int{size_t}(size)
  fun loop (c1: card_t, c2: card_t, c3: card_t, AA2: array0 (array0 (card_t)), i: int, s: int): bool = (
    if i = size then true
    else let
      val rr = AA[i]
      val () = print_cards(rr)
      val rc1 = rr[0]
      val rc2 = rr[1]
      val rc3 = rr[2]
    in
      if (c1 = rc1 && c2 = rc2 && c3 = rc3) then false else loop (c1, c2, c3, AA2, i+1, s)
    end
  )
in
  loop (c1, c2, c3, AA, 0, size)
end // end of [is_unique_set]

implement add_set (c1, c2, c3, AA, i) = let
  val rr = AA[i]
  val () = rr[0] := c1
  val () = rr[1] := c2
  val () = rr[2] := c3
in
end // end of [add_set]

implement player_loop (table, size_of_res, res_found) = let
  val A = get_user_input ()
  val A = $UN.cast{arrayref(int, 4)}(A)
  val c1_int = A[0]
  val c2_int = A[1]
  val c3_int = A[2]
  val opt = A[3]
  val cards = table.cards
  val results = table.results
in
  if opt = 0 then println! ("Exiting game.")
  else if opt = 1 then let        // 1: print table
      val () = print_cards (cards)
    in
      player_loop (table, size_of_res, res_found)
    end
  else if opt = 2 then let        // 2: print results
      val () = print_results(results)
    in
      player_loop (table, size_of_res, res_found)
    end
  else if opt = 100 then let    // 100: input guesses
      val c1 = cards[c1_int]
      val c2 = cards[c2_int]
      val c3 = cards[c3_int]
      val set = is_set(c1, c2, c3)
    in
      if (set = 1) then (
        if is_unique_set (c1, c2, c3, results) then let
            val () = add_set (c1, c2, c3, results, res_found)
            val () = println! ("Set added! Type 'results' to see Results Table.")
          in
	        if (size_of_res = res_found+1) then let
	            val () = print_results (results)
	            val () = println! ("Woop woop you win!")
	          in
	          end
	        else player_loop (table, size_of_res, res_found+1)
          end
        else let
            val () = println! ("You've already found that set!")
            val () = player_loop (table, size_of_res, res_found)
          in
          end
      )
      else let
          val () = println! ("That's not a valid set!")
        in
          player_loop (table, size_of_res, res_found)
        end
    end
    
  else let
      val () = println! ("Invalid Command. Please try again.")
    in
      player_loop (table, size_of_res, res_found)
    end
end // end of [player_loop]
