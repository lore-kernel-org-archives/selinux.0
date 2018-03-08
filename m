Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w281qtvv030167
 for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2018 20:52:58 -0500
To: LSM <linux-security-module@vger.kernel.org>,
 James Morris <jmorris@namei.org>
Cc: John Johansen <john.johansen@canonical.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, Kees Cook <keescook@chromium.org>,
 Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
 SMACK-announce@lists.01.org, Casey Schaufler <casey@schaufler-ca.com>
References: <d2c25c38-e19d-1e08-8c49-4726a34e72bb@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <25eaf580-7fee-c11a-eb26-afed825111f9@schaufler-ca.com>
Date: Wed, 7 Mar 2018 17:52:53 -0800
MIME-Version: 1.0
In-Reply-To: <d2c25c38-e19d-1e08-8c49-4726a34e72bb@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Subject: [PATCH 3/8] LSM: Manage file security blobs
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Subject: [PATCH 3/8] LSM: Manage file security blobs

Move the management of file security blobs from the individual
security modules to the security infrastructure. The security modules
using file blobs have been updated accordingly. Modules are required
to identify the space they need at module initialization. In some
cases a module no longer needs to supply a blob management hook, in
which case the hook has been removed.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h           |  1 +
 security/apparmor/include/context.h |  5 ++++
 security/apparmor/include/file.h    |  2 +-
 security/apparmor/lsm.c             | 19 ++++++-------
 security/security.c                 | 54 ++++++++++++++++++++++++++++++++++---
 security/selinux/hooks.c            | 41 +++++++---------------------
 security/selinux/include/objsec.h   |  5 ++++
 security/smack/smack.h              |  5 ++++
 security/smack/smack_lsm.c          | 26 +++++++-----------
 9 files changed, 97 insertions(+), 61 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index bb36a9ead1fe..417a8946201a 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1974,6 +1974,7 @@ struct security_hook_list {
  */
 struct lsm_blob_sizes {
 	int	lbs_cred;
+	int	lbs_file;
 };
 
 /*
diff --git a/security/apparmor/include/context.h b/security/apparmor/include/context.h
index 301ab3a0dd04..c6e106a533e8 100644
--- a/security/apparmor/include/context.h
+++ b/security/apparmor/include/context.h
@@ -87,6 +87,11 @@ static inline struct aa_label *aa_get_newest_cred_label(const struct cred *cred)
 	return aa_get_newest_label(aa_cred_raw_label(cred));
 }
 
+static inline struct aa_file_ctx *apparmor_file(const struct file *file)
+{
+	return file->f_security;
+}
+
 /**
  * __aa_task_raw_label - retrieve another task's label
  * @task: task to query  (NOT NULL)
diff --git a/security/apparmor/include/file.h b/security/apparmor/include/file.h
index 4c2c8ac8842f..b9efe6bc226b 100644
--- a/security/apparmor/include/file.h
+++ b/security/apparmor/include/file.h
@@ -32,7 +32,7 @@ struct path;
 				 AA_MAY_CHMOD | AA_MAY_CHOWN | AA_MAY_LOCK | \
 				 AA_EXEC_MMAP | AA_MAY_LINK)
 
-#define file_ctx(X) ((struct aa_file_ctx *)(X)->f_security)
+#define file_ctx(X) apparmor_file(X)
 
 /* struct aa_file_ctx - the AppArmor context the file was opened in
  * @lock: lock to update the ctx
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 6058ce595037..03c7cbce4853 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -401,21 +401,21 @@ static int apparmor_file_open(struct file *file, const struct cred *cred)
 
 static int apparmor_file_alloc_security(struct file *file)
 {
-	int error = 0;
-
-	/* freed by apparmor_file_free_security */
+	struct aa_file_ctx *ctx = file_ctx(file);
 	struct aa_label *label = begin_current_label_crit_section();
-	file->f_security = aa_alloc_file_ctx(label, GFP_KERNEL);
-	if (!file_ctx(file))
-		error = -ENOMEM;
-	end_current_label_crit_section(label);
 
-	return error;
+	spin_lock_init(&ctx->lock);
+	rcu_assign_pointer(ctx->label, aa_get_label(label));
+	end_current_label_crit_section(label);
+	return 0;
 }
 
 static void apparmor_file_free_security(struct file *file)
 {
-	aa_free_file_ctx(file_ctx(file));
+	struct aa_file_ctx *ctx = file_ctx(file);
+
+	if (ctx)
+		aa_put_label(rcu_access_pointer(ctx->label));
 }
 
 static int common_file_perm(const char *op, struct file *file, u32 mask)
@@ -722,6 +722,7 @@ static int apparmor_task_kill(struct task_struct *target, struct siginfo *info,
 
 struct lsm_blob_sizes apparmor_blob_sizes = {
 	.lbs_cred = sizeof(struct aa_task_ctx),
+	.lbs_file = sizeof(struct aa_file_ctx),
 };
 
 static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
diff --git a/security/security.c b/security/security.c
index c471019e2a7e..90d09d8542d4 100644
--- a/security/security.c
+++ b/security/security.c
@@ -38,6 +38,8 @@
 struct security_hook_heads security_hook_heads __lsm_ro_after_init;
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
 
+static struct kmem_cache *lsm_file_cache;
+
 char *lsm_names;
 static struct lsm_blob_sizes blob_sizes;
 
@@ -83,6 +85,13 @@ int __init security_init(void)
 	 */
 	do_security_initcalls();
 
+	/*
+	 * Create any kmem_caches needed for blobs
+	 */
+	if (blob_sizes.lbs_file)
+		lsm_file_cache = kmem_cache_create("lsm_file_cache",
+						   blob_sizes.lbs_file, 0,
+						   SLAB_PANIC, NULL);
 	/*
 	 * The second call to a module specific init function
 	 * adds hooks to the hook lists and does any other early
@@ -92,6 +101,7 @@ int __init security_init(void)
 
 #ifdef CONFIG_SECURITY_LSM_DEBUG
 	pr_info("LSM: cred blob size       = %d\n", blob_sizes.lbs_cred);
+	pr_info("LSM: file blob size       = %d\n", blob_sizes.lbs_file);
 #endif
 
 	return 0;
@@ -266,6 +276,28 @@ static void __init lsm_set_size(int *need, int *lbs)
 void __init security_add_blobs(struct lsm_blob_sizes *needed)
 {
 	lsm_set_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
+	lsm_set_size(&needed->lbs_file, &blob_sizes.lbs_file);
+}
+
+/**
+ * lsm_file_alloc - allocate a composite file blob
+ * @file: the file that needs a blob
+ *
+ * Allocate the file blob for all the modules
+ *
+ * Returns 0, or -ENOMEM if memory can't be allocated.
+ */
+int lsm_file_alloc(struct file *file)
+{
+	if (!lsm_file_cache) {
+		file->f_security = NULL;
+		return 0;
+	}
+
+	file->f_security = kmem_cache_zalloc(lsm_file_cache, GFP_KERNEL);
+	if (file->f_security == NULL)
+		return -ENOMEM;
+	return 0;
 }
 
 /*
@@ -951,12 +983,28 @@ int security_file_permission(struct file *file, int mask)
 
 int security_file_alloc(struct file *file)
 {
-	return call_int_hook(file_alloc_security, 0, file);
+	int rc = lsm_file_alloc(file);
+
+	if (rc)
+		return rc;
+	rc = call_int_hook(file_alloc_security, 0, file);
+	if (unlikely(rc))
+		security_file_free(file);
+	return rc;
 }
 
 void security_file_free(struct file *file)
 {
+	void *blob;
+
+	if (!lsm_file_cache)
+		return;
+
 	call_void_hook(file_free_security, file);
+
+	blob = file->f_security;
+	file->f_security = NULL;
+	kmem_cache_free(lsm_file_cache, blob);
 }
 
 int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
@@ -1074,7 +1122,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 		return rc;
 
 	rc = call_int_hook(cred_alloc_blank, 0, cred, gfp);
-	if (rc)
+	if (unlikely(rc))
 		security_cred_free(cred);
 	return rc;
 }
@@ -1095,7 +1143,7 @@ int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp)
 		return rc;
 
 	rc = call_int_hook(cred_prepare, 0, new, old, gfp);
-	if (rc)
+	if (unlikely(rc))
 		security_cred_free(new);
 	return rc;
 }
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index aee16f5b6e1e..ed01d18d0924 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -130,7 +130,6 @@ int selinux_enabled = 1;
 #endif
 
 static struct kmem_cache *sel_inode_cache;
-static struct kmem_cache *file_security_cache;
 
 /**
  * selinux_secmark_enabled - Check to see if SECMARK is currently enabled
@@ -360,27 +359,15 @@ static void inode_free_security(struct inode *inode)
 
 static int file_alloc_security(struct file *file)
 {
-	struct file_security_struct *fsec;
+	struct file_security_struct *fsec = selinux_file(file);
 	u32 sid = current_sid();
 
-	fsec = kmem_cache_zalloc(file_security_cache, GFP_KERNEL);
-	if (!fsec)
-		return -ENOMEM;
-
 	fsec->sid = sid;
 	fsec->fown_sid = sid;
-	file->f_security = fsec;
 
 	return 0;
 }
 
-static void file_free_security(struct file *file)
-{
-	struct file_security_struct *fsec = file->f_security;
-	file->f_security = NULL;
-	kmem_cache_free(file_security_cache, fsec);
-}
-
 static int superblock_alloc_security(struct super_block *sb)
 {
 	struct superblock_security_struct *sbsec;
@@ -1828,7 +1815,7 @@ static int file_has_perm(const struct cred *cred,
 			 struct file *file,
 			 u32 av)
 {
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	struct inode *inode = file_inode(file);
 	struct common_audit_data ad;
 	u32 sid = cred_sid(cred);
@@ -2154,7 +2141,7 @@ static int selinux_binder_transfer_file(struct task_struct *from,
 					struct file *file)
 {
 	u32 sid = task_sid(to);
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	struct dentry *dentry = file->f_path.dentry;
 	struct inode_security_struct *isec;
 	struct common_audit_data ad;
@@ -3429,7 +3416,7 @@ static int selinux_revalidate_file_permission(struct file *file, int mask)
 static int selinux_file_permission(struct file *file, int mask)
 {
 	struct inode *inode = file_inode(file);
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	struct inode_security_struct *isec;
 	u32 sid = current_sid();
 
@@ -3451,11 +3438,6 @@ static int selinux_file_alloc_security(struct file *file)
 	return file_alloc_security(file);
 }
 
-static void selinux_file_free_security(struct file *file)
-{
-	file_free_security(file);
-}
-
 /*
  * Check whether a task has the ioctl permission and cmd
  * operation to an inode.
@@ -3464,7 +3446,7 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
 		u32 requested, u16 cmd)
 {
 	struct common_audit_data ad;
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	struct inode *inode = file_inode(file);
 	struct inode_security_struct *isec;
 	struct lsm_ioctlop_audit ioctl;
@@ -3710,7 +3692,7 @@ static void selinux_file_set_fowner(struct file *file)
 {
 	struct file_security_struct *fsec;
 
-	fsec = file->f_security;
+	fsec = selinux_file(file);
 	fsec->fown_sid = current_sid();
 }
 
@@ -3725,7 +3707,7 @@ static int selinux_file_send_sigiotask(struct task_struct *tsk,
 	/* struct fown_struct is never outside the context of a struct file */
 	file = container_of(fown, struct file, f_owner);
 
-	fsec = file->f_security;
+	fsec = selinux_file(file);
 
 	if (!signum)
 		perm = signal_to_av(SIGIO); /* as per send_sigio_to_task */
@@ -3748,7 +3730,7 @@ static int selinux_file_open(struct file *file, const struct cred *cred)
 	struct file_security_struct *fsec;
 	struct inode_security_struct *isec;
 
-	fsec = file->f_security;
+	fsec = selinux_file(file);
 	isec = inode_security(file_inode(file));
 	/*
 	 * Save inode label and policy sequence number
@@ -3878,7 +3860,7 @@ static int selinux_kernel_module_from_file(struct file *file)
 	ad.type = LSM_AUDIT_DATA_FILE;
 	ad.u.file = file;
 
-	fsec = file->f_security;
+	fsec = selinux_file(file);
 	if (sid != fsec->sid) {
 		rc = avc_has_perm(sid, fsec->sid, SECCLASS_FD, FD__USE, &ad);
 		if (rc)
@@ -6359,6 +6341,7 @@ static void selinux_bpf_prog_free(struct bpf_prog_aux *aux)
 
 struct lsm_blob_sizes selinux_blob_sizes = {
 	.lbs_cred = sizeof(struct task_security_struct),
+	.lbs_file = sizeof(struct file_security_struct),
 };
 
 static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
@@ -6429,7 +6412,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
 	LSM_HOOK_INIT(file_permission, selinux_file_permission),
 	LSM_HOOK_INIT(file_alloc_security, selinux_file_alloc_security),
-	LSM_HOOK_INIT(file_free_security, selinux_file_free_security),
 	LSM_HOOK_INIT(file_ioctl, selinux_file_ioctl),
 	LSM_HOOK_INIT(mmap_file, selinux_mmap_file),
 	LSM_HOOK_INIT(mmap_addr, selinux_mmap_addr),
@@ -6620,9 +6602,6 @@ static __init int selinux_init(void)
 	sel_inode_cache = kmem_cache_create("selinux_inode_security",
 					    sizeof(struct inode_security_struct),
 					    0, SLAB_PANIC, NULL);
-	file_security_cache = kmem_cache_create("selinux_file_security",
-					    sizeof(struct file_security_struct),
-					    0, SLAB_PANIC, NULL);
 	avc_init();
 
 	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index e57010b2ea1f..8117051eef41 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -165,4 +165,9 @@ static inline struct task_security_struct *selinux_cred(const struct cred *cred)
 	return cred->security;
 }
 
+static inline struct file_security_struct *selinux_file(const struct file *file)
+{
+	return file->f_security;
+}
+
 #endif /* _SELINUX_OBJSEC_H_ */
diff --git a/security/smack/smack.h b/security/smack/smack.h
index 0c6dce446825..043525a52e94 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -362,6 +362,11 @@ static inline struct task_smack *smack_cred(const struct cred *cred)
 	return cred->security;
 }
 
+static inline struct smack_known **smack_file(const struct file *file)
+{
+	return file->f_security;
+}
+
 /*
  * Is the directory transmuting?
  */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index a992c0a04795..1bffbab2e765 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1570,24 +1570,12 @@ static void smack_inode_getsecid(struct inode *inode, u32 *secid)
  */
 static int smack_file_alloc_security(struct file *file)
 {
-	struct smack_known *skp = smk_of_current();
+	struct smack_known **blob = smack_file(file);
 
-	file->f_security = skp;
+	*blob = smk_of_current();
 	return 0;
 }
 
-/**
- * smack_file_free_security - clear a file security blob
- * @file: the object
- *
- * The security blob for a file is a pointer to the master
- * label list, so no memory is freed.
- */
-static void smack_file_free_security(struct file *file)
-{
-	file->f_security = NULL;
-}
-
 /**
  * smack_file_ioctl - Smack check on ioctls
  * @file: the object
@@ -1812,7 +1800,9 @@ static int smack_mmap_file(struct file *file,
  */
 static void smack_file_set_fowner(struct file *file)
 {
-	file->f_security = smk_of_current();
+	struct smack_known **blob = smack_file(file);
+
+	*blob = smk_of_current();
 }
 
 /**
@@ -1829,6 +1819,7 @@ static void smack_file_set_fowner(struct file *file)
 static int smack_file_send_sigiotask(struct task_struct *tsk,
 				     struct fown_struct *fown, int signum)
 {
+	struct smack_known **blob;
 	struct smack_known *skp;
 	struct smack_known *tkp = smk_of_task(smack_cred(tsk->cred));
 	struct file *file;
@@ -1841,7 +1832,8 @@ static int smack_file_send_sigiotask(struct task_struct *tsk,
 	file = container_of(fown, struct file, f_owner);
 
 	/* we don't log here as rc can be overriden */
-	skp = file->f_security;
+	blob = smack_file(file);
+	skp = *blob;
 	rc = smk_access(skp, tkp, MAY_DELIVER, NULL);
 	rc = smk_bu_note("sigiotask", skp, tkp, MAY_DELIVER, rc);
 	if (rc != 0 && has_capability(tsk, CAP_MAC_OVERRIDE))
@@ -4655,6 +4647,7 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
 
 struct lsm_blob_sizes smack_blob_sizes = {
 	.lbs_cred = sizeof(struct task_smack),
+	.lbs_file = sizeof(struct smack_known *),
 };
 
 static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
@@ -4692,7 +4685,6 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(inode_getsecid, smack_inode_getsecid),
 
 	LSM_HOOK_INIT(file_alloc_security, smack_file_alloc_security),
-	LSM_HOOK_INIT(file_free_security, smack_file_free_security),
 	LSM_HOOK_INIT(file_ioctl, smack_file_ioctl),
 	LSM_HOOK_INIT(file_lock, smack_file_lock),
 	LSM_HOOK_INIT(file_fcntl, smack_file_fcntl),
-- 
2.14.3
