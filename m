Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4B0rlt2001612
 for <selinux@tycho.nsa.gov>; Thu, 10 May 2018 20:53:47 -0400
To: LSM <linux-security-module@vger.kernel.org>,
 LKLM <linux-kernel@vger.kernel.org>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
 "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
 John Johansen <john.johansen@canonical.com>,
 Kees Cook <keescook@chromium.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 James Morris <jmorris@namei.org>
References: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <81e6a64e-9040-dc89-5ac4-7984197d5ab1@schaufler-ca.com>
Date: Thu, 10 May 2018 17:53:36 -0700
MIME-Version: 1.0
In-Reply-To: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Subject: [PATCH 09/23] Smack: Abstract use of inode security blob
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Casey Schaufler <casey@schaufler-ca.com>
Date: Thu, 10 May 2018 14:19:09 -0700
Subject: [PATCH 09/23] Smack: Abstract use of inode security blob

Don't use the inode->i_security pointer directly.
Provide a helper function that provides the security blob pointer.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack.h     |  9 +++++++--
 security/smack/smack_lsm.c | 34 +++++++++++++++++-----------------
 2 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index 043525a52e94..5da5bd1b9b47 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -367,12 +367,17 @@ static inline struct smack_known **smack_file(const struct file *file)
 	return file->f_security;
 }
 
+static inline struct inode_smack *smack_inode(const struct inode *inode)
+{
+	return inode->i_security;
+}
+
 /*
  * Is the directory transmuting?
  */
 static inline int smk_inode_transmutable(const struct inode *isp)
 {
-	struct inode_smack *sip = isp->i_security;
+	struct inode_smack *sip = smack_inode(isp);
 	return (sip->smk_flags & SMK_INODE_TRANSMUTE) != 0;
 }
 
@@ -381,7 +386,7 @@ static inline int smk_inode_transmutable(const struct inode *isp)
  */
 static inline struct smack_known *smk_of_inode(const struct inode *isp)
 {
-	struct inode_smack *sip = isp->i_security;
+	struct inode_smack *sip = smack_inode(isp);
 	return sip->smk_inode;
 }
 
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index da22e31312b9..b9db97470e06 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -165,7 +165,7 @@ static int smk_bu_task(struct task_struct *otp, int mode, int rc)
 static int smk_bu_inode(struct inode *inode, int mode, int rc)
 {
 	struct task_smack *tsp = smack_cred(current_cred());
-	struct inode_smack *isp = inode->i_security;
+	struct inode_smack *isp = smack_inode(inode);
 	char acc[SMK_NUM_ACCESS_TYPE + 1];
 
 	if (isp->smk_flags & SMK_INODE_IMPURE)
@@ -197,7 +197,7 @@ static int smk_bu_file(struct file *file, int mode, int rc)
 	struct task_smack *tsp = smack_cred(current_cred());
 	struct smack_known *sskp = tsp->smk_task;
 	struct inode *inode = file_inode(file);
-	struct inode_smack *isp = inode->i_security;
+	struct inode_smack *isp = smack_inode(inode);
 	char acc[SMK_NUM_ACCESS_TYPE + 1];
 
 	if (isp->smk_flags & SMK_INODE_IMPURE)
@@ -227,7 +227,7 @@ static int smk_bu_credfile(const struct cred *cred, struct file *file,
 	struct task_smack *tsp = smack_cred(cred);
 	struct smack_known *sskp = tsp->smk_task;
 	struct inode *inode = file_inode(file);
-	struct inode_smack *isp = inode->i_security;
+	struct inode_smack *isp = smack_inode(inode);
 	char acc[SMK_NUM_ACCESS_TYPE + 1];
 
 	if (isp->smk_flags & SMK_INODE_IMPURE)
@@ -823,7 +823,7 @@ static int smack_set_mnt_opts(struct super_block *sb,
 	/*
 	 * Initialize the root inode.
 	 */
-	isp = inode->i_security;
+	isp = smack_inode(inode);
 	if (isp == NULL) {
 		isp = new_inode_smack(sp->smk_root);
 		if (isp == NULL)
@@ -911,7 +911,7 @@ static int smack_bprm_set_creds(struct linux_binprm *bprm)
 	if (bprm->called_set_creds)
 		return 0;
 
-	isp = inode->i_security;
+	isp = smack_inode(inode);
 	if (isp->smk_task == NULL || isp->smk_task == bsp->smk_task)
 		return 0;
 
@@ -991,7 +991,7 @@ static void smack_inode_free_rcu(struct rcu_head *head)
  */
 static void smack_inode_free_security(struct inode *inode)
 {
-	struct inode_smack *issp = inode->i_security;
+	struct inode_smack *issp = smack_inode(inode);
 
 	/*
 	 * The inode may still be referenced in a path walk and
@@ -1019,7 +1019,7 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr, const char **name,
 				     void **value, size_t *len)
 {
-	struct inode_smack *issp = inode->i_security;
+	struct inode_smack *issp = smack_inode(inode);
 	struct smack_known *skp = smk_of_current();
 	struct smack_known *isp = smk_of_inode(inode);
 	struct smack_known *dsp = smk_of_inode(dir);
@@ -1357,7 +1357,7 @@ static void smack_inode_post_setxattr(struct dentry *dentry, const char *name,
 				      const void *value, size_t size, int flags)
 {
 	struct smack_known *skp;
-	struct inode_smack *isp = d_backing_inode(dentry)->i_security;
+	struct inode_smack *isp = smack_inode(d_backing_inode(dentry));
 
 	if (strcmp(name, XATTR_NAME_SMACKTRANSMUTE) == 0) {
 		isp->smk_flags |= SMK_INODE_TRANSMUTE;
@@ -1438,7 +1438,7 @@ static int smack_inode_removexattr(struct dentry *dentry, const char *name)
 	if (rc != 0)
 		return rc;
 
-	isp = d_backing_inode(dentry)->i_security;
+	isp = smack_inode(d_backing_inode(dentry));
 	/*
 	 * Don't do anything special for these.
 	 *	XATTR_NAME_SMACKIPIN
@@ -1536,7 +1536,7 @@ static int smack_inode_listsecurity(struct inode *inode, char *buffer,
  */
 static void smack_inode_getsecid(struct inode *inode, u32 *secid)
 {
-	struct inode_smack *isp = inode->i_security;
+	struct inode_smack *isp = smack_inode(inode);
 
 	*secid = isp->smk_inode->smk_secid;
 }
@@ -1713,7 +1713,7 @@ static int smack_mmap_file(struct file *file,
 	if (unlikely(IS_PRIVATE(file_inode(file))))
 		return 0;
 
-	isp = file_inode(file)->i_security;
+	isp = smack_inode(file_inode(file));
 	if (isp->smk_mmap == NULL)
 		return 0;
 	sbsp = file_inode(file)->i_sb->s_security;
@@ -2055,7 +2055,7 @@ static int smack_kernel_act_as(struct cred *new, u32 secid)
 static int smack_kernel_create_files_as(struct cred *new,
 					struct inode *inode)
 {
-	struct inode_smack *isp = inode->i_security;
+	struct inode_smack *isp = smack_inode(inode);
 	struct task_smack *tsp = smack_cred(new);
 
 	tsp->smk_forked = isp->smk_inode;
@@ -2255,7 +2255,7 @@ static int smack_task_kill(struct task_struct *p, struct siginfo *info,
  */
 static void smack_task_to_inode(struct task_struct *p, struct inode *inode)
 {
-	struct inode_smack *isp = inode->i_security;
+	struct inode_smack *isp = smack_inode(inode);
 	struct smack_known *skp = smk_of_task_struct(p);
 
 	isp->smk_inode = skp;
@@ -2717,7 +2717,7 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
 				   const void *value, size_t size, int flags)
 {
 	struct smack_known *skp;
-	struct inode_smack *nsp = inode->i_security;
+	struct inode_smack *nsp = smack_inode(inode);
 	struct socket_smack *ssp;
 	struct socket *sock;
 	int rc = 0;
@@ -3304,7 +3304,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 	if (inode == NULL)
 		return;
 
-	isp = inode->i_security;
+	isp = smack_inode(inode);
 
 	mutex_lock(&isp->smk_lock);
 	/*
@@ -4529,7 +4529,7 @@ static int smack_inode_copy_up(struct dentry *dentry, struct cred **new)
 	/*
 	 * Get label from overlay inode and set it in create_sid
 	 */
-	isp = d_inode(dentry->d_parent)->i_security;
+	isp = smack_inode(d_inode(dentry->d_parent));
 	skp = isp->smk_inode;
 	tsp->smk_task = skp;
 	*new = new_creds;
@@ -4566,7 +4566,7 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
 	/*
 	 * the attribute of the containing directory
 	 */
-	isp = d_inode(dentry->d_parent)->i_security;
+	isp = smack_inode(d_inode(dentry->d_parent));
 
 	if (isp->smk_flags & SMK_INODE_TRANSMUTE) {
 		rcu_read_lock();
-- 
2.14.3
