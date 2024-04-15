-- from 'induction.lean'

#check False.rec

#check Bool.rec

#check Nat.rec

#check List.rec

example : ∀ (b: Bool), !!b = b :=
by
  intros b
  induction b
  repeat {rfl}

inductive Tree (α : Type) where
| empty : Tree α
| node (a : α) (l r : Tree α)

#check Tree.rec

#check List.rec

def fact_0 := 1

def fact_succ : (n : Nat) → (fact_n : Nat) → Nat
| n, fact_n => fact_n * (n + 1)

#check (Nat.rec fact_0 fact_succ : Nat → Nat)

#reduce (Nat.rec fact_0 fact_succ : Nat → Nat) 5


-- finish list thing for HW
def list_step (α : Type) : α → List α → Nat → Nat
| α, lst, n => n + 1

#reduce (List.rec 0 list_step _)

def list_empty_len := 0
