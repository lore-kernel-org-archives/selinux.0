Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id XAA04256
	for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 23:31:02 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id DAA12667
	for <selinux@tycho.nsa.gov>; Tue, 30 Apr 2002 03:29:13 GMT
Received: from mailandnews.com ([209.81.157.232])
	by jazzswing.ncsc.mil  with ESMTP id DAA12663
	for <selinux@tycho.nsa.gov>; Tue, 30 Apr 2002 03:29:12 GMT
Message-ID: <001201c1eff7$b0e765c0$780aa8c0@r213>
From: "f980215" <f980215@mailandnews.com>
To: <selinux@tycho.nsa.gov>
Subject: boot  messages and mount
Date: Tue, 30 Apr 2002 11:32:40 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi,all

1)

I install freeswan-selinux rpm packages  on redhat 7.2

when boot, found error messages:
=================================
Apr 28 21:05:16 sea2 ipsec: execvp: Permission denied
kernel: avc:  denied  { execute } for  pid=679 exe=/sbin/initlog path=/etc/rc.d/init.d/ipsec dev=03:43 ino=680615 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:var_lock_t tclass=file
Apr 28 20:27:09 sea2 ipsec: execvp: Permission denied
Apr 28 20:27:09 sea2 rc: Starting ipsec:  failed

then, 

after  

file_context.te: (add)
===============
/usr/local/sbin/ipsec system_u:object_r:ipsec_exec_t

initrc.te: (add)
==========
allow initrc_t var_lock_t:file { execute execute_no_trans };
allow initrc_t file_t:file { execute execute_no_trans };
allow initrc_t self:key_socket { create };

, 

when again boot, "ipsec startup succeeded"


2)
running mount command:
======================
        /dev/hdb3 on / type ext3 (rw)
        none on /proc type proc (rw)
        none on /dev/pts type devpts (rw,gid=5,mode=620)
        /dev/hdb1 on /mnt/hdb1 type vfat (rw)
        /dev/hdb5 on /mnt/hdb5 type vfat (rw)
        none on /dev/shm type tmpfs (rw)
        /dev/fd0 on /mnt/floppy type vfat (rw,nosuid,nodev)

ext3 filesystems is read/write, but other filesystems ( vfat ) is read-only

How to make other filesystems can be wrote?

f980215



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
