Attribute VB_Name = "Painting"
   Public Const SRCCOPY = &HCC0020
   Public Const SRCAND = &H8800C6
   Public Const SRCPAINT = &HEE0086
   Public Const NOTSRCCOPY = &H330008

   Type bitmap


      bmType As Long
      bmWidth As Long
      bmHeight As Long
      bmWidthBytes As Long
      bmPlanes As String * 1
      bmBitsPixel As String * 1
      bmBits As Long

   End Type
   Public Type POINTAPI
        x As Long
        y As Long
   End Type

   Public Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long

   Declare Function SetBkColor Lib "gdi32" (ByVal hdc As Long, ByVal cColor As Long) As Long
   Declare Function CreateCompatibleDC Lib "gdi32" (ByVal hdc As Long) As Long
   Declare Function DeleteDC Lib "gdi32" (ByVal hdc As Long) As Long
   Declare Function CreateBitmap Lib "gdi32" (ByVal nWidth As Long, ByVal nHeight As Long, ByVal cbPlanes As Long, ByVal cbBits As Long, lpvBits As Any) As Long
   Declare Function CreateCompatibleBitmap Lib "GDI" (ByVal hdc As Long, ByVal nWidth As Long, ByVal nHeight As Long) As Long
   Declare Function SelectObject Lib "gdi32" (ByVal hdc As Long, ByVal hObject As Long) As Long
   Declare Function DeleteObject Lib "gdi32" (ByVal hObject As Long) As Long
   Declare Function GetObj Lib "gdi32" Alias "GetObject" (ByVal hObject As Long, ByVal nCount As Long, bmp As Any) As Long
   Declare Function SetTextColor Lib "gdi32" (ByVal hdc As Long, ByVal crColor As Long) As Long
   Declare Function Rectangle Lib "gdi32" (ByVal hdc As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long) As Long
   Declare Function LineTo Lib "gdi32" (ByVal hdc As Long, ByVal x As Long, ByVal y As Long) As Long
   Declare Function MoveToEx Lib "gdi32" (ByVal hdc As Long, ByVal x As Long, ByVal y As Long, lpPoint As POINTAPI) As Long
 
