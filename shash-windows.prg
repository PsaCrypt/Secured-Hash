
*
* [shash.prg] - (c) Alejandro Padrino, 2.017
*               Programa desarrollado exclusivamente para el Hackathon-2017.
*

 Parameters p00, p01, p02, p03, p04, p05, p06, p07, p08, p09, p10, p11, p12, p13, p14, p15, p16

 *** Selector for Linux/Windows Compiler #00 ***
 *(Not)> #Include "./S-Hash.Prg"
 #Include ".\S-Hash.Prg"

 Main(p00, p01, p02, p03, p04, p05, p06, p07, p08, p09, p10, p11, p12, p13, p14, p15, p16)
 Quit

Function Main(p00, p01, p02, p03, p04, p05, p06, p07, p08, p09, p10, p11, p12, p13, p14, p15, p16)
* (c) Alejandro Padrino, 2.017
*

 Private cP := {}
 Private cL := ""
 Private cC := ""
 Private cT := ""
 Private lM := .F.
 Private lC := .F.
 Private lX := .F.
 Private lH := .T.
 Private lF := .F.
 Private lT := .F.
 Private nB := (-1)

 StartHb()
 AAdd(cP, p00)
 AAdd(cP, p01)
 AAdd(cP, p02)
 AAdd(cP, p03)
 AAdd(cP, p04)
 AAdd(cP, p05)
 AAdd(cP, p06)
 AAdd(cP, p07)
 AAdd(cP, p08)
 AAdd(cP, p09)
 AAdd(cP, p10)
 AAdd(cP, p11)
 AAdd(cP, p12)
 AAdd(cP, p13)
 AAdd(cP, p14)
 AAdd(cP, p15)
 AAdd(cP, p16)
 Set Color To BG+/N

 *** Selector for Linux/Windows Compiler #01 ***
 *(Not)> Linux()
 Windows()

For nB = 1 To 10 Step 1
 cP[nB] := IIf((ValType(cP[nB]) <> "C"), "", AllTrim(cP[nB]))

If (Len(cP[nB]) > 0) .And. (Left(cP[nB], 1) <> "-") .And. (Left(cP[nB], 1) <> "/")

 cL := AllTrim(cL + " " + cP[nB])

ElseIf (Left(cP[nB], 1) = "-") .Or. (Left(cP[nB], 1) = "/")

 cT := Lower(AllTrim(cP[nB]))

Do Case
Case (cT = "-m") .Or. (cT = "/m")
 lF := IIf((Right(cT, 1) <> "s"), .F., .T.)
 lM := .T.

Case (cT = "-c") .Or. (cT = "/c")
 lC := .T.

Case (cT = "-x") .Or. (cT = "/x")
 lX := .T.

Case (cT = "-n") .Or. (cT = "/n")
 lH := IIf((Right(cT, 1) <> "n"), .T., .F.)

Case (cT = "-p") .Or. (cT = "/p")
 cC := SubStr(cT, (At(":", cT) + 1), Len(cT))

Case (cT = "-h") .Or. (cT = "/h")
 Help(IIf((SubStr(cT, 3, 1) <> "e"), 0, 1), IIf((Right(cT, 1) <> "c"), .F., .T.))

Otherwise
 cT := ""

End Case

EndIf
Next nB

If (Len(cP[1]) < 1)
 Help(0, .F.)
 Quit
EndIf

Do Case
Case (lM <> .F.) .And. (lC <> .T.) .And. (lX <> .T.)
 ? ""
 ? ("(" + cL + ") Hash: "), SHHash(cL, cC, lH, lF)
 ? ""

Case (lC <> .F.) .And. (lM <> .T.) .And. (lX <> .T.)
 SHGI(cL, cC)

Case (lX <> .F.) .And. (lM <> .T.) .And. (lC <> .T.)
If (SHDHash(cL, cC, .T.) <> .F.)
 ? ""
 ? "Se ha extraido el Archivo almacenado en el Hash."
 ? ""
EndIf

Otherwise
 DefError()
 Quit

End Case

 Quit

 Return (Nil)

Function Help(_nHlp, _lHlpFile)
* (c) Alejandro Padrino, 2.017
*

If (_lHlpFile <> .F.)
 Close Alternate

If (_nHlp < 1)
 Set Alternate To shash-sp.txt
Else
 Set Alternate To shash-en.txt
EndIf

 Set Alternate On
EndIf

 Set Color To BG+/N
 ? "                                                                            "
 ? "Secured-Hash Free.  (c) Alejandro Padrino.         Hackathon CyberCamp 2.017"
 ? "============================================================================"
 ? "                                                                            "

If (_nHlp < 1)

 Set Color To GR+/N
 ? "Sintaxis:  shash [-Opciones] [Archivo/Cadena]                               "
 ? "                                                                            "
 ? "           Archivo/Cadena:  Archivo o Cadena de Caracteres que  se procesara"
 ? "                            en Secured-Hash.                                "
 ? "                                                                            "

 Set Color To R+/N
 ? "Opciones:                                                                   "
 ? "                                                                            "

 Set Color To GR+/N
 ? "-m : Genera el Hash del Archivo o la Cadena de Caracteres que se indique.   "

 Set Color To B+/N
 ? "     shash -m [-n] [-p:clave] Archivo/Cadena   ; Genera el Hash.            "
 ? "     shash -ms [-n] [-p:clave] Archivo         ; Genera el Hash con Archivo."

 Set Color To GR+/N
 ? "-c : Comprueba el Hash del Archivo o la Cadena de Caracteres que se indique."
 ? "     Tambien puede comprobar un Hash creado con este programa.              "

 Set Color To B+/N
 ? "     shash -c [-p:clave] Archivo/Cadena/Archivo-Hash/Hash                   "

 Set Color To GR+/N
 ? "-x : Extrae el archivo almacenado dentro del Hash.                          "

 Set Color To B+/N
 ? "     shash -x [-p:clave] Archivo-Hash/Hash                                  "

 Set Color To GR+/N
 ? "-n : No genera el archivo con extension .SHash al crear un Hash.            "
 ? "-p : Clave alfanumerica utilizada  en  las opciones anteriores para procesar"
 ? "     un Hash Privado.                                                       "
 ? "                                                                            "

 Set Color To GR+/N
 ? "-h : Muestra la ayuda del programa.                                         "

 Set Color To B+/N
 ? "     shash -h     ; Muestra la ayuda en Castellano.                         "
 ? "     shash -hc    ; Crea el archivo shash-sp.txt                            "
 ? "     shash -he    ; Muestra la ayuda en Ingles.                             "
 ? "     shash -hec   ; Crea el archivo shash-en.txt                            "
 ? "                                                                            "
 ? "                                                                            "

 Set Color To R+/N
 ? "Notas del programador:                                                      "
 ? "                                                                            "

 Set Color To GR+/N
 ? "Secured-Hash Free  se  ha creado a partir  de  dos  proyectos profesionales:"
 ? "Algoritmo de Cifrado PSA,  Modulos  #01  y  #02.  Los  proyectos  originales"
 ? "ofrecen mayor seguridad y una longitud mas corta en el Hash generado.       "
 ? "                                                                            "
 ? "Caracteristicas de las Funciones de Hash:                                   "
 ? "- Pueden codificar la informacion de un archivo o una cadena de caracteres. "
 ? "- Contiene informacion  de  Fecha,  Hora,  Nombre de Archivo  o la Cadena de"
 ? "  Caracteres que se ha procesado, y el CheckSum obtenido.                   "
 ? "- Toda la informacion contenida en el Hash esta cifrada.                    "
 ? "- El Hash puede almacenar el archivo indicado en su interior.               "
 ? "- El CheckSum del Hash no revela la longitud real del Archivo o la Cadena de"
 ? "  Caracteres procesada.                                                     "
 ? "- Puede crearse un Hash Publico o un Hash Privado protegido por una clave.  "
 ? "                                                                            "
 ? "Ofrecer software de codigo abierto a la  comunidad de programadores es bueno"
 ? "para facilitar ayuda a las personas que quieren aprender a programar, y para"
 ? "comprobar  que el  software  no contiene codigo  que pueda causar perdida de"
 ? "datos en los equipos donde se use.  Por el contrario, acceder a este tipo de"
 ? "software le quita al  programador  muchas oportunidades para tener un futuro"
 ? "digno, honrado y feliz.                                                     "
 ? "                                                                            "
 ? "Este programa  se ha  desarrollado usando Harbour Compiler 3.0.  No contiene"
 ? "limitaciones que impidan desarrollarlo en otros lenguajes de programacion.  "
 ? "                                                                            "
 ? "https://github.com/PsaCrypt/Secured-Hash                                    "
 ? "                                                                            "
 ? "Este software se facilita sin ninguna garantia.                             "
 ? "                                                                            "

ElseIf (_nHlp = 1)

 Set Color To GR+/N
 ? "Syntax:  shash [-Options] [File/String]                                     "
 ? "                                                                            "
 ? "         File/String:  File Name  or  String Characters  to be  processed in"
 ? "                       Secured-Hash software.                               "
 ? "                                                                            "

 Set Color To R+/N
 ? "Options:                                                                    "
 ? "                                                                            "

 Set Color To GR+/N
 ? "-m : Generates new Hash for specified File Name or String Characters.       "

 Set Color To B+/N
 ? "     shash -m [-n] [-p:password] File/String   ; Creates Hash.              "
 ? "     shash -ms [-n] [-p:password] File         ; Creates Hash with File.    "

 Set Color To GR+/N
 ? "-c : Checks  the  Hash  for  specified File Name or String Characters.  This"
 ? "     option can also be used to check a generated Hash string.              "

 Set Color To B+/N
 ? "     shash -c [-p:password] File/String/Hash-File/Hash-String               "

 Set Color To GR+/N
 ? "-x : Extracts the File stored into the Hash.                                "

 Set Color To B+/N
 ? "     shash -x [-p:password] Hash-File/Hash-String                           "

 Set Color To GR+/N
 ? "-n : Do not generate .SHash extension file when creating new Hash.          "
 ? "-p : Aphanumeric Password used with past options to process a Private Hash. "
 ? "                                                                            "

 Set Color To GR+/N
 ? "-h : Shows help for this program.                                           "

 Set Color To B+/N
 ? "     shash -h     ; Shows Spanish help.                                     "
 ? "     shash -hc    ; Creates shash-sp.txt file.                              "
 ? "     shash -he    ; Shows English help.                                     "
 ? "     shash -hec   ; Creates shash-en.txt file.                              "
 ? "                                                                            "
 ? "                                                                            "

 Set Color To R+/N
 ? "Developer notes:                                                            "
 ? "                                                                            "

 Set Color To GR+/N
 ? "Secured-Hash Free  has  been  created from  two  professional projects:  PSA"
 ? "Encryption Algorithm,  #01 and #02 Modules.  These  original projects  gives"
 ? "best security and generates fewer Hash string in lenght.                    "
 ? "                                                                            "
 ? "Hash Function's Features:                                                   "
 ? "- Can codify information from FileName or String.                           "
 ? "- Stored information includes Date, Time, FileName or String, and CheckSum. "
 ? "- All Hash information are encrypted.                                       "
 ? "- Generated Hash can store specified FileName into itself.                  "
 ? "- Hash's CheckSum does not reveal true lenght from FileName or String.      "
 ? "- Generated Hash could be Public Hash or password protected Private Hash.   "
 ? "                                                                            "
 ? "Offering open-source software  to  developer's community  is good for giving"
 ? "help  to  anybody who wants  to  learn programming,  and  for  checking that"
 ? "software  does not  cause  lost data  in computers running it.  By the other"
 ? "hand,  accessing open-source software does not give original developers many"
 ? "opportunities to get a dignified, honestly and happy future.                "
 ? "                                                                            "
 ? "This project has been created using  Harbour Compiler 3.0.  It does not have"
 ? "any limitations that prevents to create itself using another compilers.     "
 ? "                                                                            "
 ? "https://github.com/PsaCrypt/Secured-Hash                                    "
 ? "                                                                            "
 ? "This software is provided without any warranty.                             "
 ? "                                                                            "

EndIf

 ? ""
 Set Color To W+/N
 Set Alternate Off
 Close Alternate
 Quit

 Return (Nil)

