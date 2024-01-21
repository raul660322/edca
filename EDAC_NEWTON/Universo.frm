VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form Universo 
   Caption         =   "Energy Driven CA"
   ClientHeight    =   11010
   ClientLeft      =   4905
   ClientTop       =   2415
   ClientWidth     =   14715
   FillStyle       =   0  'Solid
   LinkTopic       =   "Form1"
   ScaleHeight     =   734
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   981
   Begin VB.TextBox Text2 
      Height          =   285
      Left            =   13500
      TabIndex        =   39
      Text            =   "1000"
      Top             =   135
      Width           =   930
   End
   Begin VB.CommandButton SEnergy 
      Caption         =   "Save Energy"
      Height          =   345
      Left            =   10335
      TabIndex        =   38
      Top             =   105
      Width           =   1185
   End
   Begin VB.CheckBox VerEnergia 
      Caption         =   "Show Energy"
      Height          =   270
      Left            =   3390
      TabIndex        =   37
      Top             =   135
      Value           =   1  'Checked
      Width           =   1530
   End
   Begin VB.TextBox Promedio 
      Height          =   300
      Left            =   13920
      TabIndex        =   35
      Text            =   "0"
      Top             =   5415
      Width           =   555
   End
   Begin VB.TextBox ElTic 
      Height          =   315
      Left            =   9060
      TabIndex        =   33
      Text            =   "0"
      Top             =   105
      Width           =   915
   End
   Begin VB.PictureBox Picture5 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00000000&
      DrawStyle       =   5  'Transparent
      FillStyle       =   0  'Solid
      Height          =   465
      Left            =   14025
      ScaleHeight     =   27
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   17
      TabIndex        =   32
      Top             =   8340
      Visible         =   0   'False
      Width           =   315
   End
   Begin VB.PictureBox Picture4 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00000000&
      DrawStyle       =   5  'Transparent
      FillStyle       =   0  'Solid
      Height          =   405
      Left            =   13245
      ScaleHeight     =   23
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   22
      TabIndex        =   31
      Top             =   8430
      Visible         =   0   'False
      Width           =   390
   End
   Begin VB.PictureBox Picture3 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00000000&
      DrawStyle       =   5  'Transparent
      FillStyle       =   0  'Solid
      Height          =   375
      Left            =   14025
      ScaleHeight     =   21
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   21
      TabIndex        =   30
      Top             =   8385
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.PictureBox Picture2 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00000000&
      DrawStyle       =   5  'Transparent
      FillStyle       =   0  'Solid
      Height          =   375
      Left            =   13350
      ScaleHeight     =   21
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   21
      TabIndex        =   29
      Top             =   8385
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Command2"
      Height          =   285
      Left            =   14250
      TabIndex        =   28
      Top             =   810
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   405
      Left            =   13110
      TabIndex        =   27
      Top             =   495
      Visible         =   0   'False
      Width           =   960
   End
   Begin VB.Frame Frame2 
      Caption         =   "Energía Total"
      Height          =   870
      Left            =   13200
      TabIndex        =   18
      Top             =   6750
      Width           =   1335
      Begin VB.TextBox ETN 
         Height          =   315
         Left            =   495
         TabIndex        =   24
         Text            =   "0"
         Top             =   465
         Width           =   615
      End
      Begin VB.TextBox ETP 
         Height          =   285
         Left            =   495
         TabIndex        =   23
         Text            =   "0"
         Top             =   195
         Width           =   615
      End
      Begin VB.Label Label8 
         Caption         =   "-"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   270
         Left            =   285
         TabIndex        =   26
         Top             =   495
         Width           =   135
      End
      Begin VB.Label Label7 
         Caption         =   "+"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   255
         TabIndex        =   25
         Top             =   255
         Width           =   210
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Energía Creada"
      Height          =   930
      Left            =   13185
      TabIndex        =   17
      Top             =   5730
      Width           =   1335
      Begin VB.TextBox ECN 
         Height          =   315
         Left            =   480
         TabIndex        =   20
         Text            =   "0"
         Top             =   495
         Width           =   615
      End
      Begin VB.TextBox ECP 
         Height          =   285
         Left            =   480
         TabIndex        =   19
         Text            =   "0"
         Top             =   225
         Width           =   615
      End
      Begin VB.Label Label6 
         Caption         =   "-"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   270
         Left            =   270
         TabIndex        =   22
         Top             =   525
         Width           =   135
      End
      Begin VB.Label Label5 
         Caption         =   "+"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   240
         TabIndex        =   21
         Top             =   285
         Width           =   210
      End
   End
   Begin VB.TextBox Poblacion 
      Height          =   285
      Left            =   13920
      TabIndex        =   15
      Text            =   "0"
      Top             =   5085
      Width           =   570
   End
   Begin VB.TextBox Text1 
      Enabled         =   0   'False
      Height          =   285
      Left            =   13605
      TabIndex        =   14
      Text            =   "0"
      Top             =   1320
      Width           =   465
   End
   Begin VB.Timer Timer2 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   14310
      Top             =   4215
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      ItemData        =   "Universo.frx":0000
      Left            =   13200
      List            =   "Universo.frx":0019
      TabIndex        =   10
      Text            =   "Combo1"
      Top             =   4560
      Width           =   990
   End
   Begin VB.CommandButton BStop 
      Caption         =   "Stop"
      Height          =   330
      Left            =   7125
      TabIndex        =   9
      Top             =   75
      Width           =   660
   End
   Begin VB.CommandButton BStart 
      Caption         =   "Start"
      Height          =   375
      Left            =   6225
      TabIndex        =   8
      Top             =   60
      Width           =   705
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Left            =   5670
      Top             =   60
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Down"
      Height          =   480
      Left            =   13560
      TabIndex        =   7
      Top             =   3570
      Width           =   585
   End
   Begin VB.CommandButton Command3 
      Caption         =   "UP"
      Height          =   480
      Left            =   13530
      TabIndex        =   6
      Top             =   2355
      Width           =   615
   End
   Begin VB.CommandButton Derecha 
      Caption         =   "--->"
      Height          =   525
      Left            =   14070
      TabIndex        =   5
      Top             =   2910
      Width           =   435
   End
   Begin VB.CommandButton Izquierda 
      Caption         =   "<---"
      Height          =   510
      Left            =   13080
      TabIndex        =   4
      Top             =   2910
      Width           =   450
   End
   Begin VB.CommandButton Alejar 
      Caption         =   "-"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   14190
      TabIndex        =   3
      Top             =   1305
      Width           =   315
   End
   Begin VB.CommandButton Acercar 
      Caption         =   "+"
      Height          =   315
      Left            =   13170
      TabIndex        =   2
      Top             =   1305
      Width           =   375
   End
   Begin VB.PictureBox Picture1 
      AutoRedraw      =   -1  'True
      FillStyle       =   0  'Solid
      Height          =   10350
      Left            =   150
      ScaleHeight     =   611.408
      ScaleMode       =   0  'User
      ScaleWidth      =   845.238
      TabIndex        =   1
      Top             =   510
      Width           =   12840
   End
   Begin MSComDlg.CommonDialog CommonDialog1 
      Left            =   2460
      Top             =   30
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.CommandButton BOpen 
      Caption         =   "Open Model"
      Height          =   420
      Left            =   135
      TabIndex        =   0
      Top             =   60
      Width           =   1110
   End
   Begin MSComDlg.CommonDialog CommonDialog2 
      Left            =   0
      Top             =   0
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.Label Label11 
      Caption         =   "Energy time limit:"
      Height          =   225
      Left            =   12270
      TabIndex        =   40
      Top             =   150
      Width           =   1215
   End
   Begin VB.Label Label10 
      Caption         =   "Promedio:0"
      Height          =   300
      Left            =   13185
      TabIndex        =   36
      Top             =   5415
      Width           =   705
   End
   Begin VB.Label Label9 
      Caption         =   "Tic:"
      Height          =   240
      Left            =   8700
      TabIndex        =   34
      Top             =   135
      Width           =   360
   End
   Begin VB.Label Label4 
      Caption         =   "Population:"
      Height          =   225
      Left            =   13110
      TabIndex        =   16
      Top             =   5100
      Width           =   780
   End
   Begin VB.Label Label3 
      Caption         =   "Scroll"
      Height          =   255
      Left            =   13560
      TabIndex        =   13
      Top             =   1980
      Width           =   480
   End
   Begin VB.Label Label2 
      Caption         =   "Zoom"
      Height          =   210
      Left            =   13590
      TabIndex        =   12
      Top             =   960
      Width           =   570
   End
   Begin VB.Label Label1 
      Caption         =   "Interval (ms)"
      Height          =   240
      Left            =   13215
      TabIndex        =   11
      Top             =   4305
      Width           =   945
   End
End
Attribute VB_Name = "Universo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim NPromedio As Long
' Return the angle with tangent opp/hyp. The returned
' value is between 180 and -180.
Function ATan2(ByVal opp As Single, ByVal adj As Single) As Double
Dim angle As Single

    ' Get the basic angle.
    If Abs(adj) < 0.0000000001 Then
        angle = PI / 2
    Else
        angle = Abs(Atn(opp / adj))
    End If

    ' See if we are in quadrant 2 or 3.
    If adj < 0 Then
        ' angle > PI/2 or angle < -PI/2.
        angle = PI - angle
    End If

    ' See if we are in quadrant 3 or 4.
    If opp < 0 Then
        angle = 2 * PI - angle
    End If

    ' Return the result.
    ATan2 = (angle * PIGRAD)
End Function
Function Angle360(alpha As Double) As Double
   If alpha > 180 Then
      Angle360 = alpha - 360
   Else
      If alpha < -180 Then
         Angle360 = alpha + 360
      Else
         Angle360 = alpha
      End If
   End If
End Function

Function GetSensorInfo(ByVal ElSensor As Long, ElTic As Long, laep As Long, laen As Long) As Long
With Gauge(ElSensor)
      If (ElTic = .Dato(.Last).tic) Then
         laep = .Dato(.Last).EP
         laen = .Dato(.Last).EN
         GetSensorInfo = 1
         If .Last < .NData Then
            .Last = .Last + 1
         End If
      Else
         laep = 0
         laen = 0
         GetSensorInfo = 0
      End If
End With
End Function
Sub CheckSensors()
Dim TEP As Long, TEN As Long
For i = 1 To NSensors
   TEP = 0
   TEN = 0
   With Gauge(i)
   If .x + .y + .zx1 + .zx2 + .zy1 + .zy2 <> 0 Then
      If .x > 0 Then   'Si .x=0 cuenta población, de lo contrario, energía
         For j = 1 To NP
            If ((.zx1 <= EP(j).cx) And (.zx2 >= EP(j).cx) And (.zy1 <= EP(j).cy) And (.zy2 >= EP(j).cy)) Then
               A = ((Abs(.x - EP(j).cx) < EP(j).Rg + R) And (Abs(.y - EP(j).cy) < EP(j).Rg + R))
               B = ((Abs(.x - EP(j).cx) < EP(j).Rg) And (Abs(.y - EP(j).cy) < EP(j).Rg))
               c = ((.x <> EP(j).cx) Or (.y <> EP(j).cy))
               If A And (Not B) And c And (EP(j).living = 1) Then
                  TEP = TEP + 1
               End If
            End If
         Next
         For j = 1 To NN
            If ((.zx1 <= EN(j).cx) And (.zx2 >= EN(j).cx) And (.zy1 <= EN(j).cy) And (.zy2 >= EN(j).cy)) Then
               A = ((Abs(.x - EN(j).cx) < EN(j).Rg + R) And (Abs(.y - EN(j).cy) < EN(j).Rg + R))
               B = ((Abs(.x - EN(j).cx) < EN(j).Rg) And (Abs(.y - EN(j).cy) < EN(j).Rg))
               c = ((.x <> EN(j).cx) Or (.y <> EN(j).cy))
               If A And (Not B) And c And (EN(j).living = 1) Then
                  TEN = TEN + 1
               End If
             End If
         Next
      Else
         If .x = 0 Then 'Conteo de población
            TEP = N 'EP-Población total, EN-Población en la zona abarcada por el sensor
            For j = 1 To N
              If ((.zx1 <= L(j).x) And (.zx2 >= L(j).x) And (.zy1 <= L(j).y) And (.zy2 >= L(j).y)) Then
                 TEN = TEN + 1
              End If
            Next
         Else     'Temperatura
            For j = 1 To NP
               If ((.zx1 <= EP(j).cx) And (.zx2 >= EP(j).cx) And (.zy1 <= EP(j).cy) And (.zy2 >= EP(j).cy)) Then
                  If (EP(j).Rg = RInicio) And (EP(j).living = 1) Then
                     TEP = TEP + 1
                  End If
               End If
            Next
            For j = 1 To NN
               If ((.zx1 <= EN(j).cx) And (.zx2 >= EN(j).cx) And (.zy1 <= EN(j).cy) And (.zy2 >= EN(j).cy)) Then
                  If (EN(j).Rg = RInicio) And (EN(j).living = 1) Then
                     TEN = TEN + 1
                  End If
               End If
            Next
         End If
      End If
   Else 'Registra la energia global
      TEP = NP
      TEN = NN
   End If
   If ((TEP > 0) Or (TEN > 0)) Then
        .NData = .NData + 1
        If .NData > UBound(.Dato()) Then
           ReDim Preserve .Dato(UBound(.Dato) + 1000)
        End If
        .Dato(.NData).tic = tic
        .Dato(.NData).EP = TEP
        .Dato(.NData).EN = TEN
   End If
   End With
Next
End Sub
Function RNormal(c As Long) As Double
Dim S As Double
If c <> 0 Then
  S = 0
  For i = 1 To c
     S = S + Rnd()
  Next
  RNormal = Sqr(Sqr(S / c))
Else
  RNormal = 0.5
End If
End Function
Sub MakeGravityField()
Dim sx As Double, sy As Double, mix As Double, miy As Double, difx As Double, dify As Double
Dim fuerza As Double, dist As Double
For i = 1 To Horizonte
   For j = 1 To Horizonte
      sx = 0
      sy = 0
      mix = i
      miy = j
      For k = 1 To NStars
      With Star(k)
      fuerza = .strength
      Select Case .tipo
      Case 1 'Puntual
         difx = .x - mix
         dify = .y - miy
         'sx = sx + Abs(difx) * Sgn(difx) * fuerza
         'sy = sy + Abs(dify) * Sgn(dify) * fuerza
         sx = difx
         sy = dify
      
      Case 2 'Horiz no
         difx = .x - mix
         sx = sx + Abs(difx) * Sgn(difx) * fuerza
      Case 3 'Vert  no
         dify = .y - miy
         sy = sy + Abs(dify) * Sgn(dify) * fuerza
      End Select
      End With
      Next
      dist = Sqr(sx * sx + sy * sy)
      If dist <> 0 Then
         reticula(i, j).g = Sqr(sx * sx + sy * sy)
      Else
         reticula(i, j).g = 0.01
      End If
   Next
Next
End Sub
Sub PrepararExp()
Dim k2 As Integer, j1 As Integer, j2 As Integer, lax As Integer, lay As Integer
For k1 = 1 To 20
   k2 = 0
   For i = -1 To 1
      For j = -1 To 1
          If ((i <> 0) Or (j <> 0)) Then
              k2 = k2 + 1
              D(k1, k2).dx = i
              D(k1, k2).dy = j
          End If
      Next
   Next
Next
Randomize
For i = 1 To 20
  For j = 1 To 20
     j1 = 1 + Int(Rnd() * 7.99)
     j2 = 1 + Int(Rnd() * 7.99)
     lax = D(i, j1).dx
     lay = D(i, j1).dy
     D(i, j1).dx = D(i, j2).dx
     D(i, j1).dy = D(i, j2).dy
     D(i, j2).dx = lax
     D(i, j2).dy = lay
  Next
Next
End Sub

Sub ArmarReguero()
Dim lax As Long, lay As Long, vive As Byte
Dim irand1 As Long, irand2 As Long
Randomize
For k = 1 To 2 * N
   irand1 = 1 + Int(Rnd() * N)
   irand2 = 1 + Int(Rnd() * N)
   With L(irand1)
      lax = .x
      lay = .y
      vive = .living
      .x = L(irand2).x
      .y = L(irand2).y
      .living = L(irand2).living
   End With
   With L(irand2)
      .x = lax
      .y = lay
      .living = vive
   End With
Next
End Sub
Sub dibWall()
Dim OldPos As POINTAPI
Dim OldColor As Long
OldColor = Me.Picture1.ForeColor
Me.Picture1.ForeColor = RGB(100, 100, 255)
Me.Picture1.DrawWidth = Escala
For i = 1 To NW
   z = MoveToEx(Picture1.hdc, (Wall(i).y1 + WY) * Escala, (Wall(i).x1 + WX) * Escala, OldPos)
   z = LineTo(Picture1.hdc, (Wall(i).y2 + WY) * Escala, (Wall(i).x2 + WX) * Escala)
Next
Me.Picture1.ForeColor = OldColor
End Sub
Sub procesarEne()
Dim NNuevos As Long
NAux = 0
NPA = 0
NNA = 0
NNuevos = 0
CreaBirthList
ProcesarEPos
CreaDeadList
ProcesarENeg
For i = 1 To NAux
   reticula(Laux(i).x, Laux(i).y).v = Laux(i).living
   If Laux(i).living = 1 Then
      NNuevos = NNuevos + 1
      L(NNuevos).living = 1
      L(NNuevos).x = Laux(i).x
      L(NNuevos).y = Laux(i).y
   End If
Next
N = NNuevos
MakeEnergyListNew
End Sub
Sub CreaBirthList()
NComp = 0
Dim S As Byte
For i = N + 1 To N + NVACIOS
    S = 0
    For j = -1 To 1
        For k = -1 To 1
            If ((k <> 0) Or (j <> 0)) Then
               S = S + reticula(L(i).x + j, L(i).y + k).v
            End If
        Next
    Next
    If S > 8 Then S = WallValue
    If ((Rule(S) = 2) Or (Rule(S) = 3)) Then
       NComp = NComp + 1
       LComp(NComp).x = L(i).x
       LComp(NComp).y = L(i).y
       LComp(NComp).living = 0
    End If
Next
End Sub
Sub CreaDeadList()
Dim S As Byte
NComp = 0
For i = 1 To N
    S = 0
    For j = -1 To 1
        For k = -1 To 1
            If ((k <> 0) Or (j <> 0)) Then
               S = S + reticula(L(i).x + j, L(i).y + k).v
            End If
        Next
    Next
    If S > 8 Then S = WallValue
    If ((Rule(S) = 0) Or (Rule(S) = 3)) Then
       NComp = NComp + 1
       LComp(NComp).x = L(i).x
       LComp(NComp).y = L(i).y
       LComp(NComp).living = 1
    Else
       NAux = NAux + 1
       Laux(NAux).x = L(i).x
       Laux(NAux).y = L(i).y
       Laux(NAux).living = 1
    End If
Next
End Sub
Sub ProcesarEPos()
Dim dz As Double, dzmin As Double, mz As Double, mzmin As Double
Dim direc As Integer, difdir As Double, difmin As Double, direne As Integer 'Para cálculo de orientación de la energía
Dim r1 As Double, r2 As Double, pr1 As Double, pr2 As Double, iguales As Double, dif1 As Double, dif2 As Double
Dim jmin As Long
Dim hay As Boolean
Dim dx As Single, dy As Single, gx As Single, gy As Single
If NP > 0 Then
   iguales = 1
   For i = 1 To NP
      'Procesar Drains
      HayDrain = False
      For j = 1 To NDrains
         If Dr(j).T = 1 Then
            With EP(i)
               A = ((Abs(Dr(j).x - .cx) < .Rg + R) And (Abs(Dr(j).y - .cy) < .Rg + R))
               B = ((Abs(Dr(j).x - .cx) < .Rg) And (Abs(Dr(j).y - .cy) < .Rg))
               c = ((Dr(j).x <> .cx) Or (Dr(j).y <> .cy))
               If A And (Not B) And c And (.living = 1) Then
                  .living = 0
                  HayDrain = True
                  Exit For
               End If
            End With
         End If
      Next
      If Not HayDrain Then
         dzmin = 0
         mzmin = dzmin
         difmin = 999 '(>180)
         hay = False
         For j = 1 To NComp
         With EP(i)
            A = ((Abs(LComp(j).x - .cx) < .Rg + R) And (Abs(LComp(j).y - .cy) < .Rg + R))
            B = ((Abs(LComp(j).x - .cx) < .Rg) And (Abs(LComp(j).y - .cy) < .Rg))
            c = ((LComp(j).x <> .cx) Or (LComp(j).y <> .cy))
            If A And (Not B) And c And (.living = 1) Then
               hay = True
               dx = (LComp(j).x - .cx)
               dy = (LComp(j).y - .cy)
               dz = Sqr(dx ^ 2 + dy ^ 2)
               mz = IIf(Abs(dx) > Abs(dy), Abs(dx), Abs(dy))
               If mz > mzmin Then
                  dzmin = dz
                  mzmin = mz
                  jmin = j
               Else
                  If mz = mzmin Then
'--------------------------------------------------Revisa Gravity------------------------------------
                     'gx = (Star(1).x - .cx)
                     'gy = (Star(1).y - .cy)
                     'difdir = 1 - (dx * gx + dy * gy) / (dz * reticula(.cx, .cy).g)
                     'dif1 = dx * -gy + dy * gx
                     'dx = (LComp(jmin).x - .cx)
                     'dy = (LComp(jmin).y - .cy)
                     'difmin = 1 - (dx * gx + dy * gy) / (dzmin * reticula(.cx, .cy).g)
                     'dif2 = dx * -gy + dy * gx
'---------------------------------------------------------------------------------------------------------
                     'dx = (LComp(j).x - .cx)
                     'dy = (LComp(j).y - .cy)
                     difdir = ATan2(dy, dx) - .D
                     dif1 = Angle360(difdir)
                     signo = (difdir < 0)
                     difdir = Abs(difdir)
                     difdir = IIf(difdir <= 180, difdir, 360 - difdir)
                     dx = (LComp(jmin).x - .cx)
                     dy = (LComp(jmin).y - .cy)
                     difmin = ATan2(dy, dx) - .D
                     dif2 = Angle360(difmin)
                     difmin = Abs(difmin)
                     difmin = IIf(difmin <= 180, difmin, 360 - difmin)
                     
                     If (difdir < difmin) Or ((difdir = difmin) And (dif1 > dif2)) Then 'nacen  a favor de la dirección
                        dzmin = dz
                        mzmin = mz
                        jmin = j
                     End If
                  End If
               End If
            End If
         End With
         Next
         If hay Then
            NAux = NAux + 1
            Laux(NAux).x = LComp(jmin).x
            Laux(NAux).y = LComp(jmin).y
            Laux(NAux).living = 1
            'dx = (LComp(jmin).x - EP(i).cx)   'incluye
            'dy = (LComp(jmin).y - EP(i).cy)   'la dirección de la
            'direne = Round(ATan2(dy, dx))            'energia
            direne = EP(i).D
            MakeENeg LComp(jmin).x, LComp(jmin).y, direne
            If jmin < NComp Then
               LComp(jmin).x = LComp(NComp).x
               LComp(jmin).y = LComp(NComp).y
               LComp(jmin).living = LComp(NComp).living
            End If
            NComp = NComp - 1
            EP(i).living = 0
         End If
      End If
   Next
End If
End Sub
Sub ProcesarENeg()
Dim dz As Double, dzmin As Double, mz As Double, mzmin As Double
Dim direc As Integer, difdir As Double, difmin As Double, direne As Integer 'Para cálculo de orientación de la energía
Dim r1 As Double, r2 As Double, pr1 As Double, pr2 As Double, iguales As Double, dif1 As Double, dif2 As Double
Dim jmin As Long
Dim hay As Boolean
Dim dx As Single, dy As Single, gx As Single, gy As Single
If NN > 0 Then
   For i = 1 To NN
      'Procesar Drains
      HayDrain = False
      For j = 1 To NDrains
         If Dr(j).T = 0 Then
            With EN(i)
               A = ((Abs(Dr(j).x - .cx) < .Rg + R) And (Abs(Dr(j).y - .cy) < .Rg + R))
               B = ((Abs(Dr(j).x - .cx) < .Rg) And (Abs(Dr(j).y - .cy) < .Rg))
               c = ((Dr(j).x <> .cx) Or (Dr(j).y <> .cy))
               If A And (Not B) And c And (.living = 1) Then
                  .living = 0
                  HayDrain = True
                  Exit For
               End If
            End With
         End If
      Next
      If Not HayDrain Then
         dzmin = 0
         mzmin = dzmin
         difmin = 999 '(>180)
         hay = False
         For j = 1 To NComp
         With EN(i)
            A = ((Abs(LComp(j).x - .cx) < .Rg + R) And (Abs(LComp(j).y - .cy) < .Rg + R))
            B = ((Abs(LComp(j).x - .cx) < .Rg) And (Abs(LComp(j).y - .cy) < .Rg))
            c = ((LComp(j).x <> .cx) Or (LComp(j).y <> .cy))
            If A And (Not B) And c And (.living = 1) Then
               hay = True
               dx = (LComp(j).x - .cx)
               dy = (LComp(j).y - .cy)
               dz = Sqr(dx ^ 2 + dy ^ 2)
               mz = IIf(Abs(dx) > Abs(dy), Abs(dx), Abs(dy))
               If mz > mzmin Then
                  dzmin = dz
                  jmin = j
                  mzmin = mz
               Else
                  If mz = mzmin Then
'--------------------------------------------------Revisa Gravity------------------------------------
                     'gx = (Star(1).x - .cx)
                     'gy = (Star(1).y - .cy)
                     'difdir = 1 - (dx * gx + dy * gy) / (dz * reticula(.cx, .cy).g)
                     'dif1 = dx * -gy + dy * gx
                     'dx = (LComp(jmin).x - .cx)
                     'dy = (LComp(jmin).y - .cy)
                     'difmin = 1 - (dx * gx + dy * gy) / (dzmin * reticula(.cx, .cy).g)
                     'dif2 = dx * -gy + dy * gx
'----------------------------------------------------------------------------------------------------
                     difdir = ATan2(dy, dx) - .D
                     dif1 = Angle360(difdir)
                     signo = (difdir < 0)
                     difdir = Abs(difdir)
                     difdir = IIf(difdir <= 180, difdir, 360 - difdir)
                     dx = (LComp(jmin).x - .cx)
                     dy = (LComp(jmin).y - .cy)
                     difmin = ATan2(dy, dx) - .D
                     dif2 = Angle360(difmin)
                     difmin = Abs(difmin)
                     difmin = IIf(difmin <= 180, difmin, 360 - difmin)

                     If (difdir > difmin) Or ((difdir = difmin) And (dif1 > dif2)) Then 'nacen  a favor de la dirección
                        dzmin = dz
                        mzmin = mz
                        jmin = j
                     End If
                  End If
               End If
            End If
         End With
         Next
         If hay Then
            NAux = NAux + 1
            Laux(NAux).x = LComp(jmin).x
            Laux(NAux).y = LComp(jmin).y
            Laux(NAux).living = 0
            'dx = (LComp(jmin).x - EN(i).cx)   'incluye
            'dy = (LComp(jmin).y - EN(i).cy)   'la dirección de la
            'direne = Round(ATan2(dy, dx))            'energia
            direne = EN(i).D
            MakeEPos LComp(jmin).x, LComp(jmin).y, direne
            If jmin < NComp Then
               LComp(jmin).x = LComp(NComp).x
               LComp(jmin).y = LComp(NComp).y
               LComp(jmin).living = LComp(NComp).living
            End If
            NComp = NComp - 1
            EN(i).living = 0
         End If
      End If
   Next
End If
For i = 1 To NComp
   NAux = NAux + 1
   Laux(NAux).x = LComp(i).x
   Laux(NAux).y = LComp(i).y
   Laux(NAux).living = LComp(i).living
Next
End Sub


Sub Generar()
Dim time As Long
Dim Semip As Long


For i = 1 To NG
With g(i)
   time = tic - .St
   If ((time >= 0) And (time <= .P)) Then
      For k = 1 To .A
      Select Case .T
      Case 0
         If time Mod .F = 0 Then
            NN = NN + 1
            EN(NN).cx = .x
            EN(NN).cy = .y
            EN(NN).living = 1
            EN(NN).Rg = 0
            EN(NN).D = .D
         End If
      Case 1
         If time Mod .F = 0 Then
            NP = NP + 1
            EP(NP).cx = .x
            EP(NP).cy = .y
            EP(NP).living = 1
            EP(NP).Rg = 0
            EP(NP).D = .D
         End If
   
      Case 2
         Semip = .F \ 2
         Select Case .PH
         Case 0
            If (time Mod Semip) = 0 Then
               If (time Mod .F) = 0 Then
                  NN = NN + 1
                  EN(NN).cx = .x
                  EN(NN).cy = .y
                  EN(NN).living = 1
                  EN(NN).Rg = 0
                  EN(NN).D = .D
               Else
                  NP = NP + 1
                  EP(NP).cx = .x
                  EP(NP).cy = .y
                  EP(NP).living = 1
                  EP(NP).Rg = 0
                  EP(NP).D = .D
               End If
            End If
         Case 1
            If (time Mod Semip) = 0 Then
               If (time Mod .F) = 0 Then
                  NP = NP + 1
                  EP(NP).cx = .x
                  EP(NP).cy = .y
                  EP(NP).living = 1
                  EP(NP).Rg = 0
                  EP(NP).D = .D
               Else
                  NN = NN + 1
                  EN(NN).cx = .x
                  EN(NN).cy = .y
                  EN(NN).living = 1
                  EN(NN).Rg = 0
                  EN(NN).D = .D
               End If
            End If
         End Select
      End Select
      Next
   End If
End With
Next
End Sub
Sub Pintar(ElCont As Control, x As Long, y As Long, dx As Long, dy As Long)

    Dim hdcMask As Long
    Dim hMaskBmp As Long
    Dim hMaskPrevBmp As Long
    Randomize
    xx1 = Int(Rnd() * 20)
    yy1 = Int(Rnd() * 20)
    
    hdcMask = CreateCompatibleDC(ElCont.hdc)
    hMaskBmp = CreateBitmap(dx, dy, 1, 1, ByVal 0&)
    hMaskPrevBmp = SelectObject(hdcMask, hMaskBmp)
    m = SetBkColor(ElCont.hdc, RGB(0, 0, 0))
    m = BitBlt(hdcMask, 0, 0, dx, dy, ElCont.hdc, xx1, yy1, SRCCOPY)
    
    m = SetBkColor(Me.Picture1.hdc, RGB(255, 255, 255))
    m = SetTextColor(Me.Picture1.hdc, RGB(0, 0, 0))
    m = BitBlt(Me.Picture1.hdc, x, y, dx, dy, hdcMask, 0, 0, SRCAND)
    m = BitBlt(Me.Picture1.hdc, x, y, dx, dy, ElCont.hdc, xx1, yy1, SRCPAINT)
    ' m = BitBlt(Me.Picture1.hdc, 0, 0, 100, 100, Me.Picture3.hdc, 0, 0, SRCPAINT)
     Me.Picture1.Refresh

End Sub

Sub PutEPos(x As Long, y As Long)
   NP = NP + 1
   With EP(NP)
      .cx = x - R \ 2 - 2 * R
      .cy = y - R \ 2 - 2 * R
      .living = 1
      .Rg = 2 * R
      .D = 0
   End With

End Sub
Sub PutENeg(x As Long, y As Long)
   NN = NN + 1
   With EN(NN)
      .cx = x - R \ 2 - 2 * R
      .cy = y - R \ 2 - 2 * R
      .living = 1
      .Rg = 2 * R
      .D = 0
   End With
End Sub

Sub MakeNeededEnergy()
Dim S As Byte
NP = 0
NN = 0
escanear
For i = 1 To N + NVACIOS
  If L(i).sel = 1 Then
      S = 0
      For j = -1 To 1
        For k = -1 To 1
            If ((k <> 0) Or (j <> 0)) Then
               S = S + reticula(L(i).x + j, L(i).y + k).v
            End If
        Next
      Next
      If S > 8 Then S = WallValue
      Select Case L(i).living
      Case 0
      If ((Rule(S) = 2) Or (Rule(S) = 3)) Then
         PutEPos L(i).x, L(i).y
      End If
      Case 1
      If ((Rule(S) = 0) Or (Rule(S) = 3)) Then
         PutENeg L(i).x, L(i).y
      End If
    
      End Select
      L(i).sel = 0
  End If
Next

End Sub
Sub MakeEnergyListNew()
NPCreada = NPA
NNCreada = NNA
For i = 1 To NP
   If (EP(i).living = 1) And (EP(i).Rg < RGLimit) Then
      NPA = NPA + 1
      EPA(NPA).cx = EP(i).cx
      EPA(NPA).cy = EP(i).cy
      EPA(NPA).D = EP(i).D
      EPA(NPA).living = EP(i).living
      EPA(NPA).Rg = EP(i).Rg + R 'Mueve energia restante
   End If
Next
For i = 1 To NN
   If (EN(i).living = 1) And (EN(i).Rg < RGLimit) Then
      NNA = NNA + 1
      ENA(NNA).cx = EN(i).cx
      ENA(NNA).cy = EN(i).cy
      ENA(NNA).D = EN(i).D
      ENA(NNA).living = EN(i).living
      ENA(NNA).Rg = EN(i).Rg + R 'Mueve energia restante
   End If
Next

NP = 0
NN = 0
For i = 1 To NPA 'Agrega nuevas energías positivas
   NP = NP + 1
   EP(NP).cx = EPA(i).cx
   EP(NP).cy = EPA(i).cy
   EP(NP).living = EPA(i).living
   EP(NP).Rg = EPA(i).Rg
   EP(NP).D = EPA(i).D
Next
For i = 1 To NNA 'Agrega nuevas energías negativas
   NN = NN + 1
   EN(NN).cx = ENA(i).cx
   EN(NN).cy = ENA(i).cy
   EN(NN).living = ENA(i).living
   EN(NN).Rg = ENA(i).Rg
   EN(NN).D = ENA(i).D
Next

End Sub
Sub MakeEnergyList() 'noooooo
If NP > 0 Then 'Mueve la energía positiva R celdas hacia afuera
   For i = 1 To NP
      EP(i).Rg = EP(i).Rg + R
   Next
End If
If NN > 0 Then 'Mueve la energía negativa R celdas hacia afuera
   For i = 1 To NN
      EN(i).Rg = EN(i).Rg + R
   Next
End If

For i = 1 To NPA 'Agrega nuevas energías positivas
   EP(NP + i).cx = EPA(i).cx
   EP(NP + i).cy = EPA(i).cy
   EP(NP + i).living = EPA(i).living
   EP(NP + i).Rg = EPA(i).Rg
Next
For i = 1 To NNA 'Agrega nuevas energías negativas
   EN(NN + i).cx = ENA(i).cx
   EN(NN + i).cy = ENA(i).cy
   EN(NN + i).living = ENA(i).living
   EN(NN + i).Rg = ENA(i).Rg
Next
NP = NP + NPA
NN = NN + NNA
End Sub
Sub MakeEPos(x As Long, y As Long, direc As Integer) 'aqui es donde surge la energía por 1ra vez
   NPA = NPA + 1
   With EPA(NPA)
      .cx = x
      .cy = y
      .living = 1
      .Rg = RInicio
      .D = direc
   End With
End Sub
Sub MakeENeg(x As Long, y As Long, direc As Integer) 'aqui es donde surge la energía por 1ra vez
   NNA = NNA + 1
   With ENA(NNA)
      .cx = x
      .cy = y
      .living = 1
      .Rg = RInicio
      .D = direc
   End With
End Sub

Function HayEPos(x As Long, y As Long) As Boolean 'Noooooo
'Chequea si existe Energía Positiva en la celda x,y
'para efectuar nacimiento
'Absorbe la energía
Dim A As Boolean, B As Boolean, c As Boolean, hay As Boolean
Dim IE As Long
If (NP = 0) Then
   HayEPos = False
   Exit Function
End If
hay = False
For i = 1 To NP
   With EP(i)
      A = ((Abs(x - .cx) < .Rg + R) And (Abs(y - .cy) < .Rg + R))
      B = ((Abs(x - .cx) < .Rg) And (Abs(y - .cy) < .Rg))
      c = ((x <> .cx) Or (y <> .cy))
      If A And (Not B) And c And (.living = 1) Then
         hay = True
         .living = 0
         IE = i
         Exit For
      End If
   End With
Next
If hay Then
   If (IE < NP) Then
      EP(IE).cx = EP(NP).cx
      EP(IE).cy = EP(NP).cy
      EP(IE).Rg = EP(NP).Rg
      EP(IE).living = EP(NP).living
      NP = NP - 1
   Else
      NP = NP - 1
   End If
   HayEPos = True
Else
   HayEPos = False
End If
End Function
Function HayENeg(x As Long, y As Long) As Boolean 'Nooooo
'Chequea si existe Energía Negativa en la celda x,y
'para efectuar muerte
'Absorbe la energía
Dim A As Boolean, B As Boolean, c As Boolean, hay As Boolean
Dim IE As Long
If (NN = 0) Then
   HayENeg = False
   Exit Function
End If
hay = False
For i = 1 To NN
   With EN(i)
      A = ((Abs(x - .cx) < .Rg + R) And (Abs(y - .cy) < .Rg + R))
      B = ((Abs(x - .cx) < .Rg) And (Abs(y - .cy) < .Rg))
      c = ((x <> .cx) Or (y <> .cy))
      If A And (Not B) And c And (.living = 1) Then
         hay = True
         .living = 0
         IE = i
         Exit For
      End If
   End With
Next
If hay Then
   If (IE < NN) Then
      EN(IE).cx = EN(NN).cx
      EN(IE).cy = EN(NN).cy
      EN(IE).Rg = EN(NN).Rg
      EN(IE).living = EN(NN).living
      NN = NN - 1
   Else
      NN = NN - 1
   End If
   HayENeg = True
Else
   HayENeg = False
End If
End Function

Sub HacerTic()
   tic = tic + 1
   CheckSensors
   'WallValue = Round(Rnd()) * 2
   WallValue = 0
   escanear
   procesarEne
   Generar
   Picture1.Cls
   dibWall
   If Me.VerEnergia Then ShowEne
   dibujar
   NSuma = NSuma + N
   NPromedio = NSuma \ tic
End Sub
Sub escanear()
Dim kk As Integer, mm As Integer
'Determina cuales son las celdas vacías
'que deben ser verificadas para posibles
'cambios de estado
Dim LaMarca As Byte, ElValor As Byte
mm = 1 + tic Mod 20
NVACIOS = 0
For i = 1 To N
    For kk = 1 To 8
        j = D(mm, kk).dx
        k = D(mm, kk).dy
        ElValor = reticula(L(i).x + j, L(i).y + k).v
        LaMarca = reticula(L(i).x + j, L(i).y + k).m
        If (ElValor = 0) And (LaMarca = 0) Then
            reticula(L(i).x + j, L(i).y + k).m = 1
            NVACIOS = NVACIOS + 1
            L(N + NVACIOS).x = L(i).x + j
            L(N + NVACIOS).y = L(i).y + k
            L(N + NVACIOS).living = 0
            L(N + NVACIOS).sel = L(i).sel
        Else
            If (LaMarca = 2) Then
               hits = hits + 1
            End If
        End If
    Next
Next
For i = N + 1 To N + NVACIOS
   reticula(L(i).x, L(i).y).m = 0
Next
End Sub
Sub procesar() 'noooooo
Dim NNuevos As Long
Dim S As Byte
NNuevos = 0
NPA = 0
NNA = 0
For i = 1 To N + NVACIOS
    S = 0
    Laux(i).x = L(i).x
    Laux(i).y = L(i).y
    For j = -1 To 1
        For k = -1 To 1
            If ((k <> 0) Or (j <> 0)) Then
               S = S + reticula(L(i).x + j, L(i).y + k).v
            End If
        Next
    Next
    Select Case L(i).living
    Case 0
    If (Rule(S) = 2) Then
       If HayEPos(L(i).x, L(i).y) Then
          Laux(i).living = 1
          MakeENeg L(i).x, L(i).y, 0
       Else
          Laux(i).living = 0
       End If
    Else
       Laux(i).living = 0
    End If
    Case 1
    If (Rule(S) = 0) Then
       If HayENeg(L(i).x, L(i).y) Then
          Laux(i).living = 0
          MakeEPos L(i).x, L(i).y, 0
       Else
          Laux(i).living = 1
       End If
    Else
       Laux(i).living = 1
    End If
    End Select
Next
For i = 1 To N + NVACIOS
   reticula(Laux(i).x, Laux(i).y).v = Laux(i).living
   If Laux(i).living = 1 Then
      NNuevos = NNuevos + 1
      L(NNuevos).living = 1
      L(NNuevos).x = Laux(i).x
      L(NNuevos).y = Laux(i).y
   End If
Next
N = NNuevos
MakeEnergyList
End Sub
Sub dibujar()
'Me.Picture1.Cls
Me.Picture1.ForeColor = RGB(0, 0, 0)
'Me.Picture1.BackColor = &H8000000F
Me.Picture1.DrawWidth = Escala
For i = 1 To N
   'Me.Picture1.Line ((L(i).y + WY) * Escala, (L(i).x + WX) * Escala)-Step(0, 0)
   z = Rectangle(Picture1.hdc, (L(i).y + WY) * Escala, (L(i).x + WX) * Escala, (L(i).y + WY) * Escala + 1, (L(i).x + WX) * Escala + 1)
Next
End Sub
Sub dibEne2(cx As Long, cy As Long, Rg As Long, color As Byte)
Dim x1 As Long, y1 As Long, x2 As Long, y2 As Long
x1 = (cx - Rg - R + WX) * Escala
x2 = (cx + Rg + R + WX) * Escala
y1 = (cy - Rg - R + WY) * Escala
y2 = (cy - Rg + WY) * Escala
If color = 0 Then
   Pintar Picture4, x1, y1, x2 - x1, y2 - y1
Else
   Pintar Picture2, x1, y1, x2 - x1, y2 - y1
End If
y1 = (cy + Rg + WY) * Escala
y2 = (cy + Rg + R + WY) * Escala
If color = 0 Then
   Pintar Picture4, x1, y1, x2 - x1, y2 - y1
Else
   Pintar Picture2, x1, y1, x2 - x1, y2 - y1
End If
x1 = (cx - Rg - R + WX) * Escala
x2 = (cx - Rg + WX) * Escala
y1 = (cy - Rg + WY) * Escala
y2 = (cy + Rg + WY) * Escala
If color = 0 Then
   Pintar Picture5, x1, y1, x2 - x1, y2 - y1
Else
   Pintar Picture3, x1, y1, x2 - x1, y2 - y1
End If

x1 = (cx + Rg + WX) * Escala
x2 = (cx + Rg + R + WX) * Escala
If color = 0 Then
   Pintar Picture5, x1, y1, x2 - x1, y2 - y1
Else
   Pintar Picture3, x1, y1, x2 - x1, y2 - y1
End If

End Sub
Sub dibEne(cx As Long, cy As Long, Rg As Long, color As Byte)
Picture1.DrawWidth = 1
If color = 0 Then
   Picture1.FillColor = RGB(255, 0, 0)
   Picture1.ForeColor = RGB(255, 0, 0)
Else
   Picture1.FillColor = RGB(0, 255, 0)
   Picture1.ForeColor = RGB(0, 255, 0)
End If
x1 = (cx - Rg - R + WX) * Escala
x2 = (cx + Rg + R + WX) * Escala
y1 = (cy - Rg - R + WY) * Escala
y2 = (cy - Rg + WY) * Escala
Randomize
cantidad = Abs(y1 - y2)
For i = 1 To cantidad
    mix = x1 + Int(Rnd() * (x2 - x1))
    miy = y1 + Int(Rnd() * (y2 - y1))
    z = Rectangle(Picture1.hdc, miy, mix, miy + 2, mix + 2)
Next
y1 = (cy + Rg + WY) * Escala
y2 = (cy + Rg + R + WY) * Escala
Randomize
cantidad = Abs(y1 - y2)
For i = 1 To cantidad
    mix = x1 + Int(Rnd() * (x2 - x1))
    miy = y1 + Int(Rnd() * (y2 - y1))
    z = Rectangle(Picture1.hdc, miy, mix, miy + 2, mix + 2)
Next
If Rg <> 0 Then
   x1 = (cx - Rg - R + WX) * Escala
   x2 = (cx - Rg + WX) * Escala
   y1 = (cy - Rg + WY) * Escala
   y2 = (cy + Rg + WY) * Escala
   Randomize
   cantidad = Abs(x1 - x2)
   For i = 1 To cantidad
      mix = x1 + Int(Rnd() * (x2 - x1))
      miy = y1 + Int(Rnd() * (y2 - y1))
      z = Rectangle(Picture1.hdc, miy, mix, miy + 2, mix + 2)
   Next
   x1 = (cx + Rg + WX) * Escala
   x2 = (cx + Rg + R + WX) * Escala
   Randomize
   cantidad = Abs(x1 - x2)
   For i = 1 To cantidad
       mix = x1 + Int(Rnd() * (x2 - x1))
       miy = y1 + Int(Rnd() * (y2 - y1))
       z = Rectangle(Picture1.hdc, miy, mix, miy + 2, mix + 2)
   Next
End If
End Sub
Sub ShowEne()
CN = IIf(NN > NP, NN, NP)
For i = 1 To CN
  If i <= NN And EN(i).Rg < 100 * R Then
     dibEne EN(i).cx, EN(i).cy, EN(i).Rg, 0
  End If
  If i <= NP And EP(i).Rg < 100 * R Then
    dibEne EP(i).cx, EP(i).cy, EP(i).Rg, 1
  End If
Next
End Sub

Private Sub Acercar_Click()
  Escala = Escala + 1
  Me.Text1 = Escala
  Picture1.Cls
  dibWall
  If Me.VerEnergia Then ShowEne
  dibujar
End Sub

Private Sub Alejar_Click()
  Escala = Escala - 1
  Me.Text1 = Escala
  Picture1.Cls
  dibWall
  If Me.VerEnergia Then ShowEne
  dibujar

End Sub

Private Sub BOpen_Click()
Dim colini, filini, fila, col As Long
Dim letra, caracter As String
Dim extension As String
Dim MinFil As Long, MinCol As Long
Dim Nfilas As Long, PonEne As Byte
Dim TipoE As Byte, Frec As Long, Amplitud As Long, NPulsos As Long
Dim nf As Long, nc As Long
Dim densidad As Double
MinFil = 1000
MinCol = 1000
NG = 0
NStars = 0
'CommonDialog1.Filter = "Matter Files (*.mxx)|*.mxx|Matter-Energy Files (*.mex)|*.mex"
CommonDialog1.Filter = "Matter-Energy Files (*.mex)|*.mex"
CommonDialog1.CancelError = True
Me.CommonDialog1.ShowOpen
extension = Right(Me.CommonDialog1.FileName, 3)
filini = 1
colini = 1
For i = 1 To 1000
   For j = 1 To 1000
      If (i = 1) Or (j = 1) Or (i = 1000) Or (j = 1000) Then
         reticula(i, j).v = 1
         reticula(i, j).m = 1
      Else
         reticula(i, j).v = 0
         reticula(i, j).m = 0
      End If
      reticula(i, j).g = RNormal(1)
   Next
Next
If extension = "mxx" Then
   Open Me.CommonDialog1.FileName For Input As #1
   N = 0
   Do While Not EOF(1)
      Line Input #1, letra
      If letra = "B" Then
         fila = 0
         Input #1, filini, colini
         If filini < MinFil Then
            MinFil = filini
         End If
         If colini < MinCol Then
            MinCol = colini
         End If
      
      Else
         For i = 0 To Len(letra) - 1
            caracter = Mid$(letra, i + 1, 1)
            valor = Val(caracter)
            reticula(filini + fila, colini + i).v = valor
            If valor = 1 Then
               N = N + 1
               L(N).x = filini + fila
               L(N).y = colini + i
               L(N).living = 1
               L(N).sel = 1
            End If
         Next
         fila = fila + 1
      End If
   Loop
   Close #1
Else
   Open Me.CommonDialog1.FileName For Input As #1
   N = 0
   NP = 0
   NN = 0
   NW = 0
   NSensors = 0
   NDrains = 0
   RInicio = 0
   Input #1, R, RInicio
   Input #1, Rule(0), Rule(1), Rule(2), Rule(3), Rule(4), Rule(5), Rule(6), Rule(7), Rule(8)
   Do While Not EOF(1)
      Line Input #1, letra
      If letra = "B" Then
         fila = 0
         Input #1, filini, colini, Nfilas, PonEne
         If filini < MinFil Then
            MinFil = filini
         End If
         If colini < MinCol Then
            MinCol = colini
         End If
         For k = 1 To Nfilas
            Line Input #1, letra
            For i = 0 To Len(letra) - 1
               caracter = Mid$(letra, i + 1, 1)
               valor = Val(caracter)
               reticula(filini + fila, colini + i).v = valor
               If valor = 1 Then
                  N = N + 1
                  L(N).x = filini + fila
                  L(N).y = colini + i
                  L(N).living = 1
                  L(N).sel = PonEne
               End If
            Next
            fila = fila + 1
         Next
      Else
         If letra = "G" Then
            NG = NG + 1
            Input #1, g(NG).x, g(NG).y, g(NG).T, g(NG).A, g(NG).F, g(NG).PH, g(NG).St, g(NG).P, g(NG).D
         Else
            If letra = "S" Then
               NSensors = NSensors + 1
               Input #1, Gauge(NSensors).x, Gauge(NSensors).y, Gauge(NSensors).zx1, Gauge(NSensors).zy1, Gauge(NSensors).zx2, Gauge(NSensors).zy2
            Else
               If letra = "R" Then
                  Input #1, filini, colini, nf, nc, densidad, PonEne
                  If filini < MinFil Then
                     MinFil = filini
                  End If
                     If colini < MinCol Then
                     MinCol = colini
                  End If
                  Randomize
                  For i = filini To filini + nf
                     For j = colini To colini + nc
                         valor = IIf((Rnd() <= densidad), 1, 0)
                         reticula(i, j).v = valor
                         If valor = 1 Then
                            N = N + 1
                            L(N).x = i
                            L(N).y = j
                            L(N).living = 1
                            L(N).sel = PonEne
                         End If
                     Next
                  Next
               Else
                  If letra = "W" Then
                     NW = NW + 1
                     Input #1, Wall(NW).x1, Wall(NW).y1, Wall(NW).x2, Wall(NW).y2
                     With Wall(NW)
                     For i = .x1 To .x2
                        For j = .y1 To .y2
                            reticula(i, j).m = 2
                            reticula(i, j).v = 0
                        Next
                     Next
                     End With
                  Else
                     If letra = "M" Then
                        NStars = NStars + 1
                        Input #1, Star(NStars).x, Star(NStars).y, Star(NStars).tipo, Star(NStars).strength
                     Else
                        If letra = "D" Then
                           NDrains = NDrains + 1
                           Input #1, Dr(NDrains).x, Dr(NDrains).y, Dr(NDrains).T
                        End If
                     End If
                  End If
               End If
            End If
         End If
      End If
   Loop
   Close #1
   
End If
tic = 0 'Comienzo del tiempo
Escala = 5
Me.Text1 = Escala
WX = 50 - MinFil
WY = 50 - MinCol
NPA = 0 'no hay energía creada
NNA = 0
'R = 8
RGMax = 1000 \ R
RGLimit = Me.Text2 * R
Horizonte = 1000
MakeGravityField
WallValue = 0
PrepararExp
ArmarReguero
MakeNeededEnergy
Generar
Me.Picture1.Cls
dibWall
If Me.VerEnergia Then ShowEne
dibujar
Me.Poblacion = N
Me.ETN = NN
Me.ETP = NP
Me.ECN = NNA
Me.ECP = NPA
tic = 0 'Comienzo del tiempo
hits = 0
ElTic.Text = tic
NSuma = 0
Promedio = N
'Inicializa sensores
For i = 1 To NSensors
  Gauge(i).NData = 0
  Gauge(i).Last = 1
  ReDim Gauge(i).Dato(1000)
Next
End Sub

Private Sub BStart_Click()
   RGLimit = Me.Text2 * R
   Timer1.Interval = Me.Combo1
   Randomize
   Me.Timer1.Enabled = True
   Me.Timer2.Enabled = True
End Sub

Private Sub BStop_Click()
   'DoEvents
   Me.Timer1.Enabled = False
   Me.Timer2.Enabled = False
   'DoEvents
End Sub



Private Sub Command1_Click()
Pintar Picture4, 10, 10, 500, 100
'Randomize
'Picture1.DrawMode = 13
'Picture1.ForeColor = RGB(100, 0, 0)
'Picture1.FillColor = RGB(100, 0, 0)
'For i = 1 To 100
'    x = 100 + Int(Rnd() * 200)
'    y = 100 + Int(Rnd() * 200)
'    d = Rectangle(Picture1.hdc, x, y, x + 3, y + 3)
'Next
'Me.Picture1.DrawWidth = 100
'Me.Picture1.Line (100, 100)-Step(0, 0)
'Picture1.FillColor = RGB(100, 0, 0)
'Picture1.FillStyle = 6
'd = Rectangle(Picture1.hdc, 100, 100, 200, 200)
'Picture1.DrawMode = 15
'Picture1.FillColor = RGB(0, 0, 100)
'd = Rectangle(Picture1.hdc, 113, 122, 200, 200)
End Sub

Private Sub Command3_Click()
WX = WX - 1
Picture1.Cls
dibWall
If Me.VerEnergia Then ShowEne
dibujar
End Sub

Private Sub Command4_Click()
WX = WX + 1
Picture1.Cls
dibWall
If Me.VerEnergia Then ShowEne
dibujar
End Sub

Private Sub Derecha_Click()
WY = WY + 1
Picture1.Cls
dibWall
If Me.VerEnergia Then ShowEne
dibujar

End Sub

Private Sub Form_Load()
Combo1.ListIndex = 4
Me.Text1 = 10
Escala = 10
WX = 0
WY = 0
'Picture2.Height = 200
'Picture2.Width = 2200
'Picture3.Height = 2200
'Picture3.Width = 200
'Picture4.Height = 200
'Picture4.Width = 2200
'Picture5.Height = 2200
'Picture5.Width = 200
'Picture2.ScaleHeight = 200
'Picture2.ScaleWidth = 2200
'Picture3.ScaleHeight = 2200
'Picture3.ScaleWidth = 200
'Picture4.ScaleHeight = 200
'Picture4.ScaleWidth = 2200
'Picture5.ScaleHeight = 2200
'Picture5.ScaleWidth = 200

'Randomize
'Picture2.FillColor = RGB(0, 255, 0)
'For i = 1 To 1000
'   x = Rnd() * 200
'   y = Rnd() * 2200
'   z = Rectangle(Picture2.hdc, y, x, y + 3, x + 3)
'Next
'Picture3.FillColor = RGB(0, 255, 0)
'For i = 1 To 1000
'   x = Rnd() * 2200
'   y = Rnd() * 200
'   z = Rectangle(Picture3.hdc, y, x, y + 3, x + 3)
'Next
'Picture4.FillColor = RGB(255, 0, 0)
'For i = 1 To 1000
'   x = Rnd() * 200
'   y = Rnd() * 2200
'   z = Rectangle(Picture4.hdc, y, x, y + 3, x + 3)
'Next
'Picture5.FillColor = RGB(255, 0, 0)
'For i = 1 To 1000
'   x = Rnd() * 2200
'   y = Rnd() * 200
'   z = Rectangle(Picture5.hdc, y, x, y + 3, x + 3)
'Next

End Sub

Private Sub Izquierda_Click()
WY = WY - 1
Picture1.Cls
dibWall
If Me.VerEnergia Then ShowEne
dibujar
End Sub

Private Sub Text3_Change()

End Sub

Private Sub SEnergy_Click()
Dim Visto As Long, MiTic As Long, Epos As Long, Eneg As Long
Dim Linea As String
CommonDialog2.Filter = "Energy Files (*.exx)|*.exx"

CommonDialog2.CancelError = True
Me.CommonDialog2.ShowSave
Open Me.CommonDialog2.FileName For Output As #2
For i = 1 To NSensors
  Gauge(i).Last = 1
Next

For MiTic = 1 To tic
   Linea = Str(MiTic) + " "
   For j = 1 To NSensors
      Visto = GetSensorInfo(j, MiTic, Epos, Eneg)
      Linea = Linea + Str(Epos) + " " + Str(Eneg)
   Next
   Print #2, Linea
Next
Close #2
End Sub

Private Sub Timer1_Timer()
   HacerTic
End Sub

Private Sub Timer2_Timer()
Timer1.Interval = Me.Combo1
Me.Poblacion = N
Me.ETN = NN
Me.ETP = NP
Me.ECN = NNCreada
Me.ECP = NPCreada
ElTic.Text = tic
Me.Promedio = NPromedio
End Sub
