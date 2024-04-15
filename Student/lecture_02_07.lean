-- should be able to see 'props_as_types.lean' in the instructor repo at some point

/-
p implies q

P | Q | P → Q
F | F | T
F | T | T
T | F | F
T | T | T
-/

#check Empty

def e2e : Empty → Empty
| e => e

def n2e : Nat → Empty
| n =>
