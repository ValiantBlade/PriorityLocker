# PriorityLocker
A simple PowerShell script to lock and unlock something at high priority.

The Batch files REQUIRE admin access

This is because the PowerShell files create registry keys in HKEY_LOCAL_MACHINE, which always requires admin access. No HKEY_CURRENT_USER equivalent that I know of.

REQUIREMENTS: .NET Framework (I am actually unsure of which version PowerShell in particular calls, if anyone knows, please tell me).

INSTRUCTIONS: Run the batch file as Administrator, and enter the full EXE name, including extension, into the field.

All the batch files do is run PowerShell to run an elevated PowerShell window, and the PowerShell scripts are commented.
