#! /usr/bin/env sh

UHOME=/home/user
XSOCK=/tmp/.X11-unix
MKK_APPDIR="drive_c/users/user/Application Data/Mikrotik"

if [ -n ${WINEPREFIX} ]; then
    WINEPREFIX=${HOME}/.wine
fi

test -d ${WINEPREFIX}/"${MKK_APPDIR}" || mkdir -p ${WINEPREFIX}/"${MKK_APPDIR}"

docker run -it --rm \
    --env=TZ=$(cat /etc/timezone) \
    --env=DISPLAY=$DISPLAY \
    --env=XAUTHORITY=${XSOCK} --volume=${XSOCK}:${XSOCK} \
    --volume=/dev/bus:/dev/bus --net host \
    -u $(id -u) \
    --volume="${WINEPREFIX}/${MKK_APPDIR}":"${UHOME}/.wine/${MKK_APPDIR}" \
    --volume=/tmp:/tmp \
    philmd/winbox
