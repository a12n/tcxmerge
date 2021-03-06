(** Estimates the lag of signal [b] relative to the signal [a] using
 * [xcorr]. Returns also the correlation coefficient of the lag. *)
val lag : float array -> float array -> int * float

(** Cross correlation of signals [a] and [b]. While signals may have
 * different lengths, they must be sampled with the same sampling
 * interval for the answer to be meaningful. Returns array of pairs
 * [(lag, unscaled_correlation)]. *)
val xcorr : float array -> float array -> (int * float) array
