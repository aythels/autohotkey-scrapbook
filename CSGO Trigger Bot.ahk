If WinActive("Counter-Strike: Global Offensive")
#singleinstance force

$t::
	{
		PixelGetColor, OutputVar, 805, 450
		loop,
			{
				PixelGetColor, OutputVar2, 805, 450
				if OutputVar2 != %OutputVar% ;and (GetKeyState("t", "P"))
					{
						if (GetKeyState("t", "P")) = 0
							{
								break
							}
						click
						break
					}
			}
		sleep 1000
	}
return

$^t::
	loop,
	{
		PixelGetColor, idoldetector, 839, 790
		sleep, 500
		PixelGetColor, idoldetector2, 839, 790
		if idoldetector = %idoldetector2% 
			{
				PixelGetColor, target, 805, 450
				loop,
					{
						PixelGetColor, finalidol, 839, 790
						PixelGetColor, check, 805, 450
						if target != %check% and finalidol = %idoldetector%
							{
								click
								break
							}
					}
				break
			}	
	}
return

$0::
	ExitApp
Return