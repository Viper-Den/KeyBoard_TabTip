unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  reg_ActiveKeyBoard_TabTip, rs_RunApp, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    btnShow: TButton;
    btnHide: TButton;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    btnLogOff: TButton;
    Button3: TButton;
    procedure btnShowClick(Sender: TObject);
    procedure btnHideClick(Sender: TObject);
    procedure btnLogOffClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnHideClick(Sender: TObject);
begin
  TActiveKeyBoard.Close;
end;

procedure TForm1.btnLogOffClick(Sender: TObject);
begin
  ShutDownWindows;
end;

procedure TForm1.btnShowClick(Sender: TObject);
begin
  TActiveKeyBoard.Show;
end;

procedure TForm1.Button1Click(Sender: TObject);
var Appl: string;
begin
  Appl := 'C:\Program Files\Common Files\microsoft shared\ink\TabTip.exe';
  RunAppDeskLockWait(Appl,'');
end;

procedure TForm1.Button3Click(Sender: TObject);
var Appl: string;
begin
  Appl := 'c:\\Windows\\notepad.exe';
  RunAppDeskLockWait(Appl,'');
end;

end.
