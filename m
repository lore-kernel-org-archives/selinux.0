Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8C6NI7e002999
	for <selinux@tycho.nsa.gov>; Mon, 12 Sep 2011 02:23:18 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p8C6NFl7015460
	for <selinux@tycho.nsa.gov>; Mon, 12 Sep 2011 06:23:16 GMT
Received: from xev.localnet (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 9848D18068
	for <selinux@tycho.nsa.gov>; Mon, 12 Sep 2011 16:23:12 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: sshd problem
Date: Mon, 12 Sep 2011 16:23:12 +1000
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201109121623.12511.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On a system running Debian/Squeeze (the latest stable release) I am seeing the 
following audit messages.  This happens when I run "ssh user@localhost" and 
enter something random in the password prompt.  When it happens one of the ssh 
privsep processes aborts and the tcp connection to port 22 is closed.  This 
doesn't seem to be a security problem.

type=AVC msg=audit(1315807424.338:39): avc:  denied  { unix_read unix_write } 
for  pid=1363 comm="sshd" key=58236  scontext=system_u:system_r:sshd_t:s0-
s0:c0.c1023 tcontext=system_u:system_r:unconfined_t:s0-s0:c0.c1023 tclass=shm
type=SYSCALL msg=audit(1315807424.338:39): arch=c000003e syscall=29 success=no 
exit=-131939286884392 a0=e37c a1=200048 a2=1b6 a3=0 items=0 ppid=627 pid=1363 
auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 
tty=(none) ses=4294967295 comm="sshd" exe="/usr/sbin/sshd" 
subj=system_u:system_r:sshd_t:s0-s0:c0.c1023 key=(null)
type=AVC msg=audit(1315807424.338:40): avc:  denied  { unix_read unix_write } 
for  pid=1363 comm="sshd" key=58771  scontext=system_u:system_r:sshd_t:s0-
s0:c0.c1023 tcontext=system_u:system_r:unconfined_t:s0-s0:c0.c1023 tclass=sem
type=SYSCALL msg=audit(1315807424.338:40): arch=c000003e syscall=64 success=no 
exit=-131939286884392 a0=e593 a1=8 a2=1b6 a3=0 items=0 ppid=627 pid=1363 
auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 
tty=(none) ses=4294967295 comm="sshd" exe="/usr/sbin/sshd" 
subj=system_u:system_r:sshd_t:s0-s0:c0.c1023 key=(null)
type=ANOM_ABEND msg=audit(1315807424.341:41): auid=4294967295 uid=0 gid=0 
ses=4294967295 subj=system_u:system_r:sshd_t:s0-s0:c0.c1023 pid=1363 
comm="sshd" sig=11

Below is the output of "ipcs|grep -v www-data".  The only shm and sem objects 
listed are the ones that interest us.

------ Shared Memory Segments --------
key        shmid      owner      perms      bytes      nattch     status      
0x0000e37c 0          root       666        2097224    0                       

------ Semaphore Arrays --------
key        semid      owner      perms      nsems     
0x0000e593 294921     root       666        8


I did a quick gdb run on the system in question.  I first ran "ssh 
user@localhost" and then I ran gdb on the first of the two "sshd: unknown 
[priv]" processes (which is the one that crashes).  After gdb was attached I 
entered a random password (the test account in question didn't exist so no 
password would get a login).

At the point of the crash gdb said:
Program received signal SIGTRAP, Trace/breakpoint trap.
0x000000000044e1b5 in ?? ()

After that I could use the "c" command in gdb to keep running and my ssh 
client would ask me for another password (the expected action).  When I did 
the same thing without gdb the sshd process would SEGV.

It seems that there is some debugging code enabled in ssh or it's libraries.

I just put some auditallow statements in local.te and rebooted to discover who 
is creating the shm/sem resources in question.  It seems that the ssh client 
is doing so!  Does anyone have any idea why the ssh client is creating shm/sem 
resources that the server uses?

type=AVC msg=audit(1315808317.426:28): avc:  granted  { create } for  pid=965 
comm="ssh" key=58771  scontext=system_u:system_r:unconfined_t:s0-s0:c0.c1023 
tcontext=system_u:system_r:unconfined_t:s0-s0:c0.c1023 tclass=sem
type=SYSCALL msg=audit(1315808317.426:28): arch=c000003e syscall=64 success=no 
exit=-131941352292392 a0=e593 a1=8 a2=7b6 a3=0 items=0 ppid=960 pid=965 
auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 
tty=pts0 ses=4294967295 comm="ssh" exe="/usr/bin/ssh" 
subj=system_u:system_r:unconfined_t:s0-s0:c0.c1023 key=(null)
type=AVC msg=audit(1315808317.426:29): avc:  granted  { create } for  pid=965 
comm="ssh" key=58236  scontext=system_u:system_r:unconfined_t:s0-s0:c0.c1023 
tcontext=system_u:system_r:unconfined_t:s0-s0:c0.c1023 tclass=shm
type=SYSCALL msg=audit(1315808317.426:29): arch=c000003e syscall=29 
success=yes exit=0 a0=e37c a1=200048 a2=7b6 a3=1 items=0 ppid=960 pid=965 
auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 
tty=pts0 ses=4294967295 comm="ssh" exe="/usr/bin/ssh" 
subj=system_u:system_r:unconfined_t:s0-s0:c0.c1023 key=(null)
type=AVC msg=audit(1315808317.426:30): avc:  denied  { unix_read unix_write } 
for  pid=968 comm="sshd" key=58236  scontext=system_u:system_r:sshd_t:s0-
s0:c0.c1023 tcontext=system_u:system_r:unconfined_t:s0-s0:c0.c1023 tclass=shm
type=AVC msg=audit(1315808317.430:31): avc:  denied  { unix_read unix_write } 
for  pid=968 comm="sshd" key=58771  scontext=system_u:system_r:sshd_t:s0-
s0:c0.c1023 tcontext=system_u:system_r:unconfined_t:s0-s0:c0.c1023 tclass=sem

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
