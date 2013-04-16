Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r3H1sabw000386
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2013 21:54:58 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r3GMuTxr028436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2013 18:56:29 -0400
Date: Tue, 16 Apr 2013 18:56:19 -0400
From: Anand Avati <avati@redhat.com>
To: selinux@tycho.nsa.gov
Cc: eparis@redhat.com, dwalsh@redhat.com, kraman@redhat.com
Subject: [PATCH v2] selinux: consider filesystem subtype in policies
Message-ID: <20130416225619.GA30164@sh-el5.eng.rdu2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Not considering sub filesystem has the following limitation. Support
for SELinux in FUSE is dependent on the particular userspace
filesystem, which is identified by the subtype. For e.g, GlusterFS,
a FUSE based filesystem supports SELinux (by mounting and processing
FUSE requests in different threads, avoiding the mount time
deadlock), whereas other FUSE based filesystems (identified by a
different subtype) have the mount time deadlock.

By considering the subtype of the filesytem in the SELinux policies,
allows us to specify a filesystem subtype, in the following way:

fs_use_xattr fuse.glusterfs gen_context(system_u:object_r:fs_t,s0);

This way not all FUSE filesystems are put in the same bucket and
subjected to the limitations of the other subtypes.

Signed-off-by: Anand Avati <avati@redhat.com>
---
 security/selinux/hooks.c            |   46 +++++++++++++++++++----------------
 security/selinux/include/security.h |    2 +-
 security/selinux/ss/services.c      |   34 ++++++++++++++++++++++---
 3 files changed, 56 insertions(+), 26 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7171a95..e5d1384 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -94,6 +94,10 @@
 #include "audit.h"
 #include "avc_ss.h"
 
+#define SB_TYPE_FMT "%s%s%s"
+#define SB_SUBTYPE(sb) (sb->s_subtype && sb->s_subtype[0])
+#define SB_TYPE_ARGS(sb) sb->s_type->name, SB_SUBTYPE(sb) ? "." : "", SB_SUBTYPE(sb) ? sb->s_subtype : ""
+
 #define NUM_SEL_MNT_OPTS 5
 
 extern struct security_operations *security_ops;
@@ -367,8 +371,8 @@ static int sb_finish_set_opts(struct super_block *sb)
 		   the first boot of the SELinux kernel before we have
 		   assigned xattr values to the filesystem. */
 		if (!root_inode->i_op->getxattr) {
-			printk(KERN_WARNING "SELinux: (dev %s, type %s) has no "
-			       "xattr support\n", sb->s_id, sb->s_type->name);
+			printk(KERN_WARNING "SELinux: (dev %s, type "SB_TYPE_FMT") has no "
+			       "xattr support\n", sb->s_id, SB_TYPE_ARGS(sb));
 			rc = -EOPNOTSUPP;
 			goto out;
 		}
@@ -376,12 +380,12 @@ static int sb_finish_set_opts(struct super_block *sb)
 		if (rc < 0 && rc != -ENODATA) {
 			if (rc == -EOPNOTSUPP)
 				printk(KERN_WARNING "SELinux: (dev %s, type "
-				       "%s) has no security xattr handler\n",
-				       sb->s_id, sb->s_type->name);
+				       SB_TYPE_FMT") has no security xattr handler\n",
+				       sb->s_id, SB_TYPE_ARGS(sb));
 			else
 				printk(KERN_WARNING "SELinux: (dev %s, type "
-				       "%s) getxattr errno %d\n", sb->s_id,
-				       sb->s_type->name, -rc);
+				       SB_TYPE_FMT") getxattr errno %d\n", sb->s_id,
+				       SB_TYPE_ARGS(sb), -rc);
 			goto out;
 		}
 	}
@@ -389,11 +393,11 @@ static int sb_finish_set_opts(struct super_block *sb)
 	sbsec->flags |= (SE_SBINITIALIZED | SE_SBLABELSUPP);
 
 	if (sbsec->behavior > ARRAY_SIZE(labeling_behaviors))
-		printk(KERN_ERR "SELinux: initialized (dev %s, type %s), unknown behavior\n",
-		       sb->s_id, sb->s_type->name);
+		printk(KERN_ERR "SELinux: initialized (dev %s, type "SB_TYPE_FMT"), unknown behavior\n",
+		       sb->s_id, SB_TYPE_ARGS(sb));
 	else
-		printk(KERN_DEBUG "SELinux: initialized (dev %s, type %s), %s\n",
-		       sb->s_id, sb->s_type->name,
+		printk(KERN_DEBUG "SELinux: initialized (dev %s, type "SB_TYPE_FMT"), %s\n",
+		       sb->s_id, SB_TYPE_ARGS(sb),
 		       labeling_behaviors[sbsec->behavior-1]);
 
 	if (sbsec->behavior == SECURITY_FS_USE_GENFS ||
@@ -557,7 +561,6 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	const struct cred *cred = current_cred();
 	int rc = 0, i;
 	struct superblock_security_struct *sbsec = sb->s_security;
-	const char *name = sb->s_type->name;
 	struct inode *inode = sbsec->sb->s_root->d_inode;
 	struct inode_security_struct *root_isec = inode->i_security;
 	u32 fscontext_sid = 0, context_sid = 0, rootcontext_sid = 0;
@@ -610,8 +613,8 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 					     strlen(mount_options[i]), &sid);
 		if (rc) {
 			printk(KERN_WARNING "SELinux: security_context_to_sid"
-			       "(%s) failed for (dev %s, type %s) errno=%d\n",
-			       mount_options[i], sb->s_id, name, rc);
+			       "(%s) failed for (dev %s, type "SB_TYPE_FMT") errno=%d\n",
+			       mount_options[i], sb->s_id, SB_TYPE_ARGS(sb), rc);
 			goto out;
 		}
 		switch (flags[i]) {
@@ -671,10 +674,10 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 		sbsec->flags |= SE_SBPROC;
 
 	/* Determine the labeling behavior to use for this filesystem type. */
-	rc = security_fs_use((sbsec->flags & SE_SBPROC) ? "proc" : sb->s_type->name, &sbsec->behavior, &sbsec->sid);
+	rc = security_fs_use((sbsec->flags & SE_SBPROC) ? "proc" : sb->s_type->name, SB_SUBTYPE(sb) ? sb->s_subtype : NULL, &sbsec->behavior, &sbsec->sid);
 	if (rc) {
-		printk(KERN_WARNING "%s: security_fs_use(%s) returned %d\n",
-		       __func__, sb->s_type->name, rc);
+		printk(KERN_WARNING "%s: security_fs_use("SB_TYPE_FMT") returned %d\n",
+		       __func__, SB_TYPE_ARGS(sb), rc);
 		goto out;
 	}
 
@@ -747,7 +750,8 @@ out:
 out_double_mount:
 	rc = -EINVAL;
 	printk(KERN_WARNING "SELinux: mount invalid.  Same superblock, different "
-	       "security settings for (dev %s, type %s)\n", sb->s_id, name);
+	       "security settings for (dev %s, type "SB_TYPE_FMT")\n", sb->s_id,
+	       SB_TYPE_ARGS(sb));
 	goto out;
 }
 
@@ -2376,8 +2380,8 @@ static int selinux_sb_remount(struct super_block *sb, void *data)
 		rc = security_context_to_sid(mount_options[i], len, &sid);
 		if (rc) {
 			printk(KERN_WARNING "SELinux: security_context_to_sid"
-			       "(%s) failed for (dev %s, type %s) errno=%d\n",
-			       mount_options[i], sb->s_id, sb->s_type->name, rc);
+			       "(%s) failed for (dev %s, type "SB_TYPE_FMT") errno=%d\n",
+			       mount_options[i], sb->s_id, SB_TYPE_ARGS(sb), rc);
 			goto out_free_opts;
 		}
 		rc = -EINVAL;
@@ -2415,8 +2419,8 @@ out_free_secdata:
 	return rc;
 out_bad_option:
 	printk(KERN_WARNING "SELinux: unable to change security options "
-	       "during remount (dev %s, type=%s)\n", sb->s_id,
-	       sb->s_type->name);
+	       "during remount (dev %s, type "SB_TYPE_FMT")\n", sb->s_id,
+	       SB_TYPE_ARGS(sb));
 	goto out_free_opts;
 }
 
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 6d38851..5ec1877 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -170,7 +170,7 @@ int security_get_allow_unknown(void);
 #define SECURITY_FS_USE_NONE		5 /* no labeling support */
 #define SECURITY_FS_USE_MNTPOINT	6 /* use mountpoint labeling */
 
-int security_fs_use(const char *fstype, unsigned int *behavior,
+int security_fs_use(const char *fstype, const char *subtype, unsigned int *behavior,
 	u32 *sid);
 
 int security_genfs_sid(const char *fstype, char *name, u16 sclass,
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index b4feecc..f4e6b0b 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2324,25 +2324,51 @@ out:
 /**
  * security_fs_use - Determine how to handle labeling for a filesystem.
  * @fstype: filesystem type
+ * @subtype: filesystem subtype (e.g userspace FUSE filesystem)
  * @behavior: labeling behavior
  * @sid: SID for filesystem (superblock)
  */
 int security_fs_use(
 	const char *fstype,
+	const char *subtype,
 	unsigned int *behavior,
 	u32 *sid)
 {
 	int rc = 0;
 	struct ocontext *c;
+	struct ocontext *base = NULL;
+	int baselen;
+	char *sub;
 
 	read_lock(&policy_rwlock);
 
-	c = policydb.ocontexts[OCON_FSUSE];
-	while (c) {
-		if (strcmp(fstype, c->u.name) == 0)
+	for (c = policydb.ocontexts[OCON_FSUSE]; c; c = c->next) {
+		if (strcmp(fstype, c->u.name) == 0) {
+			if (!subtype)
+				/* exact match, no subtype requested */
+				break;
+			/* save this for now, in case we do not find
+			   a subtype match */
+			base = c;
+		}
+		if (!subtype)
+			continue;
+		sub = strchr(c->u.name, '.');
+		if (!sub)
+			/* not an entry with subtype */
+			continue;
+		baselen = (sub - c->u.name);
+		if (strncmp(fstype, c->u.name, baselen) || fstype[baselen])
+			/* fstype does not match */
+			continue;
+		sub++; /* move past '.' */
+		if (strcmp(subtype, sub) == 0)
+			/* exact match of fstype AND subtype */
 			break;
-		c = c->next;
 	}
+	if (!c)
+		/* in case we had found an fstype match but no subtype match */
+		c = base;
 
 	if (c) {
 		*behavior = c->v.behavior;
-- 
1.7.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
