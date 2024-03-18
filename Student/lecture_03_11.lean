inductive BobStudiesAtUVa
| attendsClasses
| paidTuition

inductive MaryStudiesAtUVa
| attendsClasses
| paidTuition

def b : BobStudiesAtUVa := BobStudiesAtUVa.paidTuition
def m : MaryStudiesAtUVa := MaryStudiesAtUVa.paidTuition

inductive MyAnd (α β : Type) : Type
| mk (a : α) (b : β)

inductive MyOr (α β : Type) : Type
| inl (a : α)
| inr (b : β)

example : MyAnd BobStudiesAtUVa MaryStudiesAtUVa := MyAnd.mk b m
example : MyOr BobStudiesAtUVa MaryStudiesAtUVa := MyOr.inl b
example : MyOr BobStudiesAtUVa MaryStudiesAtUVa := MyOr.inr m

def MyNot (α : Type) := α → Empty
example : MyNot BobStudiesAtUVa := λ b => _ -- can't complete this
example : MyNot MarkoStudiesAtUVa := λ m => nomatch m
