Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA12847
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 18:05:01 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id XAA26437
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 23:04:23 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id XAA26425
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 23:04:21 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 5518C92749
	for <selinux@tycho.nsa.gov>; Sat, 19 Jan 2002 10:04:45 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 2772532FA2C
	for <selinux@tycho.nsa.gov>; Sat, 19 Jan 2002 00:04:36 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: <selinux@tycho.nsa.gov>
Subject: starting daemons under Debian
Date: Sat, 19 Jan 2002 00:04:35 +0100
MIME-Version: 1.0
Message-Id: <20020118230436.2772532FA2C@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am considering how to make SE Linux integrate smoothly with Debian 
regarding the startup of daemons.
 
Requiring everyone to change all their init scripts is out of the question of 
course.

One thing I have played with is setting the security contexts so that the 
daemon automatically changes to the correct domain on startup from the 
sysadm_t domain such as the following (and also a minor matching change to 
rbac to make it allow root:sysadm_r:sshd_t):

domain_auto_trans(sysadm_t , sshd_exec_t, sshd_t)

This is minorly ugly, involves more rules than I'd like, but has the benefit 
that running "sshd" at the command line gets the same result as 
"/etc/init.d/ssh start".

The other option is to divert /sbin/start-stop-daemon which is used by Debian 
for starting most (should be all) daemons.  Then my replacement script would 
call run_init to run the real start-stop-daemon.


Any comments on the relative merits of these two schemes?

I realise that the recommended way is probably run_init (it was written for a 
reason), but how bad an idea is it to not use it?

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
