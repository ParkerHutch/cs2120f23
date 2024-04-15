-- from 'logic.lean'

example (P Q : Prop) : P ∧ Q → Q ∧ P :=
λ (h : P ∧ Q) => ⟨h.2 , h.1⟩ --

example (P Q : Prop) : P ∧ Q → Q ∧ P
| And.intro p q => And.intro q p


example (P Q : Prop) : P ∧ Q → Q ∧ P
| ⟨ p, q ⟩ => ⟨ q, p ⟩

example (P Q : Prop) : P ∧ Q → P ∨ Q
| ⟨ p, q ⟩ => Or.inl p

-- in class self-taught example
example (P Q : Prop) : P ∨ Q → Q ∨ P
| Or.inl p => Or.inr p
| Or.inr q => Or.inl q
