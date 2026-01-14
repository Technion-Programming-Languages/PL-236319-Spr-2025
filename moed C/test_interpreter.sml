use "solution.sml";

structure PrologTest = struct
    val testCount = ref 0
    val passCount = ref 0
    val totalWeight = ref 0.0
    val earnedWeight = ref 0.0

    fun runTest (name, prog, query, expectedSuccess, weight) =
        let
            val _ = testCount := !testCount + 1
            val _ = totalWeight := !totalWeight + weight

            val result =
                (let
                    val dbTokens = tokenize prog

                    fun parseDB [] = []
                    | parseDB tokens =
                        let
                            val (cls, rest) = parseClause tokens
                        in
                            cls :: parseDB rest
                        end

                    val db = parseDB dbTokens
                    val qTokens = tokenize query
                    val (QueryClause goals, _) = parseClause qTokens
                in
                    SOME (solve db goals)
                end)
                handle _ => NONE 

            val passed = case result of
                            SOME r => (r = expectedSuccess)
                          | NONE   => false
        in
            if passed then (
                passCount := !passCount + 1;
                earnedWeight := !earnedWeight + weight;
                print ("Test " ^ Int.toString (!testCount) ^ 
                       " PASSED: [" ^ name ^ "] (Weight: " ^ Real.toString weight ^ ")\n")
            )
            else (
                print ("Test " ^ Int.toString (!testCount) ^ 
                       " FAILED: [" ^ name ^ "]\n")
            )
        end


    fun runErrorTest (name, prog, query) =
        let
            val _ = testCount := !testCount + 1
            val passed =
                (ignore (
                    let
                        val dbTokens = tokenize prog
                        fun parseDB [] = []
                        | parseDB tokens =
                                let val (cls, rest) = parseClause tokens
                                in cls :: parseDB rest end
                        val db = parseDB dbTokens
                        val qTokens = tokenize query
                        val (QueryClause goals, _) = parseClause qTokens
                    in
                        solve db goals
                    end
                ); false)
                handle ParseError _ => true | _ => false
        in
            if passed then (
                passCount := !passCount + 1;
                print ("Test " ^ Int.toString (!testCount) ^
                    " PASSED (Caught Error): [" ^ name ^ "]\n")
            )
            else
                print ("Test " ^ Int.toString (!testCount) ^
                    " FAILED (Expected ParseError): [" ^ name ^ "]\n")
        end


fun execute () = (
        testCount := 0; passCount := 0;
        print("--- Running Prolog Interpreter Tests ---\n");

        testCount := 0; passCount := 0; 
        totalWeight := 0.0; earnedWeight := 0.0;

        (* Basic Test-weight 1.0 *)
        runTest("Atom Match", "p(a).", "?- p(a).", true, 1.0);
        runTest("Atom Mismatch", "p(a).", "?- p(b).", false, 1.0);
        runTest("Var Unify Const", "p(a).", "?- p(X).", true, 1.0);
        runTest("Var Unify Var", "p(X).", "?- p(Y).", true, 1.0);
        runTest("Double Var Constraint", "eq(X,X).", "?- eq(a,a).", true, 1.0);
        runTest("Nested Mismatch", "f(g(a)).", "?- f(h(a)).", false, 1.0);
        runTest("Arity Mismatch", "p(a).", "?- p(a,b).", false, 1.0);
        runTest("List Single El", "l([a]).", "?- l([a]).", true, 1.0);
        runTest("List Nesting Var", "nested([[a],b]).", "?- nested([X,b]).", true, 1.0);
        runTest("List Mismatch", "[a,b].", "?- [a,c].", false, 1.0);
        let val b3 = "a(1). a(2). b(X) :- a(X)." in
            runTest("Rule Fail", b3, "?- b(3).", false, 1.0)
        end;
        let val b3b = "p(X,Y) :- a(X), b(Y). a(1). b(2)." in
            runTest("Conjunction Rule", b3b, "?- p(1,2).", true, 1.0)
        end;
        runTest("Self Identity", "same(X,X).", "?- same(apple, apple).", true, 1.0);
        runTest("Backtrack over Fail", "p(a). p(b). q(X) :- p(X), eq(X,b). eq(b,b).", "?- q(b).", true, 1.0);
        runTest("Deep Backtrack", "x(a). x(b). y(c). y(d). z(X,Y) :- x(X), y(Y), fail.", "?- z(a,c).", false, 1.0);
        runTest("Anon in Recursion", "m([_|T]) :- m(T). m([]).", "?- m([1,2]).", true, 1.0);
        runTest("Anon Tail", "t([_|T], T).", "?- t([1,2,3], [2,3]).", true, 1.0);
        runTest("Anon Mismatch", "p(a,b).", "?- p(_, c).", false, 1.0);

        (* better tests-weight 2.0 *)
        let val path = "edge(a,b). edge(b,c). edge(c,d). p(X,Y) :- edge(X,Y). p(X,Y) :- edge(X,Z), p(Z,Y)." in
            runTest("Path 1 step", path, "?- p(a,b).", true, 2.0);
            runTest("Path 3 step", path, "?- p(a,d).", true, 2.0);
            runTest("Path fail", path, "?- p(d,a).", false, 2.0)
        end;
        let val nat = "add(0,X,X). add(s(X),Y,s(Z)) :- add(X,Y,Z)." in
            runTest("Peano Add", nat, "?- add(s(0), s(0), s(s(0))).", true, 2.0)
        end;
        runTest("Spaces in Fact", "  p  (  a  )  .  ", "?- p(a).", true, 2.0);
        runTest("Variable Shadowing", "p(X) :- q(X). q(1).", "?- p(1).", true, 1.0);
        runTest("Backtrack to Fact", "p(a). p(b). q(X) :- p(X).", "?- q(b).", true, 1.0);
        runTest("Identity Mismatch", "eq(X,X).", "?- eq(1,2).", false, 1.0);

         (* error handling tests-weight 1.0 *)
        runErrorTest("Err: Missing Dot Fact", "p(a)", "?- p(a).");
        runErrorTest("Err: Missing Dot Query", "p(a).", "?- p(a)");
        runErrorTest("Err: Unclosed Bracket", "p([a,b).", "?- p(X).");
        runErrorTest("Err: Unclosed Paren", "p(a,b.", "?- p(X).");

        (* advanced tests-weight 3.0 *)
        let val rev = "app([],L,L). app([H|T],L,[H|R]) :- app(T,L,R). rev([],[]). rev([H|T],R) :- rev(T,RT), app(RT,[H],R)." in
            runTest("List Reverse Fail", rev, "?- rev([a,b], [a,b]).", false, 3.0)
        end;
        let val len = "len([], 0). len([_|T], s(N)) :- len(T, N)." in
            runTest("List Length 3", len, "?- len([a,b,c], s(s(s(0)))).", true, 3.0)
        end;
        let val fam = "parent(bob, ann). parent(bob, joe). parent(ann, liz). gparent(X,Z) :- parent(X,Y), parent(Y,Z). sibling(X,Y) :- parent(P,X), parent(P,Y), diff(X,Y). diff(a,b). diff(joe,ann). diff(ann,joe)." in
            runTest("Non-Sibling Logic", fam, "?- sibling(bob, liz).", false, 3.0)
        end;
        let val diff = "d(x, 1). d(C, 0) :- atom(C). d(plus(U,V), plus(DU,DV)) :- d(U,DU), d(V,DV)." in
            runTest("Symbolic Diff", "d(x, 1). d(a, 0). d(plus(x,a), plus(1,0)).", "?- d(plus(x,a), plus(1,0)).", true, 3.0)
        end;
        let val simp = "simp(plus(0,X), X). simp(plus(X,0), X). simp(f(X), f(Y)) :- simp(X,Y)." in
            runTest("Nested Simplification", simp, "?- simp(f(plus(b, 0)), f(b)).", true, 3.0)
        end;
        runTest("Improper List Nesting", "p([1|[2|[3|[]]]]).", "?- p([1,2,3]).", true, 3.0);
        let val sets = "mem(X,[X|_]). mem(X,[_|T]) :- mem(X,T). subset([], _). subset([H|T], L) :- mem(H, L), subset(T, L)." in
            runTest("Subset True", sets, "?- subset([a,c], [a,b,c]).", true, 3.0)
        end;
        let val maps = "change(a,1). change(b,2). map([], []). map([H|T], [RH|RT]) :- change(H, RH), map(T, RT)." in
            runTest("List Map Fail", maps, "?- map([a,b], [1,3]).", false, 3.0)
        end;
        let val conflict = "check(X,Y,Z) :- a(X), b(Y), c(Z), eq(X,Z). a(1). a(2). b(3). c(4). c(1). eq(A,A)." in
            runTest("Conflict Backtrack", conflict, "?- check(1, 3, 1).", true, 3.0)
        end;
        let val math = "add(0,X,X). add(s(X),Y,s(Z)) :- add(X,Y,Z). mul(0,_,0). mul(s(X),Y,Z) :- mul(X,Y,W), add(W,Y,Z). fac(0, s(0)). fac(s(N), F) :- fac(N, F1), mul(s(N), F1, F). fib(0, 0). fib(s(0), s(0)). fib(s(s(N)), F) :- fib(N, F1), fib(s(N), F2), add(F1, F2, F)." in
            runTest("Factorial 3", math, "?- fac(s(s(s(0))), s(s(s(s(s(s(0))))))).", true, 3.0);
            runTest("Math Multiply Fail", math, "?- mul(s(s(0)), s(s(0)), s(0)).", false, 3.0)
        end;
        let val map = "color(red). color(blue). color(green). diff(red, blue). diff(red, green). diff(blue, red). diff(blue, green). diff(green, red). diff(green, blue). coloring(N1, N2, N3, N4) :- color(N1), color(N2), color(N3), color(N4), diff(N1, N2), diff(N1, N3), diff(N2, N3), diff(N2, N4), diff(N3, N4)." in
            runTest("Map Coloring Success", map, "?- coloring(red, blue, green, red).", true, 3.0)
        end;
        runTest("Deep Arity Match", "f(1,2,3,4,5,6,7,8,9,10).", "?- f(1,2,3,4,5,6,7,8,9,10).", true, 3.0);
        runTest("Full Integration", "member(X,[X|_]). member(X,[_|T]) :- member(X,T). app([],L,L). app([H|T],L,[H|R]) :- app(T,L,R). solve(L) :- member(a, L), app([a,b], [c], L).", "?- solve([a,b,c]).", true, 3.0);
        let val tOrder = "app([],L,L). app([H|T],L,[H|R]) :- app(T,L,R). pre(nil, []). pre(node(V,L,R), [V|Res]) :- pre(L,LL), pre(R,RL), app(LL,RL,Res). post(nil, []). post(node(V,L,R), Res) :- post(L,LL), post(R,RL), app(LL,RL,Tmp), app(Tmp,[V],Res)." in
            runTest("Tree Pre-order", tOrder, "?- pre(node(1, node(2,nil,nil), node(3,nil,nil)), [1,2,3]).", true, 3.0)
        end;
        let val graph = "edge(a,b). edge(b,c). edge(c,a). edge(c,d). triangle(X,Y,Z) :- edge(X,Y), edge(Y,Z), edge(Z,X)." in
            runTest("Find Triangle", graph, "?- triangle(a,b,c).", true, 3.0)
        end;
        runTest("Nested Pipe", "p([a|[b|[c|[]]]]).", "?- p([a,b,c]).", true, 3.0);
        let val shadow = "a(X) :- b(X). b(X) :- c(X). c(final)." in
            runTest("Deep Variable Shadow", shadow, "?- a(final).", true, 3.0)
        end;
        runTest("Name Clash", "f(a). f(a(b)).", "?- f(a).", true, 3.0);
        (* quicksort tests *)
        let val qsort = 
            "split(_, [], [], []). " ^
            "split(Pivot, [X|T], [X|Lss], Gtr) :- lte(X, Pivot), split(Pivot, T, Lss, Gtr). " ^
            "split(Pivot, [X|T], Lss, [X|Gtr]) :- gt(X, Pivot), split(Pivot, T, Lss, Gtr). " ^
            "qs([], []). " ^
            "qs([H|T], Sorted) :- " ^
            "  split(H, T, Lss, Gtr), " ^
            "  qs(Lss, SLss), " ^
            "  qs(Gtr, SGtr), " ^
            "  append(SLss, [H|SGtr], Sorted). " ^
            "append([], L, L). append([H|T], L, [H|R]) :- append(T, L, R). " ^
            "lte(0, _). lte(s(X), s(Y)) :- lte(X, Y). " ^
            "gt(s(_), 0). gt(s(X), s(Y)) :- gt(X, Y)."
        in
            runTest("Quicksort Peano List", qsort, 
                "?- qs([s(0), s(s(0)), 0], [0, s(0), s(s(0))]).", true, 1.0)
        end;
        (* stats *)
        let
            val rawScore = if !totalWeight > 0.0 
                           then (!earnedWeight / !totalWeight) 
                           else 0.0
            val finalGrade = rawScore * 100.0
        in
            print ("\n" ^ String.concatWith "" [
                "Final Result: ", Int.toString (!passCount), " / ", Int.toString (!testCount), " passed.\n",
                "Total Earned Weight: ", Real.toString (!earnedWeight), " / ", Real.toString (!totalWeight), "\n",
                "Final Grade (Scale 0-100): ", Real.fmt (StringCvt.FIX (SOME 2)) finalGrade, "\n"
            ])
        end
    )
end;

val _ = PrologTest.execute();
