From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, james.l.morris@oracle.com,
 linux-security-module@vger.kernel.org, casey@schaufler-ca.com,
 john.johansen@canonical.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 1/2] selinux: clean up cred usage and simplify
Date: Fri, 16 Dec 2016 12:41:11 -0500
Message-Id: <1481910072-11392-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

SELinux was sometimes using the task "objective" credentials when
it could/should use the "subjective" credentials.  This was sometimes
hidden by the fact that we were unnecessarily passing around pointers
to the current task, making it appear as if the task could be something
other than current, so eliminate all such passing of current.  Inline
various permission checking helper functions that can be reduced to a
single avc_has_perm() call.

Since the credentials infrastructure only allows a task to alter
its own credentials, we can always assume that current must be the same
as the target task in selinux_setprocattr after the check. We likely
should move this check from selinux_setprocattr() to proc_pid_attr_write()
and drop the task argument to the security hook altogether; it can only
serve to confuse things.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/hooks.c          | 294 +++++++++++++++-----------------------
 security/selinux/include/objsec.h |  10 ++
 security/selinux/selinuxfs.c      |  73 +++++-----
 3 files changed, 166 insertions(+), 211 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e7c5481..9992626 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -210,16 +210,6 @@ static inline u32 task_sid(const struct task_struct *task)
 	return sid;
 }
 
-/*
- * get the subjective security ID of the current task
- */
-static inline u32 current_sid(void)
-{
-	const struct task_security_struct *tsec = current_security();
-
-	return tsec->sid;
-}
-
 /* Allocate and free functions for each kind of security blob. */
 
 static int inode_alloc_security(struct inode *inode)
@@ -1687,55 +1677,6 @@ static inline u32 signal_to_av(int sig)
 	return perm;
 }
 
-/*
- * Check permission between a pair of credentials
- * fork check, ptrace check, etc.
- */
-static int cred_has_perm(const struct cred *actor,
-			 const struct cred *target,
-			 u32 perms)
-{
-	u32 asid = cred_sid(actor), tsid = cred_sid(target);
-
-	return avc_has_perm(asid, tsid, SECCLASS_PROCESS, perms, NULL);
-}
-
-/*
- * Check permission between a pair of tasks, e.g. signal checks,
- * fork check, ptrace check, etc.
- * tsk1 is the actor and tsk2 is the target
- * - this uses the default subjective creds of tsk1
- */
-static int task_has_perm(const struct task_struct *tsk1,
-			 const struct task_struct *tsk2,
-			 u32 perms)
-{
-	const struct task_security_struct *__tsec1, *__tsec2;
-	u32 sid1, sid2;
-
-	rcu_read_lock();
-	__tsec1 = __task_cred(tsk1)->security;	sid1 = __tsec1->sid;
-	__tsec2 = __task_cred(tsk2)->security;	sid2 = __tsec2->sid;
-	rcu_read_unlock();
-	return avc_has_perm(sid1, sid2, SECCLASS_PROCESS, perms, NULL);
-}
-
-/*
- * Check permission between current and another task, e.g. signal checks,
- * fork check, ptrace check, etc.
- * current is the actor and tsk2 is the target
- * - this uses current's subjective creds
- */
-static int current_has_perm(const struct task_struct *tsk,
-			    u32 perms)
-{
-	u32 sid, tsid;
-
-	sid = current_sid();
-	tsid = task_sid(tsk);
-	return avc_has_perm(sid, tsid, SECCLASS_PROCESS, perms, NULL);
-}
-
 #if CAP_LAST_CAP > 63
 #error Fix SELinux to handle capabilities > 63.
 #endif
@@ -1777,16 +1718,6 @@ static int cred_has_capability(const struct cred *cred,
 	return rc;
 }
 
-/* Check whether a task is allowed to use a system operation. */
-static int task_has_system(struct task_struct *tsk,
-			   u32 perms)
-{
-	u32 sid = task_sid(tsk);
-
-	return avc_has_perm(sid, SECINITSID_KERNEL,
-			    SECCLASS_SYSTEM, perms, NULL);
-}
-
 /* Check whether a task has a particular permission to an inode.
    The 'adp' parameter is optional and allows other audit
    data to be passed (e.g. the dentry). */
@@ -1958,15 +1889,6 @@ static int may_create(struct inode *dir,
 			    FILESYSTEM__ASSOCIATE, &ad);
 }
 
-/* Check whether a task can create a key. */
-static int may_create_key(u32 ksid,
-			  struct task_struct *ctx)
-{
-	u32 sid = task_sid(ctx);
-
-	return avc_has_perm(sid, ksid, SECCLASS_KEY, KEY__CREATE, NULL);
-}
-
 #define MAY_LINK	0
 #define MAY_UNLINK	1
 #define MAY_RMDIR	2
@@ -2222,24 +2144,26 @@ static int selinux_binder_transfer_file(struct task_struct *from,
 static int selinux_ptrace_access_check(struct task_struct *child,
 				     unsigned int mode)
 {
-	if (mode & PTRACE_MODE_READ) {
-		u32 sid = current_sid();
-		u32 csid = task_sid(child);
+	u32 sid = current_sid();
+	u32 csid = task_sid(child);
+
+	if (mode & PTRACE_MODE_READ)
 		return avc_has_perm(sid, csid, SECCLASS_FILE, FILE__READ, NULL);
-	}
 
-	return current_has_perm(child, PROCESS__PTRACE);
+	return avc_has_perm(sid, csid, SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
 }
 
 static int selinux_ptrace_traceme(struct task_struct *parent)
 {
-	return task_has_perm(parent, current, PROCESS__PTRACE);
+	return avc_has_perm(task_sid(parent), current_sid(), SECCLASS_PROCESS,
+			    PROCESS__PTRACE, NULL);
 }
 
 static int selinux_capget(struct task_struct *target, kernel_cap_t *effective,
 			  kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
-	return current_has_perm(target, PROCESS__GETCAP);
+	return avc_has_perm(current_sid(), task_sid(target), SECCLASS_PROCESS,
+			    PROCESS__GETCAP, NULL);
 }
 
 static int selinux_capset(struct cred *new, const struct cred *old,
@@ -2247,7 +2171,8 @@ static int selinux_capset(struct cred *new, const struct cred *old,
 			  const kernel_cap_t *inheritable,
 			  const kernel_cap_t *permitted)
 {
-	return cred_has_perm(old, new, PROCESS__SETCAP);
+	return avc_has_perm(cred_sid(old), cred_sid(new), SECCLASS_PROCESS,
+			    PROCESS__SETCAP, NULL);
 }
 
 /*
@@ -2303,29 +2228,22 @@ static int selinux_quota_on(struct dentry *dentry)
 
 static int selinux_syslog(int type)
 {
-	int rc;
-
 	switch (type) {
 	case SYSLOG_ACTION_READ_ALL:	/* Read last kernel messages */
 	case SYSLOG_ACTION_SIZE_BUFFER:	/* Return size of the log buffer */
-		rc = task_has_system(current, SYSTEM__SYSLOG_READ);
-		break;
+		return avc_has_perm(current_sid(), SECINITSID_KERNEL,
+				    SECCLASS_SYSTEM, SYSTEM__SYSLOG_READ, NULL);
 	case SYSLOG_ACTION_CONSOLE_OFF:	/* Disable logging to console */
 	case SYSLOG_ACTION_CONSOLE_ON:	/* Enable logging to console */
 	/* Set level of messages printed to console */
 	case SYSLOG_ACTION_CONSOLE_LEVEL:
-		rc = task_has_system(current, SYSTEM__SYSLOG_CONSOLE);
-		break;
-	case SYSLOG_ACTION_CLOSE:	/* Close log */
-	case SYSLOG_ACTION_OPEN:	/* Open log */
-	case SYSLOG_ACTION_READ:	/* Read from log */
-	case SYSLOG_ACTION_READ_CLEAR:	/* Read/clear last kernel messages */
-	case SYSLOG_ACTION_CLEAR:	/* Clear ring buffer */
-	default:
-		rc = task_has_system(current, SYSTEM__SYSLOG_MOD);
-		break;
+		return avc_has_perm(current_sid(), SECINITSID_KERNEL,
+				    SECCLASS_SYSTEM, SYSTEM__SYSLOG_CONSOLE,
+				    NULL);
 	}
-	return rc;
+	/* All other syslog types */
+	return avc_has_perm(current_sid(), SECINITSID_KERNEL,
+			    SECCLASS_SYSTEM, SYSTEM__SYSLOG_MOD, NULL);
 }
 
 /*
@@ -2350,13 +2268,13 @@ static int selinux_vm_enough_memory(struct mm_struct *mm, long pages)
 
 /* binprm security operations */
 
-static u32 ptrace_parent_sid(struct task_struct *task)
+static u32 ptrace_parent_sid(void)
 {
 	u32 sid = 0;
 	struct task_struct *tracer;
 
 	rcu_read_lock();
-	tracer = ptrace_parent(task);
+	tracer = ptrace_parent(current);
 	if (tracer)
 		sid = task_sid(tracer);
 	rcu_read_unlock();
@@ -2485,7 +2403,7 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
 		 * changes its SID has the appropriate permit */
 		if (bprm->unsafe &
 		    (LSM_UNSAFE_PTRACE | LSM_UNSAFE_PTRACE_CAP)) {
-			u32 ptsid = ptrace_parent_sid(current);
+			u32 ptsid = ptrace_parent_sid();
 			if (ptsid != 0) {
 				rc = avc_has_perm(ptsid, new_tsec->sid,
 						  SECCLASS_PROCESS,
@@ -3579,6 +3497,7 @@ static int default_noexec;
 static int file_map_prot_check(struct file *file, unsigned long prot, int shared)
 {
 	const struct cred *cred = current_cred();
+	u32 sid = cred_sid(cred);
 	int rc = 0;
 
 	if (default_noexec &&
@@ -3589,7 +3508,8 @@ static int file_map_prot_check(struct file *file, unsigned long prot, int shared
 		 * private file mapping that will also be writable.
 		 * This has an additional check.
 		 */
-		rc = cred_has_perm(cred, cred, PROCESS__EXECMEM);
+		rc = avc_has_perm(sid, sid, SECCLASS_PROCESS,
+				  PROCESS__EXECMEM, NULL);
 		if (rc)
 			goto error;
 	}
@@ -3640,6 +3560,7 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
 				 unsigned long prot)
 {
 	const struct cred *cred = current_cred();
+	u32 sid = cred_sid(cred);
 
 	if (selinux_checkreqprot)
 		prot = reqprot;
@@ -3649,12 +3570,14 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
 		int rc = 0;
 		if (vma->vm_start >= vma->vm_mm->start_brk &&
 		    vma->vm_end <= vma->vm_mm->brk) {
-			rc = cred_has_perm(cred, cred, PROCESS__EXECHEAP);
+			rc = avc_has_perm(sid, sid, SECCLASS_PROCESS,
+					  PROCESS__EXECHEAP, NULL);
 		} else if (!vma->vm_file &&
 			   ((vma->vm_start <= vma->vm_mm->start_stack &&
 			     vma->vm_end >= vma->vm_mm->start_stack) ||
 			    vma_is_stack_for_current(vma))) {
-			rc = current_has_perm(current, PROCESS__EXECSTACK);
+			rc = avc_has_perm(sid, sid, SECCLASS_PROCESS,
+					  PROCESS__EXECSTACK, NULL);
 		} else if (vma->vm_file && vma->anon_vma) {
 			/*
 			 * We are making executable a file mapping that has
@@ -3787,7 +3710,9 @@ static int selinux_file_open(struct file *file, const struct cred *cred)
 
 static int selinux_task_create(unsigned long clone_flags)
 {
-	return current_has_perm(current, PROCESS__FORK);
+	u32 sid = current_sid();
+
+	return avc_has_perm(sid, sid, SECCLASS_PROCESS, PROCESS__FORK, NULL);
 }
 
 /*
@@ -3897,15 +3822,12 @@ static int selinux_kernel_create_files_as(struct cred *new, struct inode *inode)
 
 static int selinux_kernel_module_request(char *kmod_name)
 {
-	u32 sid;
 	struct common_audit_data ad;
 
-	sid = task_sid(current);
-
 	ad.type = LSM_AUDIT_DATA_KMOD;
 	ad.u.kmod_name = kmod_name;
 
-	return avc_has_perm(sid, SECINITSID_KERNEL, SECCLASS_SYSTEM,
+	return avc_has_perm(current_sid(), SECINITSID_KERNEL, SECCLASS_SYSTEM,
 			    SYSTEM__MODULE_REQUEST, &ad);
 }
 
@@ -3957,17 +3879,20 @@ static int selinux_kernel_read_file(struct file *file,
 
 static int selinux_task_setpgid(struct task_struct *p, pid_t pgid)
 {
-	return current_has_perm(p, PROCESS__SETPGID);
+	return avc_has_perm(current_sid(), task_sid(p), SECCLASS_PROCESS,
+			    PROCESS__SETPGID, NULL);
 }
 
 static int selinux_task_getpgid(struct task_struct *p)
 {
-	return current_has_perm(p, PROCESS__GETPGID);
+	return avc_has_perm(current_sid(), task_sid(p), SECCLASS_PROCESS,
+			    PROCESS__GETPGID, NULL);
 }
 
 static int selinux_task_getsid(struct task_struct *p)
 {
-	return current_has_perm(p, PROCESS__GETSESSION);
+	return avc_has_perm(current_sid(), task_sid(p), SECCLASS_PROCESS,
+			    PROCESS__GETSESSION, NULL);
 }
 
 static void selinux_task_getsecid(struct task_struct *p, u32 *secid)
@@ -3977,17 +3902,20 @@ static void selinux_task_getsecid(struct task_struct *p, u32 *secid)
 
 static int selinux_task_setnice(struct task_struct *p, int nice)
 {
-	return current_has_perm(p, PROCESS__SETSCHED);
+	return avc_has_perm(current_sid(), task_sid(p), SECCLASS_PROCESS,
+			    PROCESS__SETSCHED, NULL);
 }
 
 static int selinux_task_setioprio(struct task_struct *p, int ioprio)
 {
-	return current_has_perm(p, PROCESS__SETSCHED);
+	return avc_has_perm(current_sid(), task_sid(p), SECCLASS_PROCESS,
+			    PROCESS__SETSCHED, NULL);
 }
 
 static int selinux_task_getioprio(struct task_struct *p)
 {
-	return current_has_perm(p, PROCESS__GETSCHED);
+	return avc_has_perm(current_sid(), task_sid(p), SECCLASS_PROCESS,
+			    PROCESS__GETSCHED, NULL);
 }
 
 static int selinux_task_setrlimit(struct task_struct *p, unsigned int resource,
@@ -4000,47 +3928,48 @@ static int selinux_task_setrlimit(struct task_struct *p, unsigned int resource,
 	   later be used as a safe reset point for the soft limit
 	   upon context transitions.  See selinux_bprm_committing_creds. */
 	if (old_rlim->rlim_max != new_rlim->rlim_max)
-		return current_has_perm(p, PROCESS__SETRLIMIT);
+		return avc_has_perm(current_sid(), task_sid(p),
+				    SECCLASS_PROCESS, PROCESS__SETRLIMIT, NULL);
 
 	return 0;
 }
 
 static int selinux_task_setscheduler(struct task_struct *p)
 {
-	return current_has_perm(p, PROCESS__SETSCHED);
+	return avc_has_perm(current_sid(), task_sid(p), SECCLASS_PROCESS,
+			    PROCESS__SETSCHED, NULL);
 }
 
 static int selinux_task_getscheduler(struct task_struct *p)
 {
-	return current_has_perm(p, PROCESS__GETSCHED);
+	return avc_has_perm(current_sid(), task_sid(p), SECCLASS_PROCESS,
+			    PROCESS__GETSCHED, NULL);
 }
 
 static int selinux_task_movememory(struct task_struct *p)
 {
-	return current_has_perm(p, PROCESS__SETSCHED);
+	return avc_has_perm(current_sid(), task_sid(p), SECCLASS_PROCESS,
+			    PROCESS__SETSCHED, NULL);
 }
 
 static int selinux_task_kill(struct task_struct *p, struct siginfo *info,
 				int sig, u32 secid)
 {
 	u32 perm;
-	int rc;
 
 	if (!sig)
 		perm = PROCESS__SIGNULL; /* null signal; existence test */
 	else
 		perm = signal_to_av(sig);
-	if (secid)
-		rc = avc_has_perm(secid, task_sid(p),
-				  SECCLASS_PROCESS, perm, NULL);
-	else
-		rc = current_has_perm(p, perm);
-	return rc;
+	if (!secid)
+		secid = current_sid();
+	return avc_has_perm(secid, task_sid(p), SECCLASS_PROCESS, perm, NULL);
 }
 
 static int selinux_task_wait(struct task_struct *p)
 {
-	return task_has_perm(p, current, PROCESS__SIGCHLD);
+	return avc_has_perm(task_sid(p), current_sid(), SECCLASS_PROCESS,
+			    PROCESS__SIGCHLD, NULL);
 }
 
 static void selinux_task_to_inode(struct task_struct *p,
@@ -4330,12 +4259,11 @@ static int socket_sockcreate_sid(const struct task_security_struct *tsec,
 				       socksid);
 }
 
-static int sock_has_perm(struct task_struct *task, struct sock *sk, u32 perms)
+static int sock_has_perm(struct sock *sk, u32 perms)
 {
 	struct sk_security_struct *sksec = sk->sk_security;
 	struct common_audit_data ad;
 	struct lsm_network_audit net = {0,};
-	u32 tsid = task_sid(task);
 
 	if (sksec->sid == SECINITSID_KERNEL)
 		return 0;
@@ -4344,7 +4272,8 @@ static int sock_has_perm(struct task_struct *task, struct sock *sk, u32 perms)
 	ad.u.net = &net;
 	ad.u.net->sk = sk;
 
-	return avc_has_perm(tsid, sksec->sid, sksec->sclass, perms, &ad);
+	return avc_has_perm(current_sid(), sksec->sid, sksec->sclass, perms,
+			    &ad);
 }
 
 static int selinux_socket_create(int family, int type,
@@ -4406,7 +4335,7 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 	u16 family;
 	int err;
 
-	err = sock_has_perm(current, sk, SOCKET__BIND);
+	err = sock_has_perm(sk, SOCKET__BIND);
 	if (err)
 		goto out;
 
@@ -4505,7 +4434,7 @@ static int selinux_socket_connect(struct socket *sock, struct sockaddr *address,
 	struct sk_security_struct *sksec = sk->sk_security;
 	int err;
 
-	err = sock_has_perm(current, sk, SOCKET__CONNECT);
+	err = sock_has_perm(sk, SOCKET__CONNECT);
 	if (err)
 		return err;
 
@@ -4557,7 +4486,7 @@ static int selinux_socket_connect(struct socket *sock, struct sockaddr *address,
 
 static int selinux_socket_listen(struct socket *sock, int backlog)
 {
-	return sock_has_perm(current, sock->sk, SOCKET__LISTEN);
+	return sock_has_perm(sock->sk, SOCKET__LISTEN);
 }
 
 static int selinux_socket_accept(struct socket *sock, struct socket *newsock)
@@ -4568,7 +4497,7 @@ static int selinux_socket_accept(struct socket *sock, struct socket *newsock)
 	u16 sclass;
 	u32 sid;
 
-	err = sock_has_perm(current, sock->sk, SOCKET__ACCEPT);
+	err = sock_has_perm(sock->sk, SOCKET__ACCEPT);
 	if (err)
 		return err;
 
@@ -4589,30 +4518,30 @@ static int selinux_socket_accept(struct socket *sock, struct socket *newsock)
 static int selinux_socket_sendmsg(struct socket *sock, struct msghdr *msg,
 				  int size)
 {
-	return sock_has_perm(current, sock->sk, SOCKET__WRITE);
+	return sock_has_perm(sock->sk, SOCKET__WRITE);
 }
 
 static int selinux_socket_recvmsg(struct socket *sock, struct msghdr *msg,
 				  int size, int flags)
 {
-	return sock_has_perm(current, sock->sk, SOCKET__READ);
+	return sock_has_perm(sock->sk, SOCKET__READ);
 }
 
 static int selinux_socket_getsockname(struct socket *sock)
 {
-	return sock_has_perm(current, sock->sk, SOCKET__GETATTR);
+	return sock_has_perm(sock->sk, SOCKET__GETATTR);
 }
 
 static int selinux_socket_getpeername(struct socket *sock)
 {
-	return sock_has_perm(current, sock->sk, SOCKET__GETATTR);
+	return sock_has_perm(sock->sk, SOCKET__GETATTR);
 }
 
 static int selinux_socket_setsockopt(struct socket *sock, int level, int optname)
 {
 	int err;
 
-	err = sock_has_perm(current, sock->sk, SOCKET__SETOPT);
+	err = sock_has_perm(sock->sk, SOCKET__SETOPT);
 	if (err)
 		return err;
 
@@ -4622,12 +4551,12 @@ static int selinux_socket_setsockopt(struct socket *sock, int level, int optname
 static int selinux_socket_getsockopt(struct socket *sock, int level,
 				     int optname)
 {
-	return sock_has_perm(current, sock->sk, SOCKET__GETOPT);
+	return sock_has_perm(sock->sk, SOCKET__GETOPT);
 }
 
 static int selinux_socket_shutdown(struct socket *sock, int how)
 {
-	return sock_has_perm(current, sock->sk, SOCKET__SHUTDOWN);
+	return sock_has_perm(sock->sk, SOCKET__SHUTDOWN);
 }
 
 static int selinux_socket_unix_stream_connect(struct sock *sock,
@@ -5115,7 +5044,7 @@ static int selinux_nlmsg_perm(struct sock *sk, struct sk_buff *skb)
 		goto out;
 	}
 
-	err = sock_has_perm(current, sk, perm);
+	err = sock_has_perm(sk, perm);
 out:
 	return err;
 }
@@ -5446,20 +5375,17 @@ static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
 	return selinux_nlmsg_perm(sk, skb);
 }
 
-static int ipc_alloc_security(struct task_struct *task,
-			      struct kern_ipc_perm *perm,
+static int ipc_alloc_security(struct kern_ipc_perm *perm,
 			      u16 sclass)
 {
 	struct ipc_security_struct *isec;
-	u32 sid;
 
 	isec = kzalloc(sizeof(struct ipc_security_struct), GFP_KERNEL);
 	if (!isec)
 		return -ENOMEM;
 
-	sid = task_sid(task);
 	isec->sclass = sclass;
-	isec->sid = sid;
+	isec->sid = current_sid();
 	perm->security = isec;
 
 	return 0;
@@ -5527,7 +5453,7 @@ static int selinux_msg_queue_alloc_security(struct msg_queue *msq)
 	u32 sid = current_sid();
 	int rc;
 
-	rc = ipc_alloc_security(current, &msq->q_perm, SECCLASS_MSGQ);
+	rc = ipc_alloc_security(&msq->q_perm, SECCLASS_MSGQ);
 	if (rc)
 		return rc;
 
@@ -5574,7 +5500,8 @@ static int selinux_msg_queue_msgctl(struct msg_queue *msq, int cmd)
 	case IPC_INFO:
 	case MSG_INFO:
 		/* No specific object, just general system-wide information. */
-		return task_has_system(current, SYSTEM__IPC_INFO);
+		return avc_has_perm(current_sid(), SECINITSID_KERNEL,
+				    SECCLASS_SYSTEM, SYSTEM__IPC_INFO, NULL);
 	case IPC_STAT:
 	case MSG_STAT:
 		perms = MSGQ__GETATTR | MSGQ__ASSOCIATE;
@@ -5668,7 +5595,7 @@ static int selinux_shm_alloc_security(struct shmid_kernel *shp)
 	u32 sid = current_sid();
 	int rc;
 
-	rc = ipc_alloc_security(current, &shp->shm_perm, SECCLASS_SHM);
+	rc = ipc_alloc_security(&shp->shm_perm, SECCLASS_SHM);
 	if (rc)
 		return rc;
 
@@ -5716,7 +5643,8 @@ static int selinux_shm_shmctl(struct shmid_kernel *shp, int cmd)
 	case IPC_INFO:
 	case SHM_INFO:
 		/* No specific object, just general system-wide information. */
-		return task_has_system(current, SYSTEM__IPC_INFO);
+		return avc_has_perm(current_sid(), SECINITSID_KERNEL,
+				    SECCLASS_SYSTEM, SYSTEM__IPC_INFO, NULL);
 	case IPC_STAT:
 	case SHM_STAT:
 		perms = SHM__GETATTR | SHM__ASSOCIATE;
@@ -5760,7 +5688,7 @@ static int selinux_sem_alloc_security(struct sem_array *sma)
 	u32 sid = current_sid();
 	int rc;
 
-	rc = ipc_alloc_security(current, &sma->sem_perm, SECCLASS_SEM);
+	rc = ipc_alloc_security(&sma->sem_perm, SECCLASS_SEM);
 	if (rc)
 		return rc;
 
@@ -5808,7 +5736,8 @@ static int selinux_sem_semctl(struct sem_array *sma, int cmd)
 	case IPC_INFO:
 	case SEM_INFO:
 		/* No specific object, just general system-wide information. */
-		return task_has_system(current, SYSTEM__IPC_INFO);
+		return avc_has_perm(current_sid(), SECINITSID_KERNEL,
+				    SECCLASS_SYSTEM, SYSTEM__IPC_INFO, NULL);
 	case GETPID:
 	case GETNCNT:
 	case GETZCNT:
@@ -5889,15 +5818,16 @@ static int selinux_getprocattr(struct task_struct *p,
 	int error;
 	unsigned len;
 
+	rcu_read_lock();
+	__tsec = __task_cred(p)->security;
+
 	if (current != p) {
-		error = current_has_perm(p, PROCESS__GETATTR);
+		error = avc_has_perm(current_sid(), __tsec->sid,
+				     SECCLASS_PROCESS, PROCESS__GETATTR, NULL);
 		if (error)
-			return error;
+			goto bad;
 	}
 
-	rcu_read_lock();
-	__tsec = __task_cred(p)->security;
-
 	if (!strcmp(name, "current"))
 		sid = __tsec->sid;
 	else if (!strcmp(name, "prev"))
@@ -5910,8 +5840,10 @@ static int selinux_getprocattr(struct task_struct *p,
 		sid = __tsec->keycreate_sid;
 	else if (!strcmp(name, "sockcreate"))
 		sid = __tsec->sockcreate_sid;
-	else
-		goto invalid;
+	else {
+		error = -EINVAL;
+		goto bad;
+	}
 	rcu_read_unlock();
 
 	if (!sid)
@@ -5922,9 +5854,9 @@ static int selinux_getprocattr(struct task_struct *p,
 		return error;
 	return len;
 
-invalid:
+bad:
 	rcu_read_unlock();
-	return -EINVAL;
+	return error;
 }
 
 static int selinux_setprocattr(struct task_struct *p,
@@ -5932,31 +5864,38 @@ static int selinux_setprocattr(struct task_struct *p,
 {
 	struct task_security_struct *tsec;
 	struct cred *new;
-	u32 sid = 0, ptsid;
+	u32 mysid = current_sid(), sid = 0, ptsid;
 	int error;
 	char *str = value;
 
 	if (current != p) {
-		/* SELinux only allows a process to change its own
-		   security attributes. */
+		/*
+		 * A task may only alter its own credentials.
+		 * SELinux has always enforced this restriction,
+		 * and it is now mandated by the Linux credentials
+		 * infrastructure; see Documentation/security/credentials.txt.
+		 */
 		return -EACCES;
 	}
 
 	/*
 	 * Basic control over ability to set these attributes at all.
-	 * current == p, but we'll pass them separately in case the
-	 * above restriction is ever removed.
 	 */
 	if (!strcmp(name, "exec"))
-		error = current_has_perm(p, PROCESS__SETEXEC);
+		error = avc_has_perm(mysid, mysid, SECCLASS_PROCESS,
+				     PROCESS__SETEXEC, NULL);
 	else if (!strcmp(name, "fscreate"))
-		error = current_has_perm(p, PROCESS__SETFSCREATE);
+		error = avc_has_perm(mysid, mysid, SECCLASS_PROCESS,
+				     PROCESS__SETFSCREATE, NULL);
 	else if (!strcmp(name, "keycreate"))
-		error = current_has_perm(p, PROCESS__SETKEYCREATE);
+		error = avc_has_perm(mysid, mysid, SECCLASS_PROCESS,
+				     PROCESS__SETKEYCREATE, NULL);
 	else if (!strcmp(name, "sockcreate"))
-		error = current_has_perm(p, PROCESS__SETSOCKCREATE);
+		error = avc_has_perm(mysid, mysid, SECCLASS_PROCESS,
+				     PROCESS__SETSOCKCREATE, NULL);
 	else if (!strcmp(name, "current"))
-		error = current_has_perm(p, PROCESS__SETCURRENT);
+		error = avc_has_perm(mysid, mysid, SECCLASS_PROCESS,
+				     PROCESS__SETCURRENT, NULL);
 	else
 		error = -EINVAL;
 	if (error)
@@ -6010,7 +5949,8 @@ static int selinux_setprocattr(struct task_struct *p,
 	} else if (!strcmp(name, "fscreate")) {
 		tsec->create_sid = sid;
 	} else if (!strcmp(name, "keycreate")) {
-		error = may_create_key(sid, p);
+		error = avc_has_perm(mysid, sid, SECCLASS_KEY, KEY__CREATE,
+				     NULL);
 		if (error)
 			goto abort_change;
 		tsec->keycreate_sid = sid;
@@ -6037,7 +5977,7 @@ static int selinux_setprocattr(struct task_struct *p,
 
 		/* Check for ptracing, and update the task SID if ok.
 		   Otherwise, leave SID unchanged and fail. */
-		ptsid = ptrace_parent_sid(p);
+		ptsid = ptrace_parent_sid();
 		if (ptsid != 0) {
 			error = avc_has_perm(ptsid, sid, SECCLASS_PROCESS,
 					     PROCESS__PTRACE, NULL);
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index e8dab0f..c03cdcd 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -37,6 +37,16 @@ struct task_security_struct {
 	u32 sockcreate_sid;	/* fscreate SID */
 };
 
+/*
+ * get the subjective security ID of the current task
+ */
+static inline u32 current_sid(void)
+{
+	const struct task_security_struct *tsec = current_security();
+
+	return tsec->sid;
+}
+
 enum label_initialized {
 	LABEL_INVALID,		/* invalid or not initialized */
 	LABEL_INITIALIZED,	/* initialized */
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 0aac402..55345f8 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -77,25 +77,6 @@ static char policy_opened;
 /* global data for policy capabilities */
 static struct dentry *policycap_dir;
 
-/* Check whether a task is allowed to use a security operation. */
-static int task_has_security(struct task_struct *tsk,
-			     u32 perms)
-{
-	const struct task_security_struct *tsec;
-	u32 sid = 0;
-
-	rcu_read_lock();
-	tsec = __task_cred(tsk)->security;
-	if (tsec)
-		sid = tsec->sid;
-	rcu_read_unlock();
-	if (!tsec)
-		return -EACCES;
-
-	return avc_has_perm(sid, SECINITSID_SECURITY,
-			    SECCLASS_SECURITY, perms, NULL);
-}
-
 enum sel_inos {
 	SEL_ROOT_INO = 2,
 	SEL_LOAD,	/* load policy */
@@ -166,7 +147,9 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 	new_value = !!new_value;
 
 	if (new_value != selinux_enforcing) {
-		length = task_has_security(current, SECURITY__SETENFORCE);
+		length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
+				      SECCLASS_SECURITY, SECURITY__SETENFORCE,
+				      NULL);
 		if (length)
 			goto out;
 		audit_log(current->audit_context, GFP_KERNEL, AUDIT_MAC_STATUS,
@@ -368,7 +351,8 @@ static int sel_open_policy(struct inode *inode, struct file *filp)
 
 	mutex_lock(&sel_mutex);
 
-	rc = task_has_security(current, SECURITY__READ_POLICY);
+	rc = avc_has_perm(current_sid(), SECINITSID_SECURITY,
+			  SECCLASS_SECURITY, SECURITY__READ_POLICY, NULL);
 	if (rc)
 		goto err;
 
@@ -429,7 +413,8 @@ static ssize_t sel_read_policy(struct file *filp, char __user *buf,
 
 	mutex_lock(&sel_mutex);
 
-	ret = task_has_security(current, SECURITY__READ_POLICY);
+	ret = avc_has_perm(current_sid(), SECINITSID_SECURITY,
+			  SECCLASS_SECURITY, SECURITY__READ_POLICY, NULL);
 	if (ret)
 		goto out;
 
@@ -499,7 +484,8 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 
 	mutex_lock(&sel_mutex);
 
-	length = task_has_security(current, SECURITY__LOAD_POLICY);
+	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
+			      SECCLASS_SECURITY, SECURITY__LOAD_POLICY, NULL);
 	if (length)
 		goto out;
 
@@ -561,7 +547,8 @@ static ssize_t sel_write_context(struct file *file, char *buf, size_t size)
 	u32 sid, len;
 	ssize_t length;
 
-	length = task_has_security(current, SECURITY__CHECK_CONTEXT);
+	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
+			      SECCLASS_SECURITY, SECURITY__CHECK_CONTEXT, NULL);
 	if (length)
 		goto out;
 
@@ -604,7 +591,9 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 	ssize_t length;
 	unsigned int new_value;
 
-	length = task_has_security(current, SECURITY__SETCHECKREQPROT);
+	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
+			      SECCLASS_SECURITY, SECURITY__SETCHECKREQPROT,
+			      NULL);
 	if (length)
 		return length;
 
@@ -645,7 +634,8 @@ static ssize_t sel_write_validatetrans(struct file *file,
 	u16 tclass;
 	int rc;
 
-	rc = task_has_security(current, SECURITY__VALIDATE_TRANS);
+	rc = avc_has_perm(current_sid(), SECINITSID_SECURITY,
+			  SECCLASS_SECURITY, SECURITY__VALIDATE_TRANS, NULL);
 	if (rc)
 		goto out;
 
@@ -772,7 +762,8 @@ static ssize_t sel_write_access(struct file *file, char *buf, size_t size)
 	struct av_decision avd;
 	ssize_t length;
 
-	length = task_has_security(current, SECURITY__COMPUTE_AV);
+	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
+			      SECCLASS_SECURITY, SECURITY__COMPUTE_AV, NULL);
 	if (length)
 		goto out;
 
@@ -822,7 +813,9 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
 	u32 len;
 	int nargs;
 
-	length = task_has_security(current, SECURITY__COMPUTE_CREATE);
+	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
+			      SECCLASS_SECURITY, SECURITY__COMPUTE_CREATE,
+			      NULL);
 	if (length)
 		goto out;
 
@@ -919,7 +912,9 @@ static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size)
 	char *newcon = NULL;
 	u32 len;
 
-	length = task_has_security(current, SECURITY__COMPUTE_RELABEL);
+	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
+			      SECCLASS_SECURITY, SECURITY__COMPUTE_RELABEL,
+			      NULL);
 	if (length)
 		goto out;
 
@@ -975,7 +970,9 @@ static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 	int i, rc;
 	u32 len, nsids;
 
-	length = task_has_security(current, SECURITY__COMPUTE_USER);
+	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
+			      SECCLASS_SECURITY, SECURITY__COMPUTE_USER,
+			      NULL);
 	if (length)
 		goto out;
 
@@ -1035,7 +1032,9 @@ static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
 	char *newcon = NULL;
 	u32 len;
 
-	length = task_has_security(current, SECURITY__COMPUTE_MEMBER);
+	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
+			      SECCLASS_SECURITY, SECURITY__COMPUTE_MEMBER,
+			      NULL);
 	if (length)
 		goto out;
 
@@ -1142,7 +1141,9 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
 
 	mutex_lock(&sel_mutex);
 
-	length = task_has_security(current, SECURITY__SETBOOL);
+	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
+			      SECCLASS_SECURITY, SECURITY__SETBOOL,
+			      NULL);
 	if (length)
 		goto out;
 
@@ -1198,7 +1199,9 @@ static ssize_t sel_commit_bools_write(struct file *filep,
 
 	mutex_lock(&sel_mutex);
 
-	length = task_has_security(current, SECURITY__SETBOOL);
+	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
+			      SECCLASS_SECURITY, SECURITY__SETBOOL,
+			      NULL);
 	if (length)
 		goto out;
 
@@ -1351,7 +1354,9 @@ static ssize_t sel_write_avc_cache_threshold(struct file *file,
 	ssize_t ret;
 	unsigned int new_value;
 
-	ret = task_has_security(current, SECURITY__SETSECPARAM);
+	ret = avc_has_perm(current_sid(), SECINITSID_SECURITY,
+			   SECCLASS_SECURITY, SECURITY__SETSECPARAM,
+			   NULL);
 	if (ret)
 		return ret;
 
-- 
2.7.4
