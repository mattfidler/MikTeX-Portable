SetCompress Auto
SetCompressor /SOLID lzma
SetCompressorDictSize 32
SetDatablockOptimize On
SilentInstall Silent
AutoCloseWindow True
RequestExecutionLevel user
OutFile "..\..\YapPortable.exe"
Icon "..\..\App\AppInfo\yap.ico"

!include "FileFunc.nsh"
!insertmacro GetParameters

!macro _PathIfExist ARG1
  DetailPrint "Checking for ${ARG1}"
  StrCpy $9 ""
  IfFileExists "${ARG1}" 0 +4
  System::Call 'Kernel32::GetEnvironmentVariable(t , t, i) i("PATH", .r0, ${NSIS_MAX_STRLEN}).r1'
  System::Call 'Kernel32::SetEnvironmentVariableA(t, t) i("PATH", "${ARG1};$0").r3'
  StrCpy $9 "1"
!macroend
!define PathIfExists '!insertmacro "_PathIfExist"'


Section "Main" sec_main ; Checked
  ; Description:
  ; Main Section for GvEdit Launch
  IfFileExists "$EXEDIR\App\MikTeX\miktex\bin\miktex-taskbar-icon.exe" 0 not_found
  FindProcDLL::FindProc "miktex-taskbar-icon.tmp"
  StrCmp "1" "$R0" run
  launch:
    Exec "$EXEDIR\App\MikTeX\miktex\bin\miktex-taskbar-icon.exe"
    Goto starttexworks
  run:
    Goto starttexworks
  not_found:
    MessageBox MB_OK "Could not find miktex-taskbar-icon.exe Installation corrupt."
    Goto end
  starttexworks:
    ${PathIfExists} $EXEDIR\App\MikTeX\miktex\bin
    System::Call 'Kernel32::SetEnvironmentVariableA(t, t) i("MIKTEX_BINDIR, "$EXEDIR\App\MikTeX\miktex\bin").r3'
    System::Call 'Kernel32::SetEnvironmentVariableA(t, t) i("MIKTEX_COMMONSTARTUPFILE, "$EXEDIR\App\MikTeX\miktex\config\miktexstartup.ini").r3'
    System::Call 'Kernel32::SetEnvironmentVariableA(t, t) i("MIKTEX_USERSTARTUPFILE", "$EXEDIR\App\MikTeX\miktex\config\miktexstartup.ini").r3'
    System::Call 'Kernel32::SetEnvironmentVariableA(t, t) i("TEXMFMAIN", "$EXEDIR\App\MikTeX\miktex").r3'
    System::Call 'Kernel32::SetEnvironmentVariableA(t, t) i("TEXSYSTEM", "miktex").r3'
    ${GetParameters} $R1
    Exec "$EXEDIR\App\MikTeX\miktex\bin\yap.exe $R1"
  end:
    #
  SectionEnd ; sec_main
  
