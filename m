Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2OL1nx6006044
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 16:01:49 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h2OL1mR1024517
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 21:01:48 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h2OL1jj9024513 for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 21:01:46 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: SE Linux on ARM
Date: Mon, 24 Mar 2003 22:01:33 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200303242201.33705.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have back-ported the latest SE Linux kernel patch with both the ptrace 
updates and put it on my web site (and uploaded it to Debian).

I have also ported it to the 2.4.19 ARM kernel and put it on 
http://www.coker.com.au/arm/
One patch is for the main LSM and SE code, the other is for the ARM specific 
SE code, both patches are required.  They are separate for ease of 
management.

The following entry in /etc/ipkg.conf is for a feed of kernel packages based 
on the above patches:
src 2.4.19 http://adsl.coker.com.au/ipaq/

NB If you use this kernel then you should expect regular Oops's and occasional 
spontaneous reboots.  This is not due to my code but due to the main ARM 
kernel code (IMHO).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
