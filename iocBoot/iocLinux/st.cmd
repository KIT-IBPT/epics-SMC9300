#!../../bin/linux-x86_64/SMC9300

< envPaths

epicsEnvSet("STREAM_PROTOCOL_PATH","../../db")

################################################################################
# Tell EPICS all about the record types, device-support modules, drivers,
# etc. in the software we just loaded
dbLoadDatabase("../../dbd/SMC9300.dbd")
SMC9300_registerRecordDeviceDriver(pdbbase)

### Confiugure Motor Controllers ###
#drvAsynIPPortConfigure("SMC1", "flute-motcon-smc01:1234 TCP", 0, 0, 0)
drvAsynIPPortConfigure("SMC1", "acc-flute-tmp06:1234 TCP", 0, 0, 0)

#asynSetTraceFile("TLBBD", -1, "$(TOP)/async.log")

# print error       0x01
# print device IO   0x02
# print filtering   0x04
# print all above   0x07
# print driver IO   0x08
asynSetTraceMask("SMC1",-1,0x01)

# print nothing     0x00
# print with ASCII  0x01
# print with excape 0x02
# print with hex    0x04
asynSetTraceIOMask("SMC1",-1,0x00)

### save_restore setup
# We presume a suitable initHook routine was compiled into EOSMotorsApp.munch.
# See also create_monitor_set(), after iocInit() .
#< save_restore.cmd

### Load Records ###

# Parameters:
# DEV  - device PV prefix
# AXIS - axis number, from 1 to number of installed axes

# AXIS 1
dbLoadRecords("../../db/SMC9300.db", "PORT=SMC1,DEV=F:TEST:SMC:01,AXIS=1")

# AXIS 2
dbLoadRecords("../../db/SMC9300.db", "PORT=SMC1,DEV=F:TEST:SMC:02,AXIS=2")

# AXIS SYNC MOVE 1&2
dbLoadRecords("../../db/SMC9300sync.db", "DEV=F:TEST:SMC2:01,DEV1=F:TEST:SMC:01,AXIS1=1,AXIS2=2")

#dbLoadTemplate "../../db/ThorlabsBBD203.substitutions"

# Dump the list of records to a file.
#dbl > "$(EPICS_AUTOPVLIST_IOC_FILE)"

iocInit

### Start up the autosave task and tell it what to do.
# The task is actually named "save_restore".
# Note that you can reload these sets after creating them: e.g., 
# reload_monitor_set("auto_settings.req",30,"P=SR:OrbitCheck:,R=")
#save_restoreDebug=20
#
# save motor positions every ten seconds
#create_monitor_set("laserMotorPositions.req", 10, "P=A:EO:Laser:,R=01:")
