DetectHiddenWindows, On
#SingleInstance force
SetKeyDelay, 10, 10
ComObjError(false)

pwb := ComObjCreate("InternetExplorer.Application")
pwb.Visible := True

pwb.Navigate("https://www.facebook.com/messages/t/3252505832525")
While, (pwb.ReadyState <> 4)
	Sleep, 3000

loop,
	{
		varx := pwb.document.getElementsByClassName("_3oh- _58nk").length
		array := varx - 1
		vary := pwb.document.getElementsByClassName("_3oh- _58nk")[(array)].innerhtml
		
		IfInString, vary, #
			{
				If array <> %oldarray% 
					{
						oldarray = %array%
						gosub commands
					}
			}
	}
Return


commands:
	if vary = #hi
		TextResponse("hello")
	if vary = #shutdown
	{
		TextResponse("Shuting down.")
		gosub ExitSub
	}
	if vary = #p
	{
		gosub PrintScreen
	}
return

PrintScreen:
	Send {PrintScreen}
	ControlSend, Internet Explorer_Server1, ^v ,ahk_class IEFrame
return

$0::
	gosub ExitSub
return

TextResponse(TEXT)
{
	ControlSend, Internet Explorer_Server1 ,%TEXT% ,ahk_class IEFrame
	sleep, 400
	ControlSend, Internet Explorer_Server1 ,{Enter} ,ahk_class IEFrame
	sleep, 200
	return
}
	
ExitSub:
	ifwinexist, ahk_class IEFrame
	{
		loop
		{
			winclose, ahk_class IEFrame
			IfWinNotExist, ahk_class IEFrame
				ExitApp
		}

	}
	ExitApp
