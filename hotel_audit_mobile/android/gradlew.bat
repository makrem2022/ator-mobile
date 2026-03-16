@ECHO OFF
SETLOCAL

SET SCRIPT_DIR=%~dp0
SET WRAPPER_JAR=%SCRIPT_DIR%gradle\wrapper\gradle-wrapper.jar

IF EXIST "%WRAPPER_JAR%" (
  java -classpath "%WRAPPER_JAR%" org.gradle.wrapper.GradleWrapperMain %*
  EXIT /B %ERRORLEVEL%
)

where gradle >NUL 2>&1
IF %ERRORLEVEL% EQU 0 (
  ECHO gradle-wrapper.jar is missing; falling back to system gradle. 1>&2
  gradle %*
  EXIT /B %ERRORLEVEL%
)

ECHO Error: gradle-wrapper.jar is missing and no system gradle command is available. 1>&2
ECHO Run this project through Flutter tooling or provide a Gradle installation. 1>&2
EXIT /B 1
