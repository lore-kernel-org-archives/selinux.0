Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v9GKbXSt001380
 for <selinux@tycho.nsa.gov>; Mon, 16 Oct 2017 16:37:35 -0400
Received: by mail-oi0-f73.google.com with SMTP id e68so13093670oic.3
 for <selinux@tycho.nsa.gov>; Mon, 16 Oct 2017 13:37:23 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 16 Oct 2017 13:37:08 -0700
Message-Id: <20171016203709.11199-1-mjg59@google.com>
From: Matthew Garrett <mjg59@google.com>
To: mjg59@google.com
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
 Casey Schaufler <casey@schaufler-ca.com>,
 linux-security-module@vger.kernel.org,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: [PATCH 1/2] security: Add a cred_getsecid hook
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

For IMA purposes, we want to be able to obtain the prepared secid in the
bprm structure before the credentials are committed. Add a cred_getsecid
hook that makes this possible.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Eric Paris <eparis@parisplace.org>
Cc: selinux@tycho.nsa.gov
Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-integrity@vger.kernel.org
---
 include/linux/lsm_hooks.h  |  6 ++++++
 include/linux/security.h   |  1 +
 security/security.c        |  7 +++++++
 security/selinux/hooks.c   |  8 ++++++++
 security/smack/smack.h     | 10 ++++++++++
 security/smack/smack_lsm.c | 14 ++++++++++++++
 6 files changed, 46 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index ce02f76a6188..48a929fd47e6 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -556,6 +556,10 @@
  *	@new points to the new credentials.
  *	@old points to the original credentials.
  *	Transfer data from original creds to new creds
+ * @cred_getsecid:
+ *	Retrieve the security identifier of the cred structure @c
+ *	@p contains the credentials, secid will be placed into @secid.
+ *	In case of failure, @secid will be set to zero.
  * @kernel_act_as:
  *	Set the credentials for a kernel service to act as (subjective context).
  *	@new points to the credentials to be modified.
@@ -1510,6 +1514,7 @@ union security_list_options {
 	int (*cred_prepare)(struct cred *new, const struct cred *old,
 				gfp_t gfp);
 	void (*cred_transfer)(struct cred *new, const struct cred *old);
+	void (*cred_getsecid)(const struct cred *c, u32 *secid);
 	int (*kernel_act_as)(struct cred *new, u32 secid);
 	int (*kernel_create_files_as)(struct cred *new, struct inode *inode);
 	int (*kernel_module_request)(char *kmod_name);
@@ -1783,6 +1788,7 @@ struct security_hook_heads {
 	struct list_head cred_free;
 	struct list_head cred_prepare;
 	struct list_head cred_transfer;
+	struct list_head cred_getsecid;
 	struct list_head kernel_act_as;
 	struct list_head kernel_create_files_as;
 	struct list_head kernel_read_file;
diff --git a/include/linux/security.h b/include/linux/security.h
index 458e24bea2d4..8d969958c25e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -324,6 +324,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp);
 void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
+void security_cred_getsecid(const struct cred *c, u32 *secid);
 int security_kernel_act_as(struct cred *new, u32 secid);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
diff --git a/security/security.c b/security/security.c
index 55b5997e4b72..0f5784880c94 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1009,6 +1009,13 @@ void security_transfer_creds(struct cred *new, const struct cred *old)
 	call_void_hook(cred_transfer, new, old);
 }
 
+void security_cred_getsecid(const struct cred *c, u32 *secid)
+{
+	*secid = 0;
+	call_void_hook(cred_getsecid, c, secid);
+}
+EXPORT_SYMBOL(security_cred_getsecid);
+
 int security_kernel_act_as(struct cred *new, u32 secid)
 {
 	return call_int_hook(kernel_act_as, 0, new, secid);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 33fd061305c4..e0828e9130c7 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3829,6 +3829,13 @@ static void selinux_cred_transfer(struct cred *new, const struct cred *old)
 	*tsec = *old_tsec;
 }
 
+static void selinux_cred_getsecid(const struct cred *c, u32 *secid)
+{
+	rcu_read_lock();
+	*secid = cred_sid(c);
+	rcu_read_unlock();
+}
+
 /*
  * set the security data for a kernel service
  * - all the creation contexts are set to unlabelled
@@ -6332,6 +6339,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(cred_free, selinux_cred_free),
 	LSM_HOOK_INIT(cred_prepare, selinux_cred_prepare),
 	LSM_HOOK_INIT(cred_transfer, selinux_cred_transfer),
+	LSM_HOOK_INIT(cred_getsecid, selinux_cred_getsecid),
 	LSM_HOOK_INIT(kernel_act_as, selinux_kernel_act_as),
 	LSM_HOOK_INIT(kernel_create_files_as, selinux_kernel_create_files_as),
 	LSM_HOOK_INIT(kernel_module_request, selinux_kernel_module_request),
diff --git a/security/smack/smack.h b/security/smack/smack.h
index 6a71fc7831ab..5af7b7e709bc 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -391,6 +391,16 @@ static inline struct smack_known *smk_of_task_struct(const struct task_struct *t
 	return skp;
 }
 
+static inline struct smack_known *smk_of_cred(const struct cred *c)
+{
+	struct smack_known *skp;
+
+	rcu_read_lock();
+	skp = smk_of_task(c->security);
+	rcu_read_unlock();
+	return skp;
+}
+
 /*
  * Present a pointer to the forked smack label entry in an task blob.
  */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 463af86812c7..f1710cf76f7f 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2080,6 +2080,19 @@ static void smack_cred_transfer(struct cred *new, const struct cred *old)
 	/* cbs copy rule list */
 }
 
+/**
+ * smack_cred_getsecid - get the secid corresponding to a creds structure
+ * @c: the object creds
+ * @secid: where to put the result
+ *
+ * Sets the secid to contain a u32 version of the smack label.
+ */
+static void smack_cred_getsecid(const struct cred *c, u32 *secid)
+{
+	struct smack_known *skp = smk_of_cred(c);
+	*secid = skp->smk_secid;
+}
+
 /**
  * smack_kernel_act_as - Set the subjective context in a set of credentials
  * @new: points to the set of credentials to be modified.
@@ -4684,6 +4697,7 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(cred_free, smack_cred_free),
 	LSM_HOOK_INIT(cred_prepare, smack_cred_prepare),
 	LSM_HOOK_INIT(cred_transfer, smack_cred_transfer),
+	LSM_HOOK_INIT(cred_getsecid, smack_cred_getsecid),
 	LSM_HOOK_INIT(kernel_act_as, smack_kernel_act_as),
 	LSM_HOOK_INIT(kernel_create_files_as, smack_kernel_create_files_as),
 	LSM_HOOK_INIT(task_setpgid, smack_task_setpgid),
-- 
2.15.0.rc0.271.g36b669edcc-goog
