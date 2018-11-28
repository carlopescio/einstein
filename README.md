I was reading about the Einstein’s Problem the other day (first hit on google: http://www.davar.net/MATH/PROBLEMS/EINSTEIN.HTM, and yeah, probably not from Einstein, but anyway). 

It takes a bit of persistence to solve on paper, but I thought it would make a nice example of CLP(FD), or Constraint Logic Programming over Finite Domains.

I used the clp(fd) library in SWI-Prolog. In this specific case “Finite Domains” means basically “finite set of integers” and you have to find a way to express your constraints using those. Some notions in the Einstein’s problem, like “neighbor”, may call to mind data structures like the array, where you would express proximity in space through proximity in index, but the array is a little alien to Prolog, so again you have to adapt your thinking a little.

In the end I adopted a simple strategy:

- House / Nationality / Beverage / Cigar / Pet is a tuple, so I have 5 unknown tuples to solve for.

- Every choice is mapped to a number, like: blue = 1, green = 2, red = 3, white = 4, yellow = 5 or Brit = 1, Dane = 2, German = 3, Norwegian = 4, Swede = 5.

- Some constraints are easy to express in the language / library, for instance, the fact that all Nationalities are different.

- Tuples are implicitly ordered by position. So tuple T1 = [N1, H1, B1, C1, P1] refers to the first house on the street, and so on.

- Constraints like “The Brit lives in a red house” are mapped to numerical expressions, like:
  10 * N1 + H1 #= 13 #\/
  10 * N2 + H2 #= 13 #\/
  10 * N3 + H3 #= 13 #\/
  10 * N4 + H4 #= 13 #\/ 
  10 * N5 + H5 #= 13
(Because 10 * Brit + red = 13). I don’t know where the Brit lives on the street, but one of the combinations must have a match. Note that #\/ is the “or” in clp(fd).

I had to play around a little before I settled on this form to express constraints. Other forms that were shorter gave run-time errors when combined in an “or” expression. Overall, once you get the idea, is pretty easy to understand the constraints. Symbolic constants would have helped, but again it’s not something you get in prolog: you have to express constants through facts, and in the end you get a more verbose code in cases like this. I could have avoided the multiplication by shifting the domains, but I choose not to.

There are a couple of ambiguities in the text of the problem, as when it says “The man who smokes blend lives next to…” does “next” mean “after” of “before or after”? Since in one case it says “neighbor”, which I read as “before or after”, is “next” intended to be more specific? In the end, I played around with both versions, and I kept the most general (next meaning “before or after”) as it lead to the expected solution anyway.

Labeling was required to get the single correct answer, although I didn’t have to label all the tuples. Curiously enough, if I label Houses and Beverages too, I don’t need constraint #15. 

Running the code with the goal

einstein( T1, T2, T3, T4, T5 ).

You immediately get back

T1 = [4, 5, 5, 2, 1],
T2 = [2, 1, 4, 5, 5],
T3 = [1, 3, 3, 3, 2],
T4 = [3, 2, 2, 4, 4],
T5 = [5, 4, 1, 1, 3]

So the answer to “Who keeps fish” is in tuple T4 (fish = 4, pet is the last field) and so nationality is 3 = German as expected. As I said, the code runs fast enough that you don’t notice. I didn’t run any benchmark.


For those interested, a brief tutorial on clp(fd) library in SWI-Prolog from Anne Ogborn is at http://www.pathwayslms.com/swipltuts/clpfd/clpfd.html





