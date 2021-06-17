Rem --- eWON start section: Cyclic Section
eWON_cyclic_section:
Rem --- eWON user (start)
Rem --- eWON user (end)
End
Rem --- eWON end section: Cyclic Section
Rem --- eWON start section: Init Section
eWON_init_section:
Rem --- eWON user (start)
//################" CONFIGURATION #################
DeviceId$="mydeviceewon"
IotHubName$ ="ewoniothub"
Pushtime% = 20 //Timer to push Tags [s]
CLS

// MQTT CONFIGURATION
MQTT "Open",DeviceId$,IotHubName$ + ".azure-devices.net"
Mqtt "SetParam","Port","8883"
MQTT "setparam", "log", "1"
MQTT "setparam", "keepalive", "20"
MQTT "setparam", "TLSVERSION", "tlsv1.2"
MQTT "setparam", "PROTOCOLVERSION", "3.1.1"
MQTT "setparam", "cafile","/usr/BaltimoreCyberTrustRoot.pem"
MQTT "setparam", "CertFile","/usr/"+DeviceId$+".crt"
MQTT "setparam", "KeyFile","/usr/"+DeviceId$+".key"
Mqtt "SetParam","Username",IotHubName$+ ".azure-devices.net/"+DeviceId$+"/api-version=2016-11-14"
Mqtt "SetParam","Password","HostName="+IotHubName$+";DeviceID="+DeviceId$+";x509=true"
SETSYS PRG,"RESUMENEXT",1  //Continue in case of error at MQTT "CONNECT"
Mqtt "Connect"
ErrorReturned% = GETSYS PRG,"LSTERR"
IF ErrorReturned% = 28 THEN @Log("[MQTT SCRIPT] WAN interface not yet ready")
SETSYS PRG,"RESUMENEXT",0
ONMQTT "GOTO MqttRx"
//a = table with 2 columns : one with the negative indice of the tag and the second one with 1 if the values of the tag change or 0 otherwise
IsConnected: 
ONTIMER 1, "goto MqttPublishValue"
TSET 1,Pushtime%
END
//Compute the right time format for AZURE
Function GetTime$()
  $a$ = Time$
  $GetTime$ = $a$(7 To 10) + "-" + $a$(4 To 5) + "-" + $a$(1 To 2) + " " + $a$(12 To 13)+":"+$a$(15 To 16)+":"+$a$(18 To 19)
EndFn
//Publish tags
MqttPublishValue:
//Compute JSON
mydata$ = STR$ OEE@
json$ = '{'
json$ = json$ +    '"time": "'+@GetTime$()+'"'  + ', '
json$ = json$ +    '"OEEvalue": '+ mydata$ +''
json$ = json$ +    '}'
MQTT "PUBLISH","devices/"+DeviceID$+"/messages/events/",json$, 0, 0
PRINT "[PUBLISH TIMER] Tags have been Published"
END
FUNCTION Log($Msg$)
  LOGEVENT  $Msg$ ,100
  PRINT $Msg$
ENDFN




Rem --- eWON user (end)
End
Rem --- eWON end section: Init Section