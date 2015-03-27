open Batteries

let map_track_points f tcx =
  let collect ans = function
    | `Track_point ({Tcx.Track_point.time; _} as p) ->
       let data = f p in
       if Option.is_some data then
         (Tcx.Timestamp.to_unix_time time, Option.get data) :: ans
       else
         ans
    | _ -> ans in
  Tcx.fold collect [] tcx |> List.rev |> Array.of_list

let altitude =
  map_track_points (fun {Tcx.Track_point.altitude; _} -> altitude)
