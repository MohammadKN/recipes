#Persistent
SetTimer, WatchCursor, 200
return

StartTime := 0


WatchCursor:

WinGetTitle, active_title, A

WinGetPos, X, Y, W, H, A

MouseGetPos, xpos, ypos
if xpos >= 1919
{
    StartTime++
    if StartTime >1
    {
        StartTime := 0
        Send ^#{Right}
    }

}
else if xpos < 10
{
    StartTime++
    if StartTime >1
    {
        StartTime := 0
        Send ^#{Left}
    }

}
else
{
    StartTime := 0
}

return
