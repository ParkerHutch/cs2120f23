
example :
∀ (Person : Type)
  (Loves : Person → Person → Prop)
  (p q : Person),
  (∃ (q : Person), ∀ (p : Person), Loves p q) →
  (∀ (p : Person), ∃ (q : Person), Loves p q) :=
λ Person Loves p q sel k => match sel with
  | (joe, every_loves_joe) =>
    (joe, every_loves_joe k)



variable
  (Ball : Type)
  (Heavy : Ball → Prop )
  (Red : Ball → Prop)

example : (∃ (b : Ball), Red b ∧ Heavy b) → (∃ (b : Ball), Red b) :=
λ h => match h with
| (rhb, bisredandheavy) => (rhb, bisredandheavy.left)

example : (∃ (b : Ball), Red b ∧ Heavy b) → (∃ (b : Ball), Red b ∨ Heavy b) :=
λ h => match h with
| (rhb, bisredandheavy) => (rhb, Or.inr bisredandheavy.right)

example : (¬(∀ (b : Ball), Red b)) → (∃ (b : Ball), ¬(Red b)) :=
λ nabr => _
