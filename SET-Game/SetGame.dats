(* ****** THE SET GAME ****** *)
(*
// CS 520
// Final Project
//
// Erik Geil
// Ben
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
    if i = 12 then true
    else let
      val c2 = A[i]
    in
      if c1 = c2 then false else loop(c1, A, i+1)
    end // end of [else]
  end // end of [loop]
in
  loop(c, A, 0)
end // end of [is_unique]

implement is_set(c1, c2, c3) = let

  fun check_type(i:int, j: int, k:int): bool = let
  in
    if ((i+j+k) mod 3 = 0) then true else false
  end // end of [check_type]

  val color = check_type(c1.color, c2.color, c3.color)
  val shape = check_type(c1.shape, c2.shape, c3.shape)
  val shade = check_type(c1.shading, c2.shading, c3.shading)
  val num = check_type(c1.number, c2.number, c3.number)
in
  if (color&&shape&&shade&&num) then 1 else 0
end // end of [is_set]

(* ****** ****** *)

implement get_color(c) = let
  val color = c.color
in
  if color = 1 then "Red"
  else if color = 2 then "Green"
  else if color = 3 then "Blue"
  else let
    val () = println!("Invalid Color")
  in
    ""
  end // end of [else]
end // end of [get_color]

implement get_shape(c) = let
  val shape = c.shape
in
  if shape = 1 then "Square"
  else if shape = 2 then "Triangle"
  else if shape = 3 then "Circle"
  else let
    val () = println!("Invalid Shape")
  in
    ""
  end // end of [else]
end // end of [get_shape]

implement get_shade(c) = let
  val shade = c.shading
in
  if shade = 1 then "Solid"
  else if shade = 2 then "Striped"
  else if shade = 3 then "Empty"
  else let
    val () = println!("Invalid Shading")
  in
    ""
  end // end of [else]
end // end of [get_shade]

implement print_card(c) = let
  val ind = c.ind
  val num = c.number
  val () = println!(ind,": ",get_color(c)," | ",get_shape(c)," | ",get_shade(c)," | ",num)
in
  (*nothing*)
end // end of [print_card]

(* ****** ****** *)
// Functions to generate our table


// Return the value to represent a characteristic
// of a card.
implement get_value() = let
  val res = rand() mod 3 + 1
  //val () = println!(res)
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
    val asz2_a = size_of_int(12)
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
