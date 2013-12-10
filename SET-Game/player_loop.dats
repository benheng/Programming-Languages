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
staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/array0.sats"
staload _ = "libats/ML/DATS/array0.dats"
staload "libc/SATS/stdlib.sats"
staload "libc/SATS/unistd.sats"

implement player_loop (table, size_of_res, res_found) = let
  val A = get_user_input ()
  val A = $UN.cast{arrayref(int, 4)}(A)
  val c1_int = A[0]
  val c2_int = A[1]
  val c3_int = A[2]
  val opt = A[3]
in
  if opt = 0 then println! ("Exiting game.")
  else if opt = 1 then (        // 1: print table
    print_cards (table.cards)
    player_loop (table, size_of_res, res_found)
  )
  else if opt = 2 then (        // 2: print results
    print_results(table.results)
    player_loop (table, size_of_res, res_found)
  )
  (*
  else if opt = 100 then let    // 100: input guesses
  	  val cards = table.cards
  	  val results = table.results
      val c1 = cards[c1_int]
      val c2 = cards[c2_int]
      val c3 = cards[c3_int]
    in
      if is_set(c1, c2, c3) then (
        if is_unique_set (c1, c2, c3, results) then (
          add_set (c1, c2, c3, results, res_found)
          println! ("Set added! Type 'results' to see Results Table.")
          if size_of_res = res_found+1 then (
            print_results (results)
            println! ("Woop woop you win!")
          )
          else player_loop (table, size_of_res, res_found+1)
        )
        else (
          println! ("You've already found that set!")
          player_loop (table, size_of_res, res_found)
        )
      )
      else (
        println! ("That's not a valid set!")
        player_loop (table, size_of_res, res_found)
      )
    end
    *)
    
  else (
    println! ("Invalid Command. Please try again.")
    player_loop (table, size_of_res, res_found)
  )
end // end of [player_loop]

implement print_cards (A) = let
  val size = int_of_size ( array0_size {card_t} (A) )
  fun loop (i: int): void = (
    if i != size then let
        val card = A[i]
      in
        print_card (card)
        loop (i+1)
      end
    else ()
  )
in
  loop(0)
end // end of [print_cards]

implement print_results (AA) = let
  val size = int_of_size ( array0_size {array0(card_t)} (AA) )
  fun loop (i: int): void = (
    if i != size then (
      println! ("=== Set #", i, " ===================================")
      print_cards (AA[i])
      loop (i+1)
    )
    else ()
  )
in
  loop(0)
end // end of [print_results]

implement is_unique_set (c1, c2, c3, AA) = let
  val size = int_of_size ( array0_size {array0(card_t)} (AA) )
  fun loop (c1: card_t, c2: card_t, c3: card_t, AA2: array0 (array0 (card_t)), i: int, s: int): bool = (
    if i = size then true
    else let
      val results = table.results
      val rr = results[i]
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
