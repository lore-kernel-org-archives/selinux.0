Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA15612
	for <selinux@tycho.nsa.gov>; Mon, 20 Jan 2003 06:48:08 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA21350
	for <selinux@tycho.nsa.gov>; Mon, 20 Jan 2003 11:45:20 GMT
Received: from nox.lemuria.org (nox.lemuria.org [213.191.86.30])
	by jazzswing.ncsc.mil  with ESMTP id LAA21346
	for <selinux@tycho.nsa.gov>; Mon, 20 Jan 2003 11:45:19 GMT
Date: Mon, 20 Jan 2003 12:48:08 +0100
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Debian Kernel Images
Message-ID: <20030120124808.A28400@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Somehow, the initrd process seems to mess with the SELinux stuff. When
I boot Brian's kernel (which uses initrd), I suddenly get lots of
errors, relating to unlabeled_t. My own kernel runs fine.

Now there is no unlabeled file on the filesystem. I scanned it
completely, just to be sure. Here's an excerpt from the syslog during
the boot process:

Jan 20 13:33:16 nsa3 kernel: hda: 39102336 sectors (20020 MB) w/1024KiB Cache, CHS=38792/16/63, UDMA(66)
Jan 20 13:33:16 nsa3 kernel: Partition check:
Jan 20 13:33:16 nsa3 kernel:  /dev/ide/host0/bus0/target0/lun0: [PTBL] [2586/240/63] p1 p2 p3 p4
Jan 20 13:33:16 nsa3 kernel: kjournald starting.  Commit interval 5 seconds
Jan 20 13:33:16 nsa3 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jan 20 13:33:16 nsa3 kernel: SELinux:  Completing initialization.
Jan 20 13:33:16 nsa3 kernel: security:  loading policy configuration from /etc/security/selinux/policy.12
Jan 20 13:33:16 nsa3 kernel: security:  policydb is compressed, decompressing...
Jan 20 13:33:16 nsa3 kernel: security:  decompressed 2523517 bytes
Jan 20 13:33:16 nsa3 kernel: security:  5 users, 5 roles, 637 types
Jan 20 13:33:16 nsa3 kernel: security:  29 classes, 103704 rules
Jan 20 13:33:16 nsa3 kernel: SELinux: initialized (dev 03:01, type ext3), uses PSIDs
Jan 20 13:33:16 nsa3 kernel: SELinux: initialized (dev 01:00, type cramfs), not configured for labeling
Jan 20 13:33:16 nsa3 kernel: SELinux: initialized (dev 00:07, type devpts), uses transition SIDs
Jan 20 13:33:16 nsa3 kernel: SELinux: initialized (dev 00:06, type devfs), uses genfs_contexts
Jan 20 13:33:16 nsa3 kernel: SELinux: initialized (dev 00:05, type pipefs), uses task SIDs
Jan 20 13:33:16 nsa3 kernel: SELinux: initialized (dev 00:04, type tmpfs), uses transition SIDs
Jan 20 13:33:16 nsa3 kernel: SELinux: initialized (dev 00:03, type sockfs), uses task SIDs
Jan 20 13:33:16 nsa3 kernel: SELinux: initialized (dev 00:02, type proc), uses genfs_contexts
Jan 20 13:33:16 nsa3 kernel: SELinux: initialized (dev 00:01, type bdev), not configured for labeling
Jan 20 13:33:16 nsa3 kernel: SELinux: initialized (dev 00:00, type rootfs), not configured for labeling
Jan 20 13:33:16 nsa3 kernel: 
Jan 20 13:33:16 nsa3 kernel: avc:  denied  { read } for  pid=1 exe=/sbin/init path=/ dev=00:00 ino=1 scontext=system_u:system_r:init_t tcontext=system_u:object_r:unlabeled_t tclass=dir
Jan 20 13:33:16 nsa3 kernel: 
Jan 20 13:33:16 nsa3 kernel: avc:  denied  { search } for  pid=1 exe=/sbin/init path=/var dev=03:01 ino=63873 scontext=system_u:system_r:init_t tcontext=system_u:object_r:file_t tclass=dir
Jan 20 13:33:16 nsa3 kernel: 
Jan 20 13:33:16 nsa3 kernel: avc:  denied  { use } for  pid=33 exe=/bin/bash path=/ dev=00:00 ino=1 scontext=system_u:system_r:initrc_t tcontext=system_u:system_r:kernel_t tclass=fd
Jan 20 13:33:16 nsa3 kernel: 
Jan 20 13:33:16 nsa3 kernel: avc:  denied  { read } for  pid=33 exe=/bin/bash path=/ dev=00:00 ino=1 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:unlabeled_t tclass=dir
Jan 20 13:33:16 nsa3 kernel: 
Jan 20 13:33:16 nsa3 kernel: avc:  denied  { use } for  pid=35 exe=/bin/mount path=/ dev=00:00 ino=1 scontext=system_u:system_r:mount_t tcontext=system_u:system_r:kernel_t tclass=fd
Jan 20 13:33:16 nsa3 kernel: 
Jan 20 13:33:16 nsa3 kernel: avc:  denied  { read } for  pid=35 exe=/bin/mount path=/ dev=00:00 ino=1 scontext=system_u:system_r:mount_t tcontext=system_u:object_r:unlabeled_t tclass=dir
Jan 20 13:33:16 nsa3 kernel: 
Jan 20 13:33:16 nsa3 kernel: avc:  denied  { use } for  pid=38 exe=/sbin/blockdev path=/ dev=00:00 ino=1 scontext=system_u:system_r:fsadm_t tcontext=system_u:system_r:kernel_t tclass=fd
Jan 20 13:33:16 nsa3 kernel: 
Jan 20 13:33:16 nsa3 kernel: avc:  denied  { read } for  pid=38 exe=/sbin/blockdev path=/ dev=00:00 ino=1 scontext=system_u:system_r:fsadm_t tcontext=system_u:object_r:unlabeled_t tclass=dir
Jan 20 13:33:16 nsa3 kernel: Adding Swap: 975232k swap-space (priority -1)
Jan 20 13:33:16 nsa3 kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
Jan 20 13:33:16 nsa3 kernel: 



-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
