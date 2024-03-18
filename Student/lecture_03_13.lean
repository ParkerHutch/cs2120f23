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

theorem foo : B ∧ Not K := (B.paid, λ k => nomatch k)
example : B ∧ ¬K := foo

example : B ∨ K := Or.inl B.paid
example : B ∨ K → B := ¬(B or K) or B
λ bork  => match bork with
| Or.inl b => b
| Or.inr k => nomatch k
-- proof values: use theorem, computational values: use def
