(*first part*)
datatype Atom = SYMBOL of string | NIL;
datatype SExp = ATOM of Atom | CONS of (SExp * SExp);

exception Undefined;
exception Empty;

fun initEnv () : string -> SExp = fn exp => raise Undefined;

fun define str oldEnv valToBind=fn exp:string=> if str=exp then valToBind else oldEnv exp;

fun emptyNestedEnv()=[initEnv()];

fun pushEnv element oldEnv=element::oldEnv;

fun popEnv [] = raise Empty
  | popEnv (x::xs)=xs;
  
fun topEnv [] = raise Empty
  | topEnv (x::xs)=x;

fun defineNested _ [] _ = raise Empty
  | defineNested str stack valToBind=(define str (topEnv stack) valToBind)::popEnv stack;
  
( * TODO: your implementation for find *)
