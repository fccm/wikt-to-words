(* Copyright (C) 2021 Florent Monnier

  This software is provided "AS-IS", without any express or implied warranty.
  In no event will the authors be held liable for any damages arising from
  the use of this software.

  Permission is granted to anyone to use this software without restrictions
  for any purpose, including commercial applications, and to alter it and
  redistribute it freely. *)

let () =
  let i = Xmlm.make_input ~strip:true (`Channel stdin) in
  let title = ref "" in
  let tag_path = ref [] in
  let push_tag tag =
    tag_path := tag :: !tag_path
  in
  let pop_tag () =
    match !tag_path with [] -> ()
    | _ :: tl -> tag_path := tl
  in
  let last_tag_is tag =
    match !tag_path with [] -> false
    | hd :: _ -> hd = tag
  in
  let lang = try Sys.argv.(1) with _ -> "English" in
  let reg = Str.regexp_string ("==" ^ lang ^ "==") in
  let matches s =
    try let _ = Str.search_forward reg s 0 in true
    with Not_found -> false
  in
  let starts_with sub s =
    let n1 = String.length s
    and n2 = String.length sub in
    n2 <= n1 &&
      sub = (String.sub s 0 n2)
  in
  while not (Xmlm.eoi i) do
    match Xmlm.input i with
    | `Dtd dtd -> ()
    | `El_start ((uri, tag_name), attrs) -> push_tag tag_name
    | `El_end -> pop_tag ()
    | `Data s ->
        if last_tag_is "title"
        then title := s;
        if last_tag_is "text"
        then begin
          if matches s
          && not (starts_with "Wiktionary:" !title)
          && not (starts_with "Thesaurus:" !title)
          then print_endline !title
        end
  done
