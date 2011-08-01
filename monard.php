<?php
//$cc=exec("cat /proc/cpuinfo | wc -l", $cpucount);
//$cpucount = $cpucount[0]+ 0; //typecast;
//print_r( $cpucount); 
$cpucount =1;

$str= "12:32:20 up 58 min,  3 users,  load average: 0.00, 0.02, 0.00";
$e =  exec ("uptime", $str);

$str=$str[0];
//print_r( $str) ;
$parse1 = explode( 'average: ',$str);
$parse2 = explode( ', ', $parse1[1]);
//$parse2[0]=1.33;
$cpuperc = ceil(           8* (0+$parse2[0])/$cpucount         );
if($cpuperc > 8 ) $cpuperc = 8;



/*
$mem = <<<EOQ
MemTotal:	444444
MemFree:	33333
EOQ;	 */	
									
$memss =  exec("cat /proc/meminfo | grep Mem", $memparse);
//print_r($mem);
//$memparse = explode("\n", $mem );
//$totalMem = explode("MemTotal:", $memparse[0]);
// = explode("\t",  $memparse[1]);

$totalMem=0+ strtr($memparse[0], array('MemTotal:' =>'', 'kB'=>''));
$freeMem=0+ strtr($memparse[1], array('MemFree:' =>'', 'kB'=>''));

//echo $totalMem;

$memperc = ceil(8*$freeMem/($totalMem));


echo('C'.$cpuperc.'M'.$memperc);

//echo 'C5M7';