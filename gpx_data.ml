open Batteries

let map_trkpts f {Gpx.trk; _} =
  let of_wpt ans = function
    | {Gpx.time = Some (t, _tz); ele = _; _} as p ->
       let data = f p in
       if Option.is_some data then
         (t, Option.get data) :: ans
       else
         ans
    | _ -> ans in
  let of_trkseg {Gpx.trkpt; _} =
    trkpt |> List.fold_left of_wpt [] |> List.rev in
  let of_trk {Gpx.trkseg; _} =
    trkseg |> List.map of_trkseg |> List.flatten in
  trk |> List.map of_trk |> List.flatten |> Array.of_list

let ele = map_trkpts (fun {Gpx.ele; _} -> ele)

let lat = map_trkpts (fun {Gpx.lat; _} -> Some lat)

let lon = map_trkpts (fun {Gpx.lon; _} -> Some lon)
