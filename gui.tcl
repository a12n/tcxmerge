#!/usr/bin/env wish

set inputPath {}
set trackPath {}
set outputPath {}

set inputFileTypes [list {"Training Center XML Files" ".tcx"} {"All Files" "*"}]
set trackFileTypes [list {"GPS Exchange Files" ".gpx"} {"All Files" "*"}]

namespace eval mergeCmd {
    proc find {} {
        foreach prefix {{} ./} {
            foreach suffix {{} .exe .native} {
                set cmd [auto_execok ${prefix}tcxmerge${suffix}]
                if {$cmd ne {}} {
                    return $cmd
                }
            }
        }
        return {}
    }

    proc formatErr {err} {
        return [join [lmap line [split $err \n] { string trim "${line}." }] \n]
    }
}

wm title . "TCX Merge"
wm minsize . 480 180

ttk::label .inputLabel -text "Input TCX:"

ttk::entry .inputEntry -textvariable inputPath

ttk::button .inputButton -text "Browse..." -command {
    .statusLabel configure -text {}
    set path [tk_getOpenFile -filetypes $inputFileTypes \
                  -initialdir [file dirname $inputPath] \
                  -typevariable curInputFileType]
    if {$path ne {}} {
        set inputPath $path
    }
}

ttk::label .trackLabel -text "GPX Track:"

ttk::entry .trackEntry -textvariable trackPath

ttk::button .trackButton -text "Browse..." -command {
    .statusLabel configure -text {}
    set path [tk_getOpenFile -filetypes $trackFileTypes \
                  -initialdir [file dirname $trackPath] \
                  -typevariable curTrackFileType]
    if {$path ne {}} {
        set trackPath $path
    }
}

ttk::label .outputLabel -text "Output TCX:"

ttk::entry .outputEntry -textvariable outputPath

ttk::button .outputButton -text "Browse..." -command {
    .statusLabel configure -text {}
    set path [tk_getSaveFile -filetypes $inputFileTypes \
                  -initialdir [file dirname $outputPath] \
                  -typevariable curOutputFileType]
    if {$path ne {}} {
        set outputPath $path
    }
}

ttk::label .statusLabel -anchor center -justify center

ttk::button .mergeButton -text "Merge" -command {
    .statusLabel configure -text {}
    set cmd [mergeCmd::find]
    if {$cmd ne {}} {
        tk busy hold .
        catch {exec {*}$cmd -input $inputPath -track $trackPath -output $outputPath} cmdErr
        .statusLabel configure -text [mergeCmd::formatErr $cmdErr]
        tk busy forget .
    } else {
        .statusLabel configure -text \
            "Couldn't locate merge program. Make sure that 'tcxmerge' is in the PATH."
    }
}

grid rowconfigure    . 3 -weight 1
grid columnconfigure . 1 -weight 1

grid .inputLabel   -row 0 -column 0 -sticky nesw -padx 5 -pady 5
grid .inputEntry   -row 0 -column 1 -sticky nesw -padx 5 -pady 5
grid .inputButton  -row 0 -column 2 -sticky nesw -padx 5 -pady 5
grid .trackLabel   -row 1 -column 0 -sticky nesw -padx 5 -pady 5
grid .trackEntry   -row 1 -column 1 -sticky nesw -padx 5 -pady 5
grid .trackButton  -row 1 -column 2 -sticky nesw -padx 5 -pady 5
grid .outputLabel  -row 2 -column 0 -sticky nesw -padx 5 -pady 5
grid .outputEntry  -row 2 -column 1 -sticky nesw -padx 5 -pady 5
grid .outputButton -row 2 -column 2 -sticky nesw -padx 5 -pady 5
grid .statusLabel  -row 3 -column 0 -sticky nesw -padx 5 -pady 5 -columnspan 3
grid .mergeButton  -row 4 -column 0 -sticky nesw -padx 5 -pady 5 -columnspan 3
