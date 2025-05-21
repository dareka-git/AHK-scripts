#Requires AutoHotkey v2
^/::
{
	/*
		Global variables
	*/

	/* ¢¤¥¦§©ª«®µ¶ */
	specialChar := "¶"
	delimiters := [".", "?", "!"]
	paragraphText := ""
	segments := Array()
	segment	:= ""
	logFile := "splitter-log.txt"
	splitResults := True
	splitParagraph :=False

	/*
		Logic Start
	*/

	;A_Clipboard := ""  ; Start off empty to allow ClipWait to detect when the text has arrived.
	;Send "^c"
	;ClipWait  ; Wait for the clipboard to contain text.
	paragraphText := A_Clipboard
	;MsgBox paragraphText

	paragraphText := StrReplace(paragraphText, "`r`n", "¶")
	if splitParagraph {
		Loop delimiters.Length {
			delimiterPhrase := delimiters[A_Index] " "
			paragraphText := StrReplace(paragraphText, delimiterPhrase, delimiters[A_Index] "¶")
		}
	}
	segments := StrSplit(paragraphText , "¶")

	if WinExist("ahk_exe SDLTradosStudio.exe") {
		WinActivate
		Loop segments.Length {
		;MsgBox segments[A_Index]
		SetKeyDelay 50
		SendEvent "^a"
		SendInput "{Text}" segments[A_Index]
		SetKeyDelay 50
		Send "{Left}"
		;Send "^{Down}"
		;SetKeyDelay 50
		;Send "^a"
		SendEvent "{Down}"
		}
	}
	else {
		MsgBox "I can not find running Trados Studio window"
		SendInput "{Text}" paragraphText
	}

	/*
		Logic End    
	*/


	/*
	   Helper methods
	*/
	ReplaceMultipleNewLines(inputText) {
		outputText := inputText
		Loop
		{
			outputText := StrReplace(outputText, "`r`n`r`n", "`r`n",, &Count)
			if (Count = 0)  ; No more replacements needed.
				break
		}	
		return outputText
	}

}