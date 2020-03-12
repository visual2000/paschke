REM This file is to kick off partitioning and formatting of HDD.

REM FDISK.BAT will touch a file called FDISKING.TXT, so if it
REM exists, we can skip this step.
IF NOT EXIST FDISKING.TXT FDISK.BAT

IF EXIST FDISKING.TXT FORMAT.BAT
