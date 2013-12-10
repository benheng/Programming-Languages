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

implement player_loop (table) = let
  val (c1, c2, c3, opt) = get_user_input ()
in
  if opt = 0 then println! ("Exiting game.")
  else if opt = 1 then {      // 1: print table
    val () = print_cards ()
    val () = player_loop ()
  }
  else if opt = 2 then {      // 2: print results
    val () = print_results()
    val () = player_loop ()
  }

  (*
  else if opt = 3 then let    // 3: input guesses
      val c1 = // convert (int)c1 into a corresponding card_t
      val c2 = // convert (int)c2 into a corresponding card_t
      val c3 = // convert (int)c3 into a corresponding card_t
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
  *)

  else {
    val () = println! ("Invalid Command. Please try again.")
    player_loop ()
  }
end
