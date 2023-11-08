setlocal
:parse
    if "%~1"=="" GOTO endparse
    if "%~1"=="--ref" (set _REF=%~2)
    shift
    GOTO parse
:endparse

echo BRANCH_SCRIPT=%_REF% >> %GITHUB_ENV%
echo branch=%_REF% >> %GITHUB_OUTPUT%
endlocal
