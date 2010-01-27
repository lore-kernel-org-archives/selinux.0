Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o0R3CBMA028496
	for <selinux@tycho.nsa.gov>; Tue, 26 Jan 2010 22:12:15 -0500
Received: from house.lunarmania.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o0R3CFgP002320
	for <selinux@tycho.nsa.gov>; Wed, 27 Jan 2010 03:12:15 GMT
Received: from c-71-56-48-118.hsd1.ga.comcast.net ([71.56.48.118] helo=[192.168.1.100])
	by house.lunarmania.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <warner@rubix.com>)
	id 1NZyK9-0000Gp-Td
	for selinux@tycho.nsa.gov; Tue, 26 Jan 2010 19:12:10 -0800
Message-ID: <4B5FAF0A.8070402@rubix.com>
Date: Tue, 26 Jan 2010 22:12:10 -0500
From: Andy Warner <warner@rubix.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: odd behavior of newrole setting level
Content-Type: multipart/alternative;
 boundary="------------030805050706060409050909"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030805050706060409050909
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Can someone explain why the first newrole (newrole -l s0) from the
commands below fails while the second newrole (newrole -l SystemLow)
succeeds. I am using Fedora 12 fully updated, the mls policy and the
mcstrans label translation service. s0 is mapped to SystemLow.

Thanks,

Andy

$ id -Z
staff_u:staff_r:staff_t:SystemLow-SystemHigh
$ newrole -l s0
staff_u:staff_r:staff_t:s0-SystemHigh is not a valid context
$ newrole -l SystemLow
Password:
$ id -Z
staff_u:staff_r:staff_t:SystemLow-SystemHigh
$ newrole -l s0-s0
Password:
$ id -Z
staff_u:staff_r:staff_t:SystemLow





--------------030805050706060409050909
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
</head>
<body bgcolor="#ffffff" text="#000000">
<font face="Arial">Can someone explain why the first newrole (</font><font
 face="Arial">newrole -l s0) </font><font face="Arial">from the
commands below fails while the second newrole (</font><font face="Arial">newrole
-l SystemLow) </font><font face="Arial">succeeds. I am using Fedora 12
fully updated, the mls policy and the mcstrans label translation
service. s0 is mapped to SystemLow. <br>
<br>
Thanks,<br>
<br>
Andy<br>
<br>
$ id -Z<br>
staff_u:staff_r:staff_t:SystemLow-SystemHigh<br>
$ newrole -l s0<br>
staff_u:staff_r:staff_t:s0-SystemHigh is not a valid context<br>
$ newrole -l SystemLow<br>
Password: <br>
$ id -Z<br>
staff_u:staff_r:staff_t:SystemLow-SystemHigh<br>
$ newrole -l s0-s0<br>
Password: <br>
$ id -Z<br>
staff_u:staff_r:staff_t:SystemLow<br>
<br>
<br>
<br>
<br>
</font>
</body>
</html>

--------------030805050706060409050909--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
