Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9KGDtXZ001511
	for <selinux@tycho.nsa.gov>; Wed, 20 Oct 2004 12:13:55 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9KGCeui020893
	for <selinux@tycho.nsa.gov>; Wed, 20 Oct 2004 16:12:40 GMT
Subject: [PATCH][SELINUX] Add DAC check for setxattr(security.selinux)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
   lkml <linux-kernel@vger.kernel.org>, selinux@tycho.nsa.gov
Content-Type: text/plain
Message-Id: <1098288630.672.181.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 20 Oct 2004 12:10:31 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch against 2.6.9 adds a DAC ownership check to the existing MAC
permission checks when setting the security.selinux attribute via
setxattr.  In the past, the MAC permission checks were viewed as
sufficient for controlling relabeling operations, but experience in the
Fedora SELinux integration has shown that a DAC check is also
appropriate here, particularly under targeted policy.  Please apply.

Signed-off-by:  Stephen Smalley <sds@epoch.ncsc.mil>

 security/selinux/hooks.c |    3 +++
 1 files changed, 3 insertions(+)

--- linux-2.6.9/security/selinux/hooks.c.orig	2004-10-20 10:32:18.653598056 -0400
+++ linux-2.6.9/security/selinux/hooks.c	2004-10-20 10:32:39.712396632 -0400
@@ -2243,6 +2243,9 @@ static int selinux_inode_setxattr(struct
 	if (sbsec->behavior == SECURITY_FS_USE_MNTPOINT)
 		return -EOPNOTSUPP;
 
+	if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
+		return -EPERM;
+
 	AVC_AUDIT_DATA_INIT(&ad,FS);
 	ad.u.fs.dentry = dentry;
 

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
