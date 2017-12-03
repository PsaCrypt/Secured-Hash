
*
* [SH-Speed.Prg]:  Secured-Hash Speed Test.
*                  (c) Alejandro Padrino, 2017.
*

 #Include ".\S-Hash.Prg"

 main()
 quit

function main()

 public _t0 := (-1)
 public _t1 := (-1)
 public _hFile := 0

 StartHb()

 close alternate
 set alternate to .\sh-speed.txt
 set alternate on

 set color to w+/n
 ? ""
 ? "Secured-Hash Speed Testing:"
 ? "==========================="
 ? ""

 set alternate off
 ? "Creando archivos temporales ..."
 maketestfile(".\Temp4k", 4096)
 ? "- Temp4k => Ok."
 maketestfile(".\Temp8k", 8192)
 ? "- Temp8k => Ok."
 maketestfile(".\Temp16k", 16384)
 ? "- Temp16k => Ok."
 maketestfile(".\Temp32k", 32768)
 ? "- Temp32k => Ok."
 maketestfile(".\Temp64k", 65536)
 ? "- Temp64k => Ok."
 maketestfile(".\Temp128k", 131072)
 ? "- Temp128k => Ok."
 maketestfile(".\Temp256k", 262144)
 ? "- Temp256k => Ok."
 maketestfile(".\Temp512k", 524288)
 ? "- Temp512k => Ok."
 maketestfile(".\Temp1m", (1024 * 1024))
 ? "- Temp1m => Ok."
 maketestfile(".\Temp2m", (2048 * 1024))
 ? "- Temp2m => Ok."
 maketestfile(".\Temp4m", (4096 * 1024))
 ? "- Temp4m => Ok."
 maketestfile(".\Temp8m", (8192 * 1024))
 ? "- Temp8m => Ok."
 maketestfile(".\Temp16m", (16384 * 1024))
 ? "- Temp16m => Ok."
 maketestfile(".\Temp32m", (32768 * 1024))
 ? "- Temp32m => Ok."
 maketestfile(".\Temp64m", (65536 * 1024))
 ? "- Temp64m => Ok."
 maketestfile(".\Temp128m", (131072 * 1024))
 ? "- Temp128m => Ok."
 maketestfile(".\Temp256m", (262144 * 1024))
 ? "- Temp256m => Ok."
 ? ""

 set alternate on
 ? "Pruebas de velocidad ..."

 _t0 := seconds()
 SHHash(".\Temp4k", "", .t., .t.)
 _t1 := seconds()
 ? "- 4k: ", (_t1 - _t0), " Segundos."

 _t0 := seconds()
 SHHash(".\Temp8k", "", .t., .t.)
 _t1 := seconds()
 ? "- 8k: ", (_t1 - _t0), " Segundos."

 _t0 := seconds()
 SHHash(".\Temp16k", "", .t., .t.)
 _t1 := seconds()
 ? "- 16k: ", (_t1 - _t0), " Segundos."

 _t0 := seconds()
 SHHash(".\Temp32k", "", .t., .t.)
 _t1 := seconds()
 ? "- 32k: ", (_t1 - _t0), " Segundos."

 _t0 := seconds()
 SHHash(".\Temp64k", "", .t., .t.)
 _t1 := seconds()
 ? "- 64k: ", (_t1 - _t0), " Segundos."

 _t0 := seconds()
 SHHash(".\Temp128k", "", .t., .t.)
 _t1 := seconds()
 ? "- 128k: ", (_t1 - _t0), " Segundos."

 _t0 := seconds()
 SHHash(".\Temp256k", "", .t., .t.)
 _t1 := seconds()
 ? "- 256k: ", (_t1 - _t0), " Segundos."

 _t0 := seconds()
 SHHash(".\Temp512k", "", .t., .t.)
 _t1 := seconds()
 ? "- 512k: ", (_t1 - _t0), " Segundos."

 _t0 := seconds()
 SHHash(".\Temp1m", "", .t., .t.)
 _t1 := seconds()
 ? "- 1m: ", (_t1 - _t0), " Segundos."

 _t0 := seconds()
 SHHash(".\Temp2m", "", .t., .t.)
 _t1 := seconds()
 ? "- 2m: ", (_t1 - _t0), " Segundos."

 _t0 := seconds()
 SHHash(".\Temp4m", "", .t., .t.)
 _t1 := seconds()
 ? "- 4m: ", (_t1 - _t0), " Segundos."

 _t0 := seconds()
 SHHash(".\Temp8m", "", .t., .t.)
 _t1 := seconds()
 ? "- 8m: ", (_t1 - _t0), " Segundos."

 _t0 := seconds()
 SHHash(".\Temp16m", "", .t., .t.)
 _t1 := seconds()
 ? "- 16m: ", (_t1 - _t0), " Segundos."

 _t0 := seconds()
 SHHash(".\Temp32m", "", .t., .t.)
 _t1 := seconds()
 ? "- 32m: ", (_t1 - _t0), " Segundos."

 _t0 := seconds()
 SHHash(".\Temp64m", "", .t., .t.)
 _t1 := seconds()
 ? "- 64m: ", (_t1 - _t0), " Segundos."

 _t0 := seconds()
 SHHash(".\Temp128m", "", .t., .t.)
 _t1 := seconds()
 ? "- 128m: ", (_t1 - _t0), " Segundos."

 _t0 := seconds()
 SHHash(".\Temp256m", "", .t., .t.)
 _t1 := seconds()
 ? "- 256m: ", (_t1 - _t0), " Segundos."

 set alternate off
 close alternate

 return (nil)

function maketestfile(_cfile, _nlen)

 Private _cStr
 Private _WriteLen
 Private _BytesWrited

 FClose(_hFile)
 _hFile := FCreate(_cfile, 0)
 FClose(_hFile)
 _hFile := FOpen(_cfile, (1 + 16 + 32 + 48))

 _cStr := Replicate(Chr(0), _nlen)
 _WriteLen := 0
 _BytesWrited := 0

 _cStr := IIf((Right(_cStr, 2) <> (Chr(13) + Chr(10))), (_cStr + Chr(13) + Chr(10)), _cStr)
 _WriteLen := Len(_cStr)
 _BytesWrited := FWrite(_hFile, _cStr, _WriteLen)
 FClose(_hFile)
 _cStr := ""

 Return (IIf((_BytesWrited <> _WriteLen), .F., .T.))
