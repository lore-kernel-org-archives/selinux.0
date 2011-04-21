Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3LEV03c016413
	for <selinux@tycho.nsa.gov>; Thu, 21 Apr 2011 10:31:02 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p3LEV0Zc017710
	for <selinux@tycho.nsa.gov>; Thu, 21 Apr 2011 14:31:01 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 4/9] LSM: Make the linux_binfmt creds pointer const and pass
 creds to bprm_set_creds
To: serge.hallyn@canonical.com, eparis@redhat.com
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        David Howells <dhowells@redhat.com>
Date: Thu, 21 Apr 2011 15:30:47 +0100
Message-ID: <20110421143047.31318.95441.stgit@warthog.procyon.org.uk>
In-Reply-To: <20110421143020.31318.59457.stgit@warthog.procyon.org.uk>
References: <20110421143020.31318.59457.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Make the linux_binfmt credentials pointer const and pass a separate non-const
creds pointer to the bprm_set_creds() security ops.  From this point, the
credentials in linux_binfmt can be used at any time, but must be replaced on
each transit through prepare_binfmt().

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/exec.c                          |   28 ++++++++++++++++++++-------
 include/linux/binfmts.h            |    2 +-
 include/linux/cred.h               |    1 +
 include/linux/security.h           |   12 +++++++----
 kernel/cred.c                      |   38 +++++++++++++++++++++++-------------
 security/apparmor/domain.c         |    7 ++++---
 security/apparmor/include/domain.h |    2 +-
 security/commoncap.c               |   22 ++++++++++-----------
 security/security.c                |    4 ++--
 security/selinux/hooks.c           |    6 +++---
 security/smack/smack_lsm.c         |    6 +++---
 security/tomoyo/common.h           |    2 +-
 security/tomoyo/domain.c           |    5 +++--
 security/tomoyo/tomoyo.c           |    9 ++++-----
 14 files changed, 86 insertions(+), 58 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 5e62d26..f0ddc51 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1142,7 +1142,7 @@ void free_bprm(struct linux_binprm *bprm)
 	free_arg_pages(bprm);
 	if (bprm->cred) {
 		mutex_unlock(&current->signal->cred_guard_mutex);
-		abort_creds(bprm->cred);
+		put_cred(bprm->cred);
 	}
 	kfree(bprm);
 }
@@ -1210,6 +1210,8 @@ int check_unsafe_exec(struct linux_binprm *bprm)
  */
 int prepare_binprm(struct linux_binprm *bprm)
 {
+	const struct cred *old;
+	struct cred *cred;
 	umode_t mode;
 	struct inode * inode = bprm->file->f_path.dentry->d_inode;
 	int retval;
@@ -1218,15 +1220,19 @@ int prepare_binprm(struct linux_binprm *bprm)
 	if (bprm->file->f_op == NULL)
 		return -EACCES;
 
+	cred = duplicate_creds(bprm->cred);
+	if (!cred)
+		return -ENOMEM;
+
 	/* clear any previous set[ug]id data from a previous binary */
-	bprm->cred->euid = current_euid();
-	bprm->cred->egid = current_egid();
+	cred->euid = current_euid();
+	cred->egid = current_egid();
 
 	if (!(bprm->file->f_path.mnt->mnt_flags & MNT_NOSUID)) {
 		/* Set-uid? */
 		if (mode & S_ISUID) {
 			bprm->per_clear |= PER_CLEAR_ON_SETID;
-			bprm->cred->euid = inode->i_uid;
+			cred->euid = inode->i_uid;
 		}
 
 		/* Set-gid? */
@@ -1237,15 +1243,23 @@ int prepare_binprm(struct linux_binprm *bprm)
 		 */
 		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
 			bprm->per_clear |= PER_CLEAR_ON_SETID;
-			bprm->cred->egid = inode->i_gid;
+			cred->egid = inode->i_gid;
 		}
 	}
 
 	/* fill in binprm security blob */
-	retval = security_bprm_set_creds(bprm);
-	if (retval)
+	retval = security_bprm_set_creds(bprm, cred);
+	if (retval) {
+		abort_creds(cred);
 		return retval;
+	}
+
+	/* 'commit' the new creds - after this point, the new creds may not be
+	 * altered */
+	old = bprm->cred;
+	bprm->cred = cred;
 	bprm->cred_prepared = 1;
+	put_cred(old);
 
 	memset(bprm->buf, 0, BINPRM_BUF_SIZE);
 	return kernel_read(bprm->file, 0, bprm->buf, BINPRM_BUF_SIZE);
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index c3d6512..fc3bc19 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -47,7 +47,7 @@ struct linux_binprm {
 #endif
 	unsigned int recursion_depth;
 	struct file * file;
-	struct cred *cred;	/* new credentials */
+	const struct cred *cred; /* new credentials */
 	int unsafe;		/* how unsafe this exec is (mask of LSM_UNSAFE_*) */
 	unsigned int per_clear;	/* bits to clear in current->personality */
 	int argc, envc;
diff --git a/include/linux/cred.h b/include/linux/cred.h
index 6a9cec4..37783de 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -155,6 +155,7 @@ extern void exit_creds(struct task_struct *);
 extern int copy_creds(struct task_struct *, unsigned long);
 extern const struct cred *get_task_cred(struct task_struct *);
 extern struct cred *cred_alloc_blank(void);
+extern struct cred *duplicate_creds(const struct cred *);
 extern struct cred *prepare_creds(void);
 extern struct cred *prepare_exec_creds(void);
 extern int commit_creds(const struct cred *);
diff --git a/include/linux/security.h b/include/linux/security.h
index ca02f17..6b99225 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -63,7 +63,7 @@ extern int cap_capset(struct cred *new, const struct cred *old,
 		      const kernel_cap_t *effective,
 		      const kernel_cap_t *inheritable,
 		      const kernel_cap_t *permitted);
-extern int cap_bprm_set_creds(struct linux_binprm *bprm);
+extern int cap_bprm_set_creds(struct linux_binprm *bprm, struct cred *cred);
 extern int cap_bprm_secureexec(struct linux_binprm *bprm);
 extern int cap_inode_setxattr(struct dentry *dentry, const char *name,
 			      const void *value, size_t size, int flags);
@@ -197,6 +197,7 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
  *	may decide either to retain the security information saved earlier or
  *	to replace it.
  *	@bprm contains the linux_binprm structure.
+ *	@cred contains the new credentials under construction at this point
  *	Return 0 if the hook is successful and permission is granted.
  * @bprm_check_security:
  *	This hook mediates the point when a search for a binary handler will
@@ -1393,7 +1394,7 @@ struct security_operations {
 	int (*settime) (const struct timespec *ts, const struct timezone *tz);
 	int (*vm_enough_memory) (struct mm_struct *mm, long pages);
 
-	int (*bprm_set_creds) (struct linux_binprm *bprm);
+	int (*bprm_set_creds) (struct linux_binprm *bprm, struct cred *cred);
 	int (*bprm_check_security) (struct linux_binprm *bprm);
 	int (*bprm_secureexec) (struct linux_binprm *bprm);
 	void (*bprm_committing_creds) (struct linux_binprm *bprm);
@@ -1680,7 +1681,7 @@ int security_settime(const struct timespec *ts, const struct timezone *tz);
 int security_vm_enough_memory(long pages);
 int security_vm_enough_memory_mm(struct mm_struct *mm, long pages);
 int security_vm_enough_memory_kern(long pages);
-int security_bprm_set_creds(struct linux_binprm *bprm);
+int security_bprm_set_creds(struct linux_binprm *bprm, struct cred *cred);
 int security_bprm_check(struct linux_binprm *bprm);
 void security_bprm_committing_creds(struct linux_binprm *bprm);
 void security_bprm_committed_creds(struct linux_binprm *bprm);
@@ -1934,9 +1935,10 @@ static inline int security_vm_enough_memory_kern(long pages)
 	return cap_vm_enough_memory(current->mm, pages);
 }
 
-static inline int security_bprm_set_creds(struct linux_binprm *bprm)
+static inline
+int security_bprm_set_creds(struct linux_binprm *bprm, struct cred *cred)
 {
-	return cap_bprm_set_creds(bprm);
+	return cap_bprm_set_creds(bprm, cred);
 }
 
 static inline int security_bprm_check(struct linux_binprm *bprm)
diff --git a/kernel/cred.c b/kernel/cred.c
index 1873e87..b2a81d3 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -267,34 +267,24 @@ error:
 }
 
 /**
- * prepare_creds - Prepare a new set of credentials for modification
- *
- * Prepare a new set of task credentials for modification.  A task's creds
- * shouldn't generally be modified directly, therefore this function is used to
- * prepare a new copy, which the caller then modifies and then commits by
- * calling commit_creds().
+ * duplicate_creds - Prepare a duplicate set of credentials for modification
  *
- * Preparation involves making a copy of the objective creds for modification.
+ * Prepare a duplicate set of credentials for modification.
  *
  * Returns a pointer to the new creds-to-be if successful, NULL otherwise.
  *
  * Call commit_creds() or abort_creds() to clean up.
  */
-struct cred *prepare_creds(void)
+struct cred *duplicate_creds(const struct cred *old)
 {
-	struct task_struct *task = current;
-	const struct cred *old;
 	struct cred *new;
 
-	validate_process_creds();
-
 	new = kmem_cache_alloc(cred_jar, GFP_KERNEL);
 	if (!new)
 		return NULL;
 
-	kdebug("prepare_creds() alloc %p", new);
+	kdebug("duplicate_creds() alloc %p", new);
 
-	old = task->cred;
 	memcpy(new, old, sizeof(struct cred));
 
 	atomic_set(&new->usage, 1);
@@ -321,6 +311,26 @@ error:
 	abort_creds(new);
 	return NULL;
 }
+
+/**
+ * prepare_creds - Prepare a new set of credentials for modification
+ *
+ * Prepare a new set of task credentials for modification.  A task's creds
+ * shouldn't generally be modified directly, therefore this function is used to
+ * prepare a new copy, which the caller then modifies and then commits by
+ * calling commit_creds().
+ *
+ * Preparation involves making a copy of the objective creds for modification.
+ *
+ * Returns a pointer to the new creds-to-be if successful, NULL otherwise.
+ *
+ * Call commit_creds() or abort_creds() to clean up.
+ */
+struct cred *prepare_creds(void)
+{
+	validate_process_creds();
+	return duplicate_creds(current->cred);
+}
 EXPORT_SYMBOL(prepare_creds);
 
 /*
diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index c825c6e..c96832e 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -337,10 +337,11 @@ static struct aa_profile *x_to_profile(struct aa_profile *profile,
 /**
  * apparmor_bprm_set_creds - set the new creds on the bprm struct
  * @bprm: binprm for the exec  (NOT NULL)
+ * @cred: the credentials under construction.
  *
  * Returns: %0 or error on failure
  */
-int apparmor_bprm_set_creds(struct linux_binprm *bprm)
+int apparmor_bprm_set_creds(struct linux_binprm *bprm, struct cred *cred)
 {
 	struct aa_task_cxt *cxt;
 	struct aa_profile *profile, *new_profile = NULL;
@@ -353,14 +354,14 @@ int apparmor_bprm_set_creds(struct linux_binprm *bprm)
 		bprm->file->f_path.dentry->d_inode->i_mode
 	};
 	const char *name = NULL, *target = NULL, *info = NULL;
-	int error = cap_bprm_set_creds(bprm);
+	int error = cap_bprm_set_creds(bprm, cred);
 	if (error)
 		return error;
 
 	if (bprm->cred_prepared)
 		return 0;
 
-	cxt = bprm->cred->security;
+	cxt = cred->security;
 	BUG_ON(!cxt);
 
 	profile = aa_get_profile(aa_newest_version(cxt->profile));
diff --git a/security/apparmor/include/domain.h b/security/apparmor/include/domain.h
index de04464..963a97d 100644
--- a/security/apparmor/include/domain.h
+++ b/security/apparmor/include/domain.h
@@ -23,7 +23,7 @@ struct aa_domain {
 	char **table;
 };
 
-int apparmor_bprm_set_creds(struct linux_binprm *bprm);
+int apparmor_bprm_set_creds(struct linux_binprm *bprm, struct cred *cred);
 int apparmor_bprm_secureexec(struct linux_binprm *bprm);
 void apparmor_bprm_committing_creds(struct linux_binprm *bprm);
 void apparmor_bprm_committed_creds(struct linux_binprm *bprm);
diff --git a/security/commoncap.c b/security/commoncap.c
index f20e984..62d8c5c 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -277,9 +277,9 @@ int cap_capset(struct cred *new,
 /*
  * Clear proposed capability sets for execve().
  */
-static inline void bprm_clear_caps(struct linux_binprm *bprm)
+static inline void bprm_clear_caps(struct linux_binprm *bprm, struct cred *cred)
 {
-	cap_clear(bprm->cred->cap_permitted);
+	cap_clear(cred->cap_permitted);
 	bprm->cap_effective = false;
 }
 
@@ -332,9 +332,8 @@ int cap_inode_killpriv(struct dentry *dentry)
  */
 static inline int bprm_caps_from_vfs_caps(struct cpu_vfs_cap_data *caps,
 					  struct linux_binprm *bprm,
-					  bool *effective)
+					  bool *effective, struct cred *new)
 {
-	struct cred *new = bprm->cred;
 	unsigned i;
 	int ret = 0;
 
@@ -424,13 +423,14 @@ int get_vfs_caps_from_disk(const struct dentry *dentry, struct cpu_vfs_cap_data
  * its xattrs and, if present, apply them to the proposed credentials being
  * constructed by execve().
  */
-static int get_file_caps(struct linux_binprm *bprm, bool *effective)
+static int get_file_caps(struct linux_binprm *bprm, bool *effective,
+			 struct cred *new)
 {
 	struct dentry *dentry;
 	int rc = 0;
 	struct cpu_vfs_cap_data vcaps;
 
-	bprm_clear_caps(bprm);
+	bprm_clear_caps(bprm, new);
 
 	if (!file_caps_enabled)
 		return 0;
@@ -450,7 +450,7 @@ static int get_file_caps(struct linux_binprm *bprm, bool *effective)
 		goto out;
 	}
 
-	rc = bprm_caps_from_vfs_caps(&vcaps, bprm, effective);
+	rc = bprm_caps_from_vfs_caps(&vcaps, bprm, effective, new);
 	if (rc == -EINVAL)
 		printk(KERN_NOTICE "%s: cap_from_disk returned %d for %s\n",
 		       __func__, rc, bprm->filename);
@@ -458,7 +458,7 @@ static int get_file_caps(struct linux_binprm *bprm, bool *effective)
 out:
 	dput(dentry);
 	if (rc)
-		bprm_clear_caps(bprm);
+		bprm_clear_caps(bprm, new);
 
 	return rc;
 }
@@ -466,20 +466,20 @@ out:
 /**
  * cap_bprm_set_creds - Set up the proposed credentials for execve().
  * @bprm: The execution parameters, including the proposed creds
+ * @new: The credentials being constructed
  *
  * Set up the proposed credentials for a new execution context being
  * constructed by execve().  The proposed creds in @bprm->cred is altered,
  * which won't take effect immediately.  Returns 0 if successful, -ve on error.
  */
-int cap_bprm_set_creds(struct linux_binprm *bprm)
+int cap_bprm_set_creds(struct linux_binprm *bprm, struct cred *new)
 {
 	const struct cred *old = current_cred();
-	struct cred *new = bprm->cred;
 	bool effective;
 	int ret;
 
 	effective = false;
-	ret = get_file_caps(bprm, &effective);
+	ret = get_file_caps(bprm, &effective, new);
 	if (ret < 0)
 		return ret;
 
diff --git a/security/security.c b/security/security.c
index 1011423..2499e94 100644
--- a/security/security.c
+++ b/security/security.c
@@ -224,9 +224,9 @@ int security_vm_enough_memory_kern(long pages)
 	return security_ops->vm_enough_memory(current->mm, pages);
 }
 
-int security_bprm_set_creds(struct linux_binprm *bprm)
+int security_bprm_set_creds(struct linux_binprm *bprm, struct cred *cred)
 {
-	return security_ops->bprm_set_creds(bprm);
+	return security_ops->bprm_set_creds(bprm, cred);
 }
 
 int security_bprm_check(struct linux_binprm *bprm)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f9c3764..1b63c11 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1943,7 +1943,7 @@ static int selinux_vm_enough_memory(struct mm_struct *mm, long pages)
 
 /* binprm security operations */
 
-static int selinux_bprm_set_creds(struct linux_binprm *bprm)
+static int selinux_bprm_set_creds(struct linux_binprm *bprm, struct cred *cred)
 {
 	const struct task_security_struct *old_tsec;
 	struct task_security_struct *new_tsec;
@@ -1952,7 +1952,7 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
 	struct inode *inode = bprm->file->f_path.dentry->d_inode;
 	int rc;
 
-	rc = cap_bprm_set_creds(bprm);
+	rc = cap_bprm_set_creds(bprm, cred);
 	if (rc)
 		return rc;
 
@@ -1962,7 +1962,7 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
 		return 0;
 
 	old_tsec = current_security();
-	new_tsec = bprm->cred->security;
+	new_tsec = cred->security;
 	isec = inode->i_security;
 
 	/* Default to the current task SID. */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index c6f8fca..ba4c992 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -438,14 +438,14 @@ static int smack_sb_umount(struct vfsmount *mnt, int flags)
  * BPRM hooks
  */
 
-static int smack_bprm_set_creds(struct linux_binprm *bprm)
+static int smack_bprm_set_creds(struct linux_binprm *bprm, struct cred *cred)
 {
-	struct task_smack *tsp = bprm->cred->security;
+	struct task_smack *tsp = cred->security;
 	struct inode_smack *isp;
 	struct dentry *dp;
 	int rc;
 
-	rc = cap_bprm_set_creds(bprm);
+	rc = cap_bprm_set_creds(bprm, cred);
 	if (rc != 0)
 		return rc;
 
diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
index 7c66bd8..7b4c330 100644
--- a/security/tomoyo/common.h
+++ b/security/tomoyo/common.h
@@ -851,7 +851,7 @@ int tomoyo_mkdev_perm(const u8 operation, struct path *path,
 int tomoyo_path_perm(const u8 operation, struct path *path);
 int tomoyo_path2_perm(const u8 operation, struct path *path1,
 		      struct path *path2);
-int tomoyo_find_next_domain(struct linux_binprm *bprm);
+int tomoyo_find_next_domain(struct linux_binprm *bprm, struct cred *cred);
 
 void tomoyo_print_ulong(char *buffer, const int buffer_len,
 			const unsigned long value, const u8 type);
diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
index 3538840..f76431d 100644
--- a/security/tomoyo/domain.c
+++ b/security/tomoyo/domain.c
@@ -406,12 +406,13 @@ struct tomoyo_domain_info *tomoyo_assign_domain(const char *domainname,
  * tomoyo_find_next_domain - Find a domain.
  *
  * @bprm: Pointer to "struct linux_binprm".
+ * @cred: The credentials under construction.
  *
  * Returns 0 on success, negative value otherwise.
  *
  * Caller holds tomoyo_read_lock().
  */
-int tomoyo_find_next_domain(struct linux_binprm *bprm)
+int tomoyo_find_next_domain(struct linux_binprm *bprm, struct cred *cred)
 {
 	struct tomoyo_request_info r;
 	char *tmp = kzalloc(TOMOYO_EXEC_TMPSIZE, GFP_NOFS);
@@ -534,7 +535,7 @@ int tomoyo_find_next_domain(struct linux_binprm *bprm)
 		domain = old_domain;
 	/* Update reference count on "struct tomoyo_domain_info". */
 	atomic_inc(&domain->users);
-	bprm->cred->security = domain;
+	cred->security = domain;
 	if (need_kfree)
 		kfree(rn.name);
 	kfree(tmp);
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 5a72868..6f0f325 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -37,11 +37,11 @@ static void tomoyo_cred_free(struct cred *cred)
 		atomic_dec(&domain->users);
 }
 
-static int tomoyo_bprm_set_creds(struct linux_binprm *bprm)
+static int tomoyo_bprm_set_creds(struct linux_binprm *bprm, struct cred *cred)
 {
 	int rc, idx, err;
 
-	rc = cap_bprm_set_creds(bprm);
+	rc = cap_bprm_set_creds(bprm, cred);
 	if (rc)
 		return rc;
 
@@ -63,15 +63,14 @@ static int tomoyo_bprm_set_creds(struct linux_binprm *bprm)
 	 * stored inside "bprm->cred->security" will be acquired later inside
 	 * tomoyo_find_next_domain().
 	 */
-	atomic_dec(&((struct tomoyo_domain_info *)
-		     bprm->cred->security)->users);
+	atomic_dec(&((struct tomoyo_domain_info *)cred->security)->users);
 
 	/* Check that the caller has execute permission on the program they
 	 * actually asked to run and install the new domain into the
 	 * credentials being constructed.
 	 */
 	idx = tomoyo_read_lock();
-	err = tomoyo_find_next_domain(bprm);
+	err = tomoyo_find_next_domain(bprm, cred);
 	tomoyo_read_unlock(idx);
 	return err;
 }


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
