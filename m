Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mAOGxKLu018292
	for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2008 11:59:20 -0500
Received: from house.lunarmania.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mAOGvMj8023855
	for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2008 16:57:23 GMT
Received: from 78-3-149-35.adsl.net.t-com.hr ([78.3.149.35] helo=[192.168.1.22])
	by house.lunarmania.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <warner@rubix.com>)
	id 1L4emC-0006oD-QF
	for selinux@tycho.nsa.gov; Mon, 24 Nov 2008 08:59:09 -0800
Message-ID: <492ADD56.1050403@rubix.com>
Date: Mon, 24 Nov 2008 17:59:02 +0100
From: Andy Warner <warner@rubix.com>
MIME-Version: 1.0
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: externally usable interfaces from 3rd party policy modules
Content-Type: multipart/alternative;
 boundary="------------020901070409070909020203"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020901070409070909020203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Is it possible to create a policy module, install it, and have its 
interfaces usable by other policy modules? In creating DBMS policy I 
would like to provide a high level interface to the DBMS user/developer 
that will allow them to create their site-specific DBMS policy in a 
modular fashion. At the same time I do not want to encourage them to 
directly edit the "base policy" for the DBMS.

In my attempt I simply created my "DBMS base policy" and installed it. I 
then created a "DBMS local policy" that uses interfaces from the DBMS 
base policy. The DBMS local policy fails to compile, failing at the 
first reference to an external interface. If I place all of the policy 
code in the DBMS base policy, everything works. Therefore, I am guessing 
that either there is no way to make the DBMS base policy interfaces 
externally usable or I need to perform an extra step that I am no aware of.

I realize I could modify the base fedora 9 policy and add my module, but 
this has been ruled out as an option.

As a side question, is it possible to generate the HTML "policy help" 
for my modules interfaces?

Thanks,

Andy

--------------020901070409070909020203
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body bgcolor="#ffffff" text="#000000">
<font face="Arial">Is it possible to create a policy module, install
it, and have its interfaces usable by other policy modules? In creating
DBMS policy I would like to provide a high level interface to the DBMS
user/developer that will allow them to create their site-specific DBMS
policy in a modular fashion. At the same time I do not want to
encourage them to directly edit the "base policy" for the DBMS.<br>
<br>
In my attempt I simply created my "DBMS base policy" and installed it.
I then created a "DBMS local policy" that uses interfaces from the DBMS
base policy. The DBMS local policy fails to compile, failing at the
first reference to an external interface. If I place all of the policy
code in the DBMS base policy, everything works. Therefore, I am
guessing that either there is no way to make the DBMS base policy
interfaces externally usable or I need to perform an extra step that I
am no aware of.<br>
<br>
I realize I could modify the base fedora 9 policy and add my module,
but this has been ruled out as an option.<br>
<br>
As a side question, is it possible to generate the HTML "policy help"
for my modules interfaces?<br>
<br>
Thanks,<br>
<br>
Andy<br>
</font>
</body>
</html>

--------------020901070409070909020203--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
