<?PHP

/* require_once('../recaptchalib.php');
$privatekey = "6LexBQEAAAAAAIceXzR1HqHgYZLIfWzvYegguJrt";
$resp = recaptcha_check_answer ($privatekey,
                                $_SERVER["REMOTE_ADDR"],
                                $_POST["recaptcha_challenge_field"],
                                $_POST["recaptcha_response_field"]);

if (!$resp->is_valid) {
  die ("The reCAPTCHA wasn't entered correctly. Go back and try it again.");
} */


session_start();
//if(($_SESSION['security_code'] == $_POST['security_code']) && (!empty($_SESSION['security_code'])) ) {
//      // Insert you code for processing the form here, e.g emailing the submission, entering it into a database. 
//      unset($_SESSION['security_code']);
//   } else {
//      die ("The special image wasn't entered correctly. Go back and try it again.");
//   }

#----------
# Validate: String

function check_string($value, $low, $high, $mode, $optional)
{
  ### DAMN AUTOSUBMITTER I HATE YOU!!!
 if( preg_match("/bcc/i", $value) ) {
   return false;
 }

 if ( (strlen($value) == 0) && ($optional == true) ) {
  return true;
 } elseif ( (strlen($value) >= $low) && ($mode == 1) ) {
  return true;
 } elseif ( (strlen($value) <= $high) && ($mode == 2) ) {
  return true;
 } elseif ( (strlen($value) >= $low) && (strlen($value) <= $high) && ($mode == 3) ) {
  return true;
 } else {
  return false;
 }
}

# RegisterGlobals OFF

$FTGMy_Firstname = $_POST['My_Firstname'];
$FTGMy_Lastname = $_POST['My_Lastname'];
$FTGCampground_Name = $_POST['Campground_Name'];
$FTGAddress = $_POST['Address'];
$FTGCity = $_POST['City'];
$FTGState = $_POST['State'];
$FTGCountry = $_POST['Country'];
$FTGZipPostal = $_POST['ZipPostal'];
$FTGTel1 = $_POST['Tel1'];
$FTGTel2 = $_POST['Tel2'];
$FTGTel3 = $_POST['Tel3'];
$FTGFax1 = $_POST['Fax1'];
$FTGFax2 = $_POST['Fax2'];
$FTGFax3 = $_POST['Fax3'];
$FTGEmail = $_POST['Email'];
#$FTGOperating_System = $_POST['Operating_System'];
$FTGContact_By = $_POST['Contact_By'];
$FTGRefer_Source = $_POST['Refer_Source'];
$FTGsubmit = $_POST['submit'];
if( $_POST['Send-Me-Newsletters'] ) {
	$FTGSendMeNewsletters = 'Yes';
} else {
	$FTGSendMeNewsletters = 'No';
};

$FTGMy_Name = $FTGMy_Firstname . " " . $FTGMy_Lastname;

//# Fields Validations

//$validationFailed = false;

//if ( (! check_string($FTGMy_Firstname, 1, 0, 1, false))) {
// $validationFailed = true;
//}

//if ( (! check_string($FTGMy_Lastname, 1, 0, 1, false))) {
// $validationFailed = true;
//}

//if ( (! check_string($FTGAddress, 1, 0, 1, false))) {
// $validationFailed = true;
//}

//if ( (! check_string($FTGCampground_Name, 1, 0, 1, false))) {
// $validationFailed = true;
//}

//if ( (! check_string($FTGCity, 1, 0, 1, false))) {
// $validationFailed = true;
//}

//if ( (! check_string($FTGState, 1, 0, 1, false))) {
// $validationFailed = true;
//}

//if ( (! check_string($FTGZipPostal, 1, 0, 1, false))) {
// $validationFailed = true;
//}

//if ( (! check_string($FTGTel1, 1, 0, 1, false))) {
// $validationFailed = true;
//}

//if ( (! check_string($FTGEmail, 1, 0, 1, false))) {
// $validationFailed = true;
//}

//#if ( (! check_string($FTGOperating_System, 1, 0, 1, false))) {
//# $validationFailed = true;
//#}

# Redirect user to the error page

if ($validationFailed == true) {

 header("Location: /index.php/formsubmit/failure");
 exit;

}

# Email to Form Owner

$emailTo = '"Campground Manager" <peterkearns@gmail.com>';
$emailTo2 = '"Campground Manager" <calgoodman@gmail.com>';
$emailTo3 = '"Demo Download Counter" <demodownload@bookyoursite.com>';

$emailSubject = "Campground Manager Software Demo Downloaded";

$emailBody = "Contact Name: $FTGMy_Name\n"
 . "Campground Name: $FTGCampground_Name\n"
 . "Address: $FTGAddress\n"
 . "City: $FTGCity\n"
 . "State: $FTGState\n"
 . "ZipPostal: $FTGZipPostal\n"
 . "Country: $FTGCountry\n"
 . "Tel: $FTGTel1 $FTGTel2 $FTGTel3\n"
 . "Fax: $FTGFax1 $FTGFax2 $FTGFax3\n"
 . "Email: $FTGEmail\n"
 . "Accept Our Future Email: $FTGSendMeNewsletters\n"
 . "Operating_System: $FTGOperating_System\n"
 . "Contact_By: $FTGContact_By\n"
 . "Refer_Source: $FTGRefer_Source\n"
 . "\n"
 . "";

$emailHeader = "From: $FTGMy_Name <$FTGEmail>\n"
 . "Reply-To: $FTGEmail\n"
 . "Content-type: text/plain; charset=\"ISO-8859-1\"\n"
 . "Content-transfer-encoding: quoted-printable;\n";


//$myfile = '/home/cgm/tmp/email_addresses.txt';
//$fh = fopen($myfile,'a');
//$emailString = "$FTGEmail\n";
//fwrite( $fh, $emailString );
//fclose( $fh );

mail($emailTo, $emailSubject, $emailBody, $emailHeader);
#mail($emailTo3, $emailSubject, $emailBody, $emailHeader);

#### SEND HTML EMAIL TO CUSTOMER
$HTML         = '
	<html>
	<head>
	<title>Campground Manager Software Demo Download</title>
	</head>
	<body style="margin:0;padding:0">
	<div style="">
		<table class="email-body-wrap" width="740" cellspacing="0" cellpadding="0" id="email-body" align="center" >
			<tr>
				<td width="740" colspan="3" class="top"><img src="http://www.campgroundmanager.com/img/email-top.jpg" width="740" height="146" style="display:block;"></td>
			</tr>
			<tr>
				<td width="740" class="top-bg"><table width="740" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td width="100">&nbsp;</td>
							<td><font color="#211e19" face="Georgia, Times, serif" style="font-size:14px; text-align:left;"><span apple-content-name="body" style="display:block;width:540px">
								<div class="body-content" id="body-content" style="line-height:1.5;">
									<DIV>
									';
$HTML .= "
										Hi $FTGMy_Name.<div><br/></div> 
";
$HTML .= '
										By now I hope you have found the time to investigate the demo you downloaded. Thanks again for taking the time to download our demo and your initial interest in Campground Manager Software&reg; and Bookyoursite.com. We always follow up from our end in order to make sure that the customer has all the information he or she needs in order to make an informed decision. Once you get the demo loaded <a href="http://www.campgroundmanager.com/index.php/main/howto-video-free/making_a_reservation_1">click here</a> to see a short video movie of how to enter a basic reservation.<div><br/></div> 

										To recap some of the features of our product:<div><br/></div> 
										In addition to Campground Manager Software&reg; we have the following add on modules and services: 
										<ul>
											<li>We have a automatic download to Quickbooks Pro</li>
											<li>A full point of sale program to run your store and track your inventory</li>
											<li>A credit card verification piece that can be integrated into the system</li>
											<li>Fully automated Bookyoursite.com online booking system.</li>
										</ul>

										New- we have an ASP service(application service provider). We host the system on a secure server in a secure data center. The low monthly fee covers the software, the hosting, back ups and generally everything associated with running Campground Manager Software&reg; at park level. For more details <a href="http://www.campgroundmanager.com/index.php/main/asp">click here</a>.<div><br/></div> 
										
										We have lots of info on our website. For a general overview of how the product works we have recorded various webinars we have run over the past few months. If you want to view them please click on the links below.<div><br/></div> 
										
										<ul>
											<li>For an overall view of the product and how it works <a href="https://campgroundmanager.webex.com/campgroundmanager/ldr.php?AT=pb&SP=MC&rID=9638887&rKey=6696B68F26247AC1">click here</a></li>
											<li>For the POS training webinar we ran <a href="https://campgroundmanager.webex.com/campgroundmanager/ldr.php?AT=pb&SP=MC&rID=9896127&rKey=822DD2A2CFFA41BC">click here</a>.</li>
											<li>For a more in depth view on how the system integrates with our Bookyoursite.com online booking <a href="https://campgroundmanager.webex.com/campgroundmanager/ldr.php?AT=pb&SP=MC&rID=9672977&rKey=011541FDA972FDA9">click here</a>.</li>
											<li>For a in depth demo of how the system works with the Quickbooks Pro accounting interface <a href="https://campgroundmanager.webex.com/campgroundmanager/ldr.php?AT=pb&SP=MC&rID=9745432&rKey=032C41DE17719C0B">click here</a>.</li>
											<li>For a comparison pricing interactive web page <a href="http://www.campgroundmanager.com/cost-calculator.html">click here</a>.</li>
										</ul>
										
										We also have lots of training movies in the esupport section on <a href="http://www.campgroundmanager.com/">our website</a>.<div><br/></div>
										
										So that is it for now.<br/>
										Let me know what else you need to make an informed decision.<br/>
										Hope we can earn your trust and your business.<br/>
										
										<div><br/></div>

										Thank you in advance for your anticipated support.<div><br/></div>
										<strong>Peter Kearns<br/>
										<hr width="100%"/>
										Campground Manager Software&reg;<br/>
										8676 Oakwood Drive Building B<br/>
										Niagara Falls, ON. L2E 6S5<br/>
										p. 800.547.9147/403.278.3279<br/>
										f. 905.374.4493<br/>
										e. <a href="mailto:peterk@campgroundmanager.com">peterk@campgroundmanager.com</a><br/>
										w. <a href="http://www.campgroundmanager.com">www.campgroundmanager.com</a><br/>
										w. <a href="http://www.campgroundmanager.com">www.bookyoursite.com</a><br/>
										w. <a href="http://www.campgroundmanagerjobs.com">www.campgroundmanagerjobs.com</a><br/>
										w. <a href="http://www.jellystonejobs.com">www.jellystonejobs.com</a><br/>
										<div><br/></div>
										Join our e-newsletter mailing list at <a href="http://www.campgroundmanager.com">www.campgroundmanager.com</a>
									</DIV>
									<span apple-content-name="body" style="display:block;width:540px">
									</span></div>
								</span></font></td>
							<td width="100">&nbsp;</td>
						</tr>
					</table></td>
			</tr>
		</table>
	</div>
	</body>
	</html>
';
$from         = "Peter Kearns <peterk@campgroundmanager.com>";
$to           = $FTGEmail;
$subject     = "Campground Manager Software Demo Download";

sendHTMLemail($HTML,$from,$to,$subject);


function sendHTMLemail($HTML,$from,$to,$subject)
{
// First we have to build our email headers
// Set out "from" address

    $headers = "From: $from\r\n"; 

// Now we specify our MIME version

    $headers .= "MIME-Version: 1.0\r\n"; 

// Create a boundary so we know where to look for
// the start of the data

    $boundary = uniqid("HTMLEMAIL"); 
    
// First we be nice and send a non-html version of our email
    
    $headers .= "Content-Type: multipart/alternative;".
                "boundary = $boundary\r\n\r\n"; 

    $headers .= "This is a MIME encoded message.\r\n\r\n"; 

    $headers .= "--$boundary\r\n".
                "Content-Type: text/plain; charset=ISO-8859-1\r\n".
                "Content-Transfer-Encoding: base64\r\n\r\n"; 
                
    $headers .= chunk_split(base64_encode(strip_tags($HTML))); 

// Now we attach the HTML version

    $headers .= "--$boundary\r\n".
                "Content-Type: text/html; charset=ISO-8859-1\r\n".
                "Content-Transfer-Encoding: base64\r\n\r\n"; 
                
    $headers .= chunk_split(base64_encode($HTML)); 

// And then send the email ....

    mail($to,$subject,"",$headers);
    
}



### insert customer record into highrise and create a task for peter
include('simplehighrise.php');

$token = "2eb34a7b78c5177d60bae36d9b49af48d57510c9".":X";
#$token = "e9c0f24c7fe4daecfe85bc327c8e53b64bc906d9".":X";
$hr = new SimpleHighrise('missionmanagement',$token);
$person_id = $hr->create_new_person_detail($FTGMy_Firstname,$FTGMy_Lastname,$FTGAddress,$FTGCity,$FTGState,$FTGZipPostal,$FTGCountry,"$FTGTel1 $FTGTel2 $FTGTel3","$FTGFax1 $FTGFax2 $FTGFax3",$FTGCampground_Name,$FTGEmail,'Work');
$result2 = $hr->create_new_peter_task("$FTGMy_Name downloaded the demo on ".date("Y/m/d").". Please follow up with a $FTGContact_By.","later", $person_id);

header("Location: http://www.campgroundmanager.com/files/demo/NetDemo.exe");
# Redirect user to success page

#if( $FTGOperating_System == "Win" ) {
	#header("Location: http://www.campgroundmanager.com/files/demo/NetDemo.exe");
#} else {
#	header("Location: ftp://vaxxine.com/users/mission/outgoing/DemoMac/CMMacDemo.sea");
#}

exit;

# End of PHP script
?>
