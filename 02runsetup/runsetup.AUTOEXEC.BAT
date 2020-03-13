REM This file is to kick off the Windows 95 installation.

C:
CD WIN95

REM /C  Do not load SmartDrive disk cache
REM /d  Do not use existing versions of Windows
REM /id Do not check for disk space
REM /im Do not check for RAM
REM /is Do not run ScanDisk, starting in Windows
REM /iq Do not run ScanDisk, starting in DOS
REM /IW Supposedly to suppress EULA
REM /IV Supposedly to suppress various dialogs

SETUP.EXE /C /d /id /im /is /iq /IW /IV MSBATCH.INF
