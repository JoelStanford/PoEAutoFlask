;----------------------------------------------------------------------
; PoE Flasks macro for AutoHotKey
;
; Keys used and monitored:
; alt+f12 - activate automatic flask usage
; right mouse button - primary attack skills
; 1-5 - number keys to manually use a specific flask
; ` (backtick) - use all flasks, now
;----------------------------------------------------------------------
#IfWinActive Path of Exile
#SingleInstance force
#NoEnv  
#Warn  
#Persistent 

FlaskDurationInit := []
;----------------------------------------------------------------------
; Set the duration of each flask, in ms, below.  For example, if the 
; flask in slot 3 has a duration of "Lasts 4.80 Seconds", then use:
;		FlaskDurationInit[3] := 4800
;
; To disable a particular flask, set it's duration to 0
;----------------------------------------------------------------------
FlaskDurationInit[1] := 4200
FlaskDurationInit[2] := 4700
FlaskDurationInit[3] := 4800
FlaskDurationInit[4] := 6000
FlaskDurationInit[5] := 6200

FlaskDuration := []
FlaskLastUsed := []
UseFlasks := false
HoldRightClick := false
LastRightClick := 0

Loop {
	;----------------------------------------------------------------------
	; Main program loop - basics are that we use flasks whenever flask
	; usage is enabled via hotkey (default is F12), and we've attacked
	; within the last 0.5 second (or are channeling/continuous attacking.
	;----------------------------------------------------------------------
	if (UseFlasks) {
		; have we attacked in the last 0.5 seconds?
		if ((A_TickCount - LastRightClick) < 500) {
			Gosub, CycleAllFlasksWhenReady
		} else {
			; We haven't attacked recently, but are we channeling/continuous?
			if (HoldRightClick) {
				Gosub, CycleAllFlasksWhenReady
			}
		}
	}
}

!F12::
	UseFlasks := not UseFlasks
	if UseFlasks {
		; initialize start of auto-flask use
		ToolTip, UseFlasks On
		
		; reset usage timers for all flasks
		for i in FlaskDurationInit {
			FlaskLastUsed[i] := 0
			FlaskDuration[i] := FlaskDurationInit[i]
		}
		StartTick := A_TickCount ; Get the current system tickcount	in ms
	} else {
		ToolTip, UseFlasks Off
	}
	return

~RButton::
	; pass-thru and capture when the last attack (Right click) was done
	; we also track if the mouse button is being held down for continuous attack(s) and/or channelling skills
	HoldRightClick := true
	LastRightClick := A_TickCount
	return

~RButton up::
	; pass-thru and release the right mouse button
	HoldRightClick := false
	return

;----------------------------------------------------------------------
; The following 5 hotkeys allow for manual use of flasks while still
; tracking optimal recast times.
;----------------------------------------------------------------------
~1::
	; pass-thru and start timer for flask 1
	FlaskLastUsed[1] := A_TickCount
	Random, VariableDelay, -99, 99
	FlaskDuration[1] := FlaskDurationInit[1] + VariableDelay ; randomize duration to simulate human
	return

~2::
	; pass-thru and start timer for flask 2
	FlaskLastUsed[2] := A_TickCount
	Random, VariableDelay, -99, 99
	FlaskDuration[2] := FlaskDurationInit[2] + VariableDelay ; randomize duration to simulate human
	return

~3::
	; pass-thru and start timer for flask 3
	FlaskLastUsed[3] := A_TickCount
	Random, VariableDelay, -99, 99
	FlaskDuration[3] := FlaskDurationInit[3] + VariableDelay ; randomize duration to simulate human
	return

~4::
	; pass-thru and start timer for flask 4
	FlaskLastUsed[4] := A_TickCount
	Random, VariableDelay, -99, 99
	FlaskDuration[4] := FlaskDurationInit[4] + VariableDelay ; randomize duration to simulate human
	return

~5::
	; pass-thru and start timer for flask 5
	FlaskLastUsed[5] := A_TickCount
	Random, VariableDelay, -99, 99
	FlaskDuration[5] := FlaskDurationInit[5] + VariableDelay ; randomize duration to simulate human
	return

;----------------------------------------------------------------------
; Use all flasks, now.  A variable delay is included between flasks
; NOTE: this will use all flasks, even those with a FlaskDurationInit of 0
;----------------------------------------------------------------------
`::
	Send 1
	Random, VariableDelay, -99, 99
	Sleep, %VariableDelay%
	Send 2
	Random, VariableDelay, -99, 99
	Sleep, %VariableDelay%
	Send 3
	Random, VariableDelay, -99, 99
	Sleep, %VariableDelay%
	Send 4
	Random, VariableDelay, -99, 99
	Sleep, %VariableDelay%
	Send 5
	return

CycleAllFlasksWhenReady:
	for flask, duration in FlaskDuration {
		; skip flasks with 0 duration and skip flasks that are still active
		if ((duration > 0) & (duration < A_TickCount - FlaskLastUsed[flask])) {
			Send %flask%
			FlaskLastUsed[flask] := A_TickCount
			Random, VariableDelay, -99, 99
			FlaskDuration[flask] := FlaskDurationInit[flask] + VariableDelay ; randomize duration to simulate human
		}
	}
	return

