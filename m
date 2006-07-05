Subject: [PATCH] 1/2 decouple fscontext/context mount options
From: Eric Paris <eparis@parisplace.org>
To: selinux@tycho.nsa.gov
Cc: jmorris@namei.org, sds@tycho.nsa.gov
Content-Type: text/plain
Date: Wed, 05 Jul 2006 11:59:06 -0400
Message-Id: <1152115146.26384.152.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch will remove the conflict between fscontext and context mount
options.  If context= is specified without fscontext it will operate
just as before, if both are specified we will use mount point labeling
and all inodes will get the label specified by context=.   The
superblock will be labeled with the label of fscontext=, thus affecting
operations which check the superblock security context, such as
associate permissions.

Hopefully this addresses all of the concerns.

 security/selinux/hooks.c          |   68 +++++++++++++++++++++++++++++---------
 security/selinux/include/objsec.h |    3 +
 2 files changed, 55 insertions(+), 16 deletions(-)

--- linux-2.6.17/security/selinux/hooks.c.orig	2006-07-05 11:39:48.000000000 -0400
+++ linux-2.6.17/security/selinux/hooks.c	2006-07-05 11:40:03.000000000 -0400
@@ -246,6 +246,7 @@ static int superblock_alloc_security(str
 	sbsec->sb = sb;
 	sbsec->sid = SECINITSID_UNLABELED;
 	sbsec->def_sid = SECINITSID_FILE;
+	sbsec->mntpoint_sid = SECINITSID_UNLABELED;
 	sb->s_security = sbsec;
 
 	return 0;
@@ -329,9 +330,25 @@ static match_table_t tokens = {
 
 #define SEL_MOUNT_FAIL_MSG "SELinux:  duplicate or incompatible mount options\n"
 
+static int may_context_mount_sb_relabel(u32 sid, struct superblock_security_struct *sbsec,
+			struct task_security_struct *tsec)
+{
+	int rc;
+
+	rc = avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
+			  FILESYSTEM__RELABELFROM, NULL);
+	if (rc)
+		return rc;
+
+	rc = avc_has_perm(tsec->sid, sid, SECCLASS_FILESYSTEM,
+			  FILESYSTEM__RELABELTO, NULL);
+	return rc;
+}
+
 static int try_context_mount(struct super_block *sb, void *data)
 {
 	char *context = NULL, *defcontext = NULL;
+	char *fscontext = NULL;
 	const char *name;
 	u32 sid;
 	int alloc = 0, rc = 0, seen = 0;
@@ -374,7 +391,7 @@ static int try_context_mount(struct supe
 
 			switch (token) {
 			case Opt_context:
-				if (seen) {
+				if (seen & (Opt_context|Opt_defcontext)) {
 					rc = -EINVAL;
 					printk(KERN_WARNING SEL_MOUNT_FAIL_MSG);
 					goto out_free;
@@ -390,13 +407,13 @@ static int try_context_mount(struct supe
 				break;
 
 			case Opt_fscontext:
-				if (seen & (Opt_context|Opt_fscontext)) {
+				if (seen & Opt_fscontext) {
 					rc = -EINVAL;
 					printk(KERN_WARNING SEL_MOUNT_FAIL_MSG);
 					goto out_free;
 				}
-				context = match_strdup(&args[0]);
-				if (!context) {
+				fscontext = match_strdup(&args[0]);
+				if (!fscontext) {
 					rc = -ENOMEM;
 					goto out_free;
 				}
@@ -441,29 +458,46 @@ static int try_context_mount(struct supe
 	if (!seen)
 		goto out;
 
-	if (context) {
-		rc = security_context_to_sid(context, strlen(context), &sid);
+	/* sets the context of the superblock for the fs being mounted. */
+	if (fscontext) {
+		rc = security_context_to_sid(fscontext, strlen(fscontext), &sid);
 		if (rc) {
 			printk(KERN_WARNING "SELinux: security_context_to_sid"
 			       "(%s) failed for (dev %s, type %s) errno=%d\n",
-			       context, sb->s_id, name, rc);
+			       fscontext, sb->s_id, name, rc);
 			goto out_free;
 		}
 
-		rc = avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
-		                  FILESYSTEM__RELABELFROM, NULL);
+		rc = may_context_mount_sb_relabel(sid, sbsec, tsec);
 		if (rc)
 			goto out_free;
 
-		rc = avc_has_perm(tsec->sid, sid, SECCLASS_FILESYSTEM,
-		                  FILESYSTEM__RELABELTO, NULL);
+		sbsec->sid = sid;
+	}
+
+	/* 
+	 * Switch to using mount point labeling behavior.
+	 * sets the label used on all files below the mountpoint, and will set
+	 * the superblock context if not already set.
+	 */
+	if (context) {
+		rc = security_context_to_sid(context, strlen(context), &sid);
+		if (rc) {
+			printk(KERN_WARNING "SELinux: security_context_to_sid"
+			       "(%s) failed for (dev %s, type %s) errno=%d\n",
+			       context, sb->s_id, name, rc);
+			goto out_free;
+		}
+
+		rc = may_context_mount_sb_relabel(sid, sbsec, tsec);
 		if (rc)
 			goto out_free;
 
-		sbsec->sid = sid;
+		if (!fscontext)
+			sbsec->sid = sid;
+		sbsec->mntpoint_sid = sid;
 
-		if (seen & Opt_context)
-			sbsec->behavior = SECURITY_FS_USE_MNTPOINT;
+		sbsec->behavior = SECURITY_FS_USE_MNTPOINT;
 	}
 
 	if (defcontext) {
@@ -495,6 +529,7 @@ out_free:
 	if (alloc) {
 		kfree(context);
 		kfree(defcontext);
+		kfree(fscontext);
 	}
 out:
 	return rc;
@@ -876,8 +911,11 @@ static int inode_doinit_with_dentry(stru
 			goto out;
 		isec->sid = sid;
 		break;
+	case SECURITY_FS_USE_MNTPOINT:
+		isec->sid = sbsec->mntpoint_sid;
+		break;
 	default:
-		/* Default to the fs SID. */
+		/* Default to the fs superblock SID. */
 		isec->sid = sbsec->sid;
 
 		if (sbsec->proc) {
--- linux-2.6.17/security/selinux/include/objsec.h.orig	2006-07-05 11:39:48.000000000 -0400
+++ linux-2.6.17/security/selinux/include/objsec.h	2006-07-05 11:40:03.000000000 -0400
@@ -57,8 +57,9 @@ struct file_security_struct {
 struct superblock_security_struct {
 	struct super_block *sb;         /* back pointer to sb object */
 	struct list_head list;          /* list of superblock_security_struct */
-	u32 sid;              /* SID of file system */
+	u32 sid;			/* SID of file system superblock */
 	u32 def_sid;			/* default SID for labeling */
+	u32 mntpoint_sid;		/* SECURITY_FS_USE_MNTPOINT context for files */
 	unsigned int behavior;          /* labeling behavior */
 	unsigned char initialized;      /* initialization flag */
 	unsigned char proc;             /* proc fs */



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
