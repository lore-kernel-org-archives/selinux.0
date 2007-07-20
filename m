Message-ID: <46A0C494.7060000@redhat.com>
Date: Fri, 20 Jul 2007 10:20:04 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: [Fwd: cups AVC...]
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Kernel problem?

-------- Original Message --------
Subject: 	cups AVC...
Date: 	Fri, 20 Jul 2007 07:04:08 -0700
From: 	Tom London <selinux@gmail.com>
To: 	fedora-selinux <fedora-selinux-list@redhat.com>



Seem to be getting this one from cups.  Haven't seen 'anon_inodefs' before....

Printing to HP5MP seems to work however....

tom

type=AVC msg=audit(1184938825.408:32): avc:  denied  { ioctl } for
pid=5296 comm="cupsd" name="[eventpoll]" dev=anon_inodefs ino=385
scontext=system_u:system_r:cupsd_t:s0-s0:c0.c1023
tcontext=system_u:object_r:unlabeled_t:s0 tclass=file
type=SYSCALL msg=audit(1184938825.408:32): arch=40000003 syscall=54
success=no exit=-13 a0=1 a1=5401 a2=bfda72ac a3=bfda73cc items=0
ppid=5295 pid=5296 auid=500 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0
sgid=0 fsgid=0 tty=(none) comm="cupsd" exe="/usr/sbin/cupsd"
subj=system_u:system_r:cupsd_t:s0-s0:c0.c1023 key=(null)
type=AVC_PATH msg=audit(1184938825.408:32):  path="anon_inode:[eventpoll]"
type=LABEL_LEVEL_CHANGE msg=audit(1184938825.408:33): user pid=5296
uid=0 auid=500 subj=system_u:system_r:cupsd_t:s0-s0:c0.c1023
msg='printer=HP5MP uri=hp:/par/HP_LaserJet_5MP?device=/dev/parport0
banners=none,none range=unknown: exe="/usr/sbin/cupsd"
(hostname=localhost.localdomain, addr=127.0.0.1, terminal=?
res=success)'

-- 
Tom London

--
fedora-selinux-list mailing list
fedora-selinux-list@redhat.com
https://www.redhat.com/mailman/listinfo/fedora-selinux-list


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
