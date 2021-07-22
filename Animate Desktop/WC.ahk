SaveWallpaper := GetWallpaper()
	loop,
	{
		SetWallpaper(A_ScriptDir "\sponge1.png")
		sleep, 80
		SetWallpaper(A_ScriptDir "\sponge2.png")
		sleep, 80
		SetWallpaper(A_ScriptDir "\sponge3.png")
		sleep, 80
		SetWallpaper(A_ScriptDir "\sponge4.png")
		sleep, 80
		SetWallpaper(A_ScriptDir "\sponge5.png")
		sleep, 80
		SetWallpaper(A_ScriptDir "\sponge6.png")
		sleep, 80
	}
return

GetWallpaper()
{
    static SystemParametersInfo := A_IsUnicode ? "SystemParametersInfoW" 
                                               : "SystemParametersInfoA"
    static SPI_GETDESKWALLPAPER := 0x0073
    MaxSize := VarSetCapacity(sFile, 260)
    DllCall(SystemParametersInfo
            , "uint", SPI_GETDESKWALLPAPER
            , "uint", MaxSize
            , "str", sFile
            , "uint", 0 )
    return sFile
}

SetWallpaper(sFile)
{
    static SystemParametersInfo := A_IsUnicode ? "SystemParametersInfoW" 
                                               : "SystemParametersInfoA"
    static SPI_SETDESKWALLPAPER	:= 0x0014
    DllCall( "SystemParametersInfo"
           , "uint", SPI_SETDESKWALLPAPER
           , "uint", 0
           , "str", sFile
           , "uint", 0 )
    return
}

$0::
	SetWallpaper(SaveWallpaper)
	Exitapp
return