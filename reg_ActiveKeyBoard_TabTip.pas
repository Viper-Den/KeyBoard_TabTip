unit reg_ActiveKeyBoard_TabTip;

interface

uses System.Classes, System.SysUtils,
     VCL.Forms,
     ShellAPI,
     Winapi.Windows, Winapi.Messages;

type

TActiveKeyBoard = class
  private
    class function ExpandEnvironmentVar(var Value: string): Boolean;

  public
    class function Close: boolean;
    class function Show: boolean;
end;

implementation





class function TActiveKeyBoard.Close: boolean;
var
  MyHandle1: THandle;
begin
  Result := False;
  MyHandle1 := FindWindow('IPTip_Main_Window', nil);

  if MyHandle1 <> 0 then
  begin
    PostMessage(MyHandle1, WM_SYSCOMMAND, SC_CLOSE, 0);
    Result := True;
  end;
end;

class function TActiveKeyBoard.Show: boolean;
var
  S: string;
begin
  Result := False;
  Close;
  try
    S := '%CommonProgramW6432%\microsoft shared\ink\tabtip.exe';
    ExpandEnvironmentVar(S);
    ShellExecute(0, PChar('open'), PChar(S), nil, nil, SW_SHOWNORMAL);
    Result := True;
  except
    on E: Exception do
    begin
      Application.MessageBox(PChar(E.Message),
      PChar(Application.Title),
      MB_OK or MB_ICONERROR);
    end;
  end;
end;



class function TActiveKeyBoard.ExpandEnvironmentVar(var Value: string): Boolean;
var
  R: Integer;
  Expanded: string;

procedure StrResetLength(var S: string);
  var
    I: Integer;
  begin
    for I := 0 to Length(S) - 1 do
      if S[I + 1] = #0 then
      begin
        SetLength(S, I);
        Exit;
      end;
  end;

begin
  SetLength(Expanded, 1);
  R := ExpandEnvironmentStrings(PChar(Value), PChar(Expanded), 0);
  SetLength(Expanded, R);
  Result := ExpandEnvironmentStrings(PChar(Value), PChar(Expanded), R) <> 0;
  if Result then
  begin
    StrResetLength(Expanded);
    Value := Expanded;
  end;
end;

end.
