-- propositions_as_types.lean
inductive BobStudiesAtUVa
| attendsClasses
| paidTuition

inductive MaryStudiesAtUVa
| attendsClasses
| paidTuition

inductive BobStudiesAtUVaAndMaryStudiesAtUVa
| and (b : BobStudiesAtUVa) (m : MaryStudiesAtUVa)

def b : BobStudiesAtUVa := BobStudiesAtUVa.paidTuition
def m : MaryStudiesAtUVa := MaryStudiesAtUVa.paidTuition

example : BobStudiesAtUVaAndMaryStudiesAtUVa :=
  BobStudiesAtUVaAndMaryStudiesAtUVa.and b m

inductive BobStudiesAtUVAOrMaryStudiesAtUVa
| left (b : BobStudiesAtUVa)
| right (m : MaryStudiesAtUVa)

example : BobStudiesAtUVAOrMaryStudiesAtUVa :=
  BobStudiesAtUVAOrMaryStudiesAtUVa.left b

def neg (α : Type) := α → Empty
inductive MarkoStudiesAtUVa
example : neg MarkoStudiesAtUVa :=
λ m : MarkoStudiesAtUVa => nomatch m
