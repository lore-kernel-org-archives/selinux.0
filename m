Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mA3BnlZK001564
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2008 06:49:47 -0500
Received: from house.lunarmania.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mA3Bm5TD025844
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2008 11:48:10 GMT
Received: from 83-131-241-229.adsl.net.t-com.hr ([83.131.241.229] helo=[192.168.1.22])
	by house.lunarmania.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <warner@rubix.com>)
	id 1Kwxw6-0000bV-W6
	for selinux@tycho.nsa.gov; Mon, 03 Nov 2008 03:49:35 -0800
Message-ID: <490EE548.60400@rubix.com>
Date: Mon, 03 Nov 2008 12:49:28 +0100
From: Andy Warner <warner@rubix.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Label Translation on Fedora 9
Content-Type: multipart/alternative;
 boundary="------------050700070302060603060007"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050700070302060603060007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I am running Fedora 9 with the MLS policy and see no evidence that the 
label translation is enabled. I am using the default setrans.conf and 
the "disable=1" flag is commented out.

Using the selinux_trans_to_raw (e.g., with a SystemHigh level) produces 
the exact same label string as passed in which will not pass validation 
(using s15:c0.c1023 will pass validation).

Trying id-Z followed by newrole produces:
id -Z
warner_u:secadm_r:secadm_t:s0-s15:c0.c1023

newrole -l SystemLow-SystemHigh
warner_u:secadm_r:secadm_t:SystemLow-SystemHigh is not a valid context

Is there something that must be done to activate label translation?

thanks

Andy

--------------050700070302060603060007
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body bgcolor="#ffffff" text="#000000">
<font face="Arial">I am running Fedora 9 with the MLS policy and see no
evidence that the label translation is enabled. I am using the default
setrans.conf and the "disable=1" flag is commented out.<br>
<br>
Using the selinux_trans_to_raw (e.g., with a SystemHigh level) produces
the exact same label string as passed in which will not pass validation
(using s15:c0.c1023 will pass validation). <br>
<br>
Trying id-Z followed by newrole produces:<br>
id -Z<br>
warner_u:secadm_r:secadm_t:s0-s15:c0.c1023<br>
<br>
newrole -l SystemLow-SystemHigh<br>
warner_u:secadm_r:secadm_t:</font><font face="Arial">SystemLow-SystemHigh
is not a valid context<br>
<br>
Is there something that must be done to activate label translation?<br>
<br>
thanks <br>
<br>
Andy<br>
</font>
</body>
</html>

--------------050700070302060603060007--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
