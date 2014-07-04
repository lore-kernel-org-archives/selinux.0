Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s64KFCln022319
 for <selinux@tycho.nsa.gov>; Fri, 4 Jul 2014 16:15:12 -0400
Message-ID: <53B70B4B.8090909@schaufler-ca.com>
Date: Fri, 04 Jul 2014 13:15:07 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: LSM <linux-security-module@vger.kernel.org>,
 Paul Moore <paul@paul-moore.com>
Subject: [PATCH] LSM: Generalize existing module stacking
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 SE Linux <selinux@tycho.nsa.gov>, Kees Cook <keescook@chromium.org>,
 Eric Paris <eparis@redhat.com>, John Johansen <john.johansen@canonical.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Subject: [PATCH] LSM: Generalize existing module stacking

There are currently two different mechanisms used to
stack security modules. The capability module is set
up as the "default" module. The other modules that
replace it call the functions it contains directly.
The Yama module is stacked using ifdefs in the security
infrastructure.

This patch changes the existing module stacking so that
all stacking gets done the same way. There is no
"default" module, instead there is a list of modules
for each hook. The capability module is now on the
list first. If Yama stacking is configured, that is
added to the list next. Finally, if another module is
configured it gets added to the lists. The capability
calls duplicated within existing LSMs have been
removed. Not all capability calls in other modules can
be treated this way, and the individual cases are
noted.

The next change was motivated by a discussion I had
with Linus about LSM performance. We can get significant
performance improvement if we put the LSM inode data
into the inode rather than maintaining a pointer to
data that is allocated and freed separately. Rather
than having an i_security entry there is now a structure
for each LSM that needs one, i_selinux and i_smack for
the time being. That turned out to make the upcoming
general stacking so much simpler that it is done for
each of the cred, file and other structures, although
those are still just pointers at this stage.

The downside is that there are more LSM configuration
ifdefs in header files. There are tricks that could
be used to reduce them, but they really make the code
ugly. Uglier than the ifdefs, by quite a margin. If you
configure LSMs that you're not using, the structures
get slightly bigger. That is more than offset by the
performance improvement gained by the inode change.

This is the first in a series for generalized LSM stacking.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

---

 fs/nfs/inode.c                      |   14 +-
 include/linux/cred.h                |   26 +-
 include/linux/fs.h                  |   30 +-
 include/linux/ipc.h                 |    7 +-
 include/linux/key.h                 |    7 +-
 include/linux/msg.h                 |    7 +-
 include/linux/security.h            |   33 +-
 include/linux/selinux.h             |   16 +
 include/linux/smack.h               |   32 +
 include/net/sock.h                  |    7 +-
 ipc/msg.c                           |    1 -
 ipc/msgutil.c                       |    1 -
 ipc/sem.c                           |    1 -
 ipc/shm.c                           |    1 -
 kernel/cred.c                       |   57 +-
 net/core/sock.c                     |   14 +-
 security/Makefile                   |    2 +-
 security/apparmor/domain.c          |    4 +-
 security/apparmor/include/context.h |    4 +-
 security/apparmor/lsm.c             |   32 +-
 security/commoncap.c                |   34 +
 security/security.c                 | 1590 +++++++++++++++++++++++++++++------
 security/selinux/hooks.c            |  406 ++++-----
 security/selinux/include/objsec.h   |   13 -
 security/selinux/netlabel.c         |   14 +-
 security/selinux/selinuxfs.c        |   10 +-
 security/selinux/ss/services.c      |    2 +-
 security/selinux/xfrm.c             |    4 +-
 security/smack/smack.h              |   24 +-
 security/smack/smack_access.c       |    2 +-
 security/smack/smack_lsm.c          |  258 +++---
 security/smack/smackfs.c            |   14 +-
 security/tomoyo/common.h            |    4 +-
 security/tomoyo/domain.c            |    2 +-
 security/tomoyo/gc.c                |    4 +-
 security/tomoyo/securityfs_if.c     |    6 +-
 security/tomoyo/tomoyo.c            |   26 +-
 security/yama/yama_lsm.c            |   36 +-
 38 files changed, 1918 insertions(+), 827 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 0c43897..280b5e1 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -276,11 +276,23 @@ void nfs_setsecurity(struct inode *inode, struct nfs_fattr *fattr,
 					struct nfs4_label *label)
 {
 	int error;
+	int has_label = 0;
 
 	if (label == NULL)
 		return;
 
-	if ((fattr->valid & NFS_ATTR_FATTR_V4_SECURITY_LABEL) && inode->i_security) {
+#ifdef CONFIG_SECURITY_SELINUX
+	/*
+	 * As of this writing the only LSM known to work with
+	 * labeled NFS is SELinux.
+	 *
+	 * This should probably be
+	 * has_label = security_inode_hasmaclabel(inode); 
+	 */
+	has_label = (inode->i_selinux.sid != 0);
+#endif
+
+	if ((fattr->valid & NFS_ATTR_FATTR_V4_SECURITY_LABEL) && has_label) {
 		error = security_inode_notifysecctx(inode, label->label,
 				label->len);
 		if (error)
diff --git a/include/linux/cred.h b/include/linux/cred.h
index f61d6c8..8320bd3 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -129,8 +129,17 @@ struct cred {
 	struct key	*thread_keyring; /* keyring private to this thread */
 	struct key	*request_key_auth; /* assumed request_key authority */
 #endif
-#ifdef CONFIG_SECURITY
-	void		*security;	/* subjective LSM security */
+#ifdef CONFIG_SECURITY_SELINUX
+	void		*cred_selinux;	/* subjective security for SELinux */
+#endif
+#ifdef CONFIG_SECURITY_SMACK
+	void		*cred_smack;	/* subjective security for Smack */
+#endif
+#ifdef CONFIG_SECURITY_TOMOYO
+	void		*cred_tomoyo;	/* subjective security for TOMOYO */
+#endif
+#ifdef CONFIG_SECURITY_APPARMOR
+	void		*cred_apparmor;	/* subjective security for AppArmor */
 #endif
 	struct user_struct *user;	/* real user ID subscription */
 	struct user_namespace *user_ns; /* user_ns the caps and keyrings are relative to. */
@@ -338,7 +347,18 @@ static inline void put_cred(const struct cred *_cred)
 #define current_fsgid() 	(current_cred_xxx(fsgid))
 #define current_cap()		(current_cred_xxx(cap_effective))
 #define current_user()		(current_cred_xxx(user))
-#define current_security()	(current_cred_xxx(security))
+#ifdef CONFIG_SECURITY_SELINUX
+#define current_selinux()	(current_cred_xxx(cred_selinux))
+#endif
+#ifdef CONFIG_SECURITY_SMACK
+#define current_smack()		(current_cred_xxx(cred_smack))
+#endif
+#ifdef CONFIG_SECURITY_TOMOYO
+#define current_tomoyo()	(current_cred_xxx(cred_tomoyo))
+#endif
+#ifdef CONFIG_SECURITY_APPARMOR
+#define current_apparmor()	(current_cred_xxx(cred_apparmor))
+#endif
 
 extern struct user_namespace init_user_ns;
 #ifdef CONFIG_USER_NS
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8780312..b8ffefd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -29,6 +29,12 @@
 #include <linux/lockdep.h>
 #include <linux/percpu-rwsem.h>
 #include <linux/blk_types.h>
+#ifdef CONFIG_SECURITY_SELINUX
+#include <linux/selinux.h>
+#endif
+#ifdef CONFIG_SECURITY_SMACK
+#include <linux/smack.h>
+#endif
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -512,8 +518,11 @@ struct inode {
 	struct super_block	*i_sb;
 	struct address_space	*i_mapping;
 
-#ifdef CONFIG_SECURITY
-	void			*i_security;
+#ifdef CONFIG_SECURITY_SELINUX
+	struct inode_selinux	i_selinux;
+#endif
+#ifdef CONFIG_SECURITY_SMACK
+	struct inode_smack	i_smack;
 #endif
 
 	/* Stat data, not accessed from path walking */
@@ -766,8 +775,14 @@ struct file {
 	struct file_ra_state	f_ra;
 
 	u64			f_version;
-#ifdef CONFIG_SECURITY
-	void			*f_security;
+#ifdef CONFIG_SECURITY_SELINUX
+	void			*f_selinux;
+#endif
+#ifdef CONFIG_SECURITY_SMACK
+	void			*f_smack;
+#endif
+#ifdef CONFIG_SECURITY_APPARMOR
+	void			*f_apparmor;
 #endif
 	/* needed for tty driver, and maybe others */
 	void			*private_data;
@@ -1186,8 +1201,11 @@ struct super_block {
 	struct rw_semaphore	s_umount;
 	int			s_count;
 	atomic_t		s_active;
-#ifdef CONFIG_SECURITY
-	void                    *s_security;
+#ifdef CONFIG_SECURITY_SELINUX
+	void			*s_selinux;
+#endif
+#ifdef CONFIG_SECURITY_SMACK
+	void			*s_smack;
 #endif
 	const struct xattr_handler **s_xattr;
 
diff --git a/include/linux/ipc.h b/include/linux/ipc.h
index 9d84942..c6a0db2 100644
--- a/include/linux/ipc.h
+++ b/include/linux/ipc.h
@@ -20,7 +20,12 @@ struct kern_ipc_perm
 	kgid_t		cgid;
 	umode_t		mode; 
 	unsigned long	seq;
-	void		*security;
+#ifdef CONFIG_SECURITY_SELINUX
+	void		*kip_selinux;
+#endif
+#ifdef CONFIG_SECURITY_SMACK
+	void		*kip_smack;
+#endif
 };
 
 #endif /* _LINUX_IPC_H */
diff --git a/include/linux/key.h b/include/linux/key.h
index 80d6774..08403a3 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -138,7 +138,12 @@ struct key {
 	};
 	struct rw_semaphore	sem;		/* change vs change sem */
 	struct key_user		*user;		/* owner of this key */
-	void			*security;	/* security data for this key */
+#ifdef CONFIG_SECURITY_SELINUX
+	void			*key_selinux;	/* SELinux data for this key */
+#endif
+#ifdef CONFIG_SECURITY_SMACK
+	void			*key_smack;	/* Smack data for this key */
+#endif
 	union {
 		time_t		expiry;		/* time at which key expires (or 0) */
 		time_t		revoked_at;	/* time at which key was revoked */
diff --git a/include/linux/msg.h b/include/linux/msg.h
index f3f302f..56f4851 100644
--- a/include/linux/msg.h
+++ b/include/linux/msg.h
@@ -10,7 +10,12 @@ struct msg_msg {
 	long m_type;
 	size_t m_ts;		/* message text size */
 	struct msg_msgseg *next;
-	void *security;
+#ifdef CONFIG_SECURITY_SELINUX
+	void *msg_selinux;
+#endif
+#ifdef CONFIG_SECURITY_SMACK
+	void *msg_smack;
+#endif
 	/* the actual message follows immediately */
 };
 
diff --git a/include/linux/security.h b/include/linux/security.h
index 6478ce3..04a1a04 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -101,6 +101,8 @@ extern int cap_task_setioprio(struct task_struct *p, int ioprio);
 extern int cap_task_setnice(struct task_struct *p, int nice);
 extern int cap_vm_enough_memory(struct mm_struct *mm, long pages);
 
+extern struct security_operations capability_ops;
+
 struct msghdr;
 struct sk_buff;
 struct sock;
@@ -116,7 +118,9 @@ struct seq_file;
 
 extern int cap_netlink_send(struct sock *sk, struct sk_buff *skb);
 
-void reset_security_ops(void);
+#ifdef CONFIG_SECURITY_SELINUX_DISABLE
+void security_module_disable(struct security_operations *);
+#endif
 
 #ifdef CONFIG_MMU
 extern unsigned long mmap_min_addr;
@@ -246,13 +250,11 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
  * Security hooks for filesystem operations.
  *
  * @sb_alloc_security:
- *	Allocate and attach a security structure to the sb->s_security field.
- *	The s_security field is initialized to NULL when the structure is
- *	allocated.
+ *	Allocate and attach a security structure to the sb.
  *	@sb contains the super_block structure to be modified.
  *	Return 0 if operation was successful.
  * @sb_free_security:
- *	Deallocate and clear the sb->s_security field.
+ *	Deallocate and clear the sb security field(s).
  *	@sb contains the super_block structure to be modified.
  * @sb_statfs:
  *	Check permission before obtaining filesystem statistics for the @mnt
@@ -323,15 +325,12 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
  * Security hooks for inode operations.
  *
  * @inode_alloc_security:
- *	Allocate and attach a security structure to @inode->i_security.  The
- *	i_security field is initialized to NULL when the inode structure is
- *	allocated.
+ *	Allocate and attach a security structure to @inode.
  *	@inode contains the inode structure.
  *	Return 0 if operation was successful.
  * @inode_free_security:
  *	@inode contains the inode structure.
- *	Deallocate the inode security structure and set @inode->i_security to
- *	NULL.
+ *	Deallocate the inode security structure(s).
  * @inode_init_security:
  *	Obtain the security attribute name suffix and value to set on a newly
  *	created inode and set up the incore security field for the new inode.
@@ -636,8 +635,8 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
  *	@arg contains the operational arguments.
  *	Return 0 if permission is granted.
  * @file_set_fowner:
- *	Save owner security information (typically from current->security) in
- *	file->f_security for later use by the send_sigiotask hook.
+ *	Save owner security information in
+ *	file for later use by the send_sigiotask hook.
  *	@file contains the file structure to update.
  *	Return 0 on success.
  * @file_send_sigiotask:
@@ -679,7 +678,7 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
  *	cred_transfer() will not get ENOMEM.
  * @cred_free:
  *	@cred points to the credentials.
- *	Deallocate and clear the cred->security field in a set of credentials.
+ *	Deallocate and clear the cred field(s) in a set of credentials.
  * @cred_prepare:
  *	@new points to the new credentials.
  *	@old points to the original credentials.
@@ -867,8 +866,8 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
  *	socket structure, but rather, the socket security information is stored
  *	in the associated inode.  Typically, the inode alloc_security hook will
  *	allocate and and attach security information to
- *	sock->inode->i_security.  This hook may be used to update the
- *	sock->inode->i_security field with additional information that wasn't
+ *	sock->inode.  This hook may be used to update the
+ *	sock->inode with additional information that wasn't
  *	available when the inode was allocated.
  *	@sock contains the newly created socket structure.
  *	@family contains the requested protocol family.
@@ -977,7 +976,7 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
  *	@seclen is the maximum length for @secdata
  *	Return 0 on success, error on failure.
  * @sk_alloc_security:
- *	Allocate and attach a security structure to the sk->sk_security field,
+ *	Allocate and attach a security structure to the sk,
  *	which is used to copy security attributes between local stream sockets.
  * @sk_free_security:
  *	Deallocate security structure.
@@ -1147,7 +1146,7 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
  *
  * Security hooks for individual messages held in System V IPC message queues
  * @msg_msg_alloc_security:
- *	Allocate and attach a security structure to the msg->security field.
+ *	Allocate and attach a security structure to the msg.
  *	The security field is initialized to NULL when the structure is first
  *	created.
  *	@msg contains the message structure to be modified.
diff --git a/include/linux/selinux.h b/include/linux/selinux.h
index 44f4596..9114692 100644
--- a/include/linux/selinux.h
+++ b/include/linux/selinux.h
@@ -19,6 +19,22 @@ struct audit_context;
 struct kern_ipc_perm;
 
 #ifdef CONFIG_SECURITY_SELINUX
+#include <linux/list.h>
+#include <linux/mutex.h>
+
+struct inode;
+
+struct inode_selinux {
+	union {
+		struct list_head list;	/* list of inode_security_struct */
+		struct rcu_head rcu;	/* for freeing the inode_security_struct */
+	};
+	u32 task_sid;			/* SID of creating task */
+	u32 sid;			/* SID of this object */
+	u16 sclass;			/* security class of this object */
+	unsigned char initialized;	/* initialization flag */
+	struct mutex lock;
+};
 
 /**
  * selinux_is_enabled - is SELinux enabled?
diff --git a/include/linux/smack.h b/include/linux/smack.h
new file mode 100644
index 0000000..0233da5
--- /dev/null
+++ b/include/linux/smack.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright (C) 2014 Casey Schaufler <casey@schaufler-ca.com>
+ * Copyright (C) 2014 Intel Corporation.
+ *
+ *      This program is free software; you can redistribute it and/or modify
+ *      it under the terms of the GNU General Public License as published by
+ *      the Free Software Foundation, version 2.
+ *
+ * Author:
+ *      Casey Schaufler <casey@schaufler-ca.com>
+ *
+ */
+
+#ifndef _LINUX_SMACK_H
+#define _LINUX_SMACK_H
+
+#include <linux/mutex.h>
+
+struct smack_known;
+
+/*
+ * Inode Smack data
+ */
+struct inode_smack {
+	char 			*smk_inode;	/* label of the fso */
+	struct smack_known	*smk_task;	/* label of the task */
+	struct smack_known	*smk_mmap;	/* label of the mmap domain */
+	struct mutex		smk_lock;	/* initialization lock */
+	int			smk_flags;	/* smack inode flags */
+};
+
+#endif /* _LINUX_SMACK_H */
diff --git a/include/net/sock.h b/include/net/sock.h
index 21569cf..993e136 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -411,8 +411,11 @@ struct sock {
 	struct sk_buff		*sk_send_head;
 	__s32			sk_peek_off;
 	int			sk_write_pending;
-#ifdef CONFIG_SECURITY
-	void			*sk_security;
+#ifdef CONFIG_SECURITY_SELINUX
+	void			*sk_selinux;
+#endif
+#ifdef CONFIG_SECURITY_SMACK
+	void			*sk_smack;
 #endif
 	__u32			sk_mark;
 	u32			sk_classid;
diff --git a/ipc/msg.c b/ipc/msg.c
index 6498531..9b7fa31 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -195,7 +195,6 @@ static int newque(struct ipc_namespace *ns, struct ipc_params *params)
 	msq->q_perm.mode = msgflg & S_IRWXUGO;
 	msq->q_perm.key = key;
 
-	msq->q_perm.security = NULL;
 	retval = security_msg_queue_alloc(msq);
 	if (retval) {
 		ipc_rcu_putref(msq, ipc_rcu_free);
diff --git a/ipc/msgutil.c b/ipc/msgutil.c
index 7e70959..7ead17e 100644
--- a/ipc/msgutil.c
+++ b/ipc/msgutil.c
@@ -57,7 +57,6 @@ static struct msg_msg *alloc_msg(size_t len)
 		return NULL;
 
 	msg->next = NULL;
-	msg->security = NULL;
 
 	len -= alen;
 	pseg = &msg->next;
diff --git a/ipc/sem.c b/ipc/sem.c
index bee5554..3c4ffbe 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -500,7 +500,6 @@ static int newary(struct ipc_namespace *ns, struct ipc_params *params)
 	sma->sem_perm.mode = (semflg & S_IRWXUGO);
 	sma->sem_perm.key = key;
 
-	sma->sem_perm.security = NULL;
 	retval = security_sem_alloc(sma);
 	if (retval) {
 		ipc_rcu_putref(sma, ipc_rcu_free);
diff --git a/ipc/shm.c b/ipc/shm.c
index 7645961..24f7609 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -504,7 +504,6 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 	shp->shm_perm.mode = (shmflg & S_IRWXUGO);
 	shp->mlock_user = NULL;
 
-	shp->shm_perm.security = NULL;
 	error = security_shm_alloc(shp);
 	if (error) {
 		ipc_rcu_putref(shp, ipc_rcu_free);
diff --git a/kernel/cred.c b/kernel/cred.c
index e0573a4..2745ae0 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -262,8 +262,17 @@ struct cred *prepare_creds(void)
 	key_get(new->request_key_auth);
 #endif
 
-#ifdef CONFIG_SECURITY
-	new->security = NULL;
+#ifdef CONFIG_SECURITY_SELINUX
+	new->cred_selinux = NULL;
+#endif
+#ifdef CONFIG_SECURITY_SMACK
+	new->cred_smack = NULL;
+#endif
+#ifdef CONFIG_SECURITY_TOMOYO
+	new->cred_tomoyo = NULL;
+#endif
+#ifdef CONFIG_SECURITY_APPARMOR
+	new->cred_apparmor = NULL;
 #endif
 
 	if (security_prepare_creds(new, old, GFP_KERNEL) < 0)
@@ -616,8 +625,17 @@ struct cred *prepare_kernel_cred(struct task_struct *daemon)
 	new->jit_keyring = KEY_REQKEY_DEFL_THREAD_KEYRING;
 #endif
 
-#ifdef CONFIG_SECURITY
-	new->security = NULL;
+#ifdef CONFIG_SECURITY_SELINUX
+	new->cred_selinux = NULL;
+#endif
+#ifdef CONFIG_SECURITY_SMACK
+	new->cred_smack = NULL;
+#endif
+#ifdef CONFIG_SECURITY_TOMOYO
+	new->cred_tomoyo = NULL;
+#endif
+#ifdef CONFIG_SECURITY_APPARMOR
+	new->cred_apparmor = NULL;
 #endif
 	if (security_prepare_creds(new, old, GFP_KERNEL) < 0)
 		goto error;
@@ -695,13 +713,13 @@ bool creds_are_invalid(const struct cred *cred)
 		return true;
 #ifdef CONFIG_SECURITY_SELINUX
 	/*
-	 * cred->security == NULL if security_cred_alloc_blank() or
+	 * cred->cred_selinux == NULL if security_cred_alloc_blank() or
 	 * security_prepare_creds() returned an error.
 	 */
-	if (selinux_is_enabled() && cred->security) {
-		if ((unsigned long) cred->security < PAGE_SIZE)
+	if (selinux_is_enabled() && cred->cred_selinux) {
+		if ((unsigned long) cred->cred_selinux < PAGE_SIZE)
 			return true;
-		if ((*(u32 *)cred->security & 0xffffff00) ==
+		if ((*(u32 *)cred->cred_selinux & 0xffffff00) ==
 		    (POISON_FREE << 24 | POISON_FREE << 16 | POISON_FREE << 8))
 			return true;
 	}
@@ -736,14 +754,23 @@ static void dump_invalid_creds(const struct cred *cred, const char *label,
 		from_kgid_munged(&init_user_ns, cred->egid),
 		from_kgid_munged(&init_user_ns, cred->sgid),
 		from_kgid_munged(&init_user_ns, cred->fsgid));
-#ifdef CONFIG_SECURITY
-	printk(KERN_ERR "CRED: ->security is %p\n", cred->security);
-	if ((unsigned long) cred->security >= PAGE_SIZE &&
-	    (((unsigned long) cred->security & 0xffffff00) !=
+#ifdef CONFIG_SECURITY_SELINUX
+	printk(KERN_ERR "CRED: ->cred_selinux is %p\n", cred->cred_selinux);
+	if ((unsigned long) cred->cred_selinux >= PAGE_SIZE &&
+	    (((unsigned long) cred->cred_selinux & 0xffffff00) !=
 	     (POISON_FREE << 24 | POISON_FREE << 16 | POISON_FREE << 8)))
-		printk(KERN_ERR "CRED: ->security {%x, %x}\n",
-		       ((u32*)cred->security)[0],
-		       ((u32*)cred->security)[1]);
+		printk(KERN_ERR "CRED: ->cred_selinux {%x, %x}\n",
+		       ((u32*)cred->cred_selinux)[0],
+		       ((u32*)cred->cred_selinux)[1]);
+#endif
+#ifdef CONFIG_SECURITY_SMACK
+	printk(KERN_ERR "CRED: ->cred_smack is %p\n", cred->cred_smack);
+#endif
+#ifdef CONFIG_SECURITY_TOMOYO
+	printk(KERN_ERR "CRED: ->cred_tomoyo is %p\n", cred->cred_tomoyo);
+#endif
+#ifdef CONFIG_SECURITY_APPARMOR
+	printk(KERN_ERR "CRED: ->cred_apparmor is %p\n", cred->cred_apparmor);
 #endif
 }
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 664ee42..66d9431 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1270,7 +1270,12 @@ static inline void sock_lock_init(struct sock *sk)
 static void sock_copy(struct sock *nsk, const struct sock *osk)
 {
 #ifdef CONFIG_SECURITY_NETWORK
-	void *sptr = nsk->sk_security;
+#ifdef CONFIG_SECURITY_SELINUX
+	void *selinux = nsk->sk_selinux;
+#endif
+#ifdef CONFIG_SECURITY_SMACK
+	void *smack = nsk->sk_smack;
+#endif
 #endif
 	memcpy(nsk, osk, offsetof(struct sock, sk_dontcopy_begin));
 
@@ -1278,7 +1283,12 @@ static void sock_copy(struct sock *nsk, const struct sock *osk)
 	       osk->sk_prot->obj_size - offsetof(struct sock, sk_dontcopy_end));
 
 #ifdef CONFIG_SECURITY_NETWORK
-	nsk->sk_security = sptr;
+#ifdef CONFIG_SECURITY_SELINUX
+	nsk->sk_selinux = selinux;
+#endif
+#ifdef CONFIG_SECURITY_SMACK
+	nsk->sk_smack = smack;
+#endif
 	security_sk_clone(osk, nsk);
 #endif
 }
diff --git a/security/Makefile b/security/Makefile
index 05f1c93..c9bfbc8 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -14,7 +14,7 @@ obj-y					+= commoncap.o
 obj-$(CONFIG_MMU)			+= min_addr.o
 
 # Object file lists
-obj-$(CONFIG_SECURITY)			+= security.o capability.o
+obj-$(CONFIG_SECURITY)			+= security.o
 obj-$(CONFIG_SECURITYFS)		+= inode.o
 obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/
 obj-$(CONFIG_SECURITY_SMACK)		+= smack/
diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 452567d..38aefc0 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -347,9 +347,7 @@ int apparmor_bprm_set_creds(struct linux_binprm *bprm)
 		file_inode(bprm->file)->i_mode
 	};
 	const char *name = NULL, *target = NULL, *info = NULL;
-	int error = cap_bprm_set_creds(bprm);
-	if (error)
-		return error;
+	int error = 0;
 
 	if (bprm->cred_prepared)
 		return 0;
diff --git a/security/apparmor/include/context.h b/security/apparmor/include/context.h
index 6bf6579..61a2ad5 100644
--- a/security/apparmor/include/context.h
+++ b/security/apparmor/include/context.h
@@ -21,13 +21,13 @@
 
 #include "policy.h"
 
-#define cred_cxt(X) (X)->security
+#define cred_cxt(X) (X)->cred_apparmor
 #define current_cxt() cred_cxt(current_cred())
 
 /* struct aa_file_cxt - the AppArmor context the file was opened in
  * @perms: the permission the file was opened with
  *
- * The file_cxt could currently be directly stored in file->f_security
+ * The file_cxt could currently be directly stored in file->f_apparmor
  * as the profile reference is now stored in the f_cred.  However the
  * cxt struct will expand in the future so we keep the struct.
  */
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 9981000..b0dc9e8 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -96,19 +96,11 @@ static void apparmor_cred_transfer(struct cred *new, const struct cred *old)
 static int apparmor_ptrace_access_check(struct task_struct *child,
 					unsigned int mode)
 {
-	int error = cap_ptrace_access_check(child, mode);
-	if (error)
-		return error;
-
 	return aa_ptrace(current, child, mode);
 }
 
 static int apparmor_ptrace_traceme(struct task_struct *parent)
 {
-	int error = cap_ptrace_traceme(parent);
-	if (error)
-		return error;
-
 	return aa_ptrace(parent, current, PTRACE_MODE_ATTACH);
 }
 
@@ -140,13 +132,11 @@ static int apparmor_capable(const struct cred *cred, struct user_namespace *ns,
 			    int cap, int audit)
 {
 	struct aa_profile *profile;
-	/* cap_capable returns 0 on success, else -EPERM */
-	int error = cap_capable(cred, ns, cap, audit);
-	if (!error) {
-		profile = aa_cred_profile(cred);
-		if (!unconfined(profile))
-			error = aa_capable(profile, cap, audit);
-	}
+	int error = 0;
+
+	profile = aa_cred_profile(cred);
+	if (!unconfined(profile))
+		error = aa_capable(profile, cap, audit);
 	return error;
 }
 
@@ -375,7 +365,7 @@ static int apparmor_inode_getattr(struct vfsmount *mnt, struct dentry *dentry)
 
 static int apparmor_file_open(struct file *file, const struct cred *cred)
 {
-	struct aa_file_cxt *fcxt = file->f_security;
+	struct aa_file_cxt *fcxt = file->f_apparmor;
 	struct aa_profile *profile;
 	int error = 0;
 
@@ -409,8 +399,8 @@ static int apparmor_file_open(struct file *file, const struct cred *cred)
 static int apparmor_file_alloc_security(struct file *file)
 {
 	/* freed by apparmor_file_free_security */
-	file->f_security = aa_alloc_file_context(GFP_KERNEL);
-	if (!file->f_security)
+	file->f_apparmor = aa_alloc_file_context(GFP_KERNEL);
+	if (!file->f_apparmor)
 		return -ENOMEM;
 	return 0;
 
@@ -418,14 +408,14 @@ static int apparmor_file_alloc_security(struct file *file)
 
 static void apparmor_file_free_security(struct file *file)
 {
-	struct aa_file_cxt *cxt = file->f_security;
+	struct aa_file_cxt *cxt = file->f_apparmor;
 
 	aa_free_file_context(cxt);
 }
 
 static int common_file_perm(int op, struct file *file, u32 mask)
 {
-	struct aa_file_cxt *fcxt = file->f_security;
+	struct aa_file_cxt *fcxt = file->f_apparmor;
 	struct aa_profile *profile, *fprofile = aa_cred_profile(file->f_cred);
 	int error = 0;
 
@@ -471,7 +461,7 @@ static int common_mmap(int op, struct file *file, unsigned long prot,
 {
 	int mask = 0;
 
-	if (!file || !file->f_security)
+	if (!file || !file->f_apparmor)
 		return 0;
 
 	if (prot & PROT_READ)
diff --git a/security/commoncap.c b/security/commoncap.c
index b9d613e..1cfc27c 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -994,3 +994,37 @@ int cap_mmap_file(struct file *file, unsigned long reqprot,
 {
 	return 0;
 }
+
+#ifdef CONFIG_SECURITY
+
+struct security_operations capability_ops = {
+	.name =			"capability",
+	.capable =		cap_capable,
+	.settime =		cap_settime,
+	.ptrace_access_check =	cap_ptrace_access_check,
+	.ptrace_traceme =	cap_ptrace_traceme,
+	.capget =		cap_capget,
+	.capset =		cap_capset,
+	.bprm_set_creds =	cap_bprm_set_creds,
+	/*
+	 * Not stacked in the usual way.
+	 * .bprm_secureexec =	cap_bprm_secureexec,
+	 * .inode_setxattr =	cap_inode_setxattr,
+	 * .inode_removexattr =	cap_inode_removexattr,
+	 */
+	.inode_need_killpriv =	cap_inode_need_killpriv,
+	.inode_killpriv =	cap_inode_killpriv,
+	/*
+	 * Not stacked in the usual way.
+	 * .mmap_addr =		cap_mmap_addr,
+	 */
+	.mmap_file =		cap_mmap_file,
+	.task_fix_setuid =	cap_task_fix_setuid,
+	.task_prctl =		cap_task_prctl,
+	.task_setscheduler =	cap_task_setscheduler,
+	.task_setioprio =	cap_task_setioprio,
+	.task_setnice =		cap_task_setnice,
+	.vm_enough_memory =	cap_vm_enough_memory,
+};
+
+#endif /* CONFIG_SECURITY */
diff --git a/security/security.c b/security/security.c
index 8b774f3..5b37c36 100644
--- a/security/security.c
+++ b/security/security.c
@@ -25,28 +25,20 @@
 #include <linux/mount.h>
 #include <linux/personality.h>
 #include <linux/backing-dev.h>
+#include <linux/list.h>
 #include <net/flow.h>
 
+struct security_hook_list {
+	struct list_head		shl_head;
+	struct security_operations	*shl_ops;
+};
+
 #define MAX_LSM_EVM_XATTR	2
 
 /* Boot-time LSM user choice */
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 	CONFIG_DEFAULT_SECURITY;
 
-static struct security_operations *security_ops;
-static struct security_operations default_security_ops = {
-	.name	= "default",
-};
-
-static inline int __init verify(struct security_operations *ops)
-{
-	/* verify the security_operations structure exists */
-	if (!ops)
-		return -EINVAL;
-	security_fixup_ops(ops);
-	return 0;
-}
-
 static void __init do_security_initcalls(void)
 {
 	initcall_t *call;
@@ -57,6 +49,11 @@ static void __init do_security_initcalls(void)
 	}
 }
 
+static int __init security_enlist_ops(struct security_operations *sop);
+
+#ifdef CONFIG_SECURITY_YAMA_STACKED
+extern struct security_operations yama_ops;
+#endif
 /**
  * security_init - initializes the security framework
  *
@@ -64,20 +61,30 @@ static void __init do_security_initcalls(void)
  */
 int __init security_init(void)
 {
+	int rc;
+
 	printk(KERN_INFO "Security Framework initialized\n");
 
-	security_fixup_ops(&default_security_ops);
-	security_ops = &default_security_ops;
+	/*
+	 * Always load the capability module.
+	 */
+	rc = security_enlist_ops(&capability_ops);
+	if (rc)
+		return rc;
+#ifdef CONFIG_SECURITY_YAMA_STACKED
+	rc = security_enlist_ops(&yama_ops);
+	if (rc)
+		return rc;
+#endif
+	/*
+	 * Load the chosen module if there is one.
+	 * This will also find yama if it is stacking
+	 */
 	do_security_initcalls();
 
 	return 0;
 }
 
-void reset_security_ops(void)
-{
-	security_ops = &default_security_ops;
-}
-
 /* Save user chosen LSM */
 static int __init choose_lsm(char *str)
 {
@@ -119,224 +126,341 @@ int __init security_module_enable(struct security_operations *ops)
  */
 int __init register_security(struct security_operations *ops)
 {
-	if (verify(ops)) {
+	/*
+	 * Verify the security_operations structure exists
+	 */
+	if (!ops) {
 		printk(KERN_DEBUG "%s could not verify "
 		       "security_operations structure.\n", __func__);
 		return -EINVAL;
 	}
 
-	if (security_ops != &default_security_ops)
-		return -EAGAIN;
+	return security_enlist_ops(ops);
+}
 
-	security_ops = ops;
+/*
+ * Hook list operation macros.
+ *
+ * call_void_hook:
+ *	This is a hook that does not return a value.
+ *
+ * call_int_hook:
+ *	This is a hook that returns a value.
+ *	Stop on the first failure.
+ */
 
-	return 0;
-}
+#ifdef CONFIG_SECURITY_SELINUX_DISABLE
+
+#define call_void_hook(FUNC, ...)					\
+	do {								\
+		struct security_hook_list *P;				\
+									\
+		if (hooks_##FUNC.next == NULL)				\
+			break;						\
+		if (list_empty(&hooks_##FUNC))				\
+			break;						\
+									\
+		list_for_each_entry(P, &hooks_##FUNC, shl_head) {	\
+			if (P->shl_ops == NULL)			\
+				continue;				\
+			P->shl_ops->FUNC(__VA_ARGS__);			\
+		}							\
+	} while (0)							\
+
+#define call_int_hook(FUNC, ...) ({					\
+	int RC = 0;							\
+	do {								\
+		struct security_hook_list *P;				\
+									\
+		if (hooks_##FUNC.next == NULL)				\
+			break;						\
+		if (list_empty(&hooks_##FUNC))				\
+			break;						\
+									\
+		list_for_each_entry(P, &hooks_##FUNC, shl_head) {	\
+			if (P->shl_ops == NULL)			\
+				continue;				\
+			RC = P->shl_ops->FUNC(__VA_ARGS__);		\
+			if (RC != 0)					\
+				break;					\
+		}							\
+	} while (0);							\
+	RC;								\
+})									\
+
+#else /* CONFIG_SECURITY_SELINUX_DISABLE */
+
+#define call_void_hook(FUNC, ...)					\
+	do {								\
+		struct security_hook_list *P;				\
+									\
+		if (list_empty(&hooks_##FUNC))				\
+			break;						\
+									\
+		list_for_each_entry(P, &hooks_##FUNC, shl_head)		\
+			P->shl_ops->FUNC(__VA_ARGS__);			\
+	} while (0)							\
+
+#define call_int_hook(FUNC, ...) ({					\
+	int RC = 0;							\
+	do {								\
+		struct security_hook_list *P;				\
+									\
+		if (list_empty(&hooks_##FUNC))				\
+			break;						\
+									\
+		list_for_each_entry(P, &hooks_##FUNC, shl_head) {	\
+			RC = P->shl_ops->FUNC(__VA_ARGS__);		\
+			if (RC != 0)					\
+				break;					\
+		}							\
+	} while (0);							\
+	RC;								\
+})									\
+
+#endif /* CONFIG_SECURITY_SELINUX_DISABLE */
 
 /* Security operations */
 
+static struct list_head hooks_ptrace_access_check;
 int security_ptrace_access_check(struct task_struct *child, unsigned int mode)
 {
-#ifdef CONFIG_SECURITY_YAMA_STACKED
-	int rc;
-	rc = yama_ptrace_access_check(child, mode);
-	if (rc)
-		return rc;
-#endif
-	return security_ops->ptrace_access_check(child, mode);
+	return call_int_hook(ptrace_access_check, child, mode);
 }
 
+static struct list_head hooks_ptrace_traceme;
 int security_ptrace_traceme(struct task_struct *parent)
 {
-#ifdef CONFIG_SECURITY_YAMA_STACKED
-	int rc;
-	rc = yama_ptrace_traceme(parent);
-	if (rc)
-		return rc;
-#endif
-	return security_ops->ptrace_traceme(parent);
+	return call_int_hook(ptrace_traceme, parent);
 }
 
+static struct list_head hooks_capget;
 int security_capget(struct task_struct *target,
 		     kernel_cap_t *effective,
 		     kernel_cap_t *inheritable,
 		     kernel_cap_t *permitted)
 {
-	return security_ops->capget(target, effective, inheritable, permitted);
+	return call_int_hook(capget, target, effective, inheritable, permitted);
 }
 
+static struct list_head hooks_capset;
 int security_capset(struct cred *new, const struct cred *old,
 		    const kernel_cap_t *effective,
 		    const kernel_cap_t *inheritable,
 		    const kernel_cap_t *permitted)
 {
-	return security_ops->capset(new, old,
+	return call_int_hook(capset, new, old,
 				    effective, inheritable, permitted);
 }
 
+static struct list_head hooks_capable;
 int security_capable(const struct cred *cred, struct user_namespace *ns,
 		     int cap)
 {
-	return security_ops->capable(cred, ns, cap, SECURITY_CAP_AUDIT);
+	return call_int_hook(capable, cred, ns, cap, SECURITY_CAP_AUDIT);
 }
 
+/*
+ * This is special because there is no capable_noaudit
+ * the the hooks list
+ */
 int security_capable_noaudit(const struct cred *cred, struct user_namespace *ns,
 			     int cap)
 {
-	return security_ops->capable(cred, ns, cap, SECURITY_CAP_NOAUDIT);
+	return call_int_hook(capable, cred, ns, cap, SECURITY_CAP_NOAUDIT);
 }
 
+static struct list_head hooks_quotactl;
 int security_quotactl(int cmds, int type, int id, struct super_block *sb)
 {
-	return security_ops->quotactl(cmds, type, id, sb);
+	return call_int_hook(quotactl, cmds, type, id, sb);
 }
 
+static struct list_head hooks_quota_on;
 int security_quota_on(struct dentry *dentry)
 {
-	return security_ops->quota_on(dentry);
+	return call_int_hook(quota_on, dentry);
 }
 
+static struct list_head hooks_syslog;
 int security_syslog(int type)
 {
-	return security_ops->syslog(type);
+	return call_int_hook(syslog, type);
 }
 
+static struct list_head hooks_settime;
 int security_settime(const struct timespec *ts, const struct timezone *tz)
 {
-	return security_ops->settime(ts, tz);
+	return call_int_hook(settime, ts, tz);
 }
 
+static struct list_head hooks_vm_enough_memory;
 int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 {
-	return security_ops->vm_enough_memory(mm, pages);
+	return call_int_hook(vm_enough_memory, mm, pages);
 }
 
+static struct list_head hooks_bprm_set_creds;
 int security_bprm_set_creds(struct linux_binprm *bprm)
 {
-	return security_ops->bprm_set_creds(bprm);
+	return call_int_hook(bprm_set_creds, bprm);
 }
 
+static struct list_head hooks_bprm_check_security;
 int security_bprm_check(struct linux_binprm *bprm)
 {
 	int ret;
 
-	ret = security_ops->bprm_check_security(bprm);
+	ret = call_int_hook(bprm_check_security, bprm);
 	if (ret)
 		return ret;
 	return ima_bprm_check(bprm);
 }
 
+static struct list_head hooks_bprm_committing_creds;
 void security_bprm_committing_creds(struct linux_binprm *bprm)
 {
-	security_ops->bprm_committing_creds(bprm);
+	call_void_hook(bprm_committing_creds, bprm);
 }
 
+static struct list_head hooks_bprm_committed_creds;
 void security_bprm_committed_creds(struct linux_binprm *bprm)
 {
-	security_ops->bprm_committed_creds(bprm);
+	call_void_hook(bprm_committed_creds, bprm);
 }
 
+static struct list_head hooks_bprm_secureexec;
 int security_bprm_secureexec(struct linux_binprm *bprm)
 {
-	return security_ops->bprm_secureexec(bprm);
+	/*
+	 * SELinux and Smack integrate the cap call,
+	 * so assume that all LSMs supplying this call do so.
+	 */
+	if (list_empty(&hooks_bprm_secureexec))
+		return cap_bprm_secureexec(bprm);
+
+	return call_int_hook(bprm_secureexec, bprm);
 }
 
+static struct list_head hooks_sb_alloc_security;
 int security_sb_alloc(struct super_block *sb)
 {
-	return security_ops->sb_alloc_security(sb);
+	return call_int_hook(sb_alloc_security, sb);
 }
 
+static struct list_head hooks_sb_free_security;
 void security_sb_free(struct super_block *sb)
 {
-	security_ops->sb_free_security(sb);
+	call_void_hook(sb_free_security, sb);
 }
 
+static struct list_head hooks_sb_copy_data;
 int security_sb_copy_data(char *orig, char *copy)
 {
-	return security_ops->sb_copy_data(orig, copy);
+	return call_int_hook(sb_copy_data, orig, copy);
 }
 EXPORT_SYMBOL(security_sb_copy_data);
 
+static struct list_head hooks_sb_remount;
 int security_sb_remount(struct super_block *sb, void *data)
 {
-	return security_ops->sb_remount(sb, data);
+	return call_int_hook(sb_remount, sb, data);
 }
 
+static struct list_head hooks_sb_kern_mount;
 int security_sb_kern_mount(struct super_block *sb, int flags, void *data)
 {
-	return security_ops->sb_kern_mount(sb, flags, data);
+	return call_int_hook(sb_kern_mount, sb, flags, data);
 }
 
+static struct list_head hooks_sb_show_options;
 int security_sb_show_options(struct seq_file *m, struct super_block *sb)
 {
-	return security_ops->sb_show_options(m, sb);
+	return call_int_hook(sb_show_options, m, sb);
 }
 
+static struct list_head hooks_sb_statfs;
 int security_sb_statfs(struct dentry *dentry)
 {
-	return security_ops->sb_statfs(dentry);
+	return call_int_hook(sb_statfs, dentry);
 }
 
+static struct list_head hooks_sb_mount;
 int security_sb_mount(const char *dev_name, struct path *path,
                        const char *type, unsigned long flags, void *data)
 {
-	return security_ops->sb_mount(dev_name, path, type, flags, data);
+	return call_int_hook(sb_mount, dev_name, path, type, flags, data);
 }
 
+static struct list_head hooks_sb_umount;
 int security_sb_umount(struct vfsmount *mnt, int flags)
 {
-	return security_ops->sb_umount(mnt, flags);
+	return call_int_hook(sb_umount, mnt, flags);
 }
 
+static struct list_head hooks_sb_pivotroot;
 int security_sb_pivotroot(struct path *old_path, struct path *new_path)
 {
-	return security_ops->sb_pivotroot(old_path, new_path);
+	return call_int_hook(sb_pivotroot, old_path, new_path);
 }
 
+static struct list_head hooks_sb_set_mnt_opts;
 int security_sb_set_mnt_opts(struct super_block *sb,
 				struct security_mnt_opts *opts,
 				unsigned long kern_flags,
 				unsigned long *set_kern_flags)
 {
-	return security_ops->sb_set_mnt_opts(sb, opts, kern_flags,
+	if (list_empty(&hooks_sb_set_mnt_opts)) {
+		if (unlikely(opts->num_mnt_opts))
+			return -EOPNOTSUPP;
+	}
+
+	return call_int_hook(sb_set_mnt_opts, sb, opts, kern_flags,
 						set_kern_flags);
 }
 EXPORT_SYMBOL(security_sb_set_mnt_opts);
 
+static struct list_head hooks_sb_clone_mnt_opts;
 int security_sb_clone_mnt_opts(const struct super_block *oldsb,
 				struct super_block *newsb)
 {
-	return security_ops->sb_clone_mnt_opts(oldsb, newsb);
+	return call_int_hook(sb_clone_mnt_opts, oldsb, newsb);
 }
 EXPORT_SYMBOL(security_sb_clone_mnt_opts);
 
+static struct list_head hooks_sb_parse_opts_str;
 int security_sb_parse_opts_str(char *options, struct security_mnt_opts *opts)
 {
-	return security_ops->sb_parse_opts_str(options, opts);
+	return call_int_hook(sb_parse_opts_str, options, opts);
 }
 EXPORT_SYMBOL(security_sb_parse_opts_str);
 
+static struct list_head hooks_inode_alloc_security;
 int security_inode_alloc(struct inode *inode)
 {
-	inode->i_security = NULL;
-	return security_ops->inode_alloc_security(inode);
+	return call_int_hook(inode_alloc_security, inode);
 }
 
+static struct list_head hooks_inode_free_security;
 void security_inode_free(struct inode *inode)
 {
 	integrity_inode_free(inode);
-	security_ops->inode_free_security(inode);
+	call_void_hook(inode_free_security, inode);
 }
 
+static struct list_head hooks_dentry_init_security;
 int security_dentry_init_security(struct dentry *dentry, int mode,
 					struct qstr *name, void **ctx,
 					u32 *ctxlen)
 {
-	return security_ops->dentry_init_security(dentry, mode, name,
+	if (list_empty(&hooks_dentry_init_security))
+		return -EOPNOTSUPP;
+	return call_int_hook(dentry_init_security, dentry, mode, name,
 							ctx, ctxlen);
 }
 EXPORT_SYMBOL(security_dentry_init_security);
 
+static struct list_head hooks_inode_init_security;
 int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const struct qstr *qstr,
 				 const initxattrs initxattrs, void *fs_data)
@@ -348,12 +472,16 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
 
+	if (list_empty(&hooks_inode_init_security))
+		return 0;
+
 	if (!initxattrs)
-		return security_ops->inode_init_security(inode, dir, qstr,
+		return call_int_hook(inode_init_security, inode, dir, qstr,
 							 NULL, NULL, NULL);
 	memset(new_xattrs, 0, sizeof(new_xattrs));
 	lsm_xattr = new_xattrs;
-	ret = security_ops->inode_init_security(inode, dir, qstr,
+
+	ret = call_int_hook(inode_init_security, inode, dir, qstr,
 						&lsm_xattr->name,
 						&lsm_xattr->value,
 						&lsm_xattr->value_len);
@@ -372,66 +500,79 @@ out:
 }
 EXPORT_SYMBOL(security_inode_init_security);
 
+/*
+ * Shares a hook with inode_init_security
+ */
 int security_old_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr, const char **name,
 				     void **value, size_t *len)
 {
 	if (unlikely(IS_PRIVATE(inode)))
 		return -EOPNOTSUPP;
-	return security_ops->inode_init_security(inode, dir, qstr, name, value,
-						 len);
+	if (list_empty(&hooks_inode_init_security))
+		return 0;
+
+	return call_int_hook(inode_init_security, inode, dir, qstr, name,
+				value, len);
 }
 EXPORT_SYMBOL(security_old_inode_init_security);
 
 #ifdef CONFIG_SECURITY_PATH
+static struct list_head hooks_path_mknod;
 int security_path_mknod(struct path *dir, struct dentry *dentry, umode_t mode,
 			unsigned int dev)
 {
 	if (unlikely(IS_PRIVATE(dir->dentry->d_inode)))
 		return 0;
-	return security_ops->path_mknod(dir, dentry, mode, dev);
+	return call_int_hook(path_mknod, dir, dentry, mode, dev);
 }
 EXPORT_SYMBOL(security_path_mknod);
 
+static struct list_head hooks_path_mkdir;
 int security_path_mkdir(struct path *dir, struct dentry *dentry, umode_t mode)
 {
 	if (unlikely(IS_PRIVATE(dir->dentry->d_inode)))
 		return 0;
-	return security_ops->path_mkdir(dir, dentry, mode);
+	return call_int_hook(path_mkdir, dir, dentry, mode);
 }
 EXPORT_SYMBOL(security_path_mkdir);
 
+static struct list_head hooks_path_rmdir;
 int security_path_rmdir(struct path *dir, struct dentry *dentry)
 {
 	if (unlikely(IS_PRIVATE(dir->dentry->d_inode)))
 		return 0;
-	return security_ops->path_rmdir(dir, dentry);
+	return call_int_hook(path_rmdir, dir, dentry);
 }
 
+static struct list_head hooks_path_unlink;
 int security_path_unlink(struct path *dir, struct dentry *dentry)
 {
 	if (unlikely(IS_PRIVATE(dir->dentry->d_inode)))
 		return 0;
-	return security_ops->path_unlink(dir, dentry);
+	return call_int_hook(path_unlink, dir, dentry);
 }
 EXPORT_SYMBOL(security_path_unlink);
 
+static struct list_head hooks_path_symlink;
 int security_path_symlink(struct path *dir, struct dentry *dentry,
 			  const char *old_name)
 {
 	if (unlikely(IS_PRIVATE(dir->dentry->d_inode)))
 		return 0;
-	return security_ops->path_symlink(dir, dentry, old_name);
+	return call_int_hook(path_symlink, dir, dentry, old_name);
 }
 
+static struct list_head hooks_path_link;
 int security_path_link(struct dentry *old_dentry, struct path *new_dir,
 		       struct dentry *new_dentry)
 {
 	if (unlikely(IS_PRIVATE(old_dentry->d_inode)))
 		return 0;
-	return security_ops->path_link(old_dentry, new_dir, new_dentry);
+	return call_int_hook(path_link, old_dentry, new_dir, new_dentry);
 }
 
+static struct list_head hooks_path_rename;
 int security_path_rename(struct path *old_dir, struct dentry *old_dentry,
 			 struct path *new_dir, struct dentry *new_dentry,
 			 unsigned int flags)
@@ -441,97 +582,109 @@ int security_path_rename(struct path *old_dir, struct dentry *old_dentry,
 		return 0;
 
 	if (flags & RENAME_EXCHANGE) {
-		int err = security_ops->path_rename(new_dir, new_dentry,
+		int err = call_int_hook(path_rename, new_dir, new_dentry,
 						    old_dir, old_dentry);
 		if (err)
 			return err;
 	}
 
-	return security_ops->path_rename(old_dir, old_dentry, new_dir,
+	return call_int_hook(path_rename, old_dir, old_dentry, new_dir,
 					 new_dentry);
 }
 EXPORT_SYMBOL(security_path_rename);
 
+static struct list_head hooks_path_truncate;
 int security_path_truncate(struct path *path)
 {
 	if (unlikely(IS_PRIVATE(path->dentry->d_inode)))
 		return 0;
-	return security_ops->path_truncate(path);
+	return call_int_hook(path_truncate, path);
 }
 
+static struct list_head hooks_path_chmod;
 int security_path_chmod(struct path *path, umode_t mode)
 {
 	if (unlikely(IS_PRIVATE(path->dentry->d_inode)))
 		return 0;
-	return security_ops->path_chmod(path, mode);
+	return call_int_hook(path_chmod, path, mode);
 }
 
+static struct list_head hooks_path_chown;
 int security_path_chown(struct path *path, kuid_t uid, kgid_t gid)
 {
 	if (unlikely(IS_PRIVATE(path->dentry->d_inode)))
 		return 0;
-	return security_ops->path_chown(path, uid, gid);
+	return call_int_hook(path_chown, path, uid, gid);
 }
 
+static struct list_head hooks_path_chroot;
 int security_path_chroot(struct path *path)
 {
-	return security_ops->path_chroot(path);
+	return call_int_hook(path_chroot, path);
 }
 #endif
 
+static struct list_head hooks_inode_create;
 int security_inode_create(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
 	if (unlikely(IS_PRIVATE(dir)))
 		return 0;
-	return security_ops->inode_create(dir, dentry, mode);
+	return call_int_hook(inode_create, dir, dentry, mode);
 }
 EXPORT_SYMBOL_GPL(security_inode_create);
 
+static struct list_head hooks_inode_link;
 int security_inode_link(struct dentry *old_dentry, struct inode *dir,
 			 struct dentry *new_dentry)
 {
 	if (unlikely(IS_PRIVATE(old_dentry->d_inode)))
 		return 0;
-	return security_ops->inode_link(old_dentry, dir, new_dentry);
+	return call_int_hook(inode_link, old_dentry, dir, new_dentry);
 }
 
+static struct list_head hooks_inode_unlink;
 int security_inode_unlink(struct inode *dir, struct dentry *dentry)
 {
 	if (unlikely(IS_PRIVATE(dentry->d_inode)))
 		return 0;
-	return security_ops->inode_unlink(dir, dentry);
+	return call_int_hook(inode_unlink, dir, dentry);
 }
 
+static struct list_head hooks_inode_symlink;
 int security_inode_symlink(struct inode *dir, struct dentry *dentry,
 			    const char *old_name)
 {
 	if (unlikely(IS_PRIVATE(dir)))
 		return 0;
-	return security_ops->inode_symlink(dir, dentry, old_name);
+	return call_int_hook(inode_symlink, dir, dentry, old_name);
 }
 
+static struct list_head hooks_inode_mkdir;
 int security_inode_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
 	if (unlikely(IS_PRIVATE(dir)))
 		return 0;
-	return security_ops->inode_mkdir(dir, dentry, mode);
+	return call_int_hook(inode_mkdir, dir, dentry, mode);
 }
 EXPORT_SYMBOL_GPL(security_inode_mkdir);
 
+static struct list_head hooks_inode_rmdir;
 int security_inode_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	if (unlikely(IS_PRIVATE(dentry->d_inode)))
 		return 0;
-	return security_ops->inode_rmdir(dir, dentry);
+	return call_int_hook(inode_rmdir, dir, dentry);
 }
 
+static struct list_head hooks_inode_mknod;
 int security_inode_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
 {
 	if (unlikely(IS_PRIVATE(dir)))
 		return 0;
-	return security_ops->inode_mknod(dir, dentry, mode, dev);
+	return call_int_hook(inode_mknod, dir, dentry, mode, dev);
 }
 
+static struct list_head hooks_inode_rename;
 int security_inode_rename(struct inode *old_dir, struct dentry *old_dentry,
 			   struct inode *new_dir, struct dentry *new_dentry,
 			   unsigned int flags)
@@ -541,57 +694,63 @@ int security_inode_rename(struct inode *old_dir, struct dentry *old_dentry,
 		return 0;
 
 	if (flags & RENAME_EXCHANGE) {
-		int err = security_ops->inode_rename(new_dir, new_dentry,
+		int err = call_int_hook(inode_rename, old_dir, old_dentry,
 						     old_dir, old_dentry);
 		if (err)
 			return err;
 	}
 
-	return security_ops->inode_rename(old_dir, old_dentry,
+	return call_int_hook(inode_rename, old_dir, old_dentry,
 					   new_dir, new_dentry);
 }
 
+static struct list_head hooks_inode_readlink;
 int security_inode_readlink(struct dentry *dentry)
 {
 	if (unlikely(IS_PRIVATE(dentry->d_inode)))
 		return 0;
-	return security_ops->inode_readlink(dentry);
+	return call_int_hook(inode_readlink, dentry);
 }
 
+static struct list_head hooks_inode_follow_link;
 int security_inode_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	if (unlikely(IS_PRIVATE(dentry->d_inode)))
 		return 0;
-	return security_ops->inode_follow_link(dentry, nd);
+	return call_int_hook(inode_follow_link, dentry, nd);
 }
 
+static struct list_head hooks_inode_permission;
 int security_inode_permission(struct inode *inode, int mask)
 {
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
-	return security_ops->inode_permission(inode, mask);
+	return call_int_hook(inode_permission, inode, mask);
 }
 
+static struct list_head hooks_inode_setattr;
 int security_inode_setattr(struct dentry *dentry, struct iattr *attr)
 {
 	int ret;
 
 	if (unlikely(IS_PRIVATE(dentry->d_inode)))
 		return 0;
-	ret = security_ops->inode_setattr(dentry, attr);
+	ret = call_int_hook(inode_setattr, dentry, attr);
 	if (ret)
 		return ret;
 	return evm_inode_setattr(dentry, attr);
 }
 EXPORT_SYMBOL_GPL(security_inode_setattr);
 
+static struct list_head hooks_inode_getattr;
 int security_inode_getattr(struct vfsmount *mnt, struct dentry *dentry)
 {
 	if (unlikely(IS_PRIVATE(dentry->d_inode)))
 		return 0;
-	return security_ops->inode_getattr(mnt, dentry);
+	return call_int_hook(inode_getattr, mnt, dentry);
 }
 
+static struct list_head hooks_inode_setxattr;
 int security_inode_setxattr(struct dentry *dentry, const char *name,
 			    const void *value, size_t size, int flags)
 {
@@ -599,7 +758,16 @@ int security_inode_setxattr(struct dentry *dentry, const char *name,
 
 	if (unlikely(IS_PRIVATE(dentry->d_inode)))
 		return 0;
-	ret = security_ops->inode_setxattr(dentry, name, value, size, flags);
+	/*
+	 * SELinux and Smack integrate the cap call,
+	 * so assume that all LSMs supplying this call do so.
+	 */
+	if (list_empty(&hooks_inode_setxattr))
+		ret = cap_inode_setxattr(dentry, name, value, size, flags);
+	else
+		ret = call_int_hook(inode_setxattr, dentry, name, value,
+					size, flags);
+
 	if (ret)
 		return ret;
 	ret = ima_inode_setxattr(dentry, name, value, size);
@@ -608,36 +776,45 @@ int security_inode_setxattr(struct dentry *dentry, const char *name,
 	return evm_inode_setxattr(dentry, name, value, size);
 }
 
+static struct list_head hooks_inode_post_setxattr;
 void security_inode_post_setxattr(struct dentry *dentry, const char *name,
 				  const void *value, size_t size, int flags)
 {
 	if (unlikely(IS_PRIVATE(dentry->d_inode)))
 		return;
-	security_ops->inode_post_setxattr(dentry, name, value, size, flags);
+	call_void_hook(inode_post_setxattr, dentry, name, value, size, flags);
 	evm_inode_post_setxattr(dentry, name, value, size);
 }
 
+static struct list_head hooks_inode_getxattr;
 int security_inode_getxattr(struct dentry *dentry, const char *name)
 {
 	if (unlikely(IS_PRIVATE(dentry->d_inode)))
 		return 0;
-	return security_ops->inode_getxattr(dentry, name);
+	return call_int_hook(inode_getxattr, dentry, name);
 }
 
+static struct list_head hooks_inode_listxattr;
 int security_inode_listxattr(struct dentry *dentry)
 {
 	if (unlikely(IS_PRIVATE(dentry->d_inode)))
 		return 0;
-	return security_ops->inode_listxattr(dentry);
+	return call_int_hook(inode_listxattr, dentry);
 }
 
+static struct list_head hooks_inode_removexattr;
 int security_inode_removexattr(struct dentry *dentry, const char *name)
 {
 	int ret;
 
 	if (unlikely(IS_PRIVATE(dentry->d_inode)))
 		return 0;
-	ret = security_ops->inode_removexattr(dentry, name);
+
+	if (list_empty(&hooks_inode_removexattr))
+		ret = cap_inode_removexattr(dentry, name);
+	else
+		ret = call_int_hook(inode_removexattr, dentry, name);
+
 	if (ret)
 		return ret;
 	ret = ima_inode_removexattr(dentry, name);
@@ -646,67 +823,84 @@ int security_inode_removexattr(struct dentry *dentry, const char *name)
 	return evm_inode_removexattr(dentry, name);
 }
 
+static struct list_head hooks_inode_need_killpriv;
 int security_inode_need_killpriv(struct dentry *dentry)
 {
-	return security_ops->inode_need_killpriv(dentry);
+	return call_int_hook(inode_need_killpriv, dentry);
 }
 
+static struct list_head hooks_inode_killpriv;
 int security_inode_killpriv(struct dentry *dentry)
 {
-	return security_ops->inode_killpriv(dentry);
+	return call_int_hook(inode_killpriv, dentry);
 }
 
+static struct list_head hooks_inode_getsecurity;
 int security_inode_getsecurity(const struct inode *inode, const char *name, void **buffer, bool alloc)
 {
 	if (unlikely(IS_PRIVATE(inode)))
 		return -EOPNOTSUPP;
-	return security_ops->inode_getsecurity(inode, name, buffer, alloc);
+	if (list_empty(&hooks_inode_getsecurity))
+		return -EOPNOTSUPP;
+	return call_int_hook(inode_getsecurity, inode, name, buffer, alloc);
 }
 
+static struct list_head hooks_inode_setsecurity;
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
 {
 	if (unlikely(IS_PRIVATE(inode)))
 		return -EOPNOTSUPP;
-	return security_ops->inode_setsecurity(inode, name, value, size, flags);
+	if (list_empty(&hooks_inode_setsecurity))
+		return -EOPNOTSUPP;
+	return call_int_hook(inode_setsecurity, inode, name, value, size, flags);
 }
 
+static struct list_head hooks_inode_listsecurity;
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
 {
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
-	return security_ops->inode_listsecurity(inode, buffer, buffer_size);
+	return call_int_hook(inode_listsecurity, inode, buffer, buffer_size);
 }
 EXPORT_SYMBOL(security_inode_listsecurity);
 
+static struct list_head hooks_inode_getsecid;
 void security_inode_getsecid(const struct inode *inode, u32 *secid)
 {
-	security_ops->inode_getsecid(inode, secid);
+	if (list_empty(&hooks_inode_getsecid))
+		*secid = 0;
+	else
+		call_void_hook(inode_getsecid, inode, secid);
 }
 
+static struct list_head hooks_file_permission;
 int security_file_permission(struct file *file, int mask)
 {
 	int ret;
 
-	ret = security_ops->file_permission(file, mask);
+	ret = call_int_hook(file_permission, file, mask);
 	if (ret)
 		return ret;
 
 	return fsnotify_perm(file, mask);
 }
 
+static struct list_head hooks_file_alloc_security;
 int security_file_alloc(struct file *file)
 {
-	return security_ops->file_alloc_security(file);
+	return call_int_hook(file_alloc_security, file);
 }
 
+static struct list_head hooks_file_free_security;
 void security_file_free(struct file *file)
 {
-	security_ops->file_free_security(file);
+	call_void_hook(file_free_security, file);
 }
 
+static struct list_head hooks_file_ioctl;
 int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
-	return security_ops->file_ioctl(file, cmd, arg);
+	return call_int_hook(file_ioctl, file, cmd, arg);
 }
 
 static inline unsigned long mmap_prot(struct file *file, unsigned long prot)
@@ -743,667 +937,821 @@ static inline unsigned long mmap_prot(struct file *file, unsigned long prot)
 	return prot;
 }
 
+static struct list_head hooks_mmap_file;
 int security_mmap_file(struct file *file, unsigned long prot,
 			unsigned long flags)
 {
 	int ret;
-	ret = security_ops->mmap_file(file, prot,
+	ret = call_int_hook(mmap_file, file, prot,
 					mmap_prot(file, prot), flags);
 	if (ret)
 		return ret;
 	return ima_file_mmap(file, prot);
 }
 
+static struct list_head hooks_mmap_addr;
 int security_mmap_addr(unsigned long addr)
 {
-	return security_ops->mmap_addr(addr);
+	return call_int_hook(mmap_addr, addr);
 }
 
+static struct list_head hooks_file_mprotect;
 int security_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 			    unsigned long prot)
 {
-	return security_ops->file_mprotect(vma, reqprot, prot);
+	return call_int_hook(file_mprotect, vma, reqprot, prot);
 }
 
+static struct list_head hooks_file_lock;
 int security_file_lock(struct file *file, unsigned int cmd)
 {
-	return security_ops->file_lock(file, cmd);
+	return call_int_hook(file_lock, file, cmd);
 }
 
+static struct list_head hooks_file_fcntl;
 int security_file_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
 {
-	return security_ops->file_fcntl(file, cmd, arg);
+	return call_int_hook(file_fcntl, file, cmd, arg);
 }
 
+static struct list_head hooks_file_set_fowner;
 int security_file_set_fowner(struct file *file)
 {
-	return security_ops->file_set_fowner(file);
+	return call_int_hook(file_set_fowner, file);
 }
 
+static struct list_head hooks_file_send_sigiotask;
 int security_file_send_sigiotask(struct task_struct *tsk,
 				  struct fown_struct *fown, int sig)
 {
-	return security_ops->file_send_sigiotask(tsk, fown, sig);
+	return call_int_hook(file_send_sigiotask, tsk, fown, sig);
 }
 
+static struct list_head hooks_file_receive;
 int security_file_receive(struct file *file)
 {
-	return security_ops->file_receive(file);
+	return call_int_hook(file_receive, file);
 }
 
+static struct list_head hooks_file_open;
 int security_file_open(struct file *file, const struct cred *cred)
 {
 	int ret;
 
-	ret = security_ops->file_open(file, cred);
+	ret = call_int_hook(file_open, file, cred);
 	if (ret)
 		return ret;
 
 	return fsnotify_perm(file, MAY_OPEN);
 }
 
+static struct list_head hooks_task_create;
 int security_task_create(unsigned long clone_flags)
 {
-	return security_ops->task_create(clone_flags);
+	return call_int_hook(task_create, clone_flags);
 }
 
+static struct list_head hooks_task_free;
 void security_task_free(struct task_struct *task)
 {
-#ifdef CONFIG_SECURITY_YAMA_STACKED
-	yama_task_free(task);
-#endif
-	security_ops->task_free(task);
+	call_void_hook(task_free, task);
 }
 
+static struct list_head hooks_cred_alloc_blank;
 int security_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 {
-	return security_ops->cred_alloc_blank(cred, gfp);
+	return call_int_hook(cred_alloc_blank, cred, gfp);
 }
 
+static struct list_head hooks_cred_free;
 void security_cred_free(struct cred *cred)
 {
-	security_ops->cred_free(cred);
+	call_void_hook(cred_free, cred);
 }
 
+static struct list_head hooks_cred_prepare;
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp)
 {
-	return security_ops->cred_prepare(new, old, gfp);
+	return call_int_hook(cred_prepare, new, old, gfp);
 }
 
+static struct list_head hooks_cred_transfer;
 void security_transfer_creds(struct cred *new, const struct cred *old)
 {
-	security_ops->cred_transfer(new, old);
+	call_void_hook(cred_transfer, new, old);
 }
 
+static struct list_head hooks_kernel_act_as;
 int security_kernel_act_as(struct cred *new, u32 secid)
 {
-	return security_ops->kernel_act_as(new, secid);
+	return call_int_hook(kernel_act_as, new, secid);
 }
 
+static struct list_head hooks_kernel_create_files_as;
 int security_kernel_create_files_as(struct cred *new, struct inode *inode)
 {
-	return security_ops->kernel_create_files_as(new, inode);
+	return call_int_hook(kernel_create_files_as, new, inode);
 }
 
+static struct list_head hooks_kernel_module_request;
 int security_kernel_module_request(char *kmod_name)
 {
-	return security_ops->kernel_module_request(kmod_name);
+	return call_int_hook(kernel_module_request, kmod_name);
 }
 
+static struct list_head hooks_kernel_module_from_file;
 int security_kernel_module_from_file(struct file *file)
 {
 	int ret;
 
-	ret = security_ops->kernel_module_from_file(file);
+	ret = call_int_hook(kernel_module_from_file, file);
 	if (ret)
 		return ret;
 	return ima_module_check(file);
 }
 
+static struct list_head hooks_task_fix_setuid;
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
 			     int flags)
 {
-	return security_ops->task_fix_setuid(new, old, flags);
+	return call_int_hook(task_fix_setuid, new, old, flags);
 }
 
+static struct list_head hooks_task_setpgid;
 int security_task_setpgid(struct task_struct *p, pid_t pgid)
 {
-	return security_ops->task_setpgid(p, pgid);
+	return call_int_hook(task_setpgid, p, pgid);
 }
 
+static struct list_head hooks_task_getpgid;
 int security_task_getpgid(struct task_struct *p)
 {
-	return security_ops->task_getpgid(p);
+	return call_int_hook(task_getpgid, p);
 }
 
+static struct list_head hooks_task_getsid;
 int security_task_getsid(struct task_struct *p)
 {
-	return security_ops->task_getsid(p);
+	return call_int_hook(task_getsid, p);
 }
 
+static struct list_head hooks_task_getsecid;
 void security_task_getsecid(struct task_struct *p, u32 *secid)
 {
-	security_ops->task_getsecid(p, secid);
+	if (list_empty(&hooks_task_getsecid))
+		*secid = 0;
+	else
+		call_void_hook(task_getsecid, p, secid);
 }
 EXPORT_SYMBOL(security_task_getsecid);
 
+static struct list_head hooks_task_setnice;
 int security_task_setnice(struct task_struct *p, int nice)
 {
-	return security_ops->task_setnice(p, nice);
+	return call_int_hook(task_setnice, p, nice);
 }
 
+static struct list_head hooks_task_setioprio;
 int security_task_setioprio(struct task_struct *p, int ioprio)
 {
-	return security_ops->task_setioprio(p, ioprio);
+	return call_int_hook(task_setioprio, p, ioprio);
 }
 
+static struct list_head hooks_task_getioprio;
 int security_task_getioprio(struct task_struct *p)
 {
-	return security_ops->task_getioprio(p);
+	return call_int_hook(task_getioprio, p);
 }
 
+static struct list_head hooks_task_setrlimit;
 int security_task_setrlimit(struct task_struct *p, unsigned int resource,
 		struct rlimit *new_rlim)
 {
-	return security_ops->task_setrlimit(p, resource, new_rlim);
+	return call_int_hook(task_setrlimit, p, resource, new_rlim);
 }
 
+static struct list_head hooks_task_setscheduler;
 int security_task_setscheduler(struct task_struct *p)
 {
-	return security_ops->task_setscheduler(p);
+	return call_int_hook(task_setscheduler, p);
 }
 
+static struct list_head hooks_task_getscheduler;
 int security_task_getscheduler(struct task_struct *p)
 {
-	return security_ops->task_getscheduler(p);
+	return call_int_hook(task_getscheduler, p);
 }
 
+static struct list_head hooks_task_movememory;
 int security_task_movememory(struct task_struct *p)
 {
-	return security_ops->task_movememory(p);
+	return call_int_hook(task_movememory, p);
 }
 
+static struct list_head hooks_task_kill;
 int security_task_kill(struct task_struct *p, struct siginfo *info,
 			int sig, u32 secid)
 {
-	return security_ops->task_kill(p, info, sig, secid);
+	return call_int_hook(task_kill, p, info, sig, secid);
 }
 
+static struct list_head hooks_task_wait;
 int security_task_wait(struct task_struct *p)
 {
-	return security_ops->task_wait(p);
+	return call_int_hook(task_wait, p);
 }
 
+static struct list_head hooks_task_prctl;
 int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			 unsigned long arg4, unsigned long arg5)
 {
-#ifdef CONFIG_SECURITY_YAMA_STACKED
-	int rc;
-	rc = yama_task_prctl(option, arg2, arg3, arg4, arg5);
-	if (rc != -ENOSYS)
-		return rc;
+	int thisrc;
+	int rc = -ENOSYS;
+	struct security_hook_list *shp;
+
+	if (list_empty(&hooks_task_prctl))
+		return -ENOSYS;
+
+	list_for_each_entry(shp, &hooks_task_prctl, shl_head) {
+#ifdef CONFIG_SECURITY_SELINUX_DISABLE
+		if (shp->shl_ops == NULL)
+			continue;
 #endif
-	return security_ops->task_prctl(option, arg2, arg3, arg4, arg5);
+		thisrc = shp->shl_ops->task_prctl(option, arg2, arg3,
+							arg4, arg5);
+		if (thisrc != -ENOSYS) {
+			rc = thisrc;
+			if (thisrc != 0)
+				break;
+		}
+	}
+	return rc;
 }
 
+static struct list_head hooks_task_to_inode;
 void security_task_to_inode(struct task_struct *p, struct inode *inode)
 {
-	security_ops->task_to_inode(p, inode);
+	call_void_hook(task_to_inode, p, inode);
 }
 
+static struct list_head hooks_ipc_permission;
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 {
-	return security_ops->ipc_permission(ipcp, flag);
+	return call_int_hook(ipc_permission, ipcp, flag);
 }
 
+static struct list_head hooks_ipc_getsecid;
 void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
 {
-	security_ops->ipc_getsecid(ipcp, secid);
+	if (list_empty(&hooks_ipc_getsecid))
+		*secid = 0;
+	else
+		call_void_hook(ipc_getsecid, ipcp, secid);
 }
 
+static struct list_head hooks_msg_msg_alloc_security;
 int security_msg_msg_alloc(struct msg_msg *msg)
 {
-	return security_ops->msg_msg_alloc_security(msg);
+	return call_int_hook(msg_msg_alloc_security, msg);
 }
 
+static struct list_head hooks_msg_msg_free_security;
 void security_msg_msg_free(struct msg_msg *msg)
 {
-	security_ops->msg_msg_free_security(msg);
+	call_void_hook(msg_msg_free_security, msg);
 }
 
+static struct list_head hooks_msg_queue_alloc_security;
 int security_msg_queue_alloc(struct msg_queue *msq)
 {
-	return security_ops->msg_queue_alloc_security(msq);
+	return call_int_hook(msg_queue_alloc_security, msq);
 }
 
+static struct list_head hooks_msg_queue_free_security;
 void security_msg_queue_free(struct msg_queue *msq)
 {
-	security_ops->msg_queue_free_security(msq);
+	call_void_hook(msg_queue_free_security, msq);
 }
 
+static struct list_head hooks_msg_queue_associate;
 int security_msg_queue_associate(struct msg_queue *msq, int msqflg)
 {
-	return security_ops->msg_queue_associate(msq, msqflg);
+	return call_int_hook(msg_queue_associate, msq, msqflg);
 }
 
+static struct list_head hooks_msg_queue_msgctl;
 int security_msg_queue_msgctl(struct msg_queue *msq, int cmd)
 {
-	return security_ops->msg_queue_msgctl(msq, cmd);
+	return call_int_hook(msg_queue_msgctl, msq, cmd);
 }
 
+static struct list_head hooks_msg_queue_msgsnd;
 int security_msg_queue_msgsnd(struct msg_queue *msq,
 			       struct msg_msg *msg, int msqflg)
 {
-	return security_ops->msg_queue_msgsnd(msq, msg, msqflg);
+	return call_int_hook(msg_queue_msgsnd, msq, msg, msqflg);
 }
 
+static struct list_head hooks_msg_queue_msgrcv;
 int security_msg_queue_msgrcv(struct msg_queue *msq, struct msg_msg *msg,
 			       struct task_struct *target, long type, int mode)
 {
-	return security_ops->msg_queue_msgrcv(msq, msg, target, type, mode);
+	return call_int_hook(msg_queue_msgrcv, msq, msg, target, type, mode);
 }
 
+static struct list_head hooks_shm_alloc_security;
 int security_shm_alloc(struct shmid_kernel *shp)
 {
-	return security_ops->shm_alloc_security(shp);
+	return call_int_hook(shm_alloc_security, shp);
 }
 
+static struct list_head hooks_shm_free_security;
 void security_shm_free(struct shmid_kernel *shp)
 {
-	security_ops->shm_free_security(shp);
+	call_void_hook(shm_free_security, shp);
 }
 
+static struct list_head hooks_shm_associate;
 int security_shm_associate(struct shmid_kernel *shp, int shmflg)
 {
-	return security_ops->shm_associate(shp, shmflg);
+	return call_int_hook(shm_associate, shp, shmflg);
 }
 
+static struct list_head hooks_shm_shmctl;
 int security_shm_shmctl(struct shmid_kernel *shp, int cmd)
 {
-	return security_ops->shm_shmctl(shp, cmd);
+	return call_int_hook(shm_shmctl, shp, cmd);
 }
 
+static struct list_head hooks_shm_shmat;
 int security_shm_shmat(struct shmid_kernel *shp, char __user *shmaddr, int shmflg)
 {
-	return security_ops->shm_shmat(shp, shmaddr, shmflg);
+	return call_int_hook(shm_shmat, shp, shmaddr, shmflg);
 }
 
+static struct list_head hooks_sem_alloc_security;
 int security_sem_alloc(struct sem_array *sma)
 {
-	return security_ops->sem_alloc_security(sma);
+	return call_int_hook(sem_alloc_security, sma);
 }
 
+static struct list_head hooks_sem_free_security;
 void security_sem_free(struct sem_array *sma)
 {
-	security_ops->sem_free_security(sma);
+	call_void_hook(sem_free_security, sma);
 }
 
+static struct list_head hooks_sem_associate;
 int security_sem_associate(struct sem_array *sma, int semflg)
 {
-	return security_ops->sem_associate(sma, semflg);
+	return call_int_hook(sem_associate, sma, semflg);
 }
 
+static struct list_head hooks_sem_semctl;
 int security_sem_semctl(struct sem_array *sma, int cmd)
 {
-	return security_ops->sem_semctl(sma, cmd);
+	return call_int_hook(sem_semctl, sma, cmd);
 }
 
+static struct list_head hooks_sem_semop;
 int security_sem_semop(struct sem_array *sma, struct sembuf *sops,
 			unsigned nsops, int alter)
 {
-	return security_ops->sem_semop(sma, sops, nsops, alter);
+	return call_int_hook(sem_semop, sma, sops, nsops, alter);
 }
 
+static struct list_head hooks_d_instantiate;
 void security_d_instantiate(struct dentry *dentry, struct inode *inode)
 {
 	if (unlikely(inode && IS_PRIVATE(inode)))
 		return;
-	security_ops->d_instantiate(dentry, inode);
+	call_void_hook(d_instantiate, dentry, inode);
 }
 EXPORT_SYMBOL(security_d_instantiate);
 
+static struct list_head hooks_getprocattr;
 int security_getprocattr(struct task_struct *p, char *name, char **value)
 {
-	return security_ops->getprocattr(p, name, value);
+	if (list_empty(&hooks_getprocattr))
+		return -EINVAL;
+	return call_int_hook(getprocattr, p, name, value);
 }
 
+static struct list_head hooks_setprocattr;
 int security_setprocattr(struct task_struct *p, char *name, void *value, size_t size)
 {
-	return security_ops->setprocattr(p, name, value, size);
+	if (list_empty(&hooks_setprocattr))
+		return -EINVAL;
+	return call_int_hook(setprocattr, p, name, value, size);
 }
 
+static struct list_head hooks_netlink_send;
 int security_netlink_send(struct sock *sk, struct sk_buff *skb)
 {
-	return security_ops->netlink_send(sk, skb);
+	return call_int_hook(netlink_send, sk, skb);
 }
 
+static struct list_head hooks_ismaclabel;
 int security_ismaclabel(const char *name)
 {
-	return security_ops->ismaclabel(name);
+	return call_int_hook(ismaclabel, name);
 }
 EXPORT_SYMBOL(security_ismaclabel);
 
+static struct list_head hooks_secid_to_secctx;
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 {
-	return security_ops->secid_to_secctx(secid, secdata, seclen);
+	if (list_empty(&hooks_secid_to_secctx))
+		return -EOPNOTSUPP;
+	return call_int_hook(secid_to_secctx, secid, secdata, seclen);
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
+static struct list_head hooks_secctx_to_secid;
 int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 {
-	return security_ops->secctx_to_secid(secdata, seclen, secid);
+	if (list_empty(&hooks_secctx_to_secid)) {
+		*secid = 0;
+		return 0;
+	}
+	return call_int_hook(secctx_to_secid, secdata, seclen, secid);
 }
 EXPORT_SYMBOL(security_secctx_to_secid);
 
+static struct list_head hooks_release_secctx;
 void security_release_secctx(char *secdata, u32 seclen)
 {
-	security_ops->release_secctx(secdata, seclen);
+	call_void_hook(release_secctx, secdata, seclen);
 }
 EXPORT_SYMBOL(security_release_secctx);
 
+static struct list_head hooks_inode_notifysecctx;
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
 {
-	return security_ops->inode_notifysecctx(inode, ctx, ctxlen);
+	return call_int_hook(inode_notifysecctx, inode, ctx, ctxlen);
 }
 EXPORT_SYMBOL(security_inode_notifysecctx);
 
+static struct list_head hooks_inode_setsecctx;
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 {
-	return security_ops->inode_setsecctx(dentry, ctx, ctxlen);
+	return call_int_hook(inode_setsecctx, dentry, ctx, ctxlen);
 }
 EXPORT_SYMBOL(security_inode_setsecctx);
 
+static struct list_head hooks_inode_getsecctx;
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
 {
-	return security_ops->inode_getsecctx(inode, ctx, ctxlen);
+	if (list_empty(&hooks_inode_getsecctx))
+		return -EOPNOTSUPP;
+	return call_int_hook(inode_getsecctx, inode, ctx, ctxlen);
 }
 EXPORT_SYMBOL(security_inode_getsecctx);
 
 #ifdef CONFIG_SECURITY_NETWORK
 
+static struct list_head hooks_unix_stream_connect;
 int security_unix_stream_connect(struct sock *sock, struct sock *other, struct sock *newsk)
 {
-	return security_ops->unix_stream_connect(sock, other, newsk);
+	return call_int_hook(unix_stream_connect, sock, other, newsk);
 }
 EXPORT_SYMBOL(security_unix_stream_connect);
 
+static struct list_head hooks_unix_may_send;
 int security_unix_may_send(struct socket *sock,  struct socket *other)
 {
-	return security_ops->unix_may_send(sock, other);
+	return call_int_hook(unix_may_send, sock, other);
 }
 EXPORT_SYMBOL(security_unix_may_send);
 
+static struct list_head hooks_socket_create;
 int security_socket_create(int family, int type, int protocol, int kern)
 {
-	return security_ops->socket_create(family, type, protocol, kern);
+	return call_int_hook(socket_create, family, type, protocol, kern);
 }
 
+static struct list_head hooks_socket_post_create;
 int security_socket_post_create(struct socket *sock, int family,
 				int type, int protocol, int kern)
 {
-	return security_ops->socket_post_create(sock, family, type,
+	return call_int_hook(socket_post_create, sock, family, type,
 						protocol, kern);
 }
 
+static struct list_head hooks_socket_bind;
 int security_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
 {
-	return security_ops->socket_bind(sock, address, addrlen);
+	return call_int_hook(socket_bind, sock, address, addrlen);
 }
 
+static struct list_head hooks_socket_connect;
 int security_socket_connect(struct socket *sock, struct sockaddr *address, int addrlen)
 {
-	return security_ops->socket_connect(sock, address, addrlen);
+	return call_int_hook(socket_connect, sock, address, addrlen);
 }
 
+static struct list_head hooks_socket_listen;
 int security_socket_listen(struct socket *sock, int backlog)
 {
-	return security_ops->socket_listen(sock, backlog);
+	return call_int_hook(socket_listen, sock, backlog);
 }
 
+static struct list_head hooks_socket_accept;
 int security_socket_accept(struct socket *sock, struct socket *newsock)
 {
-	return security_ops->socket_accept(sock, newsock);
+	return call_int_hook(socket_accept, sock, newsock);
 }
 
+static struct list_head hooks_socket_sendmsg;
 int security_socket_sendmsg(struct socket *sock, struct msghdr *msg, int size)
 {
-	return security_ops->socket_sendmsg(sock, msg, size);
+	return call_int_hook(socket_sendmsg, sock, msg, size);
 }
 
+static struct list_head hooks_socket_recvmsg;
 int security_socket_recvmsg(struct socket *sock, struct msghdr *msg,
 			    int size, int flags)
 {
-	return security_ops->socket_recvmsg(sock, msg, size, flags);
+	return call_int_hook(socket_recvmsg, sock, msg, size, flags);
 }
 
+static struct list_head hooks_socket_getsockname;
 int security_socket_getsockname(struct socket *sock)
 {
-	return security_ops->socket_getsockname(sock);
+	return call_int_hook(socket_getsockname, sock);
 }
 
+static struct list_head hooks_socket_getpeername;
 int security_socket_getpeername(struct socket *sock)
 {
-	return security_ops->socket_getpeername(sock);
+	return call_int_hook(socket_getpeername, sock);
 }
 
+static struct list_head hooks_socket_getsockopt;
 int security_socket_getsockopt(struct socket *sock, int level, int optname)
 {
-	return security_ops->socket_getsockopt(sock, level, optname);
+	return call_int_hook(socket_getsockopt, sock, level, optname);
 }
 
+static struct list_head hooks_socket_setsockopt;
 int security_socket_setsockopt(struct socket *sock, int level, int optname)
 {
-	return security_ops->socket_setsockopt(sock, level, optname);
+	return call_int_hook(socket_setsockopt, sock, level, optname);
 }
 
+static struct list_head hooks_socket_shutdown;
 int security_socket_shutdown(struct socket *sock, int how)
 {
-	return security_ops->socket_shutdown(sock, how);
+	return call_int_hook(socket_shutdown, sock, how);
 }
 
+static struct list_head hooks_socket_sock_rcv_skb;
 int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
-	return security_ops->socket_sock_rcv_skb(sk, skb);
+	return call_int_hook(socket_sock_rcv_skb, sk, skb);
 }
 EXPORT_SYMBOL(security_sock_rcv_skb);
 
+static struct list_head hooks_socket_getpeersec_stream;
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len)
 {
-	return security_ops->socket_getpeersec_stream(sock, optval, optlen, len);
+	if (list_empty(&hooks_socket_getpeersec_stream))
+		return -ENOPROTOOPT;
+	return call_int_hook(socket_getpeersec_stream, sock, optval, optlen, len);
 }
 
+static struct list_head hooks_socket_getpeersec_dgram;
 int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
 {
-	return security_ops->socket_getpeersec_dgram(sock, skb, secid);
+	if (list_empty(&hooks_socket_getpeersec_dgram))
+		return -ENOPROTOOPT;
+	return call_int_hook(socket_getpeersec_dgram, sock, skb, secid);
 }
 EXPORT_SYMBOL(security_socket_getpeersec_dgram);
 
+static struct list_head hooks_sk_alloc_security;
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority)
 {
-	return security_ops->sk_alloc_security(sk, family, priority);
+	return call_int_hook(sk_alloc_security, sk, family, priority);
 }
 
+static struct list_head hooks_sk_free_security;
 void security_sk_free(struct sock *sk)
 {
-	security_ops->sk_free_security(sk);
+	call_void_hook(sk_free_security, sk);
 }
 
+static struct list_head hooks_sk_clone_security;
 void security_sk_clone(const struct sock *sk, struct sock *newsk)
 {
-	security_ops->sk_clone_security(sk, newsk);
+	call_void_hook(sk_clone_security, sk, newsk);
 }
 EXPORT_SYMBOL(security_sk_clone);
 
+static struct list_head hooks_sk_getsecid;
 void security_sk_classify_flow(struct sock *sk, struct flowi *fl)
 {
-	security_ops->sk_getsecid(sk, &fl->flowi_secid);
+	call_void_hook(sk_getsecid, sk, &fl->flowi_secid);
 }
 EXPORT_SYMBOL(security_sk_classify_flow);
 
+static struct list_head hooks_req_classify_flow;
 void security_req_classify_flow(const struct request_sock *req, struct flowi *fl)
 {
-	security_ops->req_classify_flow(req, fl);
+	call_void_hook(req_classify_flow, req, fl);
 }
 EXPORT_SYMBOL(security_req_classify_flow);
 
+static struct list_head hooks_sock_graft;
 void security_sock_graft(struct sock *sk, struct socket *parent)
 {
-	security_ops->sock_graft(sk, parent);
+	call_void_hook(sock_graft, sk, parent);
 }
 EXPORT_SYMBOL(security_sock_graft);
 
+static struct list_head hooks_inet_conn_request;
 int security_inet_conn_request(struct sock *sk,
 			struct sk_buff *skb, struct request_sock *req)
 {
-	return security_ops->inet_conn_request(sk, skb, req);
+	return call_int_hook(inet_conn_request, sk, skb, req);
 }
 EXPORT_SYMBOL(security_inet_conn_request);
 
+static struct list_head hooks_inet_csk_clone;
 void security_inet_csk_clone(struct sock *newsk,
 			const struct request_sock *req)
 {
-	security_ops->inet_csk_clone(newsk, req);
+	call_void_hook(inet_csk_clone, newsk, req);
 }
 
+static struct list_head hooks_inet_conn_established;
 void security_inet_conn_established(struct sock *sk,
 			struct sk_buff *skb)
 {
-	security_ops->inet_conn_established(sk, skb);
+	call_void_hook(inet_conn_established, sk, skb);
 }
 
+static struct list_head hooks_secmark_relabel_packet;
 int security_secmark_relabel_packet(u32 secid)
 {
-	return security_ops->secmark_relabel_packet(secid);
+	return call_int_hook(secmark_relabel_packet, secid);
 }
 EXPORT_SYMBOL(security_secmark_relabel_packet);
 
+static struct list_head hooks_secmark_refcount_inc;
 void security_secmark_refcount_inc(void)
 {
-	security_ops->secmark_refcount_inc();
+	call_void_hook(secmark_refcount_inc, );
 }
 EXPORT_SYMBOL(security_secmark_refcount_inc);
 
+static struct list_head hooks_secmark_refcount_dec;
 void security_secmark_refcount_dec(void)
 {
-	security_ops->secmark_refcount_dec();
+	call_void_hook(secmark_refcount_dec, );
 }
 EXPORT_SYMBOL(security_secmark_refcount_dec);
 
+static struct list_head hooks_tun_dev_alloc_security;
 int security_tun_dev_alloc_security(void **security)
 {
-	return security_ops->tun_dev_alloc_security(security);
+	return call_int_hook(tun_dev_alloc_security, security);
 }
 EXPORT_SYMBOL(security_tun_dev_alloc_security);
 
+static struct list_head hooks_tun_dev_free_security;
 void security_tun_dev_free_security(void *security)
 {
-	security_ops->tun_dev_free_security(security);
+	call_void_hook(tun_dev_free_security, security);
 }
 EXPORT_SYMBOL(security_tun_dev_free_security);
 
+static struct list_head hooks_tun_dev_create;
 int security_tun_dev_create(void)
 {
-	return security_ops->tun_dev_create();
+	return call_int_hook(tun_dev_create, );
 }
 EXPORT_SYMBOL(security_tun_dev_create);
 
+static struct list_head hooks_tun_dev_attach_queue;
 int security_tun_dev_attach_queue(void *security)
 {
-	return security_ops->tun_dev_attach_queue(security);
+	return call_int_hook(tun_dev_attach_queue, security);
 }
 EXPORT_SYMBOL(security_tun_dev_attach_queue);
 
+static struct list_head hooks_tun_dev_attach;
 int security_tun_dev_attach(struct sock *sk, void *security)
 {
-	return security_ops->tun_dev_attach(sk, security);
+	return call_int_hook(tun_dev_attach, sk, security);
 }
 EXPORT_SYMBOL(security_tun_dev_attach);
 
+static struct list_head hooks_tun_dev_open;
 int security_tun_dev_open(void *security)
 {
-	return security_ops->tun_dev_open(security);
+	return call_int_hook(tun_dev_open, security);
 }
 EXPORT_SYMBOL(security_tun_dev_open);
 
+static struct list_head hooks_skb_owned_by;
 void security_skb_owned_by(struct sk_buff *skb, struct sock *sk)
 {
-	security_ops->skb_owned_by(skb, sk);
+	call_void_hook(skb_owned_by, skb, sk);
 }
 
 #endif	/* CONFIG_SECURITY_NETWORK */
 
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
 
+static struct list_head hooks_xfrm_policy_alloc_security;
 int security_xfrm_policy_alloc(struct xfrm_sec_ctx **ctxp,
 			       struct xfrm_user_sec_ctx *sec_ctx,
 			       gfp_t gfp)
 {
-	return security_ops->xfrm_policy_alloc_security(ctxp, sec_ctx, gfp);
+	return call_int_hook(xfrm_policy_alloc_security, ctxp, sec_ctx, gfp);
 }
 EXPORT_SYMBOL(security_xfrm_policy_alloc);
 
+static struct list_head hooks_xfrm_policy_clone_security;
 int security_xfrm_policy_clone(struct xfrm_sec_ctx *old_ctx,
 			      struct xfrm_sec_ctx **new_ctxp)
 {
-	return security_ops->xfrm_policy_clone_security(old_ctx, new_ctxp);
+	return call_int_hook(xfrm_policy_clone_security, old_ctx, new_ctxp);
 }
 
+static struct list_head hooks_xfrm_policy_free_security;
 void security_xfrm_policy_free(struct xfrm_sec_ctx *ctx)
 {
-	security_ops->xfrm_policy_free_security(ctx);
+	call_void_hook(xfrm_policy_free_security, ctx);
 }
 EXPORT_SYMBOL(security_xfrm_policy_free);
 
+static struct list_head hooks_xfrm_policy_delete_security;
 int security_xfrm_policy_delete(struct xfrm_sec_ctx *ctx)
 {
-	return security_ops->xfrm_policy_delete_security(ctx);
+	return call_int_hook(xfrm_policy_delete_security, ctx);
 }
 
+static struct list_head hooks_xfrm_state_alloc;
 int security_xfrm_state_alloc(struct xfrm_state *x,
 			      struct xfrm_user_sec_ctx *sec_ctx)
 {
-	return security_ops->xfrm_state_alloc(x, sec_ctx);
+	return call_int_hook(xfrm_state_alloc, x, sec_ctx);
 }
 EXPORT_SYMBOL(security_xfrm_state_alloc);
 
+static struct list_head hooks_xfrm_state_alloc_acquire;
 int security_xfrm_state_alloc_acquire(struct xfrm_state *x,
 				      struct xfrm_sec_ctx *polsec, u32 secid)
 {
-	return security_ops->xfrm_state_alloc_acquire(x, polsec, secid);
+	return call_int_hook(xfrm_state_alloc_acquire, x, polsec, secid);
 }
 
+static struct list_head hooks_xfrm_state_delete_security;
 int security_xfrm_state_delete(struct xfrm_state *x)
 {
-	return security_ops->xfrm_state_delete_security(x);
+	return call_int_hook(xfrm_state_delete_security, x);
 }
 EXPORT_SYMBOL(security_xfrm_state_delete);
 
+static struct list_head hooks_xfrm_state_free_security;
 void security_xfrm_state_free(struct xfrm_state *x)
 {
-	security_ops->xfrm_state_free_security(x);
+	call_void_hook(xfrm_state_free_security, x);
 }
 
+static struct list_head hooks_xfrm_policy_lookup;
 int security_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid, u8 dir)
 {
-	return security_ops->xfrm_policy_lookup(ctx, fl_secid, dir);
+	return call_int_hook(xfrm_policy_lookup, ctx, fl_secid, dir);
 }
 
+static struct list_head hooks_xfrm_state_pol_flow_match;
 int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 				       struct xfrm_policy *xp,
 				       const struct flowi *fl)
 {
-	return security_ops->xfrm_state_pol_flow_match(x, xp, fl);
+	if (list_empty(&hooks_xfrm_state_pol_flow_match))
+		return 1;
+	return call_int_hook(xfrm_state_pol_flow_match, x, xp, fl);
 }
 
+static struct list_head hooks_xfrm_decode_session;
 int security_xfrm_decode_session(struct sk_buff *skb, u32 *secid)
 {
-	return security_ops->xfrm_decode_session(skb, secid, 1);
+	return call_int_hook(xfrm_decode_session, skb, secid, 1);
 }
 
+/*
+ * Special case with no hook for skb_classify_flow
+ */
 void security_skb_classify_flow(struct sk_buff *skb, struct flowi *fl)
 {
-	int rc = security_ops->xfrm_decode_session(skb, &fl->flowi_secid, 0);
+	int rc;
+
+	rc = call_int_hook(xfrm_decode_session, skb, &fl->flowi_secid, 0);
 
 	BUG_ON(rc);
 }
@@ -1413,51 +1761,797 @@ EXPORT_SYMBOL(security_skb_classify_flow);
 
 #ifdef CONFIG_KEYS
 
+static struct list_head hooks_key_alloc;
 int security_key_alloc(struct key *key, const struct cred *cred,
 		       unsigned long flags)
 {
-	return security_ops->key_alloc(key, cred, flags);
+	return call_int_hook(key_alloc, key, cred, flags);
 }
 
+static struct list_head hooks_key_free;
 void security_key_free(struct key *key)
 {
-	security_ops->key_free(key);
+	call_void_hook(key_free, key);
 }
 
+static struct list_head hooks_key_permission;
 int security_key_permission(key_ref_t key_ref,
 			    const struct cred *cred, key_perm_t perm)
 {
-	return security_ops->key_permission(key_ref, cred, perm);
+	return call_int_hook(key_permission, key_ref, cred, perm);
 }
 
+static struct list_head hooks_key_getsecurity;
 int security_key_getsecurity(struct key *key, char **_buffer)
 {
-	return security_ops->key_getsecurity(key, _buffer);
+	if (list_empty(&hooks_key_getsecurity)) {
+		*_buffer = NULL;
+		return 0;
+	}
+	return call_int_hook(key_getsecurity, key, _buffer);
 }
 
 #endif	/* CONFIG_KEYS */
 
 #ifdef CONFIG_AUDIT
 
+static struct list_head hooks_audit_rule_init;
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
 {
-	return security_ops->audit_rule_init(field, op, rulestr, lsmrule);
+	return call_int_hook(audit_rule_init, field, op, rulestr, lsmrule);
 }
 
+static struct list_head hooks_audit_rule_known;
 int security_audit_rule_known(struct audit_krule *krule)
 {
-	return security_ops->audit_rule_known(krule);
+	return call_int_hook(audit_rule_known, krule);
 }
 
+static struct list_head hooks_audit_rule_free;
 void security_audit_rule_free(void *lsmrule)
 {
-	security_ops->audit_rule_free(lsmrule);
+	call_void_hook(audit_rule_free, lsmrule);
 }
 
+static struct list_head hooks_audit_rule_match;
 int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
 			      struct audit_context *actx)
 {
-	return security_ops->audit_rule_match(secid, field, op, lsmrule, actx);
+	return call_int_hook(audit_rule_match, secid, field, op, lsmrule, actx);
 }
 
 #endif /* CONFIG_AUDIT */
+
+static int __init add_hook_to_list(struct list_head *hooklist,
+					void *interesting,
+					struct security_operations *sop)
+{
+	struct security_hook_list *new;
+	struct security_hook_list *shp;
+
+	if (hooklist->next == NULL)
+		INIT_LIST_HEAD(hooklist);
+
+	if (interesting == NULL)
+		return 0;
+
+	new = kzalloc(sizeof(*new), GFP_KERNEL);
+	if (new == NULL)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&new->shl_head);
+	new->shl_ops = sop;
+
+	shp = list_last_entry(hooklist, struct security_hook_list, shl_head);
+	list_add_rcu(&new->shl_head, &shp->shl_head);
+
+	return 0;
+}
+
+static int __init security_enlist_ops(struct security_operations *sop)
+{
+	printk(KERN_INFO "Security operations for %s initialized\n", sop->name);
+
+	if (add_hook_to_list(&hooks_ptrace_access_check,
+				sop->ptrace_access_check, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_ptrace_traceme, sop->ptrace_traceme, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_capget, sop->capget, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_capset, sop->capset, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_capable, sop->capable, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_quotactl, sop->quotactl, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_quota_on, sop->quota_on, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_syslog, sop->syslog, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_settime, sop->settime, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_vm_enough_memory,
+				sop->vm_enough_memory, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_bprm_set_creds, sop->bprm_set_creds, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_bprm_committing_creds,
+				sop->bprm_committing_creds, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_bprm_committed_creds,
+				sop->bprm_committed_creds, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_bprm_check_security,
+				sop->bprm_check_security, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_bprm_secureexec, sop->bprm_secureexec, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_sb_alloc_security,
+				sop->sb_alloc_security, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_sb_free_security,
+				sop->sb_free_security, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_sb_copy_data, sop->sb_copy_data, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_sb_remount, sop->sb_remount, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_sb_kern_mount, sop->sb_kern_mount, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_sb_show_options, sop->sb_show_options, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_sb_statfs, sop->sb_statfs, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_sb_mount, sop->sb_mount, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_sb_umount, sop->sb_umount, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_sb_pivotroot, sop->sb_pivotroot, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_sb_set_mnt_opts, sop->sb_set_mnt_opts, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_sb_clone_mnt_opts,
+				sop->sb_clone_mnt_opts, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_sb_parse_opts_str,
+				sop->sb_parse_opts_str, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_dentry_init_security,
+				sop->dentry_init_security, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_inode_alloc_security,
+				sop->inode_alloc_security, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_inode_free_security,
+				sop->inode_free_security, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_inode_init_security,
+				sop->inode_init_security, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_inode_create, sop->inode_create, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_inode_link, sop->inode_link, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_inode_unlink, sop->inode_unlink, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_inode_symlink, sop->inode_symlink, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_inode_mkdir, sop->inode_mkdir, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_inode_rmdir, sop->inode_rmdir, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_inode_mknod, sop->inode_mknod, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_inode_rename, sop->inode_rename, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_inode_readlink, sop->inode_readlink, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_inode_follow_link,
+				sop->inode_follow_link, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_inode_permission,
+				sop->inode_permission, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_inode_setattr, sop->inode_setattr, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_inode_getattr, sop->inode_getattr, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_inode_setxattr, sop->inode_setxattr, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_inode_post_setxattr,
+				sop->inode_post_setxattr, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_inode_getxattr, sop->inode_getxattr, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_inode_listxattr, sop->inode_listxattr, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_inode_removexattr,
+				sop->inode_removexattr, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_inode_need_killpriv,
+				sop->inode_need_killpriv, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_inode_killpriv, sop->inode_killpriv, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_inode_getsecurity,
+				sop->inode_getsecurity, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_inode_setsecurity,
+				sop->inode_setsecurity, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_inode_listsecurity,
+				sop->inode_listsecurity, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_inode_getsecid,
+				sop->inode_getsecid, sop))
+		return -ENOMEM;
+#ifdef CONFIG_SECURITY_PATH
+	if (add_hook_to_list(&hooks_path_mknod, sop->path_mknod, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_path_mkdir, sop->path_mkdir, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_path_rmdir, sop->path_rmdir, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_path_unlink, sop->path_unlink, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_path_symlink, sop->path_symlink, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_path_link, sop->path_link, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_path_rename, sop->path_rename, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_path_truncate, sop->path_truncate, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_path_chmod, sop->path_chmod, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_path_chown, sop->path_chown, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_path_chroot, sop->path_chroot, sop))
+		return -ENOMEM;
+#endif
+	if (add_hook_to_list(&hooks_file_permission, sop->file_permission, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_file_alloc_security,
+				sop->file_alloc_security, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_file_free_security,
+				sop->file_free_security, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_file_ioctl, sop->file_ioctl, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_mmap_addr, sop->mmap_addr, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_mmap_file, sop->mmap_file, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_file_mprotect, sop->file_mprotect, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_file_lock, sop->file_lock, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_file_fcntl, sop->file_fcntl, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_file_set_fowner, sop->file_set_fowner, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_file_send_sigiotask,
+				sop->file_send_sigiotask, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_file_receive, sop->file_receive, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_file_open, sop->file_open, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_task_create, sop->task_create, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_task_free, sop->task_free, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_cred_alloc_blank,
+				sop->cred_alloc_blank, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_cred_free, sop->cred_free, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_cred_prepare, sop->cred_prepare, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_cred_transfer, sop->cred_transfer, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_kernel_act_as, sop->kernel_act_as, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_kernel_create_files_as,
+				sop->kernel_create_files_as, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_kernel_module_request,
+				sop->kernel_module_request, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_kernel_module_from_file,
+				sop->kernel_module_from_file, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_task_fix_setuid, sop->task_fix_setuid, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_task_setpgid, sop->task_setpgid, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_task_getpgid, sop->task_getpgid, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_task_getsid, sop->task_getsid, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_task_getsecid, sop->task_getsecid, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_task_setnice, sop->task_setnice, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_task_setioprio, sop->task_setioprio, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_task_getioprio, sop->task_getioprio, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_task_setrlimit, sop->task_setrlimit, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_task_setscheduler,
+				sop->task_setscheduler, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_task_getscheduler,
+				sop->task_getscheduler, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_task_movememory, sop->task_movememory, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_task_wait, sop->task_wait, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_task_kill, sop->task_kill, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_task_prctl, sop->task_prctl, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_task_to_inode, sop->task_to_inode, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_ipc_permission, sop->ipc_permission, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_ipc_getsecid, sop->ipc_getsecid, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_msg_msg_alloc_security,
+				sop->msg_msg_alloc_security, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_msg_msg_free_security,
+				sop->msg_msg_free_security, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_msg_queue_alloc_security,
+				sop->msg_queue_alloc_security, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_msg_queue_free_security,
+				sop->msg_queue_free_security, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_msg_queue_associate,
+				sop->msg_queue_associate, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_msg_queue_msgctl,
+				sop->msg_queue_msgctl, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_msg_queue_msgsnd,
+				sop->msg_queue_msgsnd, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_msg_queue_msgrcv,
+				sop->msg_queue_msgrcv, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_shm_alloc_security,
+				sop->shm_alloc_security, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_shm_free_security,
+				sop->shm_free_security, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_shm_associate, sop->shm_associate, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_shm_shmctl, sop->shm_shmctl, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_shm_shmat, sop->shm_shmat, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_sem_alloc_security,
+				sop->sem_alloc_security, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_sem_free_security,
+				sop->sem_free_security, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_sem_associate, sop->sem_associate, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_sem_semctl, sop->sem_semctl, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_sem_semop, sop->sem_semop, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_netlink_send, sop->netlink_send, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_d_instantiate, sop->d_instantiate, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_getprocattr, sop->getprocattr, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_setprocattr, sop->setprocattr, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_ismaclabel, sop->ismaclabel, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_secid_to_secctx, sop->secid_to_secctx, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_secctx_to_secid, sop->secctx_to_secid, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_release_secctx, sop->release_secctx, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_inode_notifysecctx,
+				sop->inode_notifysecctx, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_inode_setsecctx, sop->inode_setsecctx, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_inode_getsecctx, sop->inode_getsecctx, sop))
+		return -ENOMEM;
+#ifdef CONFIG_SECURITY_NETWORK
+	if (add_hook_to_list(&hooks_unix_stream_connect,
+				sop->unix_stream_connect, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_unix_may_send, sop->unix_may_send, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_socket_create, sop->socket_create, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_socket_post_create,
+				sop->socket_post_create, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_socket_bind, sop->socket_bind, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_socket_connect, sop->socket_connect, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_socket_listen, sop->socket_listen, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_socket_accept, sop->socket_accept, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_socket_sendmsg, sop->socket_sendmsg, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_socket_recvmsg, sop->socket_recvmsg, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_socket_getsockname,
+				sop->socket_getsockname, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_socket_getpeername,
+				sop->socket_getpeername, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_socket_setsockopt,
+				sop->socket_setsockopt, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_socket_getsockopt,
+				sop->socket_getsockopt, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_socket_shutdown, sop->socket_shutdown, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_socket_sock_rcv_skb,
+				sop->socket_sock_rcv_skb, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_socket_getpeersec_stream,
+				sop->socket_getpeersec_stream, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_socket_getpeersec_dgram,
+				sop->socket_getpeersec_dgram, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_sk_alloc_security,
+				sop->sk_alloc_security, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_sk_free_security,
+				sop->sk_free_security, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_sk_clone_security,
+				sop->sk_clone_security, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_sk_getsecid, sop->sk_getsecid, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_sock_graft, sop->sock_graft, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_inet_conn_request,
+				sop->inet_conn_request, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_inet_csk_clone, sop->inet_csk_clone, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_inet_conn_established,
+				sop->inet_conn_established, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_secmark_relabel_packet,
+				sop->secmark_relabel_packet, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_secmark_refcount_inc,
+				sop->secmark_refcount_inc, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_secmark_refcount_dec,
+				sop->secmark_refcount_dec, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_req_classify_flow,
+				sop->req_classify_flow, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_tun_dev_alloc_security,
+				sop->tun_dev_alloc_security, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_tun_dev_free_security,
+				sop->tun_dev_free_security, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_tun_dev_create, sop->tun_dev_create, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_tun_dev_open, sop->tun_dev_open, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_tun_dev_attach_queue,
+				sop->tun_dev_attach_queue, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_tun_dev_attach, sop->tun_dev_attach, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_skb_owned_by, sop->skb_owned_by, sop))
+		return -ENOMEM;
+#endif	/* CONFIG_SECURITY_NETWORK */
+#ifdef CONFIG_SECURITY_NETWORK_XFRM
+	if (add_hook_to_list(&hooks_xfrm_policy_alloc_security,
+				sop->xfrm_policy_alloc_security, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_xfrm_policy_clone_security,
+				sop->xfrm_policy_clone_security, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_xfrm_policy_free_security,
+				sop->xfrm_policy_free_security, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_xfrm_policy_delete_security,
+				sop->xfrm_policy_delete_security, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_xfrm_state_alloc,
+				sop->xfrm_state_alloc, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_xfrm_state_alloc_acquire,
+				sop->xfrm_state_alloc_acquire, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_xfrm_state_free_security,
+				sop->xfrm_state_free_security, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_xfrm_state_delete_security,
+				sop->xfrm_state_delete_security, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_xfrm_policy_lookup,
+				sop->xfrm_policy_lookup, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_xfrm_state_pol_flow_match,
+				sop->xfrm_state_pol_flow_match, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_xfrm_decode_session,
+				sop->xfrm_decode_session, sop))
+		return -ENOMEM;
+#endif	/* CONFIG_SECURITY_NETWORK_XFRM */
+#ifdef CONFIG_KEYS
+	if (add_hook_to_list(&hooks_key_alloc, sop->key_alloc, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_key_free, sop->key_free, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_key_permission, sop->key_permission, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_key_getsecurity, sop->key_getsecurity, sop))
+		return -ENOMEM;
+#endif	/* CONFIG_KEYS */
+#ifdef CONFIG_AUDIT
+	if (add_hook_to_list(&hooks_audit_rule_init, sop->audit_rule_init, sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_audit_rule_known, sop->audit_rule_known,
+				sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_audit_rule_match, sop->audit_rule_match,
+				sop))
+		return -ENOMEM;
+	if (add_hook_to_list(&hooks_audit_rule_free, sop->audit_rule_free, sop))
+		return -ENOMEM;
+#endif
+	return 0;
+}
+
+#ifdef CONFIG_SECURITY_SELINUX_DISABLE
+static void clear_hook_entry(struct list_head *head,
+				struct security_operations *sop)
+{
+	struct security_hook_list *shp;
+
+	if (head->next == NULL)
+		return;
+	if (list_empty(head))
+		return;
+
+	list_for_each_entry(shp, head, shl_head)
+		if (shp->shl_ops == sop) {
+			shp->shl_ops = NULL;
+			return;
+		}
+}
+
+void security_module_disable(struct security_operations *sop)
+{
+	printk(KERN_INFO "Security operations for %s disabled.\n", sop->name);
+	clear_hook_entry(&hooks_ptrace_access_check, sop);
+	clear_hook_entry(&hooks_ptrace_traceme, sop);
+	clear_hook_entry(&hooks_capget, sop);
+	clear_hook_entry(&hooks_capset, sop);
+	clear_hook_entry(&hooks_capable, sop);
+	clear_hook_entry(&hooks_quotactl, sop);
+	clear_hook_entry(&hooks_quota_on, sop);
+	clear_hook_entry(&hooks_syslog, sop);
+	clear_hook_entry(&hooks_settime, sop);
+	clear_hook_entry(&hooks_vm_enough_memory, sop);
+	clear_hook_entry(&hooks_bprm_set_creds, sop);
+	clear_hook_entry(&hooks_bprm_committing_creds, sop);
+	clear_hook_entry(&hooks_bprm_committed_creds, sop);
+	clear_hook_entry(&hooks_bprm_check_security, sop);
+	clear_hook_entry(&hooks_bprm_secureexec, sop);
+	clear_hook_entry(&hooks_sb_alloc_security, sop);
+	clear_hook_entry(&hooks_sb_free_security, sop);
+	clear_hook_entry(&hooks_sb_copy_data, sop);
+	clear_hook_entry(&hooks_sb_remount, sop);
+	clear_hook_entry(&hooks_sb_kern_mount, sop);
+	clear_hook_entry(&hooks_sb_show_options, sop);
+	clear_hook_entry(&hooks_sb_statfs, sop);
+	clear_hook_entry(&hooks_sb_mount, sop);
+	clear_hook_entry(&hooks_sb_umount, sop);
+	clear_hook_entry(&hooks_sb_pivotroot, sop);
+	clear_hook_entry(&hooks_sb_set_mnt_opts, sop);
+	clear_hook_entry(&hooks_sb_clone_mnt_opts, sop);
+	clear_hook_entry(&hooks_sb_parse_opts_str, sop);
+	clear_hook_entry(&hooks_dentry_init_security, sop);
+	clear_hook_entry(&hooks_inode_alloc_security, sop);
+	clear_hook_entry(&hooks_inode_free_security, sop);
+	clear_hook_entry(&hooks_inode_init_security, sop);
+	clear_hook_entry(&hooks_inode_create, sop);
+	clear_hook_entry(&hooks_inode_link, sop);
+	clear_hook_entry(&hooks_inode_unlink, sop);
+	clear_hook_entry(&hooks_inode_symlink, sop);
+	clear_hook_entry(&hooks_inode_mkdir, sop);
+	clear_hook_entry(&hooks_inode_rmdir, sop);
+	clear_hook_entry(&hooks_inode_mknod, sop);
+	clear_hook_entry(&hooks_inode_rename, sop);
+	clear_hook_entry(&hooks_inode_readlink, sop);
+	clear_hook_entry(&hooks_inode_follow_link, sop);
+	clear_hook_entry(&hooks_inode_permission, sop);
+	clear_hook_entry(&hooks_inode_setattr, sop);
+	clear_hook_entry(&hooks_inode_getattr, sop);
+	clear_hook_entry(&hooks_inode_setxattr, sop);
+	clear_hook_entry(&hooks_inode_post_setxattr, sop);
+	clear_hook_entry(&hooks_inode_getxattr, sop);
+	clear_hook_entry(&hooks_inode_listxattr, sop);
+	clear_hook_entry(&hooks_inode_removexattr, sop);
+	clear_hook_entry(&hooks_inode_need_killpriv, sop);
+	clear_hook_entry(&hooks_inode_killpriv, sop);
+	clear_hook_entry(&hooks_inode_getsecurity, sop);
+	clear_hook_entry(&hooks_inode_setsecurity, sop);
+	clear_hook_entry(&hooks_inode_listsecurity, sop);
+	clear_hook_entry(&hooks_inode_getsecid, sop);
+#ifdef CONFIG_SECURITY_PATH
+	clear_hook_entry(&hooks_path_mknod, sop);
+	clear_hook_entry(&hooks_path_mkdir, sop);
+	clear_hook_entry(&hooks_path_rmdir, sop);
+	clear_hook_entry(&hooks_path_unlink, sop);
+	clear_hook_entry(&hooks_path_symlink, sop);
+	clear_hook_entry(&hooks_path_link, sop);
+	clear_hook_entry(&hooks_path_rename, sop);
+	clear_hook_entry(&hooks_path_truncate, sop);
+	clear_hook_entry(&hooks_path_chmod, sop);
+	clear_hook_entry(&hooks_path_chown, sop);
+	clear_hook_entry(&hooks_path_chroot, sop);
+#endif
+	clear_hook_entry(&hooks_file_permission, sop);
+	clear_hook_entry(&hooks_file_alloc_security, sop);
+	clear_hook_entry(&hooks_file_free_security, sop);
+	clear_hook_entry(&hooks_file_ioctl, sop);
+	clear_hook_entry(&hooks_mmap_addr, sop);
+	clear_hook_entry(&hooks_mmap_file, sop);
+	clear_hook_entry(&hooks_file_mprotect, sop);
+	clear_hook_entry(&hooks_file_lock, sop);
+	clear_hook_entry(&hooks_file_fcntl, sop);
+	clear_hook_entry(&hooks_file_set_fowner, sop);
+	clear_hook_entry(&hooks_file_send_sigiotask, sop);
+	clear_hook_entry(&hooks_file_receive, sop);
+	clear_hook_entry(&hooks_file_open, sop);
+	clear_hook_entry(&hooks_task_create, sop);
+	clear_hook_entry(&hooks_task_free, sop);
+	clear_hook_entry(&hooks_cred_alloc_blank, sop);
+	clear_hook_entry(&hooks_cred_free, sop);
+	clear_hook_entry(&hooks_cred_prepare, sop);
+	clear_hook_entry(&hooks_cred_transfer, sop);
+	clear_hook_entry(&hooks_kernel_act_as, sop);
+	clear_hook_entry(&hooks_kernel_create_files_as, sop);
+	clear_hook_entry(&hooks_kernel_module_request, sop);
+	clear_hook_entry(&hooks_kernel_module_from_file, sop);
+	clear_hook_entry(&hooks_task_fix_setuid, sop);
+	clear_hook_entry(&hooks_task_setpgid, sop);
+	clear_hook_entry(&hooks_task_getpgid, sop);
+	clear_hook_entry(&hooks_task_getsid, sop);
+	clear_hook_entry(&hooks_task_getsecid, sop);
+	clear_hook_entry(&hooks_task_setnice, sop);
+	clear_hook_entry(&hooks_task_setioprio, sop);
+	clear_hook_entry(&hooks_task_getioprio, sop);
+	clear_hook_entry(&hooks_task_setrlimit, sop);
+	clear_hook_entry(&hooks_task_setscheduler, sop);
+	clear_hook_entry(&hooks_task_getscheduler, sop);
+	clear_hook_entry(&hooks_task_movememory, sop);
+	clear_hook_entry(&hooks_task_wait, sop);
+	clear_hook_entry(&hooks_task_kill, sop);
+	clear_hook_entry(&hooks_task_prctl, sop);
+	clear_hook_entry(&hooks_task_to_inode, sop);
+	clear_hook_entry(&hooks_ipc_permission, sop);
+	clear_hook_entry(&hooks_ipc_getsecid, sop);
+	clear_hook_entry(&hooks_msg_msg_alloc_security, sop);
+	clear_hook_entry(&hooks_msg_msg_free_security, sop);
+	clear_hook_entry(&hooks_msg_queue_alloc_security, sop);
+	clear_hook_entry(&hooks_msg_queue_free_security, sop);
+	clear_hook_entry(&hooks_msg_queue_associate, sop);
+	clear_hook_entry(&hooks_msg_queue_msgctl, sop);
+	clear_hook_entry(&hooks_msg_queue_msgsnd, sop);
+	clear_hook_entry(&hooks_msg_queue_msgrcv, sop);
+	clear_hook_entry(&hooks_shm_alloc_security, sop);
+	clear_hook_entry(&hooks_shm_free_security, sop);
+	clear_hook_entry(&hooks_shm_associate, sop);
+	clear_hook_entry(&hooks_shm_shmctl, sop);
+	clear_hook_entry(&hooks_shm_shmat, sop);
+	clear_hook_entry(&hooks_sem_alloc_security, sop);
+	clear_hook_entry(&hooks_sem_free_security, sop);
+	clear_hook_entry(&hooks_sem_associate, sop);
+	clear_hook_entry(&hooks_sem_semctl, sop);
+	clear_hook_entry(&hooks_sem_semop, sop);
+	clear_hook_entry(&hooks_netlink_send, sop);
+	clear_hook_entry(&hooks_d_instantiate, sop);
+	clear_hook_entry(&hooks_getprocattr, sop);
+	clear_hook_entry(&hooks_setprocattr, sop);
+	clear_hook_entry(&hooks_ismaclabel, sop);
+	clear_hook_entry(&hooks_secid_to_secctx, sop);
+	clear_hook_entry(&hooks_secctx_to_secid, sop);
+	clear_hook_entry(&hooks_release_secctx, sop);
+	clear_hook_entry(&hooks_inode_notifysecctx, sop);
+	clear_hook_entry(&hooks_inode_setsecctx, sop);
+	clear_hook_entry(&hooks_inode_getsecctx, sop);
+#ifdef CONFIG_SECURITY_NETWORK
+	clear_hook_entry(&hooks_unix_stream_connect, sop);
+	clear_hook_entry(&hooks_unix_may_send, sop);
+	clear_hook_entry(&hooks_socket_create, sop);
+	clear_hook_entry(&hooks_socket_post_create, sop);
+	clear_hook_entry(&hooks_socket_bind, sop);
+	clear_hook_entry(&hooks_socket_connect, sop);
+	clear_hook_entry(&hooks_socket_listen, sop);
+	clear_hook_entry(&hooks_socket_accept, sop);
+	clear_hook_entry(&hooks_socket_sendmsg, sop);
+	clear_hook_entry(&hooks_socket_recvmsg, sop);
+	clear_hook_entry(&hooks_socket_getsockname, sop);
+	clear_hook_entry(&hooks_socket_getpeername, sop);
+	clear_hook_entry(&hooks_socket_setsockopt, sop);
+	clear_hook_entry(&hooks_socket_getsockopt, sop);
+	clear_hook_entry(&hooks_socket_shutdown, sop);
+	clear_hook_entry(&hooks_socket_sock_rcv_skb, sop);
+	clear_hook_entry(&hooks_socket_getpeersec_stream, sop);
+	clear_hook_entry(&hooks_socket_getpeersec_dgram, sop);
+	clear_hook_entry(&hooks_sk_alloc_security, sop);
+	clear_hook_entry(&hooks_sk_free_security, sop);
+	clear_hook_entry(&hooks_sk_clone_security, sop);
+	clear_hook_entry(&hooks_sk_getsecid, sop);
+	clear_hook_entry(&hooks_sock_graft, sop);
+	clear_hook_entry(&hooks_inet_conn_request, sop);
+	clear_hook_entry(&hooks_inet_csk_clone, sop);
+	clear_hook_entry(&hooks_inet_conn_established, sop);
+	clear_hook_entry(&hooks_secmark_relabel_packet, sop);
+	clear_hook_entry(&hooks_secmark_refcount_inc, sop);
+	clear_hook_entry(&hooks_secmark_refcount_dec, sop);
+	clear_hook_entry(&hooks_req_classify_flow, sop);
+	clear_hook_entry(&hooks_tun_dev_alloc_security, sop);
+	clear_hook_entry(&hooks_tun_dev_free_security, sop);
+	clear_hook_entry(&hooks_tun_dev_create, sop);
+	clear_hook_entry(&hooks_tun_dev_open, sop);
+	clear_hook_entry(&hooks_tun_dev_attach_queue, sop);
+	clear_hook_entry(&hooks_tun_dev_attach, sop);
+	clear_hook_entry(&hooks_skb_owned_by, sop);
+#endif	/* CONFIG_SECURITY_NETWORK */
+#ifdef CONFIG_SECURITY_NETWORK_XFRM
+	clear_hook_entry(&hooks_xfrm_policy_alloc_security, sop);
+	clear_hook_entry(&hooks_xfrm_policy_clone_security, sop);
+	clear_hook_entry(&hooks_xfrm_policy_free_security, sop);
+	clear_hook_entry(&hooks_xfrm_policy_delete_security, sop);
+	clear_hook_entry(&hooks_xfrm_state_alloc, sop);
+	clear_hook_entry(&hooks_xfrm_state_alloc_acquire, sop);
+	clear_hook_entry(&hooks_xfrm_state_free_security, sop);
+	clear_hook_entry(&hooks_xfrm_state_delete_security, sop);
+	clear_hook_entry(&hooks_xfrm_policy_lookup, sop);
+	clear_hook_entry(&hooks_xfrm_state_pol_flow_match, sop);
+	clear_hook_entry(&hooks_xfrm_decode_session, sop);
+#endif	/* CONFIG_SECURITY_NETWORK_XFRM */
+#ifdef CONFIG_KEYS
+	clear_hook_entry(&hooks_key_alloc, sop);
+	clear_hook_entry(&hooks_key_free, sop);
+	clear_hook_entry(&hooks_key_permission, sop);
+	clear_hook_entry(&hooks_key_getsecurity, sop);
+#endif	/* CONFIG_KEYS */
+#ifdef CONFIG_AUDIT
+	clear_hook_entry(&hooks_audit_rule_init, sop);
+	clear_hook_entry(&hooks_audit_rule_known, sop);
+	clear_hook_entry(&hooks_audit_rule_match, sop);
+	clear_hook_entry(&hooks_audit_rule_free, sop);
+#endif
+}
+#endif /* CONFIG_SECURITY_SELINUX_DISABLE */
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 2c7341d..6c74150 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -95,8 +95,6 @@
 #include "audit.h"
 #include "avc_ss.h"
 
-extern struct security_operations *security_ops;
-
 /* SECMARK reference count */
 static atomic_t selinux_secmark_refcount = ATOMIC_INIT(0);
 
@@ -174,7 +172,7 @@ static void cred_init_security(void)
 		panic("SELinux:  Failed to initialize initial task.\n");
 
 	tsec->osid = tsec->sid = SECINITSID_KERNEL;
-	cred->security = tsec;
+	cred->cred_selinux = tsec;
 }
 
 /*
@@ -184,7 +182,7 @@ static inline u32 cred_sid(const struct cred *cred)
 {
 	const struct task_security_struct *tsec;
 
-	tsec = cred->security;
+	tsec = cred->cred_selinux;
 	return tsec->sid;
 }
 
@@ -206,7 +204,7 @@ static inline u32 task_sid(const struct task_struct *task)
  */
 static inline u32 current_sid(void)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec = current_selinux();
 
 	return tsec->sid;
 }
@@ -215,52 +213,31 @@ static inline u32 current_sid(void)
 
 static int inode_alloc_security(struct inode *inode)
 {
-	struct inode_security_struct *isec;
+	struct inode_selinux *isec = &inode->i_selinux;
 	u32 sid = current_sid();
 
-	isec = kmem_cache_zalloc(sel_inode_cache, GFP_NOFS);
-	if (!isec)
-		return -ENOMEM;
+	memset(isec, 0, sizeof(*isec));
 
 	mutex_init(&isec->lock);
 	INIT_LIST_HEAD(&isec->list);
-	isec->inode = inode;
 	isec->sid = SECINITSID_UNLABELED;
 	isec->sclass = SECCLASS_FILE;
 	isec->task_sid = sid;
-	inode->i_security = isec;
 
 	return 0;
 }
 
-static void inode_free_rcu(struct rcu_head *head)
-{
-	struct inode_security_struct *isec;
-
-	isec = container_of(head, struct inode_security_struct, rcu);
-	kmem_cache_free(sel_inode_cache, isec);
-}
-
 static void inode_free_security(struct inode *inode)
 {
-	struct inode_security_struct *isec = inode->i_security;
-	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
+	struct inode_selinux *isec = &inode->i_selinux;
+	struct superblock_security_struct *sbsec = inode->i_sb->s_selinux;
 
 	spin_lock(&sbsec->isec_lock);
 	if (!list_empty(&isec->list))
 		list_del_init(&isec->list);
 	spin_unlock(&sbsec->isec_lock);
 
-	/*
-	 * The inode may still be referenced in a path walk and
-	 * a call to selinux_inode_permission() can be made
-	 * after inode_free_security() is called. Ideally, the VFS
-	 * wouldn't do this, but fixing that is a much harder
-	 * job. For now, simply free the i_security via RCU, and
-	 * leave the current inode->i_security pointer intact.
-	 * The inode will be freed after the RCU grace period too.
-	 */
-	call_rcu(&isec->rcu, inode_free_rcu);
+	memset(isec, 0, sizeof(*isec));
 }
 
 static int file_alloc_security(struct file *file)
@@ -274,15 +251,15 @@ static int file_alloc_security(struct file *file)
 
 	fsec->sid = sid;
 	fsec->fown_sid = sid;
-	file->f_security = fsec;
+	file->f_selinux = fsec;
 
 	return 0;
 }
 
 static void file_free_security(struct file *file)
 {
-	struct file_security_struct *fsec = file->f_security;
-	file->f_security = NULL;
+	struct file_security_struct *fsec = file->f_selinux;
+	file->f_selinux = NULL;
 	kfree(fsec);
 }
 
@@ -301,15 +278,15 @@ static int superblock_alloc_security(struct super_block *sb)
 	sbsec->sid = SECINITSID_UNLABELED;
 	sbsec->def_sid = SECINITSID_FILE;
 	sbsec->mntpoint_sid = SECINITSID_UNLABELED;
-	sb->s_security = sbsec;
+	sb->s_selinux = sbsec;
 
 	return 0;
 }
 
 static void superblock_free_security(struct super_block *sb)
 {
-	struct superblock_security_struct *sbsec = sb->s_security;
-	sb->s_security = NULL;
+	struct superblock_security_struct *sbsec = sb->s_selinux;
+	sb->s_selinux = NULL;
 	kfree(sbsec);
 }
 
@@ -359,7 +336,7 @@ static int may_context_mount_sb_relabel(u32 sid,
 			struct superblock_security_struct *sbsec,
 			const struct cred *cred)
 {
-	const struct task_security_struct *tsec = cred->security;
+	const struct task_security_struct *tsec = cred->cred_selinux;
 	int rc;
 
 	rc = avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
@@ -376,7 +353,7 @@ static int may_context_mount_inode_relabel(u32 sid,
 			struct superblock_security_struct *sbsec,
 			const struct cred *cred)
 {
-	const struct task_security_struct *tsec = cred->security;
+	const struct task_security_struct *tsec = cred->cred_selinux;
 	int rc;
 	rc = avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELFROM, NULL);
@@ -390,7 +367,7 @@ static int may_context_mount_inode_relabel(u32 sid,
 
 static int selinux_is_sblabel_mnt(struct super_block *sb)
 {
-	struct superblock_security_struct *sbsec = sb->s_security;
+	struct superblock_security_struct *sbsec = sb->s_selinux;
 
 	if (sbsec->behavior == SECURITY_FS_USE_XATTR ||
 	    sbsec->behavior == SECURITY_FS_USE_TRANS ||
@@ -413,7 +390,7 @@ static int selinux_is_sblabel_mnt(struct super_block *sb)
 
 static int sb_finish_set_opts(struct super_block *sb)
 {
-	struct superblock_security_struct *sbsec = sb->s_security;
+	struct superblock_security_struct *sbsec = sb->s_selinux;
 	struct dentry *root = sb->s_root;
 	struct inode *root_inode = root->d_inode;
 	int rc = 0;
@@ -466,10 +443,11 @@ static int sb_finish_set_opts(struct super_block *sb)
 	spin_lock(&sbsec->isec_lock);
 next_inode:
 	if (!list_empty(&sbsec->isec_head)) {
-		struct inode_security_struct *isec =
+		struct inode_selinux *isec =
 				list_entry(sbsec->isec_head.next,
-					   struct inode_security_struct, list);
-		struct inode *inode = isec->inode;
+					   struct inode_selinux, list);
+		struct inode *inode =
+				container_of(isec, struct inode, i_selinux);
 		spin_unlock(&sbsec->isec_lock);
 		inode = igrab(inode);
 		if (inode) {
@@ -495,7 +473,7 @@ static int selinux_get_mnt_opts(const struct super_block *sb,
 				struct security_mnt_opts *opts)
 {
 	int rc = 0, i;
-	struct superblock_security_struct *sbsec = sb->s_security;
+	struct superblock_security_struct *sbsec = sb->s_selinux;
 	char *context = NULL;
 	u32 len;
 	char tmp;
@@ -558,7 +536,7 @@ static int selinux_get_mnt_opts(const struct super_block *sb,
 	}
 	if (sbsec->flags & ROOTCONTEXT_MNT) {
 		struct inode *root = sbsec->sb->s_root->d_inode;
-		struct inode_security_struct *isec = root->i_security;
+		struct inode_selinux *isec = &root->i_selinux;
 
 		rc = security_sid_to_context(isec->sid, &context, &len);
 		if (rc)
@@ -611,10 +589,10 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 {
 	const struct cred *cred = current_cred();
 	int rc = 0, i;
-	struct superblock_security_struct *sbsec = sb->s_security;
+	struct superblock_security_struct *sbsec = sb->s_selinux;
 	const char *name = sb->s_type->name;
 	struct inode *inode = sbsec->sb->s_root->d_inode;
-	struct inode_security_struct *root_isec = inode->i_security;
+	struct inode_selinux *root_isec = &inode->i_selinux;
 	u32 fscontext_sid = 0, context_sid = 0, rootcontext_sid = 0;
 	u32 defcontext_sid = 0;
 	char **mount_options = opts->mnt_opts;
@@ -826,8 +804,8 @@ out_double_mount:
 static int selinux_cmp_sb_context(const struct super_block *oldsb,
 				    const struct super_block *newsb)
 {
-	struct superblock_security_struct *old = oldsb->s_security;
-	struct superblock_security_struct *new = newsb->s_security;
+	struct superblock_security_struct *old = oldsb->s_selinux;
+	struct superblock_security_struct *new = newsb->s_selinux;
 	char oldflags = old->flags & SE_MNTMASK;
 	char newflags = new->flags & SE_MNTMASK;
 
@@ -840,8 +818,8 @@ static int selinux_cmp_sb_context(const struct super_block *oldsb,
 	if ((oldflags & DEFCONTEXT_MNT) && old->def_sid != new->def_sid)
 		goto mismatch;
 	if (oldflags & ROOTCONTEXT_MNT) {
-		struct inode_security_struct *oldroot = oldsb->s_root->d_inode->i_security;
-		struct inode_security_struct *newroot = newsb->s_root->d_inode->i_security;
+		struct inode_selinux *oldroot = &oldsb->s_root->d_inode->i_selinux;
+		struct inode_selinux *newroot = &newsb->s_root->d_inode->i_selinux;
 		if (oldroot->sid != newroot->sid)
 			goto mismatch;
 	}
@@ -856,8 +834,8 @@ mismatch:
 static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
 					struct super_block *newsb)
 {
-	const struct superblock_security_struct *oldsbsec = oldsb->s_security;
-	struct superblock_security_struct *newsbsec = newsb->s_security;
+	const struct superblock_security_struct *oldsbsec = oldsb->s_selinux;
+	struct superblock_security_struct *newsbsec = newsb->s_selinux;
 
 	int set_fscontext =	(oldsbsec->flags & FSCONTEXT_MNT);
 	int set_context =	(oldsbsec->flags & CONTEXT_MNT);
@@ -892,16 +870,16 @@ static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
 			newsbsec->sid = sid;
 		if (!set_rootcontext) {
 			struct inode *newinode = newsb->s_root->d_inode;
-			struct inode_security_struct *newisec = newinode->i_security;
+			struct inode_selinux *newisec = &newinode->i_selinux;
 			newisec->sid = sid;
 		}
 		newsbsec->mntpoint_sid = sid;
 	}
 	if (set_rootcontext) {
 		const struct inode *oldinode = oldsb->s_root->d_inode;
-		const struct inode_security_struct *oldisec = oldinode->i_security;
+		const struct inode_selinux *oldisec = &oldinode->i_selinux;
 		struct inode *newinode = newsb->s_root->d_inode;
-		struct inode_security_struct *newisec = newinode->i_security;
+		struct inode_selinux *newisec = &newinode->i_selinux;
 
 		newisec->sid = oldisec->sid;
 	}
@@ -1266,7 +1244,7 @@ static int selinux_proc_get_sid(struct dentry *dentry,
 static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dentry)
 {
 	struct superblock_security_struct *sbsec = NULL;
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_selinux *isec = &inode->i_selinux;
 	u32 sid;
 	struct dentry *dentry;
 #define INITCONTEXTLEN 255
@@ -1281,7 +1259,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 	if (isec->initialized)
 		goto out_unlock;
 
-	sbsec = inode->i_sb->s_security;
+	sbsec = inode->i_sb->s_selinux;
 	if (!(sbsec->flags & SE_SBINITIALIZED)) {
 		/* Defer initialization until selinux_complete_init,
 		   after the initial policy is loaded and the security
@@ -1513,8 +1491,8 @@ static int task_has_perm(const struct task_struct *tsk1,
 	u32 sid1, sid2;
 
 	rcu_read_lock();
-	__tsec1 = __task_cred(tsk1)->security;	sid1 = __tsec1->sid;
-	__tsec2 = __task_cred(tsk2)->security;	sid2 = __tsec2->sid;
+	__tsec1 = __task_cred(tsk1)->cred_selinux;	sid1 = __tsec1->sid;
+	__tsec2 = __task_cred(tsk2)->cred_selinux;	sid2 = __tsec2->sid;
 	rcu_read_unlock();
 	return avc_has_perm(sid1, sid2, SECCLASS_PROCESS, perms, NULL);
 }
@@ -1594,7 +1572,7 @@ static int inode_has_perm(const struct cred *cred,
 			  u32 perms,
 			  struct common_audit_data *adp)
 {
-	struct inode_security_struct *isec;
+	struct inode_selinux *isec;
 	u32 sid;
 
 	validate_creds(cred);
@@ -1603,7 +1581,7 @@ static int inode_has_perm(const struct cred *cred,
 		return 0;
 
 	sid = cred_sid(cred);
-	isec = inode->i_security;
+	isec = &inode->i_selinux;
 
 	return avc_has_perm(sid, isec->sid, isec->sclass, perms, adp);
 }
@@ -1662,7 +1640,7 @@ static int file_has_perm(const struct cred *cred,
 			 struct file *file,
 			 u32 av)
 {
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = file->f_selinux;
 	struct inode *inode = file_inode(file);
 	struct common_audit_data ad;
 	u32 sid = cred_sid(cred);
@@ -1694,15 +1672,15 @@ static int may_create(struct inode *dir,
 		      struct dentry *dentry,
 		      u16 tclass)
 {
-	const struct task_security_struct *tsec = current_security();
-	struct inode_security_struct *dsec;
+	const struct task_security_struct *tsec = current_selinux();
+	struct inode_selinux *dsec;
 	struct superblock_security_struct *sbsec;
 	u32 sid, newsid;
 	struct common_audit_data ad;
 	int rc;
 
-	dsec = dir->i_security;
-	sbsec = dir->i_sb->s_security;
+	dsec = &dir->i_selinux;
+	sbsec = dir->i_sb->s_selinux;
 
 	sid = tsec->sid;
 	newsid = tsec->create_sid;
@@ -1751,14 +1729,14 @@ static int may_link(struct inode *dir,
 		    int kind)
 
 {
-	struct inode_security_struct *dsec, *isec;
+	struct inode_selinux *dsec, *isec;
 	struct common_audit_data ad;
 	u32 sid = current_sid();
 	u32 av;
 	int rc;
 
-	dsec = dir->i_security;
-	isec = dentry->d_inode->i_security;
+	dsec = &dir->i_selinux;
+	isec = &dentry->d_inode->i_selinux;
 
 	ad.type = LSM_AUDIT_DATA_DENTRY;
 	ad.u.dentry = dentry;
@@ -1794,17 +1772,17 @@ static inline int may_rename(struct inode *old_dir,
 			     struct inode *new_dir,
 			     struct dentry *new_dentry)
 {
-	struct inode_security_struct *old_dsec, *new_dsec, *old_isec, *new_isec;
+	struct inode_selinux *old_dsec, *new_dsec, *old_isec, *new_isec;
 	struct common_audit_data ad;
 	u32 sid = current_sid();
 	u32 av;
 	int old_is_dir, new_is_dir;
 	int rc;
 
-	old_dsec = old_dir->i_security;
-	old_isec = old_dentry->d_inode->i_security;
+	old_dsec = &old_dir->i_selinux;
+	old_isec = &old_dentry->d_inode->i_selinux;
 	old_is_dir = S_ISDIR(old_dentry->d_inode->i_mode);
-	new_dsec = new_dir->i_security;
+	new_dsec = &new_dir->i_selinux;
 
 	ad.type = LSM_AUDIT_DATA_DENTRY;
 
@@ -1832,7 +1810,7 @@ static inline int may_rename(struct inode *old_dir,
 	if (rc)
 		return rc;
 	if (new_dentry->d_inode) {
-		new_isec = new_dentry->d_inode->i_security;
+		new_isec = &new_dentry->d_inode->i_selinux;
 		new_is_dir = S_ISDIR(new_dentry->d_inode->i_mode);
 		rc = avc_has_perm(sid, new_isec->sid,
 				  new_isec->sclass,
@@ -1853,7 +1831,7 @@ static int superblock_has_perm(const struct cred *cred,
 	struct superblock_security_struct *sbsec;
 	u32 sid = cred_sid(cred);
 
-	sbsec = sb->s_security;
+	sbsec = sb->s_selinux;
 	return avc_has_perm(sid, sbsec->sid, SECCLASS_FILESYSTEM, perms, ad);
 }
 
@@ -1927,12 +1905,6 @@ static inline u32 open_file_to_av(struct file *file)
 static int selinux_ptrace_access_check(struct task_struct *child,
 				     unsigned int mode)
 {
-	int rc;
-
-	rc = cap_ptrace_access_check(child, mode);
-	if (rc)
-		return rc;
-
 	if (mode & PTRACE_MODE_READ) {
 		u32 sid = current_sid();
 		u32 csid = task_sid(child);
@@ -1944,12 +1916,6 @@ static int selinux_ptrace_access_check(struct task_struct *child,
 
 static int selinux_ptrace_traceme(struct task_struct *parent)
 {
-	int rc;
-
-	rc = cap_ptrace_traceme(parent);
-	if (rc)
-		return rc;
-
 	return task_has_perm(parent, current, PROCESS__PTRACE);
 }
 
@@ -1993,12 +1959,6 @@ static int selinux_capset(struct cred *new, const struct cred *old,
 static int selinux_capable(const struct cred *cred, struct user_namespace *ns,
 			   int cap, int audit)
 {
-	int rc;
-
-	rc = cap_capable(cred, ns, cap, audit);
-	if (rc)
-		return rc;
-
 	return cred_has_capability(cred, cap, audit);
 }
 
@@ -2090,23 +2050,19 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
 {
 	const struct task_security_struct *old_tsec;
 	struct task_security_struct *new_tsec;
-	struct inode_security_struct *isec;
+	struct inode_selinux *isec;
 	struct common_audit_data ad;
 	struct inode *inode = file_inode(bprm->file);
 	int rc;
 
-	rc = cap_bprm_set_creds(bprm);
-	if (rc)
-		return rc;
-
 	/* SELinux context only depends on initial program or script and not
 	 * the script interpreter */
 	if (bprm->cred_prepared)
 		return 0;
 
-	old_tsec = current_security();
-	new_tsec = bprm->cred->security;
-	isec = inode->i_security;
+	old_tsec = current_selinux();
+	new_tsec = bprm->cred->cred_selinux;
+	isec = &inode->i_selinux;
 
 	/* Default to the current task SID. */
 	new_tsec->sid = old_tsec->sid;
@@ -2181,7 +2137,7 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
 			rcu_read_lock();
 			tracer = ptrace_parent(current);
 			if (likely(tracer != NULL)) {
-				sec = __task_cred(tracer)->security;
+				sec = __task_cred(tracer)->cred_selinux;
 				ptsid = sec->sid;
 			}
 			rcu_read_unlock();
@@ -2204,7 +2160,7 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
 
 static int selinux_bprm_secureexec(struct linux_binprm *bprm)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec = current_selinux();
 	u32 sid, osid;
 	int atsecure = 0;
 
@@ -2286,7 +2242,7 @@ static void selinux_bprm_committing_creds(struct linux_binprm *bprm)
 	struct rlimit *rlim, *initrlim;
 	int rc, i;
 
-	new_tsec = bprm->cred->security;
+	new_tsec = bprm->cred->cred_selinux;
 	if (new_tsec->sid == new_tsec->osid)
 		return;
 
@@ -2327,7 +2283,7 @@ static void selinux_bprm_committing_creds(struct linux_binprm *bprm)
  */
 static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec = current_selinux();
 	struct itimerval itimer;
 	u32 osid, sid;
 	int rc, i;
@@ -2474,7 +2430,7 @@ static int selinux_sb_remount(struct super_block *sb, void *data)
 	int rc, i, *flags;
 	struct security_mnt_opts opts;
 	char *secdata, **mount_options;
-	struct superblock_security_struct *sbsec = sb->s_security;
+	struct superblock_security_struct *sbsec = sb->s_selinux;
 
 	if (!(sbsec->flags & SE_SBINITIALIZED))
 		return 0;
@@ -2526,8 +2482,8 @@ static int selinux_sb_remount(struct super_block *sb, void *data)
 				goto out_bad_option;
 			break;
 		case ROOTCONTEXT_MNT: {
-			struct inode_security_struct *root_isec;
-			root_isec = sb->s_root->d_inode->i_security;
+			struct inode_selinux *root_isec;
+			root_isec = &sb->s_root->d_inode->i_selinux;
 
 			if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid, sid))
 				goto out_bad_option;
@@ -2625,15 +2581,15 @@ static int selinux_dentry_init_security(struct dentry *dentry, int mode,
 {
 	const struct cred *cred = current_cred();
 	struct task_security_struct *tsec;
-	struct inode_security_struct *dsec;
+	struct inode_selinux *dsec;
 	struct superblock_security_struct *sbsec;
 	struct inode *dir = dentry->d_parent->d_inode;
 	u32 newsid;
 	int rc;
 
-	tsec = cred->security;
-	dsec = dir->i_security;
-	sbsec = dir->i_sb->s_security;
+	tsec = cred->cred_selinux;
+	dsec = &dir->i_selinux;
+	sbsec = dir->i_sb->s_selinux;
 
 	if (tsec->create_sid && sbsec->behavior != SECURITY_FS_USE_MNTPOINT) {
 		newsid = tsec->create_sid;
@@ -2658,15 +2614,15 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 				       const char **name,
 				       void **value, size_t *len)
 {
-	const struct task_security_struct *tsec = current_security();
-	struct inode_security_struct *dsec;
+	const struct task_security_struct *tsec = current_selinux();
+	struct inode_selinux *dsec;
 	struct superblock_security_struct *sbsec;
 	u32 sid, newsid, clen;
 	int rc;
 	char *context;
 
-	dsec = dir->i_security;
-	sbsec = dir->i_sb->s_security;
+	dsec = &dir->i_selinux;
+	sbsec = dir->i_sb->s_selinux;
 
 	sid = tsec->sid;
 	newsid = tsec->create_sid;
@@ -2690,7 +2646,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 
 	/* Possibly defer initialization to selinux_complete_init. */
 	if (sbsec->flags & SE_SBINITIALIZED) {
-		struct inode_security_struct *isec = inode->i_security;
+		struct inode_selinux *isec = &inode->i_selinux;
 		isec->sclass = inode_mode_to_security_class(inode->i_mode);
 		isec->sid = newsid;
 		isec->initialized = 1;
@@ -2773,7 +2729,7 @@ static noinline int audit_inode_permission(struct inode *inode,
 					   unsigned flags)
 {
 	struct common_audit_data ad;
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_selinux *isec = &inode->i_selinux;
 	int rc;
 
 	ad.type = LSM_AUDIT_DATA_INODE;
@@ -2792,7 +2748,7 @@ static int selinux_inode_permission(struct inode *inode, int mask)
 	u32 perms;
 	bool from_access;
 	unsigned flags = mask & MAY_NOT_BLOCK;
-	struct inode_security_struct *isec;
+	struct inode_selinux *isec;
 	u32 sid;
 	struct av_decision avd;
 	int rc, rc2;
@@ -2813,7 +2769,7 @@ static int selinux_inode_permission(struct inode *inode, int mask)
 	perms = file_mask_to_av(inode->i_mode, mask);
 
 	sid = cred_sid(cred);
-	isec = inode->i_security;
+	isec = &inode->i_selinux;
 
 	rc = avc_has_perm_noaudit(sid, isec->sid, isec->sclass, perms, 0, &avd);
 	audited = avc_audit_required(perms, &avd, rc,
@@ -2888,7 +2844,7 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
 				  const void *value, size_t size, int flags)
 {
 	struct inode *inode = dentry->d_inode;
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_selinux *isec = &inode->i_selinux;
 	struct superblock_security_struct *sbsec;
 	struct common_audit_data ad;
 	u32 newsid, sid = current_sid();
@@ -2897,7 +2853,7 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
 	if (strcmp(name, XATTR_NAME_SELINUX))
 		return selinux_inode_setotherxattr(dentry, name);
 
-	sbsec = inode->i_sb->s_security;
+	sbsec = inode->i_sb->s_selinux;
 	if (!(sbsec->flags & SBLABEL_MNT))
 		return -EOPNOTSUPP;
 
@@ -2965,7 +2921,7 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
 					int flags)
 {
 	struct inode *inode = dentry->d_inode;
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_selinux *isec = &inode->i_selinux;
 	u32 newsid;
 	int rc;
 
@@ -3023,7 +2979,7 @@ static int selinux_inode_getsecurity(const struct inode *inode, const char *name
 	u32 size;
 	int error;
 	char *context = NULL;
-	struct inode_security_struct *isec = inode->i_security;
+	const struct inode_selinux *isec = &inode->i_selinux;
 
 	if (strcmp(name, XATTR_SELINUX_SUFFIX))
 		return -EOPNOTSUPP;
@@ -3059,7 +3015,7 @@ out_nofree:
 static int selinux_inode_setsecurity(struct inode *inode, const char *name,
 				     const void *value, size_t size, int flags)
 {
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_selinux *isec = &inode->i_selinux;
 	u32 newsid;
 	int rc;
 
@@ -3089,7 +3045,7 @@ static int selinux_inode_listsecurity(struct inode *inode, char *buffer, size_t
 
 static void selinux_inode_getsecid(const struct inode *inode, u32 *secid)
 {
-	struct inode_security_struct *isec = inode->i_security;
+	const struct inode_selinux *isec = &inode->i_selinux;
 	*secid = isec->sid;
 }
 
@@ -3111,8 +3067,8 @@ static int selinux_revalidate_file_permission(struct file *file, int mask)
 static int selinux_file_permission(struct file *file, int mask)
 {
 	struct inode *inode = file_inode(file);
-	struct file_security_struct *fsec = file->f_security;
-	struct inode_security_struct *isec = inode->i_security;
+	struct file_security_struct *fsec = file->f_selinux;
+	struct inode_selinux *isec = &inode->i_selinux;
 	u32 sid = current_sid();
 
 	if (!mask)
@@ -3336,7 +3292,7 @@ static int selinux_file_set_fowner(struct file *file)
 {
 	struct file_security_struct *fsec;
 
-	fsec = file->f_security;
+	fsec = file->f_selinux;
 	fsec->fown_sid = current_sid();
 
 	return 0;
@@ -3353,7 +3309,7 @@ static int selinux_file_send_sigiotask(struct task_struct *tsk,
 	/* struct fown_struct is never outside the context of a struct file */
 	file = container_of(fown, struct file, f_owner);
 
-	fsec = file->f_security;
+	fsec = file->f_selinux;
 
 	if (!signum)
 		perm = signal_to_av(SIGIO); /* as per send_sigio_to_task */
@@ -3374,10 +3330,10 @@ static int selinux_file_receive(struct file *file)
 static int selinux_file_open(struct file *file, const struct cred *cred)
 {
 	struct file_security_struct *fsec;
-	struct inode_security_struct *isec;
+	struct inode_selinux *isec;
 
-	fsec = file->f_security;
-	isec = file_inode(file)->i_security;
+	fsec = file->f_selinux;
+	isec = &file_inode(file)->i_selinux;
 	/*
 	 * Save inode label and policy sequence number
 	 * at open-time so that selinux_file_permission
@@ -3416,7 +3372,7 @@ static int selinux_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 	if (!tsec)
 		return -ENOMEM;
 
-	cred->security = tsec;
+	cred->cred_selinux = tsec;
 	return 0;
 }
 
@@ -3425,14 +3381,14 @@ static int selinux_cred_alloc_blank(struct cred *cred, gfp_t gfp)
  */
 static void selinux_cred_free(struct cred *cred)
 {
-	struct task_security_struct *tsec = cred->security;
+	struct task_security_struct *tsec = cred->cred_selinux;
 
 	/*
-	 * cred->security == NULL if security_cred_alloc_blank() or
+	 * cred->cred_selinux == NULL if security_cred_alloc_blank() or
 	 * security_prepare_creds() returned an error.
 	 */
-	BUG_ON(cred->security && (unsigned long) cred->security < PAGE_SIZE);
-	cred->security = (void *) 0x7UL;
+	BUG_ON(cred->cred_selinux && (unsigned long) cred->cred_selinux < PAGE_SIZE);
+	cred->cred_selinux = (void *) 0x7UL;
 	kfree(tsec);
 }
 
@@ -3445,13 +3401,13 @@ static int selinux_cred_prepare(struct cred *new, const struct cred *old,
 	const struct task_security_struct *old_tsec;
 	struct task_security_struct *tsec;
 
-	old_tsec = old->security;
+	old_tsec = old->cred_selinux;
 
 	tsec = kmemdup(old_tsec, sizeof(struct task_security_struct), gfp);
 	if (!tsec)
 		return -ENOMEM;
 
-	new->security = tsec;
+	new->cred_selinux = tsec;
 	return 0;
 }
 
@@ -3460,8 +3416,8 @@ static int selinux_cred_prepare(struct cred *new, const struct cred *old,
  */
 static void selinux_cred_transfer(struct cred *new, const struct cred *old)
 {
-	const struct task_security_struct *old_tsec = old->security;
-	struct task_security_struct *tsec = new->security;
+	const struct task_security_struct *old_tsec = old->cred_selinux;
+	struct task_security_struct *tsec = new->cred_selinux;
 
 	*tsec = *old_tsec;
 }
@@ -3472,7 +3428,7 @@ static void selinux_cred_transfer(struct cred *new, const struct cred *old)
  */
 static int selinux_kernel_act_as(struct cred *new, u32 secid)
 {
-	struct task_security_struct *tsec = new->security;
+	struct task_security_struct *tsec = new->cred_selinux;
 	u32 sid = current_sid();
 	int ret;
 
@@ -3495,8 +3451,8 @@ static int selinux_kernel_act_as(struct cred *new, u32 secid)
  */
 static int selinux_kernel_create_files_as(struct cred *new, struct inode *inode)
 {
-	struct inode_security_struct *isec = inode->i_security;
-	struct task_security_struct *tsec = new->security;
+	struct inode_selinux *isec = &inode->i_selinux;
+	struct task_security_struct *tsec = new->cred_selinux;
 	u32 sid = current_sid();
 	int ret;
 
@@ -3546,23 +3502,11 @@ static void selinux_task_getsecid(struct task_struct *p, u32 *secid)
 
 static int selinux_task_setnice(struct task_struct *p, int nice)
 {
-	int rc;
-
-	rc = cap_task_setnice(p, nice);
-	if (rc)
-		return rc;
-
 	return current_has_perm(p, PROCESS__SETSCHED);
 }
 
 static int selinux_task_setioprio(struct task_struct *p, int ioprio)
 {
-	int rc;
-
-	rc = cap_task_setioprio(p, ioprio);
-	if (rc)
-		return rc;
-
 	return current_has_perm(p, PROCESS__SETSCHED);
 }
 
@@ -3588,12 +3532,6 @@ static int selinux_task_setrlimit(struct task_struct *p, unsigned int resource,
 
 static int selinux_task_setscheduler(struct task_struct *p)
 {
-	int rc;
-
-	rc = cap_task_setscheduler(p);
-	if (rc)
-		return rc;
-
 	return current_has_perm(p, PROCESS__SETSCHED);
 }
 
@@ -3633,7 +3571,7 @@ static int selinux_task_wait(struct task_struct *p)
 static void selinux_task_to_inode(struct task_struct *p,
 				  struct inode *inode)
 {
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_selinux *isec = &inode->i_selinux;
 	u32 sid = task_sid(p);
 
 	isec->sid = sid;
@@ -3916,7 +3854,7 @@ static int socket_sockcreate_sid(const struct task_security_struct *tsec,
 
 static int sock_has_perm(struct task_struct *task, struct sock *sk, u32 perms)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = sk->sk_selinux;
 	struct common_audit_data ad;
 	struct lsm_network_audit net = {0,};
 	u32 tsid = task_sid(task);
@@ -3934,7 +3872,7 @@ static int sock_has_perm(struct task_struct *task, struct sock *sk, u32 perms)
 static int selinux_socket_create(int family, int type,
 				 int protocol, int kern)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec = current_selinux();
 	u32 newsid;
 	u16 secclass;
 	int rc;
@@ -3953,8 +3891,8 @@ static int selinux_socket_create(int family, int type,
 static int selinux_socket_post_create(struct socket *sock, int family,
 				      int type, int protocol, int kern)
 {
-	const struct task_security_struct *tsec = current_security();
-	struct inode_security_struct *isec = SOCK_INODE(sock)->i_security;
+	const struct task_security_struct *tsec = current_selinux();
+	struct inode_selinux *isec = &SOCK_INODE(sock)->i_selinux;
 	struct sk_security_struct *sksec;
 	int err = 0;
 
@@ -3971,7 +3909,7 @@ static int selinux_socket_post_create(struct socket *sock, int family,
 	isec->initialized = 1;
 
 	if (sock->sk) {
-		sksec = sock->sk->sk_security;
+		sksec = sock->sk->sk_selinux;
 		sksec->sid = isec->sid;
 		sksec->sclass = isec->sclass;
 		err = selinux_netlbl_socket_post_create(sock->sk, family);
@@ -4002,7 +3940,7 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 	family = sk->sk_family;
 	if (family == PF_INET || family == PF_INET6) {
 		char *addrp;
-		struct sk_security_struct *sksec = sk->sk_security;
+		struct sk_security_struct *sksec = sk->sk_selinux;
 		struct common_audit_data ad;
 		struct lsm_network_audit net = {0,};
 		struct sockaddr_in *addr4 = NULL;
@@ -4086,7 +4024,7 @@ out:
 static int selinux_socket_connect(struct socket *sock, struct sockaddr *address, int addrlen)
 {
 	struct sock *sk = sock->sk;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = sk->sk_selinux;
 	int err;
 
 	err = sock_has_perm(current, sk, SOCKET__CONNECT);
@@ -4147,16 +4085,16 @@ static int selinux_socket_listen(struct socket *sock, int backlog)
 static int selinux_socket_accept(struct socket *sock, struct socket *newsock)
 {
 	int err;
-	struct inode_security_struct *isec;
-	struct inode_security_struct *newisec;
+	struct inode_selinux *isec;
+	struct inode_selinux *newisec;
 
 	err = sock_has_perm(current, sock->sk, SOCKET__ACCEPT);
 	if (err)
 		return err;
 
-	newisec = SOCK_INODE(newsock)->i_security;
+	newisec = &SOCK_INODE(newsock)->i_selinux;
 
-	isec = SOCK_INODE(sock)->i_security;
+	isec = &SOCK_INODE(sock)->i_selinux;
 	newisec->sclass = isec->sclass;
 	newisec->sid = isec->sid;
 	newisec->initialized = 1;
@@ -4212,9 +4150,9 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 					      struct sock *other,
 					      struct sock *newsk)
 {
-	struct sk_security_struct *sksec_sock = sock->sk_security;
-	struct sk_security_struct *sksec_other = other->sk_security;
-	struct sk_security_struct *sksec_new = newsk->sk_security;
+	struct sk_security_struct *sksec_sock = sock->sk_selinux;
+	struct sk_security_struct *sksec_other = other->sk_selinux;
+	struct sk_security_struct *sksec_new = newsk->sk_selinux;
 	struct common_audit_data ad;
 	struct lsm_network_audit net = {0,};
 	int err;
@@ -4245,8 +4183,8 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 static int selinux_socket_unix_may_send(struct socket *sock,
 					struct socket *other)
 {
-	struct sk_security_struct *ssec = sock->sk->sk_security;
-	struct sk_security_struct *osec = other->sk->sk_security;
+	struct sk_security_struct *ssec = sock->sk->sk_selinux;
+	struct sk_security_struct *osec = other->sk->sk_selinux;
 	struct common_audit_data ad;
 	struct lsm_network_audit net = {0,};
 
@@ -4285,7 +4223,7 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 				       u16 family)
 {
 	int err = 0;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = sk->sk_selinux;
 	u32 sk_sid = sksec->sid;
 	struct common_audit_data ad;
 	struct lsm_network_audit net = {0,};
@@ -4317,7 +4255,7 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
 	int err;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = sk->sk_selinux;
 	u16 family = sk->sk_family;
 	u32 sk_sid = sksec->sid;
 	struct common_audit_data ad;
@@ -4389,7 +4327,7 @@ static int selinux_socket_getpeersec_stream(struct socket *sock, char __user *op
 	int err = 0;
 	char *scontext;
 	u32 scontext_len;
-	struct sk_security_struct *sksec = sock->sk->sk_security;
+	struct sk_security_struct *sksec = sock->sk->sk_selinux;
 	u32 peer_sid = SECSID_NULL;
 
 	if (sksec->sclass == SECCLASS_UNIX_STREAM_SOCKET ||
@@ -4454,24 +4392,24 @@ static int selinux_sk_alloc_security(struct sock *sk, int family, gfp_t priority
 	sksec->peer_sid = SECINITSID_UNLABELED;
 	sksec->sid = SECINITSID_UNLABELED;
 	selinux_netlbl_sk_security_reset(sksec);
-	sk->sk_security = sksec;
+	sk->sk_selinux = sksec;
 
 	return 0;
 }
 
 static void selinux_sk_free_security(struct sock *sk)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = sk->sk_selinux;
 
-	sk->sk_security = NULL;
+	sk->sk_selinux = NULL;
 	selinux_netlbl_sk_security_free(sksec);
 	kfree(sksec);
 }
 
 static void selinux_sk_clone_security(const struct sock *sk, struct sock *newsk)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
-	struct sk_security_struct *newsksec = newsk->sk_security;
+	struct sk_security_struct *sksec = sk->sk_selinux;
+	struct sk_security_struct *newsksec = newsk->sk_selinux;
 
 	newsksec->sid = sksec->sid;
 	newsksec->peer_sid = sksec->peer_sid;
@@ -4485,7 +4423,7 @@ static void selinux_sk_getsecid(struct sock *sk, u32 *secid)
 	if (!sk)
 		*secid = SECINITSID_ANY_SOCKET;
 	else {
-		struct sk_security_struct *sksec = sk->sk_security;
+		struct sk_security_struct *sksec = sk->sk_selinux;
 
 		*secid = sksec->sid;
 	}
@@ -4493,8 +4431,8 @@ static void selinux_sk_getsecid(struct sock *sk, u32 *secid)
 
 static void selinux_sock_graft(struct sock *sk, struct socket *parent)
 {
-	struct inode_security_struct *isec = SOCK_INODE(parent)->i_security;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct inode_selinux *isec = &SOCK_INODE(parent)->i_selinux;
+	struct sk_security_struct *sksec = sk->sk_selinux;
 
 	if (sk->sk_family == PF_INET || sk->sk_family == PF_INET6 ||
 	    sk->sk_family == PF_UNIX)
@@ -4505,7 +4443,7 @@ static void selinux_sock_graft(struct sock *sk, struct socket *parent)
 static int selinux_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 				     struct request_sock *req)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = sk->sk_selinux;
 	int err;
 	u16 family = req->rsk_ops->family;
 	u32 connsid;
@@ -4526,7 +4464,7 @@ static int selinux_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 static void selinux_inet_csk_clone(struct sock *newsk,
 				   const struct request_sock *req)
 {
-	struct sk_security_struct *newsksec = newsk->sk_security;
+	struct sk_security_struct *newsksec = newsk->sk_selinux;
 
 	newsksec->sid = req->secid;
 	newsksec->peer_sid = req->peer_secid;
@@ -4543,7 +4481,7 @@ static void selinux_inet_csk_clone(struct sock *newsk,
 static void selinux_inet_conn_established(struct sock *sk, struct sk_buff *skb)
 {
 	u16 family = sk->sk_family;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = sk->sk_selinux;
 
 	/* handle mapped IPv4 packets arriving via IPv6 sockets */
 	if (family == PF_INET6 && skb->protocol == htons(ETH_P_IP))
@@ -4562,7 +4500,7 @@ static int selinux_secmark_relabel_packet(u32 sid)
 	const struct task_security_struct *__tsec;
 	u32 tsid;
 
-	__tsec = current_security();
+	__tsec = current_selinux();
 	tsid = __tsec->sid;
 
 	return avc_has_perm(tsid, sid, SECCLASS_PACKET, PACKET__RELABELTO, NULL);
@@ -4628,7 +4566,7 @@ static int selinux_tun_dev_attach_queue(void *security)
 static int selinux_tun_dev_attach(struct sock *sk, void *security)
 {
 	struct tun_security_struct *tunsec = security;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = sk->sk_selinux;
 
 	/* we don't currently perform any NetLabel based labeling here and it
 	 * isn't clear that we would want to do so anyway; while we could apply
@@ -4667,7 +4605,7 @@ static int selinux_nlmsg_perm(struct sock *sk, struct sk_buff *skb)
 	int err = 0;
 	u32 perm;
 	struct nlmsghdr *nlh;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = sk->sk_selinux;
 
 	if (skb->len < NLMSG_HDRLEN) {
 		err = -EINVAL;
@@ -4807,7 +4745,7 @@ static unsigned int selinux_ip_output(struct sk_buff *skb,
 			return NF_ACCEPT;
 
 		/* standard practice, label using the parent socket */
-		sksec = sk->sk_security;
+		sksec = sk->sk_selinux;
 		sid = sksec->sid;
 	} else
 		sid = SECINITSID_KERNEL;
@@ -4839,7 +4777,7 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 
 	if (sk == NULL)
 		return NF_ACCEPT;
-	sksec = sk->sk_security;
+	sksec = sk->sk_selinux;
 
 	ad.type = LSM_AUDIT_DATA_NET;
 	ad.u.net = &net;
@@ -4926,7 +4864,7 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb, int ifindex,
 		 * selinux_inet_conn_request().  See also selinux_ip_output()
 		 * for similar problems. */
 		u32 skb_sid;
-		struct sk_security_struct *sksec = sk->sk_security;
+		struct sk_security_struct *sksec = sk->sk_selinux;
 		if (selinux_skb_peerlbl_sid(skb, family, &skb_sid))
 			return NF_DROP;
 		/* At this point, if the returned skb peerlbl is SECSID_NULL
@@ -4954,7 +4892,7 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb, int ifindex,
 	} else {
 		/* Locally generated packet, fetch the security label from the
 		 * associated socket. */
-		struct sk_security_struct *sksec = sk->sk_security;
+		struct sk_security_struct *sksec = sk->sk_selinux;
 		peer_sid = sksec->sid;
 		secmark_perm = PACKET__SEND;
 	}
@@ -5015,12 +4953,6 @@ static unsigned int selinux_ipv6_postroute(const struct nf_hook_ops *ops,
 
 static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
 {
-	int err;
-
-	err = cap_netlink_send(sk, skb);
-	if (err)
-		return err;
-
 	return selinux_nlmsg_perm(sk, skb);
 }
 
@@ -5038,15 +4970,15 @@ static int ipc_alloc_security(struct task_struct *task,
 	sid = task_sid(task);
 	isec->sclass = sclass;
 	isec->sid = sid;
-	perm->security = isec;
+	perm->kip_selinux = isec;
 
 	return 0;
 }
 
 static void ipc_free_security(struct kern_ipc_perm *perm)
 {
-	struct ipc_security_struct *isec = perm->security;
-	perm->security = NULL;
+	struct ipc_security_struct *isec = perm->kip_selinux;
+	perm->kip_selinux = NULL;
 	kfree(isec);
 }
 
@@ -5059,16 +4991,16 @@ static int msg_msg_alloc_security(struct msg_msg *msg)
 		return -ENOMEM;
 
 	msec->sid = SECINITSID_UNLABELED;
-	msg->security = msec;
+	msg->msg_selinux = msec;
 
 	return 0;
 }
 
 static void msg_msg_free_security(struct msg_msg *msg)
 {
-	struct msg_security_struct *msec = msg->security;
+	struct msg_security_struct *msec = msg->msg_selinux;
 
-	msg->security = NULL;
+	msg->msg_selinux = NULL;
 	kfree(msec);
 }
 
@@ -5079,7 +5011,7 @@ static int ipc_has_perm(struct kern_ipc_perm *ipc_perms,
 	struct common_audit_data ad;
 	u32 sid = current_sid();
 
-	isec = ipc_perms->security;
+	isec = ipc_perms->kip_selinux;
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = ipc_perms->key;
@@ -5109,7 +5041,7 @@ static int selinux_msg_queue_alloc_security(struct msg_queue *msq)
 	if (rc)
 		return rc;
 
-	isec = msq->q_perm.security;
+	isec = msq->q_perm.kip_selinux;
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->q_perm.key;
@@ -5134,7 +5066,7 @@ static int selinux_msg_queue_associate(struct msg_queue *msq, int msqflg)
 	struct common_audit_data ad;
 	u32 sid = current_sid();
 
-	isec = msq->q_perm.security;
+	isec = msq->q_perm.kip_selinux;
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->q_perm.key;
@@ -5179,8 +5111,8 @@ static int selinux_msg_queue_msgsnd(struct msg_queue *msq, struct msg_msg *msg,
 	u32 sid = current_sid();
 	int rc;
 
-	isec = msq->q_perm.security;
-	msec = msg->security;
+	isec = msq->q_perm.kip_selinux;
+	msec = msg->msg_selinux;
 
 	/*
 	 * First time through, need to assign label to the message
@@ -5224,8 +5156,8 @@ static int selinux_msg_queue_msgrcv(struct msg_queue *msq, struct msg_msg *msg,
 	u32 sid = task_sid(target);
 	int rc;
 
-	isec = msq->q_perm.security;
-	msec = msg->security;
+	isec = msq->q_perm.kip_selinux;
+	msec = msg->msg_selinux;
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->q_perm.key;
@@ -5250,7 +5182,7 @@ static int selinux_shm_alloc_security(struct shmid_kernel *shp)
 	if (rc)
 		return rc;
 
-	isec = shp->shm_perm.security;
+	isec = shp->shm_perm.kip_selinux;
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = shp->shm_perm.key;
@@ -5275,7 +5207,7 @@ static int selinux_shm_associate(struct shmid_kernel *shp, int shmflg)
 	struct common_audit_data ad;
 	u32 sid = current_sid();
 
-	isec = shp->shm_perm.security;
+	isec = shp->shm_perm.kip_selinux;
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = shp->shm_perm.key;
@@ -5342,7 +5274,7 @@ static int selinux_sem_alloc_security(struct sem_array *sma)
 	if (rc)
 		return rc;
 
-	isec = sma->sem_perm.security;
+	isec = sma->sem_perm.kip_selinux;
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = sma->sem_perm.key;
@@ -5367,7 +5299,7 @@ static int selinux_sem_associate(struct sem_array *sma, int semflg)
 	struct common_audit_data ad;
 	u32 sid = current_sid();
 
-	isec = sma->sem_perm.security;
+	isec = sma->sem_perm.kip_selinux;
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = sma->sem_perm.key;
@@ -5449,7 +5381,7 @@ static int selinux_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 
 static void selinux_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
 {
-	struct ipc_security_struct *isec = ipcp->security;
+	struct ipc_security_struct *isec = ipcp->kip_selinux;
 	*secid = isec->sid;
 }
 
@@ -5474,7 +5406,7 @@ static int selinux_getprocattr(struct task_struct *p,
 	}
 
 	rcu_read_lock();
-	__tsec = __task_cred(p)->security;
+	__tsec = __task_cred(p)->cred_selinux;
 
 	if (!strcmp(name, "current"))
 		sid = __tsec->sid;
@@ -5583,7 +5515,7 @@ static int selinux_setprocattr(struct task_struct *p,
 	   operation.  See selinux_bprm_set_creds for the execve
 	   checks and may_create for the file creation checks. The
 	   operation will then fail if the context is not permitted. */
-	tsec = new->security;
+	tsec = new->cred_selinux;
 	if (!strcmp(name, "exec")) {
 		tsec->exec_sid = sid;
 	} else if (!strcmp(name, "fscreate")) {
@@ -5702,21 +5634,21 @@ static int selinux_key_alloc(struct key *k, const struct cred *cred,
 	if (!ksec)
 		return -ENOMEM;
 
-	tsec = cred->security;
+	tsec = cred->cred_selinux;
 	if (tsec->keycreate_sid)
 		ksec->sid = tsec->keycreate_sid;
 	else
 		ksec->sid = tsec->sid;
 
-	k->security = ksec;
+	k->key_selinux = ksec;
 	return 0;
 }
 
 static void selinux_key_free(struct key *k)
 {
-	struct key_security_struct *ksec = k->security;
+	struct key_security_struct *ksec = k->key_selinux;
 
-	k->security = NULL;
+	k->key_selinux = NULL;
 	kfree(ksec);
 }
 
@@ -5737,14 +5669,14 @@ static int selinux_key_permission(key_ref_t key_ref,
 	sid = cred_sid(cred);
 
 	key = key_ref_to_ptr(key_ref);
-	ksec = key->security;
+	ksec = key->key_selinux;
 
 	return avc_has_perm(sid, ksec->sid, SECCLASS_KEY, perm, NULL);
 }
 
 static int selinux_key_getsecurity(struct key *key, char **_buffer)
 {
-	struct key_security_struct *ksec = key->security;
+	struct key_security_struct *ksec = key->key_selinux;
 	char *context = NULL;
 	unsigned len;
 	int rc;
@@ -5983,7 +5915,7 @@ static __init int selinux_init(void)
 	default_noexec = !(VM_DATA_DEFAULT_FLAGS & VM_EXEC);
 
 	sel_inode_cache = kmem_cache_create("selinux_inode_security",
-					    sizeof(struct inode_security_struct),
+					    sizeof(struct inode_selinux),
 					    0, SLAB_PANIC, NULL);
 	avc_init();
 
@@ -6128,7 +6060,7 @@ int selinux_disable(void)
 	selinux_disabled = 1;
 	selinux_enabled = 0;
 
-	reset_security_ops();
+	security_module_disable(&selinux_ops);
 
 	/* Try to destroy the avc node cache */
 	avc_disable();
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 078e553..8c55a37 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -36,19 +36,6 @@ struct task_security_struct {
 	u32 sockcreate_sid;	/* fscreate SID */
 };
 
-struct inode_security_struct {
-	struct inode *inode;	/* back pointer to inode object */
-	union {
-		struct list_head list;	/* list of inode_security_struct */
-		struct rcu_head rcu;	/* for freeing the inode_security_struct */
-	};
-	u32 task_sid;		/* SID of creating task */
-	u32 sid;		/* SID of this object */
-	u16 sclass;		/* security class of this object */
-	unsigned char initialized;	/* initialization flag */
-	struct mutex lock;
-};
-
 struct file_security_struct {
 	u32 sid;		/* SID of open file description */
 	u32 fown_sid;		/* SID of file owner (for SIGIO) */
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 0364120..ce8d0d2 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -81,7 +81,7 @@ static int selinux_netlbl_sidlookup_cached(struct sk_buff *skb,
 static struct netlbl_lsm_secattr *selinux_netlbl_sock_genattr(struct sock *sk)
 {
 	int rc;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = sk->sk_selinux;
 	struct netlbl_lsm_secattr *secattr;
 
 	if (sksec->nlbl_secattr != NULL)
@@ -113,7 +113,7 @@ static struct netlbl_lsm_secattr *selinux_netlbl_sock_getattr(
 							const struct sock *sk,
 							u32 sid)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = sk->sk_selinux;
 	struct netlbl_lsm_secattr *secattr = sksec->nlbl_secattr;
 
 	if (secattr == NULL)
@@ -247,7 +247,7 @@ int selinux_netlbl_skbuff_setsid(struct sk_buff *skb,
 	 * being labeled by it's parent socket, if it is just exit */
 	sk = skb->sk;
 	if (sk != NULL) {
-		struct sk_security_struct *sksec = sk->sk_security;
+		struct sk_security_struct *sksec = sk->sk_selinux;
 		if (sksec->nlbl_state != NLBL_REQSKB)
 			return 0;
 		secattr = selinux_netlbl_sock_getattr(sk, sid);
@@ -309,7 +309,7 @@ inet_conn_request_return:
  */
 void selinux_netlbl_inet_csk_clone(struct sock *sk, u16 family)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = sk->sk_selinux;
 
 	if (family == PF_INET)
 		sksec->nlbl_state = NLBL_LABELED;
@@ -330,7 +330,7 @@ void selinux_netlbl_inet_csk_clone(struct sock *sk, u16 family)
 int selinux_netlbl_socket_post_create(struct sock *sk, u16 family)
 {
 	int rc;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = sk->sk_selinux;
 	struct netlbl_lsm_secattr *secattr;
 
 	if (family != PF_INET)
@@ -428,7 +428,7 @@ int selinux_netlbl_socket_setsockopt(struct socket *sock,
 {
 	int rc = 0;
 	struct sock *sk = sock->sk;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = sk->sk_selinux;
 	struct netlbl_lsm_secattr secattr;
 
 	if (level == IPPROTO_IP && optname == IP_OPTIONS &&
@@ -464,7 +464,7 @@ int selinux_netlbl_socket_setsockopt(struct socket *sock,
 int selinux_netlbl_socket_connect(struct sock *sk, struct sockaddr *addr)
 {
 	int rc;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = sk->sk_selinux;
 	struct netlbl_lsm_secattr *secattr;
 
 	if (sksec->nlbl_state != NLBL_REQSKB &&
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index c71737f..bf80eb1b 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -85,7 +85,7 @@ static int task_has_security(struct task_struct *tsk,
 	u32 sid = 0;
 
 	rcu_read_lock();
-	tsec = __task_cred(tsk)->security;
+	tsec = __task_cred(tsk)->cred_selinux;
 	if (tsec)
 		sid = tsec->sid;
 	rcu_read_unlock();
@@ -1230,7 +1230,7 @@ static int sel_make_bools(void)
 	struct dentry *dentry = NULL;
 	struct dentry *dir = bool_dir;
 	struct inode *inode = NULL;
-	struct inode_security_struct *isec;
+	struct inode_selinux *isec;
 	char **names = NULL, *page;
 	int num;
 	int *values = NULL;
@@ -1272,7 +1272,7 @@ static int sel_make_bools(void)
 		if (len >= PAGE_SIZE)
 			goto out;
 
-		isec = (struct inode_security_struct *)inode->i_security;
+		isec = &inode->i_selinux;
 		ret = security_genfs_sid("selinuxfs", page, SECCLASS_FILE, &sid);
 		if (ret)
 			goto out;
@@ -1793,7 +1793,7 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 	int ret;
 	struct dentry *dentry;
 	struct inode *inode;
-	struct inode_security_struct *isec;
+	struct inode_selinux *isec;
 
 	static struct tree_descr selinux_files[] = {
 		[SEL_LOAD] = {"load", &sel_load_ops, S_IRUSR|S_IWUSR},
@@ -1837,7 +1837,7 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 		goto err;
 
 	inode->i_ino = ++sel_last_ino;
-	isec = (struct inode_security_struct *)inode->i_security;
+	isec = &inode->i_selinux;
 	isec->sid = SECINITSID_DEVNULL;
 	isec->sclass = SECCLASS_CHR_FILE;
 	isec->initialized = 1;
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 4bca494..f3e3427 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2348,7 +2348,7 @@ int security_fs_use(struct super_block *sb)
 {
 	int rc = 0;
 	struct ocontext *c;
-	struct superblock_security_struct *sbsec = sb->s_security;
+	struct superblock_security_struct *sbsec = sb->s_selinux;
 	const char *fstype = sb->s_type->name;
 
 	read_lock(&policy_rwlock);
diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index 98b0426..0092440 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -82,7 +82,7 @@ static int selinux_xfrm_alloc_user(struct xfrm_sec_ctx **ctxp,
 				   gfp_t gfp)
 {
 	int rc;
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec = current_selinux();
 	struct xfrm_sec_ctx *ctx = NULL;
 	u32 str_len;
 
@@ -139,7 +139,7 @@ static void selinux_xfrm_free(struct xfrm_sec_ctx *ctx)
  */
 static int selinux_xfrm_delete(struct xfrm_sec_ctx *ctx)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec = current_selinux();
 
 	if (!ctx)
 		return 0;
diff --git a/security/smack/smack.h b/security/smack/smack.h
index d072fd3..f67c4ed 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -84,17 +84,6 @@ struct socket_smack {
 	char			*smk_packet;	/* TCP peer label */
 };
 
-/*
- * Inode smack data
- */
-struct inode_smack {
-	char			*smk_inode;	/* label of the fso */
-	struct smack_known	*smk_task;	/* label of the task */
-	struct smack_known	*smk_mmap;	/* label of the mmap domain */
-	struct mutex		smk_lock;	/* initialization lock */
-	int			smk_flags;	/* smack inode flags */
-};
-
 struct task_smack {
 	struct smack_known	*smk_task;	/* label for access control */
 	struct smack_known	*smk_forked;	/* label when forked */
@@ -105,6 +94,7 @@ struct task_smack {
 #define	SMK_INODE_INSTANT	0x01	/* inode is instantiated */
 #define	SMK_INODE_TRANSMUTE	0x02	/* directory is transmuting */
 #define	SMK_INODE_CHANGED	0x04	/* smack was transmuted */
+#define	SMK_INODE_ALLOCATED	0x08	/* smack_inode_alloc_security done */
 
 /*
  * A label access rule.
@@ -215,10 +205,6 @@ struct smk_audit_info {
 	struct smack_audit_data sad;
 #endif
 };
-/*
- * These functions are in smack_lsm.c
- */
-struct inode_smack *new_inode_smack(char *);
 
 /*
  * These functions are in smack_access.c
@@ -266,8 +252,7 @@ extern struct hlist_head smack_known_hash[SMACK_HASH_SLOTS];
  */
 static inline int smk_inode_transmutable(const struct inode *isp)
 {
-	struct inode_smack *sip = isp->i_security;
-	return (sip->smk_flags & SMK_INODE_TRANSMUTE) != 0;
+	return (isp->i_smack.smk_flags & SMK_INODE_TRANSMUTE) != 0;
 }
 
 /*
@@ -275,8 +260,7 @@ static inline int smk_inode_transmutable(const struct inode *isp)
  */
 static inline char *smk_of_inode(const struct inode *isp)
 {
-	struct inode_smack *sip = isp->i_security;
-	return sip->smk_inode;
+	return isp->i_smack.smk_inode;
 }
 
 /*
@@ -300,7 +284,7 @@ static inline struct smack_known *smk_of_forked(const struct task_smack *tsp)
  */
 static inline struct smack_known *smk_of_current(void)
 {
-	return smk_of_task(current_security());
+	return smk_of_task(current_smack());
 }
 
 /*
diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index 14293cd..1e185e8 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -204,7 +204,7 @@ out_audit:
  */
 int smk_curacc(char *obj_label, u32 mode, struct smk_audit_info *a)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = current_smack();
 	struct smack_known *skp = smk_of_task(tsp);
 	int may;
 	int rc;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 14f52be..cc24833 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -43,7 +43,7 @@
 #include <linux/binfmts.h>
 #include "smack.h"
 
-#define task_security(task)	(task_cred_xxx((task), security))
+#define task_security(task)	(task_cred_xxx((task), cred_smack))
 
 #define TRANS_TRUE	"TRUE"
 #define TRANS_TRUE_SIZE	4
@@ -86,27 +86,6 @@ static struct smack_known *smk_fetch(const char *name, struct inode *ip,
 }
 
 /**
- * new_inode_smack - allocate an inode security blob
- * @smack: a pointer to the Smack label to use in the blob
- *
- * Returns the new blob or NULL if there's no memory available
- */
-struct inode_smack *new_inode_smack(char *smack)
-{
-	struct inode_smack *isp;
-
-	isp = kzalloc(sizeof(struct inode_smack), GFP_NOFS);
-	if (isp == NULL)
-		return NULL;
-
-	isp->smk_inode = smack;
-	isp->smk_flags = 0;
-	mutex_init(&isp->smk_lock);
-
-	return isp;
-}
-
-/**
  * new_task_smack - allocate a task security blob
  * @smack: a pointer to the Smack label to use in the blob
  *
@@ -173,20 +152,14 @@ static int smk_copy_rules(struct list_head *nhead, struct list_head *ohead,
  */
 static int smack_ptrace_access_check(struct task_struct *ctp, unsigned int mode)
 {
-	int rc;
 	struct smk_audit_info ad;
 	struct smack_known *skp;
 
-	rc = cap_ptrace_access_check(ctp, mode);
-	if (rc != 0)
-		return rc;
-
 	skp = smk_of_task(task_security(ctp));
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_TASK);
 	smk_ad_setfield_u_tsk(&ad, ctp);
 
-	rc = smk_curacc(skp->smk_known, mode, &ad);
-	return rc;
+	return smk_curacc(skp->smk_known, mode, &ad);
 }
 
 /**
@@ -199,20 +172,14 @@ static int smack_ptrace_access_check(struct task_struct *ctp, unsigned int mode)
  */
 static int smack_ptrace_traceme(struct task_struct *ptp)
 {
-	int rc;
 	struct smk_audit_info ad;
 	struct smack_known *skp;
 
-	rc = cap_ptrace_traceme(ptp);
-	if (rc != 0)
-		return rc;
-
 	skp = smk_of_task(task_security(ptp));
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_TASK);
 	smk_ad_setfield_u_tsk(&ad, ptp);
 
-	rc = smk_curacc(skp->smk_known, MAY_READWRITE, &ad);
-	return rc;
+	return smk_curacc(skp->smk_known, MAY_READWRITE, &ad);
 }
 
 /**
@@ -262,7 +229,7 @@ static int smack_sb_alloc_security(struct super_block *sb)
 	/*
 	 * smk_initialized will be zero from kzalloc.
 	 */
-	sb->s_security = sbsp;
+	sb->s_smack = sbsp;
 
 	return 0;
 }
@@ -274,8 +241,8 @@ static int smack_sb_alloc_security(struct super_block *sb)
  */
 static void smack_sb_free_security(struct super_block *sb)
 {
-	kfree(sb->s_security);
-	sb->s_security = NULL;
+	kfree(sb->s_smack);
+	sb->s_smack = NULL;
 }
 
 /**
@@ -337,7 +304,7 @@ static int smack_sb_kern_mount(struct super_block *sb, int flags, void *data)
 {
 	struct dentry *root = sb->s_root;
 	struct inode *inode = root->d_inode;
-	struct superblock_smack *sp = sb->s_security;
+	struct superblock_smack *sp = sb->s_smack;
 	struct inode_smack *isp;
 	struct smack_known *skp;
 	char *op;
@@ -412,12 +379,12 @@ static int smack_sb_kern_mount(struct super_block *sb, int flags, void *data)
 	/*
 	 * Initialize the root inode.
 	 */
-	isp = inode->i_security;
-	if (inode->i_security == NULL) {
-		inode->i_security = new_inode_smack(sp->smk_root);
-		isp = inode->i_security;
-	} else
-		isp->smk_inode = sp->smk_root;
+	if (!(inode->i_smack.smk_flags & SMK_INODE_ALLOCATED))
+		/*
+		 * Don't optimize this. The desired result is that flags be
+		 * cleared except for the ALLOCATED bit.
+		 */
+		inode->i_smack.smk_flags = SMK_INODE_ALLOCATED;
 
 	if (transmute)
 		isp->smk_flags |= SMK_INODE_TRANSMUTE;
@@ -434,7 +401,7 @@ static int smack_sb_kern_mount(struct super_block *sb, int flags, void *data)
  */
 static int smack_sb_statfs(struct dentry *dentry)
 {
-	struct superblock_smack *sbp = dentry->d_sb->s_security;
+	struct superblock_smack *sbp = dentry->d_sb->s_smack;
 	int rc;
 	struct smk_audit_info ad;
 
@@ -458,18 +425,13 @@ static int smack_sb_statfs(struct dentry *dentry)
 static int smack_bprm_set_creds(struct linux_binprm *bprm)
 {
 	struct inode *inode = file_inode(bprm->file);
-	struct task_smack *bsp = bprm->cred->security;
+	struct task_smack *bsp = bprm->cred->cred_smack;
 	struct inode_smack *isp;
-	int rc;
-
-	rc = cap_bprm_set_creds(bprm);
-	if (rc != 0)
-		return rc;
 
 	if (bprm->cred_prepared)
 		return 0;
 
-	isp = inode->i_security;
+	isp = &inode->i_smack;
 	if (isp->smk_task == NULL || isp->smk_task == bsp->smk_task)
 		return 0;
 
@@ -490,7 +452,7 @@ static int smack_bprm_set_creds(struct linux_binprm *bprm)
  */
 static void smack_bprm_committing_creds(struct linux_binprm *bprm)
 {
-	struct task_smack *bsp = bprm->cred->security;
+	struct task_smack *bsp = bprm->cred->cred_smack;
 
 	if (bsp->smk_task != bsp->smk_forked)
 		current->pdeath_signal = 0;
@@ -504,7 +466,7 @@ static void smack_bprm_committing_creds(struct linux_binprm *bprm)
  */
 static int smack_bprm_secureexec(struct linux_binprm *bprm)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = current_smack();
 	int ret = cap_bprm_secureexec(bprm);
 
 	if (!ret && (tsp->smk_task != tsp->smk_forked))
@@ -526,10 +488,12 @@ static int smack_bprm_secureexec(struct linux_binprm *bprm)
 static int smack_inode_alloc_security(struct inode *inode)
 {
 	struct smack_known *skp = smk_of_current();
+	struct inode_smack *isp = &inode->i_smack;
+
+	memset(isp, 0, sizeof(*isp));
+	isp->smk_inode = skp->smk_known;
+	mutex_init(&isp->smk_lock);
 
-	inode->i_security = new_inode_smack(skp->smk_known);
-	if (inode->i_security == NULL)
-		return -ENOMEM;
 	return 0;
 }
 
@@ -541,8 +505,7 @@ static int smack_inode_alloc_security(struct inode *inode)
  */
 static void smack_inode_free_security(struct inode *inode)
 {
-	kfree(inode->i_security);
-	inode->i_security = NULL;
+	memset(&inode->i_smack, 0, sizeof(inode->i_smack));
 }
 
 /**
@@ -560,7 +523,7 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr, const char **name,
 				     void **value, size_t *len)
 {
-	struct inode_smack *issp = inode->i_security;
+	struct inode_smack *issp = &inode->i_smack;
 	struct smack_known *skp = smk_of_current();
 	char *isp = smk_of_inode(inode);
 	char *dsp = smk_of_inode(dir);
@@ -873,7 +836,7 @@ static void smack_inode_post_setxattr(struct dentry *dentry, const char *name,
 				      const void *value, size_t size, int flags)
 {
 	struct smack_known *skp;
-	struct inode_smack *isp = dentry->d_inode->i_security;
+	struct inode_smack *isp = &dentry->d_inode->i_smack;
 
 	if (strcmp(name, XATTR_NAME_SMACKTRANSMUTE) == 0) {
 		isp->smk_flags |= SMK_INODE_TRANSMUTE;
@@ -950,7 +913,7 @@ static int smack_inode_removexattr(struct dentry *dentry, const char *name)
 		rc = smk_curacc(smk_of_inode(dentry->d_inode), MAY_WRITE, &ad);
 
 	if (rc == 0) {
-		isp = dentry->d_inode->i_security;
+		isp = &dentry->d_inode->i_smack;
 		isp->smk_task = NULL;
 		isp->smk_mmap = NULL;
 	}
@@ -997,7 +960,7 @@ static int smack_inode_getsecurity(const struct inode *inode,
 	if (sock == NULL || sock->sk == NULL)
 		return -EOPNOTSUPP;
 
-	ssp = sock->sk->sk_security;
+	ssp = sock->sk->sk_smack;
 
 	if (strcmp(name, XATTR_SMACK_IPIN) == 0)
 		isp = ssp->smk_in;
@@ -1043,7 +1006,7 @@ static int smack_inode_listsecurity(struct inode *inode, char *buffer,
  */
 static void smack_inode_getsecid(const struct inode *inode, u32 *secid)
 {
-	struct inode_smack *isp = inode->i_security;
+	const struct inode_smack *isp = &inode->i_smack;
 
 	*secid = smack_to_secid(isp->smk_inode);
 }
@@ -1084,7 +1047,7 @@ static int smack_file_alloc_security(struct file *file)
 {
 	struct smack_known *skp = smk_of_current();
 
-	file->f_security = skp->smk_known;
+	file->f_smack = skp->smk_known;
 	return 0;
 }
 
@@ -1097,7 +1060,7 @@ static int smack_file_alloc_security(struct file *file)
  */
 static void smack_file_free_security(struct file *file)
 {
-	file->f_security = NULL;
+	file->f_smack = NULL;
 }
 
 /**
@@ -1120,10 +1083,10 @@ static int smack_file_ioctl(struct file *file, unsigned int cmd,
 	smk_ad_setfield_u_fs_path(&ad, file->f_path);
 
 	if (_IOC_DIR(cmd) & _IOC_WRITE)
-		rc = smk_curacc(file->f_security, MAY_WRITE, &ad);
+		rc = smk_curacc(file->f_smack, MAY_WRITE, &ad);
 
 	if (rc == 0 && (_IOC_DIR(cmd) & _IOC_READ))
-		rc = smk_curacc(file->f_security, MAY_READ, &ad);
+		rc = smk_curacc(file->f_smack, MAY_READ, &ad);
 
 	return rc;
 }
@@ -1141,7 +1104,7 @@ static int smack_file_lock(struct file *file, unsigned int cmd)
 
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_PATH);
 	smk_ad_setfield_u_fs_path(&ad, file->f_path);
-	return smk_curacc(file->f_security, MAY_LOCK, &ad);
+	return smk_curacc(file->f_smack, MAY_LOCK, &ad);
 }
 
 /**
@@ -1170,13 +1133,13 @@ static int smack_file_fcntl(struct file *file, unsigned int cmd,
 	case F_SETLKW:
 		smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_PATH);
 		smk_ad_setfield_u_fs_path(&ad, file->f_path);
-		rc = smk_curacc(file->f_security, MAY_LOCK, &ad);
+		rc = smk_curacc(file->f_smack, MAY_LOCK, &ad);
 		break;
 	case F_SETOWN:
 	case F_SETSIG:
 		smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_PATH);
 		smk_ad_setfield_u_fs_path(&ad, file->f_path);
-		rc = smk_curacc(file->f_security, MAY_WRITE, &ad);
+		rc = smk_curacc(file->f_smack, MAY_WRITE, &ad);
 		break;
 	default:
 		break;
@@ -1213,12 +1176,12 @@ static int smack_mmap_file(struct file *file,
 	if (file == NULL)
 		return 0;
 
-	isp = file_inode(file)->i_security;
+	isp = &file_inode(file)->i_smack;
 	if (isp->smk_mmap == NULL)
 		return 0;
 	mkp = isp->smk_mmap;
 
-	tsp = current_security();
+	tsp = current_smack();
 	skp = smk_of_current();
 	rc = 0;
 
@@ -1299,7 +1262,7 @@ static int smack_file_set_fowner(struct file *file)
 {
 	struct smack_known *skp = smk_of_current();
 
-	file->f_security = skp->smk_known;
+	file->f_smack = skp->smk_known;
 	return 0;
 }
 
@@ -1318,7 +1281,7 @@ static int smack_file_send_sigiotask(struct task_struct *tsk,
 				     struct fown_struct *fown, int signum)
 {
 	struct smack_known *skp;
-	struct smack_known *tkp = smk_of_task(tsk->cred->security);
+	struct smack_known *tkp = smk_of_task(tsk->cred->cred_smack);
 	struct file *file;
 	int rc;
 	struct smk_audit_info ad;
@@ -1329,14 +1292,14 @@ static int smack_file_send_sigiotask(struct task_struct *tsk,
 	file = container_of(fown, struct file, f_owner);
 
 	/* we don't log here as rc can be overriden */
-	skp = smk_find_entry(file->f_security);
+	skp = smk_find_entry(file->f_smack);
 	rc = smk_access(skp, tkp->smk_known, MAY_WRITE, NULL);
 	if (rc != 0 && has_capability(tsk, CAP_MAC_OVERRIDE))
 		rc = 0;
 
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_TASK);
 	smk_ad_setfield_u_tsk(&ad, tsk);
-	smack_log(file->f_security, tkp->smk_known, MAY_WRITE, rc, &ad);
+	smack_log(file->f_smack, tkp->smk_known, MAY_WRITE, rc, &ad);
 	return rc;
 }
 
@@ -1361,7 +1324,7 @@ static int smack_file_receive(struct file *file)
 	if (file->f_mode & FMODE_WRITE)
 		may |= MAY_WRITE;
 
-	return smk_curacc(file->f_security, may, &ad);
+	return smk_curacc(file->f_smack, may, &ad);
 }
 
 /**
@@ -1375,9 +1338,9 @@ static int smack_file_receive(struct file *file)
  */
 static int smack_file_open(struct file *file, const struct cred *cred)
 {
-	struct inode_smack *isp = file_inode(file)->i_security;
+	struct inode_smack *isp = &file_inode(file)->i_smack;
 
-	file->f_security = isp->smk_inode;
+	file->f_smack = isp->smk_inode;
 
 	return 0;
 }
@@ -1403,7 +1366,7 @@ static int smack_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 	if (tsp == NULL)
 		return -ENOMEM;
 
-	cred->security = tsp;
+	cred->cred_smack = tsp;
 
 	return 0;
 }
@@ -1416,14 +1379,14 @@ static int smack_cred_alloc_blank(struct cred *cred, gfp_t gfp)
  */
 static void smack_cred_free(struct cred *cred)
 {
-	struct task_smack *tsp = cred->security;
+	struct task_smack *tsp = cred->cred_smack;
 	struct smack_rule *rp;
 	struct list_head *l;
 	struct list_head *n;
 
 	if (tsp == NULL)
 		return;
-	cred->security = NULL;
+	cred->cred_smack = NULL;
 
 	list_for_each_safe(l, n, &tsp->smk_rules) {
 		rp = list_entry(l, struct smack_rule, list);
@@ -1444,7 +1407,7 @@ static void smack_cred_free(struct cred *cred)
 static int smack_cred_prepare(struct cred *new, const struct cred *old,
 			      gfp_t gfp)
 {
-	struct task_smack *old_tsp = old->security;
+	struct task_smack *old_tsp = old->cred_smack;
 	struct task_smack *new_tsp;
 	int rc;
 
@@ -1456,7 +1419,7 @@ static int smack_cred_prepare(struct cred *new, const struct cred *old,
 	if (rc != 0)
 		return rc;
 
-	new->security = new_tsp;
+	new->cred_smack = new_tsp;
 	return 0;
 }
 
@@ -1469,8 +1432,8 @@ static int smack_cred_prepare(struct cred *new, const struct cred *old,
  */
 static void smack_cred_transfer(struct cred *new, const struct cred *old)
 {
-	struct task_smack *old_tsp = old->security;
-	struct task_smack *new_tsp = new->security;
+	struct task_smack *old_tsp = old->cred_smack;
+	struct task_smack *new_tsp = new->cred_smack;
 
 	new_tsp->smk_task = old_tsp->smk_task;
 	new_tsp->smk_forked = old_tsp->smk_task;
@@ -1490,7 +1453,7 @@ static void smack_cred_transfer(struct cred *new, const struct cred *old)
  */
 static int smack_kernel_act_as(struct cred *new, u32 secid)
 {
-	struct task_smack *new_tsp = new->security;
+	struct task_smack *new_tsp = new->cred_smack;
 	struct smack_known *skp = smack_from_secid(secid);
 
 	if (skp == NULL)
@@ -1511,8 +1474,8 @@ static int smack_kernel_act_as(struct cred *new, u32 secid)
 static int smack_kernel_create_files_as(struct cred *new,
 					struct inode *inode)
 {
-	struct inode_smack *isp = inode->i_security;
-	struct task_smack *tsp = new->security;
+	struct inode_smack *isp = &inode->i_smack;
+	struct task_smack *tsp = new->cred_smack;
 
 	tsp->smk_forked = smk_find_entry(isp->smk_inode);
 	tsp->smk_task = tsp->smk_forked;
@@ -1595,12 +1558,7 @@ static void smack_task_getsecid(struct task_struct *p, u32 *secid)
  */
 static int smack_task_setnice(struct task_struct *p, int nice)
 {
-	int rc;
-
-	rc = cap_task_setnice(p, nice);
-	if (rc == 0)
-		rc = smk_curacc_on_task(p, MAY_WRITE, __func__);
-	return rc;
+	return smk_curacc_on_task(p, MAY_WRITE, __func__);
 }
 
 /**
@@ -1612,12 +1570,7 @@ static int smack_task_setnice(struct task_struct *p, int nice)
  */
 static int smack_task_setioprio(struct task_struct *p, int ioprio)
 {
-	int rc;
-
-	rc = cap_task_setioprio(p, ioprio);
-	if (rc == 0)
-		rc = smk_curacc_on_task(p, MAY_WRITE, __func__);
-	return rc;
+	return smk_curacc_on_task(p, MAY_WRITE, __func__);
 }
 
 /**
@@ -1641,12 +1594,7 @@ static int smack_task_getioprio(struct task_struct *p)
  */
 static int smack_task_setscheduler(struct task_struct *p)
 {
-	int rc;
-
-	rc = cap_task_setscheduler(p);
-	if (rc == 0)
-		rc = smk_curacc_on_task(p, MAY_WRITE, __func__);
-	return rc;
+	return smk_curacc_on_task(p, MAY_WRITE, __func__);
 }
 
 /**
@@ -1735,7 +1683,7 @@ static int smack_task_wait(struct task_struct *p)
  */
 static void smack_task_to_inode(struct task_struct *p, struct inode *inode)
 {
-	struct inode_smack *isp = inode->i_security;
+	struct inode_smack *isp = &inode->i_smack;
 	struct smack_known *skp = smk_of_task(task_security(p));
 
 	isp->smk_inode = skp->smk_known;
@@ -1768,7 +1716,7 @@ static int smack_sk_alloc_security(struct sock *sk, int family, gfp_t gfp_flags)
 	ssp->smk_out = skp;
 	ssp->smk_packet = NULL;
 
-	sk->sk_security = ssp;
+	sk->sk_smack = ssp;
 
 	return 0;
 }
@@ -1781,7 +1729,7 @@ static int smack_sk_alloc_security(struct sock *sk, int family, gfp_t gfp_flags)
  */
 static void smack_sk_free_security(struct sock *sk)
 {
-	kfree(sk->sk_security);
+	kfree(sk->sk_smack);
 }
 
 /**
@@ -1834,7 +1782,7 @@ static char *smack_host_label(struct sockaddr_in *sip)
 static int smack_netlabel(struct sock *sk, int labeled)
 {
 	struct smack_known *skp;
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = sk->sk_smack;
 	int rc = 0;
 
 	/*
@@ -1879,7 +1827,7 @@ static int smack_netlabel_send(struct sock *sk, struct sockaddr_in *sap)
 	int rc;
 	int sk_lbl;
 	char *hostsp;
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = sk->sk_smack;
 	struct smk_audit_info ad;
 
 	rcu_read_lock();
@@ -1918,7 +1866,7 @@ static void smk_ipv6_port_label(struct socket *sock, struct sockaddr *address)
 {
 	struct sock *sk = sock->sk;
 	struct sockaddr_in6 *addr6;
-	struct socket_smack *ssp = sock->sk->sk_security;
+	struct socket_smack *ssp = sock->sk->sk_smack;
 	struct smk_port_label *spp;
 	unsigned short port = 0;
 
@@ -1993,7 +1941,7 @@ static int smk_ipv6_port_check(struct sock *sk, struct sockaddr_in6 *address,
 	__be16 *bep;
 	__be32 *be32p;
 	struct smk_port_label *spp;
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = sk->sk_smack;
 	struct smack_known *skp;
 	unsigned short port = 0;
 	char *object;
@@ -2070,7 +2018,7 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
 				   const void *value, size_t size, int flags)
 {
 	struct smack_known *skp;
-	struct inode_smack *nsp = inode->i_security;
+	struct inode_smack *nsp = &inode->i_smack;
 	struct socket_smack *ssp;
 	struct socket *sock;
 	int rc = 0;
@@ -2097,7 +2045,7 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
 	if (sock == NULL || sock->sk == NULL)
 		return -EOPNOTSUPP;
 
-	ssp = sock->sk->sk_security;
+	ssp = sock->sk->sk_smack;
 
 	if (strcmp(name, XATTR_SMACK_IPIN) == 0)
 		ssp->smk_in = skp->smk_known;
@@ -2225,7 +2173,7 @@ static int smack_msg_msg_alloc_security(struct msg_msg *msg)
 {
 	struct smack_known *skp = smk_of_current();
 
-	msg->security = skp->smk_known;
+	msg->msg_smack = skp->smk_known;
 	return 0;
 }
 
@@ -2237,7 +2185,7 @@ static int smack_msg_msg_alloc_security(struct msg_msg *msg)
  */
 static void smack_msg_msg_free_security(struct msg_msg *msg)
 {
-	msg->security = NULL;
+	msg->msg_smack = NULL;
 }
 
 /**
@@ -2248,7 +2196,7 @@ static void smack_msg_msg_free_security(struct msg_msg *msg)
  */
 static char *smack_of_shm(struct shmid_kernel *shp)
 {
-	return (char *)shp->shm_perm.security;
+	return (char *)shp->shm_perm.kip_smack;
 }
 
 /**
@@ -2262,7 +2210,7 @@ static int smack_shm_alloc_security(struct shmid_kernel *shp)
 	struct kern_ipc_perm *isp = &shp->shm_perm;
 	struct smack_known *skp = smk_of_current();
 
-	isp->security = skp->smk_known;
+	isp->kip_smack = skp->smk_known;
 	return 0;
 }
 
@@ -2276,7 +2224,7 @@ static void smack_shm_free_security(struct shmid_kernel *shp)
 {
 	struct kern_ipc_perm *isp = &shp->shm_perm;
 
-	isp->security = NULL;
+	isp->kip_smack = NULL;
 }
 
 /**
@@ -2372,7 +2320,7 @@ static int smack_shm_shmat(struct shmid_kernel *shp, char __user *shmaddr,
  */
 static char *smack_of_sem(struct sem_array *sma)
 {
-	return (char *)sma->sem_perm.security;
+	return (char *)sma->sem_perm.kip_smack;
 }
 
 /**
@@ -2386,7 +2334,7 @@ static int smack_sem_alloc_security(struct sem_array *sma)
 	struct kern_ipc_perm *isp = &sma->sem_perm;
 	struct smack_known *skp = smk_of_current();
 
-	isp->security = skp->smk_known;
+	isp->kip_smack = skp->smk_known;
 	return 0;
 }
 
@@ -2400,7 +2348,7 @@ static void smack_sem_free_security(struct sem_array *sma)
 {
 	struct kern_ipc_perm *isp = &sma->sem_perm;
 
-	isp->security = NULL;
+	isp->kip_smack = NULL;
 }
 
 /**
@@ -2505,7 +2453,7 @@ static int smack_msg_queue_alloc_security(struct msg_queue *msq)
 	struct kern_ipc_perm *kisp = &msq->q_perm;
 	struct smack_known *skp = smk_of_current();
 
-	kisp->security = skp->smk_known;
+	kisp->kip_smack = skp->smk_known;
 	return 0;
 }
 
@@ -2519,7 +2467,7 @@ static void smack_msg_queue_free_security(struct msg_queue *msq)
 {
 	struct kern_ipc_perm *kisp = &msq->q_perm;
 
-	kisp->security = NULL;
+	kisp->kip_smack = NULL;
 }
 
 /**
@@ -2530,7 +2478,7 @@ static void smack_msg_queue_free_security(struct msg_queue *msq)
  */
 static char *smack_of_msq(struct msg_queue *msq)
 {
-	return (char *)msq->q_perm.security;
+	return (char *)msq->q_perm.kip_smack;
 }
 
 /**
@@ -2642,7 +2590,7 @@ static int smack_msg_queue_msgrcv(struct msg_queue *msq, struct msg_msg *msg,
  */
 static int smack_ipc_permission(struct kern_ipc_perm *ipp, short flag)
 {
-	char *isp = ipp->security;
+	char *isp = ipp->kip_smack;
 	int may = smack_flags_to_may(flag);
 	struct smk_audit_info ad;
 
@@ -2660,7 +2608,7 @@ static int smack_ipc_permission(struct kern_ipc_perm *ipp, short flag)
  */
 static void smack_ipc_getsecid(struct kern_ipc_perm *ipp, u32 *secid)
 {
-	char *smack = ipp->security;
+	char *smack = ipp->kip_smack;
 
 	*secid = smack_to_secid(smack);
 }
@@ -2688,7 +2636,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 	if (inode == NULL)
 		return;
 
-	isp = inode->i_security;
+	isp = &inode->i_smack;
 
 	mutex_lock(&isp->smk_lock);
 	/*
@@ -2699,7 +2647,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 		goto unlockandout;
 
 	sbp = inode->i_sb;
-	sbsp = sbp->s_security;
+	sbsp = sbp->s_smack;
 	/*
 	 * We're going to use the superblock default label
 	 * if there's no label on the file.
@@ -2939,7 +2887,7 @@ static int smack_setprocattr(struct task_struct *p, char *name,
 	if (new == NULL)
 		return -ENOMEM;
 
-	tsp = new->security;
+	tsp = new->cred_smack;
 	tsp->smk_task = skp;
 
 	commit_creds(new);
@@ -2959,9 +2907,9 @@ static int smack_unix_stream_connect(struct sock *sock,
 				     struct sock *other, struct sock *newsk)
 {
 	struct smack_known *skp;
-	struct socket_smack *ssp = sock->sk_security;
-	struct socket_smack *osp = other->sk_security;
-	struct socket_smack *nsp = newsk->sk_security;
+	struct socket_smack *ssp = sock->sk_smack;
+	struct socket_smack *osp = other->sk_smack;
+	struct socket_smack *nsp = newsk->sk_smack;
 	struct smk_audit_info ad;
 	int rc = 0;
 
@@ -2998,8 +2946,8 @@ static int smack_unix_stream_connect(struct sock *sock,
  */
 static int smack_unix_may_send(struct socket *sock, struct socket *other)
 {
-	struct socket_smack *ssp = sock->sk->sk_security;
-	struct socket_smack *osp = other->sk->sk_security;
+	struct socket_smack *ssp = sock->sk->sk_smack;
+	struct socket_smack *osp = other->sk->sk_smack;
 	struct smack_known *skp;
 	struct smk_audit_info ad;
 
@@ -3193,7 +3141,7 @@ static int smk_skb_to_addr_ipv6(struct sk_buff *skb, struct sockaddr_in6 *sip)
 static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
 	struct netlbl_lsm_secattr secattr;
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = sk->sk_smack;
 	struct smack_known *skp;
 	struct sockaddr_in6 sadd;
 	int rc = 0;
@@ -3261,7 +3209,7 @@ static int smack_socket_getpeersec_stream(struct socket *sock,
 	int slen = 1;
 	int rc = 0;
 
-	ssp = sock->sk->sk_security;
+	ssp = sock->sk->sk_smack;
 	if (ssp->smk_packet != NULL) {
 		rcp = ssp->smk_packet;
 		slen = strlen(rcp) + 1;
@@ -3308,14 +3256,14 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 		family = sock->sk->sk_family;
 
 	if (family == PF_UNIX) {
-		ssp = sock->sk->sk_security;
+		ssp = sock->sk->sk_smack;
 		s = ssp->smk_out->smk_secid;
 	} else if (family == PF_INET || family == PF_INET6) {
 		/*
 		 * Translate what netlabel gave us.
 		 */
 		if (sock != NULL && sock->sk != NULL)
-			ssp = sock->sk->sk_security;
+			ssp = sock->sk->sk_smack;
 		netlbl_secattr_init(&secattr);
 		rc = netlbl_skbuff_getattr(skb, family, &secattr);
 		if (rc == 0) {
@@ -3347,7 +3295,7 @@ static void smack_sock_graft(struct sock *sk, struct socket *parent)
 	    (sk->sk_family != PF_INET && sk->sk_family != PF_INET6))
 		return;
 
-	ssp = sk->sk_security;
+	ssp = sk->sk_smack;
 	ssp->smk_in = skp->smk_known;
 	ssp->smk_out = skp;
 	/* cssp->smk_packet is already set in smack_inet_csk_clone() */
@@ -3367,7 +3315,7 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 {
 	u16 family = sk->sk_family;
 	struct smack_known *skp;
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = sk->sk_smack;
 	struct netlbl_lsm_secattr secattr;
 	struct sockaddr_in addr;
 	struct iphdr *hdr;
@@ -3447,7 +3395,7 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 static void smack_inet_csk_clone(struct sock *sk,
 				 const struct request_sock *req)
 {
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = sk->sk_smack;
 	struct smack_known *skp;
 
 	if (req->peer_secid != 0) {
@@ -3479,9 +3427,9 @@ static void smack_inet_csk_clone(struct sock *sk,
 static int smack_key_alloc(struct key *key, const struct cred *cred,
 			   unsigned long flags)
 {
-	struct smack_known *skp = smk_of_task(cred->security);
+	struct smack_known *skp = smk_of_task(cred->cred_smack);
 
-	key->security = skp->smk_known;
+	key->key_smack = skp->smk_known;
 	return 0;
 }
 
@@ -3493,7 +3441,7 @@ static int smack_key_alloc(struct key *key, const struct cred *cred,
  */
 static void smack_key_free(struct key *key)
 {
-	key->security = NULL;
+	key->key_smack = NULL;
 }
 
 /*
@@ -3510,7 +3458,7 @@ static int smack_key_permission(key_ref_t key_ref,
 {
 	struct key *keyp;
 	struct smk_audit_info ad;
-	struct smack_known *tkp = smk_of_task(cred->security);
+	struct smack_known *tkp = smk_of_task(cred->cred_smack);
 
 	keyp = key_ref_to_ptr(key_ref);
 	if (keyp == NULL)
@@ -3519,7 +3467,7 @@ static int smack_key_permission(key_ref_t key_ref,
 	 * If the key hasn't been initialized give it access so that
 	 * it may do so.
 	 */
-	if (keyp->security == NULL)
+	if (keyp->key_smack == NULL)
 		return 0;
 	/*
 	 * This should not occur
@@ -3531,7 +3479,7 @@ static int smack_key_permission(key_ref_t key_ref,
 	ad.a.u.key_struct.key = keyp->serial;
 	ad.a.u.key_struct.key_desc = keyp->description;
 #endif
-	return smk_access(tkp, keyp->security, MAY_READWRITE, &ad);
+	return smk_access(tkp, keyp->key_smack, MAY_READWRITE, &ad);
 }
 #endif /* CONFIG_KEYS */
 
@@ -3922,7 +3870,7 @@ static __init int smack_init(void)
 	 * Set the security state for the initial task.
 	 */
 	cred = (struct cred *) current->cred;
-	cred->security = tsp;
+	cred->cred_smack = tsp;
 
 	/* initialize the smack_known_list */
 	init_smack_known_list();
@@ -3933,6 +3881,8 @@ static __init int smack_init(void)
 	if (register_security(&smack_ops))
 		panic("smack: Unable to register with kernel.\n");
 
+	smack_net_ambient = &smack_known_floor;
+
 	return 0;
 }
 
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 3198cfe..8d5de9e 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -1653,7 +1653,7 @@ static ssize_t smk_write_onlycap(struct file *file, const char __user *buf,
 				 size_t count, loff_t *ppos)
 {
 	char *data;
-	struct smack_known *skp = smk_of_task(current->cred->security);
+	struct smack_known *skp = smk_of_task(current->cred->cred_smack);
 	int rc = count;
 
 	if (!smack_privileged(CAP_MAC_ADMIN))
@@ -1767,14 +1767,14 @@ static const struct file_operations smk_logging_ops = {
 
 static void *load_self_seq_start(struct seq_file *s, loff_t *pos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = current_smack();
 
 	return smk_seq_start(s, pos, &tsp->smk_rules);
 }
 
 static void *load_self_seq_next(struct seq_file *s, void *v, loff_t *pos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = current_smack();
 
 	return smk_seq_next(s, v, pos, &tsp->smk_rules);
 }
@@ -1821,7 +1821,7 @@ static int smk_open_load_self(struct inode *inode, struct file *file)
 static ssize_t smk_write_load_self(struct file *file, const char __user *buf,
 			      size_t count, loff_t *ppos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = current_smack();
 
 	return smk_write_rules_list(file, buf, count, ppos, &tsp->smk_rules,
 				    &tsp->smk_rules_lock, SMK_FIXED24_FMT);
@@ -1970,14 +1970,14 @@ static const struct file_operations smk_load2_ops = {
 
 static void *load_self2_seq_start(struct seq_file *s, loff_t *pos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = current_smack();
 
 	return smk_seq_start(s, pos, &tsp->smk_rules);
 }
 
 static void *load_self2_seq_next(struct seq_file *s, void *v, loff_t *pos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = current_smack();
 
 	return smk_seq_next(s, v, pos, &tsp->smk_rules);
 }
@@ -2023,7 +2023,7 @@ static int smk_open_load_self2(struct inode *inode, struct file *file)
 static ssize_t smk_write_load_self2(struct file *file, const char __user *buf,
 			      size_t count, loff_t *ppos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = current_smack();
 
 	return smk_write_rules_list(file, buf, count, ppos, &tsp->smk_rules,
 				    &tsp->smk_rules_lock, SMK_LONG_FMT);
diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
index b897d48..8ffe158 100644
--- a/security/tomoyo/common.h
+++ b/security/tomoyo/common.h
@@ -1202,7 +1202,7 @@ static inline void tomoyo_put_group(struct tomoyo_group *group)
  */
 static inline struct tomoyo_domain_info *tomoyo_domain(void)
 {
-	return current_cred()->security;
+	return current_cred()->cred_tomoyo;
 }
 
 /**
@@ -1215,7 +1215,7 @@ static inline struct tomoyo_domain_info *tomoyo_domain(void)
 static inline struct tomoyo_domain_info *tomoyo_real_domain(struct task_struct
 							    *task)
 {
-	return task_cred_xxx(task, security);
+	return task_cred_xxx(task, cred_tomoyo);
 }
 
 /**
diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
index 3865145..04f7389 100644
--- a/security/tomoyo/domain.c
+++ b/security/tomoyo/domain.c
@@ -840,7 +840,7 @@ force_jump_domain:
 		domain = old_domain;
 	/* Update reference count on "struct tomoyo_domain_info". */
 	atomic_inc(&domain->users);
-	bprm->cred->security = domain;
+	bprm->cred->cred_tomoyo = domain;
 	kfree(exename.name);
 	if (!retval) {
 		ee->r.domain = domain;
diff --git a/security/tomoyo/gc.c b/security/tomoyo/gc.c
index 986a6a7..87604b5 100644
--- a/security/tomoyo/gc.c
+++ b/security/tomoyo/gc.c
@@ -248,7 +248,7 @@ static inline void tomoyo_del_domain(struct list_head *element)
 	struct tomoyo_acl_info *tmp;
 	/*
 	 * Since this domain is referenced from neither
-	 * "struct tomoyo_io_buffer" nor "struct cred"->security, we can delete
+	 * "struct tomoyo_io_buffer" nor "struct cred"->cred_tomoyo, we can delete
 	 * elements without checking for is_deleted flag.
 	 */
 	list_for_each_entry_safe(acl, tmp, &domain->acl_info_list, list) {
@@ -433,7 +433,7 @@ static void tomoyo_try_to_gc(const enum tomoyo_policy_id type,
 		break;
 	case TOMOYO_ID_DOMAIN:
 		/*
-		 * Don't kfree() until all "struct cred"->security forget this
+		 * Don't kfree() until all "struct cred"->cred_tomoyo forget this
 		 * element.
 		 */
 		if (atomic_read(&container_of
diff --git a/security/tomoyo/securityfs_if.c b/security/tomoyo/securityfs_if.c
index 179a955..8f1e9de 100644
--- a/security/tomoyo/securityfs_if.c
+++ b/security/tomoyo/securityfs_if.c
@@ -75,8 +75,8 @@ static ssize_t tomoyo_write_self(struct file *file, const char __user *buf,
 					error = -ENOMEM;
 				} else {
 					struct tomoyo_domain_info *old_domain =
-						cred->security;
-					cred->security = new_domain;
+						cred->cred_tomoyo;
+					cred->cred_tomoyo = new_domain;
 					atomic_inc(&new_domain->users);
 					atomic_dec(&old_domain->users);
 					commit_creds(cred);
@@ -241,7 +241,7 @@ static int __init tomoyo_initerface_init(void)
 	struct dentry *tomoyo_dir;
 
 	/* Don't create securityfs entries unless registered. */
-	if (current_cred()->security != &tomoyo_kernel_domain)
+	if (current_cred()->cred_tomoyo != &tomoyo_kernel_domain)
 		return 0;
 
 	tomoyo_dir = securityfs_create_dir("tomoyo", NULL);
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index f0b756e..3d38635 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -17,7 +17,7 @@
  */
 static int tomoyo_cred_alloc_blank(struct cred *new, gfp_t gfp)
 {
-	new->security = NULL;
+	new->cred_tomoyo = NULL;
 	return 0;
 }
 
@@ -33,8 +33,8 @@ static int tomoyo_cred_alloc_blank(struct cred *new, gfp_t gfp)
 static int tomoyo_cred_prepare(struct cred *new, const struct cred *old,
 			       gfp_t gfp)
 {
-	struct tomoyo_domain_info *domain = old->security;
-	new->security = domain;
+	struct tomoyo_domain_info *domain = old->cred_tomoyo;
+	new->cred_tomoyo = domain;
 	if (domain)
 		atomic_inc(&domain->users);
 	return 0;
@@ -58,7 +58,7 @@ static void tomoyo_cred_transfer(struct cred *new, const struct cred *old)
  */
 static void tomoyo_cred_free(struct cred *cred)
 {
-	struct tomoyo_domain_info *domain = cred->security;
+	struct tomoyo_domain_info *domain = cred->cred_tomoyo;
 	if (domain)
 		atomic_dec(&domain->users);
 }
@@ -72,12 +72,6 @@ static void tomoyo_cred_free(struct cred *cred)
  */
 static int tomoyo_bprm_set_creds(struct linux_binprm *bprm)
 {
-	int rc;
-
-	rc = cap_bprm_set_creds(bprm);
-	if (rc)
-		return rc;
-
 	/*
 	 * Do only if this function is called for the first time of an execve
 	 * operation.
@@ -94,17 +88,17 @@ static int tomoyo_bprm_set_creds(struct linux_binprm *bprm)
 #endif
 	/*
 	 * Release reference to "struct tomoyo_domain_info" stored inside
-	 * "bprm->cred->security". New reference to "struct tomoyo_domain_info"
-	 * stored inside "bprm->cred->security" will be acquired later inside
+	 * "bprm->cred->cred_tomoyo". New reference to "struct tomoyo_domain_info"
+	 * stored inside "bprm->cred->cred_tomoyo" will be acquired later inside
 	 * tomoyo_find_next_domain().
 	 */
 	atomic_dec(&((struct tomoyo_domain_info *)
-		     bprm->cred->security)->users);
+		     bprm->cred->cred_tomoyo)->users);
 	/*
 	 * Tell tomoyo_bprm_check_security() is called for the first time of an
 	 * execve operation.
 	 */
-	bprm->cred->security = NULL;
+	bprm->cred->cred_tomoyo = NULL;
 	return 0;
 }
 
@@ -117,7 +111,7 @@ static int tomoyo_bprm_set_creds(struct linux_binprm *bprm)
  */
 static int tomoyo_bprm_check_security(struct linux_binprm *bprm)
 {
-	struct tomoyo_domain_info *domain = bprm->cred->security;
+	struct tomoyo_domain_info *domain = bprm->cred->cred_tomoyo;
 
 	/*
 	 * Execute permission is checked against pathname passed to do_execve()
@@ -553,7 +547,7 @@ static int __init tomoyo_init(void)
 	if (register_security(&tomoyo_security_ops))
 		panic("Failure registering TOMOYO Linux");
 	printk(KERN_INFO "TOMOYO Linux initialized\n");
-	cred->security = &tomoyo_kernel_domain;
+	cred->cred_tomoyo = &tomoyo_kernel_domain;
 	tomoyo_mm_init();
 	return 0;
 }
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 13c88fbc..7974a23 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -154,13 +154,9 @@ void yama_task_free(struct task_struct *task)
 int yama_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			   unsigned long arg4, unsigned long arg5)
 {
-	int rc;
+	int rc = 0;
 	struct task_struct *myself = current;
 
-	rc = cap_task_prctl(option, arg2, arg3, arg4, arg5);
-	if (rc != -ENOSYS)
-		return rc;
-
 	switch (option) {
 	case PR_SET_PTRACER:
 		/* Since a thread can call prctl(), find the group leader
@@ -284,13 +280,6 @@ int yama_ptrace_access_check(struct task_struct *child,
 {
 	int rc;
 
-	/* If standard caps disallows it, so does Yama.  We should
-	 * only tighten restrictions further.
-	 */
-	rc = cap_ptrace_access_check(child, mode);
-	if (rc)
-		return rc;
-
 	/* require ptrace target be a child of ptracer on attach */
 	if (mode == PTRACE_MODE_ATTACH) {
 		switch (ptrace_scope) {
@@ -335,14 +324,7 @@ int yama_ptrace_access_check(struct task_struct *child,
  */
 int yama_ptrace_traceme(struct task_struct *parent)
 {
-	int rc;
-
-	/* If standard caps disallows it, so does Yama.  We should
-	 * only tighten restrictions further.
-	 */
-	rc = cap_ptrace_traceme(parent);
-	if (rc)
-		return rc;
+	int rc = 0;
 
 	/* Only disallow PTRACE_TRACEME on more aggressive settings. */
 	switch (ptrace_scope) {
@@ -364,8 +346,7 @@ int yama_ptrace_traceme(struct task_struct *parent)
 	return rc;
 }
 
-#ifndef CONFIG_SECURITY_YAMA_STACKED
-static struct security_operations yama_ops = {
+struct security_operations yama_ops = {
 	.name =			"yama",
 
 	.ptrace_access_check =	yama_ptrace_access_check,
@@ -373,7 +354,6 @@ static struct security_operations yama_ops = {
 	.task_prctl =		yama_task_prctl,
 	.task_free =		yama_task_free,
 };
-#endif
 
 #ifdef CONFIG_SYSCTL
 static int yama_dointvec_minmax(struct ctl_table *table, int write,
@@ -421,17 +401,17 @@ static struct ctl_table yama_sysctl_table[] = {
 static __init int yama_init(void)
 {
 #ifndef CONFIG_SECURITY_YAMA_STACKED
+	/*
+	 * If yama is being stacked this is already taken care of.
+	 */
 	if (!security_module_enable(&yama_ops))
 		return 0;
-#endif
-
-	printk(KERN_INFO "Yama: becoming mindful.\n");
-
-#ifndef CONFIG_SECURITY_YAMA_STACKED
 	if (register_security(&yama_ops))
 		panic("Yama: kernel registration failed.\n");
 #endif
 
+	printk(KERN_INFO "Yama: becoming mindful.\n");
+
 #ifdef CONFIG_SYSCTL
 	if (!register_sysctl_paths(yama_sysctl_path, yama_sysctl_table))
 		panic("Yama: sysctl registration failed.\n");
