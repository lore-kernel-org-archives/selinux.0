Received: from jazzdrum.ncsc.mil ([144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0GIG9Ii012163
	for <selinux@tycho.nsa.gov>; Sun, 16 Jan 2005 13:16:09 -0500 (EST)
Received: from hotmail.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0GIGBXU022966
	for <selinux@tycho.nsa.gov>; Sun, 16 Jan 2005 18:16:11 GMT
Message-ID: <BAY101-F18255CE2DCD9B803428707B48D0@phx.gbl>
From: "Albretch Mueller" <lbrtchx@hotmail.com>
To: selinux@tycho.nsa.gov
Subject: Java and SELinux
Date: Sun, 16 Jan 2005 18:15:54 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have been reading about SELinux, how to design a Trusted Computing Base 
(TCB) with it and the difficulties of setting up an OS-based ruled based 
security framework to control 'virtual machines' which basically take much 
of the responsibilities of a TCB off the Operating System.

I am more of an application developer kind of guy, but contrary to people's 
opinions I think you can indeed make SELinux and the JVM dance together 
pretty nicely, even better than regular OS-based applications since you 
would be instead of one, actually two walls by:

1._ actually using java security policies within the JVM

2._ constraining all native calls from the JVM to the actual OS through 
SELinux

I find this straightforward and doable with much difficulty or . . . what is 
it I am missing here?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
