(** Module to extract data from GPX track points. Data points are
 * represented as pairs [(unix_time, value)]. *)

val ele : Gpx.gpx -> (float * float) array

val lat : Gpx.gpx -> (float * float) array

val lon : Gpx.gpx -> (float * float) array
