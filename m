Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h44BWbI4023682
	for <selinux@tycho.nsa.gov>; Sun, 4 May 2003 07:32:37 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h44BWa7R008626
	for <selinux@tycho.nsa.gov>; Sun, 4 May 2003 11:32:36 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h44BWVKP008623 for <selinux@tycho.nsa.gov>; Sun, 4 May 2003 11:32:32 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 7870FBF3D
	for <selinux@tycho.nsa.gov>; Sun,  4 May 2003 21:32:30 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 31437-01
 for <selinux@tycho.nsa.gov>; Sun,  4 May 2003 21:32:29 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 0EC0BBF11
	for <selinux@tycho.nsa.gov>; Sun,  4 May 2003 21:32:29 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id C25AF924AD
	for <selinux@tycho.nsa.gov>; Sun,  4 May 2003 21:32:28 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id A42827B32
	for <selinux@tycho.nsa.gov>; Sun,  4 May 2003 21:31:31 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: strange avc messages on oom
Date: Sun, 4 May 2003 21:31:30 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200305042131.30060.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following messages appeared after a kde process went into a loop and used 
all available memory.  The kde process names /usr/bin/kdeinit had the context 
rjc:user_r:user_t.  I don't know what pid 1169 was, but after logging out 
(killing all KDE processes) it was gone.

avc:  denied  { sys_admin } for  pid=1169 exe=/usr/bin/kdeinit capability=21 
scontext=system_u:system_r:nscd_t tcontext=system_u:system_r:nscd_t 
tclass=capability

avc:  denied  { sys_rawio } for  pid=1169 exe=/usr/bin/kdeinit capability=17 
scontext=system_u:system_r:nscd_t tcontext=system_u:system_r:nscd_t 
tclass=capability

avc:  denied  { sys_admin } for  pid=1169 exe=/usr/bin/kdeinit capability=21 
scontext=system_u:system_r:nscd_t tcontext=system_u:system_r:nscd_t 
tclass=capability
Out of Memory: Killed process 17695 (kdeinit).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
