Subject: [PATCH] SELinux: whitespace and formating fixes for hooks.c
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Content-Type: text/plain
Date: Thu, 17 Apr 2008 13:17:49 -0400
Message-Id: <1208452669.2985.27.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

All whitespace and formatting.  Nothing interesting to see here.  About
the only thing to remember is that we aren't supposed to initialize
static variables to 0/NULL.  It is done for us and doing it ourselves
puts them in a different section.

With this patch running checkpatch.pl against hooks.c only gives us
complaints about busting the 80 character limit and declaring extern's
in .c files.  Apparently they don't like it, but I don't feel like going
to the trouble of moving those to .h files...

Signed-off-by: Eric Paris <eparis@redhat.com>

---

If anything doesn't apply James you can feel free to ignore the reject.
No hunk of this patch should in any way affect any other hunk....

 security/selinux/hooks.c |  497 +++++++++++++++++++++++-----------------------
 1 files changed, 246 insertions(+), 251 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 93cbefe..0c90dbe 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4,22 +4,22 @@
  *  This file contains the SELinux hook function implementations.
  *
  *  Authors:  Stephen Smalley, <sds@epoch.ncsc.mil>
- *            Chris Vance, <cvance@nai.com>
- *            Wayne Salamon, <wsalamon@nai.com>
- *            James Morris <jmorris@redhat.com>
+ *	      Chris Vance, <cvance@nai.com>
+ *	      Wayne Salamon, <wsalamon@nai.com>
+ *	      James Morris <jmorris@redhat.com>
  *
  *  Copyright (C) 2001,2002 Networks Associates Technology, Inc.
  *  Copyright (C) 2003 Red Hat, Inc., James Morris <jmorris@redhat.com>
  *  Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
- *                          <dgoeddel@trustedcs.com>
+ *			    <dgoeddel@trustedcs.com>
  *  Copyright (C) 2006, 2007 Hewlett-Packard Development Company, L.P.
- *                Paul Moore <paul.moore@hp.com>
+ *		Paul Moore <paul.moore@hp.com>
  *  Copyright (C) 2007 Hitachi Software Engineering Co., Ltd.
- *                     Yuichi Nakamura <ynakam@hitachisoft.jp>
+ *		       Yuichi Nakamura <ynakam@hitachisoft.jp>
  *
  *	This program is free software; you can redistribute it and/or modify
  *	it under the terms of the GNU General Public License version 2,
- *      as published by the Free Software Foundation.
+ *	as published by the Free Software Foundation.
  */
 
 #include <linux/init.h>
@@ -97,11 +97,11 @@ extern struct security_operations *security_ops;
 atomic_t selinux_secmark_refcount = ATOMIC_INIT(0);
 
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
-int selinux_enforcing = 0;
+int selinux_enforcing;
 
 static int __init enforcing_setup(char *str)
 {
-	selinux_enforcing = simple_strtol(str,NULL,0);
+	selinux_enforcing = simple_strtol(str, NULL, 0);
 	return 1;
 }
 __setup("enforcing=", enforcing_setup);
@@ -121,13 +121,13 @@ int selinux_enabled = 1;
 #endif
 
 /* Original (dummy) security module. */
-static struct security_operations *original_ops = NULL;
+static struct security_operations *original_ops;
 
 /* Minimal support for a secondary security module,
    just to allow the use of the dummy or capability modules.
    The owlsm module can alternatively be used as a secondary
    module as long as CONFIG_OWLSM_FD is not enabled. */
-static struct security_operations *secondary_ops = NULL;
+static struct security_operations *secondary_ops;
 
 /* Lists of inode and superblock security structures initialized
    before the policy was loaded. */
@@ -1034,7 +1034,7 @@ static int selinux_proc_get_sid(struct proc_dir_entry *de,
 	int buflen, rc;
 	char *buffer, *path, *end;
 
-	buffer = (char*)__get_free_page(GFP_KERNEL);
+	buffer = (char *)__get_free_page(GFP_KERNEL);
 	if (!buffer)
 		return -ENOMEM;
 
@@ -1164,7 +1164,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 			rc = 0;
 		} else {
 			rc = security_context_to_sid_default(context, rc, &sid,
-			                                     sbsec->def_sid);
+							     sbsec->def_sid);
 			if (rc) {
 				printk(KERN_WARNING "SELinux: %s:  context_to_sid(%s) "
 				       "returned %d for dev=%s ino=%ld\n",
@@ -1284,7 +1284,7 @@ static int task_has_capability(struct task_struct *tsk,
 
 	tsec = tsk->security;
 
-	AVC_AUDIT_DATA_INIT(&ad,CAP);
+	AVC_AUDIT_DATA_INIT(&ad, CAP);
 	ad.tsk = tsk;
 	ad.u.cap = cap;
 
@@ -1327,7 +1327,7 @@ static int inode_has_perm(struct task_struct *tsk,
 	struct inode_security_struct *isec;
 	struct avc_audit_data ad;
 
-	if (unlikely (IS_PRIVATE (inode)))
+	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
 
 	tsec = tsk->security;
@@ -1352,7 +1352,7 @@ static inline int dentry_has_perm(struct task_struct *tsk,
 {
 	struct inode *inode = dentry->d_inode;
 	struct avc_audit_data ad;
-	AVC_AUDIT_DATA_INIT(&ad,FS);
+	AVC_AUDIT_DATA_INIT(&ad, FS);
 	ad.u.fs.path.mnt = mnt;
 	ad.u.fs.path.dentry = dentry;
 	return inode_has_perm(tsk, inode, av, &ad);
@@ -1449,9 +1449,9 @@ static int may_create_key(u32 ksid,
 	return avc_has_perm(tsec->sid, ksid, SECCLASS_KEY, KEY__CREATE, NULL);
 }
 
-#define MAY_LINK   0
-#define MAY_UNLINK 1
-#define MAY_RMDIR  2
+#define MAY_LINK	0
+#define MAY_UNLINK	1
+#define MAY_RMDIR	2
 
 /* Check whether a task can link, unlink, or rmdir a file/directory. */
 static int may_link(struct inode *dir,
@@ -1655,7 +1655,7 @@ static int selinux_ptrace(struct task_struct *parent, struct task_struct *child)
 {
 	int rc;
 
-	rc = secondary_ops->ptrace(parent,child);
+	rc = secondary_ops->ptrace(parent, child);
 	if (rc)
 		return rc;
 
@@ -1663,7 +1663,7 @@ static int selinux_ptrace(struct task_struct *parent, struct task_struct *child)
 }
 
 static int selinux_capget(struct task_struct *target, kernel_cap_t *effective,
-                          kernel_cap_t *inheritable, kernel_cap_t *permitted)
+			  kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
 	int error;
 
@@ -1675,7 +1675,7 @@ static int selinux_capget(struct task_struct *target, kernel_cap_t *effective,
 }
 
 static int selinux_capset_check(struct task_struct *target, kernel_cap_t *effective,
-                                kernel_cap_t *inheritable, kernel_cap_t *permitted)
+				kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
 	int error;
 
@@ -1687,7 +1687,7 @@ static int selinux_capset_check(struct task_struct *target, kernel_cap_t *effect
 }
 
 static void selinux_capset_set(struct task_struct *target, kernel_cap_t *effective,
-                               kernel_cap_t *inheritable, kernel_cap_t *permitted)
+			       kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
 	secondary_ops->capset_set(target, effective, inheritable, permitted);
 }
@@ -1700,7 +1700,7 @@ static int selinux_capable(struct task_struct *tsk, int cap)
 	if (rc)
 		return rc;
 
-	return task_has_capability(tsk,cap);
+	return task_has_capability(tsk, cap);
 }
 
 static int selinux_sysctl_get_sid(ctl_table *table, u16 tclass, u32 *sid)
@@ -1709,7 +1709,7 @@ static int selinux_sysctl_get_sid(ctl_table *table, u16 tclass, u32 *sid)
 	char *buffer, *path, *end;
 
 	rc = -ENOMEM;
-	buffer = (char*)__get_free_page(GFP_KERNEL);
+	buffer = (char *)__get_free_page(GFP_KERNEL);
 	if (!buffer)
 		goto out;
 
@@ -1767,7 +1767,7 @@ static int selinux_sysctl(ctl_table *table, int op)
 
 	/* The op values are "defined" in sysctl.c, thereby creating
 	 * a bad coupling between this module and sysctl.c */
-	if(op == 001) {
+	if (op == 001) {
 		error = avc_has_perm(tsec->sid, tsid,
 				     SECCLASS_DIR, DIR__SEARCH, NULL);
 	} else {
@@ -1779,7 +1779,7 @@ static int selinux_sysctl(ctl_table *table, int op)
 		if (av)
 			error = avc_has_perm(tsec->sid, tsid,
 					     SECCLASS_FILE, av, NULL);
-        }
+	}
 
 	return error;
 }
@@ -1792,25 +1792,23 @@ static int selinux_quotactl(int cmds, int type, int id, struct super_block *sb)
 		return 0;
 
 	switch (cmds) {
-		case Q_SYNC:
-		case Q_QUOTAON:
-		case Q_QUOTAOFF:
-	        case Q_SETINFO:
-		case Q_SETQUOTA:
-			rc = superblock_has_perm(current,
-						 sb,
-						 FILESYSTEM__QUOTAMOD, NULL);
-			break;
-	        case Q_GETFMT:
-	        case Q_GETINFO:
-		case Q_GETQUOTA:
-			rc = superblock_has_perm(current,
-						 sb,
-						 FILESYSTEM__QUOTAGET, NULL);
-			break;
-		default:
-			rc = 0;  /* let the kernel handle invalid cmds */
-			break;
+	case Q_SYNC:
+	case Q_QUOTAON:
+	case Q_QUOTAOFF:
+	case Q_SETINFO:
+	case Q_SETQUOTA:
+		rc = superblock_has_perm(current, sb, FILESYSTEM__QUOTAMOD,
+					 NULL);
+		break;
+	case Q_GETFMT:
+	case Q_GETINFO:
+	case Q_GETQUOTA:
+		rc = superblock_has_perm(current, sb, FILESYSTEM__QUOTAGET,
+					 NULL);
+		break;
+	default:
+		rc = 0;  /* let the kernel handle invalid cmds */
+		break;
 	}
 	return rc;
 }
@@ -1829,23 +1827,23 @@ static int selinux_syslog(int type)
 		return rc;
 
 	switch (type) {
-		case 3:         /* Read last kernel messages */
-		case 10:        /* Return size of the log buffer */
-			rc = task_has_system(current, SYSTEM__SYSLOG_READ);
-			break;
-		case 6:         /* Disable logging to console */
-		case 7:         /* Enable logging to console */
-		case 8:		/* Set level of messages printed to console */
-			rc = task_has_system(current, SYSTEM__SYSLOG_CONSOLE);
-			break;
-		case 0:         /* Close log */
-		case 1:         /* Open log */
-		case 2:         /* Read from log */
-		case 4:         /* Read/clear last kernel messages */
-		case 5:         /* Clear ring buffer */
-		default:
-			rc = task_has_system(current, SYSTEM__SYSLOG_MOD);
-			break;
+	case 3:		/* Read last kernel messages */
+	case 10:	/* Return size of the log buffer */
+		rc = task_has_system(current, SYSTEM__SYSLOG_READ);
+		break;
+	case 6:		/* Disable logging to console */
+	case 7:		/* Enable logging to console */
+	case 8:		/* Set level of messages printed to console */
+		rc = task_has_system(current, SYSTEM__SYSLOG_CONSOLE);
+		break;
+	case 0:		/* Close log */
+	case 1:		/* Open log */
+	case 2:		/* Read from log */
+	case 4:		/* Read/clear last kernel messages */
+	case 5:		/* Clear ring buffer */
+	default:
+		rc = task_has_system(current, SYSTEM__SYSLOG_MOD);
+		break;
 	}
 	return rc;
 }
@@ -1951,7 +1949,7 @@ static int selinux_bprm_set_security(struct linux_binprm *bprm)
 	} else {
 		/* Check for a default transition on this program. */
 		rc = security_transition_sid(tsec->sid, isec->sid,
-		                             SECCLASS_PROCESS, &newsid);
+					     SECCLASS_PROCESS, &newsid);
 		if (rc)
 			return rc;
 	}
@@ -1962,7 +1960,7 @@ static int selinux_bprm_set_security(struct linux_binprm *bprm)
 	if (bprm->file->f_path.mnt->mnt_flags & MNT_NOSUID)
 		newsid = tsec->sid;
 
-        if (tsec->sid == newsid) {
+	if (tsec->sid == newsid) {
 		rc = avc_has_perm(tsec->sid, isec->sid,
 				  SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, &ad);
 		if (rc)
@@ -1990,13 +1988,13 @@ static int selinux_bprm_set_security(struct linux_binprm *bprm)
 	return 0;
 }
 
-static int selinux_bprm_check_security (struct linux_binprm *bprm)
+static int selinux_bprm_check_security(struct linux_binprm *bprm)
 {
 	return secondary_ops->bprm_check_security(bprm);
 }
 
 
-static int selinux_bprm_secureexec (struct linux_binprm *bprm)
+static int selinux_bprm_secureexec(struct linux_binprm *bprm)
 {
 	struct task_security_struct *tsec = current->security;
 	int atsecure = 0;
@@ -2023,7 +2021,7 @@ extern struct vfsmount *selinuxfs_mount;
 extern struct dentry *selinux_null;
 
 /* Derived from fs/exec.c:flush_old_files. */
-static inline void flush_unauthorized_files(struct files_struct * files)
+static inline void flush_unauthorized_files(struct files_struct *files)
 {
 	struct avc_audit_data ad;
 	struct file *file, *devnull = NULL;
@@ -2058,7 +2056,7 @@ static inline void flush_unauthorized_files(struct files_struct * files)
 
 	/* Revalidate access to inherited open files. */
 
-	AVC_AUDIT_DATA_INIT(&ad,FS);
+	AVC_AUDIT_DATA_INIT(&ad, FS);
 
 	spin_lock(&files->file_lock);
 	for (;;) {
@@ -2074,7 +2072,7 @@ static inline void flush_unauthorized_files(struct files_struct * files)
 		if (!set)
 			continue;
 		spin_unlock(&files->file_lock);
-		for ( ; set ; i++,set >>= 1) {
+		for ( ; set ; i++, set >>= 1) {
 			if (set & 1) {
 				file = fget(i);
 				if (!file)
@@ -2231,7 +2229,7 @@ static void selinux_bprm_post_apply_creds(struct linux_binprm *bprm)
 		for (i = 0; i < RLIM_NLIMITS; i++) {
 			rlim = current->signal->rlim + i;
 			initrlim = init_task.signal->rlim+i;
-			rlim->rlim_cur = min(rlim->rlim_max,initrlim->rlim_cur);
+			rlim->rlim_cur = min(rlim->rlim_max, initrlim->rlim_cur);
 		}
 		if (current->signal->rlim[RLIMIT_CPU].rlim_cur != RLIM_INFINITY) {
 			/*
@@ -2286,16 +2284,15 @@ static inline void take_option(char **to, char *from, int *first, int len)
 	*to += len;
 }
 
-static inline void take_selinux_option(char **to, char *from, int *first, 
-		                       int len)
+static inline void take_selinux_option(char **to, char *from, int *first,
+				       int len)
 {
 	int current_size = 0;
 
 	if (!*first) {
 		**to = '|';
 		*to += 1;
-	}
-	else
+	} else
 		*first = 0;
 
 	while (current_size < len) {
@@ -2365,7 +2362,7 @@ static int selinux_sb_kern_mount(struct super_block *sb, void *data)
 	if (rc)
 		return rc;
 
-	AVC_AUDIT_DATA_INIT(&ad,FS);
+	AVC_AUDIT_DATA_INIT(&ad, FS);
 	ad.u.fs.path.dentry = sb->s_root;
 	return superblock_has_perm(current, sb, FILESYSTEM__MOUNT, &ad);
 }
@@ -2374,16 +2371,16 @@ static int selinux_sb_statfs(struct dentry *dentry)
 {
 	struct avc_audit_data ad;
 
-	AVC_AUDIT_DATA_INIT(&ad,FS);
+	AVC_AUDIT_DATA_INIT(&ad, FS);
 	ad.u.fs.path.dentry = dentry->d_sb->s_root;
 	return superblock_has_perm(current, dentry->d_sb, FILESYSTEM__GETATTR, &ad);
 }
 
-static int selinux_mount(char * dev_name,
-                         struct nameidata *nd,
-                         char * type,
-                         unsigned long flags,
-                         void * data)
+static int selinux_mount(char *dev_name,
+			 struct nameidata *nd,
+			 char *type,
+			 unsigned long flags,
+			 void *data)
 {
 	int rc;
 
@@ -2393,10 +2390,10 @@ static int selinux_mount(char * dev_name,
 
 	if (flags & MS_REMOUNT)
 		return superblock_has_perm(current, nd->path.mnt->mnt_sb,
-		                           FILESYSTEM__REMOUNT, NULL);
+					   FILESYSTEM__REMOUNT, NULL);
 	else
 		return dentry_has_perm(current, nd->path.mnt, nd->path.dentry,
-		                       FILE__MOUNTON);
+				       FILE__MOUNTON);
 }
 
 static int selinux_umount(struct vfsmount *mnt, int flags)
@@ -2407,8 +2404,8 @@ static int selinux_umount(struct vfsmount *mnt, int flags)
 	if (rc)
 		return rc;
 
-	return superblock_has_perm(current,mnt->mnt_sb,
-	                           FILESYSTEM__UNMOUNT,NULL);
+	return superblock_has_perm(current, mnt->mnt_sb,
+				   FILESYSTEM__UNMOUNT, NULL);
 }
 
 /* inode security operations */
@@ -2494,7 +2491,7 @@ static int selinux_inode_link(struct dentry *old_dentry, struct inode *dir, stru
 {
 	int rc;
 
-	rc = secondary_ops->inode_link(old_dentry,dir,new_dentry);
+	rc = secondary_ops->inode_link(old_dentry, dir, new_dentry);
 	if (rc)
 		return rc;
 	return may_link(dir, old_dentry, MAY_LINK);
@@ -2537,7 +2534,7 @@ static int selinux_inode_mknod(struct inode *dir, struct dentry *dentry, int mod
 }
 
 static int selinux_inode_rename(struct inode *old_inode, struct dentry *old_dentry,
-                                struct inode *new_inode, struct dentry *new_dentry)
+				struct inode *new_inode, struct dentry *new_dentry)
 {
 	return may_rename(old_inode, old_dentry, new_inode, new_dentry);
 }
@@ -2551,7 +2548,7 @@ static int selinux_inode_follow_link(struct dentry *dentry, struct nameidata *na
 {
 	int rc;
 
-	rc = secondary_ops->inode_follow_link(dentry,nameidata);
+	rc = secondary_ops->inode_follow_link(dentry, nameidata);
 	if (rc)
 		return rc;
 	return dentry_has_perm(current, NULL, dentry, FILE__READ);
@@ -2637,7 +2634,7 @@ static int selinux_inode_setxattr(struct dentry *dentry, char *name, void *value
 	if (!is_owner_or_cap(inode))
 		return -EPERM;
 
-	AVC_AUDIT_DATA_INIT(&ad,FS);
+	AVC_AUDIT_DATA_INIT(&ad, FS);
 	ad.u.fs.path.dentry = dentry;
 
 	rc = avc_has_perm(tsec->sid, isec->sid, isec->sclass,
@@ -2655,7 +2652,7 @@ static int selinux_inode_setxattr(struct dentry *dentry, char *name, void *value
 		return rc;
 
 	rc = security_validate_transition(isec->sid, newsid, tsec->sid,
-	                                  isec->sclass);
+					  isec->sclass);
 	if (rc)
 		return rc;
 
@@ -2667,7 +2664,7 @@ static int selinux_inode_setxattr(struct dentry *dentry, char *name, void *value
 }
 
 static void selinux_inode_post_setxattr(struct dentry *dentry, char *name,
-                                        void *value, size_t size, int flags)
+					void *value, size_t size, int flags)
 {
 	struct inode *inode = dentry->d_inode;
 	struct inode_security_struct *isec = inode->i_security;
@@ -2690,17 +2687,17 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, char *name,
 	return;
 }
 
-static int selinux_inode_getxattr (struct dentry *dentry, char *name)
+static int selinux_inode_getxattr(struct dentry *dentry, char *name)
 {
 	return dentry_has_perm(current, NULL, dentry, FILE__GETATTR);
 }
 
-static int selinux_inode_listxattr (struct dentry *dentry)
+static int selinux_inode_listxattr(struct dentry *dentry)
 {
 	return dentry_has_perm(current, NULL, dentry, FILE__GETATTR);
 }
 
-static int selinux_inode_removexattr (struct dentry *dentry, char *name)
+static int selinux_inode_removexattr(struct dentry *dentry, char *name)
 {
 	if (strcmp(name, XATTR_NAME_SELINUX))
 		return selinux_inode_setotherxattr(dentry, name);
@@ -2741,7 +2738,7 @@ out_nofree:
 }
 
 static int selinux_inode_setsecurity(struct inode *inode, const char *name,
-                                     const void *value, size_t size, int flags)
+				     const void *value, size_t size, int flags)
 {
 	struct inode_security_struct *isec = inode->i_security;
 	u32 newsid;
@@ -2753,7 +2750,7 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
 	if (!value || !size)
 		return -EACCES;
 
-	rc = security_context_to_sid((void*)value, size, &newsid);
+	rc = security_context_to_sid((void *)value, size, &newsid);
 	if (rc)
 		return rc;
 
@@ -2838,42 +2835,41 @@ static int selinux_file_ioctl(struct file *file, unsigned int cmd,
 	int error = 0;
 
 	switch (cmd) {
-		case FIONREAD:
-		/* fall through */
-		case FIBMAP:
-		/* fall through */
-		case FIGETBSZ:
-		/* fall through */
-		case EXT2_IOC_GETFLAGS:
-		/* fall through */
-		case EXT2_IOC_GETVERSION:
-			error = file_has_perm(current, file, FILE__GETATTR);
-			break;
-
-		case EXT2_IOC_SETFLAGS:
-		/* fall through */
-		case EXT2_IOC_SETVERSION:
-			error = file_has_perm(current, file, FILE__SETATTR);
-			break;
+	case FIONREAD:
+	/* fall through */
+	case FIBMAP:
+	/* fall through */
+	case FIGETBSZ:
+	/* fall through */
+	case EXT2_IOC_GETFLAGS:
+	/* fall through */
+	case EXT2_IOC_GETVERSION:
+		error = file_has_perm(current, file, FILE__GETATTR);
+		break;
 
-		/* sys_ioctl() checks */
-		case FIONBIO:
-		/* fall through */
-		case FIOASYNC:
-			error = file_has_perm(current, file, 0);
-			break;
+	case EXT2_IOC_SETFLAGS:
+	/* fall through */
+	case EXT2_IOC_SETVERSION:
+		error = file_has_perm(current, file, FILE__SETATTR);
+		break;
 
-	        case KDSKBENT:
-	        case KDSKBSENT:
-			error = task_has_capability(current,CAP_SYS_TTY_CONFIG);
-			break;
+	/* sys_ioctl() checks */
+	case FIONBIO:
+	/* fall through */
+	case FIOASYNC:
+		error = file_has_perm(current, file, 0);
+		break;
 
-		/* default case assumes that the command will go
-		 * to the file's ioctl() function.
-		 */
-		default:
-			error = file_has_perm(current, file, FILE__IOCTL);
+	case KDSKBENT:
+	case KDSKBSENT:
+		error = task_has_capability(current, CAP_SYS_TTY_CONFIG);
+		break;
 
+	/* default case assumes that the command will go
+	 * to the file's ioctl() function.
+	 */
+	default:
+		error = file_has_perm(current, file, FILE__IOCTL);
 	}
 	return error;
 }
@@ -2914,7 +2910,7 @@ static int selinux_file_mmap(struct file *file, unsigned long reqprot,
 			     unsigned long addr, unsigned long addr_only)
 {
 	int rc = 0;
-	u32 sid = ((struct task_security_struct*)(current->security))->sid;
+	u32 sid = ((struct task_security_struct *)(current->security))->sid;
 
 	if (addr < mmap_min_addr)
 		rc = avc_has_perm(sid, sid, SECCLASS_MEMPROTECT,
@@ -2983,39 +2979,39 @@ static int selinux_file_fcntl(struct file *file, unsigned int cmd,
 	int err = 0;
 
 	switch (cmd) {
-	        case F_SETFL:
-			if (!file->f_path.dentry || !file->f_path.dentry->d_inode) {
-				err = -EINVAL;
-				break;
-			}
+	case F_SETFL:
+		if (!file->f_path.dentry || !file->f_path.dentry->d_inode) {
+			err = -EINVAL;
+			break;
+		}
 
-			if ((file->f_flags & O_APPEND) && !(arg & O_APPEND)) {
-				err = file_has_perm(current, file,FILE__WRITE);
-				break;
-			}
-			/* fall through */
-	        case F_SETOWN:
-	        case F_SETSIG:
-	        case F_GETFL:
-	        case F_GETOWN:
-	        case F_GETSIG:
-			/* Just check FD__USE permission */
-			err = file_has_perm(current, file, 0);
+		if ((file->f_flags & O_APPEND) && !(arg & O_APPEND)) {
+			err = file_has_perm(current, file, FILE__WRITE);
 			break;
-		case F_GETLK:
-		case F_SETLK:
-	        case F_SETLKW:
+		}
+		/* fall through */
+	case F_SETOWN:
+	case F_SETSIG:
+	case F_GETFL:
+	case F_GETOWN:
+	case F_GETSIG:
+		/* Just check FD__USE permission */
+		err = file_has_perm(current, file, 0);
+		break;
+	case F_GETLK:
+	case F_SETLK:
+	case F_SETLKW:
 #if BITS_PER_LONG == 32
-	        case F_GETLK64:
-		case F_SETLK64:
-	        case F_SETLKW64:
+	case F_GETLK64:
+	case F_SETLK64:
+	case F_SETLKW64:
 #endif
-			if (!file->f_path.dentry || !file->f_path.dentry->d_inode) {
-				err = -EINVAL;
-				break;
-			}
-			err = file_has_perm(current, file, FILE__LOCK);
+		if (!file->f_path.dentry || !file->f_path.dentry->d_inode) {
+			err = -EINVAL;
 			break;
+		}
+		err = file_has_perm(current, file, FILE__LOCK);
+		break;
 	}
 
 	return err;
@@ -3036,13 +3032,13 @@ static int selinux_file_set_fowner(struct file *file)
 static int selinux_file_send_sigiotask(struct task_struct *tsk,
 				       struct fown_struct *fown, int signum)
 {
-        struct file *file;
+	struct file *file;
 	u32 perm;
 	struct task_security_struct *tsec;
 	struct file_security_struct *fsec;
 
 	/* struct fown_struct is never outside the context of a struct file */
-        file = container_of(fown, struct file, f_owner);
+	file = container_of(fown, struct file, f_owner);
 
 	tsec = tsk->security;
 	fsec = file->f_security;
@@ -3144,7 +3140,7 @@ static int selinux_task_setuid(uid_t id0, uid_t id1, uid_t id2, int flags)
 
 static int selinux_task_post_setuid(uid_t id0, uid_t id1, uid_t id2, int flags)
 {
-	return secondary_ops->task_post_setuid(id0,id1,id2,flags);
+	return secondary_ops->task_post_setuid(id0, id1, id2, flags);
 }
 
 static int selinux_task_setgid(gid_t id0, gid_t id1, gid_t id2, int flags)
@@ -3187,7 +3183,7 @@ static int selinux_task_setnice(struct task_struct *p, int nice)
 	if (rc)
 		return rc;
 
-	return task_has_perm(current,p, PROCESS__SETSCHED);
+	return task_has_perm(current, p, PROCESS__SETSCHED);
 }
 
 static int selinux_task_setioprio(struct task_struct *p, int ioprio)
@@ -3291,7 +3287,7 @@ static int selinux_task_wait(struct task_struct *p)
 
 static void selinux_task_reparent_to_init(struct task_struct *p)
 {
-  	struct task_security_struct *tsec;
+	struct task_security_struct *tsec;
 
 	secondary_ops->task_reparent_to_init(p);
 
@@ -3336,11 +3332,11 @@ static int selinux_parse_skb_ipv4(struct sk_buff *skb,
 		*proto = ih->protocol;
 
 	switch (ih->protocol) {
-        case IPPROTO_TCP: {
-        	struct tcphdr _tcph, *th;
+	case IPPROTO_TCP: {
+		struct tcphdr _tcph, *th;
 
-        	if (ntohs(ih->frag_off) & IP_OFFSET)
-        		break;
+		if (ntohs(ih->frag_off) & IP_OFFSET)
+			break;
 
 		offset += ihlen;
 		th = skb_header_pointer(skb, offset, sizeof(_tcph), &_tcph);
@@ -3350,23 +3346,23 @@ static int selinux_parse_skb_ipv4(struct sk_buff *skb,
 		ad->u.net.sport = th->source;
 		ad->u.net.dport = th->dest;
 		break;
-        }
-        
-        case IPPROTO_UDP: {
-        	struct udphdr _udph, *uh;
-        	
-        	if (ntohs(ih->frag_off) & IP_OFFSET)
-        		break;
-        		
+	}
+
+	case IPPROTO_UDP: {
+		struct udphdr _udph, *uh;
+
+		if (ntohs(ih->frag_off) & IP_OFFSET)
+			break;
+
 		offset += ihlen;
-        	uh = skb_header_pointer(skb, offset, sizeof(_udph), &_udph);
+		uh = skb_header_pointer(skb, offset, sizeof(_udph), &_udph);
 		if (uh == NULL)
-			break;	
+			break;
 
-        	ad->u.net.sport = uh->source;
-        	ad->u.net.dport = uh->dest;
-        	break;
-        }
+		ad->u.net.sport = uh->source;
+		ad->u.net.dport = uh->dest;
+		break;
+	}
 
 	case IPPROTO_DCCP: {
 		struct dccp_hdr _dccph, *dh;
@@ -3382,11 +3378,11 @@ static int selinux_parse_skb_ipv4(struct sk_buff *skb,
 		ad->u.net.sport = dh->dccph_sport;
 		ad->u.net.dport = dh->dccph_dport;
 		break;
-        }
+	}
 
-        default:
-        	break;
-        }
+	default:
+		break;
+	}
 out:
 	return ret;
 }
@@ -3421,7 +3417,7 @@ static int selinux_parse_skb_ipv6(struct sk_buff *skb,
 
 	switch (nexthdr) {
 	case IPPROTO_TCP: {
-        	struct tcphdr _tcph, *th;
+		struct tcphdr _tcph, *th;
 
 		th = skb_header_pointer(skb, offset, sizeof(_tcph), &_tcph);
 		if (th == NULL)
@@ -3454,7 +3450,7 @@ static int selinux_parse_skb_ipv6(struct sk_buff *skb,
 		ad->u.net.sport = dh->dccph_sport;
 		ad->u.net.dport = dh->dccph_dport;
 		break;
-        }
+	}
 
 	/* includes fragments */
 	default:
@@ -3552,7 +3548,7 @@ static int socket_has_perm(struct task_struct *task, struct socket *sock,
 	if (isec->sid == SECINITSID_KERNEL)
 		goto out;
 
-	AVC_AUDIT_DATA_INIT(&ad,NET);
+	AVC_AUDIT_DATA_INIT(&ad, NET);
 	ad.u.net.sk = sock->sk;
 	err = avc_has_perm(tsec->sid, isec->sid, isec->sclass, perms, &ad);
 
@@ -3664,7 +3660,7 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 							&sid);
 				if (err)
 					goto out;
-				AVC_AUDIT_DATA_INIT(&ad,NET);
+				AVC_AUDIT_DATA_INIT(&ad, NET);
 				ad.u.net.sport = htons(snum);
 				ad.u.net.family = family;
 				err = avc_has_perm(isec->sid, sid,
@@ -3674,12 +3670,12 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 					goto out;
 			}
 		}
-		
-		switch(isec->sclass) {
+
+		switch (isec->sclass) {
 		case SECCLASS_TCP_SOCKET:
 			node_perm = TCP_SOCKET__NODE_BIND;
 			break;
-			
+
 		case SECCLASS_UDP_SOCKET:
 			node_perm = UDP_SOCKET__NODE_BIND;
 			break;
@@ -3692,12 +3688,12 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 			node_perm = RAWIP_SOCKET__NODE_BIND;
 			break;
 		}
-		
+
 		err = sel_netnode_sid(addrp, family, &sid);
 		if (err)
 			goto out;
-		
-		AVC_AUDIT_DATA_INIT(&ad,NET);
+
+		AVC_AUDIT_DATA_INIT(&ad, NET);
 		ad.u.net.sport = htons(snum);
 		ad.u.net.family = family;
 
@@ -3707,7 +3703,7 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 			ipv6_addr_copy(&ad.u.net.v6info.saddr, &addr6->sin6_addr);
 
 		err = avc_has_perm(isec->sid, sid,
-		                   isec->sclass, node_perm, &ad);
+				   isec->sclass, node_perm, &ad);
 		if (err)
 			goto out;
 	}
@@ -3757,7 +3753,7 @@ static int selinux_socket_connect(struct socket *sock, struct sockaddr *address,
 		perm = (isec->sclass == SECCLASS_TCP_SOCKET) ?
 		       TCP_SOCKET__NAME_CONNECT : DCCP_SOCKET__NAME_CONNECT;
 
-		AVC_AUDIT_DATA_INIT(&ad,NET);
+		AVC_AUDIT_DATA_INIT(&ad, NET);
 		ad.u.net.dport = htons(snum);
 		ad.u.net.family = sk->sk_family;
 		err = avc_has_perm(isec->sid, sid, isec->sclass, perm, &ad);
@@ -3795,7 +3791,7 @@ static int selinux_socket_accept(struct socket *sock, struct socket *newsock)
 }
 
 static int selinux_socket_sendmsg(struct socket *sock, struct msghdr *msg,
- 				  int size)
+				  int size)
 {
 	int rc;
 
@@ -3822,7 +3818,7 @@ static int selinux_socket_getpeername(struct socket *sock)
 	return socket_has_perm(current, sock, SOCKET__GETATTR);
 }
 
-static int selinux_socket_setsockopt(struct socket *sock,int level,int optname)
+static int selinux_socket_setsockopt(struct socket *sock, int level, int optname)
 {
 	int err;
 
@@ -3861,7 +3857,7 @@ static int selinux_socket_unix_stream_connect(struct socket *sock,
 	isec = SOCK_INODE(sock)->i_security;
 	other_isec = SOCK_INODE(other)->i_security;
 
-	AVC_AUDIT_DATA_INIT(&ad,NET);
+	AVC_AUDIT_DATA_INIT(&ad, NET);
 	ad.u.net.sk = other->sk;
 
 	err = avc_has_perm(isec->sid, other_isec->sid,
@@ -3873,7 +3869,7 @@ static int selinux_socket_unix_stream_connect(struct socket *sock,
 	/* connecting socket */
 	ssec = sock->sk->sk_security;
 	ssec->peer_sid = other_isec->sid;
-	
+
 	/* server child socket */
 	ssec = newsk->sk_security;
 	ssec->peer_sid = isec->sid;
@@ -3893,7 +3889,7 @@ static int selinux_socket_unix_may_send(struct socket *sock,
 	isec = SOCK_INODE(sock)->i_security;
 	other_isec = SOCK_INODE(other)->i_security;
 
-	AVC_AUDIT_DATA_INIT(&ad,NET);
+	AVC_AUDIT_DATA_INIT(&ad, NET);
 	ad.u.net.sk = other->sk;
 
 	err = avc_has_perm(isec->sid, other_isec->sid,
@@ -3971,7 +3967,7 @@ static int selinux_sock_rcv_skb_iptables_compat(struct sock *sk,
 	err = avc_has_perm(sk_sid, if_sid, SECCLASS_NETIF, netif_perm, ad);
 	if (err)
 		return err;
-	
+
 	err = sel_netnode_sid(addrp, family, &node_sid);
 	if (err)
 		return err;
@@ -4123,7 +4119,7 @@ out_len:
 		err = -EFAULT;
 
 	kfree(scontext);
-out:	
+out:
 	return err;
 }
 
@@ -4184,7 +4180,7 @@ static void selinux_sk_getsecid(struct sock *sk, u32 *secid)
 	}
 }
 
-static void selinux_sock_graft(struct sock* sk, struct socket *parent)
+static void selinux_sock_graft(struct sock *sk, struct socket *parent)
 {
 	struct inode_security_struct *isec = SOCK_INODE(parent)->i_security;
 	struct sk_security_struct *sksec = sk->sk_security;
@@ -4261,13 +4257,13 @@ static int selinux_nlmsg_perm(struct sock *sk, struct sk_buff *skb)
 	struct nlmsghdr *nlh;
 	struct socket *sock = sk->sk_socket;
 	struct inode_security_struct *isec = SOCK_INODE(sock)->i_security;
-	
+
 	if (skb->len < NLMSG_SPACE(0)) {
 		err = -EINVAL;
 		goto out;
 	}
 	nlh = nlmsg_hdr(skb);
-	
+
 	err = selinux_nlmsg_lookup(isec->sclass, nlh->nlmsg_type, &perm);
 	if (err) {
 		if (err == -EINVAL) {
@@ -4393,7 +4389,7 @@ static int selinux_ip_postroute_iptables_compat(struct sock *sk,
 		return err;
 	err = avc_has_perm(sk_sid, if_sid, SECCLASS_NETIF, netif_perm, ad);
 		return err;
-		
+
 	err = sel_netnode_sid(addrp, family, &node_sid);
 	if (err)
 		return err;
@@ -4577,7 +4573,7 @@ static int selinux_netlink_recv(struct sk_buff *skb, int capability)
 	ad.u.cap = capability;
 
 	return avc_has_perm(NETLINK_CB(skb).sid, NETLINK_CB(skb).sid,
-	                    SECCLASS_CAPABILITY, CAP_TO_MASK(capability), &ad);
+			    SECCLASS_CAPABILITY, CAP_TO_MASK(capability), &ad);
 }
 
 static int ipc_alloc_security(struct task_struct *task,
@@ -4669,7 +4665,7 @@ static int selinux_msg_queue_alloc_security(struct msg_queue *msq)
 	isec = msq->q_perm.security;
 
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
- 	ad.u.ipc_id = msq->q_perm.key;
+	ad.u.ipc_id = msq->q_perm.key;
 
 	rc = avc_has_perm(tsec->sid, isec->sid, SECCLASS_MSGQ,
 			  MSGQ__CREATE, &ad);
@@ -4706,7 +4702,7 @@ static int selinux_msg_queue_msgctl(struct msg_queue *msq, int cmd)
 	int err;
 	int perms;
 
-	switch(cmd) {
+	switch (cmd) {
 	case IPC_INFO:
 	case MSG_INFO:
 		/* No specific object, just general system-wide information. */
@@ -4790,7 +4786,7 @@ static int selinux_msg_queue_msgrcv(struct msg_queue *msq, struct msg_msg *msg,
 	msec = msg->security;
 
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
- 	ad.u.ipc_id = msq->q_perm.key;
+	ad.u.ipc_id = msq->q_perm.key;
 
 	rc = avc_has_perm(tsec->sid, isec->sid,
 			  SECCLASS_MSGQ, MSGQ__READ, &ad);
@@ -4816,7 +4812,7 @@ static int selinux_shm_alloc_security(struct shmid_kernel *shp)
 	isec = shp->shm_perm.security;
 
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
- 	ad.u.ipc_id = shp->shm_perm.key;
+	ad.u.ipc_id = shp->shm_perm.key;
 
 	rc = avc_has_perm(tsec->sid, isec->sid, SECCLASS_SHM,
 			  SHM__CREATE, &ad);
@@ -4854,7 +4850,7 @@ static int selinux_shm_shmctl(struct shmid_kernel *shp, int cmd)
 	int perms;
 	int err;
 
-	switch(cmd) {
+	switch (cmd) {
 	case IPC_INFO:
 	case SHM_INFO:
 		/* No specific object, just general system-wide information. */
@@ -4915,7 +4911,7 @@ static int selinux_sem_alloc_security(struct sem_array *sma)
 	isec = sma->sem_perm.security;
 
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
- 	ad.u.ipc_id = sma->sem_perm.key;
+	ad.u.ipc_id = sma->sem_perm.key;
 
 	rc = avc_has_perm(tsec->sid, isec->sid, SECCLASS_SEM,
 			  SEM__CREATE, &ad);
@@ -4953,7 +4949,7 @@ static int selinux_sem_semctl(struct sem_array *sma, int cmd)
 	int err;
 	u32 perms;
 
-	switch(cmd) {
+	switch (cmd) {
 	case IPC_INFO:
 	case SEM_INFO:
 		/* No specific object, just general system-wide information. */
@@ -5019,13 +5015,13 @@ static int selinux_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 }
 
 /* module stacking operations */
-static int selinux_register_security (const char *name, struct security_operations *ops)
+static int selinux_register_security(const char *name, struct security_operations *ops)
 {
 	if (secondary_ops != original_ops) {
 		printk(KERN_ERR "%s:  There is already a secondary security "
 		       "module registered.\n", __func__);
 		return -EINVAL;
- 	}
+	}
 
 	secondary_ops = ops;
 
@@ -5036,7 +5032,7 @@ static int selinux_register_security (const char *name, struct security_operatio
 	return 0;
 }
 
-static void selinux_d_instantiate (struct dentry *dentry, struct inode *inode)
+static void selinux_d_instantiate(struct dentry *dentry, struct inode *inode)
 {
 	if (inode)
 		inode_doinit_with_dentry(inode, dentry);
@@ -5164,11 +5160,11 @@ static int selinux_setprocattr(struct task_struct *p,
 				}
 			while_each_thread(g, t);
 			read_unlock(&tasklist_lock);
-                }
+		}
 
 		/* Check permissions for the transition. */
 		error = avc_has_perm(tsec->sid, sid, SECCLASS_PROCESS,
-		                     PROCESS__DYNTRANSITION, NULL);
+				     PROCESS__DYNTRANSITION, NULL);
 		if (error)
 			return error;
 
@@ -5196,8 +5192,7 @@ static int selinux_setprocattr(struct task_struct *p,
 			tsec->sid = sid;
 			task_unlock(p);
 		}
-	}
-	else
+	} else
 		return -EINVAL;
 
 	return size;
@@ -5285,7 +5280,7 @@ static struct security_operations selinux_ops = {
 	.vm_enough_memory =		selinux_vm_enough_memory,
 
 	.netlink_send =			selinux_netlink_send,
-        .netlink_recv =			selinux_netlink_recv,
+	.netlink_recv =			selinux_netlink_recv,
 
 	.bprm_alloc_security =		selinux_bprm_alloc_security,
 	.bprm_free_security =		selinux_bprm_free_security,
@@ -5298,13 +5293,13 @@ static struct security_operations selinux_ops = {
 	.sb_alloc_security =		selinux_sb_alloc_security,
 	.sb_free_security =		selinux_sb_free_security,
 	.sb_copy_data =			selinux_sb_copy_data,
-	.sb_kern_mount =	        selinux_sb_kern_mount,
+	.sb_kern_mount =		selinux_sb_kern_mount,
 	.sb_statfs =			selinux_sb_statfs,
 	.sb_mount =			selinux_mount,
 	.sb_umount =			selinux_umount,
 	.sb_get_mnt_opts =		selinux_get_mnt_opts,
 	.sb_set_mnt_opts =		selinux_set_mnt_opts,
-	.sb_clone_mnt_opts = 		selinux_sb_clone_mnt_opts,
+	.sb_clone_mnt_opts =		selinux_sb_clone_mnt_opts,
 
 	.inode_alloc_security =		selinux_inode_alloc_security,
 	.inode_free_security =		selinux_inode_free_security,
@@ -5327,9 +5322,9 @@ static struct security_operations selinux_ops = {
 	.inode_getxattr =		selinux_inode_getxattr,
 	.inode_listxattr =		selinux_inode_listxattr,
 	.inode_removexattr =		selinux_inode_removexattr,
-	.inode_getsecurity =            selinux_inode_getsecurity,
-	.inode_setsecurity =            selinux_inode_setsecurity,
-	.inode_listsecurity =           selinux_inode_listsecurity,
+	.inode_getsecurity =		selinux_inode_getsecurity,
+	.inode_setsecurity =		selinux_inode_setsecurity,
+	.inode_listsecurity =		selinux_inode_listsecurity,
 	.inode_need_killpriv =		selinux_inode_need_killpriv,
 	.inode_killpriv =		selinux_inode_killpriv,
 
@@ -5345,7 +5340,7 @@ static struct security_operations selinux_ops = {
 	.file_send_sigiotask =		selinux_file_send_sigiotask,
 	.file_receive =			selinux_file_receive,
 
-	.dentry_open =                  selinux_dentry_open,
+	.dentry_open =			selinux_dentry_open,
 
 	.task_create =			selinux_task_create,
 	.task_alloc_security =		selinux_task_alloc_security,
@@ -5355,7 +5350,7 @@ static struct security_operations selinux_ops = {
 	.task_setgid =			selinux_task_setgid,
 	.task_setpgid =			selinux_task_setpgid,
 	.task_getpgid =			selinux_task_getpgid,
-	.task_getsid =		        selinux_task_getsid,
+	.task_getsid =			selinux_task_getsid,
 	.task_getsecid =		selinux_task_getsecid,
 	.task_setgroups =		selinux_task_setgroups,
 	.task_setnice =			selinux_task_setnice,
@@ -5369,7 +5364,7 @@ static struct security_operations selinux_ops = {
 	.task_wait =			selinux_task_wait,
 	.task_prctl =			selinux_task_prctl,
 	.task_reparent_to_init =	selinux_task_reparent_to_init,
-	.task_to_inode =                selinux_task_to_inode,
+	.task_to_inode =		selinux_task_to_inode,
 
 	.ipc_permission =		selinux_ipc_permission,
 
@@ -5389,24 +5384,24 @@ static struct security_operations selinux_ops = {
 	.shm_shmctl =			selinux_shm_shmctl,
 	.shm_shmat =			selinux_shm_shmat,
 
-	.sem_alloc_security = 		selinux_sem_alloc_security,
-	.sem_free_security =  		selinux_sem_free_security,
+	.sem_alloc_security =		selinux_sem_alloc_security,
+	.sem_free_security =		selinux_sem_free_security,
 	.sem_associate =		selinux_sem_associate,
 	.sem_semctl =			selinux_sem_semctl,
 	.sem_semop =			selinux_sem_semop,
 
 	.register_security =		selinux_register_security,
 
-	.d_instantiate =                selinux_d_instantiate,
+	.d_instantiate =		selinux_d_instantiate,
 
-	.getprocattr =                  selinux_getprocattr,
-	.setprocattr =                  selinux_setprocattr,
+	.getprocattr =			selinux_getprocattr,
+	.setprocattr =			selinux_setprocattr,
 
 	.secid_to_secctx =		selinux_secid_to_secctx,
 	.secctx_to_secid =		selinux_secctx_to_secid,
 	.release_secctx =		selinux_release_secctx,
 
-        .unix_stream_connect =		selinux_socket_unix_stream_connect,
+	.unix_stream_connect =		selinux_socket_unix_stream_connect,
 	.unix_may_send =		selinux_socket_unix_may_send,
 
 	.socket_create =		selinux_socket_create,
@@ -5428,7 +5423,7 @@ static struct security_operations selinux_ops = {
 	.sk_alloc_security =		selinux_sk_alloc_security,
 	.sk_free_security =		selinux_sk_free_security,
 	.sk_clone_security =		selinux_sk_clone_security,
-	.sk_getsecid = 			selinux_sk_getsecid,
+	.sk_getsecid =			selinux_sk_getsecid,
 	.sock_graft =			selinux_sock_graft,
 	.inet_conn_request =		selinux_inet_conn_request,
 	.inet_csk_clone =		selinux_inet_csk_clone,
@@ -5443,15 +5438,15 @@ static struct security_operations selinux_ops = {
 	.xfrm_state_alloc_security =	selinux_xfrm_state_alloc,
 	.xfrm_state_free_security =	selinux_xfrm_state_free,
 	.xfrm_state_delete_security =	selinux_xfrm_state_delete,
-	.xfrm_policy_lookup = 		selinux_xfrm_policy_lookup,
+	.xfrm_policy_lookup =		selinux_xfrm_policy_lookup,
 	.xfrm_state_pol_flow_match =	selinux_xfrm_state_pol_flow_match,
 	.xfrm_decode_session =		selinux_xfrm_decode_session,
 #endif
 
 #ifdef CONFIG_KEYS
-	.key_alloc =                    selinux_key_alloc,
-	.key_free =                     selinux_key_free,
-	.key_permission =               selinux_key_permission,
+	.key_alloc =			selinux_key_alloc,
+	.key_free =			selinux_key_free,
+	.key_permission =		selinux_key_permission,
 #endif
 };
 
@@ -5479,15 +5474,14 @@ static __init int selinux_init(void)
 
 	original_ops = secondary_ops = security_ops;
 	if (!secondary_ops)
-		panic ("SELinux: No initial security operations\n");
-	if (register_security (&selinux_ops))
+		panic("SELinux: No initial security operations\n");
+	if (register_security(&selinux_ops))
 		panic("SELinux: Unable to register with kernel.\n");
 
-	if (selinux_enforcing) {
+	if (selinux_enforcing)
 		printk(KERN_DEBUG "SELinux:  Starting in enforcing mode\n");
-	} else {
+	else
 		printk(KERN_DEBUG "SELinux:  Starting in permissive mode\n");
-	}
 
 #ifdef CONFIG_KEYS
 	/* Add security information to initial keyrings */
@@ -5512,8 +5506,8 @@ next_sb:
 	if (!list_empty(&superblock_security_head)) {
 		struct superblock_security_struct *sbsec =
 				list_entry(superblock_security_head.next,
-				           struct superblock_security_struct,
-				           list);
+					   struct superblock_security_struct,
+					   list);
 		struct super_block *sb = sbsec->sb;
 		sb->s_count++;
 		spin_unlock(&sb_security_lock);
@@ -5632,10 +5626,11 @@ static void selinux_nf_ip_exit(void)
 #endif /* CONFIG_NETFILTER */
 
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
+static int selinux_disabled;
+
 int selinux_disable(void)
 {
 	extern void exit_sel_fs(void);
-	static int selinux_disabled = 0;
 
 	if (ss_initialized) {
 		/* Not permitted after initial policy load. */



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
