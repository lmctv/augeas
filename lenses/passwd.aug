(* Passwd module for Augeas
 Author: Free Ekanayaka <free@64studio.com>

 Reference: man 5 passwd

*)

module Passwd =

   autoload xfm

(************************************************************************
 *                           USEFUL PRIMITIVES
 *************************************************************************)

let eol        = Util.eol
let comment    = Util.comment
let empty      = Util.empty
let dels       = Util.del_str

let word       = Rx.word
let integer    = Rx.integer

let colon      = Sep.colon

let sto_to_eol = store Rx.space_in
let sto_to_col = store /[^:\r\n]+/

(************************************************************************
 *                               ENTRIES
 *************************************************************************)

let entry     = [ key word
                . colon
                . [ label "password" . sto_to_col?   . colon ]
                . [ label "uid"      . store integer . colon ]
                . [ label "gid"      . store integer . colon ]
                . [ label "name"     . sto_to_col?   . colon ]
                . [ label "home"     . sto_to_col?  . colon ]
                . [ label "shell"    . sto_to_eol? ]
                . eol ]

(* A NIS entry has nothing bar the +@:::::: bits. *)
let nisentry =
  let overrides =
        colon
      . [ label "password" . sto_to_col ]?   . colon
      . [ label "uid"      . store integer ]? . colon
      . [ label "gid"      . store integer ]? . colon
      . [ label "name"     . sto_to_col ]?   . colon
      . [ label "home"     . sto_to_col ]?  . colon
      . [ label "shell"    . sto_to_eol ]? in
  [ dels "+@" . label "@nis" . store word . overrides . eol ]

let nisdefault =
  let overrides =
        colon
      . [ label "password" . store word?    . colon ]
      . [ label "uid"      . store integer? . colon ]
      . [ label "gid"      . store integer? . colon ]
      . [ label "name"     . sto_to_col?    . colon ]
      . [ label "home"     . sto_to_col?    . colon ]
      . [ label "shell"    . sto_to_eol? ] in
  [ dels "+" . label "@nisdefault" . overrides? . eol ]

(************************************************************************
 *                                LENS
 *************************************************************************)

let lns        = (comment|empty|entry|nisentry|nisdefault) *

let filter     = incl "/etc/passwd"

let xfm        = transform lns filter
