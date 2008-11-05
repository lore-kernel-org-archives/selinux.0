Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mA5FXPlX007519
	for <selinux@tycho.nsa.gov>; Wed, 5 Nov 2008 10:33:25 -0500
Received: from house.lunarmania.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mA5FVk1q020588
	for <selinux@tycho.nsa.gov>; Wed, 5 Nov 2008 15:31:46 GMT
Received: from 78-3-234-122.adsl.net.t-com.hr ([78.3.234.122] helo=[192.168.1.22])
	by house.lunarmania.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <warner@rubix.com>)
	id 1KxkNh-00036n-7X
	for selinux@tycho.nsa.gov; Wed, 05 Nov 2008 07:33:18 -0800
Message-ID: <4911BCB9.1060407@rubix.com>
Date: Wed, 05 Nov 2008 16:33:13 +0100
From: Andy Warner <warner@rubix.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: using roles with mls policy
Content-Type: multipart/alternative;
 boundary="------------000804000303020401040503"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000804000303020401040503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I am using Fedora 9 with the MLS policy. I have been using it in 
permissive mode for a while (integrating SELinux with a DBMS and its 
objects) and now must do some work/testing in enforcing mode. As soon as 
I switch to enforcing mode I seem unable to perform any action which 
requires privilege.

What is the anticipated method to shutdown/reboot the system and to 
toggle the enforcing mode while in MLS/Enforcing? What I assumed was to 
transition to an appropriate role (sysadm_r and secadm_r respectively) 
and then issue the corresponding command (shutdown and setenforce). This 
fails and I believe my difficulty is that in both cases I need to also 
be the linux root user. There does not seem to be an obvious way to 
execute a command as the lunux root user as neither su nor sudo seem 
available while in the sysadm_r and secadm_r roles. Executing something 
like seaudit while in the auditadm_r role fails to allow me to 
authenticate as root. Despite being the correct password it continuously 
loops asking for the password.

As a related but less important question, in general, is it intended 
that a user initially have the staff_r role upon login and then 
transition to a more trusted role (i.e., secadm_r) using the newrole 
command? (as opposed to having the secadm_r upon login.

Thanks for any help,

Andy



--------------000804000303020401040503
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body bgcolor="#ffffff" text="#000000">
<font face="Arial">I am using Fedora 9 with the MLS policy. I have been
using it in permissive mode for a while (integrating SELinux with a
DBMS and its objects) and now must do some work/testing in enforcing
mode. As soon as I switch to enforcing mode I seem unable to perform
any action which requires privilege. <br>
<br>
What is the anticipated method to shutdown/reboot the system and to
toggle the enforcing mode while in MLS/Enforcing? What I assumed was to
transition to an appropriate role (sysadm_r and secadm_r respectively)
and then issue the corresponding command (shutdown and setenforce).
This fails and I believe my difficulty is that in both cases I need to
also be the linux root user. There does not seem to be an obvious way
to execute a command as the lunux root user as neither su nor sudo seem
available while in the sysadm_r and secadm_r roles. Executing something
like seaudit while in the auditadm_r role fails to allow me to
authenticate as root. Despite being the correct password it
continuously loops asking for the password. <br>
<br>
As a related but less important question, in general, is it intended
that a user initially have the staff_r role upon login and then
transition to a more trusted role (i.e., secadm_r) using the newrole
command? (as opposed to having the secadm_r upon login.<br>
<br>
Thanks for any help,<br>
<br>
Andy<br>
<br>
<br>
</font>
</body>
</html>

--------------000804000303020401040503--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
