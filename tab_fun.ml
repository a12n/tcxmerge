open Batteries

type t = (float * float) array

let lerp (a, b) t = a +. t *. (b -. a)

let interpolate x (x1, y1) (x2, y2) =
  let t = (x -. x1) /. (x2 -. x1) in lerp (y1, y2) t

let domain f =
  let n = Array.length f in
  if n > 0 then
    Some (fst f.(0), fst f.(n - 1))
  else
    None

let eval_opt f x =
  let cmp (x1, _) (x2, _) =
    (BatOrd.ord compare) x1 x2 in
  match Array.bsearch cmp f (x, 0.0) with
    `At k -> Some (snd f.(k))
  | `Just_after k -> Some (interpolate x f.(k) f.(k + 1))
  | `All_lower | `All_bigger | `Empty -> None

let eval2_opt f1 f2 x =
  match eval_opt f1 x, eval_opt f2 x with
    Some y1, Some y2 -> Some (y1, y2)
  | _, _ -> None

let eval f x = Option.default 0.0 (eval_opt f x)

let eval2 f1 f2 x = eval f1 x, eval f2 x

let of_array = Array.decorate_stable_sort fst

let of_list = of_array % Array.of_list

let sample f (min_x, max_x) dx =
  let next x =
    if x <= max_x then
      eval f x, x +. dx
    else
      raise Enum.No_more_elements in
  Enum.from_loop min_x next |> Array.of_enum
