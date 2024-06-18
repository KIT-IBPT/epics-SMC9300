# EPICS device support for SMC 9300 motor controller


This is EPICS device support IOC for SMC 9300 Huber motor controller by manufacturer [pp-electronic gmbh](www.pp-electronic.de).

Device support uses StreamDevice support for communication with the motor controller.


## IOC


Each SMC9300.db is assotiated with one controller axis, that is provided by the IOC configuration.

This is excerpt from fSMC9300/iocBoot/iocLinux/st.cmd

ASYN port configuration:

```
drvAsynIPPortConfigure("SMC1", "flute-motcon-smc01:1234 TCP", 0, 0, 0)

# signel axis
# Parameters:
# DEV - device PV prefix
# AXIS - axis number, from 1 to number of installed axes

dbLoadRecords("../../db/SMC9300.db", "PORT=SMC1,DEV=F:TEST:SMC:01,AXIS=1")


# two axis moved in sync
# Parameters:
# DEV - device PV prefix
# DEV1 - device PV prefix for first axis, need for relative move value
# AXIS1 - first axis number, from 1 to number of installed axes
# AXIS2 - second axis number, from 1 to number of installed axes

dbLoadRecords("../../db/SMC9300sync.db", "DEV=F:TEST:SMC2:01,DEV1=F:TEST:SMC:01,AXIS1=1,AXIS2=2")
```

### EPICS API

Current device in operation has device PV prefix: F:TEST:SMC:01. Following is list of PVs with explanation. Full PV consist of prefix and suffix part.



| PV Suffix | Type | Description |
| --- | --- | --- |
| `Info:IDN` | `stringin` | Controller identification and version string |
| `Info:Axis:Count` | `longin` | Number of all axis supported by controller |
| `Info:Axis` | `longin` | Axis index operated by this PV prefix |
| `Status` | `mbbiDirect` | 16 bit controller status. Position of bits in status is described by PV Status:Strings and might differ from controller status bit order. |
| `Status:Get` | `mbbiDirect` | Status bits directly from controller, intended for IOC internal use and debugging. |
| `Status:ErrorSum` | `bi` | Sums all error of device in one flag, 1 if device error. |
| `Status:Strings` | `mbbi` | Descriptions string for status. Consistent with PV Status. Used in CSS widget with LED displays for status. |
| `Status:Bit0 .. Status:Bit15` | `bi` | Individual status bits with description and severity. Used in CSS widget with LED displays for status. |
| `Status:Homed` | `bi` | Boolean flag if controller has been homed. Reflects corresponding bit from PV Status. It is always homed, this here for consistency reasons. |
| `Status:Limit:Fwd` | `bi` | Boolean flag if forward limit switch has been activated. Reflects corresponding bit from PV Status. |
| `Status:Limit:Rev` | `bi` | Boolean flag if backward limit switch has been activated. Reflects corresponding bit from PV Status. |
| `Pos:Get` | `ai` | Position readout |
| `Enc:Get` | `ai` | Position encoder readout |
| `Pos:Abs` | `ao` | Absolute position prepared for next movement |
| `Pos:Abs:Sync` | `bo` | Uses current position readout (`Pos:Get`) to set to `Pos:Abs` |
| `Pos:Rel` | `ao` | Relative position prepared for next movement |
| `Move:Start:Get` | `longin` | Move parameter. Start velocity readout in Hz. |
| `Move:Start:Set` | `longout` | Move parameter. Start velocity set in Hz. |
| `Move:Acc:Get` | `longin` | Move parameter. Acceleration readout in Hz/ms. |
| `Move:Acc:Set` | `longout` | Move parameter. Acceleration set in Hz/ms. |
| `Move:Velo:Get` | `longin` | Move parameter. Max movement velocity in Hz. |
| `Move:Velo:Set` | `longout` | Move parameter. Max movement velocity in Hz. |
| `Move:Dec:Get` | `longin` | Move parameter. Deceleration readout in Hz/ms. |
| `Move:Dec:Set` | `longout` | Move parameter. Deceleration set in Hz/ms. |
| `Cmd:Stop` | `bo` | Stop all movement. |
| `Cmd:Zero` | `bo` | Sets position value for current motor position to 0. |
| `Cmd:Move:Abs` | `bo` | Move to new absolute position, as provided by PV `Pos:Abs`. |
| `Cmd:Move:Rel` | `bo` | Move by relative position as provided by PV `Pos:Rel`. |


## CSS GUI Panels

Panel module is located in CSS folder.


## Copyright / License

This EPICS device support is licensed under the terms of the [MIT license](LICENSE) by 
[Karlsruhe Institute of Technology's Institute of Beam Physics and Technology](https://www.ibpt.kit.edu/) 
and was developed by [igor@scictrl.com](http://scictrl.com).
