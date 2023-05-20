% Copyright

implement main
    open core, stdio, file

domains
    country = russia; poland; usa; venezuella.

class facts - footballDb
    team : (integer Id, string TeamCall, country Country, string TeamTown, real Budget).
    player : (integer PlayerNumber, string Playername, integer Id).
    place : (string Town).
    result : (integer Res1, integer Res2).

class facts
    sum : (real Sum) single.

clauses
    sum(0).

class predicates
    match : (string Place, string Teamcalling1, string Teamcalling2, integer Res1, integer Res2) nondeterm anyflow.
    playerATteam : (string Playername, string Teamcalling) nondeterm anyflow.
    matchresult : (string Place, string Teamcalling1, integer Res1, integer Res2) nondeterm anyflow.
    budget_summary : () failure anyflow.

clauses
    match(Place, Team1, Team2, Res1, Res2) :-
        place(Place),
        team(ID1, Team1, _, _, _),
        team(ID2, Team2, _, _, _),
        ID1 <> ID2,
        result(Res1, Res2).

    playerATteam(Player, TeamCalling) :-
        player(_, Player, Id),
        team(Id, TeamCalling, _, _, _).

    matchresult(Place, Team1, Res1, Res2) :-
        match(Place, Team1, _, Res1, Res2),
        Res1 > Res2.
    budget_summary() :-
        team(_, _, _, _, Budget),
        sum(Sum),
        assert(sum(Sum + Budget)),
        fail.

clauses
    run() :-
        file::consult("../consultfile.txt", footballDb),
        fail.
    run() :-
        matchresult(P, T, R1, R2),
        stdio::write("Team ", T, " won match at ", P, " with score ", R1, ":", R2, "\n"),
        fail.

    run() :-
        playerATteam(Y, X),
        stdio::write("Player ", Y, " at team:", X, "\n"),
        fail.
    run() :-
        budget_summary().
    run() :-
        sum(Sum),
        stdio::write("Summary budget is ", Sum, "\n"),
        fail.
    run() :-
        stdio::write("End test\n").

end implement main

goal
    console::runUtf8(main::run).
