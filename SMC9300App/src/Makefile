TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = SMC9300

# EOSMotors.dbd will be created and installed
DBD += SMC9300.dbd

# EOSMotors.dbd will be made up from these files:
SMC9300_DBD += base.dbd
SMC9300_DBD += asyn.dbd
SMC9300_DBD += drvAsynIPPort.dbd
SMC9300_DBD += calc.dbd
SMC9300_DBD += stream.dbd

# Add all the support libraries needed by this IOC
SMC9300_LIBS += asyn
SMC9300_LIBS += calc
SMC9300_LIBS += stream

# EOSMotors_registerRecordDeviceDriver.cpp derives from EOSMotors.dbd
SMC9300_SRCS += SMC9300_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
SMC9300_SRCS_DEFAULT += SMC9300Main.c
SMC9300_SRCS_vxWorks += -nil-

# Finally link to the EPICS Base libraries
SMC9300_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE
