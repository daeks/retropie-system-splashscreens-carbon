@echo off

SET ICONVERT=C:\imagemagick\iconvert.exe
SET THEME=C:\temp\carbon
SET BACKGROUND=%THEME%\art\carbon_fiber.png
REM SET BACKGROUND=%THEME%\art\carbon_black.png
SET FONT=%THEME%\art\Cabin-Bold.ttf

IF EXIST "%THEME%\_OUTPUT" DEL /Q "%THEME%\_OUTPUT"

FOR /R "%THEME%" %%G IN (*.svg) DO (
  IF NOT EXIST "%%~dpG%%~nG.png" echo "Converting image %%~dpnG"
  REM CONVERT SVG TO PNG
  IF NOT EXIST "%%~dpG%%~nG.png" "%ICONVERT%" -background none -resize "x235>" -resize "600x>" "%%G" "%%~dpG%%~nG.png"
)
FOR /D %%i IN ("%THEME%\*.*") DO (
  IF EXIST "%THEME%\%%~ni\art\system.png" echo "Creating launching image for %%~dpni"
  REM MERGE IMAGE 
  IF EXIST "%THEME%\%%~ni\art\system.png" "%ICONVERT%" -size 800x600 tile:"%BACKGROUND%" -gravity center "%THEME%\%%~ni\art\system.png" -geometry -0-100 -composite "%%~dpni\launching.png"
  REM ADD "NOW LOADING" 
  IF EXIST "%THEME%\%%~ni\launching.png" "%ICONVERT%" "%THEME%\%%~ni\launching.png" -gravity center -font "%FONT%" -weight 700 -pointsize 28 -fill white -annotate +0+120 "NOW LOADING" "%THEME%\%%~ni\launching.png"
  REM ADD "PRESS BUTTON TO CONFIGURE"
  IF EXIST "%THEME%\%%~ni\launching.png" "%ICONVERT%" "%THEME%\%%~ni\launching.png" -gravity center -font "%FONT%" -weight 700 -pointsize 14 -fill gray -annotate +0+200 "PRESS A BUTTON TO CONFIGURE\nLAUNCH OPTIONS" "%THEME%\%%~ni\launching.png"
  REM COMPRESS PNG
  IF EXIST "%THEME%\%%~ni\launching.png" "%ICONVERT%" "%THEME%\%%~ni\launching.png" -quality 80 "%THEME%\%%~ni\launching.png"
)

IF EXIST "%THEME%\_OUTPUT" DEL /Q "%THEME%\_OUTPUT"
MKDIR "%THEME%\_OUTPUT"
FOR /D %%i IN ("%THEME%\*.*") DO (
  IF EXIST "%THEME%\%%~ni\launching.png" MKDIR "%THEME%\_OUTPUT\%%~ni"
  MOVE "%THEME%\%%~ni\launching.png" "%THEME%\_OUTPUT\%%~ni"
)