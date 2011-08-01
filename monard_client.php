<?php

//change this
$MONARD_SERVER_URL = 'http://10.0.0.9/monard.php';

//need to set the comport number properly. 
//change this too
ser_open( "\\\\.\\COM20", 9600, 8, "None", "1", "None" ); //open the serial port



ser_setDTR( false);
ser_setRTS( false);
if(ser_isopen()){
//while(ser_inputcount() <= 0) {sleep(1);echo('-');}
sleep(10); //let the hardware initialize first. 
$ch = curl_init();
while(1){
	

	// get the data from MonArd server
	curl_setopt($ch, CURLOPT_URL, $MONARD_SERVER_URL);

	//warning: don't use so many clients at a time with keepalives on
	curl_setopt($ch, CURLOPT_HTTPHEADER, array('Connection: Keep-Alive', 'Keep-Alive: 300'));
	
	curl_setopt($ch,CURLOPT_RETURNTRANSFER,1);
	$res = curl_exec($ch);
	ser_write(trim($res));
	echo($res);
	sleep(3);

}
curl_close($ch);

//everything else below just used for debugging.
sleep(10);
echo(ser_inputcount()." -<br>");
while(ser_inputcount() > 0)
{
	
	$data = chr(ser_readbyte( ));
	echo $data;
	echo('---');
}
}
else
{
	echo "no connection";
}

