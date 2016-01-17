@echo on

echo ***************************************************************************
echo ** Montando Entorno de Compilacion de ARM                                **
echo ** Todas las tareas deben ejecutarse desde : X                           **
echo ***************************************************************************
call subst X: .
X:

call setEnv.bat

cd X:\MinGW\msys\1.0

call .\msys.bat

echo ************************ ENTORNO LEVANTADO *****************

