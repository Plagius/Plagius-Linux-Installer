#!/usr/bin/env playonlinux-bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

POL_SetupWindow_Init

TITLE="Plagius"
Prefix="Plagius2"

POL_SetupWindow_presentation "$TITLE" "GH Software" "http://www.plagius.com" "Gustavo Hennig" "$Prefix"


POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$Prefix"
POL_Wine_PrefixCreate

# Installing mandatory dependencies
POL_Wine_InstallFonts
POL_Call POL_Install_corefonts
POL_Function_FontsSmoothRGB

POL_SetupWindow_message "Please, proceed with the IE8 installation on next screen (Next, Next, Next)..."
POL_Call POL_Install_ie8 --lang English
POL_Call POL_Install_mfc42
POL_Call POL_Install_dotnet35sp1


POL_System_TmpCreate "Plagius2"
 
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
 
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "Please select the installation file to run." "Plagius installation"
    INSTALLER="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    cd "$POL_System_TmpDir"
    POL_Download "http://www.plagius.com.br/downloads/SetupPlagiusProLatest.exe"
    INSTALLER="$POL_System_TmpDir/SetupPlagiusProLatest.exe"
fi



POL_SetupWindow_wait "Installation in progress." "Plagius installation"
POL_Wine "$INSTALLER"
 
POL_System_TmpDelete
 
POL_Shortcut "PlagiusDetector.exe" "Plagius"
 
POL_SetupWindow_Close
exit