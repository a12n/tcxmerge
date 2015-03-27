let error msg =
  prerr_string "tcxmerge: ";
  prerr_endline msg;
  exit 1

(* Time lag detection *)

let time_lag input track =
  (* TODO *)
  None

(* Merge data *)

let merge input track ?(time_lag=0.0) =
  (* TODO *)
  input

(* Command line arguments *)

let parse_args () =
  let input_path = ref "/dev/fd/0" in
  let output_path = ref "/dev/fd/1" in
  let track_path = ref "track.gpx" in
  Arg.parse [ "-input", Arg.Set_string input_path,
              Printf.sprintf "Path to input TCX file (default \"%s\")" !input_path;
              "-output", Arg.Set_string output_path,
              Printf.sprintf "Path to output TCX file (default \"%s\")" !output_path;
              "-track", Arg.Set_string track_path,
              Printf.sprintf "Path to GPX file with GPS data (default \"%s\")" !track_path ]
            (fun _anon -> ())
            "Merge TCX data (heart rate, cadence) with GPS data from a GPX file";
  !input_path, !output_path, !track_path

(* Main *)

let () =
  let input_path, output_path, track_path =
    parse_args () in
  let input =
    try Tcx.parse_file input_path
    with _ -> error (Printf.sprintf "couldn't parse TCX file \"%s\"" input_path) in
  let track =
    try Gpx.of_xml (Xml.parse_file track_path)
    with _ -> error (Printf.sprintf "couldn't parse GPX file \"%s\"" track_path) in
  let output =
    merge input track ?time_lag:None in
  try Tcx.format_file output output_path
  with _ -> error (Printf.sprintf "couldn't save TCX file \"%s\"" output_path)
