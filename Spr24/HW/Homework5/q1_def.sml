datatype 'a DSeq = DNil | DCons of 'a * (unit -> 'a DSeq) * (unit -> 'a DSeq);
datatype 'a Seq = Nil | Cons of 'a * (unit -> 'a Seq);

fun coords (3, _) = DNil
  | coords (_, 3) = DNil
  | coords (x, y) = DCons((x, y), fn () => coords (x + 1, y), fn () => coords (x, y + 1));
  
val s = coords (0, 0);

fun next Nil = Nil
  | next (Cons(x, xf)) = xf ();
  
fun take s 0 = []
  | take Nil _ = []
  | take (Cons (x, xf)) n = x :: take (xf ()) (n - 1);

fun pcoords (3, _) = DNil
  | pcoords (_, 3) = DNil
  | pcoords (x, y) = (
    print ("exec: (" ^ Int.toString x ^ ", " ^  Int.toString y ^ ")\n"); 
    DCons((x, y), fn () => pcoords (x, y + 1), fn () => pcoords (x + 1,y))
  );
  
val p = pcoords (0, 0);