use "hw3_q3.sml";

(* 
    To run this test, place hw3_q3.sml in the terminal's working directory,
    then execute: 
        smlnj test_parse.sml
*)

let
    exception TestFailure of string;

    local
        fun sexp_to_string (ATOM(SYMBOL s)) = s
        | sexp_to_string (ATOM NIL) = "NIL"
        | sexp_to_string (CONS (x, y)) = "(" ^ sexp_to_string x ^ "." ^ sexp_to_string y ^ ")";
    in
        fun assert_equal (expected, actual, msg) =
            if expected = actual then ()
            else raise TestFailure (msg ^ ": expected " ^ sexp_to_string expected ^ ", but got " ^ sexp_to_string actual);
    end;

    fun run_tests tests =
        let
            fun runTest (name, test) =
                (print ("Running " ^ name ^ "... ");
                (test ();
                print "Passed\n") handle
                    TestFailure msg => print ("Failed - " ^ msg ^ "\n"))
        in
            List.app runTest tests
        end;

    fun tokenize x = 
    String.tokens (fn c: char => c = #" ") 
        (String.translate (fn #"(" => "( " | #")" => " )" | c => str c) x);
                                                        
    val parse_tests = [
        ("Test single symbol",
            fn () => let
                val input = "x"
                val expected = ATOM(SYMBOL "x")
                val actual = parse (tokenize input)
            in
                assert_equal (expected, actual, "Test single symbol")
            end),

        ("Test list with single element",
            fn () => let
                val input = "(x)"
                val expected = CONS(ATOM(SYMBOL "x"), ATOM NIL)
                val actual = parse (tokenize input)
            in
                assert_equal (expected, actual, "Test list with single element")
            end),

        ("Test empty list",
            fn () => let
                val input = "()"
                val expected = ATOM NIL
                val actual = parse (tokenize input)
            in
                assert_equal (expected, actual, "Test empty list")
            end),
        
        ("Test nested lists",
            fn () => let
                val input = "(a (b c) d)"
                val expected = CONS(
                    ATOM(SYMBOL "a"),
                    CONS(
                        CONS(
                            ATOM(SYMBOL "b"),
                            CONS(
                                ATOM(SYMBOL "c"),
                                ATOM NIL)),
                        CONS(
                            ATOM(SYMBOL "d"),
                            ATOM NIL)))
                val actual = parse (tokenize input)
            in
                assert_equal (expected, actual, "Test nested lists")
            end),

        ("Test simple list",
            fn () => let
                val input = "(a b c)"
                val expected = CONS(
                    ATOM(SYMBOL "a"),
                    CONS(
                        ATOM(SYMBOL "b"),
                        CONS(
                            ATOM(SYMBOL "c"),
                            ATOM NIL)))
                val actual = parse (tokenize input)
            in
                assert_equal (expected, actual, "Test simple list")
            end),

        ("Test list with nested empty lists",
            fn () => let
                val input = "(a () b)"
                val expected = CONS(
                    ATOM(SYMBOL "a"),
                    CONS(
                        ATOM NIL,
                        CONS(
                            ATOM(SYMBOL "b"),
                            ATOM NIL)))
                val actual = parse (tokenize input)
            in
                assert_equal (expected, actual, "Test list with nested empty lists")
            end),

        ("Test deeply nested lists",
            fn () => let
                val input = "(a (b (c (d e))))"
                val expected = CONS(
                    ATOM(SYMBOL "a"),
                    CONS(
                        CONS(
                            ATOM(SYMBOL "b"),
                            CONS(
                                CONS(
                                    ATOM(SYMBOL "c"),
                                    CONS(
                                        CONS(
                                            ATOM(SYMBOL "d"),
                                            CONS(
                                                ATOM(SYMBOL "e"),
                                                ATOM NIL)),
                                        ATOM NIL)),
                                ATOM NIL)),
                        ATOM NIL))
                val actual = parse (tokenize input)
            in
                assert_equal (expected, actual, "Test deeply nested lists")
            end),

        ("Test complex expression",
            fn () => let
                val input = "(define (square x) (* x x))"
                val expected = CONS(
                    ATOM(SYMBOL "define"),
                    CONS(
                        CONS(
                            ATOM(SYMBOL "square"),
                            CONS(
                                ATOM(SYMBOL "x"),
                                ATOM NIL)),
                        CONS(
                            CONS(
                                ATOM(SYMBOL "*"),
                                CONS(
                                    ATOM(SYMBOL "x"),
                                    CONS(
                                        ATOM(SYMBOL "x"),
                                        ATOM NIL))),
                            ATOM NIL)))
                val actual = parse (tokenize input)
            in
                assert_equal (expected, actual, "Test complex expression")
            end),

        ("Test mixed atoms and lists",
            fn () => let
                val input = "(a (b) c (d e) f)"
                val expected = CONS(
                    ATOM(SYMBOL "a"),
                    CONS(
                        CONS(
                            ATOM(SYMBOL "b"),
                            ATOM NIL),
                        CONS(
                            ATOM(SYMBOL "c"),
                            CONS(
                                CONS(
                                    ATOM(SYMBOL "d"),
                                    CONS(
                                        ATOM(SYMBOL "e"),
                                        ATOM NIL)),
                                CONS(
                                    ATOM(SYMBOL "f"),
                                    ATOM NIL)))))
                val actual = parse (tokenize input)
            in
                assert_equal (expected, actual, "Test mixed atoms and lists")
            end),

        ("Test complex lambda",
            fn () => let
                val input = "(lambda (x) (lambda (y) (lambda (z) (f x y z))))"
                val expected = CONS(
                    ATOM(SYMBOL "lambda"),
                    CONS(
                        CONS(
                            ATOM(SYMBOL "x"),
                            ATOM NIL),
                        CONS(
                            CONS(
                                ATOM(SYMBOL "lambda"),
                                CONS(
                                    CONS(
                                        ATOM(SYMBOL "y"),
                                        ATOM NIL),
                                    CONS(
                                        CONS(
                                            ATOM(SYMBOL "lambda"),
                                            CONS(
                                                CONS(
                                                    ATOM(SYMBOL "z"),
                                                    ATOM NIL),
                                                CONS(
                                                    CONS(
                                                        ATOM(SYMBOL "f"),
                                                        CONS(
                                                            ATOM(SYMBOL "x"),
                                                            CONS(
                                                                ATOM(SYMBOL "y"),
                                                                CONS(
                                                                    ATOM(SYMBOL "z"),
                                                                    ATOM NIL)))),
                                                    ATOM NIL))),
                                        ATOM NIL))),
                            ATOM NIL)))
                val actual = parse (tokenize input)
            in
                assert_equal (expected, actual, "Test complex lambda")
            end)
    ];
in
    run_tests parse_tests
end;
