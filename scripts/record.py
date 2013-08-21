#!/var/packages/python/target/bin/python

import cgitb, os, time, urllib2
cgitb.enable()

TIME_WAIT = 10
STAT_FILE = "RECORDING"

 
class Recorder(object):
    CAMS = [1, 2, 3]

    def start(self):
        touch(STAT_FILE)
        self._record_action("start")
	return self
    
    def stop(self):
        last_time = os.path.getmtime(STAT_FILE)
	last_time = datetime.datetime.fromtimestamp(last_time)
	current_time = datetime.datetime.now()
	td = current_time - last_time
	if td.seconds < TIME_WAIT:
            return self
	self._record_action("stop")
        return self

    def _record_action(self, action): 
       for i in  Recorder.CAMS: 
           urllib2.urlopen(self._buildUrl(action, i))

    def _buildUrl(self, action, id): 
	print "Executing " + action + " for cam" + str(id)
        return ''.join([str(os.environ.get("DOCUMENT_ROOT")), "/webapi/SurveillanceStation/extrecord.cgi?api=SYNO.SurveillanceStation.ExternalRecording&method=Record&version=1&cameraId=", str(id), "&action=", action])

def touch(fname, times=None):
    with file(fname, 'a'):
            os.utime(fname, times)

print "Content-Type: text/html;"
print ""

subprocess.call('./login.sh')
recorder = Recorder()
recorder.start()
time.sleep(TIME_WAIT)
recorder.stop()
	    
