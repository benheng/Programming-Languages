
#include
"share/atspre_staload.hats"

staload "./SetGame.sats"
dynload "./SetGame.sats"
dynload "./SetGame.dats"


val c1 = generate_card(0)
val c2 = generate_card(1)
val () = println!(is_equal_card(c1, c2))

val t = generate_table()

implement main0() = 
{
//
val () = println! ("YAY!")
//
}
