Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n24C9jmj007478
	for <selinux@tycho.nsa.gov>; Wed, 4 Mar 2009 07:09:45 -0500
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n24C674t009681
	for <selinux@tycho.nsa.gov>; Wed, 4 Mar 2009 12:06:08 GMT
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id D4FF818097
	for <selinux@tycho.nsa.gov>; Wed,  4 Mar 2009 23:09:39 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 5967F21C70
	for <selinux@tycho.nsa.gov>; Wed,  4 Mar 2009 23:09:38 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: dbus reading /proc/X/cmdline
Date: Wed, 4 Mar 2009 23:09:33 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200903042309.37571.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Why does the dbus-daemon want to read the cmdline of every process that it 
talks to?  Is it something to allow or dontaudit?  It appears to work without 
allowing it.

type=AVC msg=audit(1236168464.840:83): avc:  denied  { search } for  pid=2757 
comm="dbus-daemon" name="2874" dev=proc ino=12535 
scontext=unconfined_u:unconfined_r:system_dbusd_t:s0-s0:c0.c1023 
tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=dir
type=AVC msg=audit(1236168464.840:83): avc:  denied  { read } for  pid=2757 
comm="dbus-daemon" name="cmdline" dev=proc ino=12536 
scontext=unconfined_u:unconfined_r:system_dbusd_t:s0-s0:c0.c1023 
tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=file
type=SYSCALL msg=audit(1236168464.840:83): arch=40000003 syscall=5 success=yes 
exit=16 a0=b8481fa0 a1=0 a2=b3a a3=b84826c0 items=0 ppid=1 pid=2757 
auid=4294967295 uid=103 gid=105 euid=103 suid=103 fsuid=103 egid=105 sgid=105 
fsgid=105 tty=(none) ses=4294967295 comm="dbus-daemon" 
exe="/usr/bin/dbus-daemon" 
subj=unconfined_u:unconfined_r:system_dbusd_t:s0-s0:c0.c1023 key=(null)

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
