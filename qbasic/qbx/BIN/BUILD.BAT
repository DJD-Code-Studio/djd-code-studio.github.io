@echo off
if exist c:\bc7\bin\build.$$$ goto delit
echo BUILD has been run once and it can not be re-run.
echo Please run SETUP again.
goto done
:delit
del c:\bc7\bin\build.$$$
c:
cd c:\bc7\lib
if exist proisamd.lib del proisamd.lib 
c:\bc7\binb\lib.exe @.\b2. 
if exist .\b2. del .\b2. 
if exist proisamd.bak del proisamd.bak 
c:\bc7\binb\link.exe @.\b3. 
if exist .\b3. del .\b3. 
c:\bc7\binb\link.exe @.\b4. 
if exist .\b4. del .\b4. 
c:\bc7\binb\link.exe @.\b5. 
if exist .\b5. del .\b5. 
c:\bc7\binb\link.exe @.\b6. 
if exist .\b6. del .\b6. 
c:\bc7\binb\link.exe @.\b7. 
if exist .\b7. del .\b7. 
c:\bc7\binb\link.exe @.\b8. 
if exist .\b8. del .\b8. 
c:\bc7\binb\link.exe @.\b9. 
if exist .\b9. del .\b9. 
c:\bc7\binb\link.exe @.\b10. 
if exist .\b10. del .\b10. 
c:\bc7\binb\link.exe @.\b11. 
if exist .\b11. del .\b11. 
c:\bc7\binb\link.exe @.\b12. 
if exist .\b12. del .\b12. 
if exist bcl71afr.lib del bcl71afr.lib 
c:\bc7\binb\lib.exe @.\b13. 
if exist .\b13. del .\b13. 
if exist bcl71anr.lib del bcl71anr.lib 
c:\bc7\binb\lib.exe @.\b14. 
if exist .\b14. del .\b14. 
if exist bcl71efr.lib del bcl71efr.lib 
c:\bc7\binb\lib.exe @.\b15. 
if exist .\b15. del .\b15. 
if exist bcl71enr.lib del bcl71enr.lib 
c:\bc7\binb\lib.exe @.\b16. 
if exist .\b16. del .\b16. 
if exist dtfmter.lib del dtfmter.lib 
c:\bc7\binb\lib.exe @.\b17. 
if exist .\b17. del .\b17. 
if exist dtfmtar.lib del dtfmtar.lib 
c:\bc7\binb\lib.exe @.\b18. 
if exist .\b18. del .\b18. 
c:\bc7\binb\buildrtm.exe  /Lr /FPa /fs /Tc:\bc7\binb /D .\b19. 
copy brt71afr.exe c:\bc7\bin 
del brt71afr.exe
if exist .\b19. del .\b19. 
c:\bc7\binb\buildrtm.exe  /Lr /FPi /fs /Tc:\bc7\binb /D .\b20. 
copy brt71efr.exe c:\bc7\bin 
del brt71efr.exe
if exist .\b20. del .\b20. 
c:\bc7\binb\buildrtm.exe  /Lr /FPa /ns /Tc:\bc7\binb /D .\b21. 
copy brt71anr.exe c:\bc7\bin 
del brt71anr.exe
if exist .\b21. del .\b21. 
c:\bc7\binb\buildrtm.exe  /Lr /FPi /ns /Tc:\bc7\binb /D .\b22. 
copy brt71enr.exe c:\bc7\bin 
del brt71enr.exe
if exist .\b22. del .\b22. 
c:
cd c:\bc7\src
if exist c:\bc7\lib\fontbenr.lib del c:\bc7\lib\fontbenr.lib 
c:\bc7\binb\bc.exe /o /x /ah /fpi /lr fontb.bas,fontbenr.obj; 
c:\bc7\binb\lib.exe @.\b23. 
if exist .\b23. del .\b23. 
if exist fontbenr.obj del fontbenr.obj 
if exist c:\bc7\lib\fontbefr.lib del c:\bc7\lib\fontbefr.lib 
c:\bc7\binb\bc.exe /o /x /ah /fpi /fs /lr fontb.bas,fontbefr.obj; 
c:\bc7\binb\lib.exe @.\b24. 
if exist .\b24. del .\b24. 
if exist fontbefr.obj del fontbefr.obj 
if exist c:\bc7\lib\fontbanr.lib del c:\bc7\lib\fontbanr.lib 
c:\bc7\binb\bc.exe /o /x /ah /fpa /lr fontb.bas,fontbanr.obj; 
c:\bc7\binb\lib.exe @.\b25. 
if exist .\b25. del .\b25. 
if exist fontbanr.obj del fontbanr.obj 
if exist c:\bc7\lib\fontbafr.lib del c:\bc7\lib\fontbafr.lib 
c:\bc7\binb\bc.exe /o /x /ah /fpa /fs /lr fontb.bas,fontbafr.obj; 
c:\bc7\binb\lib.exe @.\b26. 
if exist .\b26. del .\b26. 
if exist fontbafr.obj del fontbafr.obj 
if exist c:\bc7\lib\fontbefr.qlb del c:\bc7\lib\fontbefr.qlb 
c:\bc7\binb\link.exe @.\b27. 
if exist .\b27. del .\b27. 
if exist c:\bc7\lib\chrtbenr.lib del c:\bc7\lib\chrtbenr.lib 
c:\bc7\binb\bc.exe /o /x /ah /fpi /lr chrtb.bas,chrtbenr.obj; 
c:\bc7\binb\lib.exe @.\b28. 
if exist .\b28. del .\b28. 
if exist chrtbenr.obj del chrtbenr.obj 
if exist c:\bc7\lib\chrtbefr.lib del c:\bc7\lib\chrtbefr.lib 
c:\bc7\binb\bc.exe /o /x /ah /fpi /fs /lr chrtb.bas,chrtbefr.obj; 
c:\bc7\binb\lib.exe @.\b29. 
if exist .\b29. del .\b29. 
if exist chrtbefr.obj del chrtbefr.obj 
if exist c:\bc7\lib\chrtbanr.lib del c:\bc7\lib\chrtbanr.lib 
c:\bc7\binb\bc.exe /o /x /ah /fpa /lr chrtb.bas,chrtbanr.obj; 
c:\bc7\binb\lib.exe @.\b30. 
if exist .\b30. del .\b30. 
if exist chrtbanr.obj del chrtbanr.obj 
if exist c:\bc7\lib\chrtbafr.lib del c:\bc7\lib\chrtbafr.lib 
c:\bc7\binb\bc.exe /o /x /ah /fpa /fs /lr chrtb.bas,chrtbafr.obj; 
c:\bc7\binb\lib.exe @.\b31. 
if exist .\b31. del .\b31. 
if exist chrtbafr.obj del chrtbafr.obj 
if exist c:\bc7\lib\chrtbefr.qlb del c:\bc7\lib\chrtbefr.qlb 
c:\bc7\binb\link.exe @.\b32. 
if exist .\b32. del .\b32. 
if exist c:\bc7\lib\uitbenr.lib del c:\bc7\lib\uitbenr.lib 
c:\bc7\binb\bc.exe /o /ah /fpi /lr mouse.bas,mouseenr.obj; 
c:\bc7\binb\bc.exe /o /ah /fpi /lr menu.bas,menuenr.obj; 
c:\bc7\binb\bc.exe /o /ah /fpi /lr window.bas,windoenr.obj; 
c:\bc7\binb\bc.exe /o /ah /fpi /lr general.bas,generenr.obj; 
c:\bc7\binb\lib.exe @.\b33. 
if exist .\b33. del .\b33. 
if exist mouseenr.obj del mouseenr.obj 
if exist menuenr.obj del menuenr.obj 
if exist windoenr.obj del windoenr.obj 
if exist generenr.obj del generenr.obj 
if exist c:\bc7\lib\uitbefr.lib del c:\bc7\lib\uitbefr.lib 
c:\bc7\binb\bc.exe /o /ah /fpi /fs /lr mouse.bas,mouseefr.obj; 
c:\bc7\binb\bc.exe /o /ah /fpi /fs /lr menu.bas,menuefr.obj; 
c:\bc7\binb\bc.exe /o /ah /fpi /fs /lr window.bas,windoefr.obj; 
c:\bc7\binb\bc.exe /o /ah /fpi /fs /lr general.bas,generefr.obj; 
c:\bc7\binb\lib.exe @.\b34. 
if exist .\b34. del .\b34. 
if exist mouseefr.obj del mouseefr.obj 
if exist menuefr.obj del menuefr.obj 
if exist windoefr.obj del windoefr.obj 
if exist generefr.obj del generefr.obj 
if exist c:\bc7\lib\uitbanr.lib del c:\bc7\lib\uitbanr.lib 
c:\bc7\binb\bc.exe /o /ah /fpa /lr mouse.bas,mouseanr.obj; 
c:\bc7\binb\bc.exe /o /ah /fpa /lr menu.bas,menuanr.obj; 
c:\bc7\binb\bc.exe /o /ah /fpa /lr window.bas,windoanr.obj; 
c:\bc7\binb\bc.exe /o /ah /fpa /lr general.bas,generanr.obj; 
c:\bc7\binb\lib.exe @.\b35. 
if exist .\b35. del .\b35. 
if exist mouseanr.obj del mouseanr.obj 
if exist menuanr.obj del menuanr.obj 
if exist windoanr.obj del windoanr.obj 
if exist generanr.obj del generanr.obj 
if exist c:\bc7\lib\uitbafr.lib del c:\bc7\lib\uitbafr.lib 
c:\bc7\binb\bc.exe /o /ah /fpa /fs /lr mouse.bas,mouseafr.obj; 
c:\bc7\binb\bc.exe /o /ah /fpa /fs /lr menu.bas,menuafr.obj; 
c:\bc7\binb\bc.exe /o /ah /fpa /fs /lr window.bas,windoafr.obj; 
c:\bc7\binb\bc.exe /o /ah /fpa /fs /lr general.bas,generafr.obj; 
c:\bc7\binb\lib.exe @.\b36. 
if exist .\b36. del .\b36. 
if exist mouseafr.obj del mouseafr.obj 
if exist menuafr.obj del menuafr.obj 
if exist windoafr.obj del windoafr.obj 
if exist generafr.obj del generafr.obj 
if exist c:\bc7\lib\uitbefr.qlb del c:\bc7\lib\uitbefr.qlb 
c:\bc7\binb\link.exe @.\b37. 
if exist .\b37. del .\b37. 
if exist c:\bc7\lib\matbenr.lib del c:\bc7\lib\matbenr.lib 
c:\bc7\binb\bc.exe /o /e /ah /fpi /lr matb.bas,matbenr.obj; 
c:\bc7\binb\lib.exe @.\b38. 
if exist .\b38. del .\b38. 
if exist matbenr.obj del matbenr.obj 
if exist c:\bc7\lib\matbefr.lib del c:\bc7\lib\matbefr.lib 
c:\bc7\binb\bc.exe /o /e /ah /fpi /fs /lr matb.bas,matbefr.obj; 
c:\bc7\binb\lib.exe @.\b39. 
if exist .\b39. del .\b39. 
if exist matbefr.obj del matbefr.obj 
if exist c:\bc7\lib\matbanr.lib del c:\bc7\lib\matbanr.lib 
c:\bc7\binb\bc.exe /o /e /ah /fpa /lr matba.bas,matbanr.obj; 
c:\bc7\binb\lib.exe @.\b40. 
if exist .\b40. del .\b40. 
if exist matbanr.obj del matbanr.obj 
if exist c:\bc7\lib\matbafr.lib del c:\bc7\lib\matbafr.lib 
c:\bc7\binb\bc.exe /o /e /ah /fpa /fs /lr matba.bas,matbafr.obj; 
c:\bc7\binb\lib.exe @.\b41. 
if exist .\b41. del .\b41. 
if exist matbafr.obj del matbafr.obj 
if exist c:\bc7\lib\matbefr.qlb del c:\bc7\lib\matbefr.qlb 
c:\bc7\binb\link.exe @.\b42. 
if exist .\b42. del .\b42. 
if exist c:\bc7\lib\dtfmter.qlb del c:\bc7\lib\dtfmter.qlb 
c:\bc7\binb\link.exe @.\b43. 
if exist .\b43. del .\b43. 
if exist c:\bc7\lib\financer.qlb del c:\bc7\lib\financer.qlb 
c:\bc7\binb\link.exe @.\b44. 
if exist .\b44. del .\b44. 
if exist c:\bc7\lib\b71isdup.obj del c:\bc7\lib\b71isdup.obj 
if exist c:\bc7\lib\b71isscp.obj del c:\bc7\lib\b71isscp.obj 
if exist c:\bc7\lib\dtfmtobj.lib del c:\bc7\lib\dtfmtobj.lib 
if exist c:\bc7\lib\dtfmtobe.lib del c:\bc7\lib\dtfmtobe.lib 
if exist c:\bc7\lib\dtfmtoba.lib del c:\bc7\lib\dtfmtoba.lib 
if exist c:\bc7\lib\dtfmtore.lib del c:\bc7\lib\dtfmtore.lib 
if exist c:\bc7\lib\dtfmtora.lib del c:\bc7\lib\dtfmtora.lib 
if exist c:\bc7\lib\b71isd.lib del c:\bc7\lib\b71isd.lib 
if exist c:\bc7\lib\b71is.lib del c:\bc7\lib\b71is.lib 
if exist c:\bc7\lib\b71isstd.lib del c:\bc7\lib\b71isstd.lib 
if exist c:\bc7\lib\b71isdut.obj del c:\bc7\lib\b71isdut.obj 
if exist c:\bc7\lib\b71issca.obj del c:\bc7\lib\b71issca.obj 
if exist c:\bc7\lib\b71isspa.obj del c:\bc7\lib\b71isspa.obj 
if exist c:\bc7\lib\b71isamd.lib del c:\bc7\lib\b71isamd.lib 
if exist c:\bc7\lib\b71isam.lib del c:\bc7\lib\b71isam.lib 
if exist c:\bc7\lib\b71isspp.obj del c:\bc7\lib\b71isspp.obj 
if exist c:\bc7\lib\isamcvt.lib del c:\bc7\lib\isamcvt.lib 
if exist c:\bc7\lib\isampack.lib del c:\bc7\lib\isampack.lib 
if exist c:\bc7\lib\isamio.lib del c:\bc7\lib\isamio.lib 
if exist c:\bc7\lib\b71isc.lib del c:\bc7\lib\b71isc.lib 
if exist c:\bc7\lib\b71iscr.lib del c:\bc7\lib\b71iscr.lib 
if exist c:\bc7\lib\proisamt.lib del c:\bc7\lib\proisamt.lib 
if exist c:\bc7\lib\isamrepr.lib del c:\bc7\lib\isamrepr.lib 
c:
cd c:\bc7\bin
:done 
