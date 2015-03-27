(** Module to extract data from TCX track points. Data points are
 * represented as pairs [(unix_time, value)]. *)

val altitude : Tcx.t -> (float * float) array
