@echo off

SET ICONVERT=D:\system\imagemagick\iconvert.exe
SET THEME=D:\temp\carbon

FOR /R "%THEME%" %%G IN (*.svg) DO (
  IF NOT EXIST "%%~dpG%%~nG.png" echo "Converting image %%~dpnG"
  IF NOT EXIST "%%~dpG%%~nG.png" "%ICONVERT%" -background none "%%G" "%%~dpG%%~nG.png"
)
FOR /D %%i IN ("%THEME%\*.*") DO (
  IF EXIST "%THEME%\%%~ni\art\system.png" echo "Creating launching image for %%~dpni"
  IF EXIST "%THEME%\%%~ni\art\system.png" "%ICONVERT%" -size 800x600 tile:"%THEME%\art\carbon_fiber.png" -gravity center "%THEME%\%%~ni\art\system.png" -composite "%%~dpni\launching.png"
  IF EXIST "%THEME%\%%~ni\launching.png" "%ICONVERT%" "%THEME%\%%~ni\launching.png" -gravity center -weight 900 -pointsize 24 -fill white -annotate +0+140 "NOW LOADING" "%THEME%\%%~ni\launching.png"
  IF EXIST "%THEME%\%%~ni\launching.png" "%ICONVERT%" "%THEME%\%%~ni\launching.png" -gravity center -weight 700 -pointsize 14 -fill gray -annotate +0+200 "PRESS A BUTTON TO CONFIGURE\nLAUNCH OPTIONS" "%THEME%\%%~ni\launching.png"
)