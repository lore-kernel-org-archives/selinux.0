Subject: [RFC PATCH] 2/2 rootcontext=
From: Eric Paris <eparis@parisplace.org>
To: selinux@tycho.nsa.gov
Cc: jmorris@namei.org, sds@tycho.nsa.gov
Content-Type: text/plain
Date: Wed, 28 Jun 2006 19:09:41 -0400
Message-Id: <1151536181.26384.50.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The second patch will introduce a new rootcontext= option to mounting.
This option will allow you to explicitly label the root inode of a FS
being mounted.  This was found to be useful for things like stateless
linux, see https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=190001
I'd like some close eyes on this patch, specifically because I had to
move the avc_has_perm() checks farther up the stack.  I'm also not sure
even if we want perms on this operation.  Right now you need the same
perms to use rootcontext= that you need to use chcon /mnt/point after
you mount.  I'm also not sure if this might be a good mechanism to
usefully mount a fs (with XATTR support) from a different machine that
had contexts that may not even exist on the mounting machine.

 hooks.c          |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 include/objsec.h |    1
 2 files changed, 56 insertions(+), 1 deletion(-)

--- linux-2.6.17-rootcontext/security/selinux/hooks.c.decouple	2006-06-28 17:59:31.000000000 -0400
+++ linux-2.6.17-rootcontext/security/selinux/hooks.c	2006-06-28 17:51:22.000000000 -0400
@@ -247,6 +247,7 @@ static int superblock_alloc_security(str
 	sbsec->sid = SECINITSID_UNLABELED;
 	sbsec->def_sid = SECINITSID_FILE;
 	sbsec->mntpoint_sid = SECINITSID_UNLABELED;
+	sbsec->root_sid = SECINITSID_UNLABELED;
 	sb->s_security = sbsec;
 
 	return 0;
@@ -320,12 +321,14 @@ enum {
 	Opt_context = 1,
 	Opt_fscontext = 2,
 	Opt_defcontext = 4,
+	Opt_rootcontext = 8,
 };
 
 static match_table_t tokens = {
 	{Opt_context, "context=%s"},
 	{Opt_fscontext, "fscontext=%s"},
 	{Opt_defcontext, "defcontext=%s"},
+	{Opt_rootcontext, "rootcontext=%s"},
 };
 
 #define SEL_MOUNT_FAIL_MSG "SELinux:  duplicate or incompatible mount options\n"
@@ -333,7 +336,7 @@ static match_table_t tokens = {
 static int try_context_mount(struct super_block *sb, void *data)
 {
 	char *context = NULL, *defcontext = NULL;
-	char *fscontext = NULL;
+	char *fscontext = NULL, *rootcontext = NULL;
 	const char *name;
 	u32 sid;
 	int alloc = 0, rc = 0, seen = 0;
@@ -407,6 +410,22 @@ static int try_context_mount(struct supe
 				seen |= Opt_fscontext;
 				break;
 
+			case Opt_rootcontext:
+				if (seen & Opt_rootcontext) {
+					rc = -EINVAL;
+					printk(KERN_WARNING SEL_MOUNT_FAIL_MSG);
+					goto out_free;
+				}
+				rootcontext = match_strdup(&args[0]);
+				if (!rootcontext) {
+					rc = -ENOMEM;
+					goto out_free;
+				}
+				if (!alloc)
+					alloc = 1;
+				seen |= Opt_fscontext;
+				break;
+
 			case Opt_defcontext:
 				if (sbsec->behavior != SECURITY_FS_USE_XATTR) {
 					rc = -EINVAL;
@@ -506,6 +525,23 @@ static int try_context_mount(struct supe
 			sbsec->behavior = SECURITY_FS_USE_MNTPOINT;
 	}
 
+	if (rootcontext) {
+		rc = security_context_to_sid(rootcontext, strlen(rootcontext), &sid);
+		if (rc) {
+			printk(KERN_WARNING "SELinux: security_context_to_sid"
+			       "(%s) failed for (dev %s, type %s) errno=%d\n",
+			       rootcontext, sb->s_id, name, rc);
+			goto out_free;
+		}
+
+		/* 
+		 * Security checking on this transition is done later in superblock_doinit()
+		 * since we don't actually know the root inode context we are relabeling from
+		 * until after inode_doinit_with_dentry() has been called on the root inode.
+		 */
+		sbsec->root_sid = sid;
+	}
+
 	if (defcontext) {
 		rc = security_context_to_sid(defcontext, strlen(defcontext), &sid);
 		if (rc) {
@@ -536,11 +572,14 @@ out_free:
 		kfree(context);
 		kfree(defcontext);
 		kfree(fscontext);
+		kfree(rootcontext);
 	}
 out:
 	return rc;
 }
 
+static int inode_security_set_sid(struct inode *inode, u32 sid);
+
 static int superblock_doinit(struct super_block *sb, void *data)
 {
 	struct superblock_security_struct *sbsec = sb->s_security;
@@ -619,6 +658,20 @@ static int superblock_doinit(struct supe
 	/* Initialize the root inode. */
 	rc = inode_doinit_with_dentry(sb->s_root->d_inode, sb->s_root);
 
+	/* Set the context on the root inode if mounted with rootcontext= */
+	if ((sbsec->root_sid != SECINITSID_UNLABELED) && !rc) {
+		struct inode_security_struct *isec = sb->s_root->d_inode->i_security;
+		struct task_security_struct *tsec = current->security;
+
+		rc = avc_has_perm(tsec->sid, isec->sid, SECCLASS_FILESYSTEM, 
+			FILESYSTEM__RELABELFROM, NULL);
+		if (!rc)
+			rc = avc_has_perm(tsec->sid, sbsec->root_sid, SECCLASS_FILESYSTEM,
+				FILESYSTEM__RELABELTO, NULL);
+		if (!rc)
+			inode_security_set_sid(sb->s_root->d_inode, sbsec->root_sid);
+	}
+
 	/* Initialize any other inodes associated with the superblock, e.g.
 	   inodes created prior to initial policy load or inodes created
 	   during get_sb by a pseudo filesystem that directly
@@ -1889,6 +1942,7 @@ static inline int selinux_option(char *o
 {
 	return (match_prefix("context=", sizeof("context=")-1, option, len) ||
 	        match_prefix("fscontext=", sizeof("fscontext=")-1, option, len) ||
+	        match_prefix("rootcontext=", sizeof("rootcontext=")-1, option, len) ||
 	        match_prefix("defcontext=", sizeof("defcontext=")-1, option, len));
 }
 
--- linux-2.6.17-rootcontext/security/selinux/include/objsec.h.decouple	2006-06-28 17:25:46.000000000 -0400
+++ linux-2.6.17-rootcontext/security/selinux/include/objsec.h	2006-06-28 17:49:32.000000000 -0400
@@ -59,6 +59,7 @@ struct superblock_security_struct {
 	u32 sid;			/* SID of file system superblock */
 	u32 def_sid;			/* default SID for labeling */
 	u32 mntpoint_sid;		/* SECURITY_FS_USE_MNTPOINT context for files */
+	u32 root_sid;			/* context of the root inode */
 	unsigned int behavior;          /* labeling behavior */
 	unsigned char initialized;      /* initialization flag */
 	unsigned char proc;             /* proc fs */



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
