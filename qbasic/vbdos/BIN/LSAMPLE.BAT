@echo off

REM   Refer to the Professional Features Guide for
REM   more information on this batch file and its usage.

echo Microsoft Source Profiler LSAMPLE batch file.
echo Sampled line profiling with timing information.

prep /ls /p %1.exe /ot %1.pbt /oi %1.pbi
profile /S 2000 %1 %2 %3 %4 %5 %6 %7 %8 %9
prep /it %1.pbt /io %1.pbo /ot %1.pbt
plist /sl %1.pbt > %1.out
del %1.pbo
del %1.pbi
