team(1,'Predadors', 'Chicago').
team(2,'Orły','Katowice').
team(3,'Амурский тигр','Хабаровск').

player(11,'Mike',22,1).
player(12,'Michal',26,2).
player(13,'Михаил', 25,3).


place("Berlin").
place("Kraków").
place("Rio de janeiro").

result(5,0).
result(3,2).
result(1,4).
result(2,3).

match(Place,Team1,Team2,Res1,Res2) :- place(Place),team(ID1,Team1,Town1), team(ID2,Team2,Town2), (ID1 <> ID2),result(Res1,Res2).

playerATteam(Player,TeamCalling) :- player(Nb,Player,Age,Id), team(Id,TeamCalling,Town).


teamwinner(Team1) :- match(Place,Team1,Team2,Res1,Res2), Res1>Res2.
