-- this is all in Instructor/typeclasses.lean
structure functor'' (c : Type → Type) where
map {α β : Type} (f : α → β) (ic : c α): c β

@[class]
structure functor' (c : Type → Type) where
map {α β : Type} (f : α → β) (ic : c α) : c β

-- upgraded func

class functor (c : Type → Type) where
map {α β : Type} (f : α → β) (ic : c α) : c β


-- from hw 5
def list_map {α β : Type} : (α → β) → List α → List β
| _, [] => []
| f, h::t => f h :: list_map f t

def option_map {α β : Type} : (α → β) → Option α → Option β
| _, Option.none => Option.none
| f, (Option.some a) => some (f a)

inductive Box (α : Type)
| contents (a : α)

def box_map : (α → β) → Box α → Box β
| f, (Box.contents a) => Box.contents (f a)

def list_functor'' : functor'' List := functor''.mk list_map
def option_functor'' : functor'' Option := functor''.mk option_map

-- original definition of do_map
def do_map' {α β : Type} {c : Type → Type} (m : functor'' c):
  (f : α → β) → c α → c β
| f, c => m.map f c

-- stuff before was review according to prof
#eval do_map' list_functor'' Nat.succ [1,2,3]
#eval do_map' option_functor'' (λ s => s ++ "!") (some "Hi")

-- we want to be able to map a function over a container using <$> notation
-- square brackets tell lean to find a type class instance implicitly (???) and
-- to pass it as an implicit instance argument
def do_map {α β : Type} {c : Type → Type} [m : functor c] :
  (f : α → β) → c α → c β
| f, c => m.map f c

#reduce do_map Nat.succ [1, 2, 3] -- what's the problem?
-- you can pass me any 'c' as long as it has (not sure exact wording) a functor



-- we need registered typeclass instances
-- these instances go into a database in lean
instance : functor List := ( list_map ) -- this should work :(
-- other people had an error on that line too ^
instance : functor Box := ( box_map )

#reduce do_map Nat.succ [1, 2, 3]

-- so now if you tried to do this
#reduce do_map Nat.succ (some 3)
-- it won't work until you add the line below above it:
instance : functor Option := ( option_map )


infix:50 " <$> " => do_map -- takes left and right arguments and applies them to do_map
#reduce Nat.succ <$> (Box.contents 1)
-- on the HW this worked because Lean defines typeclasses for List and Option
#reduce Nat.succ <$> [1, 2, 3]
/-!
ambiguous because Lean already defines <$> for list functors, so it doesn't know whether to apply its definition of <$> or our own
-/
#reduce do_map Nat.succ [1, 2, 3] -- this works because it isn't ambiguous (use our definition I think)

-- lean defines Functor
#reduce Functor.map Nat.succ [1, 2, 3]
#reduce Nat.succ <$> [1, 2, 3]
-- see typeclasses_practice.lean for examples of <$> out-of-the-box

#reduce do_map Nat.succ [1, 2, 3]

-- typeclass instance associates added metadata around a type
-- when we make a functor instance for list, we're implicitly associating a map function with the list type
