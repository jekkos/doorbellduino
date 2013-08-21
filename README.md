BellDuino Project
-----------------
This repository contains all source code used in my BellDuino project. The idea here was to couple a retail store's door buzzer to an arduino with ethernet shield and the indoor surveillance system.

Project Setup
-------------
The flow of events is as follows

A customer enters the door by crossing a motion detector that works on 24V AC. This detector will activate two buzzers in the house. Some wiring was added and a 24V AC - 5V DC switching voltage regulator to attach this input to an Arduino.

The store also has three surveillance camera's which are monitored through the Synology Surveillance Station software. The main idea is to trigger recording on the NVR for a configurable amount of seconds whenever someone enters the store.

Instant notification
--------------------
Whenever someone comes through the door, the Arduino will have an input set to high through the voltage regulator. The Arduino sketch will send a HTTP GET requestto to a CGI shell script running on the Synology's Apache server.

The arduino sketch also has a configurable delay for subsequent calls to the CGI script. The script itself is foreseen to handle concurrent access by using an external lock file and will prolong the recoding duration accordlingly.

Notification can be configured through Synology's built in notification system, which can be SMS, Email, Skype or MSN. The message to be sent can be adapted and every call to the shell script will be logged in the synology event logging system.

Third party API integration
---------------------------
The CGI scripts communicate with Surveillance Station through the Synology HTTP API. Therefore a HTTP Session has to be established using curl first. Subsequent calls to the API can reuse an already acquiured cookie.

