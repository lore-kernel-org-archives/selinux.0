Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3LEV03h016413
	for <selinux@tycho.nsa.gov>; Thu, 21 Apr 2011 10:31:14 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p3LEVDTB001373
	for <selinux@tycho.nsa.gov>; Thu, 21 Apr 2011 14:31:13 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 7/9] LSM: Allow an LSM to indicate that it wants bprm->file
 reopening with new creds
To: serge.hallyn@canonical.com, eparis@redhat.com
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        David Howells <dhowells@redhat.com>
Date: Thu, 21 Apr 2011 15:31:06 +0100
Message-ID: <20110421143106.31318.99012.stgit@warthog.procyon.org.uk>
In-Reply-To: <20110421143020.31318.59457.stgit@warthog.procyon.org.uk>
References: <20110421143020.31318.59457.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Allow an LSM module's bprm_set_creds() security op to indicate that it wants
bprm->file reopening with the newly calculated credentials.  This is done
towards the end of prepare_binprm() after all the security modules have had a
say, but before the bprm buffer is loaded from the file.

The LSM modules should set this flag if they changed the process security
context that will be used to access the file.  The LSM policies will then need
a rule to permit a process to open, read, execute or mmap their own executable
or script interpreter image file and binary loader file.

This patch does not actually reopen the file - that is left to a subsequent
patch.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/exec.c                          |    9 ++++++++-
 include/linux/security.h           |   15 ++++++++++-----
 security/apparmor/domain.c         |    7 +++++--
 security/apparmor/include/domain.h |    3 ++-
 security/commoncap.c               |    4 +++-
 security/security.c                |    5 +++--
 security/selinux/hooks.c           |   15 ++++++++++++---
 security/smack/smack_lsm.c         |    9 ++++++---
 security/tomoyo/common.h           |    3 ++-
 security/tomoyo/domain.c           |    6 +++++-
 security/tomoyo/tomoyo.c           |    7 ++++---
 11 files changed, 60 insertions(+), 23 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 84625a1..4c47395 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1224,6 +1224,7 @@ int prepare_binprm(struct linux_binprm *bprm)
 	struct cred *cred;
 	umode_t mode;
 	struct inode * inode = bprm->file->f_path.dentry->d_inode;
+	bool reopen_file = false;
 	int retval;
 
 	mode = inode->i_mode;
@@ -1243,6 +1244,7 @@ int prepare_binprm(struct linux_binprm *bprm)
 		if (mode & S_ISUID) {
 			bprm->per_clear |= PER_CLEAR_ON_SETID;
 			cred->euid = inode->i_uid;
+			reopen_file = true;
 		}
 
 		/* Set-gid? */
@@ -1254,11 +1256,12 @@ int prepare_binprm(struct linux_binprm *bprm)
 		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
 			bprm->per_clear |= PER_CLEAR_ON_SETID;
 			cred->egid = inode->i_gid;
+			reopen_file = true;
 		}
 	}
 
 	/* fill in binprm security blob */
-	retval = security_bprm_set_creds(bprm, cred);
+	retval = security_bprm_set_creds(bprm, cred, &reopen_file);
 	if (retval) {
 		abort_creds(cred);
 		return retval;
@@ -1271,6 +1274,10 @@ int prepare_binprm(struct linux_binprm *bprm)
 	bprm->cred_prepared = 1;
 	put_cred(old);
 
+	/* TODO: Reopen the executable image file if any significant security
+	 * data changed during calculation of the new credentials
+	 */
+
 	memset(bprm->buf, 0, BINPRM_BUF_SIZE);
 	return exec_read_header(bprm, bprm->file);
 }
diff --git a/include/linux/security.h b/include/linux/security.h
index 6b99225..5555dee 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -63,7 +63,8 @@ extern int cap_capset(struct cred *new, const struct cred *old,
 		      const kernel_cap_t *effective,
 		      const kernel_cap_t *inheritable,
 		      const kernel_cap_t *permitted);
-extern int cap_bprm_set_creds(struct linux_binprm *bprm, struct cred *cred);
+extern int cap_bprm_set_creds(struct linux_binprm *bprm, struct cred *cred,
+			      bool *_reopen_file);
 extern int cap_bprm_secureexec(struct linux_binprm *bprm);
 extern int cap_inode_setxattr(struct dentry *dentry, const char *name,
 			      const void *value, size_t size, int flags);
@@ -198,6 +199,7 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
  *	to replace it.
  *	@bprm contains the linux_binprm structure.
  *	@cred contains the new credentials under construction at this point
+ *	*@_reopen_file should be set if the file needs reopening with the new creds
  *	Return 0 if the hook is successful and permission is granted.
  * @bprm_check_security:
  *	This hook mediates the point when a search for a binary handler will
@@ -1394,7 +1396,8 @@ struct security_operations {
 	int (*settime) (const struct timespec *ts, const struct timezone *tz);
 	int (*vm_enough_memory) (struct mm_struct *mm, long pages);
 
-	int (*bprm_set_creds) (struct linux_binprm *bprm, struct cred *cred);
+	int (*bprm_set_creds) (struct linux_binprm *bprm, struct cred *cred,
+			       bool *_reopen_file);
 	int (*bprm_check_security) (struct linux_binprm *bprm);
 	int (*bprm_secureexec) (struct linux_binprm *bprm);
 	void (*bprm_committing_creds) (struct linux_binprm *bprm);
@@ -1681,7 +1684,8 @@ int security_settime(const struct timespec *ts, const struct timezone *tz);
 int security_vm_enough_memory(long pages);
 int security_vm_enough_memory_mm(struct mm_struct *mm, long pages);
 int security_vm_enough_memory_kern(long pages);
-int security_bprm_set_creds(struct linux_binprm *bprm, struct cred *cred);
+int security_bprm_set_creds(struct linux_binprm *bprm, struct cred *cred,
+			    bool *_reopen_file);
 int security_bprm_check(struct linux_binprm *bprm);
 void security_bprm_committing_creds(struct linux_binprm *bprm);
 void security_bprm_committed_creds(struct linux_binprm *bprm);
@@ -1936,9 +1940,10 @@ static inline int security_vm_enough_memory_kern(long pages)
 }
 
 static inline
-int security_bprm_set_creds(struct linux_binprm *bprm, struct cred *cred)
+int security_bprm_set_creds(struct linux_binprm *bprm, struct cred *cred,
+			    bool *_reopen_file)
 {
-	return cap_bprm_set_creds(bprm, cred);
+	return cap_bprm_set_creds(bprm, cred, _reopen_file);
 }
 
 static inline int security_bprm_check(struct linux_binprm *bprm)
diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index c96832e..cdef6bb 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -338,10 +338,12 @@ static struct aa_profile *x_to_profile(struct aa_profile *profile,
  * apparmor_bprm_set_creds - set the new creds on the bprm struct
  * @bprm: binprm for the exec  (NOT NULL)
  * @cred: the credentials under construction.
+ * *@_reopen_file: set to true to reopen bprm->file under the new creds
  *
  * Returns: %0 or error on failure
  */
-int apparmor_bprm_set_creds(struct linux_binprm *bprm, struct cred *cred)
+int apparmor_bprm_set_creds(struct linux_binprm *bprm, struct cred *cred,
+			    bool *_reopen_file)
 {
 	struct aa_task_cxt *cxt;
 	struct aa_profile *profile, *new_profile = NULL;
@@ -354,7 +356,7 @@ int apparmor_bprm_set_creds(struct linux_binprm *bprm, struct cred *cred)
 		bprm->file->f_path.dentry->d_inode->i_mode
 	};
 	const char *name = NULL, *target = NULL, *info = NULL;
-	int error = cap_bprm_set_creds(bprm, cred);
+	int error = cap_bprm_set_creds(bprm, cred, _reopen_file);
 	if (error)
 		return error;
 
@@ -498,6 +500,7 @@ x_clear:
 	aa_put_profile(cxt->profile);
 	/* transfer new profile reference will be released when cxt is freed */
 	cxt->profile = new_profile;
+	*_reopen_file = true;
 
 	/* clear out all temporary/transitional state from the context */
 	aa_put_profile(cxt->previous);
diff --git a/security/apparmor/include/domain.h b/security/apparmor/include/domain.h
index 963a97d..fda5f88 100644
--- a/security/apparmor/include/domain.h
+++ b/security/apparmor/include/domain.h
@@ -23,7 +23,8 @@ struct aa_domain {
 	char **table;
 };
 
-int apparmor_bprm_set_creds(struct linux_binprm *bprm, struct cred *cred);
+int apparmor_bprm_set_creds(struct linux_binprm *bprm, struct cred *cred,
+			    bool *_reopen_file);
 int apparmor_bprm_secureexec(struct linux_binprm *bprm);
 void apparmor_bprm_committing_creds(struct linux_binprm *bprm);
 void apparmor_bprm_committed_creds(struct linux_binprm *bprm);
diff --git a/security/commoncap.c b/security/commoncap.c
index 62d8c5c..44567bf 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -467,12 +467,14 @@ out:
  * cap_bprm_set_creds - Set up the proposed credentials for execve().
  * @bprm: The execution parameters, including the proposed creds
  * @new: The credentials being constructed
+ * *@_reopen_file: Set to reopen bprm->file with the new creds
  *
  * Set up the proposed credentials for a new execution context being
  * constructed by execve().  The proposed creds in @bprm->cred is altered,
  * which won't take effect immediately.  Returns 0 if successful, -ve on error.
  */
-int cap_bprm_set_creds(struct linux_binprm *bprm, struct cred *new)
+int cap_bprm_set_creds(struct linux_binprm *bprm, struct cred *new,
+		       bool *_reopen_file)
 {
 	const struct cred *old = current_cred();
 	bool effective;
diff --git a/security/security.c b/security/security.c
index 2499e94..2de57f5 100644
--- a/security/security.c
+++ b/security/security.c
@@ -224,9 +224,10 @@ int security_vm_enough_memory_kern(long pages)
 	return security_ops->vm_enough_memory(current->mm, pages);
 }
 
-int security_bprm_set_creds(struct linux_binprm *bprm, struct cred *cred)
+int security_bprm_set_creds(struct linux_binprm *bprm, struct cred *cred,
+			    bool *_reopen_file)
 {
-	return security_ops->bprm_set_creds(bprm, cred);
+	return security_ops->bprm_set_creds(bprm, cred, _reopen_file);
 }
 
 int security_bprm_check(struct linux_binprm *bprm)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1b63c11..b55d3bb 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1943,7 +1943,13 @@ static int selinux_vm_enough_memory(struct mm_struct *mm, long pages)
 
 /* binprm security operations */
 
-static int selinux_bprm_set_creds(struct linux_binprm *bprm, struct cred *cred)
+/*
+ * Calculate the new security data for the exec'd process and store it in the
+ * creds provided.  If the task sid is to be changed, then the caller is asked
+ * to reopen bprm->file with the new creds.
+ */
+static int selinux_bprm_set_creds(struct linux_binprm *bprm, struct cred *cred,
+				  bool *_reopen_file)
 {
 	const struct task_security_struct *old_tsec;
 	struct task_security_struct *new_tsec;
@@ -1952,7 +1958,7 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm, struct cred *cred)
 	struct inode *inode = bprm->file->f_path.dentry->d_inode;
 	int rc;
 
-	rc = cap_bprm_set_creds(bprm, cred);
+	rc = cap_bprm_set_creds(bprm, cred, _reopen_file);
 	if (rc)
 		return rc;
 
@@ -2046,6 +2052,9 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm, struct cred *cred)
 
 		/* Clear any possibly unsafe personality bits on exec: */
 		bprm->per_clear |= PER_CLEAR_ON_SETID;
+
+		/* The file needs reopening with the new SID */
+		*_reopen_file = true;
 	}
 
 	return 0;
@@ -2625,7 +2634,7 @@ static int selinux_inode_readlink(struct dentry *dentry)
 {
 	const struct cred *cred = current_cred();
 
-	return dentry_has_perm(cred, NULL, dentry, FILE__READ);
+	return dentry_has_perm(cred, NULL, dentry, LNK_FILE__READ);
 }
 
 static int selinux_inode_follow_link(struct dentry *dentry, struct nameidata *nameidata)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index ba4c992..36a3e84 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -438,14 +438,15 @@ static int smack_sb_umount(struct vfsmount *mnt, int flags)
  * BPRM hooks
  */
 
-static int smack_bprm_set_creds(struct linux_binprm *bprm, struct cred *cred)
+static int smack_bprm_set_creds(struct linux_binprm *bprm, struct cred *cred,
+				bool *_reopen_file)
 {
 	struct task_smack *tsp = cred->security;
 	struct inode_smack *isp;
 	struct dentry *dp;
 	int rc;
 
-	rc = cap_bprm_set_creds(bprm, cred);
+	rc = cap_bprm_set_creds(bprm, cred, _reopen_file);
 	if (rc != 0)
 		return rc;
 
@@ -462,8 +463,10 @@ static int smack_bprm_set_creds(struct linux_binprm *bprm, struct cred *cred)
 
 	isp = dp->d_inode->i_security;
 
-	if (isp->smk_task != NULL)
+	if (isp->smk_task != NULL && tsp->smk_task != isp->smk_task) {
+		*_reopen_file = true;
 		tsp->smk_task = isp->smk_task;
+	}
 
 	return 0;
 }
diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
index 7b4c330..814b1ec 100644
--- a/security/tomoyo/common.h
+++ b/security/tomoyo/common.h
@@ -851,7 +851,8 @@ int tomoyo_mkdev_perm(const u8 operation, struct path *path,
 int tomoyo_path_perm(const u8 operation, struct path *path);
 int tomoyo_path2_perm(const u8 operation, struct path *path1,
 		      struct path *path2);
-int tomoyo_find_next_domain(struct linux_binprm *bprm, struct cred *cred);
+int tomoyo_find_next_domain(struct linux_binprm *bprm, struct cred *cred,
+			    bool *_reopen_file);
 
 void tomoyo_print_ulong(char *buffer, const int buffer_len,
 			const unsigned long value, const u8 type);
diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
index f76431d..a33fc82 100644
--- a/security/tomoyo/domain.c
+++ b/security/tomoyo/domain.c
@@ -407,12 +407,14 @@ struct tomoyo_domain_info *tomoyo_assign_domain(const char *domainname,
  *
  * @bprm: Pointer to "struct linux_binprm".
  * @cred: The credentials under construction.
+ * *@_reopen_file: Set to reopen bprm->file with new creds.
  *
  * Returns 0 on success, negative value otherwise.
  *
  * Caller holds tomoyo_read_lock().
  */
-int tomoyo_find_next_domain(struct linux_binprm *bprm, struct cred *cred)
+int tomoyo_find_next_domain(struct linux_binprm *bprm, struct cred *cred,
+			    bool *_reopen_file)
 {
 	struct tomoyo_request_info r;
 	char *tmp = kzalloc(TOMOYO_EXEC_TMPSIZE, GFP_NOFS);
@@ -533,6 +535,8 @@ int tomoyo_find_next_domain(struct linux_binprm *bprm, struct cred *cred)
  out:
 	if (!domain)
 		domain = old_domain;
+	else if (domain != old_domain)
+		*_reopen_file = true;
 	/* Update reference count on "struct tomoyo_domain_info". */
 	atomic_inc(&domain->users);
 	cred->security = domain;
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 6f0f325..ecf24a7 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -37,11 +37,12 @@ static void tomoyo_cred_free(struct cred *cred)
 		atomic_dec(&domain->users);
 }
 
-static int tomoyo_bprm_set_creds(struct linux_binprm *bprm, struct cred *cred)
+static int tomoyo_bprm_set_creds(struct linux_binprm *bprm, struct cred *cred,
+				 bool *_reopen_file)
 {
 	int rc, idx, err;
 
-	rc = cap_bprm_set_creds(bprm, cred);
+	rc = cap_bprm_set_creds(bprm, cred, _reopen_file);
 	if (rc)
 		return rc;
 
@@ -70,7 +71,7 @@ static int tomoyo_bprm_set_creds(struct linux_binprm *bprm, struct cred *cred)
 	 * credentials being constructed.
 	 */
 	idx = tomoyo_read_lock();
-	err = tomoyo_find_next_domain(bprm, cred);
+	err = tomoyo_find_next_domain(bprm, cred, _reopen_file);
 	tomoyo_read_unlock(idx);
 	return err;
 }


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
