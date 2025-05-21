use "hw4_q2.sml";

(* 
//////////////////////////////////////////////////////
////////////////////// TESTS /////////////////////////
//////////////////////////////////////////////////////

⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠀⣘⣩⣅⣤⣤⣄⣠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄⢈⣻⣿⣿⢷⣾⣭⣯⣯⡳⣤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣧⠻⠿⡻⢿⠿⡾⣽⣿⣳⣧⡷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢰⡶⢈⠐⡀⠀⠀⠁⠀⠀⠀⠈⢿⡽⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢫⢅⢠⣥⣐⡀⠀⠀⠀⠀⠀⠀⢸⢳⠀⠀⠀⠀⠀⠀⠀⠀⠀keep⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠆⠡⠱⠒⠖⣙⠂⠈⠵⣖⡂⠄⢸⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀it⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⠆⠀⠰⡈⢆⣑⠂⠀⠀⠀⠀⠀⠏⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀rolling⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢗⠀⠱⡈⢆⠙⠉⠃⠀⠀⠀⠀⠃⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠦⡡⢘⠩⠯⠒⠀⠀⠀⢀⠐⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡄⢔⡢⢡⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⢆⠸⡁⠋⠃⠁⠀⢀⢠⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⡰⠌⣒⠡⠄⠀⢀⠔⠁⣸⣿⣷⣤⣀⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⣐⣤⡄⠀⠀⠘⢚⣒⢂⠇⣜⠒⠉⠀⢀⣿⣿⣿⣿⣿⣿⣿⣷⣶⣶⣦⣔⣀⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⡀⢀⢠⣤⣶⣿⣿⣿⡆⠀⠀⠐⡂⠌⠐⠝⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⢨⣶⣿⣿⣿⣿⣿⣿⣿⣿⣤⡶⢐⡑⣊⠀⡴⢤⣀⣀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠀⠷⡈⠀⠶⢶⣰⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀
⢾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣉⠑⠚⣙⡒⠒⠲⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡁⠀⠀⠀⠀⠀⠀⠀⠀
⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡷⠶⠀⠀⠤⣬⣍⣹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄⠀⠀⠀⠀⠀⠀⠀⠀
⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣛⣙⠀⢠⠲⠖⠶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣭⣰⢘⣙⣛⣲⣿⣿⣿⣿⡿⡻⠿⠿⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⡀⠀⠀⠀⠀
⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠶⢾⡠⢤⣭⣽⣿⣿⣿⣿⡟⣱⠦⠄⠤⠐⡄⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣤⡀⠀
⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡛⣻⡕⠶⠶⣿⣿⣿⣿⣿⣿⣗⣎⠒⣀⠃⡐⢀⠙⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀
⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣭⣹⣏⣛⣛⣿⣿⣿⣿⣿⣿⣿⣞⣍⣉⢉⠰⠀⠠⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠅
⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠶⢼⡧⢤⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣣⣡⣛⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣅
⡿⣷⣽⡿⠛⠋⠉⣉⡐⠶⣾⣾⣟⣻⡕⠶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣹⣫⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠗
⢸⣿⣟⣥⡶⢘⡻⢶⡹⣛⣼⣿⣯⣽⢯⣙⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⣿⣿⣿⣿⣿⣿⡿⠿⠟⠁⠀
⠘⢟⣾⣿⣿⣚⠷⣳⢳⣫⣽⣿⣛⣾⡷⢾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⠀⠁⠀⠈⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠙⢋⣿⣿⣯⣙⣯⣵⣿⣿⣯⣽⣟⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡯⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠉⠛⢻⠟⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣟⡟⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⣡⣿⣿⣿⣿⡗⣮⢻⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣧⣮⢻⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
*)

Control.Print.printLength := 100;
Control.Print.printDepth := 100;

fun first (x, _) = x;

fun print_atom (SYMBOL s) = s
  | print_atom NIL = "nil"

fun ends_with_nil (CONS (car, cdr)) = ends_with_nil cdr
  | ends_with_nil (ATOM NIL) = true
  | ends_with_nil _ = false

fun sexp_to_string (ATOM a) = print_atom a
  | sexp_to_string (CONS (car, cdr)) = "(" ^ print_cons (car, cdr) ^ ")"

and print_cons (car, ATOM NIL) = sexp_to_string car
  | print_cons (car, CONS (cadr, cddr)) = (case ends_with_nil (CONS (cadr, cddr)) of
      true => sexp_to_string car ^ " " ^ print_cons (cadr, cddr)
    | false => sexp_to_string car ^ " . " ^ sexp_to_string (CONS (cadr, cddr)))
  | print_cons (car, cdr) = sexp_to_string car ^ " . " ^ sexp_to_string cdr;

val env: (string -> SExp) list = emptyNestedEnv();

(* Test the evaluation of basic atoms *)
val test_simple1 = sexp_to_string (first (eval "()" env)) = "nil";

(* Test the evaluation of unknown atoms *)
val test_simple3 = sexp_to_string (first (eval "(unknown)" env)) = "lisp-error";

(* Test the evaluation of the cons function *)
val test_simple4 = sexp_to_string (first (eval "(cons 2 3)" env)) = "(2 . 3)";

(* Test the evaluation of nested cons functions *)
val test_simple5 = sexp_to_string (first (eval "(cons (cons 2 3) (cons 4 5))" env)) = "((2 . 3) . (4 . 5))";

(* Test the evaluation of the car function *)
val test_simple6 = sexp_to_string (first (eval "(car (cons 2 3))" env)) = "2";

(* Test the evaluation of the cdr function *)
val test_simple7 = sexp_to_string (first (eval "(cdr (cons 2 3))" env)) = "3";

(* Test the evaluation of the eq function *)
val test_simple8 = let 
                    val e = sexp_to_string (first (eval "(eq 2 2)" env))
                  in e <> "nil" andalso e <> "lisp-error" end;
val test_simple9 = sexp_to_string (first (eval "(eq 2 3)" env)) = "nil";

(* Test the evaluation of the atom function *)
val test_simple10 = sexp_to_string (first (eval "(atom (cons 2 3))" env)) = "nil";
val test_simple11 = let 
                    val e = sexp_to_string (first (eval "(atom 2)" env))
                  in e <> "nil" andalso e <> "lisp-error" end;

(* Test the evaluation of the cond function *)
val test_simple12 = sexp_to_string (first (eval "(cond ((eq 2 2) 3) ((eq 2 3) 4))" env)) = "3";
val test_simple13 = sexp_to_string (first (eval "(cond ((eq 2 3) 3) ((eq 3 4) 3) ((quote am-i-nil?) 4))" env)) = "4";
val test_simple14 = sexp_to_string (first (eval "(cond ((eq 2 2) 5))" env)) = "5";

(* Test the evaluation of the quote function *)
val test_simple15 = sexp_to_string (first (eval "(quote 2)" env)) = "2";
val test_simple16 = sexp_to_string (first (eval "(quote (2 3))" env)) = "(2 3)";

val test_simple17 = sexp_to_string (first (eval "(quote (1 2 3))" env)) = "(1 2 3)";

(* Test the evaluation of the lambda function *)
val test_simple18 = sexp_to_string (first (eval "((lambda (x) x) 2)" env)) = "2";
val test_simple19 = sexp_to_string (first (eval "((lambda (x y) (cons x y)) 2 3)" env)) = "(2 . 3)";
val test_simple20 = sexp_to_string (first (eval "((lambda (x y) (cons x y)) 2 (quote 3))" env)) = "(2 . 3)";
val test_simple21 = sexp_to_string (first (eval "((lambda (x y) (+ x y)) 2 3)" env)) = "5";
val test_simple22 = sexp_to_string (first (eval "((lambda (x y) (+ x y)) 2 3 4)" env)) = "lisp-error";

(* Test the evaluation of null *)
val test_simple23 = sexp_to_string (first (eval "(null (quote 2))" env)) = "nil";
val test_simple24 = let 
                    val e = sexp_to_string (first (eval "(null (quote ()))" env))
                  in e <> "nil" andalso e <> "lisp-error" end;

(* cons on quotes *)
val test_advanced1 = sexp_to_string (first (eval "(cons (quote 1) (quote 2))" env)) = "(1 . 2)";
val test_advanced2 = sexp_to_string (first (eval "(cons (quote 3) (cons (quote 1) (quote 2)))" env)) = "(3 . (1 . 2))";

(* car on cdr *)
val test_advanced3 = sexp_to_string (first (eval "(car (cdr (quote (1 2 3))))" env)) = "2";
val test_advanced4 = sexp_to_string (first (eval "(car (cdr (cdr (quote (1 2 3)))))" env)) = "3";
val test_advanced5 = sexp_to_string (first (eval "(car (cdr (cdr (cdr (quote (1 2 3))))))" env)) = "lisp-error";

(* cdr on car *)
val test_advanced6 = sexp_to_string (first (eval "(cdr (car (quote ((1 2) 3))))" env)) = "(2)";
val test_advanced7 = sexp_to_string (first (eval "(cdr (car (cdr (quote ((1 2) 3)))))" env)) = "lisp-error";

(* eq on cons *)
val test_advanced8 = sexp_to_string (first (eval "(eq (cons 1 2) (cons 1 2))" env)) = "nil";

(* math ops *)
val test_advanced9 = sexp_to_string (first (eval "(+ 1 2)" env)) = "3";
val test_advanced10 = sexp_to_string (first (eval "(- 1 2)" env)) = "~1";
val test_advanced11 = sexp_to_string (first (eval "(* 2 3)" env)) = "6";
val test_advanced12 = sexp_to_string (first (eval "(/ 6 2)" env)) = "3";
val test_advanced13 = sexp_to_string (first (eval "(mod 5 2)" env)) = "1";

(* comparison ops *)
val test_advanced14 = sexp_to_string (first (eval "(= 1 1)" env)) = "t";
val test_advanced15 = sexp_to_string (first (eval "(= 1 2)" env)) = "nil";
val test_advanced16 = sexp_to_string (first (eval "(/= 1 2)" env)) = "t";
val test_advanced17 = sexp_to_string (first (eval "(/= 1 1)" env)) = "nil";
val test_advanced18 = sexp_to_string (first (eval "(< 1 2)" env)) = "t";
val test_advanced19 = sexp_to_string (first (eval "(< 2 1)" env)) = "nil";
val test_advanced20 = sexp_to_string (first (eval "(> 2 1)" env)) = "t";
val test_advanced21 = sexp_to_string (first (eval "(> 1 2)" env)) = "nil";

(* nested lambda *)
val test_advanced22 = sexp_to_string (first (eval "((lambda (x) ((lambda (y) (cons x y)) (quote b))) (quote a))" env)) = "(a . b)";
val test_advanced23 = sexp_to_string (first (eval "((lambda (x) \
                                                    \((lambda (y) \
                                                        \(+ x y)) \
                                                    \3)) \
                                                \2)" env)) = "5";

(* nested lambda with cond *)
val test_advanced24 = sexp_to_string (first (eval "((lambda (x) \
                                                    \(cond \
                                                        \((eq x 1) 1) \
                                                        \((eq x 2) 2) \
                                                        \(t 3))) \
                                                \2)" env)) = "2";

val test_advanced25 = sexp_to_string (first (eval "((lambda (x) \
                                                    \((lambda (y) \
                                                        \(cond \
                                                            \((eq y 1) 1) \
                                                            \((eq y 2) 2) \
                                                            \(t 3))) \
                                                    \x)) \
                                                \2)" env)) = "2";

(* make sure lambda doesnt affect bindings *)
local
    val (_, env_with_x) = eval "((lambda (x) \
                                    \(cond \
                                        \((eq x 1) 1) \
                                        \((eq x 2) 2) \
                                        \(t 3))) \
                                \2)" env;
in
    val lambda_local = sexp_to_string ((find "x" env_with_x) handle 
                            Undefined => (ATOM (SYMBOL "good")) 
                            | _ => (ATOM (SYMBOL "bad"))) = "good"
end;

(* bonus: label *)
val test_advanced26 = sexp_to_string (first (eval "((label fact \
                                                    \(lambda (n) \
                                                        \(cond ((eq n 0) 1) \
                                                            \(t (* n (fact (- n 1))))))) \
                                                    \5)" env)) = "120";

val test_advanced27 = sexp_to_string (first (eval "((label fact \
                                                    \(lambda (n) \
                                                        \(cond ((eq n 0) 1) \
                                                            \(t (* n (fact (- n 1))))))) \
                                                    \((lambda (x) \
                                                    \((lambda (y) \
                                                        \(cond \
                                                            \((eq y 1) 1) \
                                                            \((eq y 2) 2) \
                                                            \(t 3))) \
                                                    \x)) \
                                                \2))" env)) = "2";

val test_advanced28 = sexp_to_string (first (eval "((label sum-list \
                                                     \(lambda (lst) \
                                                       \(cond ((null lst) 0) \
                                                             \(t (+ (car lst) (sum-list (cdr lst))))))) \
                                                    \(quote (1 2 3 4 5)))" env)) = "15";

val test_advanced29 = sexp_to_string (first (eval "((label sum-to-n \
                                                     \(lambda (n acc) \
                                                       \(cond ((eq n 0) acc) \
                                                             \(t (sum-to-n (- n 1) (+ acc n)))))) \
                                                    \10 0)" env)) = "55";

(* freestyle of combinations on atom, null, eq, car, cdr, cons *)
val freestyle1 = sexp_to_string (first (eval "(atom (quote (1 2 3)))" env)) = "nil";
val freestyle2 = let 
                    val e = sexp_to_string (first (eval "(null (quote ()))" env))
                  in e <> "nil" andalso e <> "lisp-error" end;
val freestyle3 = let 
                    val e = sexp_to_string (first (eval "(eq (car (quote (1 2 3))) 1)" env));
                  in e <> "nil" andalso e <> "lisp-error" end;
val freestyle4 = sexp_to_string (first (eval "(eq (cdr (quote (1 2 3))) (quote (2 3)))" env)) = "nil";