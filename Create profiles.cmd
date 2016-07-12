ECHO OFF
CLS

IF "%~1" NEQ "" (
    IF "%~2" NEQ "" (
        SET Leveling=%~1
        SET PEIPlate=%~2
        GOTO GENERATE
    )
)

:MENU
ECHO.
ECHO BigBox S3D Profile Builder
ECHO.
ECHO Select your leveling mechanism:
ECHO.
ECHO 1 - ABL (auto bed leveling)
ECHO 2 - MBL (mesh/manual bed leveling)
ECHO.
SET /P M=Type 1 or 2 then press ENTER:
IF %M%==1 SET Leveling=ABL
IF %M%==2 SET Leveling=MBL

ECHO.
ECHO.
ECHO Do you have a PEI build plate?
ECHO.
ECHO 1 - No
ECHO 2 - Yes
ECHO.
SET /P M=Type 1 or 2 then press ENTER:
IF %M%==1 SET PEIPlate=0
IF %M%==2 SET PEIPlate=1

:GENERATE
ECHO.
ECHO Generating profiles...

for %%i in (*.xsl) do .\bin\Transform.exe ".\profiles\BigBox Base.fff" "%%i" "Leveling=%Leveling%" "PEIPlate=%PEIPlate%"

ECHO.
ECHO Profiles generated!