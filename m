Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4THdFqw010272
	for <selinux@tycho.nsa.gov>; Tue, 29 May 2007 13:39:15 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4THdDgb004211
	for <selinux@tycho.nsa.gov>; Tue, 29 May 2007 17:39:15 GMT
From: Steve Grubb <sgrubb@redhat.com>
To: selinux@tycho.nsa.gov
Subject: AUDIT_AVC_PATH problems
Date: Tue, 29 May 2007 13:36:34 -0400
Cc: jmorris@namei.org, Stephen Smalley <sds@epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200705291336.34381.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

This was posted on linux-audit and wanted to make sure it got some review over 
here, too.

-Steve

----------  Forwarded Message  ----------

Subject: AUDIT_AVC_PATH problems
Date: Tuesday 29 May 2007 10:53
From: Alexander Viro <aviro@redhat.com>
To: linux-audit@redhat.com

	Selinux folks had been complaining about the lack of AVC_PATH
records when audit is disabled.  I must admit my stupidity - I assumed
that avc_audit() really couldn't use audit_log_d_path() because of
deadlocks (== could be called with dcache_lock or vfsmount_lock held).
Shouldn't have made that assumption - it never gets called that way.
It _is_ called under spinlocks, but not those.

	Since audit_log_d_path() uses ab->gfp_mask for allocations, kmalloc()
in there is not a problem.  IOW, the simple fix should be sufficient: let's
rip AUDIT_AVC_PATH out and simply generate pathname as part of main record.
It's trivial to do.  Patch below is against the mainline, rhel5 variant
is also trivial.

	Comments?

diff --git a/include/linux/audit.h b/include/linux/audit.h
index fccc6e5..f3d6e5f 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -399,7 +399,6 @@ extern int audit_bprm(struct linux_binprm *bprm);
 extern int audit_socketcall(int nargs, unsigned long *args);
 extern int audit_sockaddr(int len, void *addr);
 extern int __audit_fd_pair(int fd1, int fd2);
-extern int audit_avc_path(struct dentry *dentry, struct vfsmount *mnt);
 extern int audit_set_macxattr(const char *name);
 extern int __audit_mq_open(int oflag, mode_t mode, struct mq_attr __user
 *u_attr); extern int __audit_mq_timedsend(mqd_t mqdes, size_t msg_len,
 unsigned int msg_prio, const struct timespec __user *u_abs_timeout); @@
 -479,7 +478,6 @@ extern int audit_signals;
 #define audit_socketcall(n,a) ({ 0; })
 #define audit_fd_pair(n,a) ({ 0; })
 #define audit_sockaddr(len, addr) ({ 0; })
-#define audit_avc_path(dentry, mnt) ({ 0; })
 #define audit_set_macxattr(n) do { ; } while (0)
 #define audit_mq_open(o,m,a) ({ 0; })
 #define audit_mq_timedsend(d,l,p,t) ({ 0; })
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index e36481e..10e0e6e 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -176,12 +176,6 @@ struct audit_aux_data_fd_pair {
 	int	fd[2];
 };

-struct audit_aux_data_path {
-	struct audit_aux_data	d;
-	struct dentry		*dentry;
-	struct vfsmount		*mnt;
-};
-
 struct audit_aux_data_pids {
 	struct audit_aux_data	d;
 	pid_t			target_pid[AUDIT_AUX_PIDS];
@@ -657,12 +651,6 @@ static inline void audit_free_aux(struct audit_context
 *context) struct audit_aux_data *aux;

 	while ((aux = context->aux)) {
-		if (aux->type == AUDIT_AVC_PATH) {
-			struct audit_aux_data_path *axi = (void *)aux;
-			dput(axi->dentry);
-			mntput(axi->mnt);
-		}
-
 		context->aux = aux->next;
 		kfree(aux);
 	}
@@ -998,11 +986,6 @@ static void audit_log_exit(struct audit_context
 *context, struct task_struct *ts audit_log_hex(ab, axs->a, axs->len);
 			break; }

-		case AUDIT_AVC_PATH: {
-			struct audit_aux_data_path *axi = (void *)aux;
-			audit_log_d_path(ab, "path=", axi->dentry, axi->mnt);
-			break; }
-
 		case AUDIT_FD_PAIR: {
 			struct audit_aux_data_fd_pair *axs = (void *)aux;
 			audit_log_format(ab, "fd0=%d fd1=%d", axs->fd[0], axs->fd[1]);
@@ -1952,36 +1935,6 @@ void __audit_ptrace(struct task_struct *t)
 }

 /**
- * audit_avc_path - record the granting or denial of permissions
- * @dentry: dentry to record
- * @mnt: mnt to record
- *
- * Returns 0 for success or NULL context or < 0 on error.
- *
- * Called from security/selinux/avc.c::avc_audit()
- */
-int audit_avc_path(struct dentry *dentry, struct vfsmount *mnt)
-{
-	struct audit_aux_data_path *ax;
-	struct audit_context *context = current->audit_context;
-
-	if (likely(!context))
-		return 0;
-
-	ax = kmalloc(sizeof(*ax), GFP_ATOMIC);
-	if (!ax)
-		return -ENOMEM;
-
-	ax->dentry = dget(dentry);
-	ax->mnt = mntget(mnt);
-
-	ax->d.type = AUDIT_AVC_PATH;
-	ax->d.next = context->aux;
-	context->aux = (void *)ax;
-	return 0;
-}
-
-/**
  * audit_signal_info - record signal info for shutting down audit subsystem
  * @sig: signal value
  * @t: task being signaled
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index e4396a8..2f4c2bb 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -570,10 +570,12 @@ void avc_audit(u32 ssid, u32 tsid,
 		case AVC_AUDIT_DATA_FS:
 			if (a->u.fs.dentry) {
 				struct dentry *dentry = a->u.fs.dentry;
-				if (a->u.fs.mnt)
-					audit_avc_path(dentry, a->u.fs.mnt);
-				audit_log_format(ab, " name=");
-				audit_log_untrustedstring(ab, dentry->d_name.name);
+				if (a->u.fs.mnt) {
+					audit_log_d_path(ab, "path=", dentry, a->u.fs.mnt);
+				} else {
+					audit_log_format(ab, " name=");
+					audit_log_untrustedstring(ab, dentry->d_name.name);
+				}
 				inode = dentry->d_inode;
 			} else if (a->u.fs.inode) {
 				struct dentry *dentry;
@@ -624,9 +626,8 @@ void avc_audit(u32 ssid, u32 tsid,
 				case AF_UNIX:
 					u = unix_sk(sk);
 					if (u->dentry) {
-						audit_avc_path(u->dentry, u->mnt);
-						audit_log_format(ab, " name=");
-						audit_log_untrustedstring(ab, u->dentry->d_name.name);
+						audit_log_d_path(ab, "path=",
+								 u->dentry, u->mnt);
 						break;
 					}
 					if (!u->addr)

--
Linux-audit mailing list
Linux-audit@redhat.com
https://www.redhat.com/mailman/listinfo/linux-audit

-------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
