Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3JKwT9X004025
 for <selinux@tycho.nsa.gov>; Tue, 19 Apr 2016 16:58:29 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C5BAFC05E16B
 for <selinux@tycho.nsa.gov>; Tue, 19 Apr 2016 20:58:25 +0000 (UTC)
Subject: [PATCH] selinux: don't revalidate an inode's label when explicitly
 setting it
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Tue, 19 Apr 2016 16:58:24 -0400
Message-ID: <146109950464.27582.1509630911792878943.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <paul@paul-moore.com>

There is no point in attempting to revalidate an inode's security
label when we are in the process of setting it.

Reported-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index fce7dc8..f8ecc0a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -297,6 +297,13 @@ static struct inode_security_struct *inode_security(struct inode *inode)
 	return inode->i_security;
 }
 
+static struct inode_security_struct *backing_inode_security_novalidate(struct dentry *dentry)
+{
+	struct inode *inode = d_backing_inode(dentry);
+
+	return inode->i_security;
+}
+
 /*
  * Get the security label of a dentry's backing inode.
  */
@@ -686,7 +693,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	struct superblock_security_struct *sbsec = sb->s_security;
 	const char *name = sb->s_type->name;
 	struct dentry *root = sbsec->sb->s_root;
-	struct inode_security_struct *root_isec = backing_inode_security(root);
+	struct inode_security_struct *root_isec;
 	u32 fscontext_sid = 0, context_sid = 0, rootcontext_sid = 0;
 	u32 defcontext_sid = 0;
 	char **mount_options = opts->mnt_opts;
@@ -729,6 +736,8 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	    && (num_opts == 0))
 		goto out;
 
+	root_isec = backing_inode_security_novalidate(root);
+
 	/*
 	 * parse the mount options, check if they are valid sids.
 	 * also check if someone is trying to mount the same sb more
@@ -3222,7 +3231,7 @@ out_nofree:
 static int selinux_inode_setsecurity(struct inode *inode, const char *name,
 				     const void *value, size_t size, int flags)
 {
-	struct inode_security_struct *isec = inode_security(inode);
+	struct inode_security_struct *isec = inode_security_novalidate(inode);
 	u32 newsid;
 	int rc;
 
