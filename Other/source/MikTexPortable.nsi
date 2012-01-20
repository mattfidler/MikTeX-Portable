SetCompress Auto
SetCompressor /SOLID lzma
SetCompressorDictSize 32
SetDatablockOptimize On
SilentInstall Silent
AutoCloseWindow True
RequestExecutionLevel user
OutFile "..\..\MikTeXPortable.exe"
Icon "..\..\App\AppInfo\miktex.ico"

!macro _PathIfExist ARG1
  DetailPrint "Checking for ${ARG1}"
  StrCpy $9 ""
  IfFileExists "${ARG1}" 0 +4
  System::Call 'Kernel32::GetEnvironmentVariable(t , t, i) i("PATH", .r0, ${NSIS_MAX_STRLEN}).r1'
  System::Call 'Kernel32::SetEnvironmentVariableA(t, t) i("PATH", "${ARG1};$0").r3'StrCpy $9 "1"
!macroend
!define PathIfExist '!insertmacro "_PathIfExist"'


Section "Main" sec_main ; Checked
  ; Description:
  ; Main Section for GvEdit Launch
  IfFileExists "$EXEDIR\App\MikTeX\miktex\bin\miktex-taskbar-icon.exe" 0 not_found
  FindProcDLL::FindProc "miktex-taskbar-icon.tmp"
  StrCmp "1" "$R0" run
  launch:
    Exec "$EXEDIR\App\MikTeX\miktex\bin\miktex-taskbar-icon.exe"
    Goto end
  run:
    Goto end
  not_found:
    MessageBox MB_OK "Could not find miktex-taskbar-icon.exe Installation corrupt."
  end:
  SectionEnd ; sec_main
  
  
