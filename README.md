# Repository for REVERE Platform – RHINO
This repository contains information regarding the –

-	Specifications of the physical platform
-	OS configuration for the system (opendlv.os)
-	Network Architecture
- Software stack for deployment 

***Specifications of the physical platform:***
- Platform Inaugurated: 1 January 2016
	- Vehicle: Volvo FH16 750 6X4 Tractor
	- Height: 4000 mm
	- Width: 2600 mm
	- Wheelbase: 3400 mm
	- GCW (Gross Combination Weight) : 52000 kg
    - Front Axle Load: 8000 kg
    - Rear Axle Load: 23000 kg
	- Engine: Diesel Engine 16.1 Lt (750 hp)

- Research-Specific Equipment/System Architecture
	- Vehicle CAN Gateway for Control & Vehicle Data
		- Object Lists
	- LIDAR: Velodyne VLP32c x 1
	- GPS-IMU: OxTS RT3003 x 1
	- Cameras:
		- Axis M1124-E (1280 x 720) x 2
		- Dalsa Genio NANO-C2450 IRC (2448 x 2048) x 2
	- Chassis IMU x 3 (in process)
	- Computing HW for data processing and logging
	- Timesync HW: Meinberg M500 (PTP)
	- Dedicated on-board power supply: Mastervolt

***OS configuration for the system (opendlv.os):***

Refer to [computer/revere-rhino-x86_64-1](https://github.com/chalmers-revere/opendlv-platform-rhino/tree/master/computer/revere-rhino-x86_64-1) on this repo and https://github.com/chalmers-revere/opendlv.os for further information.

***Network Architecture:***

Refer to [To be uploaded]

***Software stack for deployment:***

The platform runs open source software developed in-house called OpenDLV which uses two specific concepts:

- Micro-services
- Containerized Deployment: Docker

For further info about OpenDLV, refer to https://github.com/chalmers-revere/opendlv

Depending on the sensor cluster activated on the platform, YAML files are used for deploying microservices linked to sensor interfaces, data logging, video encoding, visualization, etc.

All information regarding the individual microservices can be found on https://github.com/chalmers-revere/opendlv.
