(** Tabulated real-value function. *)
type t

(** Returns domain interval [(min_t, max_t)] if the function isn't
 * empty. *)
val domain : t -> (float * float) option

(** Same as [eval_opt], but returns zero for arguments out of
 * domain. *)
val eval : t -> float -> float

(** Evaluate functions [f1] and [f2] at the same point [x]. Uses [eval]
 * internally. *)
val eval2 : t -> t -> float -> float * float

(** Evaluate functions [f1] and [f2] at the same point [x]. Both
 * functions must be defined for [x], or there will be no result. *)
val eval2_opt : t -> t -> float -> (float * float) option

(** Evaluate function at point [x]. Linear interpolation is used for
 * missing data points. If the point [x] is out of domain, [None] is
 * returned. *)
val eval_opt : t -> float -> float option

(** Make tabulated function out of array of pairs [(x, y)]. *)
val of_array : (float * float) array -> t

(** Like [of_array], but for lists. *)
val of_list : (float * float) list -> t

(** Sample function [f] in interval [(min_x, max_x)] with sampling interval
 * [dx], starting at [min_x]. *)
val sample : t -> float * float -> float -> float array
