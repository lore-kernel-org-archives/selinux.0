Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4B0tANt001841
 for <selinux@tycho.nsa.gov>; Thu, 10 May 2018 20:55:11 -0400
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
Message-ID: <fde29f1d-5da9-3e9e-9d99-39f283aa1ebd@schaufler-ca.com>
Date: Thu, 10 May 2018 17:54:50 -0700
MIME-Version: 1.0
In-Reply-To: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Subject: [PATCH 13/23] LSM: Infrastructure management of the ipc security blob
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Casey Schaufler <casey@schaufler-ca.com>
Date: Thu, 10 May 2018 14:30:15 -0700
Subject: [PATCH 13/23] LSM: Infrastructure management of the ipc security blob

Move management of the kern_ipc_perm->security and
msg_msg->security blobs out of the individual security
modules and into the security infrastructure. Instead
of allocating the blobs from within the modules the modules
tell the infrastructure how much space is required, and
the space is allocated there.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h         |   2 +
 security/security.c               |  91 ++++++++++++++++++++++++++++--
 security/selinux/hooks.c          | 116 ++++++++------------------------------
 security/selinux/include/objsec.h |  12 ++++
 security/smack/smack.h            |  10 ++++
 security/smack/smack_lsm.c        |  50 ++++++----------
 6 files changed, 150 insertions(+), 131 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 5c1be19167dc..42535da852bc 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2018,6 +2018,8 @@ struct lsm_blob_sizes {
 	int	lbs_cred;
 	int	lbs_file;
 	int	lbs_inode;
+	int	lbs_ipc;
+	int	lbs_msg_msg;
 	int	lbs_sock;
 	int	lbs_superblock;
 	int	lbs_task;
diff --git a/security/security.c b/security/security.c
index 685e0aff0d36..9414d1a78ee5 100644
--- a/security/security.c
+++ b/security/security.c
@@ -28,6 +28,7 @@
 #include <linux/personality.h>
 #include <linux/backing-dev.h>
 #include <linux/string.h>
+#include <linux/msg.h>
 #include <net/flow.h>
 #include <net/sock.h>
 
@@ -115,6 +116,8 @@ int __init security_init(void)
 	pr_info("LSM: cred blob size       = %d\n", blob_sizes.lbs_cred);
 	pr_info("LSM: file blob size       = %d\n", blob_sizes.lbs_file);
 	pr_info("LSM: inode blob size      = %d\n", blob_sizes.lbs_inode);
+	pr_info("LSM: ipc blob size        = %d\n", blob_sizes.lbs_ipc);
+	pr_info("LSM: msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
 	pr_info("LSM: sock blob size       = %d\n", blob_sizes.lbs_sock);
 	pr_info("LSM: superblock blob size = %d\n", blob_sizes.lbs_superblock);
 	pr_info("LSM: task blob size       = %d\n", blob_sizes.lbs_task);
@@ -293,6 +296,8 @@ void __init security_add_blobs(struct lsm_blob_sizes *needed)
 {
 	lsm_set_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
 	lsm_set_size(&needed->lbs_file, &blob_sizes.lbs_file);
+	lsm_set_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
+	lsm_set_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
 	lsm_set_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
 	lsm_set_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
 	lsm_set_size(&needed->lbs_task, &blob_sizes.lbs_task);
@@ -406,6 +411,48 @@ void lsm_early_inode(struct inode *inode)
 		panic("%s: Early inode alloc failed.\n", __func__);
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
  * lsm_sock_alloc - allocate a composite sock blob
  * @sock: the sock that needs a blob
@@ -1504,22 +1551,40 @@ void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
 
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
@@ -1546,12 +1611,21 @@ int security_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *msg,
 
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
@@ -1571,12 +1645,21 @@ int security_shm_shmat(struct kern_ipc_perm *shp, char __user *shmaddr, int shmf
 
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
index 62ac0dbf21ed..3911e28e3907 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5771,51 +5771,22 @@ static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
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
@@ -5823,7 +5794,7 @@ static int ipc_has_perm(struct kern_ipc_perm *ipc_perms,
 	struct common_audit_data ad;
 	u32 sid = current_sid();
 
-	isec = ipc_perms->security;
+	isec = selinux_ipc(ipc_perms);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = ipc_perms->key;
@@ -5837,11 +5808,6 @@ static int selinux_msg_msg_alloc_security(struct msg_msg *msg)
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
@@ -5850,11 +5816,8 @@ static int selinux_msg_queue_alloc_security(struct kern_ipc_perm *msq)
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
@@ -5862,16 +5825,7 @@ static int selinux_msg_queue_alloc_security(struct kern_ipc_perm *msq)
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
@@ -5880,7 +5834,7 @@ static int selinux_msg_queue_associate(struct kern_ipc_perm *msq, int msqflg)
 	struct common_audit_data ad;
 	u32 sid = current_sid();
 
-	isec = msq->security;
+	isec = selinux_ipc(msq);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->key;
@@ -5929,8 +5883,8 @@ static int selinux_msg_queue_msgsnd(struct kern_ipc_perm *msq, struct msg_msg *m
 	u32 sid = current_sid();
 	int rc;
 
-	isec = msq->security;
-	msec = msg->security;
+	isec = selinux_ipc(msq);
+	msec = selinux_msg_msg(msg);
 
 	/*
 	 * First time through, need to assign label to the message
@@ -5977,8 +5931,8 @@ static int selinux_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *m
 	u32 sid = task_sid(target);
 	int rc;
 
-	isec = msq->security;
-	msec = msg->security;
+	isec = selinux_ipc(msq);
+	msec = selinux_msg_msg(msg);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->key;
@@ -6001,11 +5955,8 @@ static int selinux_shm_alloc_security(struct kern_ipc_perm *shp)
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
@@ -6013,16 +5964,7 @@ static int selinux_shm_alloc_security(struct kern_ipc_perm *shp)
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
@@ -6031,7 +5973,7 @@ static int selinux_shm_associate(struct kern_ipc_perm *shp, int shmflg)
 	struct common_audit_data ad;
 	u32 sid = current_sid();
 
-	isec = shp->security;
+	isec = selinux_ipc(shp);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = shp->key;
@@ -6098,11 +6040,8 @@ static int selinux_sem_alloc_security(struct kern_ipc_perm *sma)
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
@@ -6110,16 +6049,7 @@ static int selinux_sem_alloc_security(struct kern_ipc_perm *sma)
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
@@ -6128,7 +6058,7 @@ static int selinux_sem_associate(struct kern_ipc_perm *sma, int semflg)
 	struct common_audit_data ad;
 	u32 sid = current_sid();
 
-	isec = sma->security;
+	isec = selinux_ipc(sma);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = sma->key;
@@ -6214,7 +6144,7 @@ static int selinux_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 
 static void selinux_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
 {
-	struct ipc_security_struct *isec = ipcp->security;
+	struct ipc_security_struct *isec = selinux_ipc(ipcp);
 	*secid = isec->sid;
 }
 
@@ -6750,6 +6680,8 @@ struct lsm_blob_sizes selinux_blob_sizes = {
 	.lbs_cred = sizeof(struct task_security_struct),
 	.lbs_file = sizeof(struct file_security_struct),
 	.lbs_inode = sizeof(struct inode_security_struct),
+	.lbs_ipc = sizeof(struct ipc_security_struct),
+	.lbs_msg_msg = sizeof(struct msg_security_struct),
 	.lbs_sock = sizeof(struct sk_security_struct),
 	.lbs_superblock = sizeof(struct superblock_security_struct),
 };
@@ -6860,24 +6792,20 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
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
index 7e4bd14498b5..d1d883f8c552 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -180,6 +180,18 @@ static inline struct superblock_security_struct *selinux_superblock(
 	return superblock->s_security;
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
 static inline struct sk_security_struct *selinux_sock(const struct sock *sock)
 {
 	return sock->sk_security;
diff --git a/security/smack/smack.h b/security/smack/smack.h
index f457dd3b4aa0..42c36e37b0bd 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -383,6 +383,16 @@ static inline struct superblock_smack *smack_superblock(
 	return superblock->s_security;
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
index dec965eea49f..a419953c1004 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2833,23 +2833,12 @@ static int smack_flags_to_may(int flags)
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
@@ -2858,7 +2847,13 @@ static void smack_msg_msg_free_security(struct msg_msg *msg)
  */
 static struct smack_known *smack_of_ipc(struct kern_ipc_perm *isp)
 {
-	return (struct smack_known *)isp->security;
+#ifdef CONFIG_SECURITY_STACKING
+	struct smack_known **blob = smack_ipc(isp);
+
+	return *blob;
+#else
+	return isp->security;
+#endif
 }
 
 /**
@@ -2869,23 +2864,12 @@ static struct smack_known *smack_of_ipc(struct kern_ipc_perm *isp)
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
@@ -3183,7 +3167,8 @@ static int smack_msg_queue_msgrcv(struct kern_ipc_perm *isp, struct msg_msg *msg
  */
 static int smack_ipc_permission(struct kern_ipc_perm *ipp, short flag)
 {
-	struct smack_known *iskp = ipp->security;
+	struct smack_known **blob = smack_ipc(ipp);
+	struct smack_known *iskp = *blob;
 	int may = smack_flags_to_may(flag);
 	struct smk_audit_info ad;
 	int rc;
@@ -3204,7 +3189,8 @@ static int smack_ipc_permission(struct kern_ipc_perm *ipp, short flag)
  */
 static void smack_ipc_getsecid(struct kern_ipc_perm *ipp, u32 *secid)
 {
-	struct smack_known *iskp = ipp->security;
+	struct smack_known **blob = smack_ipc(ipp);
+	struct smack_known *iskp = *blob;
 
 	*secid = iskp->smk_secid;
 }
@@ -4518,6 +4504,8 @@ struct lsm_blob_sizes smack_blob_sizes = {
 	.lbs_cred = sizeof(struct task_smack),
 	.lbs_file = sizeof(struct smack_known *),
 	.lbs_inode = sizeof(struct inode_smack),
+	.lbs_ipc = sizeof(struct smack_known *),
+	.lbs_msg_msg = sizeof(struct smack_known *),
 	.lbs_sock = sizeof(struct socket_smack),
 	.lbs_superblock = sizeof(struct superblock_smack),
 };
@@ -4590,23 +4578,19 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
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
2.14.3
