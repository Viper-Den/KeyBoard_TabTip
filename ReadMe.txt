Configure the shell

- Create a new user
	Settings> Accounts> Other Users> Add a user for this computer.
	Sign in - ShellTest

regEdit.exe
	HKEY_CURRENT_USER \ Software \ Microsoft \ Windows NT \ CurrentVersion \ Winlogon
	Shell C: \ Shell \ MyShell.exe