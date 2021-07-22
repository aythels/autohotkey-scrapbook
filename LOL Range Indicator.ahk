#singleinstance force
If WinActive("League of Legends (TM) Client")
SetMouseDelay, -1

RButton::
	sendraw a
	sendraw a
return

MButton::
send !{Tab}
return


$0::
	Exitapp
return
