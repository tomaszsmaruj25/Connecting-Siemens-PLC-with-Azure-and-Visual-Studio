# Connecting-Siemens-PLC-with-Azure-and-Visual-Studio
My IOT Project about connecting PLC S7-1500 with Azure Cloud and simple visualisation in Visual Studio

## Main Idea
It was the final project to pass the Industrial Databases subject at the Automation and Robotics studies 

<img src="assets/Visual-final.PNG" width="450" height="300">

## Hardware and software requirements

- Siemens PLC S7-1200 or S7-1500 or other programable controler. 
- Ewon Flexy (in my case it is 205) 
- Azure Account with some cash on it. Some of the services are paid. 
- Visual Studio 2019
- Microsoft SQL Server Management Studio

## Links
Below you can find helpful link that I used to create and configure whole project. 

- [1] Remote Access with Ewon configuration on TIA Portal 
[https://hmsnetworks.blob.core.windows.net/www/docs/librariesprovider10/downloads-monitored/manuals/application-user-guide/aug-0047-00-en-configure-remote-access-for-siemens-plc-through-tia-portal.pdf?sfvrsn=5ab549d7_23](https://hmsnetworks.blob.core.windows.net/www/docs/librariesprovider10/downloads-monitored/manuals/application-user-guide/aug-0047-00-en-configure-remote-access-for-siemens-plc-through-tia-portal.pdf?sfvrsn=5ab549d7_23).

- [2] Creating IO server and variables on Ewon for Siemens with Ethernet
[https://hmsnetworks.blob.core.windows.net/www/docs/librariesprovider10/downloads-monitored/manuals/application-user-guide/aug-0048-00-poll-data-from-siemens-plc-using-ethernet-protocol.pdf?sfvrsn=17d757d7_9](https://hmsnetworks.blob.core.windows.net/www/docs/librariesprovider10/downloads-monitored/manuals/application-user-guide/aug-0048-00-poll-data-from-siemens-plc-using-ethernet-protocol.pdf?sfvrsn=17d757d7_9).

- [3] Documentation about programing in Basic Script on Ewon
[https://developer.ewon.biz/system/files_force/rg-0006-01-en-basic-programming.pdf](https://developer.ewon.biz/system/files_force/rg-0006-01-en-basic-programming.pdf).

- [4] Thread on the Ewon forum about configuring Ewon with MQTT 
 [https://techforum.ewon.biz/thread-786.html](https://techforum.ewon.biz/thread-786.html).

- [5] Video on YT to configuration Ewon with Azure IOT Hub
[https://www.youtube.com/watch?v=YSZPyL_gxAg](https://www.youtube.com/watch?v=YSZPyL_gxAg).

- [6] Connecting IOT Hub with SQL Server
[https://www.youtube.com/watch?v=9WQ2hGjFs6M](https://www.youtube.com/watch?v=9WQ2hGjFs6M).

- [7] Connecting Azure SQL Database with Microsoft SQL Server and Visual Studio 2019. 
[https://www.youtube.com/watch?v=JMcmJGogqyg](https://www.youtube.com/watch?v=JMcmJGogqyg).


## Configuration step-by-step

### 1. Tia Portal

<img src="assets/s7-adresses.PNG" width="300">

<img src="assets/s7-lad.PNG" width="350">

<img src="assets/s7-putget.PNG" width="450">

### 2. Ewon configuration

<img src="assets/ewon-variable.PNG" width="350">

<img src="assets/ewon-start.PNG" width="150">

<img src="assets/ewon-prg-json.PNG" width="570">

<img src="assets/ewon-prg-config.PNG" width="450">

### 3. Azure Portal

<img src="assets/azure_iot-hub.PNG" width="350">

<img src="assets/azure-iot-device.PNG" width="550">


<img src="assets/azure_sql.PNG" width="650">

<img src="assets/azure_sql_fw.PNG" width="400">


<img src="assets/azure_stream.PNG" width="600">


### 4. Microsoft SQL Server

<img src="assets/SQLServer-connection.PNG" width="350">

### 5. Visual Studio

<img src="assets/Visual-final.PNG" width="350">


