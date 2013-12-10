(* ****** THE SET GAME ****** *)
(*
// CS520
// Final Project
//
// Erik Geil
// Ben Heng
//
*)

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/array0.sats"
staload _ = "libats/ML/DATS/array0.dats"

(* ****** ****** *)

//
// The datatypes that we need for the game:
//        card_t:  A single card.
//        table_t: The table, where the current
//                 cards are stored.
//
typedef card_t = @{ color= int, shape= int, shading= int, number= int, ind= int}
typedef table_t = @{ cards= array0(card_t), results= array0(array0(card_t)) }

(* ****** ****** *)

//
// Some essential functions
//

// Tests if two cards are the same
fun is_equal_card(c1: card_t, c2: card_t): bool

// Checks if a generated card is unique on the table
fun is_unique(c: card_t, A: array0 (card_t)): bool

// Checks if the given three cards form a set
// and returns 1 if true and 0 if false.
fun is_set(card_t, card_t, card_t): int

(* ****** ****** *)
// Functions to print to screen.

// Get Color.
fun get_color(c: card_t): string

// Get Shape.
fun get_shape(c: card_t): string

// Get Shade
fun get_shade(c: card_t): string

// Prints a single card.
fun print_card(c: card_t): void


(* ****** ****** *)

//
// Here are the functions needed for
// generating the table of cards.
//

// Generates a random number between 1 and 3
// to represent a characteristic of a card.
fun get_value((*void*)): int

// Generates a single card.
fun generate_card(ind: int): card_t

// Adds a card new, unique card to a given array at the
// given index.
fun add_card(A: array0 (card_t), i: int): void

// Checks to see how many sets exist.
fun check_sets(cards: array0(card_t)): int

// Generates the table of cards.
fun generate_table((*void*)): table_t

(* ****** ****** *)

//
// Game functions
//

// Main game loop
fun player_loop (table_t, int, int): void

// Print playing cards
fun print_cards (array0(card_t)): void

// Print results table
fun print_results (array0(array0(card_t))): void

// Checks if set is unique
fun is_unique_set (card_t, card_t, card_t, table_t): bool

// Add sets to results array
fun add_set (card_t, card_t, card_t, table_t, int): void

(* ****** ****** *)

(* end of [SetGame.sats] *)
