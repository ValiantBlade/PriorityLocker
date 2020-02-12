# PriorityLocker
A simple PowerShell script to lock something at high priority.

The Batch files REQUIRE admin access

This is because the PowerShell files create registry keys in HKEY_LOCAL_MACHINE, which always requires admin access.

REQUIREMENTS: .NET Framework
(I am actually unsure of which version PowerShell in particular calls, if anyone knows, please tell me).

INSTRUCTIONS: Run the batch file as Administrator, and enter the full EXE name, including extension, into the field.
