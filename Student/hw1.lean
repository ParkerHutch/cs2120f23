def apply4 { α : Type } : (α → α) → (α → α) -- → (α → β) → (α → γ)
| f => fun a => f (f (f (f a) ) )

def apply4' { α : Type } : (α → α) → (α → α) -- → (α → β) → (α → γ)
| f => f ∘ f ∘ f ∘ f

def inc (n : Nat) := Nat.succ n

#reduce (apply4 inc) 2

def compn {α : Type} : Nat → (α → α) → (α → α)
| Nat.zero, f => λ a => a
| (Nat.succ n'), f => compn n' f ∘ f

#eval (compn 5 Nat.succ) 0

def sq (n: Nat) := n * n

#eval sq 2

def e : List Nat := List.nil
def e' : List Nat := []

def l1 : List Nat := List.cons 1 e
def l1' : List Nat := 1::e
def l1'' : List Nat := [1]

def l2 : List Nat := List.cons 0 l1
#reduce l2

def list_len {α : Type} : List α → Nat
| List.nil => 0
| (List.cons h t) => 1 + list_len t

#eval list_len l2
