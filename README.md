# Connecting-Siemens-PLC-with-Azure-and-Visual-Studio
My IOT Project about connecting PLC S7-1500 with Azure Cloud and simple visualisation in Visual Studio.

## Main Idea
The project involves connecting a Siemens S7-1500 PLC controller with an Ewon industrial router to a cloud database, and then visualizing the results by loading data from this database. The main goal of the project is to learn how to create a Azure Cloud SQL Database that is connected to the physical IOT device. In a project, you can also learn how to manage and refer to the database by external programs such as Visual Studio. It was the final project to pass the Industrial Databases subject at the Automation and Robotics studies at Poznan University of Technology.  

Final effect:

<img src="assets/Visual-final.PNG" width="450" height="300">

## Hardware and software requirements

- Siemens PLC S7-1200, S7-1500 or other programable controler. 
- Ewon Flexy (in my case it is 205) 
- Azure Account with some amount of cash. Some services are chargeable. 
- Visual Studio 2019
- Microsoft SQL Server Management Studio

## Links
Below you can find helpful links that I used to create and configure whole project. 

- [1] How to configure Remote Access and Communication with Ewon on TIA Portal 
[https://hmsnetworks.blob.core.windows.net/www/docs/librariesprovider10/downloads-monitored/manuals/application-user-guide/aug-0047-00-en-configure-remote-access-for-siemens-plc-through-tia-portal.pdf?sfvrsn=5ab549d7_23](https://hmsnetworks.blob.core.windows.net/www/docs/librariesprovider10/downloads-monitored/manuals/application-user-guide/aug-0047-00-en-configure-remote-access-for-siemens-plc-through-tia-portal.pdf?sfvrsn=5ab549d7_23).

- [2] Creating IO server with variables on Ewon for Siemens PLC with Ethernet protocol 
[https://hmsnetworks.blob.core.windows.net/www/docs/librariesprovider10/downloads-monitored/manuals/application-user-guide/aug-0048-00-poll-data-from-siemens-plc-using-ethernet-protocol.pdf?sfvrsn=17d757d7_9](https://hmsnetworks.blob.core.windows.net/www/docs/librariesprovider10/downloads-monitored/manuals/application-user-guide/aug-0048-00-poll-data-from-siemens-plc-using-ethernet-protocol.pdf?sfvrsn=17d757d7_9).

- [3] Basic Script Programming documentation on Ewon 
[https://developer.ewon.biz/system/files_force/rg-0006-01-en-basic-programming.pdf](https://developer.ewon.biz/system/files_force/rg-0006-01-en-basic-programming.pdf).

- [4] Thread on Ewon's forum about configuring eWON Flexy for Microsoft Azure with MQTT protocol
 [https://techforum.ewon.biz/thread-786.html](https://techforum.ewon.biz/thread-786.html).

- [5] Video on YT how to configure Ewon Flexy with Azure IOT Hub
[https://www.youtube.com/watch?v=YSZPyL_gxAg](https://www.youtube.com/watch?v=YSZPyL_gxAg).

- [6] Connecting IOT Hub with SQL Server on Azure Platform
[https://www.youtube.com/watch?v=9WQ2hGjFs6M](https://www.youtube.com/watch?v=9WQ2hGjFs6M).

- [7] Connecting Azure SQL Database with Microsoft SQL Server and Visual Studio 2019. 
[https://www.youtube.com/watch?v=JMcmJGogqyg](https://www.youtube.com/watch?v=JMcmJGogqyg).


## Configuration step-by-step

### 1. Tia Portal
In this section we need to enable connection with Ewon router from the PLC controller side. More detailed documentation is available on the developer's website [1].  

Set IP Adress of your PLC, it has to be in the same subnet as Ewon. In Tia go to: Device configuration → Profinet Interface → IP Protocol. Also you need to check "Use Router" and type Ewon adress in this field, like below.  

<img src="assets/s7-adresses.PNG" width="300">

Then in Device configuration → Protection & Security check the tab to enable PUT/GET connection with Ewon. 

<img src="assets/s7-putget.PNG" width="450">

Last thing is to select your variable to send. It must have its own address. For testing purpose I created variable like below. 

<img src="assets/s7-lad.PNG" width="350">

### 2. Ewon configuration
Now that we have configured the controller, you should now go to the Ewon router settings. I assume you have already configured a router and have created an IO Server that communicates with the PLC. If not, see the developer's documentation[2].
In the tags configuration tab, add a new variable with the same address with which you set it on the controller. You can see it below. 

<img src="assets/ewon-variable.PNG" width="350">

If the variable works correctly, now go to the Basic IDE section and write a program to communicate with the Azure cloud. Note, this will require a few extra steps from you, such as uploading the Certificate and Key files via FTP to the Ewon router. At this point, it's best to follow the instructions in the thread[4] and in the video[5] (YOU NEED TO DO IT).

When you finish the YT tutorial, you should have the code similar like below (I made my script smaller, you can find it [My Ewon Script](/ewon_program.bas))
Configuration of MQTT: 

<img src="assets/ewon-prg-config.PNG" width="450">

Creating JSON Frame to send:

<img src="assets/ewon-prg-json.PNG" width="570">

Do not run the program until you finish the next step. 

<img src="assets/ewon-start.PNG" width="150">

If you want to know more about the script, see the documentation[3] and chapter "MQTT". 

### 3. Microsoft Azure Portal
If the router has already been configured, we need to create three main services in Azure Platform.
- IOT Hub - service that will receive messages coming from the Ewon router
- SQL Database - it will store the information selected by us in the database
- Stream Analytics Job - which will connect 2 previous services, i.e. send and select data that goes from the input of IOT Hub to the output, for us it is SQL Server.
The short instruction for each service is below, for more information you can watch the video [6]: 

#### IOT Hub
On Azure select new service, and choose IOT Hub, enter basic parameters like hub name, select subscription and create. 
Once it is created, go to the service and select IOT Devices. Add a new device, be sure to name it the same as the files previously transferred via FTP. Select the self-signed key and then enter the footprint value in both of them, which is in your <device-name> .crt file - it was explained in the video [5]. You should have added 1 device like below. 

 <img src="assets/azure-iot-device.PNG" width="550">
 
Now, you can go back to your Ewon Script, change values of variables - "DeviceId$" and "IotHubName$" for yours settings, and start the script. Return to the IOT Hub service, after some time you should see the message count should increase (as below). If it doesn't work, check your configuration again. 
 
<img src="assets/azure_iot-hub.PNG" width="350">

#### SQL Database
Select new service, and chose SQL Database. Name your database, and select subscription. Also you need to create server, it is important because you will need server name, login and password, to establish remote connection to your database. In the last step watch the tab review, and check billing(you can create test server for only few $ for a month), if it is okey, click create. Once the service is created, open it. Check the full server name - you will need it. Then click on the "Firewall" tab. 
<img src="assets/azure_sql.PNG" width="650">

This is neccesery to add IP Adresses on the whitelist. Click "add client IP", and additionaly check "Yes" for "Allow azure services to access this server". Then you can be sure that the firewall will not stop yours services. Remember about this tab, because at various times Azure may ask you to add an IP address, e.g. your computer to the whitelist. You can add them directly here. 
<img src="assets/azure_sql_fw.PNG" width="400">

#### Stream Analytics Job

*Attention, first you have to create table where you will save your data. To do it, firstly go to the step 4. and come back afterwards. 
 
 
<img src="assets/azure_stream.PNG" width="600">


### 4. Microsoft SQL Server

<img src="assets/SQLServer-connection.PNG" width="350">

You can use [My SQL Script](/MyDBquery.sql) to create the basic table and check is it working.


### 5. Visual Studio
Install additional extension for Visual Studio which is SQL Server and open SQL Server Object Explorer. Log to your database and you should see
When everything is working go to the file MyForm.h in line 405 you need to add a connection parameters(server name, catalog name, ID and Password for loging in to the SQL Server,  in te line:

SqlConnection^ conDatabase = gcnew SqlConnection("Data Source=<TYPE FULL NAME OF SQL SERVER>;Initial Catalog=<TYPE CATALOG>;User ID=<TYPE YOUR ID>;Password=<TYPE PSWD>;Connect Timeout=30;Encrypt=True;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False");

Now you can start program (CTRL + F5) with connection to your Azure Cloud SQL Server.
 
<img src="assets/Visual-final.PNG" width="350">


