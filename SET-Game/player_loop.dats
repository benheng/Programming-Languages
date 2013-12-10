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

staload "./SetGame.sats"

implement player_loop (table) = let
  val (c1, c2, c3, opt) = get_user_input ()
in
  if opt = 0 then println! ("Exiting game.")
  else if opt = 1 then {      // 1: print table
    val () = print_cards (table)
    val () = player_loop ()
  }
  else if opt = 2 then {      // 2: print results
    val () = print_results()
    val () = player_loop ()
  }

  else if opt = 100 then let    // 3: input guesses
      val c1 = table.cards[c1]
      val c2 = table.cards[c2]
      val c3 = table.cards[c3]
    in
      if is_set(c1, c2, c3) then (
        if is_unique_set (c1, c2, c3, table) then {
          val () = add_set (c1, c2, c3, table)
          val () = println! ("Set added! Type 'results' to see Results Table.")
        }
        else println! ("That set already exists!")
      )
      else println! ("That's not a valid set!")
      player_loop ()
    end

  else {
    val () = println! ("Invalid Command. Please try again.")
    player_loop ()
  }
end // end of [player_loop]



implement is_unique set (c1, c2, c3, table) = let
  val size = int_of_size ( array0_size {array0(card_t)} (table.results) )
  fun loop (c1: card_t, c2: card_t, c3: card_t, A: array0 (array0 (card_t)), i: int, s: int): bool = (
    if i = size then true
    else let
      val rc1 = table.results[i][0]
      val rc2 = table.results[i][1]
      val rc3 = table.results[i][2]
    in
      if (c1 = rc1 && c2 = rc2 && c3 = rc3) then false else loop (c1, c2, c3, table, i+1, s)
    end
  )
in
  loop (c1, c2, c3, table, 0, size)
end // end of [is_unique_set]
