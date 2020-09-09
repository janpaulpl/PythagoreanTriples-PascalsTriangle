(* Math Investigation >> Pythagorean Triples in the Pascal Triangle
The following is code made with help of references from: http://www.cs.uleth.ca/~gaur/post/progasproof/
with the purpose to prove rigorously the sum of n-integers computationally, for it's use
in the Math Investigation referenced above.

Author: Jan-Paul V. Ramos
Date: February 2020

Copyright 2020, Jan-Paul V. Ramos, All rights reserved.*)

(* A recursive definition of 1+2+...+n *)

Require Import Arith.

Fixpoint sum (n:nat) : nat :=
  match n with
  | 0 => 0
  | S m => n + sum m
  end.

Compute (sum 322). (* Any p-integer; calculates the nth term in the first n-integers *)

(* Let us first prove the s n = n + s (n-1) [Recursion] *)

Lemma l1: forall n:nat, sum (S n) = (S n) + (sum n).
Proof.
  induction n as [|m IH].

  - simpl. reflexivity. (* 2x0 = 0 *)
  - rewrite -> IH. simpl. reflexivity. (* 2xsum(n) = 2n+sum(n-1) *)

Qed.

Lemma l2: forall n:nat, S (S n) = S (n+1).
Proof.
  induction n; intros. simpl.
  reflexivity.

  simpl.
  rewrite <- IHn.
  reflexivity.
Qed.

Lemma l3: forall n:nat, n + 1 = S n.
Proof.
  induction n; intros. simpl.
  reflexivity.
  simpl. rewrite IHn. reflexivity.
Qed.

Theorem gauss_num: forall n:nat, 2 * (sum n) = n * (S n).
Proof.

  induction n as [|m IH]; intros. simpl.

  - simpl. reflexivity. (* 2x0 = 0 *)
  - rewrite -> l1. (* 2xsum(n) = 2n+sum(n-1) *)

  rewrite mult_plus_distr_l.
  rewrite IH.

  replace (S m) with (m + 1).
  replace (S (m + 1)) with (2 + m).

  SearchRewrite(_+_).

  rewrite <- mult_plus_distr_r.
  rewrite mult_comm.
  reflexivity.

  intros.

  simpl.
  rewrite l2.
  reflexivity.

  rewrite l3.
  reflexivity.

Qed.