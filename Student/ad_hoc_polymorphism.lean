
#check (@Option)

def pred : Nat → Option Nat
| Nat.zero => Option.none
| (Nat.succ n') => n'

#reduce pred 3
#reduce pred 0

def list_map {α β : Type} : (α → β) → List α → List β
| _, [] => []
| f, h::t => f h :: list_map f t

def option_map {α β : Type} : (α → β) → Option α → Option β
| _, Option.none => Option.none
| f, (Option.some a) => some (f a)

-- note: use \ r instead of \ to or \ rightarrow
-- and can do \ a instead of \ alpha
inductive Tree (α : Type): Type
| empty
--  two ways of writing the same constructor below
-- | node : α → Tree α → Tree α → Tree α
| node (a: α) (l r : Tree α) : Tree α

def tree_map : (α → β) → Tree α → Tree β
| _, Tree.empty => Tree.empty
| f, (Tree.node a l r) => Tree.node (f a) (tree_map f l) (tree_map f r)

#reduce tree_map Nat.succ Tree.empty

-- example of using the tree constructor (indents not required)
def a_tree :=
Tree.node
1
  (Tree.node
    2
    Tree.empty
    Tree.empty
  )
  (Tree.node
    3
    Tree.empty
    Tree.empty
  )

#reduce tree_map Nat.succ a_tree

-- new algebraic structure
-- c: polymorphic container type (ex. Option, List, Tree)
  -- 'polymorphic' in that they take a type and map to another type ex. List(Nat) creates a List of Nats
-- f: mapping function
-- we want to specify a rule that map actually does what we want it to
structure functor {α β : Type} (c : Type → Type) (f: α → β) : Type where
map (f : α → β) (ic : c α) : c β -- ic = input container

-- I think List is the c parameter here
def list_functor {α β : Type}: functor List Nat.succ := functor.mk list_map
def option_functor {α β : Type}: functor Option Nat.succ := functor.mk option_map

-- more happened here but I had to go (I think like how to make the rule that ensures map works as expected)
