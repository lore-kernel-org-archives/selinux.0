Subject: Wierdness with lsm 2.5
From: Timothy Wood <timothy@hallcomp.com>
To: SELinux <SELinux@tycho.nsa.gov>
Content-Type: text/plain
Date: 10 Jul 2002 10:04:04 -0400
Message-Id: <1026309847.9320.67.camel@phobos>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Has anyone been using the 2.5 lsm since the last release?  I'm getting a
whole lot of errors the 2.4 never gave me.  Here are some of them.

-----md errors------

avc:  denied  { getattr } for  pid=121 exe=/sbin/fsck path=/dev/md0
dev=03:03 ino=66778 scontext=system_u:system_r:fsadm_t
tcontext=system_u:object_r:device_t tclass=blk_file

avc:  denied  { getattr } for  pid=121 exe=/sbin/fsck path=/dev/md10
dev=03:03 ino=65551 scontext=system_u:system_r:fsadm_t
tcontext=system_u:object_r:device_t tclass=blk_file

avc:  denied  { getattr } for  pid=121 exe=/sbin/fsck path=/dev/md0
dev=03:03 ino=66778 scontext=system_u:system_r:fsadm_t
tcontext=system_u:object_r:device_t tclass=blk_file

avc:  denied  { getattr } for  pid=121 exe=/sbin/fsck path=/dev/md1
dev=03:03 ino=65550 scontext=system_u:system_r:fsadm_t
tcontext=system_u:object_r:device_t tclass=blk_file

avc:  denied  { getattr } for  pid=121 exe=/sbin/fsck path=/dev/md2
dev=03:03 ino=66782 scontext=system_u:system_r:fsadm_t
tcontext=system_u:object_r:device_t tclass=blk_file

avc:  denied  { getattr } for  pid=121 exe=/sbin/fsck path=/dev/md3
dev=03:03 ino=66792 scontext=system_u:system_r:fsadm_t
tcontext=system_u:object_r:device_t tclass=blk_file

avc:  denied  { getattr } for  pid=121 exe=/sbin/fsck path=/dev/md4
dev=03:03 ino=66794 scontext=system_u:system_r:fsadm_t
tcontext=system_u:object_r:device_t tclass=blk_file

avc:  denied  { getattr } for  pid=121 exe=/sbin/fsck path=/dev/md5
dev=03:03 ino=65554 scontext=system_u:system_r:fsadm_t
tcontext=system_u:object_r:device_t tclass=blk_file

avc:  denied  { getattr } for  pid=121 exe=/sbin/fsck path=/dev/md6
dev=03:03 ino=65555 scontext=system_u:system_r:fsadm_t
tcontext=system_u:object_r:device_t tclass=blk_file

avc:  denied  { getattr } for  pid=121 exe=/sbin/fsck path=/dev/md7
dev=03:03 ino=65556 scontext=system_u:system_r:fsadm_t
tcontext=system_u:object_r:device_t tclass=blk_file

AVC: 501642 messages suppressed.

--------some wierd device -----------
(new thing in 2.5 kernel I guess, disks of some sort or another)

avc:  denied  { getattr } for  pid=121 exe=/sbin/fsck
path=/dev/cciss/c2d4p14 dev=03:03 ino=2425518
scontext=system_u:system_r:fsadm_t tcontext=system_u:object_r:device_t
tclass=blk_file

avc:  denied  { getattr } for  pid=121 exe=/sbin/fsck
path=/dev/cciss/c4d10p6 dev=03:03 ino=2425893
scontext=system_u:system_r:fsadm_t tcontext=system_u:object_r:device_t
tclass=blk_file

AVC: 626927 messages suppressed.

avc:  denied  { getattr } for  pid=121 exe=/sbin/fsck
path=/dev/cciss/c6d2p7 dev=03:03 ino=2426517
scontext=system_u:system_r:fsadm_t tcontext=system_u:object_r:device_t
tclass=blk_file

AVC: 627109 messages suppressed.

avc:  denied  { getattr } for  pid=121 exe=/sbin/fsck path=/dev/hitcd
dev=03:03 ino=66633 scontext=system_u:system_r:fsadm_t
tcontext=system_u:object_r:device_t tclass=blk_file


-------some other wierd thing.

avc:  denied  { sys_tty_config } for  pid=721 comm=sh capability=26
scontext=system_u:system_r:checkpc_t
tcontext=system_u:system_r:checkpc_t tclass=capability


There are several other "messages suppressed" messages and several other
things on the system that do not work.  for example I have two
partitions on this test machine, a /boot and a /.  The / mounts fine but
the /boot won't mount.  

Does anyone know off the top of their head what the /dev/cciss is for? 
I see a lot of disk devices noted in a solaris fashion (eg c0d0p0s2 etc
etc instead of hda1 hda2 etc etc) 

Any thoughts welcome.

Timothy,

BTW, I did install this overtop of my lsm2.4 so that maybe messed it up?


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
