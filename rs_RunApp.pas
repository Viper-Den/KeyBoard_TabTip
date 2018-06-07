unit rs_RunApp;

interface


uses Windows,
     SysUtils,
     VCL.Forms;



procedure RunAppDeskLockWait(Appl: String; Parametrs: String);
Procedure ShutDownWindows;


implementation




procedure RunAppDeskLockWait(Appl: String; Parametrs: String);
var
  si: STARTUPINFO;
  pi: PROCESS_INFORMATION;
  cmdline: string;
begin
  if not FileExists(Appl) then
    Exit;
  try
    ZeroMemory(@si,sizeof(si));
    si.cb := SizeOf(si);
    ChDir(ExtractFilePath(Appl));
    cmdline := ExtractFilename(Appl);
    if CreateProcess(nil,
      PChar(AnsiQuotedStr(ExpandFileName(Appl), '"') + ' ' + Parametrs),
      nil, nil, False, 0, nil, nil, si, pi)
   then
    try
      repeat
        Sleep(5);
        Application.ProcessMessages;
      until WaitForSingleObject(pi.hProcess, 1) <> WAIT_TIMEOUT;
    finally
      CloseHandle(pi.hProcess);
      CloseHandle(pi.hThread);
    end;
  finally

  end;
end;


function GetWinVersion: string;
var
  VersionInfo: TOSVersionInfo;
  OSName: string;
begin
  VersionInfo.dwOSVersionInfoSize := SizeOf( TOSVersionInfo );
  if Windows.GetVersionEx( VersionInfo ) then
  begin
    with VersionInfo do
    begin
      case dwPlatformId of
        VER_PLATFORM_WIN32s: OSName := 'Win32s';
        VER_PLATFORM_WIN32_WINDOWS: OSName := 'Windows 95';
        VER_PLATFORM_WIN32_NT: OSName := 'Windows NT';
      end; // case dwPlatformId
      Result := OSName + ' Version ' + IntToStr( dwMajorVersion ) + '.' + IntToStr( dwMinorVersion ) +
      #13#10' (Build ' + IntToStr( dwBuildNumber ) + ': ' + szCSDVersion + ')';
    end; // with VersionInfo
  end // if GetVersionEx
  else
  Result := '';
end;


Procedure ShutDownWindows;
const
  SE_SHUTDOWN_NAME = 'SeShutdownPrivilege'; // Borland forgot this declaration
Var
  hToken: THandle;
  tkp: TTokenPrivileges;
  tkpo: TTokenPrivileges;
  zero: DWORD;

begin
  if Pos('Windows NT', GetWinVersion) = 1 then
  begin
    zero := 0;
    if not OpenProcessToken(GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, hToken) then Exit;

    // SE_SHUTDOWN_NAME
    if not LookupPrivilegeValue( nil, 'SeShutdownPrivilege' , tkp.Privileges[0].Luid ) then Exit;
    tkp.PrivilegeCount := 1;
    tkp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;

    AdjustTokenPrivileges(hToken, False, tkp, SizeOf( TTokenPrivileges ), tkpo, zero);
    if Boolean(GetLastError()) then Exit else ExitWindowsEx( EWX_FORCE or EWX_LOGOFF, 0 );
  end
  else ExitWindowsEx( EWX_FORCE or EWX_LOGOFF, 0 );
end;

end.
