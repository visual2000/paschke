REM This file is to "record" we're about to FDISK, and then do FDISK.

REM Create a marker file that we've been here.
COPY NUL>FDISKING.TXT

REM Do the partitioning.
FDISK < FDISK.SCP
