Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA22273
	for <selinux@tycho.nsa.gov>; Fri, 3 Jan 2003 09:53:02 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA22453
	for <selinux@tycho.nsa.gov>; Fri, 3 Jan 2003 14:50:23 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id OAA22449
	for <selinux@tycho.nsa.gov>; Fri, 3 Jan 2003 14:50:22 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id DD9849246B
	for <selinux@tycho.nsa.gov>; Sat,  4 Jan 2003 01:52:40 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 799F62168
	for <selinux@tycho.nsa.gov>; Fri,  3 Jan 2003 15:52:36 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
Subject: possible rlinetd security issue
Date: Fri, 3 Jan 2003 15:52:35 +0100
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200301031552.35892.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is for your interest.  A possible minor security bug that is shown (and 
solved) by SE Linux.

I have a Debian/woody machine that has all the latest security updates
installed.

rlinetd is running and has the following file handles open (among many
others):
rlinetd     508  root   10u  IPv4       5316                 TCP
X.X.121.50:discard->211.63.50.60:2286 (CLOSE_WAIT)
rlinetd     508  root   11u  IPv4       5317                 TCP
X.X.121.32:discard->211.63.50.60:2268 (CLOSE_WAIT)

Now I telnet in to the machine, and SE Linux logs the following messages:

Jan  2 03:01:13 XXX kernel: avc:  denied  { use } for  pid=22617
exe=/bin/login path=socket:[5316] dev=00:00 ino=5316
scontext=system_u:system_r:remote_login_t tcontext=system_u:system_r:inetd_t
tclass=fd

Jan  2 03:01:13 XXX kernel: avc:  denied  { use } for  pid=22617
exe=/bin/login path=socket:[5317] dev=00:00 ino=5317
scontext=system_u:system_r:remote_login_t tcontext=system_u:system_r:inetd_t
tclass=fd

This indicates that the file handles that were used for the discard service
were not set to close-on-exec.  They were not closed by rlinetd between
fork() and exec() either.  This is a bug in rlinetd.  It does not have any
immediate security implications, but if the rlinetd

rlinetd version 0.5.9
libc6 version 0.5.9
Linux version 2.4.19

I have not been able to duplicate this bug on Debian/unstable, and all the
Woody machines running rlinetd that I run have SE Linux to solve the problem.
So it's not something that overly concerns me.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
