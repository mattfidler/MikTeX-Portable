CRCCheck On
RequestExecutionLevel user

; Best Compression
SetCompress Auto
SetCompressor /SOLID lzma
SetCompressorDictSize 32
SetDatablockOptimize On
;SetCompress off
Icon "..\..\App\Appinfo\miktex.ico"


; MUI2
!include "MUI2.nsh"
!include "FileFunc.nsh"
Name "MikTeX Portable"
BrandingText "MikTeX Portable"

!define MUI_ICON "..\..\App\Appinfo\miktex.ico"

;automatically close the installer when done.
AutoCloseWindow true
!define MUI_HEADERIMAGE

!define MUI_PAGE_HEADER_TEXT "MikTeX Portable"
!define MUI_PAGE_HEADER_SUBTEXT "MikTeX on the Go"

OutFile "..\..\..\MikTeXPortable-2.9-Installer.exe"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_LANGUAGE "English"

Section "MikTeX Portable" sec_miktex_portable ; Checked
  ; Description:
  ; MikTeX Portable
  SetOutPath "$INSTDIR"
  RmDir /r "$INSTDIR"
  File "..\..\*.exe"
  File /r "..\..\App"
  File /r "..\..\Other"
  File /r "..\..\README.org"
SectionEnd ; sec_miktex_portable

Var PA
Function GetDriveVars
  StrCmp $9 "c:\" spa
  StrCmp $8 "HDD" gpa
  StrCmp $9 "a:\" spa
  StrCmp $9 "b:\" spa
  
  gpa:
    IfFileExists "$9PortableApps" 0 spa
    StrCpy $PA "$9PortableApps"
  spa:
    Push $0
    
FunctionEnd

Function .onInit  
   StrCpy $PA ""
  ${GetDrives} "FDD+HDD" "GetDriveVars"
  StrCpy $INSTDIR "$PA\MikTeXPortable"
FunctionEnd

Function .onGUIEnd
  RmDir /r $PLUGINSDIR
FunctionEnd

;--------------------------------
;Description(s)
LangString DESC_sec_miktex_portable ${LANG_ENGLISH} "MikTeX Portable"
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${sec_miktex_portable} $(DESC_sec_miktex_portable)
!insertmacro MUI_FUNCTION_DESCRIPTION_END
