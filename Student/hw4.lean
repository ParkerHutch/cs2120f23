def isEvenLen : String → Bool := λ s => s.length % 2 == 0
def combine : String → Bool → Bool
| string, bool => (isEvenLen string && bool)
-- could also have done this:
def combine' : String → Bool → Bool| s, b => and (isEvenLen s) b

def foldr {α β : Type} : (α → β → β) → β → List α → β
| _, id, List.nil => id
| op, id, (h::t) => op h (foldr op id t)

#reduce foldr combine True ["333"] -- expect false
#reduce foldr combine True ["4444"] -- expect True

-- old version (I think this could be used to sum up a list for example)
def foldr_ {α : Type} : (α → α → α) → α → List α → α
| _, id, List.nil => id
| op, id, (h::t) => op h (foldr_ op id t)

#eval foldr_ Nat.add 1 [1, 2, 3] -- bad identity!

-- Let's make a monoid and show how we can enforce the identity principle

structure my_monoid (α : Type) where
(op : α → α → α)
(id : α)
(left_id : ∀ (a : α), op id a = a)
(right_id : ∀ (a : α), op a id = a)

-- I think .mk means 'call constructor'
-- def a_monoid : my_monoid Nat := my_monoid.mk Nat.add 0 sorry sorry
def a_monoid : my_monoid Nat := my_monoid.mk Nat.add 0 sorry sorry

#check a_monoid.op
#check a_monoid
