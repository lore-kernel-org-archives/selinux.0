Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA06839
	for <selinux@tycho.nsa.gov>; Mon, 22 Jan 2001 12:45:22 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id RAA29325
	for <selinux@tycho.nsa.gov>; Mon, 22 Jan 2001 17:44:43 GMT
Received: from ms1-mdi-com.mdi.com ([64.90.21.69])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id RAA29320
	for <selinux@tycho.nsa.gov>; Mon, 22 Jan 2001 17:44:42 GMT
Received: from mdi.com ([10.0.0.91]) by ms1-mdi-com.mdi.com
          (Post.Office MTA v3.1.2 release (PO205-101c)
          ID# 0-45717U300L100S0) with ESMTP id AAA340
          for <selinux@tycho.nsa.gov>; Mon, 22 Jan 2001 12:45:45 -0500
Message-ID: <3A6C72B5.CD6911AC@mdi.com>
Date: Mon, 22 Jan 2001 12:49:41 -0500
From: "Ron W. Auld" <rauld@mdi.com>
MIME-Version: 1.0
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: File system security
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

I've been attempting to follow the various discussions here for
the last couple of weeks and I must admit I'm not having a great
deal of luck. However, what drew me to the list was the idea of
a Security Enhanced Linux. I was interested because of my
involvement in the development of the Secure UDF (Universal
Disk Format) file system. The UDF file system is most commonly
found on DVD-ROM's but is designed to allow media (primarily
optical) interchange among different operating systems. Some
of the features included in Secure UDF are: access control based
on various combinations of user, media, computer, and drive;
logging of operations pertaining to a given file and/or directory;
and data encryption. I can provide a more complete presentation
on the features if anyone desires it. My question is whether or
not there is a need for a secure file system in SELinux.

-- 
Ron W. Auld - Principal Software Engineer
Micro Design International, Inc.
mailto:rauld@mdi.com  PH:407.472.6000 x312
http://www.mdi.com       800.228.0891 x312

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
