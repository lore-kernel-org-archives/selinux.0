Date: Mon, 25 Feb 2008 15:26:09 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: selinux@tycho.nsa.gov
cc: Eric Paris <eparis@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH][RFC] remove unused backpointers from security objects
Message-ID: <Xine.LNX.4.64.0802251524350.2482@us.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Please review.

---

Author: James Morris <jmorris@namei.org>
Date:   Mon Feb 25 15:22:42 2008 +1100

    SELinux: remove unused backpointers from security objects
    
    Remove unused backpoiters from security objects.
    
    Signed-off-by: James Morris <jmorris@namei.org>

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 75c2e99..7c95548 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -161,7 +161,6 @@ static int task_alloc_security(struct task_struct *task)
 	if (!tsec)
 		return -ENOMEM;
 
-	tsec->task = task;
 	tsec->osid = tsec->sid = tsec->ptrace_sid = SECINITSID_UNLABELED;
 	task->security = tsec;
 
@@ -218,7 +217,6 @@ static int file_alloc_security(struct file *file)
 	if (!fsec)
 		return -ENOMEM;
 
-	fsec->file = file;
 	fsec->sid = tsec->sid;
 	fsec->fown_sid = tsec->sid;
 	file->f_security = fsec;
@@ -275,7 +273,6 @@ static int sk_alloc_security(struct sock *sk, int family, gfp_t priority)
 	if (!ssec)
 		return -ENOMEM;
 
-	ssec->sk = sk;
 	ssec->peer_sid = SECINITSID_UNLABELED;
 	ssec->sid = SECINITSID_UNLABELED;
 	sk->sk_security = ssec;
@@ -1864,7 +1861,6 @@ static int selinux_bprm_alloc_security(struct linux_binprm *bprm)
 	if (!bsec)
 		return -ENOMEM;
 
-	bsec->bprm = bprm;
 	bsec->sid = SECINITSID_UNLABELED;
 	bsec->set = 0;
 
@@ -4542,7 +4538,6 @@ static int ipc_alloc_security(struct task_struct *task,
 		return -ENOMEM;
 
 	isec->sclass = sclass;
-	isec->ipc_perm = perm;
 	isec->sid = tsec->sid;
 	perm->security = isec;
 
@@ -4564,7 +4559,6 @@ static int msg_msg_alloc_security(struct msg_msg *msg)
 	if (!msec)
 		return -ENOMEM;
 
-	msec->msg = msg;
 	msec->sid = SECINITSID_UNLABELED;
 	msg->security = msec;
 
@@ -5175,7 +5169,6 @@ static int selinux_key_alloc(struct key *k, struct task_struct *tsk,
 	if (!ksec)
 		return -ENOMEM;
 
-	ksec->obj = k;
 	if (tsec->keycreate_sid)
 		ksec->sid = tsec->keycreate_sid;
 	else
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index c6c2bb4..474ac23 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -28,7 +28,6 @@
 #include "avc.h"
 
 struct task_security_struct {
-	struct task_struct *task;      /* back pointer to task object */
 	u32 osid;            /* SID prior to last execve */
 	u32 sid;             /* current SID */
 	u32 exec_sid;        /* exec SID */
@@ -50,7 +49,6 @@ struct inode_security_struct {
 };
 
 struct file_security_struct {
-	struct file *file;              /* back pointer to file object */
 	u32 sid;              /* SID of open file description */
 	u32 fown_sid;         /* SID of file owner (for SIGIO) */
 	u32 isid;             /* SID of inode at the time of file open */
@@ -73,18 +71,15 @@ struct superblock_security_struct {
 };
 
 struct msg_security_struct {
-	struct msg_msg *msg;		/* back pointer */
 	u32 sid;              /* SID of message */
 };
 
 struct ipc_security_struct {
-	struct kern_ipc_perm *ipc_perm; /* back pointer */
 	u16 sclass;	/* security class of this object */
 	u32 sid;              /* SID of IPC resource */
 };
 
 struct bprm_security_struct {
-	struct linux_binprm *bprm;     /* back pointer to bprm object */
 	u32 sid;                       /* SID for transformed process */
 	unsigned char set;
 
@@ -110,7 +105,6 @@ struct netnode_security_struct {
 };
 
 struct sk_security_struct {
-	struct sock *sk;		/* back pointer to sk object */
 	u32 sid;			/* SID of this object */
 	u32 peer_sid;			/* SID of peer */
 	u16 sclass;			/* sock security class */
@@ -125,7 +119,6 @@ struct sk_security_struct {
 };
 
 struct key_security_struct {
-	struct key *obj; /* back pointer */
 	u32 sid;         /* SID of key */
 };
 

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
