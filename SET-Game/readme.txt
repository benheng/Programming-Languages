(* ****** ****** The Set Game ****** ****** *)
(* ****** ****** ************ ****** ****** *)
// Final Project
// CS 520
// December 10, 2013
//
// Authors:
//	Erik Geil
//	Ben Heng
//
(* **************************************** *)

This is a text-based implementation of The Set Game.

The Rules are as follows:
    Each card has 4 characteristics, each with 3 distinct options:
    	  - Color (Red | Blue | Green)
	      - Shape (Square | Triangle | Circle)
	      - Shade (Solid | Striped | Empty)
	      - Number (One | Two | Three)

    A Set is defined as a group of 3 cards where each of the four 
    characteristics follow one of the following properties
	      i) The characteristic on each card is the same
       	     ii) The characteristic on each card is unique

    If all characteristics fit these properties, then the cards
    for a set.
    	Example:
		    0: Red | Square | Solid | 1
		    1: Green | Circle | Solid | 2
		    2: Blue | Triangle | Solid | 3

	These 3 cards form a set.

    12 cards are dealt at the beginning of the game.  Your goal is to find
    all of the sets.

    The game is won once all sets have been found.

(* *************************************** *)

Commands:
	    x y z : checks to see if the three cards with indices x, y and z
	      	    are a set.  If so, then they add that set to the results
		          that have been found. Otherwise, it will tell you the set 
		          is invalid.
      	    cards : Prints out all the cards that have been dealt out on the
	            table. Prints out in the following format:
	    		Index: Color | Shape | Shade | Number

	    	       e.g. '1: Blue | Circle | Empty | 3'
		       	        '2: Red  | Circle | Solid | 2'
			             ...
			              '11: Green | Square | Empty | 3'
	

	    results : Prints out all of the results that you have currently
	  	          found.

	    exit : Exits the game.

	    quit : Quits the game.


(* *************************************** *)
