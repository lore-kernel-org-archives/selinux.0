Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h74L43Ha019023
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2003 17:04:03 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h74L2mFB023478
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2003 21:02:48 GMT
Received: from chris.pebenito.dhs.org (12-251-184-225.client.attbi.com [12.251.184.225])
	by jazzswing.ncsc.mil  with ESMTP id h74L2lGD023475
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2003 21:02:48 GMT
Subject: oops on policy load (PPC)
From: Chris PeBenito <pebenito@gentoo.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Message-Id: <1060029193.2997.206.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: 04 Aug 2003 15:33:14 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I get this oops on the first time the policy is loaded (2.6.0-test2-bk3
on PPC):

security:  4 users, 6 roles, 334 types
security:  30 classes, 22358 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev 0:d, type nfs), uses genfs_contexts
SELinux: initialized (dev , type rpc_pipefs), not configured for
labeling
SELinux: initialized (dev , type selinuxfs), uses genfs_contexts
Oops: kernel access of bad area, sig: 11 [#1]
NIP: C00F5208 LR: C00F5FFC SP: CCFD7C30 REGS: ccfd7b80 TRAP: 0301    Not
tainted
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 01000003, DSISR: 40000000
TASK = cd3eaa80[3202] 'load_policy' Last syscall: 4
GPR00: 0000000C CCFD7C30 CD3EAA80 01000003 FFFFFFFE C01E9BC8 CCFD7CD0
0000000A
GPR08: 00000000 01000003 FFFFFFFF CCFD7C68 53000033
Call trace:
 [c001a598] printk+0x9c/0x204
 [c00e5d30] superblock_doinit+0x184/0x270
 [c00eabe4] selinux_complete_init+0x108/0x220
 [c00f17f4] security_load_policy+0x10c/0x2f0
 [c00eb11c] sel_write_load+0xd4/0x118
 [c00561d0] vfs_write+0x10c/0x154
 [c00562cc] sys_write+0x40/0x74
 [c0005abc] ret_from_syscall+0x0/0x44
note: load_policy[3202] exited with preempt_count 1

The policy actually does get loaded, as I start getting denials.  It
looks like the oops is related to the filesystem initializations; if I
load the policy after this, it doesn't oops.  If I unmount /boot and
then mount it, the mount command hangs, and I dont get the kernel
messages saying that it was initialized for SELinux.


I also get a problem relabeling:

beta policy-dev # make relabel
/usr/sbin/setfiles file_contexts/file_contexts `mount | awk
'/ext[23]/{print $3}'`
/usr/sbin/setfiles:  Using extended attributes (default)
/usr/sbin/setfiles:  read 389 specifications
/usr/sbin/setfiles:  labeling files under /
/: Function not implemented
/usr/sbin/setfiles:  unable to obtain attribute for file /
/usr/sbin/setfiles:  error while labeling files under /
make: *** [relabel] Error 1

but I suspect its related to that oops, since it never says / is
initialized.  I can use getfattr and setfattr to manually set
security.selinux, so the xattr support is certainly enabled.

-- 
Chris PeBenito
<pebenito@gentoo.org>
Developer, SELinux
Hardened Gentoo Linux
 
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xE6AF9243
Key fingerprint = B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
