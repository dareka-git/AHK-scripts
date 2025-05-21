#Requires AutoHotkey v2
/*
		Global variables
*/

^+c::
{
/*
		Local variables
*/
	numberOfSegments := 1
	collectedText := ""
/*
		Logic start
*/
	numberOfSegments := SetNumberOfSegments()
	Loop numberOfSegments {
		A_Clipboard := ""  ; Start off empty to allow ClipWait to detect when the text has arrived.
		SetKeyDelay 75
		SendEvent "^a"
		SendEvent "^c"
		if !ClipWait(2)
		{
			MsgBox "The attempt to copy text onto the clipboard failed."
			return
		}
		collectedText := collectedText "`r`n" A_Clipboard
		;MsgBox collectedText
		SendEvent "{Down}"
	}
	A_Clipboard := collectedText
	MsgBox "Text collected: " "`r`n" collectedText
/*
		Logic end
*/

/*
		Helper methods
*/
	SetNumberOfSegments() {
		EnterNumberOfSegmentsInputBox := InputBox("Please enter a number of segments to collect text from.", "Number of segments", "w320 h240")
		if EnterNumberOfSegmentsInputBox.Result = "OK" {
			return EnterNumberOfSegmentsInputBox.Value
		}
	}
	
}