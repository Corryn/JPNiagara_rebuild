<?PHP
# ----------------------------------------------------
# -----
# -----  Forms To Go v2.5.7 by Bebosoft, Inc.
# -----
# -----  http://www.bebosoft.com/
# -----
# ----------------------------------------------------

session_start();
if(($_SESSION['security_code'] == $_POST['security_code']) && (!empty($_SESSION['security_code'])) ) {
      // Insert you code for processing the form here, e.g emailing the submission, entering it into a database. 
      unset($_SESSION['security_code']);
   } else {
      die ("The special image wasn't entered correctly. Go back and try it again.");
   }

# RegisterGlobals OFF

$FTGname = $_POST['name'];
$FTGemail = $_POST['email'];
$FTGsubject = $_POST['subject'];
$FTGmessage = $_POST['message'];
$FTGsubmit = $_POST['submit'];

# Redirect user to the error page

if ($validationFailed == true) {

 header("Location: error.shtml");
 exit;

}

# Email to Form Owner

$emailTo = '"Jellystone Park" <yogibear@jellystoneniagara.ca>';
#$emailTo = '"Jellystone Park" <calgoodman@gmail.com>';
#$emailTo = '"Jellystone Park" <jeffreytokar@gmail.com>';

$emailSubject = "Jellystone.ca Form Submission";

$emailBody = "name: $FTGname\n"
 . "email: $FTGemail\n"
 . "subject: $FTGsubject\n"
 . "message: $FTGmessage\n"
 . "\n\n"
 . "";

$emailHeader = "From: $FTGemail\n"
 . "Reply-To: $FTGemail\n"
 . "Content-type: text/plain; charset=\"ISO-8859-1\"\n"
 . "Content-transfer-encoding: quoted-printable;\n";

mail($emailTo, $emailSubject, $emailBody, $emailHeader);

# Redirect user to success page

header("Location: success.shtml");
exit;

# End of PHP script
?>