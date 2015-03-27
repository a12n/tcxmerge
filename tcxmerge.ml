let error msg =
  prerr_string "tcxmerge: ";
  prerr_endline msg;
  exit 1

(* Command line arguments *)

let parse_args () =
  let in_path = ref "/dev/fd/0" in
  let out_path = ref "/dev/fd/1" in
  let track_path = ref "track.gpx" in
  Arg.parse [ "-in", Arg.Set_string in_path,
              Printf.sprintf "Path to input TCX file (default \"%s\")" !in_path;
              "-out", Arg.Set_string out_path,
              Printf.sprintf "Path to output TCX file (default \"%s\")" !out_path;
              "-track", Arg.Set_string track_path,
              Printf.sprintf "Path to GPX file with GPS data (default \"%s\")" !track_path ]
            (fun _anon -> ())
            "Merge TCX data (heart rate, cadence) with GPS data from a GPX file";
  !in_path, !out_path, !track_path

(* Main *)

let () =
  let in_path, out_path, track_path = parse_args () in
  (* TODO *)
  ()
