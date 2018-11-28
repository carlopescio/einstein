:- use_module(library(clpfd)).

%! blue = 1, green = 2, red = 3, white = 4, yellow = 5
%! Brit = 1, Dane = 2, German = 3, Norwegian = 4, Swede = 5
%! beer = 1, coffee = 2, milk = 3, tea = 4, water = 5
%! Blue Master = 1, Dunhill = 2, Pall Mall = 3, Prince = 4, blend = 5
%! cat = 1, bird = 2, dog = 3, fish = 4, horse = 5.

einstein( T1, T2, T3, T4, T5 ) :-
  T1 = [N1, H1, B1, C1, P1], 
  T2 = [N2, H2, B2, C2, P2], 
  T3 = [N3, H3, B3, C3, P3], 
  T4 = [N4, H4, B4, C4, P4], 
  T5 = [N5, H5, B5, C5, P5],
  
  Nationalities = [N1, N2, N3, N4, N5],
  Nationalities ins 1..5,
  all_different( Nationalities ),

  Houses = [H1, H2, H3, H4, H5],
  Houses ins 1..5,
  all_different( Houses ),
  
  Beverages = [B1, B2, B3, B4, B5],
  Beverages ins 1..5,
  all_different( Beverages ),

  Cigars = [C1, C2, C3, C4, C5],
  Cigars ins 1..5,
  all_different( Cigars ),
  
  Pets = [P1, P2, P3, P4, P5],
  Pets ins 1..5,
  all_different( Pets ),
  
  %! 1) The Brit lives in a red house
  10 * N1 + H1 #= 13 #\/
  10 * N2 + H2 #= 13 #\/
  10 * N3 + H3 #= 13 #\/
  10 * N4 + H4 #= 13 #\/ 
  10 * N5 + H5 #= 13,
  
  %! 2) The Swede keeps dogs as pets.
  10 * N1 + P1 #= 53 #\/
  10 * N2 + P2 #= 53 #\/
  10 * N3 + P3 #= 53 #\/
  10 * N4 + P4 #= 53 #\/ 
  10 * N5 + P5 #= 53,

  %! 3) The Dane drinks tea.
  10 * N1 + B1 #= 24 #\/
  10 * N2 + B2 #= 24 #\/
  10 * N3 + B3 #= 24 #\/
  10 * N4 + B4 #= 24 #\/ 
  10 * N5 + B5 #= 24,
  
  %! 4) The green house is on the left of the white house (next to it).
  10 * H1 + H2 #= 24 #\/
  10 * H2 + H3 #= 24 #\/
  10 * H3 + H4 #= 24 #\/
  10 * H4 + H5 #= 24,
    
  %! 5) The green house owner drinks coffee.
  10 * H1 + B1 #= 22 #\/
  10 * H2 + B2 #= 22 #\/
  10 * H3 + B3 #= 22 #\/
  10 * H4 + B4 #= 22 #\/
  10 * H5 + B5 #= 22,
 
  %! 6) The person who smokes Pall Mall rears birds.
  10 * C1 + P1 #= 32 #\/
  10 * C2 + P2 #= 32 #\/
  10 * C3 + P3 #= 32 #\/
  10 * C4 + P4 #= 32 #\/
  10 * C5 + P5 #= 32,
  
  %! 7) The owner of the yellow house smokes Dunhill.
  10 * H1 + C1 #= 52 #\/
  10 * H2 + C2 #= 52 #\/
  10 * H3 + C3 #= 52 #\/
  10 * H4 + C4 #= 52 #\/
  10 * H5 + C5 #= 52,
  
  %! 8) The man living in the house right in the center drinks milk.
  B3 #= 3,
  
  %! 9) The Norwegian lives in the first house.
  N1 #= 4,
  
  %! 10) The man who smokes blend lives next to the one who keeps cats
  10 * P1 + C2 #= 15 #\/
  10 * P2 + C3 #= 15 #\/
  10 * P3 + C4 #= 15 #\/
  10 * P4 + C5 #= 15 #\/
  %! "next" on the other side  
  10 * P2 + C1 #= 15 #\/
  10 * P3 + C2 #= 15 #\/
  10 * P4 + C3 #= 15 #\/
  10 * P5 + C4 #= 15,
    
  %! 11) The man who keeps horses lives next to the man who smokes Dunhill.
  10 * C1 + P2 #= 25 #\/
  10 * C2 + P3 #= 25 #\/
  10 * C3 + P4 #= 25 #\/
  10 * C4 + P5 #= 25 #\/
  %! "next" on the other side  
  10 * C2 + P1 #= 25 #\/
  10 * C3 + P2 #= 25 #\/
  10 * C4 + P3 #= 25 #\/
  10 * C5 + P4 #= 25,

  %! 12) The owner who smokes Blue Master drinks beer.
  10 * C1 + B1 #= 11 #\/
  10 * C2 + B2 #= 11 #\/
  10 * C3 + B3 #= 11 #\/
  10 * C4 + B4 #= 11 #\/
  10 * C5 + B5 #= 11,
  
  %! 13) The German smokes Prince.
  10 * N1 + C1 #= 34 #\/
  10 * N2 + C2 #= 34 #\/
  10 * N3 + C3 #= 34 #\/
  10 * N4 + C4 #= 34 #\/
  10 * N5 + C5 #= 34,  
  
  %! 14) The Norwegian lives next to the blue house.
  H2 #= 1,
  
  %! 15) The man who smokes blend has a neighbor who drinks water.
  %! not needed if you label Houses and Beverages as well 
  10 * C1 + B2 #= 55 #\/
  10 * C2 + B3 #= 55 #\/
  10 * C3 + B4 #= 55 #\/
  10 * C4 + B5 #= 55 #\/
  %! "next" on the other side  
  10 * C2 + B1 #= 55 #\/
  10 * C3 + B2 #= 55 #\/
  10 * C4 + B3 #= 55 #\/
  10 * C5 + B4 #= 55,
  
%!  label(Houses),  
  label(Nationalities),
%!  label(Beverages),
  label(Cigars),
  label(Pets)   
  .
  
  
