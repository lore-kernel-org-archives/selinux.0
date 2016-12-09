From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, dhowells@redhat.com,
 Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux: clean up cred usage and simplify
Date: Fri,  9 Dec 2016 16:21:15 -0500
Message-Id: <1481318475-7288-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

SELinux was sometimes using the task "objective" credentials when
it could/should use the "subjective" credentials.  This was sometimes
hidden by the fact that we were unnecessarily passing around pointers
to the current task, making it appear as if the task could be something
other than current, so eliminate all such passing.  Given that
tasks may only alter their own credentials, we likely should move
the check from selinux_setprocattr() to security_setprocattr() or even
to proc_pid_attr_write() and drop the task argument to the security hook
altogether; it can only serve to confuse things.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/hooks.c | 154 +++++++++++++++++++++++------------------------
 1 file changed, 76 insertions(+), 78 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8a90a0b..3f99480 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1696,23 +1696,27 @@ static int cred_has_perm(const struct cred *actor,
 }
 
 /*
- * Check permission between a pair of tasks, e.g. signal checks,
- * fork check, ptrace check, etc.
- * tsk1 is the actor and tsk2 is the target
- * - this uses the default subjective creds of tsk1
+ * Check permission between a task and the current task.
  */
-static int task_has_perm(const struct task_struct *tsk1,
-			 const struct task_struct *tsk2,
-			 u32 perms)
+static int task_has_perm_to_current(const struct task_struct *tsk,
+				    u32 perms)
 {
-	const struct task_security_struct *__tsec1, *__tsec2;
-	u32 sid1, sid2;
+	u32 ssid, tsid;
 
-	rcu_read_lock();
-	__tsec1 = __task_cred(tsk1)->security;	sid1 = __tsec1->sid;
-	__tsec2 = __task_cred(tsk2)->security;	sid2 = __tsec2->sid;
-	rcu_read_unlock();
-	return avc_has_perm(sid1, sid2, SECCLASS_PROCESS, perms, NULL);
+	ssid = task_sid(tsk);
+	tsid = current_sid();
+	return avc_has_perm(ssid, tsid, SECCLASS_PROCESS, perms, NULL);
+}
+
+/*
+ * Check permission between current and itself.
+ */
+static int self_has_perm(u32 perms)
+{
+	u32 sid;
+
+	sid = current_sid();
+	return avc_has_perm(sid, sid, SECCLASS_PROCESS, perms, NULL);
 }
 
 /*
@@ -1772,13 +1776,10 @@ static int cred_has_capability(const struct cred *cred,
 	return rc;
 }
 
-/* Check whether a task is allowed to use a system operation. */
-static int task_has_system(struct task_struct *tsk,
-			   u32 perms)
+/* Check whether the current task is allowed to use a system operation. */
+static int current_has_system(u32 perms)
 {
-	u32 sid = task_sid(tsk);
-
-	return avc_has_perm(sid, SECINITSID_KERNEL,
+	return avc_has_perm(current_sid(), SECINITSID_KERNEL,
 			    SECCLASS_SYSTEM, perms, NULL);
 }
 
@@ -1953,13 +1954,11 @@ static int may_create(struct inode *dir,
 			    FILESYSTEM__ASSOCIATE, &ad);
 }
 
-/* Check whether a task can create a key. */
-static int may_create_key(u32 ksid,
-			  struct task_struct *ctx)
+/* Check whether the current task can create a key. */
+static int may_create_key(u32 ksid)
 {
-	u32 sid = task_sid(ctx);
-
-	return avc_has_perm(sid, ksid, SECCLASS_KEY, KEY__CREATE, NULL);
+	return avc_has_perm(current_sid(), ksid, SECCLASS_KEY, KEY__CREATE,
+			    NULL);
 }
 
 #define MAY_LINK	0
@@ -2228,7 +2227,7 @@ static int selinux_ptrace_access_check(struct task_struct *child,
 
 static int selinux_ptrace_traceme(struct task_struct *parent)
 {
-	return task_has_perm(parent, current, PROCESS__PTRACE);
+	return task_has_perm_to_current(parent, PROCESS__PTRACE);
 }
 
 static int selinux_capget(struct task_struct *target, kernel_cap_t *effective,
@@ -2303,13 +2302,13 @@ static int selinux_syslog(int type)
 	switch (type) {
 	case SYSLOG_ACTION_READ_ALL:	/* Read last kernel messages */
 	case SYSLOG_ACTION_SIZE_BUFFER:	/* Return size of the log buffer */
-		rc = task_has_system(current, SYSTEM__SYSLOG_READ);
+		rc = current_has_system(SYSTEM__SYSLOG_READ);
 		break;
 	case SYSLOG_ACTION_CONSOLE_OFF:	/* Disable logging to console */
 	case SYSLOG_ACTION_CONSOLE_ON:	/* Enable logging to console */
 	/* Set level of messages printed to console */
 	case SYSLOG_ACTION_CONSOLE_LEVEL:
-		rc = task_has_system(current, SYSTEM__SYSLOG_CONSOLE);
+		rc = current_has_system(SYSTEM__SYSLOG_CONSOLE);
 		break;
 	case SYSLOG_ACTION_CLOSE:	/* Close log */
 	case SYSLOG_ACTION_OPEN:	/* Open log */
@@ -2317,7 +2316,7 @@ static int selinux_syslog(int type)
 	case SYSLOG_ACTION_READ_CLEAR:	/* Read/clear last kernel messages */
 	case SYSLOG_ACTION_CLEAR:	/* Clear ring buffer */
 	default:
-		rc = task_has_system(current, SYSTEM__SYSLOG_MOD);
+		rc = current_has_system(SYSTEM__SYSLOG_MOD);
 		break;
 	}
 	return rc;
@@ -2345,13 +2344,13 @@ static int selinux_vm_enough_memory(struct mm_struct *mm, long pages)
 
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
@@ -2480,7 +2479,7 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
 		 * changes its SID has the appropriate permit */
 		if (bprm->unsafe &
 		    (LSM_UNSAFE_PTRACE | LSM_UNSAFE_PTRACE_CAP)) {
-			u32 ptsid = ptrace_parent_sid(current);
+			u32 ptsid = ptrace_parent_sid();
 			if (ptsid != 0) {
 				rc = avc_has_perm(ptsid, new_tsec->sid,
 						  SECCLASS_PROCESS,
@@ -3644,12 +3643,12 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
 		int rc = 0;
 		if (vma->vm_start >= vma->vm_mm->start_brk &&
 		    vma->vm_end <= vma->vm_mm->brk) {
-			rc = cred_has_perm(cred, cred, PROCESS__EXECHEAP);
+			rc = self_has_perm(PROCESS__EXECHEAP);
 		} else if (!vma->vm_file &&
 			   ((vma->vm_start <= vma->vm_mm->start_stack &&
 			     vma->vm_end >= vma->vm_mm->start_stack) ||
 			    vma_is_stack_for_current(vma))) {
-			rc = current_has_perm(current, PROCESS__EXECSTACK);
+			rc = self_has_perm(PROCESS__EXECSTACK);
 		} else if (vma->vm_file && vma->anon_vma) {
 			/*
 			 * We are making executable a file mapping that has
@@ -3782,7 +3781,7 @@ static int selinux_file_open(struct file *file, const struct cred *cred)
 
 static int selinux_task_create(unsigned long clone_flags)
 {
-	return current_has_perm(current, PROCESS__FORK);
+	return self_has_perm(PROCESS__FORK);
 }
 
 /*
@@ -3892,15 +3891,12 @@ static int selinux_kernel_create_files_as(struct cred *new, struct inode *inode)
 
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
 
@@ -4035,7 +4031,7 @@ static int selinux_task_kill(struct task_struct *p, struct siginfo *info,
 
 static int selinux_task_wait(struct task_struct *p)
 {
-	return task_has_perm(p, current, PROCESS__SIGCHLD);
+	return task_has_perm_to_current(p, PROCESS__SIGCHLD);
 }
 
 static void selinux_task_to_inode(struct task_struct *p,
@@ -4325,12 +4321,11 @@ static int socket_sockcreate_sid(const struct task_security_struct *tsec,
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
@@ -4339,7 +4334,8 @@ static int sock_has_perm(struct task_struct *task, struct sock *sk, u32 perms)
 	ad.u.net = &net;
 	ad.u.net->sk = sk;
 
-	return avc_has_perm(tsid, sksec->sid, sksec->sclass, perms, &ad);
+	return avc_has_perm(current_sid(), sksec->sid, sksec->sclass, perms,
+			    &ad);
 }
 
 static int selinux_socket_create(int family, int type,
@@ -4401,7 +4397,7 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 	u16 family;
 	int err;
 
-	err = sock_has_perm(current, sk, SOCKET__BIND);
+	err = sock_has_perm(sk, SOCKET__BIND);
 	if (err)
 		goto out;
 
@@ -4500,7 +4496,7 @@ static int selinux_socket_connect(struct socket *sock, struct sockaddr *address,
 	struct sk_security_struct *sksec = sk->sk_security;
 	int err;
 
-	err = sock_has_perm(current, sk, SOCKET__CONNECT);
+	err = sock_has_perm(sk, SOCKET__CONNECT);
 	if (err)
 		return err;
 
@@ -4552,7 +4548,7 @@ static int selinux_socket_connect(struct socket *sock, struct sockaddr *address,
 
 static int selinux_socket_listen(struct socket *sock, int backlog)
 {
-	return sock_has_perm(current, sock->sk, SOCKET__LISTEN);
+	return sock_has_perm(sock->sk, SOCKET__LISTEN);
 }
 
 static int selinux_socket_accept(struct socket *sock, struct socket *newsock)
@@ -4563,7 +4559,7 @@ static int selinux_socket_accept(struct socket *sock, struct socket *newsock)
 	u16 sclass;
 	u32 sid;
 
-	err = sock_has_perm(current, sock->sk, SOCKET__ACCEPT);
+	err = sock_has_perm(sock->sk, SOCKET__ACCEPT);
 	if (err)
 		return err;
 
@@ -4584,30 +4580,30 @@ static int selinux_socket_accept(struct socket *sock, struct socket *newsock)
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
 
@@ -4617,12 +4613,12 @@ static int selinux_socket_setsockopt(struct socket *sock, int level, int optname
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
@@ -5110,7 +5106,7 @@ static int selinux_nlmsg_perm(struct sock *sk, struct sk_buff *skb)
 		goto out;
 	}
 
-	err = sock_has_perm(current, sk, perm);
+	err = sock_has_perm(sk, perm);
 out:
 	return err;
 }
@@ -5441,20 +5437,17 @@ static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
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
@@ -5522,7 +5515,7 @@ static int selinux_msg_queue_alloc_security(struct msg_queue *msq)
 	u32 sid = current_sid();
 	int rc;
 
-	rc = ipc_alloc_security(current, &msq->q_perm, SECCLASS_MSGQ);
+	rc = ipc_alloc_security(&msq->q_perm, SECCLASS_MSGQ);
 	if (rc)
 		return rc;
 
@@ -5569,7 +5562,7 @@ static int selinux_msg_queue_msgctl(struct msg_queue *msq, int cmd)
 	case IPC_INFO:
 	case MSG_INFO:
 		/* No specific object, just general system-wide information. */
-		return task_has_system(current, SYSTEM__IPC_INFO);
+		return current_has_system(SYSTEM__IPC_INFO);
 	case IPC_STAT:
 	case MSG_STAT:
 		perms = MSGQ__GETATTR | MSGQ__ASSOCIATE;
@@ -5663,7 +5656,7 @@ static int selinux_shm_alloc_security(struct shmid_kernel *shp)
 	u32 sid = current_sid();
 	int rc;
 
-	rc = ipc_alloc_security(current, &shp->shm_perm, SECCLASS_SHM);
+	rc = ipc_alloc_security(&shp->shm_perm, SECCLASS_SHM);
 	if (rc)
 		return rc;
 
@@ -5711,7 +5704,7 @@ static int selinux_shm_shmctl(struct shmid_kernel *shp, int cmd)
 	case IPC_INFO:
 	case SHM_INFO:
 		/* No specific object, just general system-wide information. */
-		return task_has_system(current, SYSTEM__IPC_INFO);
+		return current_has_system(SYSTEM__IPC_INFO);
 	case IPC_STAT:
 	case SHM_STAT:
 		perms = SHM__GETATTR | SHM__ASSOCIATE;
@@ -5755,7 +5748,7 @@ static int selinux_sem_alloc_security(struct sem_array *sma)
 	u32 sid = current_sid();
 	int rc;
 
-	rc = ipc_alloc_security(current, &sma->sem_perm, SECCLASS_SEM);
+	rc = ipc_alloc_security(&sma->sem_perm, SECCLASS_SEM);
 	if (rc)
 		return rc;
 
@@ -5803,7 +5796,7 @@ static int selinux_sem_semctl(struct sem_array *sma, int cmd)
 	case IPC_INFO:
 	case SEM_INFO:
 		/* No specific object, just general system-wide information. */
-		return task_has_system(current, SYSTEM__IPC_INFO);
+		return current_has_system(SYSTEM__IPC_INFO);
 	case GETPID:
 	case GETNCNT:
 	case GETZCNT:
@@ -5932,26 +5925,31 @@ static int selinux_setprocattr(struct task_struct *p,
 	char *str = value;
 
 	if (current != p) {
-		/* SELinux only allows a process to change its own
-		   security attributes. */
+		/*
+		 * A task may only alter its own credentials.
+		 * SELinux has always enforced this restriction,
+		 * and it is now mandated by the Linux credentials
+		 * implementation; see Documentation/security/credentials.txt.
+		 * Consider moving this check to proc_pid_attr_write() or
+		 * security_setprocattr() and dispensing with the
+		 * task argument altogether.
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
+		error = self_has_perm(PROCESS__SETEXEC);
 	else if (!strcmp(name, "fscreate"))
-		error = current_has_perm(p, PROCESS__SETFSCREATE);
+		error = self_has_perm(PROCESS__SETFSCREATE);
 	else if (!strcmp(name, "keycreate"))
-		error = current_has_perm(p, PROCESS__SETKEYCREATE);
+		error = self_has_perm(PROCESS__SETKEYCREATE);
 	else if (!strcmp(name, "sockcreate"))
-		error = current_has_perm(p, PROCESS__SETSOCKCREATE);
+		error = self_has_perm(PROCESS__SETSOCKCREATE);
 	else if (!strcmp(name, "current"))
-		error = current_has_perm(p, PROCESS__SETCURRENT);
+		error = self_has_perm(PROCESS__SETCURRENT);
 	else
 		error = -EINVAL;
 	if (error)
@@ -6005,7 +6003,7 @@ static int selinux_setprocattr(struct task_struct *p,
 	} else if (!strcmp(name, "fscreate")) {
 		tsec->create_sid = sid;
 	} else if (!strcmp(name, "keycreate")) {
-		error = may_create_key(sid, p);
+		error = may_create_key(sid);
 		if (error)
 			goto abort_change;
 		tsec->keycreate_sid = sid;
@@ -6032,7 +6030,7 @@ static int selinux_setprocattr(struct task_struct *p,
 
 		/* Check for ptracing, and update the task SID if ok.
 		   Otherwise, leave SID unchanged and fail. */
-		ptsid = ptrace_parent_sid(p);
+		ptsid = ptrace_parent_sid();
 		if (ptsid != 0) {
 			error = avc_has_perm(ptsid, sid, SECCLASS_PROCESS,
 					     PROCESS__PTRACE, NULL);
-- 
2.7.4
