(* ****** THE SET GAME ****** *)
(*
// CS 520
// Final Project
//
// Erik Geil
// Ben Heng
//
*)

(* ****** ****** *)

staload "./SetGame.sats"

(* ****** ****** *)

#include
"share/atspre_staload.hats"

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/array0.sats"
staload _ = "libats/ML/DATS/array0.dats"
staload "libc/SATS/stdlib.sats"
staload "libc/SATS/unistd.sats"

(* ****** ****** *)
// Some essential functions.

implement is_equal_card(c1, c2) = let
  val clr = (c1.color = c2.color)
  val shp = (c1.shape = c2.shape)
  val shd = (c1.shading = c2.shading)
  val num = (c1.number = c2.number)
in
  if (clr&&shp&&shd&&num) then true else false
end // end of [is_equal_card]
overload = with is_equal_card

implement is_unique(c, A) = let
  fun loop(c1: card_t, A: array0 (card_t), i: int): bool = let
  in
    if i = 12 then false
    else let
      val c2 = A[i]
    in
      if c1 = c2 then true else loop(c1, A, i+1)
    end // end of [else]
  end // end of [loop]
in
  loop(c, A, 0)
end // end of [is_unique]

implement is_set (c1: card, c2: card, c3: card): int = let
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

(* ****** ****** *)
// Functions to generate our table


// Return the value to represent a characteristic
// of a card.
implement get_value() = let
  val res = rand() mod 3
in
  res
end // end of [get_value]

// Generate a card.
implement generate_card(ind) = let
  val clr = get_value()
  val shp = get_value()
  val shd = get_value()
  val num = get_value()
  
  val card = @{ color= clr, shape= shp, shading= shd, number= num, ind= ind} : card_t
in
  card
end // end of [generate_card]

// adds a unique card to an array at given index.
implement add_card(A, i) = let
  val card = generate_card(i)
  val is_uniq = is_unique(card, A)
in
  if is_uniq then add_card(A, i) 
  else let
    val () = A[i] := card 
  in
    (*nothing*)
  end // end of [else]
end // end of [add_card]

// Returns the number of set in an array of cards.
implement check_sets(cards) = let
  
  fun aux3(i:int, j:int, k:int):<cloref1> int = let
  in
    if k = 12 then 0
    else is_set(cards[i], cards[j], cards[k]) + aux3(i, j, k+1)
  end // end of [aux3] 
  
  
  fun aux2(i:int, j: int):<cloref1> int = let
  in
    if j = 11 then 0
    else aux3(i, j, j+1) + aux2(i, j+1)  
  end // end of [aux2]
  
  fun aux1(i: int):<cloref1> int = let
  in
    if i = 10 then 0 
    else aux2(i, i+1) + aux1(i+1)
  end // end of [aux1]
  //val cards = t.cards
in
  aux1(0)
end // end of [check_sets]

// Generates a table that contains 12 random cards.
implement generate_table() = let
  
  // Generates an array of 12 cards.
  fun loop(i: int, A: array0 (card_t)): void = let
    //val () = println! (i)
  in
    if i = 0 then ()
    else let
      val () = add_card(A, i-1)
    in
      loop(i-1, A)
    end // end of [else]
  end // end of [loop]
  
  val asz = size_of_int(12)
  val init = generate_card(13)
  val cards = array0_make_elt(asz, init)
  val () = loop(12, cards)
  val () = println! ("Passed Step 1")
  val num_sets = check_sets(cards)
  val () = println!(num_sets)
 
in
  // if there are no sets, then regenerate the cards.
  if num_sets = 0 then generate_table()
  else let
    //
    val asz2_a = size_of_int (num_sets)
    val asz2_b = size_of_int(3)
    val init2 = array0_make_elt(asz2_b, init)
    val results = array0_make_elt(asz2_a, init2)
    //
    val t = @{ cards=cards, results=results} : table_t
  in
    t
  end // end of [else]
end // end of [generate_table]

(* ****** ****** *)

(* end of [SetGame.dats] *)
