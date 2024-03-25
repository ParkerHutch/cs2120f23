-- from propositions_as_types.lean

-- given a type of Prod α β, the fields are p.1 : α and p2 : β or you can use p.fst and p.snd
#check (1, "Hello") -- prod type

inductive BobStudiesAtUVa
| attendsClasses
| paidTuition

inductive MaryStudiesAtUVa
| attendsClasses
| paidTuition

inductive MarkoStudiesAtUVa

def neg (α : Type) := α → Empty


def b : BobStudiesAtUVa := BobStudiesAtUVa.paidTuition
def m : MaryStudiesAtUVa := MaryStudiesAtUVa.paidTuition

-- construct proof of the conjunction (introduction) ?
example : Prod BobStudiesAtUVa MaryStudiesAtUVa := Prod.mk b m
example : BobStudiesAtUVa × MaryStudiesAtUVa := (b, m)

-- use a proof of the conjunction (elimination rules)
example : BobStudiesAtUVa × MaryStudiesAtUVa → BobStudiesAtUVa := λ p => p.fst -- or p.1
example : BobStudiesAtUVa × MaryStudiesAtUVa → MaryStudiesAtUVa := λ p => p.snd -- or p.2


#check (@Sum)
-- sum has inl and inr fields

example : Sum BobStudiesAtUVa MarkoStudiesAtUVa := Sum.inl b
example : BobStudiesAtUVa ⊕ MarkoStudiesAtUVa := Sum.inr _

example : BobStudiesAtUVa ⊕ MarkoStudiesAtUVa → BobStudiesAtUVa
| (Sum.inl l)
| (Sum.inr r) => nomatch r

example : neg (MaryStudiesAtUVa × MarkoStudiesAtUVa) :=
λ p => nomatch p.2

example : BobStudiesAtUVa ∧ MaryStudiesAtUVa := _

inductive B : Prop
| paid
| classes

inductive M : Prop
| paid
| classes

inductive K : Prop

example : And B M := And.intro B.paid M.classes
def b_and_m_true : B ∧ M := And.intro B.paid M.classes
-- another way of doing this^ is:
theorem b_and_m_true' : B ∧ M := And.intro B.paid M.classes
example : B ∧ M := ( B.paid, M.classes )

example : B ∧ M → M := λ bm => bm.right

example : B ∧ M → B := λ bm => bm.left

example : B ∧ ¬ K := _
example : B ∧ Not K := _

theorem foo : B ∧ Not K := ( B.paid , λ k => nomatch k )
example : B ∧ ¬K := foo

example : B ∨ K := Or.inl B.paid
example : B ∨ K → B := -- ¬(B or K) or B
λ bork  => match bork with
| Or.inl b => b
| Or.inr k => nomatch k
-- proof values: use theorem, computational values: use def


-- continuing on 'propositions_as_types.lean'
example : And B M := And.intro B.paid M.classes
example : B ∧ M → M := λ bm => bm.right
example : B ∧ M → B := λ bm => bm.1

-- intro

example : ∀ (Raining Sprinkling Wet : Prop),
  (Raining ∨ Sprinkling) →
  (Raining → Wet) →
  (Sprinkling → Wet) →
  Wet :=
  -- underscores used to be R S W
  λ _ _ _ rors rw sp =>  -- 'assume you have a proof that if it is raining that it is wet and that if it is sprinkling that it is wet'
  match rors with
  | Or.inl r => rw r
  | Or.inr s => sp s


-- Not
def notK : ¬K := λ k => nomatch k
-- elimination example (law of no contradiction)
example (P : Prop): ¬P → P → False :=
λ np p => np p

example (P : Prop) : ¬¬P → P
| nnp => _ -- can't do this, not an axiom in Lean

-- Implication (P → Q)
-- law of the excluded middle says that for any proposition P, P ∨ ¬P must be True (every proposition must be either true or false)
example (P : Prop) : (P ∨ ¬ P) → (¬¬P → P)
| pornp => match pornp with
  | Or.inl p => λ nnp => p
  | Or.inr np => λ nnp => nomatch (nnp np)


#check Classical.em
example (P : Prop) : (¬¬P → P) :=
match (Classical.em P) with
  | Or.inl p => λ _ => p
  | Or.inr np => λ _ => by contradiction


def one_not_eq_zero (n : Nat): n = 1 → n ≠ 0 :=
λ (neq1 : n = 1) => λ neq0 => by
  rw [neq1] at neq0
  cases neq0
-- λ h => match n with
-- | Nat.zero => nomatch h
-- | Nat.succ n' => λ k => by
--   rw [k] at h
--   cases h
