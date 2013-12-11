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


(* ****** ****** *)

implement main0() = let
  val t = generate_table()
  val A = t.results
  val size = A.size
  val size = $UN.cast2int{size_t}(size)
  val () = player_loop(t, size, 0)
in
end // end of [main0]

(* ****** ****** *)

(* end of [main.dats] *)
