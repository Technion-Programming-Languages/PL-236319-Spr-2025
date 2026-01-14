(* --- Types Definitions --- *)
datatype token =
    TokAtom of string | TokVar of string | TokNum of string | TokString of string
  | True | False | PlaceHolder | Or | Query | ColonDash | Dot | Comma
  | LParen | RParen | LBracket | RBracket | Bar | Negation

datatype term =
    Const of string
  | Var of string
  | Compound of string * (term list)
  | List of term list * term option

datatype clause =
    Fact of term
  | Rule of term * (term list)
  | QueryClause of term list

exception ParseError of string

(* --- Tokenizer --- *)
fun tokenize (s : string) : token list =
    (* implenent *)

(* --- Parser --- *)
(*
It is HIGHLY recommended to implement helper functions for parsing terms, clauses, etc.
*)

fun parseClause (Query :: rest) = 
    (* implement *)

(* --- Unification Algorithm --- *)

(* a dictionary of substitutions *)
type substitution = (string * term) list

fun unify (t1, t2, subst) =
    (* implement *)

(* --- solver --- *)

fun solve db query =
    (* implement *)
