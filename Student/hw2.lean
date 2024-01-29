--

/-!
Write a function called add that takes two natural numbers, a and b, and returns
their sum, a + b. Don't just look up the answer. Figure it out on your own.
Hint: do case analysis on the second argument (a Nat can be either Nat.zero or
(Nat.succ n') and use the fact that n + (1 + m) = 1 + (n + m).
-/

def add (α : Nat) (β: Nat) : Nat := α + β
#eval add 3 2

/-!
Write a function called append, polymorphic in a type, T, that takes two lists
values, n and m of type List T and that returns the result of appending the two
lists. For example, append [1,2,3] [4,5,6], should return [1,2,3,4,5,6]. Hint:
It's very much list Nat addition.
-/

def append {T : Type} (n : List T) (m : List T) := List.append n m

def l1 : List Nat := [1, 2, 3]
def l2 : List Nat := [4, 5, 6]

#eval append l1 l1
#eval List.append l1 l2
