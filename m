Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h44Gl1I4024111
	for <selinux@tycho.nsa.gov>; Sun, 4 May 2003 12:47:01 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h44Gl07R015823
	for <selinux@tycho.nsa.gov>; Sun, 4 May 2003 16:47:00 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h44GkkKP015815 for <selinux@tycho.nsa.gov>; Sun, 4 May 2003 16:46:58 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 37149BF3D
	for <selinux@tycho.nsa.gov>; Mon,  5 May 2003 02:46:45 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 31448-05
 for <selinux@tycho.nsa.gov>; Mon,  5 May 2003 02:46:43 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id C5192BF11
	for <selinux@tycho.nsa.gov>; Mon,  5 May 2003 02:46:43 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 955BF924AD
	for <selinux@tycho.nsa.gov>; Mon,  5 May 2003 02:46:42 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 90699801E
	for <selinux@tycho.nsa.gov>; Mon,  5 May 2003 02:45:44 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: strange avc messages on oom
Date: Mon, 5 May 2003 02:45:42 +1000
References: <200305042131.30060.russell@coker.com.au>
In-Reply-To: <200305042131.30060.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200305050245.42478.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 4 May 2003 21:31, Russell Coker wrote:
> The following messages appeared after a kde process went into a loop and
> used all available memory.  The kde process names /usr/bin/kdeinit had the
> context rjc:user_r:user_t.  I don't know what pid 1169 was, but after
> logging out (killing all KDE processes) it was gone.

It just happened again.  As you can see the PID and file name match up.  The 
context does not match, and the operations requested don't match up with 
either.

root@lyta:~# dmesg | tail | grep ...
avc:  denied  { sys_admin } for  pid=9656 exe=/usr/bin/kalarmd capability=21 
scontext=system_u:system_r:nscd_t tcontext=system_u:system_r:nscd_t 
tclass=capability
avc:  denied  { sys_rawio } for  pid=9656 exe=/usr/bin/kalarmd capability=17 
scontext=system_u:system_r:nscd_t tcontext=system_u:system_r:nscd_t 
tclass=capability
avc:  denied  { sys_admin } for  pid=9656 exe=/usr/bin/kalarmd capability=21 
scontext=system_u:system_r:nscd_t tcontext=system_u:system_r:nscd_t 
tclass=capability
avc:  denied  { sys_rawio } for  pid=9656 exe=/usr/bin/kalarmd capability=17 
scontext=system_u:system_r:nscd_t tcontext=system_u:system_r:nscd_t 
tclass=capability
avc:  denied  { sys_admin } for  pid=9656 exe=/usr/bin/kalarmd capability=21 
scontext=system_u:system_r:nscd_t tcontext=system_u:system_r:nscd_t 
tclass=capability
Out of Memory: Killed process 10439 (kdeinit).
root@lyta:~# !ps
ps ax --context | grep 9656
 9656    576 rjc:user_r:user_t                        kalarmd --login
10465    575 rjc:sysadm_r:sysadm_t                    grep 9656
root@lyta:~#

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
