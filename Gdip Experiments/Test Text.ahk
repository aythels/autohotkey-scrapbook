; Made in http://youtu.be/OPc9kE5Wpec

#Include, Gdip.ahk
#Include, Gdip2.ahk

SetUpGDIP()
StartDrawGDIP()
ClearDrawGDIP()

Gdip_SetSmoothingMode(G, 4)

Gdip_TextToGraphics(G, "test text", "x350 y200 cff00FFFF r4 s68")

EndDrawGDIP()
return