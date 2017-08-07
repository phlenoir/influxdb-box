#!/bin/bash
#set -x
export BASENAME=grafana-server
export BASEDIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export pidfile=${BASEDIR}/${BASENAME}.pid
export GRAFANA_ROOT=${BASEDIR}/grafana
export GRAFANA_BIN=${GRAFANA_ROOT}/bin/grafana-server


function log() {
    printf "%.23s %s[%s]: %s\n" $(date +%F.%T.%N) ${BASH_SOURCE[1]##*/} ${BASH_LINENO[0]} "${@}";
}

log "Starting ${BASENAME} ..."
if [ -f $pidfile ]
then
    pid=`cat $pidfile`
    if ps $pid > /dev/null
    then
        log "${BASENAME} already started"
        exit 1
    fi
    # pid file is out-of-date
    rm "$pidfile"
fi
exec ${GRAFANA_BIN} -pidfile ${pidfile} -homepath ${GRAFANA_ROOT} &


