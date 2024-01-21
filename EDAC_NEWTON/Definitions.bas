Attribute VB_Name = "Definitions"
Global Const PI = 3.14159265358979
Global Const PIGRAD = 57.2957795
Public Type celda
    v As Byte 'estado de la celda 1-vivo, 0-muerto
    m As Byte 'marca
    g As Double 'gravedad
End Type
Public Type Coordenada 'arreglo de coordenadas
    x As Long
    y As Long
    living As Byte
    sel As Byte
End Type
Public Type Energy
    cx As Long 'celda origen de la energía
    cy As Long 'celda origen de la energía
    Rg As Long 'Radio de interacción x generación
    living As Byte 'Estado de la energía 1-Activa, 0-Absorbida
    D As Integer 'Dirección preferente de la energía
End Type
Public Type Generator
    x As Long
    y As Long
    T As Byte '0-Nega, 1-Pos, 2- Alterno
    A As Long 'Amplitud
    F As Long 'Periodo
    PH As Byte 'Fase 1+,2- (Para T=2)
    St As Long 'Comienzo
    P As Long 'Number of tics (Duración)
    D As Integer 'Dirección inicial
End Type
Public Type Registro
    tic As Long
    EP As Long
    EN As Long
End Type
Public Type Sensor
    x As Long
    y As Long
    zx1 As Long
    zy1 As Long
    zx2 As Long
    zy2 As Long
    Dato() As Registro
    NData As Long
    Last As Long
End Type
Public Type Pared
    x1 As Long
    y1 As Long
    x2 As Long
    y2 As Long
End Type
Public Type Explore
    dx As Integer
    dy As Integer
End Type
Public Type Gravity
    tipo As Byte '1-Puntual,2-Horizontal,3-Vertical
    x As Long
    y As Long
    strength As Double
End Type
Public Type Drain
    T As Byte '0-Nega, 1-Pos
    x As Long
    y As Long
End Type
Public reticula(1 To 1000, 1 To 1000) As celda
Public L(1 To 100000) As Coordenada
Public Laux(1 To 100000) As Coordenada
Public LComp(1 To 100000) As Coordenada
Public EP(1 To 100000) As Energy 'Energía positiva
Public EN(1 To 100000) As Energy 'Energía Negativa
Public EPA(1 To 100000) As Energy
Public ENA(1 To 100000) As Energy
Public N As Long, NVACIOS As Long, NAux As Long, NComp As Long 'Numero de Celdas
Public WX As Long, WY As Long 'Desplazamiento del visor
Public Escala As Integer 'Escala del visor
Public NP As Long, NN As Long, NPA As Long, NNA As Long 'Cantidad de cuantos de energía
Public NPCreada As Long, NNCreada As Long
Public R As Long 'Radio  de interacción
Public RInicio As Long 'Salto inicial de la energía
Public g(1 To 1000) As Generator
Public NG As Long
Public Gauge(1 To 40) As Sensor
Public tic As Long 'Tic
Public Declare Function Rectangle Lib "gdi32" (ByVal hdc As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long) As Long
Public Rule(0 To 8) As Integer
Public hits As Long
Public Wall(1 To 100) As Pared
Public NW As Long
Public D(1 To 20, 1 To 8) As Explore
Public NSuma As Long
Public WallValue As Long
Public RGMax As Long
Public Horizonte As Long
Public Star(1 To 100) As Gravity
Public NStars As Long
Public NSensors As Long
Public RGLimit As Long
Public Dr(1 To 40) As Drain
Public NDrains As Long

