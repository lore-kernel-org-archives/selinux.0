Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rBDJtOIV005525
	for <selinux@tycho.nsa.gov>; Fri, 13 Dec 2013 14:55:24 -0500
Subject: [PATCH] selinux: revert 102aefdda4d8275ce7d7100bc16c88c74272b260
To: selinux@tycho.nsa.gov
From: Paul Moore <pmoore@redhat.com>
Cc: jwboyer@fedoraproject.org
Date: Fri, 13 Dec 2013 14:55:20 -0500
Message-ID: <20131213195520.11231.81980.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Revert "selinux: consider filesystem subtype in policies"

This reverts commit 102aefdda4d8275ce7d7100bc16c88c74272b260.

Explanation from Eric Paris:

	SELinux policy can specify if it should use a filesystem's
	xattrs or not.  In current policy we have a specification that
	fuse should not use xattrs but fuse.glusterfs should use
	xattrs.  This patch has a bug in which non-glusterfs
	filesystems would match the rule saying fuse.glusterfs should
	use xattrs.  If both fuse and the particular filesystem in
	question are not written to handle xattr calls during the mount
	command, they will deadlock.

	I have fixed the bug to do proper matching, however I believe a
	revert is still the correct solution.  The reason I believe
	that is because the code still does not work.  The s_subtype is
	not set until after the SELinux hook which attempts to match on
	the ".gluster" portion of the rule.  So we cannot match on the
	rule in question.  The code is useless.

Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 security/selinux/hooks.c       |   40 +++++++++++++++++---------------------
 security/selinux/ss/services.c |   42 ++++------------------------------------
 2 files changed, 22 insertions(+), 60 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index bf0537d..756a6d2 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -96,10 +96,6 @@
 #include "audit.h"
 #include "avc_ss.h"
 
-#define SB_TYPE_FMT "%s%s%s"
-#define SB_SUBTYPE(sb) (sb->s_subtype && sb->s_subtype[0])
-#define SB_TYPE_ARGS(sb) sb->s_type->name, SB_SUBTYPE(sb) ? "." : "", SB_SUBTYPE(sb) ? sb->s_subtype : ""
-
 extern struct security_operations *security_ops;
 
 /* SECMARK reference count */
@@ -414,8 +410,8 @@ static int sb_finish_set_opts(struct super_block *sb)
 		   the first boot of the SELinux kernel before we have
 		   assigned xattr values to the filesystem. */
 		if (!root_inode->i_op->getxattr) {
-			printk(KERN_WARNING "SELinux: (dev %s, type "SB_TYPE_FMT") has no "
-			       "xattr support\n", sb->s_id, SB_TYPE_ARGS(sb));
+			printk(KERN_WARNING "SELinux: (dev %s, type %s) has no "
+			       "xattr support\n", sb->s_id, sb->s_type->name);
 			rc = -EOPNOTSUPP;
 			goto out;
 		}
@@ -423,22 +419,22 @@ static int sb_finish_set_opts(struct super_block *sb)
 		if (rc < 0 && rc != -ENODATA) {
 			if (rc == -EOPNOTSUPP)
 				printk(KERN_WARNING "SELinux: (dev %s, type "
-				       SB_TYPE_FMT") has no security xattr handler\n",
-				       sb->s_id, SB_TYPE_ARGS(sb));
+				       "%s) has no security xattr handler\n",
+				       sb->s_id, sb->s_type->name);
 			else
 				printk(KERN_WARNING "SELinux: (dev %s, type "
-				       SB_TYPE_FMT") getxattr errno %d\n", sb->s_id,
-				       SB_TYPE_ARGS(sb), -rc);
+				       "%s) getxattr errno %d\n", sb->s_id,
+				       sb->s_type->name, -rc);
 			goto out;
 		}
 	}
 
 	if (sbsec->behavior > ARRAY_SIZE(labeling_behaviors))
-		printk(KERN_ERR "SELinux: initialized (dev %s, type "SB_TYPE_FMT"), unknown behavior\n",
-		       sb->s_id, SB_TYPE_ARGS(sb));
+		printk(KERN_ERR "SELinux: initialized (dev %s, type %s), unknown behavior\n",
+		       sb->s_id, sb->s_type->name);
 	else
-		printk(KERN_DEBUG "SELinux: initialized (dev %s, type "SB_TYPE_FMT"), %s\n",
-		       sb->s_id, SB_TYPE_ARGS(sb),
+		printk(KERN_DEBUG "SELinux: initialized (dev %s, type %s), %s\n",
+		       sb->s_id, sb->s_type->name,
 		       labeling_behaviors[sbsec->behavior-1]);
 
 	sbsec->flags |= SE_SBINITIALIZED;
@@ -601,6 +597,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	const struct cred *cred = current_cred();
 	int rc = 0, i;
 	struct superblock_security_struct *sbsec = sb->s_security;
+	const char *name = sb->s_type->name;
 	struct inode *inode = sbsec->sb->s_root->d_inode;
 	struct inode_security_struct *root_isec = inode->i_security;
 	u32 fscontext_sid = 0, context_sid = 0, rootcontext_sid = 0;
@@ -659,8 +656,8 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 					     strlen(mount_options[i]), &sid);
 		if (rc) {
 			printk(KERN_WARNING "SELinux: security_context_to_sid"
-			       "(%s) failed for (dev %s, type "SB_TYPE_FMT") errno=%d\n",
-			       mount_options[i], sb->s_id, SB_TYPE_ARGS(sb), rc);
+			       "(%s) failed for (dev %s, type %s) errno=%d\n",
+			       mount_options[i], sb->s_id, name, rc);
 			goto out;
 		}
 		switch (flags[i]) {
@@ -807,8 +804,7 @@ out:
 out_double_mount:
 	rc = -EINVAL;
 	printk(KERN_WARNING "SELinux: mount invalid.  Same superblock, different "
-	       "security settings for (dev %s, type "SB_TYPE_FMT")\n", sb->s_id,
-	       SB_TYPE_ARGS(sb));
+	       "security settings for (dev %s, type %s)\n", sb->s_id, name);
 	goto out;
 }
 
@@ -2481,8 +2477,8 @@ static int selinux_sb_remount(struct super_block *sb, void *data)
 		rc = security_context_to_sid(mount_options[i], len, &sid);
 		if (rc) {
 			printk(KERN_WARNING "SELinux: security_context_to_sid"
-			       "(%s) failed for (dev %s, type "SB_TYPE_FMT") errno=%d\n",
-			       mount_options[i], sb->s_id, SB_TYPE_ARGS(sb), rc);
+			       "(%s) failed for (dev %s, type %s) errno=%d\n",
+			       mount_options[i], sb->s_id, sb->s_type->name, rc);
 			goto out_free_opts;
 		}
 		rc = -EINVAL;
@@ -2520,8 +2516,8 @@ out_free_secdata:
 	return rc;
 out_bad_option:
 	printk(KERN_WARNING "SELinux: unable to change security options "
-	       "during remount (dev %s, type "SB_TYPE_FMT")\n", sb->s_id,
-	       SB_TYPE_ARGS(sb));
+	       "during remount (dev %s, type=%s)\n", sb->s_id,
+	       sb->s_type->name);
 	goto out_free_opts;
 }
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 6db5546..fc5a63a 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2344,50 +2344,16 @@ int security_fs_use(struct super_block *sb)
 	struct ocontext *c;
 	struct superblock_security_struct *sbsec = sb->s_security;
 	const char *fstype = sb->s_type->name;
-	const char *subtype = (sb->s_subtype && sb->s_subtype[0]) ? sb->s_subtype : NULL;
-	struct ocontext *base = NULL;
 
 	read_lock(&policy_rwlock);
 
-	for (c = policydb.ocontexts[OCON_FSUSE]; c; c = c->next) {
-		char *sub;
-		int baselen;
-
-		baselen = strlen(fstype);
-
-		/* if base does not match, this is not the one */
-		if (strncmp(fstype, c->u.name, baselen))
-			continue;
-
-		/* if there is no subtype, this is the one! */
-		if (!subtype)
-			break;
-
-		/* skip past the base in this entry */
-		sub = c->u.name + baselen;
-
-		/* entry is only a base. save it. keep looking for subtype */
-		if (sub[0] == '\0') {
-			base = c;
-			continue;
-		}
-
-		/* entry is not followed by a subtype, so it is not a match */
-		if (sub[0] != '.')
-			continue;
-
-		/* whew, we found a subtype of this fstype */
-		sub++; /* move past '.' */
-
-		/* exact match of fstype AND subtype */
-		if (!strcmp(subtype, sub))
+	c = policydb.ocontexts[OCON_FSUSE];
+	while (c) {
+		if (strcmp(fstype, c->u.name) == 0)
 			break;
+		c = c->next;
 	}
 
-	/* in case we had found an fstype match but no subtype match */
-	if (!c)
-		c = base;
-
 	if (c) {
 		sbsec->behavior = c->v.behavior;
 		if (!c->sid[0]) {


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
