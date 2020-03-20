@ECHO OFF
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

SETUP.EXE /C /d /is /IW MSBATCH.INF
