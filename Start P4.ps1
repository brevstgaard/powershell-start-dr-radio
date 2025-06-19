Add-Type @"
using System;
using System.Runtime.InteropServices;
public class User32 {
    [DllImport("user32.dll")]
    public static extern IntPtr GetDC(IntPtr hwnd);
    
    [DllImport("user32.dll")]
    public static extern int ReleaseDC(IntPtr hwnd, IntPtr hdc);

    [DllImport("gdi32.dll")]
    public static extern uint GetPixel(IntPtr hdc, int x, int y);

    [DllImport("user32.dll")]
    public static extern void SetCursorPos(int x, int y);
    
    [DllImport("user32.dll")]
    public static extern bool mouse_event(int dwFlags, int dx, int dy, int dwData, int dwExtraInfo);
    
    public const int MOUSEEVENTF_LEFTDOWN = 0x02;
    public const int MOUSEEVENTF_LEFTUP = 0x04;

    [DllImport("user32.dll")]
    public static extern bool GetCursorPos(out POINT lpPoint);

    public struct POINT {
        public int X;
        public int Y;
    }
}
"@

# Function to click at a given position
function Click-At {
    param (
        [int]$x,
        [int]$y
    )
    [User32]::SetCursorPos($x, $y) | Out-Null
    Start-Sleep -Milliseconds 100
    [User32]::mouse_event([User32]::MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0) | Out-Null
    Start-Sleep -Milliseconds 50
    [User32]::mouse_event([User32]::MOUSEEVENTF_LEFTUP, 0, 0, 0, 0) | Out-Null
}

Start-Process -FilePath "C:\Program Files\Google\Chrome\Application\chrome.exe" -ArgumentList "https://www.dr.dk/lyd" -WindowStyle Maximized
sleep 5
write-host "yey"
click-at -x 800 -y 321
