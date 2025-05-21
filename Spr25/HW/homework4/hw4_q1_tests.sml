use "hw4_q1.sml";

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

    val env_tests = [
        ("Test find",
            fn () => let
                val env1 = define "x" (initEnv ()) (ATOM (SYMBOL "value1"))
                val env2 = define "x" (initEnv ()) (ATOM (SYMBOL "value2"))
                val stack = pushEnv env1 (pushEnv env2 [])
                val expected = ATOM (SYMBOL "value1")
                val actual = find "x" stack
            in
                assert_equal (expected, actual, "Test find")
            end)
    ];
in
    run_tests env_tests
end;