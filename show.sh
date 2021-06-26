function main()
{
echo -e "
<div class='class-title1'>在线设备 <a class='class-link' id='link02' href='#class-log'> [连接记录]</a></div>
<script>
\$(document).ready(function(){
  \$('#link02').click(function(){
          htmlobj=$.ajax({url:'/myweb/neig.log',async:false});
            \$('#show-logdiv2').css('display','block');
              \$('#show-log2').html(htmlobj.responseText);
                                                 });
                                                         });
                                                 </script>
                                                 <div class='class-log' id='show-logdiv2'><pre id='show-log2'></pre></div>
<div class='class-devsub1'>"
for mac in $(iw dev wlan0 station dump | grep Station | cut -f 2 -s -d" ")
 do
 dname=`cat /tmp/dhcp.leases | cut -f 2,3,4 -s -d" " | grep $mac | cut -f 3 -s -d" "`
 if  [ "$dname" = "" ]
 then
 host=$mac
 else
 host=$dname
 fi
 echo -e "<span class='class-dev2g'>$host</span>"
done
for mac in $(iw dev wlan1 station dump | grep Station | cut -f 2 -s -d" ")
 do
 dname=`cat /tmp/dhcp.leases | cut -f 2,3,4 -s -d" " | grep $mac | cut -f 3 -s -d" "`
 if  [ "$dname" = "" ]
  then
   host=$mac
  else
   host=$dname
  fi
 echo -e "<span class='class-dev5g'>$host</span>"
done
echo -e "</div>"
}

function main2()
{
echo -e "
    <div class='class-swrow'>台灯</div>
<script>
\$(document).ready(function(){
 \$('#link01').click(function(){
 htmlobj=$.ajax({url:'/myweb/esp.log',async:false});
 \$('#show-logdiv').css('display','block');
 \$('#show-log').html(htmlobj.responseText);
  });
});
</script>
<script>
  \$.getJSON('http://xxx/json?tasknr=1', function(json){
  var swstat=json.Switch
  
  if (swstat == 1)
   {
    \$('input[id=onoffswitch]').prop('checked', 'checked');
   }
   else if (swstat == 0)
   {
    \$('input[id=onoffswitch]').prop('checked', false);
   }
   else
   {
   console.log(swstat);
   };
  
  });
</script>
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />

<div class='testswitch'>
                <input class='testswitch-checkbox' id='onoffswitch' type='checkbox'>
         <label class='testswitch-label' for='onoffswitch'>
                        <span class='testswitch-inner' data-on='ON' data-off='OFF'></span>
                        <span class='testswitch-switch'></span>
         </label>
    </div>
<script>
 \$(document).ready(function() {
 \$('#onoffswitch').on('click', function(){
        clickSwitch()
   });
  var clickSwitch = function() {
  if (\$('#onoffswitch').is(':checked')) {
  \$.get('http://xxx/control?cmd=event,TurnOn');
  } else {
  \$.get('http://xxx/control?cmd=event,TurnOff');
  }
  };
  });
</script> 
<div class='class-link'><a id='link01' href='#'>[查看记录]</a></div>
"
}
function main3()
{                                                                                                                             
op_upt=$(cat /proc/uptime | cut -d '.' -f 1)
echo -e "
<font color='red'>
"
#wd=`sensors |grep temp1 |sed 's/temp1:        +//g'`
wd=`cat /sys/class/hwmon/hwmon*/temp1_input |cut -c-2`
echo -e $wd"℃</font>  <font color='green'> $(($op_upt/60/60/24))天$(($op_upt/60/60%24))小时</font>"
}    
function main4()
{
echo -e "
<div class='biaoti1'>打开电脑：</div>
"
}

a=`echo $QUERY_STRING|awk -F '=' '{print $2}'`
if [ $a == 'ondev' ]; then
 main
elif [ $a == 'contsw' ]; then
 main2
elif [ $a == 'opwendu' ]; then
 main3
elif [ $a == 'contpc' ]; then
 main4
else
 exit
fi

exit
