Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w05LFnPZ031853
 for <selinux@tycho.nsa.gov>; Fri, 5 Jan 2018 16:15:51 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID05.oob.disa.mil (Postfix) with SMTP id 3zCyBV5N0Hz1b8n
 for <selinux@tycho.nsa.gov>; Fri,  5 Jan 2018 21:15:46 +0000 (UTC)
Received: from USFB19PA09_EEMSG_MP5.eemsg.mil (unknown [192.168.16.6])
 by USFBF3ID05.oob.disa.mil (Postfix) with ESMTP id 3zCyBV4P6Zz1b8V
 for <selinux@tycho.nsa.gov>; Fri,  5 Jan 2018 21:15:46 +0000 (UTC)
Received: by mail-ot0-f201.google.com with SMTP id m2so2921717otd.22
 for <selinux@tycho.nsa.gov>; Fri, 05 Jan 2018 13:15:45 -0800 (PST)
MIME-Version: 1.0
Date: Fri,  5 Jan 2018 13:15:35 -0800
Message-Id: <20180105211536.11611-1-mjg59@google.com>
From: Matthew Garrett <mjg59@google.com>
To: linux-integrity@vger.kernel.org
Cc: Matthew Garrett <mjg59@google.com>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
 Casey Schaufler <casey@schaufler-ca.com>,
 linux-security-module@vger.kernel.org,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [PATCH V5 1/2] security: Add a cred_getsecid hook
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

For IMA purposes, we want to be able to obtain the prepared secid in the
bprm structure before the credentials are committed. Add a cred_getsecid
hook that makes this possible.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Paul Moore <paul@paul-moore.com>
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

Ok, I'm taking a slightly different approach and just passing in the secid -
for everything other than the CREDS_CHECK case this will be the task secid,
for CREDS_CHECK it'll be the one associated with the BPRM structure. I believe
that this results in zero functional change other than when dealing with the
new functionality, and we can come back and rework this once we have a better
idea about how IMA should be using secids in the first place.

 include/linux/lsm_hooks.h  |  6 ++++++
 include/linux/security.h   |  1 +
 security/security.c        |  7 +++++++
 security/selinux/hooks.c   |  6 ++++++
 security/smack/smack_lsm.c | 18 ++++++++++++++++++
 5 files changed, 38 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 7161d8e7ee79..72932dabbaed 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -554,6 +554,10 @@
  *	@new points to the new credentials.
  *	@old points to the original credentials.
  *	Transfer data from original creds to new creds
+ * @cred_getsecid:
+ *	Retrieve the security identifier of the cred structure @c
+ *	@c contains the credentials, secid will be placed into @secid.
+ *	In case of failure, @secid will be set to zero.
  * @kernel_act_as:
  *	Set the credentials for a kernel service to act as (subjective context).
  *	@new points to the credentials to be modified.
@@ -1541,6 +1545,7 @@ union security_list_options {
 	int (*cred_prepare)(struct cred *new, const struct cred *old,
 				gfp_t gfp);
 	void (*cred_transfer)(struct cred *new, const struct cred *old);
+	void (*cred_getsecid)(const struct cred *c, u32 *secid);
 	int (*kernel_act_as)(struct cred *new, u32 secid);
 	int (*kernel_create_files_as)(struct cred *new, struct inode *inode);
 	int (*kernel_module_request)(char *kmod_name);
@@ -1824,6 +1829,7 @@ struct security_hook_heads {
 	struct list_head cred_free;
 	struct list_head cred_prepare;
 	struct list_head cred_transfer;
+	struct list_head cred_getsecid;
 	struct list_head kernel_act_as;
 	struct list_head kernel_create_files_as;
 	struct list_head kernel_read_file;
diff --git a/include/linux/security.h b/include/linux/security.h
index 73f1ef625d40..5cfff15ac378 100644
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
index 1cd8526cb0b7..35cbd75844c2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1005,6 +1005,13 @@ void security_transfer_creds(struct cred *new, const struct cred *old)
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
index 8644d864e3c1..d3009c027de8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3844,6 +3844,11 @@ static void selinux_cred_transfer(struct cred *new, const struct cred *old)
 	*tsec = *old_tsec;
 }
 
+static void selinux_cred_getsecid(const struct cred *c, u32 *secid)
+{
+	*secid = cred_sid(c);
+}
+
 /*
  * set the security data for a kernel service
  * - all the creation contexts are set to unlabelled
@@ -6479,6 +6484,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(cred_free, selinux_cred_free),
 	LSM_HOOK_INIT(cred_prepare, selinux_cred_prepare),
 	LSM_HOOK_INIT(cred_transfer, selinux_cred_transfer),
+	LSM_HOOK_INIT(cred_getsecid, selinux_cred_getsecid),
 	LSM_HOOK_INIT(kernel_act_as, selinux_kernel_act_as),
 	LSM_HOOK_INIT(kernel_create_files_as, selinux_kernel_create_files_as),
 	LSM_HOOK_INIT(kernel_module_request, selinux_kernel_module_request),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 14cc7940b36d..b27327ebb031 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2049,6 +2049,23 @@ static void smack_cred_transfer(struct cred *new, const struct cred *old)
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
+	struct smack_known *skp;
+
+	rcu_read_lock();
+	skp = smk_of_task(c->security);
+	*secid = skp->smk_secid;
+	rcu_read_unlock();
+}
+
 /**
  * smack_kernel_act_as - Set the subjective context in a set of credentials
  * @new: points to the set of credentials to be modified.
@@ -4727,6 +4744,7 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(cred_free, smack_cred_free),
 	LSM_HOOK_INIT(cred_prepare, smack_cred_prepare),
 	LSM_HOOK_INIT(cred_transfer, smack_cred_transfer),
+	LSM_HOOK_INIT(cred_getsecid, smack_cred_getsecid),
 	LSM_HOOK_INIT(kernel_act_as, smack_kernel_act_as),
 	LSM_HOOK_INIT(kernel_create_files_as, smack_kernel_create_files_as),
 	LSM_HOOK_INIT(task_setpgid, smack_task_setpgid),
-- 
2.16.0.rc0.223.g4a4ac83678-goog
