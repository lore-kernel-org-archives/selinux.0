Received: from moss-spartans.epoch.ncsc.mil (moss-spartans [144.51.25.121])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jA7IHXMA026060
	for <selinux@tycho.nsa.gov>; Mon, 7 Nov 2005 13:17:33 -0500 (EST)
Subject: [Fwd: [patch 1/1] selinux:  Disable setxattr on mountpoint labeled
	filesystems]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Mon, 07 Nov 2005 13:07:43 -0500
Message-Id: <1131386863.20591.130.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

FYI, this patch has been submitted upstream in response to a previously
raised issue with exchanging media between non-MLS and MLS SELinux
systems, although the patch is more general than just that particular
case.

-------- Forwarded Message --------
From: Stephen Smalley <sds@tycho.nsa.gov>
To: lkml <linux-kernel@vger.kernel.org>, James Morris
<jmorris@namei.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 1/1] selinux: Disable setxattr on mountpoint labeled
filesystems
Date: Mon, 07 Nov 2005 11:20:43 -0500

This patch disables the setting of SELinux xattrs on files created in
filesystems labeled via mountpoint labeling (mounted with the context=
option).  selinux_inode_setxattr already prevents explicit setxattr from
userspace on such filesystems, so this provides consistent behavior for
file creation.  Please apply, for 2.6.15 if possible.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: James Morris <jmorris@namei.org>

---

 security/selinux/hooks.c |    3 +++
 1 files changed, 3 insertions(+)

Index: linux-2.6/security/selinux/hooks.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/hooks.c,v
retrieving revision 1.173
diff -u -p -r1.173 hooks.c
--- linux-2.6/security/selinux/hooks.c	31 Oct 2005 15:36:30 -0000	1.173
+++ linux-2.6/security/selinux/hooks.c	4 Nov 2005 20:55:20 -0000
@@ -1986,6 +1986,9 @@ static int selinux_inode_init_security(s
 
 	inode_security_set_sid(inode, newsid);
 
+	if (sbsec->behavior == SECURITY_FS_USE_MNTPOINT)
+		return -EOPNOTSUPP;
+
 	if (name) {
 		namep = kstrdup(XATTR_SELINUX_SUFFIX, GFP_KERNEL);
 		if (!namep)

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
