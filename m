Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o85CUYcK019802
	for <selinux@tycho.nsa.gov>; Sun, 5 Sep 2010 08:30:45 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o85CUfvU024804
	for <selinux@tycho.nsa.gov>; Sun, 5 Sep 2010 12:30:42 GMT
Received: from athena.localnet (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id B92DE180A7
	for <selinux@tycho.nsa.gov>; Sun,  5 Sep 2010 22:30:21 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: /dev/xen/evtchn labelling in Debian and auditing
Date: Sun, 5 Sep 2010 22:30:20 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_c14gM4ZqjsyjlZB"
Message-Id: <201009052230.20602.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_c14gM4ZqjsyjlZB
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

I've got a problem in Debian/Squeeze that /dev/xen/evtchn isn't being labeled.  
Running restorecon on /dev after boot gives it the right label, but by that 
time the Xen daemons have already got themselves in a state where not much 
less than a reboot will get them going again.  So I decided to use the audit 
system to tell me what process creates the device node.

#!/bin/bash
mount /proc
mount / -o remount,rw
#auditctl -w /dev/xen -p w
/etc/init.d/auditd start
auditctl -l > /out
ps auxf >> out
ls -al /dev/xen >> out
exec /sbin/init

To try and track it down I used the above for init and the attached file is 
the result.  It seems that my auditctl rule from /etc/audit/audit.rules is 
being applied correctly and the device in question doesn't exist prior to 
starting auditd, but the below is the only audit result relevant to the watch.

type=SYSCALL msg=audit(1283678086.229:9): arch=40000003 syscall=5 success=yes 
exit=11 a0=b7741311 a1=8002 a2=0 a3=1 items=1 ppid=1 pid=1340 auid=4294967295 
uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) 
ses=4294967295 comm="xenstored" exe="/usr/lib/xen-4.0/bin/xenstored" 
key=(null)
type=CWD msg=audit(1283678086.229:9):  cwd="/"
type=PATH msg=audit(1283678086.229:9): item=0 name="/dev/xen/evtchn" 
inode=4370 dev=00:05 mode=020600 ouid=0 ogid=0 rdev=0a:38

Can anyone suggest why the auditing system isn't getting the creation of the 
device node?

Also as an aside I've temporarily disabled SE Linux on the test system just to 
make testing the auditing code a little easier (it reduces the amount of stuff 
in the logs).  Once I get the auditing doing what I want then I'll enable SE 
Linux again.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--Boundary-00=_c14gM4ZqjsyjlZB
Content-Type: text/plain;
  charset="UTF-8";
  name="out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="out"

LIST_RULES: exit,always dir=/dev/xen (0x8) perm=w
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         2  0.0  0.0      0     0 ?        S    19:14   0:00 [kthreadd]
root         3  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [migration/0]
root         4  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [ksoftirqd/0]
root         5  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [watchdog/0]
root         6  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [events/0]
root         7  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [cpuset]
root         8  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [khelper]
root         9  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [netns]
root        10  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [async/mgr]
root        11  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [pm]
root        12  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [xenwatch]
root        13  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [xenbus]
root        14  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [sync_supers]
root        15  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [bdi-default]
root        16  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [kintegrityd/0]
root        17  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [kblockd/0]
root        18  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [kacpid]
root        19  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [kacpi_notify]
root        20  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [kacpi_hotplug]
root        21  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [kseriod]
root        23  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [kondemand/0]
root        24  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [khungtaskd]
root        25  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [kswapd0]
root        26  0.0  0.0      0     0 ?        SN   19:14   0:00  \_ [ksmd]
root        27  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [aio/0]
root        28  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [crypto/0]
root        32  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [pciback_workque]
root        33  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [khvcd]
root       175  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [ksuspend_usbd]
root       176  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [khubd]
root       180  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [ata/0]
root       181  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [ata_aux]
root       182  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [scsi_eh_0]
root       183  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [scsi_eh_1]
root       210  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [kstriped]
root       213  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [kdmflush]
root       227  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [jbd2/dm-0-8]
root       228  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [ext4-dio-unwrit]
root       265  0.0  0.0      0     0 ?        S    19:14   0:00  \_ [kauditd]
root         1  5.8  0.6   2860  1212 ?        S    19:14   0:00 /bin/bash /doit
root       262  0.0  0.4  11744   836 ?        S<sl 19:14   0:00 /sbin/auditd
root       264  0.0  0.3  10064   704 ?        S<sl 19:14   0:00  \_ /sbin/audispd
root       275  0.0  0.4   2360   916 ?        R    19:14   0:00 ps auxf
total 0
drwxr-xr-x  2 root root     60 Sep  5 19:14 .
drwxr-xr-x 14 root root   2640 Sep  5 19:14 ..
crw-------  1 root root 10, 62 Sep  5 19:14 gntdev

--Boundary-00=_c14gM4ZqjsyjlZB--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
