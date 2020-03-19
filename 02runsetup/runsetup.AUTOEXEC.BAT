REM This file is to kick off the Windows 95 installation.

C:
CD WIN98

REM /C  Do not load SmartDrive disk cache
REM /d  Do not use existing versions of Windows
REM /id Do not check for disk space
REM /im Do not check for RAM
REM /is Do not run ScanDisk, starting in Windows
REM /iq Do not run ScanDisk, starting in DOS
REM /IW Supposedly to suppress EULA (Win 98 only?)
REM /IV Supposedly to suppress various dialogs (Win 98 only?)

REM much more here: https://web.archive.org/web/20170825133254/http://www.thpc.info/how/switches9x.html

REM /D     Bypasses usage of installed Windows configuration (ignores settings
REM        in existing SYSTEM.INI, WIN.INI etc).
REM /IC    Win98 boots without 16-bit real mode drivers. If "KeepRMDrivers=1"
REM        setting absent from the Registry, 16-bit drivers are commented out
REM        in Config.sys or Autoexec.bat.
REM /ICH   Keeps Scandisk window visible during Setup. Useful if Setup halts
REM        during Scandisk operation.
REM /ID    Bypasses check for the minimum disk space required to install Win98.
REM /IF    Performs quick Setup. Uses CacheFindFirst for filenames and speeds
REM        up DOS Setup. Verify for copied files is off.
REM /IN    Bypasses call the networking Setup software. Neither the networking
REM        software nor the Networking Wizard screens will be used.
REM /IP    Bypasses detection of undocumented plug and play devices.
REM /IR    Bypasses detection of system CMOS/BIOS and does not update Master
REM        Boot Record (MBR).
REM /IW    Bypasses display of License Agreement dialog box (uses uppercase).
REM /IX    Bypasses character set check. Allows usage of different codepages
REM        for DOS and Windows.
REM /IY    Bypasses language conflicts.
REM /M     Bypasses playing of Setup sounds (.WAV).
REM /N     Runs Setup without mouse support.
REM /NA    Bypasses Windows/MS-DOS program check. Valid values:
REM         0 = Default.
REM         1 = Windows programs not checked, MS-DOS programs blocked.
REM         2 = MS-DOS programs not checked, Windows programs blocked.
REM         3 = Windows and MS-DOS programs not checked.
REM /ND    Bypasses MIGRATION.DLL settings and forces Windows 98 to overwrite
REM        newer files (USE WITH CAUTION!). Files that use .INF file ",,,32"
REM        flag force Windows 98 SETUP to keep newer versions.
REM /NF    Bypasses prompt to remove floppy disk from the drive.
REM        Use this switch when installing Windows 98 from a bootable CD.
REM        It's the same as:
REM         1. BOOTCD file present in the cabinet folder, or
REM         2. "BootCD=1" line present in MSBATCH.INF.
REM /NH    Bypasses running HWINFO.EXE at 0 percent files and RunOnce.
REM /NM    Bypasses CPU detection (No Minimum) to allow Win9x/ME install on
REM        systems that do NOT meet Microsoft's minimum requirements.
REM /NR    Bypasses the Registry check.
REM /NTLDR Bypasses detection of an existing Operating System.
REM        OEM/VAR Win95/NT full releases can be installed ONLY on a new PC
REM        that does not contain ANY OS. This switch allows SETUP to
REM        circumvent this situation.
REM        It works ONLY IF you create a new file (any size) on the root
REM        directory of your boot drive (C:) and name it NTLDR without any
REM        file extension.
REM /NX    Bypasses SETUPX version check.
REM /it    Bypasses checking for "dirty" or "deadly" terminate-and-stay
REM        -resident programs (TSRs) known to cause problems with Setup.

SETUP.EXE /IC /ICH /ID /IF /IN /IP /M /NF /NM /NR /NX /C /D /IS /IW MSBATCH.INF
