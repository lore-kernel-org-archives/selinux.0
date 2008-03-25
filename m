Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2PD1YkG031850
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2008 09:01:34 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2PD1Sh6028786
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2008 13:01:28 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1) with ESMTP id m2PCxdl1011201
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2008 08:59:39 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1/Submit) id m2PCxdpS011200
	for selinux@tycho.nsa.gov; Tue, 25 Mar 2008 08:59:39 -0400
Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2P4Nf5E008120
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2008 00:23:41 -0400
Received: from nospam.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2P4NcmL016942
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2008 04:23:39 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: ls in Debian/Unstable
Date: Tue, 25 Mar 2008 15:23:32 +1100
Cc: Jim Meyering <jim@meyering.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200803251523.34329.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

unstable0:~/coreutils-6.10# ls -l /
total 158
drwxr-xr-x+  2 root root  4096 2008-03-25 10:02 bin
drwxr-xr-x+  6 root root  1024 2008-03-21 12:30 boot
drwxr-xr-x+ 16 root root  3700 2008-03-25 13:38 dev
drwxr-xr-x+ 80 root root  4096 2008-03-25 13:38 etc
drwxr-xr-x+  3 root root  4096 2008-02-15 22:08 home

In Debian/Unstable the output of "ls -l" is as above, the "+" indicates a SE 
Linux security context - which doesn't do much good when every file has one.

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=472590

The above URL has the Debian bug report with a patch.

If you wish to add additional comments then email sent to 
472590@bugs.debian.org will be appended.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
