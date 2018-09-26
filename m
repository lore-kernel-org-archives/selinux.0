Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8QLvTYv011294
 for <selinux@tycho.nsa.gov>; Wed, 26 Sep 2018 17:57:30 -0400
To: LSM <linux-security-module@vger.kernel.org>,
 James Morris <jmorris@namei.org>, SE Linux <selinux@tycho.nsa.gov>,
 LKLM <linux-kernel@vger.kernel.org>,
 John Johansen <john.johansen@canonical.com>,
 Kees Cook <keescook@chromium.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>, =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?=
 <mic@digikod.net>, Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <8010a7d0-c6a0-b327-d5dd-6857d6d42561@schaufler-ca.com>
Date: Wed, 26 Sep 2018 14:57:20 -0700
MIME-Version: 1.0
In-Reply-To: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Subject: [PATCH 21/19] LSM: Cleanup and fixes from Tetsuo Handa
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

lsm_early_cred()/lsm_early_task() are called from only __init functions.

lsm_cred_alloc()/lsm_file_alloc() are called from only security/security.c .

lsm_early_inode() should be avoided because it is not appropriate to
call panic() when lsm_early_inode() is called after __init phase.

Since all free hooks are called when one of init hooks failed, each
free hook needs to check whether init hook was called.

The original changes are from Tetsuo Handa. I have made minor
changes in some places, but this is mostly his code.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h         |  6 ++----
 security/security.c               | 27 ++++-----------------------
 security/selinux/hooks.c          |  5 ++++-
 security/selinux/include/objsec.h |  2 ++
 security/smack/smack_lsm.c        |  8 +++++++-
 5 files changed, 19 insertions(+), 29 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 7e8b32fdf576..80146147531f 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2095,13 +2095,11 @@ void __init loadpin_add_hooks(void);
 static inline void loadpin_add_hooks(void) { };
 #endif
 
-extern int lsm_cred_alloc(struct cred *cred, gfp_t gfp);
 extern int lsm_inode_alloc(struct inode *inode);
 
 #ifdef CONFIG_SECURITY
-void lsm_early_cred(struct cred *cred);
-void lsm_early_inode(struct inode *inode);
-void lsm_early_task(struct task_struct *task);
+void __init lsm_early_cred(struct cred *cred);
+void __init lsm_early_task(struct task_struct *task);
 #endif
 
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/security.c b/security/security.c
index 76f7dc49b63c..d986045dd4c0 100644
--- a/security/security.c
+++ b/security/security.c
@@ -267,7 +267,7 @@ EXPORT_SYMBOL(unregister_lsm_notifier);
  *
  * Returns 0, or -ENOMEM if memory can't be allocated.
  */
-int lsm_cred_alloc(struct cred *cred, gfp_t gfp)
+static int lsm_cred_alloc(struct cred *cred, gfp_t gfp)
 {
 	if (blob_sizes.lbs_cred == 0) {
 		cred->security = NULL;
@@ -286,7 +286,7 @@ int lsm_cred_alloc(struct cred *cred, gfp_t gfp)
  *
  * Allocate the cred blob for all the modules if it's not already there
  */
-void lsm_early_cred(struct cred *cred)
+void __init lsm_early_cred(struct cred *cred)
 {
 	int rc;
 
@@ -344,7 +344,7 @@ void __init security_add_blobs(struct lsm_blob_sizes *needed)
  *
  * Returns 0, or -ENOMEM if memory can't be allocated.
  */
-int lsm_file_alloc(struct file *file)
+static int lsm_file_alloc(struct file *file)
 {
 	if (!lsm_file_cache) {
 		file->f_security = NULL;
@@ -378,25 +378,6 @@ int lsm_inode_alloc(struct inode *inode)
 	return 0;
 }
 
-/**
- * lsm_early_inode - during initialization allocate a composite inode blob
- * @inode: the inode that needs a blob
- *
- * Allocate the inode blob for all the modules if it's not already there
- */
-void lsm_early_inode(struct inode *inode)
-{
-	int rc;
-
-	if (inode == NULL)
-		panic("%s: NULL inode.\n", __func__);
-	if (inode->i_security != NULL)
-		return;
-	rc = lsm_inode_alloc(inode);
-	if (rc)
-		panic("%s: Early inode alloc failed.\n", __func__);
-}
-
 /**
  * lsm_task_alloc - allocate a composite task blob
  * @task: the task that needs a blob
@@ -466,7 +447,7 @@ int lsm_msg_msg_alloc(struct msg_msg *mp)
  *
  * Allocate the task blob for all the modules if it's not already there
  */
-void lsm_early_task(struct task_struct *task)
+void __init lsm_early_task(struct task_struct *task)
 {
 	int rc;
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 44337d2349d9..e54b7dbac775 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -332,8 +332,11 @@ static struct inode_security_struct *backing_inode_security(struct dentry *dentr
 static void inode_free_security(struct inode *inode)
 {
 	struct inode_security_struct *isec = selinux_inode(inode);
-	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
+	struct superblock_security_struct *sbsec;
 
+	if (!isec)
+		return;
+	sbsec = inode->i_sb->s_security;
 	/*
 	 * As not all inode security structures are in a list, we check for
 	 * empty list outside of the lock to make sure that we won't waste
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index ee4471213909..8231ae02560e 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -180,6 +180,8 @@ static inline struct inode_security_struct *selinux_inode(
 						const struct inode *inode)
 {
 #ifdef CONFIG_SECURITY_STACKING
+	if (unlikely(!inode->i_security))
+		return NULL;
 	return inode->i_security + selinux_blob_sizes.lbs_inode;
 #else
 	return inode->i_security;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 784300406b97..b0b40454174b 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -750,6 +750,13 @@ static int smack_set_mnt_opts(struct super_block *sb,
 	if (sp->smk_flags & SMK_SB_INITIALIZED)
 		return 0;
 
+	if (inode->i_security == NULL) {
+		int rc = lsm_inode_alloc(inode);
+
+		if (rc)
+			return rc;
+	}
+
 	if (!smack_privileged(CAP_MAC_ADMIN)) {
 		/*
 		 * Unprivileged mounts don't get to specify Smack values.
@@ -818,7 +825,6 @@ static int smack_set_mnt_opts(struct super_block *sb,
 	/*
 	 * Initialize the root inode.
 	 */
-	lsm_early_inode(inode);
 	init_inode_smack(inode, sp->smk_root);
 
 	if (transmute) {
-- 
2.17.1
