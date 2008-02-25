Date: Tue, 26 Feb 2008 00:30:14 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>,
        Paul Moore <paul.moore@hp.com>
Subject: Re: [PATCH][RFC] remove unused backpointers from security objects
In-Reply-To: <1203944199.2804.142.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.64.0802260019570.24574@us.intercode.com.au>
References: <Xine.LNX.4.64.0802251524350.2482@us.intercode.com.au>
 <1203944199.2804.142.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 25 Feb 2008, Stephen Smalley wrote:

> > -	ssec->sk = sk;
> 
> Unless it has changed recently, this back pointer is still in use by
> netlabel.c.  Likely could be reworked though to have the caller
> (selinux_sk_clone_security) just pass in the sk pointer or even just
> sk->sk_family directly.

Whoops, didn't have CONFIG_NETLABEL.

See updated version below, with the sk pointer (to allow the callee to 
take the rcu read lock).

---

Author: James Morris <jmorris@namei.org>
Date:   Tue Feb 26 00:27:36 2008 +1100

    SELinux: remove unused backpointers from security objects
    
    Remove unused backpoiters from security objects.
    
    Signed-off-by: James Morris <jmorris@namei.org>

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 75c2e99..5918d03 100644
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
 
@@ -4120,7 +4116,7 @@ static void selinux_sk_clone_security(const struct sock *sk, struct sock *newsk)
 	newssec->peer_sid = ssec->peer_sid;
 	newssec->sclass = ssec->sclass;
 
-	selinux_netlbl_sk_security_clone(ssec, newssec);
+	selinux_netlbl_sk_security_clone(newssec, sk);
 }
 
 static void selinux_sk_getsecid(struct sock *sk, u32 *secid)
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
diff --git a/security/selinux/include/netlabel.h b/security/selinux/include/netlabel.h
index 00a2809..02bb425 100644
--- a/security/selinux/include/netlabel.h
+++ b/security/selinux/include/netlabel.h
@@ -44,7 +44,7 @@ void selinux_netlbl_sk_security_reset(struct sk_security_struct *ssec,
 void selinux_netlbl_sk_security_init(struct sk_security_struct *ssec,
 				     int family);
 void selinux_netlbl_sk_security_clone(struct sk_security_struct *ssec,
-				      struct sk_security_struct *newssec);
+				      const struct sock *sk);
 
 int selinux_netlbl_skbuff_getsid(struct sk_buff *skb,
 				 u16 family,
@@ -81,7 +81,7 @@ static inline void selinux_netlbl_sk_security_init(
 }
 static inline void selinux_netlbl_sk_security_clone(
 	                                    struct sk_security_struct *ssec,
-					    struct sk_security_struct *newssec)
+					    const struct sock *sk)
 {
 	return;
 }
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
 
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 0fa2be4..7b298ef 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -148,22 +148,21 @@ void selinux_netlbl_sk_security_init(struct sk_security_struct *ssec,
 
 /**
  * selinux_netlbl_sk_security_clone - Copy the NetLabel fields
- * @ssec: the original sk_security_struct
  * @newssec: the cloned sk_security_struct
+ * @sk: sk to be cloned from
  *
  * Description:
- * Clone the NetLabel specific sk_security_struct fields from @ssec to
+ * Clone the NetLabel specific sk_security_struct fields from @sk->ssec to
  * @newssec.
  *
  */
-void selinux_netlbl_sk_security_clone(struct sk_security_struct *ssec,
-				      struct sk_security_struct *newssec)
+void selinux_netlbl_sk_security_clone(struct sk_security_struct *newssec, const struct sock *sk)
 {
 	/* We don't need to take newssec->nlbl_lock because we are the only
 	 * thread with access to newssec, but we do need to take the RCU read
 	 * lock as other threads could have access to ssec */
 	rcu_read_lock();
-	selinux_netlbl_sk_security_reset(newssec, ssec->sk->sk_family);
+	selinux_netlbl_sk_security_reset(newssec, sk->sk_family);
 	rcu_read_unlock();
 }
 

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
