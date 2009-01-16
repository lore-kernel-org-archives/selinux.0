From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: jmorris@namei.org, sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        "David P. Quigley" <dpquigl@tycho.nsa.gov>
Subject: [PATCH 1/3] SELinux: Condense super block security structure flags and cleanup necessary code.
Date: Fri, 16 Jan 2009 09:22:02 -0500
Message-Id: <1232115724-2621-2-git-send-email-dpquigl@tycho.nsa.gov>
In-Reply-To: <1232115724-2621-1-git-send-email-dpquigl@tycho.nsa.gov>
References: <1232115724-2621-1-git-send-email-dpquigl@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The super block security structure currently has three fields for what are
essentially flags.  The flags field is used for mount options while two other
char fields are used for initialization and proc flags. These latter two fields are
essentially bit fields since the only used values are 0 and 1.  These fields
have been collapsed into the flags field and new bit masks have been added for
them. The code is also fixed to work with these new flags.

Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
---
 security/selinux/hooks.c            |   38 ++++++++++++++++------------------
 security/selinux/include/objsec.h   |    2 -
 security/selinux/include/security.h |    6 +++++
 3 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0081597..473adc5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -431,7 +431,7 @@ static int sb_finish_set_opts(struct super_block *sb)
 		}
 	}
 
-	sbsec->initialized = 1;
+	sbsec->flags |= SE_SBINITIALIZED;
 
 	if (sbsec->behavior > ARRAY_SIZE(labeling_behaviors))
 		printk(KERN_ERR "SELinux: initialized (dev %s, type %s), unknown behavior\n",
@@ -487,17 +487,13 @@ static int selinux_get_mnt_opts(const struct super_block *sb,
 
 	security_init_mnt_opts(opts);
 
-	if (!sbsec->initialized)
+	if (!(sbsec->flags & SE_SBINITIALIZED))
 		return -EINVAL;
 
 	if (!ss_initialized)
 		return -EINVAL;
 
-	/*
-	 * if we ever use sbsec flags for anything other than tracking mount
-	 * settings this is going to need a mask
-	 */
-	tmp = sbsec->flags;
+	tmp = sbsec->flags & SE_MNTMASK;
 	/* count the number of mount options for this sb */
 	for (i = 0; i < 8; i++) {
 		if (tmp & 0x01)
@@ -562,8 +558,10 @@ out_free:
 static int bad_option(struct superblock_security_struct *sbsec, char flag,
 		      u32 old_sid, u32 new_sid)
 {
+	char mnt_flags = sbsec->flags & SE_MNTMASK;
+
 	/* check if the old mount command had the same options */
-	if (sbsec->initialized)
+	if (sbsec->flags & SE_SBINITIALIZED)
 		if (!(sbsec->flags & flag) ||
 		    (old_sid != new_sid))
 			return 1;
@@ -571,8 +569,8 @@ static int bad_option(struct superblock_security_struct *sbsec, char flag,
 	/* check if we were passed the same options twice,
 	 * aka someone passed context=a,context=b
 	 */
-	if (!sbsec->initialized)
-		if (sbsec->flags & flag)
+	if (!(sbsec->flags & SE_SBINITIALIZED))
+		if (mnt_flags & flag)
 			return 1;
 	return 0;
 }
@@ -626,7 +624,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	 * this sb does not set any security options.  (The first options
 	 * will be used for both mounts)
 	 */
-	if (sbsec->initialized && (sb->s_type->fs_flags & FS_BINARY_MOUNTDATA)
+	if ((sbsec->flags & SE_SBINITIALIZED) && (sb->s_type->fs_flags & FS_BINARY_MOUNTDATA)
 	    && (num_opts == 0))
 		goto out;
 
@@ -690,19 +688,19 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 		}
 	}
 
-	if (sbsec->initialized) {
+	if (sbsec->flags & SE_SBINITIALIZED) {
 		/* previously mounted with options, but not on this attempt? */
-		if (sbsec->flags && !num_opts)
+		if ((sbsec->flags & SE_MNTMASK) && !num_opts)
 			goto out_double_mount;
 		rc = 0;
 		goto out;
 	}
 
 	if (strcmp(sb->s_type->name, "proc") == 0)
-		sbsec->proc = 1;
+		sbsec->flags |= SE_SBPROC;
 
 	/* Determine the labeling behavior to use for this filesystem type. */
-	rc = security_fs_use(sbsec->proc ? "proc" : sb->s_type->name, &sbsec->behavior, &sbsec->sid);
+	rc = security_fs_use((sbsec->flags & SE_SBPROC) ? "proc" : sb->s_type->name, &sbsec->behavior, &sbsec->sid);
 	if (rc) {
 		printk(KERN_WARNING "%s: security_fs_use(%s) returned %d\n",
 		       __func__, sb->s_type->name, rc);
@@ -806,10 +804,10 @@ static void selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
 	}
 
 	/* how can we clone if the old one wasn't set up?? */
-	BUG_ON(!oldsbsec->initialized);
+	BUG_ON(!(oldsbsec->flags & SE_SBINITIALIZED));
 
 	/* if fs is reusing a sb, just let its options stand... */
-	if (newsbsec->initialized)
+	if (newsbsec->flags & SE_SBINITIALIZED)
 		return;
 
 	mutex_lock(&newsbsec->lock);
@@ -1209,7 +1207,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 		goto out_unlock;
 
 	sbsec = inode->i_sb->s_security;
-	if (!sbsec->initialized) {
+	if (!(sbsec->flags & SE_SBINITIALIZED)) {
 		/* Defer initialization until selinux_complete_init,
 		   after the initial policy is loaded and the security
 		   server is ready to handle calls. */
@@ -1326,7 +1324,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 		/* Default to the fs superblock SID. */
 		isec->sid = sbsec->sid;
 
-		if (sbsec->proc && !S_ISLNK(inode->i_mode)) {
+		if ((sbsec->flags & SE_SBPROC) && !S_ISLNK(inode->i_mode)) {
 			struct proc_inode *proci = PROC_I(inode);
 			if (proci->pde) {
 				isec->sclass = inode_mode_to_security_class(inode->i_mode);
@@ -2585,7 +2583,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 	}
 
 	/* Possibly defer initialization to selinux_complete_init. */
-	if (sbsec->initialized) {
+	if (sbsec->flags & SE_SBINITIALIZED) {
 		struct inode_security_struct *isec = inode->i_security;
 		isec->sclass = inode_mode_to_security_class(inode->i_mode);
 		isec->sid = newsid;
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 3cc4516..c4e0623 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -60,9 +60,7 @@ struct superblock_security_struct {
 	u32 def_sid;			/* default SID for labeling */
 	u32 mntpoint_sid;		/* SECURITY_FS_USE_MNTPOINT context for files */
 	unsigned int behavior;		/* labeling behavior */
-	unsigned char initialized;	/* initialization flag */
 	unsigned char flags;		/* which mount options were specified */
-	unsigned char proc;		/* proc fs */
 	struct mutex lock;
 	struct list_head isec_head;
 	spinlock_t isec_lock;
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 7244737..ff4e19c 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -37,10 +37,16 @@
 #define POLICYDB_VERSION_MAX	POLICYDB_VERSION_BOUNDARY
 #endif
 
+/* Mask for just the mount related flags */
+#define SE_MNTMASK	0x0f
+/* Super block security struct flags for mount options */
 #define CONTEXT_MNT	0x01
 #define FSCONTEXT_MNT	0x02
 #define ROOTCONTEXT_MNT	0x04
 #define DEFCONTEXT_MNT	0x08
+/* Non-mount related flags */
+#define SE_SBINITIALIZED	0x10
+#define SE_SBPROC		0x20
 
 #define CONTEXT_STR	"context="
 #define FSCONTEXT_STR	"fscontext="
-- 
1.5.6.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
