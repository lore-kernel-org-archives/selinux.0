Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA28948
	for <selinux@tycho.nsa.gov>; Wed, 7 Nov 2001 07:12:25 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA18594
	for <selinux@tycho.nsa.gov>; Wed, 7 Nov 2001 12:11:49 GMT
Received: from liqwidkrystal.com (lan-202-144-29-194.maa.sify.net [202.144.29.194] (may be forged))
	by jazzband.ncsc.mil  with SMTP id MAA18590
	for <selinux@tycho.nsa.gov>; Wed, 7 Nov 2001 12:11:47 GMT
Date: Wed, 7 Nov 2001 17:41:52 +0530
From: "Chandrashekar B ." <chandra@liqwidkrystal.com>
To: selinux@tycho.nsa.gov
Subject: Problem with su program
Message-ID: <20011107174152.C6659@chandra.liqwidkrystal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi, The su program that comes with the selinux does not inherit resource
limitations 
set in /etc/security/limits.conf file, while the default su program that
comes with 
linux (found in /bin directory) understands and enforces them. 
Was this feature deliberately removed or is it a bug ?

I'm running the selinux patch for kernel 2.4.10 on RedHat Linux 6.1


Thanks in advance,
Chandrashekar B.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
