<?php

$d = strtolower(date('M'));
/*
$good_months = array( 'apr','may','jun','jul','aug','sep','oct' );

Nothing is going on Oct this year.

*/
$good_months = array( 'apr','may','jun','jul','aug','sep');
if (! in_array( $d, $good_months )) { 
   $d = 'may';
}

header('Location: http://www.jellystoneniagara.ca/vacationplanner-'.$d.'.shtml');

?>