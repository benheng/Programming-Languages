(* ****** THE SET GAME ****** *)
(* Final project
 * CS 520
 * December 10, 2013
 *
 * Erik Geil
 * Ben Heng
 *)

(* ****** ****** *)

#include
"share/atspre_staload.hats"

(* ****** ****** *)

staload "./SetGame.sats"
dynload "./SetGame.sats"
dynload "./SetGame.dats"
dynload "./player_loop.dats"

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/array0.sats"
staload _ = "libats/ML/DATS/array0.dats"
staload "libc/SATS/stdlib.sats"
staload "libc/SATS/unistd.sats"
staload UN = "prelude/SATS/unsafe.sats"
staload TIME = "libc/SATS/time.sats"
staload STDLIB = "libc/SATS/stdlib.sats"


(* ****** ****** *)

fun print_welcome():void = let
  val () = println! ("###############################################")
  val () = println! ("################# THE SET GAME ################")
  val () = println! ("###############################################")
  val () = println! ("            Welcome to the Set Game !!!      \n")
  val () = println! ("The Game:\n Find all groups of 3 cards that form a set!")
  val () = println! ("A set is 3 cards whose characteristics are\neither all the same or all different.")
  val () = println! ("Try to find them all!!!\n")

in
  (*void*)
end // end of [print_welcome]

fun print_commands():void = let
  val () = println! ("Commands:")
  val () = println! ("\tx y z   - Checks the cards with indices\n\t        x y z to see if they are a set.")
  val () = println! ("\tcards   - Prints the cards in play.")
  val () = println! ("\tresults - Prints the sets that have\n\t          been found.")
  val () = println! ("\texit    - Exit the game.")
  val () = println! ("\tquit    - Quit the game.\n")
in
  (*void*)
end // end of [print_commands]

implement main0() = let
  val () = $STDLIB.srand ($UN.cast{uint}($TIME.time_get()))
  val () = print_welcome()
  val () = print_commands()
  val () = println!("Please Wait...")
  //
  val t = generate_table()
  val () = println!("\nThe Table:\n")
  val () = print_cards(t.cards)
  val () = println!("\nEnter Command:\n")
  //
  val A = t.results
  val size = A.size
  val size = $UN.cast2int{size_t}(size)
  val () = player_loop(t, size, 0)
in
  (*void*)
end // end of [main0]

(* ****** ****** *)

(* end of [main.dats] *)
