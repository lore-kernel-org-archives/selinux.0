From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 2/3] SELinux: call capabilities code directory
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Date: Mon, 09 Feb 2009 16:37:19 -0500
Message-ID: <20090209213719.9537.98143.stgit@paris.rdu.redhat.com>
In-Reply-To: <20090209213714.9537.8322.stgit@paris.rdu.redhat.com>
References: <20090209213714.9537.8322.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

For cleanliness and efficiency remove all calls to secondary-> and instead
call capabilities code directly.  capabilities are the only module that
selinux stacks with and so the code should not indicate that other stacking
might be possible.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/hooks.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6e6847d..e2bdb28 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1864,7 +1864,7 @@ static int selinux_ptrace_may_access(struct task_struct *child,
 {
 	int rc;
 
-	rc = secondary_ops->ptrace_may_access(child, mode);
+	rc = cap_ptrace_may_access(child, mode);
 	if (rc)
 		return rc;
 
@@ -1881,7 +1881,7 @@ static int selinux_ptrace_traceme(struct task_struct *parent)
 {
 	int rc;
 
-	rc = secondary_ops->ptrace_traceme(parent);
+	rc = cap_ptrace_traceme(parent);
 	if (rc)
 		return rc;
 
@@ -1897,7 +1897,7 @@ static int selinux_capget(struct task_struct *target, kernel_cap_t *effective,
 	if (error)
 		return error;
 
-	return secondary_ops->capget(target, effective, inheritable, permitted);
+	return cap_capget(target, effective, inheritable, permitted);
 }
 
 static int selinux_capset(struct cred *new, const struct cred *old,
@@ -1907,7 +1907,7 @@ static int selinux_capset(struct cred *new, const struct cred *old,
 {
 	int error;
 
-	error = secondary_ops->capset(new, old,
+	error = cap_capset(new, old,
 				      effective, inheritable, permitted);
 	if (error)
 		return error;
@@ -1930,7 +1930,7 @@ static int selinux_capable(struct task_struct *tsk, const struct cred *cred,
 {
 	int rc;
 
-	rc = secondary_ops->capable(tsk, cred, cap, audit);
+	rc = cap_capable(tsk, cred, cap, audit);
 	if (rc)
 		return rc;
 
@@ -2056,7 +2056,7 @@ static int selinux_syslog(int type)
 {
 	int rc;
 
-	rc = secondary_ops->syslog(type);
+	rc = cap_syslog(type);
 	if (rc)
 		return rc;
 
@@ -2087,7 +2087,7 @@ static int selinux_syslog(int type)
  * mapping. 0 means there is enough memory for the allocation to
  * succeed and -ENOMEM implies there is not.
  *
- * Note that secondary_ops->capable and task_has_perm_noaudit return 0
+ * Note that cap_capable and task_has_perm_noaudit return 0
  * if the capability is granted, but __vm_enough_memory requires 1 if
  * the capability is granted.
  *
@@ -2117,7 +2117,7 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
 	struct inode *inode = bprm->file->f_path.dentry->d_inode;
 	int rc;
 
-	rc = secondary_ops->bprm_set_creds(bprm);
+	rc = cap_bprm_set_creds(bprm);
 	if (rc)
 		return rc;
 
@@ -2234,7 +2234,7 @@ static int selinux_bprm_secureexec(struct linux_binprm *bprm)
 					PROCESS__NOATSECURE, NULL);
 	}
 
-	return (atsecure || secondary_ops->bprm_secureexec(bprm));
+	return (atsecure || cap_bprm_secureexec(bprm));
 }
 
 extern struct vfsmount *selinuxfs_mount;
@@ -3335,7 +3335,7 @@ static int selinux_task_setnice(struct task_struct *p, int nice)
 {
 	int rc;
 
-	rc = secondary_ops->task_setnice(p, nice);
+	rc = cap_task_setnice(p, nice);
 	if (rc)
 		return rc;
 
@@ -3346,7 +3346,7 @@ static int selinux_task_setioprio(struct task_struct *p, int ioprio)
 {
 	int rc;
 
-	rc = secondary_ops->task_setioprio(p, ioprio);
+	rc = cap_task_setioprio(p, ioprio);
 	if (rc)
 		return rc;
 
@@ -3376,7 +3376,7 @@ static int selinux_task_setscheduler(struct task_struct *p, int policy, struct s
 {
 	int rc;
 
-	rc = secondary_ops->task_setscheduler(p, policy, lp);
+	rc = cap_task_setscheduler(p, policy, lp);
 	if (rc)
 		return rc;
 
@@ -4634,7 +4634,7 @@ static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
 {
 	int err;
 
-	err = secondary_ops->netlink_send(sk, skb);
+	err = cap_netlink_send(sk, skb);
 	if (err)
 		return err;
 
@@ -4649,7 +4649,7 @@ static int selinux_netlink_recv(struct sk_buff *skb, int capability)
 	int err;
 	struct avc_audit_data ad;
 
-	err = secondary_ops->netlink_recv(skb, capability);
+	err = cap_netlink_recv(skb, capability);
 	if (err)
 		return err;
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
