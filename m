Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7N6j3La015649
	for <selinux@tycho.nsa.gov>; Sat, 23 Aug 2003 02:45:04 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h7N6j2fF021199
	for <selinux@tycho.nsa.gov>; Sat, 23 Aug 2003 06:45:02 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h7N6j0Hd021193 for <selinux@tycho.nsa.gov>; Sat, 23 Aug 2003 06:45:01 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: 2.6.0-test4 is released
Date: Sat, 23 Aug 2003 16:44:20 +1000
Cc: Stephen Smalley <sds@epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200308231644.20214.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Changes of note from the changelog include:

Documentation on "early-userspace" (initramfs etc), of particular note to SE 
Linux users due to the way policy is loaded in 2.6.  It also has some 
interesting new support for nfs-root, not that it's relevant to this list 
while we lack support for labeled NFS.

Lots of ACPI and other power management related changes.

Lots of minor bug fixes in drivers.

<geert@linux-m68k.org> [PATCH] Make SELinux security module compile on m68k

Quite a few ARM changes, it sounds like ARM will be usable on 2.6.x soon, so I 
convert my iPaQ's to 2.6.x if I can get xattr going on jffs2.

Several fixes to cryptoloop.

<akpm@osdl.org>
   [PATCH] SELinux inode security init
   From: Stephen Smalley <sds@epoch.ncsc.mil>
   This patch reworks the SELinux module code that handles inodes initialized
   before the policy is initially loaded to also cover the case where a pseudo
   filesystem such as selinuxfs or nfsd directly populate themselves.
   The list of inode security structures is split into per-superblock lists
   associated with each superblock security structure, and the initialization
   is performed by superblock_doinit.

<akpm@osdl.org>
   [PATCH] Add SELinux entry to MAINTAINERS
   From: Stephen Smalley <sds@epoch.ncsc.mil>
   This patch adds a SELINUX entry to the MAINTAINERS file.

Some IPv6, IPSEC, and other networking bug fixes.

akpm@osdl.org>
   [PATCH] Fix SELinux avc_log_lock
   From: Stephen Smalley <sds@epoch.ncsc.mil>
   This patch fixes a bug in the SELinux access vector cache code, which was
   incorrectly using spin_lock_irq rather than spin_lock_irqsave for the
   avc_log_lock.  As this code can be called from hardirq (e.g.  from the
   file_send_sigiotask hook), we need irqsave/restore here.

<akpm@osdl.org>
   [PATCH] SELinux check behavior value
   From: Stephen Smalley <sds@epoch.ncsc.mil>
   This patch fixes a bug in the SELinux module by adding a check of the
   filesystem labeling behavior value obtained from the policy.



All the patches from 2.6.0-test3-selinux1.patch.gz apart from the patch for 
security/selinux/selinuxfs.c have been included in test4.  Steve, was the 
selinuxfs.c made obsolete by other patches or was it an omission?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
