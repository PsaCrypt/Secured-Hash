
******************************************************************************

*
* [S-Hash.Prg] - (c) Alejandro Padrino, 2.017
*                Programa desarrollado exclusivamente para el Hackathon-2017.
*

******************************************************************************


Function StartHb()
* (c) Alejandro Padrino, 2.004 - 2.017
*

 Public _MaxInteger := ((2 ^ 53) - 1)
 Public _MaxInt16 := ((2 ^ 31) - 1) //> (2147483647)
 Public _LastId := (-1)
 Public Pi := (3.141592653589793238462) //> { Pi; <21> Decimal Places }
 Public BackSlash := "/"
 SHBeg()

 Return (Nil)


******************************************************************************

Function cExpr(_cIn)
* (c) Alejandro Padrino, 1.997 - 2.017
*

 Private _cOut := (_cIn)
 Return (&_cOut)

Function Linux()
* (c) Alejandro Padrino, 2.017
*

 BackSlash := "/"
 Return (Nil)

Function Windows()
* (c) Alejandro Padrino, 2.017
*

 BackSlash := "\"
 Return (Nil)

Procedure ErrorSys()
* (c) Alejandro Padrino, 2.006
*

 ErrorBlock( { | oError | DefError(oError) } )
 Return

Function DefError(oError)
* (c) Alejandro Padrino, 2.006 - 2.017
*

 Close All
 Set Color To R+/N
 ? "                                                                            "
 ? "Error:  Los  parametros introducidos  no son  correctos  o  faltan datos por"
 ? "        introducir.  Revise la linea de comandos.                           "
 ? "                                                                            "
 ErrorLevel(1000)
 Quit
 Return (.T.)

Function XAt(_cStr, _cSch)
* (c) Alejandro Padrino, 2.004 - 2.006
*

 Return (At(Lower(_cSch), Lower(_cStr)))

Function ReverseStr(_cIn)
* (c) Alejandro Padrino, 2.004
*

 Local _rStr := ""
 Local _nB00 := 0

For _nB00 = Len(_cIn) To 1 Step (-1)
 _rStr := (_rStr + SubStr(_cIn, _nB00, 1))
Next _nB00

 Return (_rStr)

Function EFN(_cIn, _lPath, _lExt)
* (c) Alejandro Padrino, 2.010 - 2.017
*

 Private cOutFile := _cIn
 cOutFile := IIf((_lPath <> .F.), SubStr(cOutFile, (RAt(BackSlash, cOutFile) + 1), Len(cOutFile)), cOutFile)
 cOutFile := IIf((_lExt <> .F.), SubStr(cOutFile, 1, (RAt(".", cOutFile) - 1)), cOutFile)
 Return (cOutFile)

Function EFP(_cIn)
* (c) Alejandro Padrino, 2.010
*

 Private cOutFile := _cIn
 cOutFile := IIf((RAt(BackSlash, cOutFile) > 0), Left(cOutFile, (RAt(BackSlash, cOutFile) - 1)), cOutFile)
 Return (cOutFile)

Function FRL(_hFile)
* (c) Alejandro Padrino, 2.004
*

 Private _FRL
 Private _Buffer
 Private _Exit0
 Private _Exit1
 Private _ReadHandler

 _FRL := ""
 _Buffer := " "
 _Exit0 := .F.
 _Exit1 := .F.
 _ReadHandler := 1

Do While (((_Exit0 <> .T.) .Or. (_Exit1 <> .T.)) .And. (_ReadHandler > 0))
 _ReadHandler := FRead(_hFile, @_Buffer, 1)

If (Asc(_Buffer) <> 13) .And. (Asc(_Buffer) <> 10) .And. (_ReadHandler > 0)
 _FRL := (_FRL + _Buffer)
ElseIf (Asc(_Buffer) = 13)
 _Exit0 := .T.
ElseIf (Asc(_Buffer) = 10)
 _Exit1 := .T.
ElseIf (_ReadHandler > 0)
 _Exit0 := .F.
 _Exit1 := .F.
ElseIf (_ReadHandler < 1)
 Return (Replicate(Chr(27), 1024))
EndIf
EndDo

 Return (_FRL)

Function FWL(_hFile, _cStr)
* (c) Alejandro Padrino, 2.004
*

 Private _WriteLen
 Private _BytesWrited

 _WriteLen := 0
 _BytesWrited := 0

 _cStr := IIf((Right(_cStr, 2) <> (Chr(13) + Chr(10))), (_cStr + Chr(13) + Chr(10)), _cStr)
 _WriteLen := Len(_cStr)
 _BytesWrited := FWrite(_hFile, _cStr, _WriteLen)
 Return (IIf((_BytesWrited <> _WriteLen), .F., .T.))

Function AS(_cStr, _nLen, _nPos, _nAscii)
* (c) Alejandro Padrino, 2.004 - 2.017
*

 Private _nNum00
 Private _cStr00

 _cStr := AllTrim(_cStr)
 _nNum00 := (Abs(_nLen) - Len(_cStr))
 _cStr00 := If((_nNum00 > 0), Replicate(Chr(_nAscii), _nNum00), "")
 Return (Left(If((_nPos < 0), (_cStr00 + _cStr), (_cStr + _cStr00)), _nLen))

Function Tokens(_cIn, _nASCII)
* (c) Alejandro Padrino, 2.014
*

 Local _aTokens := {}
 Local _cStr00 := ""
 Local _cStr01 := ""
 Local _nB00 := 0
 Local _lSw00 := .F.

 _cIn := If(Empty(_cIn) <> .F., Chr(_nASCII), _cIn)

For _nB00 = 1 To Len(_cIn) Step 1
 _cStr01 := SubStr(_cIn, _nB00, 1)
 _lSw00 := If((_cStr01 <> Chr(_nASCII)), .T., _lSw00)

If (_lSw00 <> .F.)
If (_cStr01 = Chr(_nASCII))
 AAdd(_aTokens, _cStr00)
 _cStr00 := ""
Else
 _cStr00 := (_cStr00 + _cStr01)
EndIf
EndIf
Next _nB00

 AAdd(_aTokens, _cStr00)
 AAdd(_aTokens, "")
 Return (_aTokens)

Function BS(_cIn)
* (c) Alejandro Padrino, 2.017
*

 Local _BS := ""
 Local _cTemp00 := _cIn
 Local _cTemp01 := ""
 Local _cTemp02 := ""
 Local _cTemp03 := ""
 Local _cTemp04 := ""
 Local _nTemp00 := 0
 Local _nTemp01 := 0

Do While (Len(_cTemp00) > 0)
 _cTemp01 := Left(_cTemp00, 6)
 _nTemp00 := (CToN(_cTemp01, 36) - 10^9)
 _cTemp03 := AllTrim(Str(_nTemp00, 9, 0))
 _nTemp01 := IIf((Len(_cTemp03) > 6), 9, IIf((Len(_cTemp03) > 3), 6, 3))
 _cTemp04 := AS(_cTemp03, _nTemp01, (-1), 48)
 _cTemp02 := (_cTemp02 + _cTemp04)
 _cTemp00 := Right(_cTemp00, (Len(_cTemp00) - 6))
EndDo

Do While (Len(_cTemp02) > 0)
 _cTemp01 := Left(_cTemp02, 3)
 _nTemp00 := xVal(_cTemp01)
 _BS := (_BS + Chr(_nTemp00))
 _cTemp02 := Right(_cTemp02, (Len(_cTemp02) - 3))
EndDo

 Return (_BS)

Function SB(_cIn)
* (c) Alejandro Padrino, 2.017
*

 Local _SB := ""
 Local _cTemp00 := ""
 Local _cTemp01 := ""
 Local _nTemp00 := 0
 Local _nB00 := 0

For _nB00 = 1 To Len(_cIn) Step 1
 _cTemp00 := (_cTemp00 + AS(Str(Asc(SubStr(_cIn, _nB00, 1)) + 256), 3, (-1), 48))
Next _nB00

Do While (Len(_cTemp00) > 0)
 _cTemp01 := Left(_cTemp00, 9)
 _nTemp00 := (Val(_cTemp01) + 10^9)
 _SB := (_SB + NToC(_nTemp00, 36))
 _cTemp00 := Right(_cTemp00, (Len(_cTemp00) - 9))
EndDo

 Return (Lower(_SB))

Function Entropy(_xcIn)
* (c) Alejandro Padrino, 2.011
*
* Agradecimientos:
* - Eduardo Ruíz Duarte (toorandom@gmail.com):  Esta función se ha dessarrollado
*   desde el archivo original [http://math.co.ro/C/entropy.c] creado por él.
*

 Local _Entropy := (-1)
 Local _cEntropy := _xcIn
 Local _nLen := Len(_cEntropy)
 Local _Ascii[256]
 Local _XData[256]
 Local _nNum00 := 0
 Local _nB00 := 0

If (_nLen > 0)
 AFill(_Ascii, 0)
 AFill(_XData, 0)

Do While (_nB00 <= _nLen)
 _nB00 := (_nB00 + 1)

If (_nB00 <= _nLen)
 _nNum00 := Asc(SubStr(_cEntropy, _nB00, 1))
 _Ascii[_nNum00 + 1] := (_Ascii[_nNum00 + 1] + 1)
EndIf
EndDo

 _Entropy := 0
 _nB00 := 0

Do While (_nB00 <= 256)
 _nB00 := (_nB00 + 1)

If (_nB00 <= 256)
 _XData[_nB00] := (_Ascii[_nB00] / _nLen)
 _Entropy := IIf((_XData[_nB00] > 0), (_Entropy - ((_XData[_nB00] * Log(_XData[_nB00])) / Log(2))), _Entropy)
EndIf
EndDo
EndIf

 Return (_Entropy)

Function IsN(_cIn)
* (c) Alejandro Padrino, 2.017
*

 Local _nTemp00 := (-1)
 Local _nTemp01 := 0
 Local _nTemp02 := 0
 Local _nTemp03 := 0
 Local _nB00 := (-1)

 _cIn := AllTrim(_cIn)

For _nB00 = 1 To Len(_cIn) Step 1
 _nTemp00 := Asc(SubStr(_cIn, _nB00, 1))
 _nTemp03 := IIf((_nTemp00 < 43) .Or. (_nTemp00 > 57) .Or. (_nTemp00 = 44) .Or. (_nTemp00 = 47), (_nTemp03 + 1), _nTemp03)
 _nTemp02 := IIf((_nTemp00 = 46), (_nTemp02 + 1), _nTemp02)
 _nTemp01 := IIf(((_nTemp00 = 43) .Or. (_nTemp00 = 45)) .And. (_nB00 <= 1), (_nTemp01 + 1), IIf(((_nTemp00 = 43) .Or. (_nTemp00 = 45)) .And. (_nB00 > 1), (_nTemp01 + 2), _nTemp01))
Next _nB00

 Return (IIf((_nTemp01 > 1) .Or. (_nTemp02 > 1) .Or. (_nTemp03 > 0) .Or. (Len(_cIn) < 1), .F., .T.))

Function xVal(_cIn)
* (c) Alejandro Padrino, 2.017
*

 Return (IIf((IsN(_cIn) <> .F.), Val(_cIn), 0))

Function BXCnv(_nInput, _nBase, _lSwStr)
* (c) Alejandro Padrino, 2.005 - 2.017
*

 Local _BXCnv := "*** Error ***"
 Local _cBuffer := ""
 Local _nDividendo := 0
 Local _nCociente := 0
 Local _nResto := 0

If (_lSwStr <> .T.)
 _nInput := Abs(Int(_nInput))
 _nBase := Abs(Int(_nBase))

If (_nInput = 0)
 _BXCnv := "0"
ElseIf (Abs(_nInput) <= _MaxInteger) .And. (IsRange(_nBase, 2, 252) <> .F.)
 _BXCnv := ""
 _nDividendo := _nInput

If (_nDividendo >= _nBase)
Do While (.T.)
 _nResto := (_nDividendo % _nBase)

If (_nDividendo < _nBase)
 _cBuffer := (_cBuffer + BXTbl(_nCociente, _nBase, _lSwStr))
 Exit
EndIf

 _nCociente := Int(_nDividendo / _nBase)
 _cBuffer := (_cBuffer + BXTbl(_nResto, _nBase, _lSwStr))
 _nDividendo := _nCociente
EndDo

Else
 _cBuffer := (_cBuffer + BXTbl(_nDividendo, _nBase, _lSwStr))
EndIf

EndIf
EndIf

 Return (_BXCnv + ReverseStr(_cBuffer))

Function BXTbl(_xNum, _nBase, _lSwStr)
* (c) Alejandro Padrino, 2.004 - 2.017
*

 Local _BXTbl := Nil
 Local _cStr00 := ""
 Local _nNum00 := 0
 Local _lError := .F.

If (IsRange(_nBase, 2, 252) <> .F.)
If (_lSwStr <> .T.)
If (IsRange(_xNum, 0, 9) <> .F.)
 _BXTbl := Chr(_xNum + 48)
ElseIf (IsRange(_xNum, 10, 35) <> .F.)
 _BXTbl := Chr(_xNum + 55)
ElseIf (IsRange(_xNum, 36, 61) <> .F.)
 _BXTbl := Chr(_xNum + 61)
ElseIf (_xNum = 62)
 _BXTbl := Chr(43)
ElseIf (_xNum = 63)
 _BXTbl := "/"
ElseIf (IsRange(_xNum, 64, 196) <> .F.)
 _BXTbl := Chr(_xNum + 59)
ElseIf (IsRange(_xNum, 197, 202) <> .F.)
 _BXTbl := Chr(_xNum - 106)
ElseIf (IsRange(_xNum, 203, 209) <> .F.)
 _BXTbl := Chr(_xNum - 145)
ElseIf (_xNum = 210)
 _BXTbl := Chr(44)
ElseIf (IsRange(_xNum, 211, 220) <> .F.)
 _BXTbl := Chr(_xNum - 178)
ElseIf (IsRange(_xNum, 221, 238) <> .F.)
 _BXTbl := Chr(_xNum - 207)
ElseIf (IsRange(_xNum, 239, 251) <> .F.)
 _BXTbl := Chr(_xNum - 238)
EndIf

ElseIf (_lSwStr <> .F.)
 _cStr00 := Left(AllTrim(_xNum), 1)
 _nNum00 := Asc(IIf((_nBase <= 36), Upper(_cStr00), _cStr00))

If (IsRange(_nNum00, 48, 57) <> .F.)
 _BXTbl := (_nNum00 - 48)
ElseIf (IsRange(_nNum00, 65, 90) <> .F.)
 _BXTbl := (_nNum00 - 55)
ElseIf (IsRange(_nNum00, 97, 122) <> .F.)
 _BXTbl := (_nNum00 - 61)
ElseIf (_nNum00 = 43)
 _BXTbl := (62)
ElseIf (_nNum00 = 47)
 _BXTbl := (63)
ElseIf (IsRange(_nNum00, 123, 255) <> .F.)
 _BXTbl := (_nNum00 - 59)
ElseIf (IsRange(_nNum00, 91, 96) <> .F.)
 _BXTbl := (_nNum00 + 106)
ElseIf (IsRange(_nNum00, 58, 64) <> .F.)
 _BXTbl := (_nNum00 + 145)
ElseIf (_nNum00 = 44)
 _BXTbl := (210)
ElseIf (IsRange(_nNum00, 33, 42) <> .F.)
 _BXTbl := (_nNum00 + 178)
ElseIf (IsRange(_nNum00, 14, 31) <> .F.)
 _BXTbl := (_nNum00 + 207)
ElseIf (IsRange(_nNum00, 1, 13) <> .F.)
 _BXTbl := (_nNum00 + 238)
EndIf

 _lError := IIf((_BXTbl < _nBase), _lError, .T.)
EndIf
EndIf

 Return (IIf((_lError <> .T.), _BXTbl, "*** Error ***"))

Function CToN(_cIn, _nBase)
* (c) Alejandro Padrino, 2.004 - 2.017
*

 Local _CToN := 0
 Local _cBuffer := ""
 Local _nExp := 0
 Local _nDecimals := 0
 Local _nFraction := 0
 Local _nNum00 := 0
 Local _lNegativo := .F.

If (ValType(_cIn) = "C")
 _cIn := AllTrim(_cIn)
 _nBase := Abs(Int(_nBase))

If (_nBase <= 252)
If (Left(_cIn, 1) = "-")
 _lNegativo := .T.
 _cIn := Right(_cIn, (Len(_cIn) - 1))
EndIf

 _cBuffer := ReverseStr(_cIn)
 _nDecimals := (At(".", _cBuffer) - 1)

If (_nDecimals > 0)
For _nExp = 0 To (_nDecimals - 1) Step 1
 _nNum00 := (_nNum00 + (BXTbl(SubStr(_cBuffer, (_nExp + 1), 1), _nBase, .T.) * (_nBase ^ _nExp)))
Next _nExp

 _nFraction := xVal("0" + "." + AllTrim(Str(_nNum00)))
 _cBuffer := ReverseStr(Left(_cIn, (At(".", _cIn) - 1)))
EndIf

For _nExp = 0 To (Len(_cBuffer) - 1) Step 1
 _CToN := (_CToN + (BXTbl(SubStr(_cBuffer, (_nExp + 1), 1), _nBase, .T.) * (_nBase ^ _nExp)))
Next _nExp

 _CToN := (_CToN + _nFraction)
EndIf
EndIf

 Return (IIf((_lNegativo <> .F.), (_CToN * (-1)), _CToN))

Function IsRange(_nInput, _nMin, _nMax)
* (c) Alejandro Padrino, 2.004
*

 Return (IIf((_nInput >= 0) .And. (_nInput >= _nMin) .And. (_nInput <= _nMax), .T., If((_nInput < 0) .And. (_nInput <= _nMin) .And. (_nInput >= _nMax), .T., .F.)))

Function NToC(_nInput, _nBase)
* (c) Alejandro Padrino, 2.004 - 2.017
*

 Local _NToC := "*** Error ***"
 Local _cFraction := ""
 Local _lNegativo := IIf((_nInput < 0), .T., .F.)
 Local _cStr00 := ""
 Local _nNum00 := Abs(_nInput)

If (ValType(_nInput) = "N")
 _cStr00 := Transform((_nNum00 - Int(_nNum00)), "####################.####################")
 _nNum00 := xVal(SubStr(_cStr00, (At(".", _cStr00) + 1), (Set(3, Nil, Nil) + 1)))
 _cFraction := IIf((_nNum00 > 0), ("." + BXCnv(_nNum00, _nBase, .F.)), "")
 _NToC := (IIf((_lNegativo <> .F.), "-", "") + BXCnv(_nInput, _nBase, .F.) + _cFraction)
EndIf

 Return (_NToC)

Function SHCrypt (_cIn, _cKey)
* (c) Alejandro Padrino, 2.004 - 2.017
*

 Local _SHCrypt := ""
 Local _cLen := Len(_cIn)
 Local _xLen := 0
 Local _kLen := 0
 Local _nK00 := 3
 Local _nK01 := 17
 Local _nK02 := 11
 Local _nK03 := 7
 Local _Xb := 0

If (_cLen > 0)
 _xLen := IIf((Len(_cKey) > SHMAS), SHMAS, Len(_cKey))
 _kLen := IIf((_xLen > (SHMAS - 2)), (SHMAS - 2), _xLen)
 Private vPKey[_kLen + 2]

If (_kLen < 1)
 Return (_cIn)
EndIf

 vPKey[1] := (((_kLen * _nK00) + _nK01 + 1) % SHMI)
 vPKey[_kLen + 2] := vPKey[1]

For _Xb = 2 To (_kLen + 1) Step 1
 vPKey[_kLen + 2] := (Abs(vPKey[_kLen + 2] + (Asc(SubStr(_cKey, (_Xb - 1), 1)) * _nK02)) % SHMI)
 vPKey[_Xb] := (Abs((Asc(SubStr(_cKey, (_Xb - 1), 1)) * (_Xb - 1)) + (Int(vPKey[_kLen + 2] / vPKey[_Xb - 1]) + 1) * _nK03) % SHMI)
Next _Xb

For _Xb = 2 To (_cLen + 1) Step 1
 _nK00 := ((vPKey[(_Xb % _kLen) + 1] % 256) + ((_Xb - 1) % 256))
 _SHCrypt := (_SHCrypt + Chr((Asc(SubStr(_cIn, (_Xb - 1), 1)) + _nK00) % 256))
Next _Xb
EndIf

 Return (_SHCrypt)

Function SHDeCrypt (_cIn, _cKey)
* (c) Alejandro Padrino, 2.004 - 2.017
*

 Local _SHDeCrypt := ""
 Local _cLen := Len(_cIn)
 Local _xLen := 0
 Local _kLen := 0
 Local _nK00 := 3
 Local _nK01 := 17
 Local _nK02 := 11
 Local _nK03 := 7
 Local _Xb := 0

If (_cLen > 0)
 _xLen := IIf((Len(_cKey) > SHMAS), SHMAS, Len(_cKey))
 _kLen := IIf((_xLen > (SHMAS - 2)), (SHMAS - 2), _xLen)
 Private vPKey[_kLen + 2]

If (_kLen < 1)
 Return (_cIn)
EndIf

 vPKey[1] := (((_kLen * _nK00) + _nK01 + 1) % SHMI)
 vPKey[_kLen + 2] := vPKey[1]

For _Xb = 2 To (_kLen + 1) Step 1
 vPKey[_kLen + 2] := (Abs(vPKey[_kLen + 2] + (Asc(SubStr(_cKey, (_Xb - 1), 1)) * _nK02)) % SHMI)
 vPKey[_Xb] := (Abs((Asc(SubStr(_cKey, (_Xb - 1), 1)) * (_Xb - 1)) + (Int(vPKey[_kLen + 2] / vPKey[_Xb - 1]) + 1) * _nK03) % SHMI)
Next _Xb

For _Xb = 2 To (_cLen + 1) Step 1
 _nK00 := ((vPKey[(_Xb % _kLen) + 1] % 256) + ((_Xb - 1) % 256))
 _SHDeCrypt := (_SHDeCrypt + Chr((Asc(SubStr(_cIn, (_Xb - 1), 1)) - _nK00) % 256))
Next _Xb
EndIf

 Return (_SHDeCrypt)

Function SHBeg()
* (c) Alejandro Padrino, 2.017
*

 Public SHMAS := (2 ^ 31)
 Public SHME2 := 31
 Public SHMI := ((2 ^ SHME2) - 1)
 Public SHMC := (SHMAS * 2)
 Public SHHI := 0
 Public SHHO := 0
 Public SHHK := "(Secured-Hash-Free).(Alejandro-Padrino-Sanchis).(Hackathon-2017)"
 Public SHHDT := ""
 Public SHHFS := ""
 Public SHHS := ""
 Public SHLHK := ""
 Public SHFB := ""

 SHHK := SHCrypt(SHHK, ReverseStr(SHHK))

 Return (Nil)

Function SHHash(_xIn, _cPwd, _lHashFile, _lGetFile)
* (c) Alejandro Padrino, 2.017
*

 Local _SHHash := ""
 Local HK1 := ""
 Local HK2 := ""
 Local HK3 := ""
 Local HK4 := ""
 Local _cHashExt := ".SHash"
 Local _cFile := ""
 Local _cOutFile := ("SecuredHashOut" + _cHashExt)
 Local _cHash := ""
 Local _cDateTime := ""
 Local _cTemp00 := ""
 Local _cTemp01 := ""
 Local _hFile := (-1)

 _cPwd := IIf((ValType(_cPwd) <> "C"), "", AllTrim(_cPwd))

If (.Not. File(_xIn) <> .T.)
 _cFile := EFN(_xIn, .T., .F.)
 _cOutFile := (EFN(_xIn, .F., .T.) + _cHashExt)
 _cHash := SHGFS(_xIn)
Else
 _cFile := "0"

If (Len(AllTrim(_xIn)) < 1)
 _cHash := SHGS(IIf((SHHO < 1), 0, SHHO))
Else
 _cHash := SHGS(_xIn)
EndIf
EndIf

 _cDateTime := (AS(Str(Year(Date())), 5, (-1), 48) + AS(Str(Month(Date())), 2, (-1), 48) + AS(Str(Day(Date())), 2, (-1), 48) + SubStr(Time(), 1, 2) + SubStr(Time(), 4, 2) + SubStr(Time(), 7, 2))
 SHLHK := IIf((Len(AllTrim(_cDateTime)) > 0), _cDateTime, SHLHK)
 _cTemp01 := SHCrypt(_cDateTime, (_cPwd + SHHK))
 HK1 := SB(_cTemp01)
 _SHHash := (HK1 + "-")
 _cTemp00 := IIf((.Not. File(_xIn) <> .T.), IIf((_lGetFile <> .F.), (_cFile + Chr(0) + SHFB), (_cFile + Chr(0))), (_xIn + Chr(0)))
 _cTemp00 := SHCrypt(_cTemp00, (_cPwd + HK1 + SHHK))
 HK2 := SB(_cTemp00)
 HK4 := Right(HK2, Len(_cDateTime))
 _SHHash := (_SHHash + HK2 + "-")
 _cTemp00 := SHCrypt(_cHash, (_cPwd + HK4 + SHHK))
 HK3 := SB(_cTemp00)
 _SHHash := (_SHHash + HK3)

If (_lHashFile <> .F.)
 FClose(_hFile)
 _hFile := FCreate(_cOutFile, 0)
 FClose(_hFile)
 _hFile := FOpen(_cOutFile, (1 + 16 + 32 + 48))
 FWL(_hFile, _SHHash)
 FClose(_hFile)
EndIf

 Return (_SHHash)

Function IsSHHash(_cIn)
* (c) Alejandro Padrino, 2.017
*

 Local _nPos00 := At("-", _cIn)
 Local _nPos01 := RAt("-", _cIn)
 Return (IIf((_nPos01 > (_nPos00 + 2)) .And. (Len(SubStr(_cIn, 1, (_nPos00 - 1))) > 13) .And. (Len(SubStr(_cIn, (_nPos00 + 1), (_nPos01 - _nPos00 - 1))) > 0) .And. (Len(SubStr(_cIn, (_nPos01 + 1), Len(_cIn))) > 0), .T., .F.))

Function SHDHash(_cIn, _cPwd, _lGetFile)
* (c) Alejandro Padrino, 2.017
*

 Local _Return := .F.
 Local _cHashExt := ".SHash"
 Local _cTemp00 := ""
 Local _cTemp01 := ""
 Local _cTemp02 := ""
 Local _nPos00 := (-1)
 Local _nPos01 := (-1)
 Local _nPos02 := (-1)
 Local _hFile := (-1)

 _cPwd := IIf((ValType(_cPwd) <> "C"), "", AllTrim(_cPwd))
 SHHDT := ""
 SHHFS := ""
 SHHS := ""
 SHFB := ""

If (IsSHHash(_cIn) <> .T.) .And. (XAt(_cIn, _cHashExt) > 0)
 _cIn := SHRHF(_cIn)
EndIf

If (IsSHHash(_cIn) <> .F.)
 _nPos00 := At("-", _cIn)
 _nPos01 := RAt("-", _cIn)
 _cTemp02 := SubStr(_cIn, 1, (_nPos00 - 1))
 _cTemp00 := BS(_cTemp02)
 SHHDT := SHDeCrypt(_cTemp00, (_cPwd + SHHK))
 SHLHK := IIf((Len(AllTrim(SHHDT)) > 0), SHHDT, SHLHK)
 _cTemp00 := SubStr(_cIn, (_nPos00 + 1), (_nPos01 - _nPos00 - 1))
 _cTemp01 := Right(_cTemp00, Len(SHHDT))
 _cTemp00 := BS(_cTemp00)
 SHHFS := SHDeCrypt(_cTemp00, (_cPwd + _cTemp02 + SHHK))
 _nPos02 := At(Chr(0), SHHFS)
 SHFB := IIf((Len(SHHFS) > _nPos02), SubStr(SHHFS, (_nPos02 + 1), Len(SHHFS)), "")
 SHHFS := Left(SHHFS, (_nPos02 - 1))
 _cTemp00 := BS(SubStr(_cIn, (_nPos01 + 1), Len(_cIn)))
 SHHS := SHDeCrypt(_cTemp00, (_cPwd + _cTemp01 + SHHK))
 _Return := .T.
EndIf

If (_lGetFile <> .F.)
 _Return := .F.
 _nPos00 := Len(SHFB)
 _nPos01 := (-1)

If (_nPos00 > 0)
 FClose(_hFile)
 _hFile := FCreate(SHHFS, 0)
 FClose(_hFile)
 ? "Extrayendo el archivo ", SHHFS, " ... "
 _hFile := FOpen(SHHFS, (1 + 16 + 32 + 48))
 _nPos01 := FWrite(_hFile, SHFB, _nPos00)
 FClose(_hFile)
 _Return := IIf((_nPos00 <> _nPos01), .F., .T.)
EndIf
EndIf

 Return (_Return)

Function SHChHash(_xIn, _cPwd)
* (c) Alejandro Padrino, 2.017
*

 Local _SHChHash := .F.
 Local _cHashExt := ".SHash"
 Local _cHashFile := ("SecuredHashOut" + _cHashExt)
 Local _cDateTime00 := ""
 Local _cDateTime02 := ""
 Local _cFile00 := ""
 Local _cFile01 := ""
 Local _cFile02 := ""
 Local _cHash00 := _xIn
 Local _cHash01 := _xIn
 Local _cHash02 := _xIn
 Local _cHashF00 := ""
 Local _cHashF01 := ""
 Local _cHashF02 := ""
 Local _cHashF03 := ""
 Local _cHashF04 := ""
 Local _cTemp00 := ""
 Local _cTemp01 := ""
 Local _cTemp02 := ""
 Local _cTemp03 := ""
 Local _cTemp04 := ""
 Local _cTemp05 := ""
 Local _cIsFile := " <File> "
 Local _cMatch := " (Ok) "
 Local _cError := " (Error) "
 Local _nTemp00 := 0
 Local _nTemp01 := 0
 Local _nTemp02 := 0
 Local _nTemp03 := 0
 Local _nTemp04 := 0
 Local _nTemp05 := 0
 Local _nTemp06 := 0
 Local _nTemp07 := 0
 Local _nTemp08 := 0
 Local _nTemp09 := 0
 Local _nTemp10 := Len(AllTrim(_cHash00))
 Local _nTemp11 := Len(AllTrim(_cHash01))
 Local _nTemp12 := (-1)
 Local _nTemp13 := 0
 Local _nTemp14 := 0
 Local _lHash00 := .F.
 Local _lHash01 := .F.
 Local _lHash02 := .F.

If (Len(AllTrim(_cHash00)) > 0) .And. (.Not. File(_cHash00) <> .F.)
 _cPwd := IIf((ValType(_cPwd) <> "C"), "", AllTrim(_cPwd))
 SHDHash(_cHash00, _cPwd, .F.)

If (Len(AllTrim(SHHDT)) > 0) .And. (Len(AllTrim(SHHFS)) > 0) .And. (Len(AllTrim(SHHS)) > 0)
 _cDateTime00 := SHHDT
 _nTemp00 := IIf((IsN(_cDateTime00) <> .F.), Val(AllTrim(_cDateTime00)), (-1))
 _cFile00 := SHHFS
 _nTemp02 := Len(AllTrim(_cFile00))
 _cHashF03 := IIf((_nTemp02 > 0) .And. (.Not. File(_cFile00) <> .F.), SHGS(_cFile00), "")
 _nTemp08 := Len(AllTrim(_cHashF03))
 _cHashF00 := SHHS
 _nTemp05 := Len(AllTrim(_cHashF00))
 _cHashFile := IIf((.Not. File(_cFile00) <> .T.), (EFN(_cFile00, .F., .T.) + _cHashExt), _cHashFile)
 _lHash00 := .T.
Else
 _lHash00 := .F.
EndIf

Else
 _cHash00 := ""
EndIf

If (.Not. File(_xIn) <> .T.) .Or. (.Not. File(_cHashFile) <> .T.) .Or. (.Not. File(_cFile00) <> .T.)
If (.Not. File(_xIn) <> .T.) .Or. (.Not. File(_cFile00) <> .T.)
If (XAt(_xIn, _cHashExt) > 0)
 _cHash01 := SHRHF(_xIn)
 SHDHash(_cHash01, _cPwd, .F.)
 _xIn := SHHFS
EndIf

 _cFile01 := EFN(IIf((.Not. File(_xIn) <> .T.), _xIn, _cFile00), .T., .F.)
 _nTemp03 := Len(AllTrim(_cFile01))
 _cHashF01 := SHGFS(IIf((.Not. File(_xIn) <> .T.), _xIn, _cFile00))
 _nTemp06 := Len(AllTrim(_cHashF01))
 _cTemp04 := SHGS(SHFB)
 _nTemp13 := Len(AllTrim(_cTemp04))
 _nTemp06 := Len(AllTrim(_cHashF01))
 _cHashFile := (EFN(IIf((.Not. File(_xIn) <> .T.), _xIn, _cHashFile), .F., .T.) + _cHashExt)
 _lHash01 := IIf((Len(AllTrim(_cFile01)) > 0) .And. (Len(AllTrim(_cHashF01)) > 0), .T., .F.)
Else
 _cHash01 := ""
EndIf

If (.Not. File(_cHashFile) <> .T.)
 _cHash02 := SHRHF(_cHashFile)
 _nTemp12 := Len(AllTrim(_cHash02))
 SHDHash(_cHash02, _cPwd, .F.)

If (IsN(SHHDT) <> .F.) .And. (Len(AllTrim(SHHFS)) > 0) .And. (Len(AllTrim(SHHS)) > 0)
 _cDateTime02 := SHHDT
 _nTemp01 := IIf((IsN(_cDateTime02) <> .F.), Val(AllTrim(_cDateTime02)), (-1))
 _cFile02 := SHHFS
 _nTemp04 := Len(AllTrim(_cFile02))
 _cHashF04 := IIf((_nTemp04 > 0) .And. (.Not. File(_cFile02) <> .F.), SHGS(_cFile02), "")
 _nTemp09 := Len(AllTrim(_cHashF04))
 _cHashF02 := SHHS
 _nTemp07 := Len(AllTrim(_cHashF02))
 _cTemp05 := SHGS(SHFB)
 _nTemp14 := Len(AllTrim(_cTemp05))
 _lHash02 := .T.
Else
 _lHash02 := .F.
EndIf

Else
 _cHash02 := ""
EndIf
EndIf

If ((Len(AllTrim(_cDateTime00)) > 0) .And. (_nTemp00 < 1)) .Or. ((Len(AllTrim(_cDateTime02)) > 0) .And. (_nTemp01 < 1))
  SHHDT := " "
 _SHChHash := .F.
Else

If (_lHash00 <> .F.) .Or. (_lHash01 <> .F.) .Or. (_lHash02 <> .F.)
 _SHChHash := IsN(SHHDT)
 _cTemp00 := IIf((IsN(_cDateTime00) <> .F.) .And. (_nTemp00 > 0), _cDateTime00, IIf(((_nTemp01 > 0)), _cDateTime02, ""))
 _cTemp00 := (SubStr(_cTemp00, 1, 5) + "-" + SubStr(_cTemp00, 6, 2) + "-" + SubStr(_cTemp00, 8, 2) + " " + "/" + " " + SubStr(_cTemp00, 10, 2) + ":" + SubStr(_cTemp00, 12, 2) + ":" + SubStr(_cTemp00, 14, 2))
 _cTemp00 := IIf((_cDateTime00 <> _cDateTime02) .And. (_nTemp00 > 0) .And. (_nTemp01 > 0), (_cTemp00 + _cError), (_cTemp00 + _cMatch))

 _cTemp03 := IIf((_nTemp12 > 0), _cHash02, IIf((_nTemp10 > 0), _cHash00, ""))
 _cTemp01 := IIf((_nTemp02 > 0), _cFile00, IIf(((_nTemp03 > 0)), _cFile01, IIf(((_nTemp04 > 0)), _cFile02, "")))
 _cTemp01 := IIf((Len(SHFB) > 0), RTrim(_cTemp01 + _cIsFile), _cTemp01)
 _cTemp01 := IIf(((_cFile00 <> _cFile01) .And. (_nTemp02 > 0) .And. (_nTemp03 > 0)) .Or. ((_cFile00 <> _cFile02) .And. (_nTemp02 > 0) .And. (_nTemp04 > 0)) .Or. ((_cFile01 <> _cFile02) .And. (_nTemp03 > 0) .And. (_nTemp04 > 0)) .Or. ((_cHash00 <> _cHash02) .And. (_nTemp10 = _nTemp12)) .Or. ((_cTemp04 <> _cTemp05) .And. (_nTemp13 = _nTemp14)), (_cTemp01 + _cError), (_cTemp01 + _cMatch))

 _cTemp02 := IIf((_nTemp05 > 0), _cHashF00, IIf(((_nTemp06 > 0)), _cHashF01, IIf(((_nTemp07 > 0)), _cHashF02, "")))
 _cTemp02 := IIf(((_cHashF00 <> _cHashF01) .And. (_nTemp05 > 0) .And. (_nTemp06 > 0)) .Or. ((_cHashF00 <> _cHashF02) .And. (_nTemp05 > 0) .And. (_nTemp07 > 0)) .Or. ((_cHashF01 <> _cHashF02) .And. (_nTemp06 > 0) .And. (_nTemp07 > 0)) .Or. ((_cHashF00 <> _cHashF03) .And. (_nTemp05 > 0) .And. (_nTemp08 > 0)) .Or. ((_cHashF02 <> _cHashF03) .And. (_nTemp07 > 0) .And. (_nTemp08 > 0)) .Or. ((_cHashF00 <> _cHashF04) .And. (_nTemp05 > 0) .And. (_nTemp09 > 0)) .Or. ((_cHashF02 <> _cHashF04) .And. (_nTemp06 > 0) .And. (_nTemp09 > 0)), (_cTemp02 + _cError), (_cTemp02 + _cMatch))

 SHHDT := _cTemp00
 SHHFS := _cTemp01
 SHHS := _cTemp02

 _SHChHash := IIf((_SHChHash <> .F.) .And. (XAt(_cTemp00, _cMatch, 0) > 0) .And. (XAt(_cTemp01, _cMatch, 0) > 0) .And. (XAt(_cTemp02, _cMatch, 0) > 0), .T., .F.)
EndIf
EndIf

 Return (_SHChHash)

Function SHGI(_xIn, _cPwd)
* (c) Alejandro Padrino, 2.017
*

 Local _HashText00 := "Secured-Hash Checker.  (c) Alejandro Padrino.      Hackathon CyberCamp 2.017"
 Local _HashText01 := "============================================================================"
 Local _HashText02 := "- Fecha/Hora (yyyy-mm-dd / hh:mm:ss): "
 Local _HashText03 := "- Archivo/Cadena: "
 Local _HashText04 := "- CheckSum: "
 Local _cMatch := "(Comparacion de Hash sin errores)"
 Local _cError := "(Error en la comparacion del Hash)"
 Local _lSw00 := .F.

 _cPwd := IIf((ValType(_cPwd) <> "C"), "", AllTrim(_cPwd))
 _lSw00 := SHChHash(_xIn, _cPwd)
 Set Color To BG+/N

 ? ""
 ? _HashText00
 ? _HashText01
 ? ""

If (Len(AllTrim(SHHDT)) >= 15)
 ? (_HashText02 + SubStr(SHHDT, 2, Len(SHHDT)))
 ? (_HashText03 + SHHFS)
 ? (_HashText04 + SHHS)
 ? ""
EndIf

If (_lSw00 <> .F.)
 Set Color To G+/N
 ? _cMatch
 ? ""
Else
 Set Color To R+/N
 ? _cError
 ? ""
 ErrorLevel(1000)
EndIf

 SHHDT := ""
 SHHFS := ""
 SHHS := ""
 SHFB := ""

 Return (_lSw00)

Function SHRHF(_cIn)
* (c) Alejandro Padrino, 2.017
*

 Local _SHRHF := ""
 Local _hFile := (-1)

 FClose(_hFile)
 _hFile := FOpen(_cIn, (0 + 16 + 32 + 48))
 _SHRHF := FRL(_hFile)
 FClose(_hFile)
 Return (_SHRHF)

Function SHGS(_cIn)
* (c) Alejandro Padrino, 2.013 - 2.017
*

 Local _SHGS := 0
 Local _nLen := 0
 Local _nTemp00 := 0

If (ValType(_cIn) == "C")
 _nLen := Len(_cIn)

If (_nLen > 0)
For _b00 = 1 To _nLen Step 1
 _nTemp00 := ((((Asc(SubStr(_cIn, _b00, 1)) + 2) * 3) % 256) + 3)
 _SHGS := (_SHGS + _nTemp00)
Next _b00
EndIf
EndIf

 Return (Lower(NToC(_SHGS, 36)))

Function SHGFS(_xIn)
* (c) Alejandro Padrino, 2.013 - 2.017
*

 Local _SHGFS := ""
 Local _aHash := {}
 Local _nMaxInt := (Int(SHMC) - 258)
 Local _nReadBlock := (2 ^ 16)
 Local _nBytesRead := 1
 Local _cBuffer := Space(Min(_nReadBlock, _MaxInt16))
 Local _hFile := FOpen(_xIn, (0 + 16 + 32 + 48))
 Local _nTmp00 := 0
 Local _nTmp01 := 0
 Local _b00 := (-1)

If (_hFile >= 0)
 SHFB := ""
 FSeek(_hFile, 0, 0)
 AAdd(_aHash, 0)

Do While (_nBytesRead > 0)
 _nBytesRead := FRead(_hFile, @_cBuffer, _nReadBlock)

If (_nBytesRead > 0)
 SHFB := (SHFB + Left(_cBuffer, _nBytesRead))

For _b00 = 1 To _nBytesRead Step 1
 _nTmp00 := ((((Asc(SubStr(_cBuffer, _b00, 1)) + 2) * 3) % 256) + 3)
 _nTmp01 := (_aHash[Len(_aHash)] + _nTmp00)

If (_nTmp01 <= _nMaxInt)
 _aHash[Len(_aHash)] := _nTmp01
Else
 AAdd(_aHash, 0)
 _aHash[Len(_aHash)] := _nTmp00
EndIf

Next _b00
EndIf
EndDo

 _nTmp00 := Len(_aHash)
 FClose(_hFile)

If (_nTmp00 > 0)
For _b00 = 1 To _nTmp00 Step 1
 _SHGFS := (_SHGFS + IIf((_b00 > 1), "-", "") + NToC(_aHash[_b00], 36))
Next _b00
EndIf
EndIf

 FClose(_hFile)
 Return (Lower(_SHGFS))


******************************************************************************

