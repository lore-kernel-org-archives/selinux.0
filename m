Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA23622
	for <selinux@tycho.nsa.gov>; Tue, 27 Nov 2001 09:21:35 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA08782
	for <selinux@tycho.nsa.gov>; Tue, 27 Nov 2001 14:20:56 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-imc.csoconline.com [140.169.2.142])
	by jazzband.ncsc.mil  with SMTP id OAA08778
	for <selinux@tycho.nsa.gov>; Tue, 27 Nov 2001 14:20:55 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A101524249@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: RedHat 7.2
Date: Tue, 27 Nov 2001 08:21:26 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have build the 2.4.16 kernel with the NSA and lsm modules.
In the utils selection I get the following error

m4/isc-posix.m4: 11: duplicated macro 'AC_ISC_POSIX'

Any Subjections ?????


I am using this kernel because is has the ext3 file system in the 
kernel. I am try to build a Redhat 7.2 system. After I can 
get it to boot I will work on the policy configuration.

Mark Westerman


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
