#!/bin/bash
################################################################################
# echo wrappers
INFO(){ echo -n "INFO: "; echo "$@" ;}
WARN(){ echo -n "WARN: "; echo "$@" ;}
ERRO(){ echo -n "ERRO: "; echo -n "$@" ; echo " Abort!"; exit 1;}

PREFIX="/"
case $1 in
    PREFIX=*) PREFIX="${1//PREFIX=/}";;
esac

cd "$(dirname $0)" || exit 1
if [ "$PREFIX" == "/" ]; then
    if [ "$UID" != "0" ]; then
        [ ! -f /usr/bin/sudo ] && ERRO "Run by root or install sudo!"
        SUDO=sudo
    else
        unset SUDO
    fi
fi

$SUDO install -Dm644 ./leagueoflegends.conf     $PREFIX/etc/leagueoflegends.conf
$SUDO install -Dm755 ./leagueoflegends          $PREFIX/usr/bin/leagueoflegends
$SUDO install -Dm644 ./leagueoflegends.png      $PREFIX/usr/share/icons/hicolor/48x48/apps/leagueoflegends.png

$SUDO mkdir -p $PREFIX/usr/share/applications/
{
    echo "[Desktop Entry]"
    echo Name=League Of Legends
    echo Comment=League Of Legends Game
    echo Type=Application
    echo Exec=leagueoflegends
    echo Icon=leagueoflegends
} | $SUDO tee $PREFIX/usr/share/applications/leagueoflegends.desktop