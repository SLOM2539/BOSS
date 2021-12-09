<?php
$str = shell_exec("vnstat -d --oneline");
$s = explode(";",$str);
$a = array_slice($s,2,4);
echo end($a);
