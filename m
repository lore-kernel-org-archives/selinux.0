Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8K0LrqJ020900
 for <selinux@tycho.nsa.gov>; Wed, 19 Sep 2018 20:21:53 -0400
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
References: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <b977e081-4402-f31d-e219-f9716ea7a83b@schaufler-ca.com>
Date: Wed, 19 Sep 2018 17:21:44 -0700
MIME-Version: 1.0
In-Reply-To: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Subject: [PATCH v3 15/16] LSM: Infrastructure management of the ipc
 security blob
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

LSM: Infrastructure management of the ipc security blob

Move management of the kern_ipc_perm->security and
msg_msg->security blobs out of the individual security
modules and into the security infrastructure. Instead
of allocating the blobs from within the modules the modules
tell the infrastructure how much space is required, and
the space is allocated there.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h         |   2 +
 security/security.c               |  91 +++++++++++++++++++++--
 security/selinux/hooks.c          | 116 ++++++------------------------
 security/selinux/include/objsec.h |  13 ++++
 security/smack/smack.h            |  11 +++
 security/smack/smack_lsm.c        |  46 ++++--------
 6 files changed, 148 insertions(+), 131 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 6057c603b979..f6dbde28833a 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2031,6 +2031,8 @@ struct lsm_blob_sizes {
 	int	lbs_cred;
 	int	lbs_file;
 	int	lbs_inode;
+	int	lbs_ipc;
+	int	lbs_msg_msg;
 	int	lbs_task;
 };
 
diff --git a/security/security.c b/security/security.c
index 7e11de7eec21..a151d728aed2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -28,6 +28,7 @@
 #include <linux/personality.h>
 #include <linux/backing-dev.h>
 #include <linux/string.h>
+#include <linux/msg.h>
 #include <net/flow.h>
 
 #include <trace/events/initcall.h>
@@ -117,6 +118,8 @@ int __init security_init(void)
 	pr_info("LSM: cred blob size       = %d\n", blob_sizes.lbs_cred);
 	pr_info("LSM: file blob size       = %d\n", blob_sizes.lbs_file);
 	pr_info("LSM: inode blob size      = %d\n", blob_sizes.lbs_inode);
+	pr_info("LSM: ipc blob size        = %d\n", blob_sizes.lbs_ipc);
+	pr_info("LSM: msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
 	pr_info("LSM: task blob size       = %d\n", blob_sizes.lbs_task);
 #endif
 
@@ -302,6 +305,8 @@ void __init security_add_blobs(struct lsm_blob_sizes *needed)
 	if (needed->lbs_inode && blob_sizes.lbs_inode == 0)
 		blob_sizes.lbs_inode = sizeof(struct rcu_head);
 	lsm_set_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
+	lsm_set_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
+	lsm_set_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
 	lsm_set_size(&needed->lbs_task, &blob_sizes.lbs_task);
 }
 
@@ -387,6 +392,48 @@ int lsm_task_alloc(struct task_struct *task)
 	return 0;
 }
 
+/**
+ * lsm_ipc_alloc - allocate a composite ipc blob
+ * @kip: the ipc that needs a blob
+ *
+ * Allocate the ipc blob for all the modules
+ *
+ * Returns 0, or -ENOMEM if memory can't be allocated.
+ */
+int lsm_ipc_alloc(struct kern_ipc_perm *kip)
+{
+	if (blob_sizes.lbs_ipc == 0) {
+		kip->security = NULL;
+		return 0;
+	}
+
+	kip->security = kzalloc(blob_sizes.lbs_ipc, GFP_KERNEL);
+	if (kip->security == NULL)
+		return -ENOMEM;
+	return 0;
+}
+
+/**
+ * lsm_msg_msg_alloc - allocate a composite msg_msg blob
+ * @mp: the msg_msg that needs a blob
+ *
+ * Allocate the ipc blob for all the modules
+ *
+ * Returns 0, or -ENOMEM if memory can't be allocated.
+ */
+int lsm_msg_msg_alloc(struct msg_msg *mp)
+{
+	if (blob_sizes.lbs_msg_msg == 0) {
+		mp->security = NULL;
+		return 0;
+	}
+
+	mp->security = kzalloc(blob_sizes.lbs_msg_msg, GFP_KERNEL);
+	if (mp->security == NULL)
+		return -ENOMEM;
+	return 0;
+}
+
 /**
  * lsm_early_task - during initialization allocate a composite task blob
  * @task: the task that needs a blob
@@ -1468,22 +1515,40 @@ void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
 
 int security_msg_msg_alloc(struct msg_msg *msg)
 {
-	return call_int_hook(msg_msg_alloc_security, 0, msg);
+	int rc = lsm_msg_msg_alloc(msg);
+
+	if (unlikely(rc))
+		return rc;
+	rc = call_int_hook(msg_msg_alloc_security, 0, msg);
+	if (unlikely(rc))
+		security_msg_msg_free(msg);
+	return rc;
 }
 
 void security_msg_msg_free(struct msg_msg *msg)
 {
 	call_void_hook(msg_msg_free_security, msg);
+	kfree(msg->security);
+	msg->security = NULL;
 }
 
 int security_msg_queue_alloc(struct kern_ipc_perm *msq)
 {
-	return call_int_hook(msg_queue_alloc_security, 0, msq);
+	int rc = lsm_ipc_alloc(msq);
+
+	if (unlikely(rc))
+		return rc;
+	rc = call_int_hook(msg_queue_alloc_security, 0, msq);
+	if (unlikely(rc))
+		security_msg_queue_free(msq);
+	return rc;
 }
 
 void security_msg_queue_free(struct kern_ipc_perm *msq)
 {
 	call_void_hook(msg_queue_free_security, msq);
+	kfree(msq->security);
+	msq->security = NULL;
 }
 
 int security_msg_queue_associate(struct kern_ipc_perm *msq, int msqflg)
@@ -1510,12 +1575,21 @@ int security_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *msg,
 
 int security_shm_alloc(struct kern_ipc_perm *shp)
 {
-	return call_int_hook(shm_alloc_security, 0, shp);
+	int rc = lsm_ipc_alloc(shp);
+
+	if (unlikely(rc))
+		return rc;
+	rc = call_int_hook(shm_alloc_security, 0, shp);
+	if (unlikely(rc))
+		security_shm_free(shp);
+	return rc;
 }
 
 void security_shm_free(struct kern_ipc_perm *shp)
 {
 	call_void_hook(shm_free_security, shp);
+	kfree(shp->security);
+	shp->security = NULL;
 }
 
 int security_shm_associate(struct kern_ipc_perm *shp, int shmflg)
@@ -1535,12 +1609,21 @@ int security_shm_shmat(struct kern_ipc_perm *shp, char __user *shmaddr, int shmf
 
 int security_sem_alloc(struct kern_ipc_perm *sma)
 {
-	return call_int_hook(sem_alloc_security, 0, sma);
+	int rc = lsm_ipc_alloc(sma);
+
+	if (unlikely(rc))
+		return rc;
+	rc = call_int_hook(sem_alloc_security, 0, sma);
+	if (unlikely(rc))
+		security_sem_free(sma);
+	return rc;
 }
 
 void security_sem_free(struct kern_ipc_perm *sma)
 {
 	call_void_hook(sem_free_security, sma);
+	kfree(sma->security);
+	sma->security = NULL;
 }
 
 int security_sem_associate(struct kern_ipc_perm *sma, int semflg)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 389e51ef48a5..3c53a3ba480e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5832,51 +5832,22 @@ static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
 	return selinux_nlmsg_perm(sk, skb);
 }
 
-static int ipc_alloc_security(struct kern_ipc_perm *perm,
-			      u16 sclass)
+static void ipc_init_security(struct ipc_security_struct *isec, u16 sclass)
 {
-	struct ipc_security_struct *isec;
-
-	isec = kzalloc(sizeof(struct ipc_security_struct), GFP_KERNEL);
-	if (!isec)
-		return -ENOMEM;
-
 	isec->sclass = sclass;
 	isec->sid = current_sid();
-	perm->security = isec;
-
-	return 0;
-}
-
-static void ipc_free_security(struct kern_ipc_perm *perm)
-{
-	struct ipc_security_struct *isec = perm->security;
-	perm->security = NULL;
-	kfree(isec);
 }
 
 static int msg_msg_alloc_security(struct msg_msg *msg)
 {
 	struct msg_security_struct *msec;
 
-	msec = kzalloc(sizeof(struct msg_security_struct), GFP_KERNEL);
-	if (!msec)
-		return -ENOMEM;
-
+	msec = selinux_msg_msg(msg);
 	msec->sid = SECINITSID_UNLABELED;
-	msg->security = msec;
 
 	return 0;
 }
 
-static void msg_msg_free_security(struct msg_msg *msg)
-{
-	struct msg_security_struct *msec = msg->security;
-
-	msg->security = NULL;
-	kfree(msec);
-}
-
 static int ipc_has_perm(struct kern_ipc_perm *ipc_perms,
 			u32 perms)
 {
@@ -5884,7 +5855,7 @@ static int ipc_has_perm(struct kern_ipc_perm *ipc_perms,
 	struct common_audit_data ad;
 	u32 sid = current_sid();
 
-	isec = ipc_perms->security;
+	isec = selinux_ipc(ipc_perms);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = ipc_perms->key;
@@ -5898,11 +5869,6 @@ static int selinux_msg_msg_alloc_security(struct msg_msg *msg)
 	return msg_msg_alloc_security(msg);
 }
 
-static void selinux_msg_msg_free_security(struct msg_msg *msg)
-{
-	msg_msg_free_security(msg);
-}
-
 /* message queue security operations */
 static int selinux_msg_queue_alloc_security(struct kern_ipc_perm *msq)
 {
@@ -5911,11 +5877,8 @@ static int selinux_msg_queue_alloc_security(struct kern_ipc_perm *msq)
 	u32 sid = current_sid();
 	int rc;
 
-	rc = ipc_alloc_security(msq, SECCLASS_MSGQ);
-	if (rc)
-		return rc;
-
-	isec = msq->security;
+	isec = selinux_ipc(msq);
+	ipc_init_security(isec, SECCLASS_MSGQ);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->key;
@@ -5923,16 +5886,7 @@ static int selinux_msg_queue_alloc_security(struct kern_ipc_perm *msq)
 	rc = avc_has_perm(&selinux_state,
 			  sid, isec->sid, SECCLASS_MSGQ,
 			  MSGQ__CREATE, &ad);
-	if (rc) {
-		ipc_free_security(msq);
-		return rc;
-	}
-	return 0;
-}
-
-static void selinux_msg_queue_free_security(struct kern_ipc_perm *msq)
-{
-	ipc_free_security(msq);
+	return rc;
 }
 
 static int selinux_msg_queue_associate(struct kern_ipc_perm *msq, int msqflg)
@@ -5941,7 +5895,7 @@ static int selinux_msg_queue_associate(struct kern_ipc_perm *msq, int msqflg)
 	struct common_audit_data ad;
 	u32 sid = current_sid();
 
-	isec = msq->security;
+	isec = selinux_ipc(msq);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->key;
@@ -5990,8 +5944,8 @@ static int selinux_msg_queue_msgsnd(struct kern_ipc_perm *msq, struct msg_msg *m
 	u32 sid = current_sid();
 	int rc;
 
-	isec = msq->security;
-	msec = msg->security;
+	isec = selinux_ipc(msq);
+	msec = selinux_msg_msg(msg);
 
 	/*
 	 * First time through, need to assign label to the message
@@ -6038,8 +5992,8 @@ static int selinux_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *m
 	u32 sid = task_sid(target);
 	int rc;
 
-	isec = msq->security;
-	msec = msg->security;
+	isec = selinux_ipc(msq);
+	msec = selinux_msg_msg(msg);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->key;
@@ -6062,11 +6016,8 @@ static int selinux_shm_alloc_security(struct kern_ipc_perm *shp)
 	u32 sid = current_sid();
 	int rc;
 
-	rc = ipc_alloc_security(shp, SECCLASS_SHM);
-	if (rc)
-		return rc;
-
-	isec = shp->security;
+	isec = selinux_ipc(shp);
+	ipc_init_security(isec, SECCLASS_SHM);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = shp->key;
@@ -6074,16 +6025,7 @@ static int selinux_shm_alloc_security(struct kern_ipc_perm *shp)
 	rc = avc_has_perm(&selinux_state,
 			  sid, isec->sid, SECCLASS_SHM,
 			  SHM__CREATE, &ad);
-	if (rc) {
-		ipc_free_security(shp);
-		return rc;
-	}
-	return 0;
-}
-
-static void selinux_shm_free_security(struct kern_ipc_perm *shp)
-{
-	ipc_free_security(shp);
+	return rc;
 }
 
 static int selinux_shm_associate(struct kern_ipc_perm *shp, int shmflg)
@@ -6092,7 +6034,7 @@ static int selinux_shm_associate(struct kern_ipc_perm *shp, int shmflg)
 	struct common_audit_data ad;
 	u32 sid = current_sid();
 
-	isec = shp->security;
+	isec = selinux_ipc(shp);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = shp->key;
@@ -6159,11 +6101,8 @@ static int selinux_sem_alloc_security(struct kern_ipc_perm *sma)
 	u32 sid = current_sid();
 	int rc;
 
-	rc = ipc_alloc_security(sma, SECCLASS_SEM);
-	if (rc)
-		return rc;
-
-	isec = sma->security;
+	isec = selinux_ipc(sma);
+	ipc_init_security(isec, SECCLASS_SEM);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = sma->key;
@@ -6171,16 +6110,7 @@ static int selinux_sem_alloc_security(struct kern_ipc_perm *sma)
 	rc = avc_has_perm(&selinux_state,
 			  sid, isec->sid, SECCLASS_SEM,
 			  SEM__CREATE, &ad);
-	if (rc) {
-		ipc_free_security(sma);
-		return rc;
-	}
-	return 0;
-}
-
-static void selinux_sem_free_security(struct kern_ipc_perm *sma)
-{
-	ipc_free_security(sma);
+	return rc;
 }
 
 static int selinux_sem_associate(struct kern_ipc_perm *sma, int semflg)
@@ -6189,7 +6119,7 @@ static int selinux_sem_associate(struct kern_ipc_perm *sma, int semflg)
 	struct common_audit_data ad;
 	u32 sid = current_sid();
 
-	isec = sma->security;
+	isec = selinux_ipc(sma);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = sma->key;
@@ -6275,7 +6205,7 @@ static int selinux_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 
 static void selinux_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
 {
-	struct ipc_security_struct *isec = ipcp->security;
+	struct ipc_security_struct *isec = selinux_ipc(ipcp);
 	*secid = isec->sid;
 }
 
@@ -6813,6 +6743,8 @@ struct lsm_blob_sizes selinux_blob_sizes = {
 	.lbs_cred = sizeof(struct task_security_struct),
 	.lbs_file = sizeof(struct file_security_struct),
 	.lbs_inode = sizeof(struct inode_security_struct),
+	.lbs_ipc = sizeof(struct ipc_security_struct),
+	.lbs_msg_msg = sizeof(struct msg_security_struct),
 };
 
 static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
@@ -6923,24 +6855,20 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ipc_getsecid, selinux_ipc_getsecid),
 
 	LSM_HOOK_INIT(msg_msg_alloc_security, selinux_msg_msg_alloc_security),
-	LSM_HOOK_INIT(msg_msg_free_security, selinux_msg_msg_free_security),
 
 	LSM_HOOK_INIT(msg_queue_alloc_security,
 			selinux_msg_queue_alloc_security),
-	LSM_HOOK_INIT(msg_queue_free_security, selinux_msg_queue_free_security),
 	LSM_HOOK_INIT(msg_queue_associate, selinux_msg_queue_associate),
 	LSM_HOOK_INIT(msg_queue_msgctl, selinux_msg_queue_msgctl),
 	LSM_HOOK_INIT(msg_queue_msgsnd, selinux_msg_queue_msgsnd),
 	LSM_HOOK_INIT(msg_queue_msgrcv, selinux_msg_queue_msgrcv),
 
 	LSM_HOOK_INIT(shm_alloc_security, selinux_shm_alloc_security),
-	LSM_HOOK_INIT(shm_free_security, selinux_shm_free_security),
 	LSM_HOOK_INIT(shm_associate, selinux_shm_associate),
 	LSM_HOOK_INIT(shm_shmctl, selinux_shm_shmctl),
 	LSM_HOOK_INIT(shm_shmat, selinux_shm_shmat),
 
 	LSM_HOOK_INIT(sem_alloc_security, selinux_sem_alloc_security),
-	LSM_HOOK_INIT(sem_free_security, selinux_sem_free_security),
 	LSM_HOOK_INIT(sem_associate, selinux_sem_associate),
 	LSM_HOOK_INIT(sem_semctl, selinux_sem_semctl),
 	LSM_HOOK_INIT(sem_semop, selinux_sem_semop),
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 591adb374d69..5bf9f280e9b2 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -26,6 +26,7 @@
 #include <linux/in.h>
 #include <linux/spinlock.h>
 #include <linux/lsm_hooks.h>
+#include <linux/msg.h>
 #include <net/net_namespace.h>
 #include "flask.h"
 #include "avc.h"
@@ -173,4 +174,16 @@ static inline struct inode_security_struct *selinux_inode(
 	return inode->i_security;
 }
 
+static inline struct msg_security_struct *selinux_msg_msg(
+						const struct msg_msg *msg_msg)
+{
+	return msg_msg->security;
+}
+
+static inline struct ipc_security_struct *selinux_ipc(
+						const struct kern_ipc_perm *ipc)
+{
+	return ipc->security;
+}
+
 #endif /* _SELINUX_OBJSEC_H_ */
diff --git a/security/smack/smack.h b/security/smack/smack.h
index add19b7efc96..dffa0ba8fd49 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -24,6 +24,7 @@
 #include <linux/list.h>
 #include <linux/rculist.h>
 #include <linux/lsm_audit.h>
+#include <linux/msg.h>
 
 /*
  * Use IPv6 port labeling if IPv6 is enabled and secmarks
@@ -371,6 +372,16 @@ static inline struct inode_smack *smack_inode(const struct inode *inode)
 	return inode->i_security;
 }
 
+static inline struct smack_known **smack_msg_msg(const struct msg_msg *msg)
+{
+	return msg->security;
+}
+
+static inline struct smack_known **smack_ipc(const struct kern_ipc_perm *ipc)
+{
+	return ipc->security;
+}
+
 /*
  * Is the directory transmuting?
  */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 6617abb51732..8f3b809d7c26 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2880,23 +2880,12 @@ static int smack_flags_to_may(int flags)
  */
 static int smack_msg_msg_alloc_security(struct msg_msg *msg)
 {
-	struct smack_known *skp = smk_of_current();
+	struct smack_known **blob = smack_msg_msg(msg);
 
-	msg->security = skp;
+	*blob = smk_of_current();
 	return 0;
 }
 
-/**
- * smack_msg_msg_free_security - Clear the security blob for msg_msg
- * @msg: the object
- *
- * Clears the blob pointer
- */
-static void smack_msg_msg_free_security(struct msg_msg *msg)
-{
-	msg->security = NULL;
-}
-
 /**
  * smack_of_ipc - the smack pointer for the ipc
  * @isp: the object
@@ -2905,7 +2894,9 @@ static void smack_msg_msg_free_security(struct msg_msg *msg)
  */
 static struct smack_known *smack_of_ipc(struct kern_ipc_perm *isp)
 {
-	return (struct smack_known *)isp->security;
+	struct smack_known **blob = smack_ipc(isp);
+
+	return *blob;
 }
 
 /**
@@ -2916,23 +2907,12 @@ static struct smack_known *smack_of_ipc(struct kern_ipc_perm *isp)
  */
 static int smack_ipc_alloc_security(struct kern_ipc_perm *isp)
 {
-	struct smack_known *skp = smk_of_current();
+	struct smack_known **blob = smack_ipc(isp);
 
-	isp->security = skp;
+	*blob = smk_of_current();
 	return 0;
 }
 
-/**
- * smack_ipc_free_security - Clear the security blob for ipc
- * @isp: the object
- *
- * Clears the blob pointer
- */
-static void smack_ipc_free_security(struct kern_ipc_perm *isp)
-{
-	isp->security = NULL;
-}
-
 /**
  * smk_curacc_shm : check if current has access on shm
  * @isp : the object
@@ -3230,7 +3210,8 @@ static int smack_msg_queue_msgrcv(struct kern_ipc_perm *isp, struct msg_msg *msg
  */
 static int smack_ipc_permission(struct kern_ipc_perm *ipp, short flag)
 {
-	struct smack_known *iskp = ipp->security;
+	struct smack_known **blob = smack_ipc(ipp);
+	struct smack_known *iskp = *blob;
 	int may = smack_flags_to_may(flag);
 	struct smk_audit_info ad;
 	int rc;
@@ -3251,7 +3232,8 @@ static int smack_ipc_permission(struct kern_ipc_perm *ipp, short flag)
  */
 static void smack_ipc_getsecid(struct kern_ipc_perm *ipp, u32 *secid)
 {
-	struct smack_known *iskp = ipp->security;
+	struct smack_known **blob = smack_ipc(ipp);
+	struct smack_known *iskp = *blob;
 
 	*secid = iskp->smk_secid;
 }
@@ -4572,6 +4554,8 @@ struct lsm_blob_sizes smack_blob_sizes = {
 	.lbs_cred = sizeof(struct task_smack),
 	.lbs_file = sizeof(struct smack_known *),
 	.lbs_inode = sizeof(struct inode_smack),
+	.lbs_ipc = sizeof(struct smack_known *),
+	.lbs_msg_msg = sizeof(struct smack_known *),
 };
 
 static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
@@ -4643,23 +4627,19 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ipc_getsecid, smack_ipc_getsecid),
 
 	LSM_HOOK_INIT(msg_msg_alloc_security, smack_msg_msg_alloc_security),
-	LSM_HOOK_INIT(msg_msg_free_security, smack_msg_msg_free_security),
 
 	LSM_HOOK_INIT(msg_queue_alloc_security, smack_ipc_alloc_security),
-	LSM_HOOK_INIT(msg_queue_free_security, smack_ipc_free_security),
 	LSM_HOOK_INIT(msg_queue_associate, smack_msg_queue_associate),
 	LSM_HOOK_INIT(msg_queue_msgctl, smack_msg_queue_msgctl),
 	LSM_HOOK_INIT(msg_queue_msgsnd, smack_msg_queue_msgsnd),
 	LSM_HOOK_INIT(msg_queue_msgrcv, smack_msg_queue_msgrcv),
 
 	LSM_HOOK_INIT(shm_alloc_security, smack_ipc_alloc_security),
-	LSM_HOOK_INIT(shm_free_security, smack_ipc_free_security),
 	LSM_HOOK_INIT(shm_associate, smack_shm_associate),
 	LSM_HOOK_INIT(shm_shmctl, smack_shm_shmctl),
 	LSM_HOOK_INIT(shm_shmat, smack_shm_shmat),
 
 	LSM_HOOK_INIT(sem_alloc_security, smack_ipc_alloc_security),
-	LSM_HOOK_INIT(sem_free_security, smack_ipc_free_security),
 	LSM_HOOK_INIT(sem_associate, smack_sem_associate),
 	LSM_HOOK_INIT(sem_semctl, smack_sem_semctl),
 	LSM_HOOK_INIT(sem_semop, smack_sem_semop),
-- 
2.17.1
