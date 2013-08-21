#!/opt/bin/bash -x

CAM_NUMBERS=( 1 2 3 )
WAIT_TIME=15

record() 
{
 if [ "$#" -eq 1 ]; then
   if [ "$1" == "stop" ]; then
    local time_now=$(date "+%s")
    local time_start=$(/opt/bin/stat -c "%Y" RECORDING)
    local time_spent=$(expr $time_now - $time_start) 
    echo "$time_start, $time_now, $time_spent"
    echo "$time_spent $WAIT_TIME seconds difference"
    [ $time_spent -lt $WAIT_TIME ] && return 0
    [ -f RECORDING ] && rm -f RECORDING
    cam_action "$1"
   elif [ "$1" == "start" ]; then
    if [ ! -f RECORDING ]; then
      /usr/syno/bin/synonotify VpncReconnectFail
      cam_action "$1"
    fi
    touch RECORDING
    echo "tocuh $?"
    chmod 666 RECORDING
   fi
 fi
}

cam_action() {
 for cam in ${CAM_NUMBERS[@]}; 
  do
   curl -s -b session.txt "$SERVER_ROOT/webapi/SurveillanceStation/extrecord.cgi?api=SYNO.SurveillanceStation.ExternalRecording&method=Record&version=1&cameraId=$cam&action=$1"
  echo "record ruwnalk-cam$cam $1"
  done
}


# output to client

cat << END
Content-Type: text/plain

END

# login to nas
. $(dirname $0)/login.sh
record start
sleep $WAIT_TIME 
record stop
