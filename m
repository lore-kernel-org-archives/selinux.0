Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6IDA6wv025332
	for <selinux@tycho.nsa.gov>; Sun, 18 Jul 2010 09:10:07 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o6IDC18q008116
	for <selinux@tycho.nsa.gov>; Sun, 18 Jul 2010 13:12:03 GMT
Received: from athena.localnet (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 8F3211811C
	for <selinux@tycho.nsa.gov>; Sun, 18 Jul 2010 23:09:59 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: libGL.so.1
Date: Sun, 18 Jul 2010 23:09:58 +1000
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201007182309.58829.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

type=AVC msg=audit(1279458495.111:24): avc:  denied  { execmem } for  pid=1801 
comm="ksmserver" scontext=unconfined_u:unconfined_r:unconfined_t:s0-
s0:c0.c1023 tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 
tclass=process
type=SYSCALL msg=audit(1279458495.111:24): arch=40000003 syscall=192 
success=no exit=-13 a0=b47ba000 a1=9000 a2=7 a3=812 items=0 ppid=1239 pid=1801 
auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 
tty=pts0 ses=4294967295 comm="ksmserver" exe="/usr/bin/ksmserver" 
subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)

# ksmserver 
ksmserver: error while loading shared libraries: libGL.so.1: failed to map 
segment from shared object: Permission denied

It seems that problems with libGL.so.1 have been around for a while, are these 
solvable without a huge amount of coding?

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
