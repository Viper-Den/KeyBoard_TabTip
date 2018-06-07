program MyShell;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {Form1},
  rs_RunApp in 'rs_RunApp.pas',
  reg_ActiveKeyBoard_TabTip in 'reg_ActiveKeyBoard_TabTip.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
