Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qAKK9hka030771
	for <selinux@tycho.nsa.gov>; Tue, 20 Nov 2012 15:09:43 -0500
Message-ID: <50ABE363.5010509@schaufler-ca.com>
Date: Tue, 20 Nov 2012 12:09:07 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>,
        LSM <linux-security-module@vger.kernel.org>
CC: SE Linux <selinux@tycho.nsa.gov>, Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Eric Paris <eparis@redhat.com>, Kees Cook <keescook@chromium.org>
Subject: [PATCH v8 2/2] LSM: Multiple concurrent LSMs
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Subject: [PATCH v8 2/2] LSM: Multiple concurrent LSMs

Hopefully this version will get past mail list filters.

The LSM composer seems past "can it work" and is on to
the "does it work well" phase. I have not tried to
reintroduce LSMs as loadable modules, in spite of the
vigor with which it has been requested. I see that as
work for another day, and a seperate battle to fight.
The current implementation of reset_security_ops() is
not up to the rigors required of a real load/unload
mechanism.

Version 8 of the patch addresses:

1. An error in the indexing in out-of-memory
   error handling in non-macroed alloc hooks.
2. Broken up for size. Not bisectable.

Version 7 of the patch addresses:

1. security/capability.c has been removed and
   all the special case code for when there is
   no LSM hook has been moved to the function
   in security/security.c. There is no longer
   a capability_ops vector.
2. Tetsuo Handa suggested that putting list headers
   into the security_operations structure rather
   than allocating the list elements on the fly
   would reduce the amount of out-of-memory error
   code required. It also makes a lot of the list
   initialization and management easier.
3. Macros are back in security_hook functions by
   reviewer request.
4. The component of the memory leak introduced by
   allocated list entries when calling
   reset_security_ops() is no longer there. The
   Portion created by LSM code remains.

Version 6 of the patch addresses:

1. The array based hook calling loops have been
   replaced by hook lists. The blobs remain array
   based.
2. Hooks are inserted into the lists based on the
   order specified in the security= boot parameter.
   If you really want AppArmor called before Yama
   you can do that. If there is no security=
   parameter it goes back to first come, first
   called.
3. prctl is a special case that assumes a single
   provider for any given option.
4. The security_hook funtions have been un-macroed.
   This should make dealing with special cases
   easier at the cost of code bulk.
5. Hooks from the capability vector are called
   directly rather than getting put on lists.
   This makes the security_reset_ops process
   rational. It also makes it easy to change the
   cap_hook to always getting called.

Version 5 of the patch addresses:

1. Tetsuo Handa pointed out that handling of failures
   alloc hooks was still not correct in v4. The code
   now only calls the free hook for LSMs that have
   had their alloc hook successfully called. The alloc
   hooks have been de-macro-ized, too.
2. Removed the Yama special case. It is no longer
   necessary.

Version 4 of the patch addresses:

1. Removed the conditional CONFIG_SECURITY_COMPOSER.
   This removes the option for LSMs to opt out of the
   multiple concurrent LSM mechanism. It also prevents
   breaking the change into meaningful subsets.
2. Pulled the trivial hooks out of the capability LSM
   as the security_hook calls make calling them unnecessary.
3. Removed register_security as it has nothing to do.
4. Changed the way security_hook calls the LSM specific
   hooks so that the capability hook is only called if
   no other LSM has supplied a hook, rather than looking
   to see if there is a capability hook.
5. Removed security_fixup_ops. The capability LSM only
   contains "real" hooks. Removed security_fixdown_ops
   as well, for the same reason.
6. Simplified security_reset_ops and made it reasonably safe.


Version 3 of the patchset addresses:

1. Improvements to allocations in lsm_read for the
   securityfs lsm interface.
2. A repair to the ordering of an NULL check in
   security_module_enable.
3. Sharing of the inode_getsecurity, inode_setsecurity
   and inode_listsecurity hooks, even thougth there is
   no current contention for them.

Version 2 of the patchset addresses:

1. The lsm_set functions did not handle error cases.
   The on demand allocation has been replaced with a
   more robust scheme within the security_alloc hooks.
   This requires more change in security/security.c
   but has the advantage of being more likely to be
   correct.
2. reset_security_ops() didn't work, causing a panic
   on invocation. That's been fixed. The change is
   somewhat invasive relative to the functionality.
3. Add registration time detection of LSMs that are
   going to use hooks that can't (currently) be shared.

Provide a mechanism for using multiple LSMs on the same
running kernel. This mechanism is not backward compatible.
All LSMs must conform to it.

As David Howells suggested some time back, making Smack and
SELinux available at that same time has proven quite a
challenge. That work has been deferred and that particular
configuration disallowed.

The Smack LSM behavior has been tested. AppArmor, TOMOYO,
Yama and SELinux have been shown to boot, but have not been
functionally tested beyond the lack of obvious error messages
and complaints from kernel debugging facilities. The kernels
have been tested with Ubuntu 12.04 and Fedora 17.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

---

 include/linux/lsm.h                 |  194 ++++
 include/linux/security.h            |  216 +++-
 security/Kconfig                    |   75 +-
 security/Makefile                   |    3 +-
 security/apparmor/context.c         |   10 +-
 security/apparmor/domain.c          |    8 +-
 security/apparmor/include/context.h |   13 +-
 security/apparmor/lsm.c             |   45 +-
 security/capability.c               | 1075 -------------------
 security/inode.c                    |   46 +-
 security/selinux/hooks.c            |  355 ++++---
 security/selinux/include/objsec.h   |    2 +
 security/selinux/include/xfrm.h     |    2 +-
 security/selinux/netlabel.c         |   13 +-
 security/selinux/selinuxfs.c        |    6 +-
 security/selinux/xfrm.c             |    9 +-
 security/smack/Kconfig              |    1 -
 security/smack/smack.h              |   14 +-
 security/smack/smack_access.c       |    2 +-
 security/smack/smack_lsm.c          |  319 +++---
 security/smack/smackfs.c            |   92 +-
 security/tomoyo/common.h            |    6 +-
 security/tomoyo/domain.c            |    2 +-
 security/tomoyo/securityfs_if.c     |    9 +-
 security/tomoyo/tomoyo.c            |   41 +-
 security/yama/Kconfig               |    7 -
 security/yama/yama_lsm.c            |    9 -
 28 files changed, 2698 insertions(+), 1830 deletions(-)

diff --git a/include/linux/lsm.h b/include/linux/lsm.h
new file mode 100644
index 0000000..06f53ff
--- /dev/null
+++ b/include/linux/lsm.h
@@ -0,0 +1,194 @@
+/*
+ *
+ * Copyright (C) 2012 Casey Schaufler <casey@schaufler-ca.com>
+ * Copyright (C) 2012 Intel Corporation
+ *
+ *	This program is free software; you can redistribute it and/or modify
+ *	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
+ *
+ * Author:
+ *	Casey Schaufler <casey@schaufler-ca.com>
+ *
+ */
+#ifndef _LINUX_LSM_H
+#define _LINUX_LSM_H
+
+#include <linux/cred.h>
+#include <linux/fs.h>
+#include <linux/msg.h>
+#include <linux/key.h>
+#include <net/sock.h>
+
+/*
+ * Maximum number of LSMs that can be used at a time.
+ */
+#define COMPOSER_MAX		CONFIG_SECURITY_COMPOSER_MAX
+#define COMPOSER_NAMES_MAX	((SECURITY_NAME_MAX + 1) * COMPOSER_MAX)
+
+#include <linux/security.h>
+
+/*
+ * Just a set of slots for each LSM to keep its blob in.
+ */
+struct lsm_blob {
+	int	lsm_setcount;			/* Number of blobs set */
+	void	*lsm_blobs[COMPOSER_MAX];	/* LSM specific blobs */
+};
+
+static inline struct lsm_blob *lsm_alloc_blob(gfp_t gfp)
+{
+	return kzalloc(sizeof(struct lsm_blob), gfp);
+}
+
+static inline void *lsm_get_blob(const struct lsm_blob *bp, const int lsm)
+{
+	if (bp == NULL)
+		return NULL;
+	return bp->lsm_blobs[lsm];
+}
+
+static inline void lsm_set_blob(void **vpp, void *value, const int lsm)
+{
+	struct lsm_blob *bp = *vpp;
+
+	if (value == NULL && bp->lsm_blobs[lsm] != NULL)
+		bp->lsm_setcount--;
+	if (value != NULL && bp->lsm_blobs[lsm] == NULL)
+		bp->lsm_setcount++;
+
+	bp->lsm_blobs[lsm] = value;
+}
+
+static inline void *lsm_get_cred(const struct cred *cred,
+					const struct security_operations *sop)
+{
+#ifdef CONFIG_SECURITY_COMPOSER_DEBUG
+	if (cred == NULL) {
+		pr_warn("%s: cred is NULL, LSM is %s.\n", __func__, sop->name);
+		return NULL;
+	}
+	if (cred->security == NULL) {
+		pr_warn("%s: cred blob NULL, LSM is %s.\n",
+			__func__, sop->name);
+		return NULL;
+	}
+#endif /* CONFIG_SECURITY_COMPOSER_DEBUG */
+	return lsm_get_blob(cred->security, sop->order);
+}
+
+static inline void lsm_set_cred(struct cred *cred, void *value,
+					const struct security_operations *sop)
+{
+	lsm_set_blob(&cred->security, value, sop->order);
+}
+
+static inline int lsm_set_init_cred(struct cred *cred, void *value,
+					const struct security_operations *sop)
+{
+	if (cred->security == NULL) {
+		cred->security = lsm_alloc_blob(GFP_KERNEL);
+		if (cred->security == NULL)
+			return -ENOMEM;
+	}
+
+	lsm_set_blob(&cred->security, value, sop->order);
+	return 0;
+}
+
+static inline void *lsm_get_file(const struct file *file,
+					const struct security_operations *sop)
+{
+	return lsm_get_blob(file->f_security, sop->order);
+}
+
+static inline void lsm_set_file(struct file *file, void *value,
+					const struct security_operations *sop)
+{
+	lsm_set_blob(&file->f_security, value, sop->order);
+}
+
+static inline void *lsm_get_inode(const struct inode *inode,
+					const struct security_operations *sop)
+{
+	return lsm_get_blob(inode->i_security, sop->order);
+}
+
+static inline void lsm_set_inode(struct inode *inode, void *value,
+					const struct security_operations *sop)
+{
+#ifdef CONFIG_SECURITY_COMPOSER_DEBUG
+	if (inode == NULL) {
+		pr_warn("%s: inode is NULL, LSM is %s.\n", __func__, sop->name);
+		return;
+	}
+	if (inode->i_security == NULL) {
+		pr_warn("%s: inode blob is NULL, LSM is %s.\n",
+			__func__, sop->name);
+		inode->i_security = lsm_alloc_blob(GFP_KERNEL);
+	}
+#endif /* CONFIG_SECURITY_COMPOSER_DEBUG */
+	lsm_set_blob(&inode->i_security, value, sop->order);
+}
+
+static inline void *lsm_get_super(const struct super_block *super,
+					const struct security_operations *sop)
+{
+	return lsm_get_blob(super->s_security, sop->order);
+}
+
+static inline void lsm_set_super(struct super_block *super, void *value,
+					const struct security_operations *sop)
+{
+	lsm_set_blob(&super->s_security, value, sop->order);
+}
+
+static inline void *lsm_get_ipc(const struct kern_ipc_perm *ipc,
+					const struct security_operations *sop)
+{
+	return lsm_get_blob(ipc->security, sop->order);
+}
+
+static inline void lsm_set_ipc(struct kern_ipc_perm *ipc, void *value,
+					const struct security_operations *sop)
+{
+	lsm_set_blob(&ipc->security, value, sop->order);
+}
+
+static inline void *lsm_get_msg(const struct msg_msg *msg,
+					const struct security_operations *sop)
+{
+	return lsm_get_blob(msg->security, sop->order);
+}
+
+static inline void lsm_set_msg(struct msg_msg *msg, void *value,
+					const struct security_operations *sop)
+{
+	lsm_set_blob(&msg->security, value, sop->order);
+}
+
+static inline void *lsm_get_key(const struct key *key,
+					const struct security_operations *sop)
+{
+	return lsm_get_blob(key->security, sop->order);
+}
+
+static inline void lsm_set_key(struct key *key, void *value,
+					const struct security_operations *sop)
+{
+	lsm_set_blob(&key->security, value, sop->order);
+}
+
+static inline void *lsm_get_sock(const struct sock *sock,
+					const struct security_operations *sop)
+{
+	return lsm_get_blob(sock->sk_security, sop->order);
+}
+
+static inline void lsm_set_sock(struct sock *sock, void *value,
+					const struct security_operations *sop)
+{
+	lsm_set_blob(&sock->sk_security, value, sop->order);
+}
+
+#endif /* ! _LINUX_LSM_H */
diff --git a/include/linux/security.h b/include/linux/security.h
index 05e88bd..ce9b943 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -112,8 +112,6 @@ struct seq_file;
 
 extern int cap_netlink_send(struct sock *sk, struct sk_buff *skb);
 
-void reset_security_ops(void);
-
 #ifdef CONFIG_MMU
 extern unsigned long mmap_min_addr;
 extern unsigned long dac_mmap_min_addr;
@@ -184,15 +182,222 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
 	opts->num_mnt_opts = 0;
 }
 
+/*
+ * Index for LSM operations.
+ */
+enum lsm_hooks_index {
+	LSM_ptrace_access_check,
+	LSM_ptrace_traceme,
+	LSM_capget,
+	LSM_capset,
+	LSM_capable,
+	LSM_quotactl,
+	LSM_quota_on,
+	LSM_syslog,
+	LSM_settime,
+	LSM_vm_enough_memory,
+	LSM_bprm_set_creds,
+	LSM_bprm_check_security,
+	LSM_bprm_secureexec,
+	LSM_bprm_committing_creds,
+	LSM_bprm_committed_creds,
+	LSM_sb_alloc_security,
+	LSM_sb_free_security,
+	LSM_sb_copy_data,
+	LSM_sb_remount,
+	LSM_sb_kern_mount,
+	LSM_sb_show_options,
+	LSM_sb_statfs,
+	LSM_sb_mount,
+	LSM_sb_umount,
+	LSM_sb_pivotroot,
+	LSM_sb_set_mnt_opts,
+	LSM_sb_clone_mnt_opts,
+	LSM_sb_parse_opts_str,
+	LSM_path_unlink,
+	LSM_path_mkdir,
+	LSM_path_rmdir,
+	LSM_path_mknod,
+	LSM_path_truncate,
+	LSM_path_symlink,
+	LSM_path_link,
+	LSM_path_rename,
+	LSM_path_chmod,
+	LSM_path_chown,
+	LSM_path_chroot,
+	LSM_inode_alloc_security,
+	LSM_inode_free_security,
+	LSM_inode_init_security,
+	LSM_inode_create,
+	LSM_inode_link,
+	LSM_inode_unlink,
+	LSM_inode_symlink,
+	LSM_inode_mkdir,
+	LSM_inode_rmdir,
+	LSM_inode_mknod,
+	LSM_inode_rename,
+	LSM_inode_readlink,
+	LSM_inode_follow_link,
+	LSM_inode_permission,
+	LSM_inode_setattr,
+	LSM_inode_getattr,
+	LSM_inode_setxattr,
+	LSM_inode_post_setxattr,
+	LSM_inode_getxattr,
+	LSM_inode_listxattr,
+	LSM_inode_removexattr,
+	LSM_inode_need_killpriv,
+	LSM_inode_killpriv,
+	LSM_inode_getsecurity,
+	LSM_inode_setsecurity,
+	LSM_inode_listsecurity,
+	LSM_inode_getsecid,
+	LSM_file_permission,
+	LSM_file_alloc_security,
+	LSM_file_free_security,
+	LSM_file_ioctl,
+	LSM_mmap_addr,
+	LSM_mmap_file,
+	LSM_file_mprotect,
+	LSM_file_lock,
+	LSM_file_fcntl,
+	LSM_file_set_fowner,
+	LSM_file_send_sigiotask,
+	LSM_file_receive,
+	LSM_file_open,
+	LSM_task_create,
+	LSM_task_free,
+	LSM_cred_alloc_blank,
+	LSM_cred_free,
+	LSM_cred_prepare,
+	LSM_cred_transfer,
+	LSM_kernel_act_as,
+	LSM_kernel_create_files_as,
+	LSM_kernel_module_request,
+	LSM_task_fix_setuid,
+	LSM_task_setpgid,
+	LSM_task_getpgid,
+	LSM_task_getsid,
+	LSM_task_getsecid,
+	LSM_task_setnice,
+	LSM_task_setioprio,
+	LSM_task_getioprio,
+	LSM_task_setrlimit,
+	LSM_task_setscheduler,
+	LSM_task_getscheduler,
+	LSM_task_movememory,
+	LSM_task_kill,
+	LSM_task_wait,
+	LSM_task_prctl,
+	LSM_task_to_inode,
+	LSM_ipc_permission,
+	LSM_ipc_getsecid,
+	LSM_msg_msg_alloc_security,
+	LSM_msg_msg_free_security,
+	LSM_msg_queue_alloc_security,
+	LSM_msg_queue_free_security,
+	LSM_msg_queue_associate,
+	LSM_msg_queue_msgctl,
+	LSM_msg_queue_msgsnd,
+	LSM_msg_queue_msgrcv,
+	LSM_shm_alloc_security,
+	LSM_shm_free_security,
+	LSM_shm_associate,
+	LSM_shm_shmctl,
+	LSM_shm_shmat,
+	LSM_sem_alloc_security,
+	LSM_sem_free_security,
+	LSM_sem_associate,
+	LSM_sem_semctl,
+	LSM_sem_semop,
+	LSM_netlink_send,
+	LSM_d_instantiate,
+	LSM_getprocattr,
+	LSM_setprocattr,
+	LSM_secid_to_secctx,
+	LSM_secctx_to_secid,
+	LSM_release_secctx,
+	LSM_inode_notifysecctx,
+	LSM_inode_setsecctx,
+	LSM_inode_getsecctx,
+	LSM_unix_stream_connect,
+	LSM_unix_may_send,
+	LSM_socket_create,
+	LSM_socket_post_create,
+	LSM_socket_bind,
+	LSM_socket_connect,
+	LSM_socket_listen,
+	LSM_socket_accept,
+	LSM_socket_sendmsg,
+	LSM_socket_recvmsg,
+	LSM_socket_getsockname,
+	LSM_socket_getpeername,
+	LSM_socket_getsockopt,
+	LSM_socket_setsockopt,
+	LSM_socket_shutdown,
+	LSM_socket_sock_rcv_skb,
+	LSM_socket_getpeersec_stream,
+	LSM_socket_getpeersec_dgram,
+	LSM_sk_alloc_security,
+	LSM_sk_free_security,
+	LSM_sk_clone_security,
+	LSM_sk_getsecid,
+	LSM_sock_graft,
+	LSM_inet_conn_request,
+	LSM_inet_csk_clone,
+	LSM_inet_conn_established,
+	LSM_secmark_relabel_packet,
+	LSM_secmark_refcount_inc,
+	LSM_secmark_refcount_dec,
+	LSM_req_classify_flow,
+	LSM_tun_dev_create,
+	LSM_tun_dev_post_create,
+	LSM_tun_dev_attach,
+	LSM_xfrm_policy_alloc_security,
+	LSM_xfrm_policy_clone_security,
+	LSM_xfrm_policy_free_security,
+	LSM_xfrm_policy_delete_security,
+	LSM_xfrm_state_alloc_security,
+	LSM_xfrm_state_free_security,
+	LSM_xfrm_state_delete_security,
+	LSM_xfrm_policy_lookup,
+	LSM_xfrm_state_pol_flow_match,
+	LSM_xfrm_decode_session,
+	LSM_key_alloc,
+	LSM_key_free,
+	LSM_key_permission,
+	LSM_key_getsecurity,
+	LSM_audit_rule_init,
+	LSM_audit_rule_known,
+	LSM_audit_rule_match,
+	LSM_audit_rule_free,
+	LSM_name, /* Used by security/inode.c */
+	LSM_MAX_HOOKS
+};
+
+/*
+ * There is a list for each hook.
+ */
+extern struct list_head lsm_hooks[LSM_MAX_HOOKS];
+
 /**
  * struct security_operations - main security structure
  *
  * Security module identifier.
  *
+ * @list:
+ *	An array of lists of hooks. These are traversed on
+ *	hook execution.
+ *
  * @name:
  *	A string that acts as a unique identifier for the LSM with max number
  *	of characters = SECURITY_NAME_MAX.
  *
+ * @order:
+ *	The numeric order in which this LSM will be invoked.
+ *	Set during LSM initialization. Used to identify
+ *	which security blob to use when there is more than one LSM.
+ *
  * Security hooks for program execution operations.
  *
  * @bprm_set_creds:
@@ -1378,7 +1583,9 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
  * This is the main security structure.
  */
 struct security_operations {
+	struct list_head list[LSM_MAX_HOOKS];
 	char name[SECURITY_NAME_MAX + 1];
+	int order;
 
 	int (*ptrace_access_check) (struct task_struct *child, unsigned int mode);
 	int (*ptrace_traceme) (struct task_struct *parent);
@@ -1658,9 +1865,10 @@ struct security_operations {
 /* prototypes */
 extern int security_init(void);
 extern int security_module_enable(struct security_operations *ops);
-extern int register_security(struct security_operations *ops);
-extern void __init security_fixup_ops(struct security_operations *ops);
 
+#ifdef CONFIG_SECURITY_SELINUX_DISABLE
+extern int reset_security_ops(struct security_operations *ops);
+#endif /* CONFIG_SECURITY_SELINUX_DISABLE */
 
 /* Security operations */
 int security_ptrace_access_check(struct task_struct *child, unsigned int mode);
diff --git a/security/Kconfig b/security/Kconfig
index e9c6ac7..da418a5 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -123,49 +123,66 @@ source security/tomoyo/Kconfig
 source security/apparmor/Kconfig
 source security/yama/Kconfig
 
+config SECURITY_COMPOSER_MAX
+	int "Maximum allowed security modules (2 to 12)"
+	depends on SECURITY
+	default 6
+	range 2 12
+	help
+	  The number of security modules that can be loaded.
+	  The capability module is always loaded, so the minimum
+	  allowed value is 2. The default value matches the number
+	  of upstream modules. The maximum allowed value is 12.
+
+config SECURITY_COMPOSER_DEBUG
+	bool "Debugging information about LSM interactions"
+	depends on SECURITY
+	default n
+	help
+	  Provides run time information regarding possible
+	  improper use of the LSM composer.
+
+	  If you are unsure how to answer this question, answer N.
+
 source security/integrity/Kconfig
 
 choice
-	prompt "Default security module"
-	default DEFAULT_SECURITY_SELINUX if SECURITY_SELINUX
-	default DEFAULT_SECURITY_SMACK if SECURITY_SMACK
-	default DEFAULT_SECURITY_TOMOYO if SECURITY_TOMOYO
-	default DEFAULT_SECURITY_APPARMOR if SECURITY_APPARMOR
-	default DEFAULT_SECURITY_YAMA if SECURITY_YAMA
-	default DEFAULT_SECURITY_DAC
+	depends on SECURITY
+	prompt "Presented security module"
+	default PRESENT_SECURITY_SELINUX if SECURITY_SELINUX
+	default PRESENT_SECURITY_SMACK if SECURITY_SMACK
+	default PRESENT_SECURITY_APPARMOR if SECURITY_APPARMOR
+	default PRESENT_SECURITY_FORMATTED
 
 	help
-	  Select the security module that will be used by default if the
-	  kernel parameter security= is not specified.
-
-	config DEFAULT_SECURITY_SELINUX
+	  Select the security module that will be presented
+	  with the /proc/*/attr interface.
+	  If not specified the interfaces will expect input
+	  to be specified as LSM name and value pairs, with
+	  the specifications deliminated by "/" characters, as
+	  "/smack=_/" or "/apparmor=unconfined/smack=_/".
+	  The leading, separating, and terminating "/" are
+	  all required.
+
+	config PRESENT_SECURITY_SELINUX
 		bool "SELinux" if SECURITY_SELINUX=y
 
-	config DEFAULT_SECURITY_SMACK
+	config PRESENT_SECURITY_SMACK
 		bool "Simplified Mandatory Access Control" if SECURITY_SMACK=y
 
-	config DEFAULT_SECURITY_TOMOYO
-		bool "TOMOYO" if SECURITY_TOMOYO=y
-
-	config DEFAULT_SECURITY_APPARMOR
+	config PRESENT_SECURITY_APPARMOR
 		bool "AppArmor" if SECURITY_APPARMOR=y
 
-	config DEFAULT_SECURITY_YAMA
-		bool "Yama" if SECURITY_YAMA=y
-
-	config DEFAULT_SECURITY_DAC
-		bool "Unix Discretionary Access Controls"
+	config PRESENT_SECURITY_FORMATTED
+		bool "Use /lsm=.../lsm=.../ format"
 
 endchoice
 
-config DEFAULT_SECURITY
+config PRESENT_SECURITY
 	string
-	default "selinux" if DEFAULT_SECURITY_SELINUX
-	default "smack" if DEFAULT_SECURITY_SMACK
-	default "tomoyo" if DEFAULT_SECURITY_TOMOYO
-	default "apparmor" if DEFAULT_SECURITY_APPARMOR
-	default "yama" if DEFAULT_SECURITY_YAMA
-	default "" if DEFAULT_SECURITY_DAC
+	default "selinux" if PRESENT_SECURITY_SELINUX
+	default "smack" if PRESENT_SECURITY_SMACK
+	default "apparmor" if PRESENT_SECURITY_APPARMOR
+	default "formatted"
 
 endmenu
-
diff --git a/security/Makefile b/security/Makefile
index c26c81e..b1875b1 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -14,9 +14,8 @@ obj-y					+= commoncap.o
 obj-$(CONFIG_MMU)			+= min_addr.o
 
 # Object file lists
-obj-$(CONFIG_SECURITY)			+= security.o capability.o
+obj-$(CONFIG_SECURITY)			+= security.o
 obj-$(CONFIG_SECURITYFS)		+= inode.o
-# Must precede capability.o in order to stack properly.
 obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/built-in.o
 obj-$(CONFIG_SECURITY_SMACK)		+= smack/built-in.o
 obj-$(CONFIG_AUDIT)			+= lsm_audit.o
diff --git a/security/apparmor/context.c b/security/apparmor/context.c
index 8a9b502..3d9e460 100644
--- a/security/apparmor/context.c
+++ b/security/apparmor/context.c
@@ -76,7 +76,7 @@ void aa_dup_task_context(struct aa_task_cxt *new, const struct aa_task_cxt *old)
  */
 int aa_replace_current_profile(struct aa_profile *profile)
 {
-	struct aa_task_cxt *cxt = current_cred()->security;
+	struct aa_task_cxt *cxt = lsm_get_cred(current_cred(), &apparmor_ops);
 	struct cred *new;
 	BUG_ON(!profile);
 
@@ -87,7 +87,7 @@ int aa_replace_current_profile(struct aa_profile *profile)
 	if (!new)
 		return -ENOMEM;
 
-	cxt = new->security;
+	cxt = lsm_get_cred(new, &apparmor_ops);
 	if (unconfined(profile) || (cxt->profile->ns != profile->ns)) {
 		/* if switching to unconfined or a different profile namespace
 		 * clear out context state
@@ -123,7 +123,7 @@ int aa_set_current_onexec(struct aa_profile *profile)
 	if (!new)
 		return -ENOMEM;
 
-	cxt = new->security;
+	cxt = lsm_get_cred(new, &apparmor_ops);
 	aa_get_profile(profile);
 	aa_put_profile(cxt->onexec);
 	cxt->onexec = profile;
@@ -150,7 +150,7 @@ int aa_set_current_hat(struct aa_profile *profile, u64 token)
 		return -ENOMEM;
 	BUG_ON(!profile);
 
-	cxt = new->security;
+	cxt = lsm_get_cred(new, &apparmor_ops);
 	if (!cxt->previous) {
 		/* transfer refcount */
 		cxt->previous = cxt->profile;
@@ -187,7 +187,7 @@ int aa_restore_previous_profile(u64 token)
 	if (!new)
 		return -ENOMEM;
 
-	cxt = new->security;
+	cxt = lsm_get_cred(new, &apparmor_ops);
 	if (cxt->token != token) {
 		abort_creds(new);
 		return -EACCES;
diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 60f0c76..bf9d1c1 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -360,7 +360,7 @@ int apparmor_bprm_set_creds(struct linux_binprm *bprm)
 	if (bprm->cred_prepared)
 		return 0;
 
-	cxt = bprm->cred->security;
+	cxt = lsm_get_cred(bprm->cred, &apparmor_ops);
 	BUG_ON(!cxt);
 
 	profile = aa_get_profile(aa_newest_version(cxt->profile));
@@ -557,7 +557,7 @@ int apparmor_bprm_secureexec(struct linux_binprm *bprm)
 void apparmor_bprm_committing_creds(struct linux_binprm *bprm)
 {
 	struct aa_profile *profile = __aa_current_profile();
-	struct aa_task_cxt *new_cxt = bprm->cred->security;
+	struct aa_task_cxt *new_cxt = lsm_get_cred(bprm->cred, &apparmor_ops);
 
 	/* bail out if unconfined or not changing profile */
 	if ((new_cxt->profile == profile) ||
@@ -634,7 +634,7 @@ int aa_change_hat(const char *hats[], int count, u64 token, bool permtest)
 
 	/* released below */
 	cred = get_current_cred();
-	cxt = cred->security;
+	cxt = lsm_get_cred(cred, &apparmor_ops);
 	profile = aa_cred_profile(cred);
 	previous_profile = cxt->previous;
 
@@ -770,7 +770,7 @@ int aa_change_profile(const char *ns_name, const char *hname, bool onexec,
 	}
 
 	cred = get_current_cred();
-	cxt = cred->security;
+	cxt = lsm_get_cred(cred, &apparmor_ops);
 	profile = aa_cred_profile(cred);
 
 	/*
diff --git a/security/apparmor/include/context.h b/security/apparmor/include/context.h
index a9cbee4..8484e55 100644
--- a/security/apparmor/include/context.h
+++ b/security/apparmor/include/context.h
@@ -18,6 +18,7 @@
 #include <linux/cred.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
+#include <linux/lsm.h>
 
 #include "policy.h"
 
@@ -81,6 +82,8 @@ int aa_set_current_onexec(struct aa_profile *profile);
 int aa_set_current_hat(struct aa_profile *profile, u64 token);
 int aa_restore_previous_profile(u64 cookie);
 
+extern struct security_operations apparmor_ops;
+
 /**
  * __aa_task_is_confined - determine if @task has any confinement
  * @task: task to check confinement of  (NOT NULL)
@@ -89,7 +92,9 @@ int aa_restore_previous_profile(u64 cookie);
  */
 static inline bool __aa_task_is_confined(struct task_struct *task)
 {
-	struct aa_task_cxt *cxt = __task_cred(task)->security;
+	struct aa_task_cxt *cxt;
+
+	cxt = lsm_get_cred(__task_cred(task), &apparmor_ops);
 
 	BUG_ON(!cxt || !cxt->profile);
 	if (unconfined(aa_newest_version(cxt->profile)))
@@ -108,7 +113,7 @@ static inline bool __aa_task_is_confined(struct task_struct *task)
  */
 static inline struct aa_profile *aa_cred_profile(const struct cred *cred)
 {
-	struct aa_task_cxt *cxt = cred->security;
+	struct aa_task_cxt *cxt = lsm_get_cred(cred, &apparmor_ops);
 	BUG_ON(!cxt || !cxt->profile);
 	return aa_newest_version(cxt->profile);
 }
@@ -136,8 +141,10 @@ static inline struct aa_profile *__aa_current_profile(void)
  */
 static inline struct aa_profile *aa_current_profile(void)
 {
-	const struct aa_task_cxt *cxt = current_cred()->security;
+	const struct aa_task_cxt *cxt;
 	struct aa_profile *profile;
+
+	cxt = lsm_get_cred(current_cred(), &apparmor_ops);
 	BUG_ON(!cxt || !cxt->profile);
 
 	profile = aa_newest_version(cxt->profile);
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 8c2a7f6..a464999 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -48,8 +48,8 @@ int apparmor_initialized __initdata;
  */
 static void apparmor_cred_free(struct cred *cred)
 {
-	aa_free_task_context(cred->security);
-	cred->security = NULL;
+	aa_free_task_context(lsm_get_cred(cred, &apparmor_ops));
+	lsm_set_cred(cred, NULL, &apparmor_ops);
 }
 
 /*
@@ -62,7 +62,7 @@ static int apparmor_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 	if (!cxt)
 		return -ENOMEM;
 
-	cred->security = cxt;
+	lsm_set_cred(cred, cxt, &apparmor_ops);
 	return 0;
 }
 
@@ -77,8 +77,8 @@ static int apparmor_cred_prepare(struct cred *new, const struct cred *old,
 	if (!cxt)
 		return -ENOMEM;
 
-	aa_dup_task_context(cxt, old->security);
-	new->security = cxt;
+	aa_dup_task_context(cxt, lsm_get_cred(old, &apparmor_ops));
+	lsm_set_cred(new, cxt, &apparmor_ops);
 	return 0;
 }
 
@@ -87,8 +87,8 @@ static int apparmor_cred_prepare(struct cred *new, const struct cred *old,
  */
 static void apparmor_cred_transfer(struct cred *new, const struct cred *old)
 {
-	const struct aa_task_cxt *old_cxt = old->security;
-	struct aa_task_cxt *new_cxt = new->security;
+	const struct aa_task_cxt *old_cxt = lsm_get_cred(old, &apparmor_ops);
+	struct aa_task_cxt *new_cxt = lsm_get_cred(new, &apparmor_ops);
 
 	aa_dup_task_context(new_cxt, old_cxt);
 }
@@ -375,7 +375,7 @@ static int apparmor_inode_getattr(struct vfsmount *mnt, struct dentry *dentry)
 
 static int apparmor_file_open(struct file *file, const struct cred *cred)
 {
-	struct aa_file_cxt *fcxt = file->f_security;
+	struct aa_file_cxt *fcxt = lsm_get_file(file, &apparmor_ops);
 	struct aa_profile *profile;
 	int error = 0;
 
@@ -409,8 +409,8 @@ static int apparmor_file_open(struct file *file, const struct cred *cred)
 static int apparmor_file_alloc_security(struct file *file)
 {
 	/* freed by apparmor_file_free_security */
-	file->f_security = aa_alloc_file_context(GFP_KERNEL);
-	if (!file->f_security)
+	lsm_set_file(file, aa_alloc_file_context(GFP_KERNEL), &apparmor_ops);
+	if (!lsm_get_file(file, &apparmor_ops))
 		return -ENOMEM;
 	return 0;
 
@@ -418,14 +418,15 @@ static int apparmor_file_alloc_security(struct file *file)
 
 static void apparmor_file_free_security(struct file *file)
 {
-	struct aa_file_cxt *cxt = file->f_security;
+	struct aa_file_cxt *cxt = lsm_get_file(file, &apparmor_ops);
 
+	lsm_set_file(file, NULL, &apparmor_ops);
 	aa_free_file_context(cxt);
 }
 
 static int common_file_perm(int op, struct file *file, u32 mask)
 {
-	struct aa_file_cxt *fcxt = file->f_security;
+	struct aa_file_cxt *fcxt = lsm_get_file(file, &apparmor_ops);
 	struct aa_profile *profile, *fprofile = aa_cred_profile(file->f_cred);
 	int error = 0;
 
@@ -472,7 +473,7 @@ static int common_mmap(int op, struct file *file, unsigned long prot,
 	struct dentry *dentry;
 	int mask = 0;
 
-	if (!file || !file->f_security)
+	if (!file || !lsm_get_file(file, &apparmor_ops))
 		return 0;
 
 	if (prot & PROT_READ)
@@ -510,7 +511,7 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
 	struct aa_profile *profile;
 	/* released below */
 	const struct cred *cred = get_task_cred(task);
-	struct aa_task_cxt *cxt = cred->security;
+	struct aa_task_cxt *cxt = lsm_get_cred(cred, &apparmor_ops);
 	profile = aa_cred_profile(cred);
 
 	if (strcmp(name, "current") == 0)
@@ -614,7 +615,7 @@ static int apparmor_task_setrlimit(struct task_struct *task,
 	return error;
 }
 
-static struct security_operations apparmor_ops = {
+struct security_operations apparmor_ops = {
 	.name =				"apparmor",
 
 	.ptrace_access_check =		apparmor_ptrace_access_check,
@@ -878,6 +879,7 @@ static int param_set_mode(const char *val, struct kernel_param *kp)
  */
 static int __init set_init_cxt(void)
 {
+	int rc;
 	struct cred *cred = (struct cred *)current->real_cred;
 	struct aa_task_cxt *cxt;
 
@@ -886,9 +888,9 @@ static int __init set_init_cxt(void)
 		return -ENOMEM;
 
 	cxt->profile = aa_get_profile(root_ns->unconfined);
-	cred->security = cxt;
+	rc = lsm_set_init_cred(cred, cxt, &apparmor_ops);
 
-	return 0;
+	return rc;
 }
 
 static int __init apparmor_init(void)
@@ -913,12 +915,6 @@ static int __init apparmor_init(void)
 		goto register_security_out;
 	}
 
-	error = register_security(&apparmor_ops);
-	if (error) {
-		AA_ERROR("Unable to register AppArmor\n");
-		goto set_init_cxt_out;
-	}
-
 	/* Report that AppArmor successfully initialized */
 	apparmor_initialized = 1;
 	if (aa_g_profile_mode == APPARMOR_COMPLAIN)
@@ -930,9 +926,6 @@ static int __init apparmor_init(void)
 
 	return error;
 
-set_init_cxt_out:
-	aa_free_task_context(current->real_cred->security);
-
 register_security_out:
 	aa_free_root_ns();
 
diff --git a/security/capability.c b/security/capability.c
deleted file mode 100644
index b14a30c..0000000
--- a/security/capability.c
+++ /dev/null
@@ -1,1075 +0,0 @@
-/*
- *  Capabilities Linux Security Module
- *
- *  This is the default security module in case no other module is loaded.
- *
- *	This program is free software; you can redistribute it and/or modify
- *	it under the terms of the GNU General Public License as published by
- *	the Free Software Foundation; either version 2 of the License, or
- *	(at your option) any later version.
- *
- */
-
-#include <linux/security.h>
-
-static int cap_syslog(int type)
-{
-	return 0;
-}
-
-static int cap_quotactl(int cmds, int type, int id, struct super_block *sb)
-{
-	return 0;
-}
-
-static int cap_quota_on(struct dentry *dentry)
-{
-	return 0;
-}
-
-static int cap_bprm_check_security(struct linux_binprm *bprm)
-{
-	return 0;
-}
-
-static void cap_bprm_committing_creds(struct linux_binprm *bprm)
-{
-}
-
-static void cap_bprm_committed_creds(struct linux_binprm *bprm)
-{
-}
-
-static int cap_sb_alloc_security(struct super_block *sb)
-{
-	return 0;
-}
-
-static void cap_sb_free_security(struct super_block *sb)
-{
-}
-
-static int cap_sb_copy_data(char *orig, char *copy)
-{
-	return 0;
-}
-
-static int cap_sb_remount(struct super_block *sb, void *data)
-{
-	return 0;
-}
-
-static int cap_sb_kern_mount(struct super_block *sb, int flags, void *data)
-{
-	return 0;
-}
-
-static int cap_sb_show_options(struct seq_file *m, struct super_block *sb)
-{
-	return 0;
-}
-
-static int cap_sb_statfs(struct dentry *dentry)
-{
-	return 0;
-}
-
-static int cap_sb_mount(const char *dev_name, struct path *path,
-			const char *type, unsigned long flags, void *data)
-{
-	return 0;
-}
-
-static int cap_sb_umount(struct vfsmount *mnt, int flags)
-{
-	return 0;
-}
-
-static int cap_sb_pivotroot(struct path *old_path, struct path *new_path)
-{
-	return 0;
-}
-
-static int cap_sb_set_mnt_opts(struct super_block *sb,
-			       struct security_mnt_opts *opts)
-{
-	if (unlikely(opts->num_mnt_opts))
-		return -EOPNOTSUPP;
-	return 0;
-}
-
-static void cap_sb_clone_mnt_opts(const struct super_block *oldsb,
-				  struct super_block *newsb)
-{
-}
-
-static int cap_sb_parse_opts_str(char *options, struct security_mnt_opts *opts)
-{
-	return 0;
-}
-
-static int cap_inode_alloc_security(struct inode *inode)
-{
-	return 0;
-}
-
-static void cap_inode_free_security(struct inode *inode)
-{
-}
-
-static int cap_inode_init_security(struct inode *inode, struct inode *dir,
-				   const struct qstr *qstr, char **name,
-				   void **value, size_t *len)
-{
-	return -EOPNOTSUPP;
-}
-
-static int cap_inode_create(struct inode *inode, struct dentry *dentry,
-			    umode_t mask)
-{
-	return 0;
-}
-
-static int cap_inode_link(struct dentry *old_dentry, struct inode *inode,
-			  struct dentry *new_dentry)
-{
-	return 0;
-}
-
-static int cap_inode_unlink(struct inode *inode, struct dentry *dentry)
-{
-	return 0;
-}
-
-static int cap_inode_symlink(struct inode *inode, struct dentry *dentry,
-			     const char *name)
-{
-	return 0;
-}
-
-static int cap_inode_mkdir(struct inode *inode, struct dentry *dentry,
-			   umode_t mask)
-{
-	return 0;
-}
-
-static int cap_inode_rmdir(struct inode *inode, struct dentry *dentry)
-{
-	return 0;
-}
-
-static int cap_inode_mknod(struct inode *inode, struct dentry *dentry,
-			   umode_t mode, dev_t dev)
-{
-	return 0;
-}
-
-static int cap_inode_rename(struct inode *old_inode, struct dentry *old_dentry,
-			    struct inode *new_inode, struct dentry *new_dentry)
-{
-	return 0;
-}
-
-static int cap_inode_readlink(struct dentry *dentry)
-{
-	return 0;
-}
-
-static int cap_inode_follow_link(struct dentry *dentry,
-				 struct nameidata *nameidata)
-{
-	return 0;
-}
-
-static int cap_inode_permission(struct inode *inode, int mask)
-{
-	return 0;
-}
-
-static int cap_inode_setattr(struct dentry *dentry, struct iattr *iattr)
-{
-	return 0;
-}
-
-static int cap_inode_getattr(struct vfsmount *mnt, struct dentry *dentry)
-{
-	return 0;
-}
-
-static void cap_inode_post_setxattr(struct dentry *dentry, const char *name,
-				    const void *value, size_t size, int flags)
-{
-}
-
-static int cap_inode_getxattr(struct dentry *dentry, const char *name)
-{
-	return 0;
-}
-
-static int cap_inode_listxattr(struct dentry *dentry)
-{
-	return 0;
-}
-
-static int cap_inode_getsecurity(const struct inode *inode, const char *name,
-				 void **buffer, bool alloc)
-{
-	return -EOPNOTSUPP;
-}
-
-static int cap_inode_setsecurity(struct inode *inode, const char *name,
-				 const void *value, size_t size, int flags)
-{
-	return -EOPNOTSUPP;
-}
-
-static int cap_inode_listsecurity(struct inode *inode, char *buffer,
-				  size_t buffer_size)
-{
-	return 0;
-}
-
-static void cap_inode_getsecid(const struct inode *inode, u32 *secid)
-{
-	*secid = 0;
-}
-
-#ifdef CONFIG_SECURITY_PATH
-static int cap_path_mknod(struct path *dir, struct dentry *dentry, umode_t mode,
-			  unsigned int dev)
-{
-	return 0;
-}
-
-static int cap_path_mkdir(struct path *dir, struct dentry *dentry, umode_t mode)
-{
-	return 0;
-}
-
-static int cap_path_rmdir(struct path *dir, struct dentry *dentry)
-{
-	return 0;
-}
-
-static int cap_path_unlink(struct path *dir, struct dentry *dentry)
-{
-	return 0;
-}
-
-static int cap_path_symlink(struct path *dir, struct dentry *dentry,
-			    const char *old_name)
-{
-	return 0;
-}
-
-static int cap_path_link(struct dentry *old_dentry, struct path *new_dir,
-			 struct dentry *new_dentry)
-{
-	return 0;
-}
-
-static int cap_path_rename(struct path *old_path, struct dentry *old_dentry,
-			   struct path *new_path, struct dentry *new_dentry)
-{
-	return 0;
-}
-
-static int cap_path_truncate(struct path *path)
-{
-	return 0;
-}
-
-static int cap_path_chmod(struct path *path, umode_t mode)
-{
-	return 0;
-}
-
-static int cap_path_chown(struct path *path, kuid_t uid, kgid_t gid)
-{
-	return 0;
-}
-
-static int cap_path_chroot(struct path *root)
-{
-	return 0;
-}
-#endif
-
-static int cap_file_permission(struct file *file, int mask)
-{
-	return 0;
-}
-
-static int cap_file_alloc_security(struct file *file)
-{
-	return 0;
-}
-
-static void cap_file_free_security(struct file *file)
-{
-}
-
-static int cap_file_ioctl(struct file *file, unsigned int command,
-			  unsigned long arg)
-{
-	return 0;
-}
-
-static int cap_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
-			     unsigned long prot)
-{
-	return 0;
-}
-
-static int cap_file_lock(struct file *file, unsigned int cmd)
-{
-	return 0;
-}
-
-static int cap_file_fcntl(struct file *file, unsigned int cmd,
-			  unsigned long arg)
-{
-	return 0;
-}
-
-static int cap_file_set_fowner(struct file *file)
-{
-	return 0;
-}
-
-static int cap_file_send_sigiotask(struct task_struct *tsk,
-				   struct fown_struct *fown, int sig)
-{
-	return 0;
-}
-
-static int cap_file_receive(struct file *file)
-{
-	return 0;
-}
-
-static int cap_file_open(struct file *file, const struct cred *cred)
-{
-	return 0;
-}
-
-static int cap_task_create(unsigned long clone_flags)
-{
-	return 0;
-}
-
-static void cap_task_free(struct task_struct *task)
-{
-}
-
-static int cap_cred_alloc_blank(struct cred *cred, gfp_t gfp)
-{
-	return 0;
-}
-
-static void cap_cred_free(struct cred *cred)
-{
-}
-
-static int cap_cred_prepare(struct cred *new, const struct cred *old, gfp_t gfp)
-{
-	return 0;
-}
-
-static void cap_cred_transfer(struct cred *new, const struct cred *old)
-{
-}
-
-static int cap_kernel_act_as(struct cred *new, u32 secid)
-{
-	return 0;
-}
-
-static int cap_kernel_create_files_as(struct cred *new, struct inode *inode)
-{
-	return 0;
-}
-
-static int cap_kernel_module_request(char *kmod_name)
-{
-	return 0;
-}
-
-static int cap_task_setpgid(struct task_struct *p, pid_t pgid)
-{
-	return 0;
-}
-
-static int cap_task_getpgid(struct task_struct *p)
-{
-	return 0;
-}
-
-static int cap_task_getsid(struct task_struct *p)
-{
-	return 0;
-}
-
-static void cap_task_getsecid(struct task_struct *p, u32 *secid)
-{
-	*secid = 0;
-}
-
-static int cap_task_getioprio(struct task_struct *p)
-{
-	return 0;
-}
-
-static int cap_task_setrlimit(struct task_struct *p, unsigned int resource,
-		struct rlimit *new_rlim)
-{
-	return 0;
-}
-
-static int cap_task_getscheduler(struct task_struct *p)
-{
-	return 0;
-}
-
-static int cap_task_movememory(struct task_struct *p)
-{
-	return 0;
-}
-
-static int cap_task_wait(struct task_struct *p)
-{
-	return 0;
-}
-
-static int cap_task_kill(struct task_struct *p, struct siginfo *info,
-			 int sig, u32 secid)
-{
-	return 0;
-}
-
-static void cap_task_to_inode(struct task_struct *p, struct inode *inode)
-{
-}
-
-static int cap_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
-{
-	return 0;
-}
-
-static void cap_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
-{
-	*secid = 0;
-}
-
-static int cap_msg_msg_alloc_security(struct msg_msg *msg)
-{
-	return 0;
-}
-
-static void cap_msg_msg_free_security(struct msg_msg *msg)
-{
-}
-
-static int cap_msg_queue_alloc_security(struct msg_queue *msq)
-{
-	return 0;
-}
-
-static void cap_msg_queue_free_security(struct msg_queue *msq)
-{
-}
-
-static int cap_msg_queue_associate(struct msg_queue *msq, int msqflg)
-{
-	return 0;
-}
-
-static int cap_msg_queue_msgctl(struct msg_queue *msq, int cmd)
-{
-	return 0;
-}
-
-static int cap_msg_queue_msgsnd(struct msg_queue *msq, struct msg_msg *msg,
-				int msgflg)
-{
-	return 0;
-}
-
-static int cap_msg_queue_msgrcv(struct msg_queue *msq, struct msg_msg *msg,
-				struct task_struct *target, long type, int mode)
-{
-	return 0;
-}
-
-static int cap_shm_alloc_security(struct shmid_kernel *shp)
-{
-	return 0;
-}
-
-static void cap_shm_free_security(struct shmid_kernel *shp)
-{
-}
-
-static int cap_shm_associate(struct shmid_kernel *shp, int shmflg)
-{
-	return 0;
-}
-
-static int cap_shm_shmctl(struct shmid_kernel *shp, int cmd)
-{
-	return 0;
-}
-
-static int cap_shm_shmat(struct shmid_kernel *shp, char __user *shmaddr,
-			 int shmflg)
-{
-	return 0;
-}
-
-static int cap_sem_alloc_security(struct sem_array *sma)
-{
-	return 0;
-}
-
-static void cap_sem_free_security(struct sem_array *sma)
-{
-}
-
-static int cap_sem_associate(struct sem_array *sma, int semflg)
-{
-	return 0;
-}
-
-static int cap_sem_semctl(struct sem_array *sma, int cmd)
-{
-	return 0;
-}
-
-static int cap_sem_semop(struct sem_array *sma, struct sembuf *sops,
-			 unsigned nsops, int alter)
-{
-	return 0;
-}
-
-#ifdef CONFIG_SECURITY_NETWORK
-static int cap_unix_stream_connect(struct sock *sock, struct sock *other,
-				   struct sock *newsk)
-{
-	return 0;
-}
-
-static int cap_unix_may_send(struct socket *sock, struct socket *other)
-{
-	return 0;
-}
-
-static int cap_socket_create(int family, int type, int protocol, int kern)
-{
-	return 0;
-}
-
-static int cap_socket_post_create(struct socket *sock, int family, int type,
-				  int protocol, int kern)
-{
-	return 0;
-}
-
-static int cap_socket_bind(struct socket *sock, struct sockaddr *address,
-			   int addrlen)
-{
-	return 0;
-}
-
-static int cap_socket_connect(struct socket *sock, struct sockaddr *address,
-			      int addrlen)
-{
-	return 0;
-}
-
-static int cap_socket_listen(struct socket *sock, int backlog)
-{
-	return 0;
-}
-
-static int cap_socket_accept(struct socket *sock, struct socket *newsock)
-{
-	return 0;
-}
-
-static int cap_socket_sendmsg(struct socket *sock, struct msghdr *msg, int size)
-{
-	return 0;
-}
-
-static int cap_socket_recvmsg(struct socket *sock, struct msghdr *msg,
-			      int size, int flags)
-{
-	return 0;
-}
-
-static int cap_socket_getsockname(struct socket *sock)
-{
-	return 0;
-}
-
-static int cap_socket_getpeername(struct socket *sock)
-{
-	return 0;
-}
-
-static int cap_socket_setsockopt(struct socket *sock, int level, int optname)
-{
-	return 0;
-}
-
-static int cap_socket_getsockopt(struct socket *sock, int level, int optname)
-{
-	return 0;
-}
-
-static int cap_socket_shutdown(struct socket *sock, int how)
-{
-	return 0;
-}
-
-static int cap_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
-{
-	return 0;
-}
-
-static int cap_socket_getpeersec_stream(struct socket *sock,
-					char __user *optval,
-					int __user *optlen, unsigned len)
-{
-	return -ENOPROTOOPT;
-}
-
-static int cap_socket_getpeersec_dgram(struct socket *sock,
-				       struct sk_buff *skb, u32 *secid)
-{
-	return -ENOPROTOOPT;
-}
-
-static int cap_sk_alloc_security(struct sock *sk, int family, gfp_t priority)
-{
-	return 0;
-}
-
-static void cap_sk_free_security(struct sock *sk)
-{
-}
-
-static void cap_sk_clone_security(const struct sock *sk, struct sock *newsk)
-{
-}
-
-static void cap_sk_getsecid(struct sock *sk, u32 *secid)
-{
-}
-
-static void cap_sock_graft(struct sock *sk, struct socket *parent)
-{
-}
-
-static int cap_inet_conn_request(struct sock *sk, struct sk_buff *skb,
-				 struct request_sock *req)
-{
-	return 0;
-}
-
-static void cap_inet_csk_clone(struct sock *newsk,
-			       const struct request_sock *req)
-{
-}
-
-static void cap_inet_conn_established(struct sock *sk, struct sk_buff *skb)
-{
-}
-
-static int cap_secmark_relabel_packet(u32 secid)
-{
-	return 0;
-}
-
-static void cap_secmark_refcount_inc(void)
-{
-}
-
-static void cap_secmark_refcount_dec(void)
-{
-}
-
-static void cap_req_classify_flow(const struct request_sock *req,
-				  struct flowi *fl)
-{
-}
-
-static int cap_tun_dev_create(void)
-{
-	return 0;
-}
-
-static void cap_tun_dev_post_create(struct sock *sk)
-{
-}
-
-static int cap_tun_dev_attach(struct sock *sk)
-{
-	return 0;
-}
-#endif	/* CONFIG_SECURITY_NETWORK */
-
-#ifdef CONFIG_SECURITY_NETWORK_XFRM
-static int cap_xfrm_policy_alloc_security(struct xfrm_sec_ctx **ctxp,
-					  struct xfrm_user_sec_ctx *sec_ctx)
-{
-	return 0;
-}
-
-static int cap_xfrm_policy_clone_security(struct xfrm_sec_ctx *old_ctx,
-					  struct xfrm_sec_ctx **new_ctxp)
-{
-	return 0;
-}
-
-static void cap_xfrm_policy_free_security(struct xfrm_sec_ctx *ctx)
-{
-}
-
-static int cap_xfrm_policy_delete_security(struct xfrm_sec_ctx *ctx)
-{
-	return 0;
-}
-
-static int cap_xfrm_state_alloc_security(struct xfrm_state *x,
-					 struct xfrm_user_sec_ctx *sec_ctx,
-					 u32 secid)
-{
-	return 0;
-}
-
-static void cap_xfrm_state_free_security(struct xfrm_state *x)
-{
-}
-
-static int cap_xfrm_state_delete_security(struct xfrm_state *x)
-{
-	return 0;
-}
-
-static int cap_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 sk_sid, u8 dir)
-{
-	return 0;
-}
-
-static int cap_xfrm_state_pol_flow_match(struct xfrm_state *x,
-					 struct xfrm_policy *xp,
-					 const struct flowi *fl)
-{
-	return 1;
-}
-
-static int cap_xfrm_decode_session(struct sk_buff *skb, u32 *fl, int ckall)
-{
-	return 0;
-}
-
-#endif /* CONFIG_SECURITY_NETWORK_XFRM */
-static void cap_d_instantiate(struct dentry *dentry, struct inode *inode)
-{
-}
-
-static int cap_getprocattr(struct task_struct *p, char *name, char **value)
-{
-	return -EINVAL;
-}
-
-static int cap_setprocattr(struct task_struct *p, char *name, void *value,
-			   size_t size)
-{
-	return -EINVAL;
-}
-
-static int cap_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
-{
-	return -EOPNOTSUPP;
-}
-
-static int cap_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
-{
-	*secid = 0;
-	return 0;
-}
-
-static void cap_release_secctx(char *secdata, u32 seclen)
-{
-}
-
-static int cap_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
-{
-	return 0;
-}
-
-static int cap_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
-{
-	return 0;
-}
-
-static int cap_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
-{
-	return 0;
-}
-#ifdef CONFIG_KEYS
-static int cap_key_alloc(struct key *key, const struct cred *cred,
-			 unsigned long flags)
-{
-	return 0;
-}
-
-static void cap_key_free(struct key *key)
-{
-}
-
-static int cap_key_permission(key_ref_t key_ref, const struct cred *cred,
-			      key_perm_t perm)
-{
-	return 0;
-}
-
-static int cap_key_getsecurity(struct key *key, char **_buffer)
-{
-	*_buffer = NULL;
-	return 0;
-}
-
-#endif /* CONFIG_KEYS */
-
-#ifdef CONFIG_AUDIT
-static int cap_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
-{
-	return 0;
-}
-
-static int cap_audit_rule_known(struct audit_krule *krule)
-{
-	return 0;
-}
-
-static int cap_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
-				struct audit_context *actx)
-{
-	return 0;
-}
-
-static void cap_audit_rule_free(void *lsmrule)
-{
-}
-#endif /* CONFIG_AUDIT */
-
-#define set_to_cap_if_null(ops, function)				\
-	do {								\
-		if (!ops->function) {					\
-			ops->function = cap_##function;			\
-			pr_debug("Had to override the " #function	\
-				 " security operation with the default.\n");\
-			}						\
-	} while (0)
-
-void __init security_fixup_ops(struct security_operations *ops)
-{
-	set_to_cap_if_null(ops, ptrace_access_check);
-	set_to_cap_if_null(ops, ptrace_traceme);
-	set_to_cap_if_null(ops, capget);
-	set_to_cap_if_null(ops, capset);
-	set_to_cap_if_null(ops, capable);
-	set_to_cap_if_null(ops, quotactl);
-	set_to_cap_if_null(ops, quota_on);
-	set_to_cap_if_null(ops, syslog);
-	set_to_cap_if_null(ops, settime);
-	set_to_cap_if_null(ops, vm_enough_memory);
-	set_to_cap_if_null(ops, bprm_set_creds);
-	set_to_cap_if_null(ops, bprm_committing_creds);
-	set_to_cap_if_null(ops, bprm_committed_creds);
-	set_to_cap_if_null(ops, bprm_check_security);
-	set_to_cap_if_null(ops, bprm_secureexec);
-	set_to_cap_if_null(ops, sb_alloc_security);
-	set_to_cap_if_null(ops, sb_free_security);
-	set_to_cap_if_null(ops, sb_copy_data);
-	set_to_cap_if_null(ops, sb_remount);
-	set_to_cap_if_null(ops, sb_kern_mount);
-	set_to_cap_if_null(ops, sb_show_options);
-	set_to_cap_if_null(ops, sb_statfs);
-	set_to_cap_if_null(ops, sb_mount);
-	set_to_cap_if_null(ops, sb_umount);
-	set_to_cap_if_null(ops, sb_pivotroot);
-	set_to_cap_if_null(ops, sb_set_mnt_opts);
-	set_to_cap_if_null(ops, sb_clone_mnt_opts);
-	set_to_cap_if_null(ops, sb_parse_opts_str);
-	set_to_cap_if_null(ops, inode_alloc_security);
-	set_to_cap_if_null(ops, inode_free_security);
-	set_to_cap_if_null(ops, inode_init_security);
-	set_to_cap_if_null(ops, inode_create);
-	set_to_cap_if_null(ops, inode_link);
-	set_to_cap_if_null(ops, inode_unlink);
-	set_to_cap_if_null(ops, inode_symlink);
-	set_to_cap_if_null(ops, inode_mkdir);
-	set_to_cap_if_null(ops, inode_rmdir);
-	set_to_cap_if_null(ops, inode_mknod);
-	set_to_cap_if_null(ops, inode_rename);
-	set_to_cap_if_null(ops, inode_readlink);
-	set_to_cap_if_null(ops, inode_follow_link);
-	set_to_cap_if_null(ops, inode_permission);
-	set_to_cap_if_null(ops, inode_setattr);
-	set_to_cap_if_null(ops, inode_getattr);
-	set_to_cap_if_null(ops, inode_setxattr);
-	set_to_cap_if_null(ops, inode_post_setxattr);
-	set_to_cap_if_null(ops, inode_getxattr);
-	set_to_cap_if_null(ops, inode_listxattr);
-	set_to_cap_if_null(ops, inode_removexattr);
-	set_to_cap_if_null(ops, inode_need_killpriv);
-	set_to_cap_if_null(ops, inode_killpriv);
-	set_to_cap_if_null(ops, inode_getsecurity);
-	set_to_cap_if_null(ops, inode_setsecurity);
-	set_to_cap_if_null(ops, inode_listsecurity);
-	set_to_cap_if_null(ops, inode_getsecid);
-#ifdef CONFIG_SECURITY_PATH
-	set_to_cap_if_null(ops, path_mknod);
-	set_to_cap_if_null(ops, path_mkdir);
-	set_to_cap_if_null(ops, path_rmdir);
-	set_to_cap_if_null(ops, path_unlink);
-	set_to_cap_if_null(ops, path_symlink);
-	set_to_cap_if_null(ops, path_link);
-	set_to_cap_if_null(ops, path_rename);
-	set_to_cap_if_null(ops, path_truncate);
-	set_to_cap_if_null(ops, path_chmod);
-	set_to_cap_if_null(ops, path_chown);
-	set_to_cap_if_null(ops, path_chroot);
-#endif
-	set_to_cap_if_null(ops, file_permission);
-	set_to_cap_if_null(ops, file_alloc_security);
-	set_to_cap_if_null(ops, file_free_security);
-	set_to_cap_if_null(ops, file_ioctl);
-	set_to_cap_if_null(ops, mmap_addr);
-	set_to_cap_if_null(ops, mmap_file);
-	set_to_cap_if_null(ops, file_mprotect);
-	set_to_cap_if_null(ops, file_lock);
-	set_to_cap_if_null(ops, file_fcntl);
-	set_to_cap_if_null(ops, file_set_fowner);
-	set_to_cap_if_null(ops, file_send_sigiotask);
-	set_to_cap_if_null(ops, file_receive);
-	set_to_cap_if_null(ops, file_open);
-	set_to_cap_if_null(ops, task_create);
-	set_to_cap_if_null(ops, task_free);
-	set_to_cap_if_null(ops, cred_alloc_blank);
-	set_to_cap_if_null(ops, cred_free);
-	set_to_cap_if_null(ops, cred_prepare);
-	set_to_cap_if_null(ops, cred_transfer);
-	set_to_cap_if_null(ops, kernel_act_as);
-	set_to_cap_if_null(ops, kernel_create_files_as);
-	set_to_cap_if_null(ops, kernel_module_request);
-	set_to_cap_if_null(ops, task_fix_setuid);
-	set_to_cap_if_null(ops, task_setpgid);
-	set_to_cap_if_null(ops, task_getpgid);
-	set_to_cap_if_null(ops, task_getsid);
-	set_to_cap_if_null(ops, task_getsecid);
-	set_to_cap_if_null(ops, task_setnice);
-	set_to_cap_if_null(ops, task_setioprio);
-	set_to_cap_if_null(ops, task_getioprio);
-	set_to_cap_if_null(ops, task_setrlimit);
-	set_to_cap_if_null(ops, task_setscheduler);
-	set_to_cap_if_null(ops, task_getscheduler);
-	set_to_cap_if_null(ops, task_movememory);
-	set_to_cap_if_null(ops, task_wait);
-	set_to_cap_if_null(ops, task_kill);
-	set_to_cap_if_null(ops, task_prctl);
-	set_to_cap_if_null(ops, task_to_inode);
-	set_to_cap_if_null(ops, ipc_permission);
-	set_to_cap_if_null(ops, ipc_getsecid);
-	set_to_cap_if_null(ops, msg_msg_alloc_security);
-	set_to_cap_if_null(ops, msg_msg_free_security);
-	set_to_cap_if_null(ops, msg_queue_alloc_security);
-	set_to_cap_if_null(ops, msg_queue_free_security);
-	set_to_cap_if_null(ops, msg_queue_associate);
-	set_to_cap_if_null(ops, msg_queue_msgctl);
-	set_to_cap_if_null(ops, msg_queue_msgsnd);
-	set_to_cap_if_null(ops, msg_queue_msgrcv);
-	set_to_cap_if_null(ops, shm_alloc_security);
-	set_to_cap_if_null(ops, shm_free_security);
-	set_to_cap_if_null(ops, shm_associate);
-	set_to_cap_if_null(ops, shm_shmctl);
-	set_to_cap_if_null(ops, shm_shmat);
-	set_to_cap_if_null(ops, sem_alloc_security);
-	set_to_cap_if_null(ops, sem_free_security);
-	set_to_cap_if_null(ops, sem_associate);
-	set_to_cap_if_null(ops, sem_semctl);
-	set_to_cap_if_null(ops, sem_semop);
-	set_to_cap_if_null(ops, netlink_send);
-	set_to_cap_if_null(ops, d_instantiate);
-	set_to_cap_if_null(ops, getprocattr);
-	set_to_cap_if_null(ops, setprocattr);
-	set_to_cap_if_null(ops, secid_to_secctx);
-	set_to_cap_if_null(ops, secctx_to_secid);
-	set_to_cap_if_null(ops, release_secctx);
-	set_to_cap_if_null(ops, inode_notifysecctx);
-	set_to_cap_if_null(ops, inode_setsecctx);
-	set_to_cap_if_null(ops, inode_getsecctx);
-#ifdef CONFIG_SECURITY_NETWORK
-	set_to_cap_if_null(ops, unix_stream_connect);
-	set_to_cap_if_null(ops, unix_may_send);
-	set_to_cap_if_null(ops, socket_create);
-	set_to_cap_if_null(ops, socket_post_create);
-	set_to_cap_if_null(ops, socket_bind);
-	set_to_cap_if_null(ops, socket_connect);
-	set_to_cap_if_null(ops, socket_listen);
-	set_to_cap_if_null(ops, socket_accept);
-	set_to_cap_if_null(ops, socket_sendmsg);
-	set_to_cap_if_null(ops, socket_recvmsg);
-	set_to_cap_if_null(ops, socket_getsockname);
-	set_to_cap_if_null(ops, socket_getpeername);
-	set_to_cap_if_null(ops, socket_setsockopt);
-	set_to_cap_if_null(ops, socket_getsockopt);
-	set_to_cap_if_null(ops, socket_shutdown);
-	set_to_cap_if_null(ops, socket_sock_rcv_skb);
-	set_to_cap_if_null(ops, socket_getpeersec_stream);
-	set_to_cap_if_null(ops, socket_getpeersec_dgram);
-	set_to_cap_if_null(ops, sk_alloc_security);
-	set_to_cap_if_null(ops, sk_free_security);
-	set_to_cap_if_null(ops, sk_clone_security);
-	set_to_cap_if_null(ops, sk_getsecid);
-	set_to_cap_if_null(ops, sock_graft);
-	set_to_cap_if_null(ops, inet_conn_request);
-	set_to_cap_if_null(ops, inet_csk_clone);
-	set_to_cap_if_null(ops, inet_conn_established);
-	set_to_cap_if_null(ops, secmark_relabel_packet);
-	set_to_cap_if_null(ops, secmark_refcount_inc);
-	set_to_cap_if_null(ops, secmark_refcount_dec);
-	set_to_cap_if_null(ops, req_classify_flow);
-	set_to_cap_if_null(ops, tun_dev_create);
-	set_to_cap_if_null(ops, tun_dev_post_create);
-	set_to_cap_if_null(ops, tun_dev_attach);
-#endif	/* CONFIG_SECURITY_NETWORK */
-#ifdef CONFIG_SECURITY_NETWORK_XFRM
-	set_to_cap_if_null(ops, xfrm_policy_alloc_security);
-	set_to_cap_if_null(ops, xfrm_policy_clone_security);
-	set_to_cap_if_null(ops, xfrm_policy_free_security);
-	set_to_cap_if_null(ops, xfrm_policy_delete_security);
-	set_to_cap_if_null(ops, xfrm_state_alloc_security);
-	set_to_cap_if_null(ops, xfrm_state_free_security);
-	set_to_cap_if_null(ops, xfrm_state_delete_security);
-	set_to_cap_if_null(ops, xfrm_policy_lookup);
-	set_to_cap_if_null(ops, xfrm_state_pol_flow_match);
-	set_to_cap_if_null(ops, xfrm_decode_session);
-#endif	/* CONFIG_SECURITY_NETWORK_XFRM */
-#ifdef CONFIG_KEYS
-	set_to_cap_if_null(ops, key_alloc);
-	set_to_cap_if_null(ops, key_free);
-	set_to_cap_if_null(ops, key_permission);
-	set_to_cap_if_null(ops, key_getsecurity);
-#endif	/* CONFIG_KEYS */
-#ifdef CONFIG_AUDIT
-	set_to_cap_if_null(ops, audit_rule_init);
-	set_to_cap_if_null(ops, audit_rule_known);
-	set_to_cap_if_null(ops, audit_rule_match);
-	set_to_cap_if_null(ops, audit_rule_free);
-#endif
-}
diff --git a/security/inode.c b/security/inode.c
index 43ce6e1..eac2f08 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -21,6 +21,9 @@
 #include <linux/namei.h>
 #include <linux/security.h>
 #include <linux/magic.h>
+#ifdef CONFIG_SECURITY
+#include <linux/lsm.h>
+#endif
 
 static struct vfsmount *mount;
 static int mount_count;
@@ -215,6 +218,39 @@ void securityfs_remove(struct dentry *dentry)
 }
 EXPORT_SYMBOL_GPL(securityfs_remove);
 
+#ifdef CONFIG_SECURITY
+static struct dentry *lsm_dentry;
+static ssize_t lsm_read(struct file *filp, char __user *buf, size_t count,
+			loff_t *ppos)
+{
+	struct security_operations *sop;
+	char *data;
+	int len;
+
+	data = kzalloc(COMPOSER_NAMES_MAX, GFP_KERNEL);
+	if (data == NULL)
+		return -ENOMEM;
+
+	list_for_each_entry(sop, &lsm_hooks[LSM_name], list[LSM_name]) {
+		strcat(data, sop->name);
+		strcat(data, ",");
+	}
+	len = strlen(data);
+	if (len > 1)
+		data[len-1] = '\n';
+
+	len = simple_read_from_buffer(buf, count, ppos, data, len);
+	kfree(data);
+
+	return len;
+}
+
+static const struct file_operations lsm_ops = {
+	.read = lsm_read,
+	.llseek = generic_file_llseek,
+};
+#endif /* CONFIG_SECURITY */
+
 static struct kobject *security_kobj;
 
 static int __init securityfs_init(void)
@@ -226,9 +262,15 @@ static int __init securityfs_init(void)
 		return -EINVAL;
 
 	retval = register_filesystem(&fs_type);
-	if (retval)
+	if (retval) {
 		kobject_put(security_kobj);
-	return retval;
+		return retval;
+	}
+#ifdef CONFIG_SECURITY
+	lsm_dentry = securityfs_create_file("lsm", S_IRUGO, NULL, NULL,
+		&lsm_ops);
+#endif /* CONFIG_SECURITY */
+	return 0;
 }
 
 core_initcall(securityfs_init);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 61a5336..dca1f69 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -150,6 +150,7 @@ static int selinux_secmark_enabled(void)
  */
 static void cred_init_security(void)
 {
+	int rc;
 	struct cred *cred = (struct cred *) current->real_cred;
 	struct task_security_struct *tsec;
 
@@ -158,7 +159,9 @@ static void cred_init_security(void)
 		panic("SELinux:  Failed to initialize initial task.\n");
 
 	tsec->osid = tsec->sid = SECINITSID_KERNEL;
-	cred->security = tsec;
+	rc = lsm_set_init_cred(cred, tsec, &selinux_ops);
+	if (rc)
+		panic("SELinux:  Failed to initialize initial task.\n");
 }
 
 /*
@@ -168,7 +171,7 @@ static inline u32 cred_sid(const struct cred *cred)
 {
 	const struct task_security_struct *tsec;
 
-	tsec = cred->security;
+	tsec = lsm_get_cred(cred, &selinux_ops);
 	return tsec->sid;
 }
 
@@ -190,8 +193,9 @@ static inline u32 task_sid(const struct task_struct *task)
  */
 static inline u32 current_sid(void)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec;
 
+	tsec = lsm_get_cred(current_cred(), &selinux_ops);
 	return tsec->sid;
 }
 
@@ -212,22 +216,23 @@ static int inode_alloc_security(struct inode *inode)
 	isec->sid = SECINITSID_UNLABELED;
 	isec->sclass = SECCLASS_FILE;
 	isec->task_sid = sid;
-	inode->i_security = isec;
+	lsm_set_inode(inode, isec, &selinux_ops);
 
 	return 0;
 }
 
 static void inode_free_security(struct inode *inode)
 {
-	struct inode_security_struct *isec = inode->i_security;
-	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
+	struct inode_security_struct *isec = lsm_get_inode(inode, &selinux_ops);
+	struct superblock_security_struct *sbsec =
+				lsm_get_super(inode->i_sb, &selinux_ops);
 
 	spin_lock(&sbsec->isec_lock);
 	if (!list_empty(&isec->list))
 		list_del_init(&isec->list);
 	spin_unlock(&sbsec->isec_lock);
 
-	inode->i_security = NULL;
+	lsm_set_inode(inode, NULL, &selinux_ops);
 	kmem_cache_free(sel_inode_cache, isec);
 }
 
@@ -242,15 +247,15 @@ static int file_alloc_security(struct file *file)
 
 	fsec->sid = sid;
 	fsec->fown_sid = sid;
-	file->f_security = fsec;
+	lsm_set_file(file, fsec, &selinux_ops);
 
 	return 0;
 }
 
 static void file_free_security(struct file *file)
 {
-	struct file_security_struct *fsec = file->f_security;
-	file->f_security = NULL;
+	struct file_security_struct *fsec = lsm_get_file(file, &selinux_ops);
+	lsm_set_file(file, NULL, &selinux_ops);
 	kfree(fsec);
 }
 
@@ -269,15 +274,16 @@ static int superblock_alloc_security(struct super_block *sb)
 	sbsec->sid = SECINITSID_UNLABELED;
 	sbsec->def_sid = SECINITSID_FILE;
 	sbsec->mntpoint_sid = SECINITSID_UNLABELED;
-	sb->s_security = sbsec;
+	lsm_set_super(sb, sbsec, &selinux_ops);
 
 	return 0;
 }
 
 static void superblock_free_security(struct super_block *sb)
 {
-	struct superblock_security_struct *sbsec = sb->s_security;
-	sb->s_security = NULL;
+	struct superblock_security_struct *sbsec =
+						lsm_get_super(sb, &selinux_ops);
+	lsm_set_super(sb, NULL, &selinux_ops);
 	kfree(sbsec);
 }
 
@@ -323,9 +329,10 @@ static int may_context_mount_sb_relabel(u32 sid,
 			struct superblock_security_struct *sbsec,
 			const struct cred *cred)
 {
-	const struct task_security_struct *tsec = cred->security;
+	const struct task_security_struct *tsec;
 	int rc;
 
+	tsec = lsm_get_cred(cred, &selinux_ops);
 	rc = avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELFROM, NULL);
 	if (rc)
@@ -340,8 +347,10 @@ static int may_context_mount_inode_relabel(u32 sid,
 			struct superblock_security_struct *sbsec,
 			const struct cred *cred)
 {
-	const struct task_security_struct *tsec = cred->security;
+	const struct task_security_struct *tsec;
 	int rc;
+
+	tsec = lsm_get_cred(cred, &selinux_ops);
 	rc = avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELFROM, NULL);
 	if (rc)
@@ -354,7 +363,8 @@ static int may_context_mount_inode_relabel(u32 sid,
 
 static int sb_finish_set_opts(struct super_block *sb)
 {
-	struct superblock_security_struct *sbsec = sb->s_security;
+	struct superblock_security_struct *sbsec =
+						lsm_get_super(sb, &selinux_ops);
 	struct dentry *root = sb->s_root;
 	struct inode *root_inode = root->d_inode;
 	int rc = 0;
@@ -444,7 +454,8 @@ static int selinux_get_mnt_opts(const struct super_block *sb,
 				struct security_mnt_opts *opts)
 {
 	int rc = 0, i;
-	struct superblock_security_struct *sbsec = sb->s_security;
+	struct superblock_security_struct *sbsec =
+						lsm_get_super(sb, &selinux_ops);
 	char *context = NULL;
 	u32 len;
 	char tmp;
@@ -504,8 +515,9 @@ static int selinux_get_mnt_opts(const struct super_block *sb,
 	}
 	if (sbsec->flags & ROOTCONTEXT_MNT) {
 		struct inode *root = sbsec->sb->s_root->d_inode;
-		struct inode_security_struct *isec = root->i_security;
+		struct inode_security_struct *isec;
 
+		isec = lsm_get_inode(root, &selinux_ops);
 		rc = security_sid_to_context(isec->sid, &context, &len);
 		if (rc)
 			goto out_free;
@@ -555,10 +567,12 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 {
 	const struct cred *cred = current_cred();
 	int rc = 0, i;
-	struct superblock_security_struct *sbsec = sb->s_security;
+	struct superblock_security_struct *sbsec =
+						lsm_get_super(sb, &selinux_ops);
 	const char *name = sb->s_type->name;
 	struct inode *inode = sbsec->sb->s_root->d_inode;
-	struct inode_security_struct *root_isec = inode->i_security;
+	struct inode_security_struct *root_isec =
+					lsm_get_inode(inode, &selinux_ops);
 	u32 fscontext_sid = 0, context_sid = 0, rootcontext_sid = 0;
 	u32 defcontext_sid = 0;
 	char **mount_options = opts->mnt_opts;
@@ -753,8 +767,10 @@ out_double_mount:
 static void selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
 					struct super_block *newsb)
 {
-	const struct superblock_security_struct *oldsbsec = oldsb->s_security;
-	struct superblock_security_struct *newsbsec = newsb->s_security;
+	const struct superblock_security_struct *oldsbsec =
+					lsm_get_super(oldsb, &selinux_ops);
+	struct superblock_security_struct *newsbsec =
+					lsm_get_super(newsb, &selinux_ops);
 
 	int set_fscontext =	(oldsbsec->flags & FSCONTEXT_MNT);
 	int set_context =	(oldsbsec->flags & CONTEXT_MNT);
@@ -789,16 +805,19 @@ static void selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
 			newsbsec->sid = sid;
 		if (!set_rootcontext) {
 			struct inode *newinode = newsb->s_root->d_inode;
-			struct inode_security_struct *newisec = newinode->i_security;
+			struct inode_security_struct *newisec =
+					lsm_get_inode(newinode, &selinux_ops);
 			newisec->sid = sid;
 		}
 		newsbsec->mntpoint_sid = sid;
 	}
 	if (set_rootcontext) {
 		const struct inode *oldinode = oldsb->s_root->d_inode;
-		const struct inode_security_struct *oldisec = oldinode->i_security;
+		const struct inode_security_struct *oldisec =
+					lsm_get_inode(oldinode, &selinux_ops);
 		struct inode *newinode = newsb->s_root->d_inode;
-		struct inode_security_struct *newisec = newinode->i_security;
+		struct inode_security_struct *newisec =
+					lsm_get_inode(newinode, &selinux_ops);
 
 		newisec->sid = oldisec->sid;
 	}
@@ -1162,7 +1181,7 @@ static int selinux_proc_get_sid(struct dentry *dentry,
 static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dentry)
 {
 	struct superblock_security_struct *sbsec = NULL;
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = lsm_get_inode(inode, &selinux_ops);
 	u32 sid;
 	struct dentry *dentry;
 #define INITCONTEXTLEN 255
@@ -1177,7 +1196,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 	if (isec->initialized)
 		goto out_unlock;
 
-	sbsec = inode->i_sb->s_security;
+	sbsec = lsm_get_super(inode->i_sb, &selinux_ops);
 	if (!(sbsec->flags & SE_SBINITIALIZED)) {
 		/* Defer initialization until selinux_complete_init,
 		   after the initial policy is loaded and the security
@@ -1389,8 +1408,10 @@ static int task_has_perm(const struct task_struct *tsk1,
 	u32 sid1, sid2;
 
 	rcu_read_lock();
-	__tsec1 = __task_cred(tsk1)->security;	sid1 = __tsec1->sid;
-	__tsec2 = __task_cred(tsk2)->security;	sid2 = __tsec2->sid;
+	__tsec1 = lsm_get_cred(__task_cred(tsk1), &selinux_ops);
+	sid1 = __tsec1->sid;
+	__tsec2 = lsm_get_cred(__task_cred(tsk2), &selinux_ops);
+	sid2 = __tsec2->sid;
 	rcu_read_unlock();
 	return avc_has_perm(sid1, sid2, SECCLASS_PROCESS, perms, NULL);
 }
@@ -1480,7 +1501,7 @@ static int inode_has_perm(const struct cred *cred,
 		return 0;
 
 	sid = cred_sid(cred);
-	isec = inode->i_security;
+	isec = lsm_get_inode(inode, &selinux_ops);
 
 	return avc_has_perm_flags(sid, isec->sid, isec->sclass, perms, adp, flags);
 }
@@ -1527,7 +1548,7 @@ static int file_has_perm(const struct cred *cred,
 			 struct file *file,
 			 u32 av)
 {
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = lsm_get_file(file, &selinux_ops);
 	struct inode *inode = file->f_path.dentry->d_inode;
 	struct common_audit_data ad;
 	u32 sid = cred_sid(cred);
@@ -1559,15 +1580,16 @@ static int may_create(struct inode *dir,
 		      struct dentry *dentry,
 		      u16 tclass)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec =
+				lsm_get_cred(current_cred(), &selinux_ops);
 	struct inode_security_struct *dsec;
 	struct superblock_security_struct *sbsec;
 	u32 sid, newsid;
 	struct common_audit_data ad;
 	int rc;
 
-	dsec = dir->i_security;
-	sbsec = dir->i_sb->s_security;
+	dsec = lsm_get_inode(dir, &selinux_ops);
+	sbsec = lsm_get_super(dir->i_sb, &selinux_ops);
 
 	sid = tsec->sid;
 	newsid = tsec->create_sid;
@@ -1622,8 +1644,8 @@ static int may_link(struct inode *dir,
 	u32 av;
 	int rc;
 
-	dsec = dir->i_security;
-	isec = dentry->d_inode->i_security;
+	dsec = lsm_get_inode(dir, &selinux_ops);
+	isec = lsm_get_inode(dentry->d_inode, &selinux_ops);
 
 	ad.type = LSM_AUDIT_DATA_DENTRY;
 	ad.u.dentry = dentry;
@@ -1666,10 +1688,10 @@ static inline int may_rename(struct inode *old_dir,
 	int old_is_dir, new_is_dir;
 	int rc;
 
-	old_dsec = old_dir->i_security;
-	old_isec = old_dentry->d_inode->i_security;
+	old_dsec = lsm_get_inode(old_dir, &selinux_ops);
+	old_isec = lsm_get_inode(old_dentry->d_inode, &selinux_ops);
 	old_is_dir = S_ISDIR(old_dentry->d_inode->i_mode);
-	new_dsec = new_dir->i_security;
+	new_dsec = lsm_get_inode(new_dir, &selinux_ops);
 
 	ad.type = LSM_AUDIT_DATA_DENTRY;
 
@@ -1697,7 +1719,7 @@ static inline int may_rename(struct inode *old_dir,
 	if (rc)
 		return rc;
 	if (new_dentry->d_inode) {
-		new_isec = new_dentry->d_inode->i_security;
+		new_isec = lsm_get_inode(new_dentry->d_inode, &selinux_ops);
 		new_is_dir = S_ISDIR(new_dentry->d_inode->i_mode);
 		rc = avc_has_perm(sid, new_isec->sid,
 				  new_isec->sclass,
@@ -1718,7 +1740,7 @@ static int superblock_has_perm(const struct cred *cred,
 	struct superblock_security_struct *sbsec;
 	u32 sid = cred_sid(cred);
 
-	sbsec = sb->s_security;
+	sbsec = lsm_get_super(sb, &selinux_ops);
 	return avc_has_perm(sid, sbsec->sid, SECCLASS_FILESYSTEM, perms, ad);
 }
 
@@ -1969,9 +1991,9 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
 	if (bprm->cred_prepared)
 		return 0;
 
-	old_tsec = current_security();
-	new_tsec = bprm->cred->security;
-	isec = inode->i_security;
+	old_tsec = lsm_get_cred(current_cred(), &selinux_ops);
+	new_tsec = lsm_get_cred(bprm->cred, &selinux_ops);
+	isec = lsm_get_inode(inode, &selinux_ops);
 
 	/* Default to the current task SID. */
 	new_tsec->sid = old_tsec->sid;
@@ -2046,7 +2068,8 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
 			rcu_read_lock();
 			tracer = ptrace_parent(current);
 			if (likely(tracer != NULL)) {
-				sec = __task_cred(tracer)->security;
+				sec = lsm_get_cred(__task_cred(tracer),
+						   &selinux_ops);
 				ptsid = sec->sid;
 			}
 			rcu_read_unlock();
@@ -2069,7 +2092,8 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
 
 static int selinux_bprm_secureexec(struct linux_binprm *bprm)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec =
+				lsm_get_cred(current_cred(), &selinux_ops);
 	u32 sid, osid;
 	int atsecure = 0;
 
@@ -2151,7 +2175,7 @@ static void selinux_bprm_committing_creds(struct linux_binprm *bprm)
 	struct rlimit *rlim, *initrlim;
 	int rc, i;
 
-	new_tsec = bprm->cred->security;
+	new_tsec = lsm_get_cred(bprm->cred, &selinux_ops);
 	if (new_tsec->sid == new_tsec->osid)
 		return;
 
@@ -2192,7 +2216,8 @@ static void selinux_bprm_committing_creds(struct linux_binprm *bprm)
  */
 static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec =
+				lsm_get_cred(current_cred(), &selinux_ops);
 	struct itimerval itimer;
 	u32 osid, sid;
 	int rc, i;
@@ -2339,7 +2364,8 @@ static int selinux_sb_remount(struct super_block *sb, void *data)
 	int rc, i, *flags;
 	struct security_mnt_opts opts;
 	char *secdata, **mount_options;
-	struct superblock_security_struct *sbsec = sb->s_security;
+	struct superblock_security_struct *sbsec =
+						lsm_get_super(sb, &selinux_ops);
 
 	if (!(sbsec->flags & SE_SBINITIALIZED))
 		return 0;
@@ -2391,7 +2417,8 @@ static int selinux_sb_remount(struct super_block *sb, void *data)
 			break;
 		case ROOTCONTEXT_MNT: {
 			struct inode_security_struct *root_isec;
-			root_isec = sb->s_root->d_inode->i_security;
+			root_isec = lsm_get_inode(sb->s_root->d_inode,
+								&selinux_ops);
 
 			if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid, sid))
 				goto out_bad_option;
@@ -2487,15 +2514,16 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 				       const struct qstr *qstr, char **name,
 				       void **value, size_t *len)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec =
+				lsm_get_cred(current_cred(), &selinux_ops);
 	struct inode_security_struct *dsec;
 	struct superblock_security_struct *sbsec;
 	u32 sid, newsid, clen;
 	int rc;
 	char *namep = NULL, *context;
 
-	dsec = dir->i_security;
-	sbsec = dir->i_sb->s_security;
+	dsec = lsm_get_inode(dir, &selinux_ops);
+	sbsec = lsm_get_super(dir->i_sb, &selinux_ops);
 
 	sid = tsec->sid;
 	newsid = tsec->create_sid;
@@ -2519,7 +2547,8 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 
 	/* Possibly defer initialization to selinux_complete_init. */
 	if (sbsec->flags & SE_SBINITIALIZED) {
-		struct inode_security_struct *isec = inode->i_security;
+		struct inode_security_struct *isec =
+					lsm_get_inode(inode, &selinux_ops);
 		isec->sclass = inode_mode_to_security_class(inode->i_mode);
 		isec->sid = newsid;
 		isec->initialized = 1;
@@ -2608,7 +2637,7 @@ static noinline int audit_inode_permission(struct inode *inode,
 					   unsigned flags)
 {
 	struct common_audit_data ad;
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = lsm_get_inode(inode, &selinux_ops);
 	int rc;
 
 	ad.type = LSM_AUDIT_DATA_INODE;
@@ -2648,7 +2677,7 @@ static int selinux_inode_permission(struct inode *inode, int mask)
 	perms = file_mask_to_av(inode->i_mode, mask);
 
 	sid = cred_sid(cred);
-	isec = inode->i_security;
+	isec = lsm_get_inode(inode, &selinux_ops);
 
 	rc = avc_has_perm_noaudit(sid, isec->sid, isec->sclass, perms, 0, &avd);
 	audited = avc_audit_required(perms, &avd, rc,
@@ -2723,7 +2752,7 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
 				  const void *value, size_t size, int flags)
 {
 	struct inode *inode = dentry->d_inode;
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = lsm_get_inode(inode, &selinux_ops);
 	struct superblock_security_struct *sbsec;
 	struct common_audit_data ad;
 	u32 newsid, sid = current_sid();
@@ -2732,7 +2761,7 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
 	if (strcmp(name, XATTR_NAME_SELINUX))
 		return selinux_inode_setotherxattr(dentry, name);
 
-	sbsec = inode->i_sb->s_security;
+	sbsec = lsm_get_super(inode->i_sb, &selinux_ops);
 	if (!(sbsec->flags & SE_SBLABELSUPP))
 		return -EOPNOTSUPP;
 
@@ -2800,7 +2829,7 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
 					int flags)
 {
 	struct inode *inode = dentry->d_inode;
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = lsm_get_inode(inode, &selinux_ops);
 	u32 newsid;
 	int rc;
 
@@ -2855,7 +2884,7 @@ static int selinux_inode_getsecurity(const struct inode *inode, const char *name
 	u32 size;
 	int error;
 	char *context = NULL;
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = lsm_get_inode(inode, &selinux_ops);
 
 	if (strcmp(name, XATTR_SELINUX_SUFFIX))
 		return -EOPNOTSUPP;
@@ -2891,7 +2920,7 @@ out_nofree:
 static int selinux_inode_setsecurity(struct inode *inode, const char *name,
 				     const void *value, size_t size, int flags)
 {
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = lsm_get_inode(inode, &selinux_ops);
 	u32 newsid;
 	int rc;
 
@@ -2920,7 +2949,7 @@ static int selinux_inode_listsecurity(struct inode *inode, char *buffer, size_t
 
 static void selinux_inode_getsecid(const struct inode *inode, u32 *secid)
 {
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = lsm_get_inode(inode, &selinux_ops);
 	*secid = isec->sid;
 }
 
@@ -2942,8 +2971,8 @@ static int selinux_revalidate_file_permission(struct file *file, int mask)
 static int selinux_file_permission(struct file *file, int mask)
 {
 	struct inode *inode = file->f_path.dentry->d_inode;
-	struct file_security_struct *fsec = file->f_security;
-	struct inode_security_struct *isec = inode->i_security;
+	struct file_security_struct *fsec = lsm_get_file(file, &selinux_ops);
+	struct inode_security_struct *isec = lsm_get_inode(inode, &selinux_ops);
 	u32 sid = current_sid();
 
 	if (!mask)
@@ -3177,7 +3206,7 @@ static int selinux_file_set_fowner(struct file *file)
 {
 	struct file_security_struct *fsec;
 
-	fsec = file->f_security;
+	fsec = lsm_get_file(file, &selinux_ops);
 	fsec->fown_sid = current_sid();
 
 	return 0;
@@ -3194,7 +3223,7 @@ static int selinux_file_send_sigiotask(struct task_struct *tsk,
 	/* struct fown_struct is never outside the context of a struct file */
 	file = container_of(fown, struct file, f_owner);
 
-	fsec = file->f_security;
+	fsec = lsm_get_file(file, &selinux_ops);
 
 	if (!signum)
 		perm = signal_to_av(SIGIO); /* as per send_sigio_to_task */
@@ -3217,8 +3246,8 @@ static int selinux_file_open(struct file *file, const struct cred *cred)
 	struct file_security_struct *fsec;
 	struct inode_security_struct *isec;
 
-	fsec = file->f_security;
-	isec = file->f_path.dentry->d_inode->i_security;
+	fsec = lsm_get_file(file, &selinux_ops);
+	isec = lsm_get_inode(file->f_path.dentry->d_inode, &selinux_ops);
 	/*
 	 * Save inode label and policy sequence number
 	 * at open-time so that selinux_file_permission
@@ -3257,7 +3286,7 @@ static int selinux_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 	if (!tsec)
 		return -ENOMEM;
 
-	cred->security = tsec;
+	lsm_set_cred(cred, tsec, &selinux_ops);
 	return 0;
 }
 
@@ -3266,14 +3295,14 @@ static int selinux_cred_alloc_blank(struct cred *cred, gfp_t gfp)
  */
 static void selinux_cred_free(struct cred *cred)
 {
-	struct task_security_struct *tsec = cred->security;
+	struct task_security_struct *tsec = lsm_get_cred(cred, &selinux_ops);
 
 	/*
 	 * cred->security == NULL if security_cred_alloc_blank() or
 	 * security_prepare_creds() returned an error.
 	 */
-	BUG_ON(cred->security && (unsigned long) cred->security < PAGE_SIZE);
-	cred->security = (void *) 0x7UL;
+	BUG_ON(tsec && (unsigned long) tsec < PAGE_SIZE);
+	lsm_set_cred(cred, NULL, &selinux_ops);
 	kfree(tsec);
 }
 
@@ -3286,13 +3315,13 @@ static int selinux_cred_prepare(struct cred *new, const struct cred *old,
 	const struct task_security_struct *old_tsec;
 	struct task_security_struct *tsec;
 
-	old_tsec = old->security;
+	old_tsec = lsm_get_cred(old, &selinux_ops);
 
 	tsec = kmemdup(old_tsec, sizeof(struct task_security_struct), gfp);
 	if (!tsec)
 		return -ENOMEM;
 
-	new->security = tsec;
+	lsm_set_cred(new, tsec, &selinux_ops);
 	return 0;
 }
 
@@ -3301,9 +3330,15 @@ static int selinux_cred_prepare(struct cred *new, const struct cred *old,
  */
 static void selinux_cred_transfer(struct cred *new, const struct cred *old)
 {
-	const struct task_security_struct *old_tsec = old->security;
-	struct task_security_struct *tsec = new->security;
+	const struct task_security_struct *old_tsec;
+	struct task_security_struct *tsec;
+
+	old_tsec = lsm_get_cred(old, &selinux_ops);
+	tsec = lsm_get_cred(new, &selinux_ops);
 
+	/*
+	 * This is a data copy, not a pointer assignment.
+	 */
 	*tsec = *old_tsec;
 }
 
@@ -3313,7 +3348,7 @@ static void selinux_cred_transfer(struct cred *new, const struct cred *old)
  */
 static int selinux_kernel_act_as(struct cred *new, u32 secid)
 {
-	struct task_security_struct *tsec = new->security;
+	struct task_security_struct *tsec = lsm_get_cred(new, &selinux_ops);
 	u32 sid = current_sid();
 	int ret;
 
@@ -3336,8 +3371,8 @@ static int selinux_kernel_act_as(struct cred *new, u32 secid)
  */
 static int selinux_kernel_create_files_as(struct cred *new, struct inode *inode)
 {
-	struct inode_security_struct *isec = inode->i_security;
-	struct task_security_struct *tsec = new->security;
+	struct inode_security_struct *isec = lsm_get_inode(inode, &selinux_ops);
+	struct task_security_struct *tsec = lsm_get_cred(new, &selinux_ops);
 	u32 sid = current_sid();
 	int ret;
 
@@ -3474,7 +3509,7 @@ static int selinux_task_wait(struct task_struct *p)
 static void selinux_task_to_inode(struct task_struct *p,
 				  struct inode *inode)
 {
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = lsm_get_inode(inode, &selinux_ops);
 	u32 sid = task_sid(p);
 
 	isec->sid = sid;
@@ -3729,7 +3764,7 @@ static int socket_sockcreate_sid(const struct task_security_struct *tsec,
 
 static int sock_has_perm(struct task_struct *task, struct sock *sk, u32 perms)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = lsm_get_sock(sk, &selinux_ops);
 	struct common_audit_data ad;
 	struct lsm_network_audit net = {0,};
 	u32 tsid = task_sid(task);
@@ -3747,7 +3782,8 @@ static int sock_has_perm(struct task_struct *task, struct sock *sk, u32 perms)
 static int selinux_socket_create(int family, int type,
 				 int protocol, int kern)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec =
+				lsm_get_cred(current_cred(), &selinux_ops);
 	u32 newsid;
 	u16 secclass;
 	int rc;
@@ -3766,8 +3802,10 @@ static int selinux_socket_create(int family, int type,
 static int selinux_socket_post_create(struct socket *sock, int family,
 				      int type, int protocol, int kern)
 {
-	const struct task_security_struct *tsec = current_security();
-	struct inode_security_struct *isec = SOCK_INODE(sock)->i_security;
+	const struct task_security_struct *tsec =
+				lsm_get_cred(current_cred(), &selinux_ops);
+	struct inode_security_struct *isec =
+				lsm_get_inode(SOCK_INODE(sock), &selinux_ops);
 	struct sk_security_struct *sksec;
 	int err = 0;
 
@@ -3784,7 +3822,7 @@ static int selinux_socket_post_create(struct socket *sock, int family,
 	isec->initialized = 1;
 
 	if (sock->sk) {
-		sksec = sock->sk->sk_security;
+		sksec = lsm_get_sock(sock->sk, &selinux_ops);
 		sksec->sid = isec->sid;
 		sksec->sclass = isec->sclass;
 		err = selinux_netlbl_socket_post_create(sock->sk, family);
@@ -3815,7 +3853,8 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 	family = sk->sk_family;
 	if (family == PF_INET || family == PF_INET6) {
 		char *addrp;
-		struct sk_security_struct *sksec = sk->sk_security;
+		struct sk_security_struct *sksec =
+					lsm_get_sock(sk, &selinux_ops);
 		struct common_audit_data ad;
 		struct lsm_network_audit net = {0,};
 		struct sockaddr_in *addr4 = NULL;
@@ -3899,7 +3938,7 @@ out:
 static int selinux_socket_connect(struct socket *sock, struct sockaddr *address, int addrlen)
 {
 	struct sock *sk = sock->sk;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = lsm_get_sock(sk, &selinux_ops);
 	int err;
 
 	err = sock_has_perm(current, sk, SOCKET__CONNECT);
@@ -3967,9 +4006,9 @@ static int selinux_socket_accept(struct socket *sock, struct socket *newsock)
 	if (err)
 		return err;
 
-	newisec = SOCK_INODE(newsock)->i_security;
+	newisec = lsm_get_inode(SOCK_INODE(newsock), &selinux_ops);
 
-	isec = SOCK_INODE(sock)->i_security;
+	isec = lsm_get_inode(SOCK_INODE(sock), &selinux_ops);
 	newisec->sclass = isec->sclass;
 	newisec->sid = isec->sid;
 	newisec->initialized = 1;
@@ -4025,9 +4064,12 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 					      struct sock *other,
 					      struct sock *newsk)
 {
-	struct sk_security_struct *sksec_sock = sock->sk_security;
-	struct sk_security_struct *sksec_other = other->sk_security;
-	struct sk_security_struct *sksec_new = newsk->sk_security;
+	struct sk_security_struct *sksec_sock =
+					lsm_get_sock(sock, &selinux_ops);
+	struct sk_security_struct *sksec_other =
+					lsm_get_sock(other, &selinux_ops);
+	struct sk_security_struct *sksec_new =
+					lsm_get_sock(newsk, &selinux_ops);
 	struct common_audit_data ad;
 	struct lsm_network_audit net = {0,};
 	int err;
@@ -4058,8 +4100,8 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 static int selinux_socket_unix_may_send(struct socket *sock,
 					struct socket *other)
 {
-	struct sk_security_struct *ssec = sock->sk->sk_security;
-	struct sk_security_struct *osec = other->sk->sk_security;
+	struct sk_security_struct *ssec = lsm_get_sock(sock->sk, &selinux_ops);
+	struct sk_security_struct *osec = lsm_get_sock(other->sk, &selinux_ops);
 	struct common_audit_data ad;
 	struct lsm_network_audit net = {0,};
 
@@ -4098,7 +4140,7 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 				       u16 family)
 {
 	int err = 0;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = lsm_get_sock(sk, &selinux_ops);
 	u32 sk_sid = sksec->sid;
 	struct common_audit_data ad;
 	struct lsm_network_audit net = {0,};
@@ -4130,7 +4172,7 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
 	int err;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = lsm_get_sock(sk, &selinux_ops);
 	u16 family = sk->sk_family;
 	u32 sk_sid = sksec->sid;
 	struct common_audit_data ad;
@@ -4200,7 +4242,7 @@ static int selinux_socket_getpeersec_stream(struct socket *sock, char __user *op
 	int err = 0;
 	char *scontext;
 	u32 scontext_len;
-	struct sk_security_struct *sksec = sock->sk->sk_security;
+	struct sk_security_struct *sksec = lsm_get_sock(sock->sk, &selinux_ops);
 	u32 peer_sid = SECSID_NULL;
 
 	if (sksec->sclass == SECCLASS_UNIX_STREAM_SOCKET ||
@@ -4265,24 +4307,24 @@ static int selinux_sk_alloc_security(struct sock *sk, int family, gfp_t priority
 	sksec->peer_sid = SECINITSID_UNLABELED;
 	sksec->sid = SECINITSID_UNLABELED;
 	selinux_netlbl_sk_security_reset(sksec);
-	sk->sk_security = sksec;
+	lsm_set_sock(sk, sksec, &selinux_ops);
 
 	return 0;
 }
 
 static void selinux_sk_free_security(struct sock *sk)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = lsm_get_sock(sk, &selinux_ops);
 
-	sk->sk_security = NULL;
+	lsm_set_sock(sk, NULL, &selinux_ops);
 	selinux_netlbl_sk_security_free(sksec);
 	kfree(sksec);
 }
 
 static void selinux_sk_clone_security(const struct sock *sk, struct sock *newsk)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
-	struct sk_security_struct *newsksec = newsk->sk_security;
+	struct sk_security_struct *sksec = lsm_get_sock(sk, &selinux_ops);
+	struct sk_security_struct *newsksec = lsm_get_sock(newsk, &selinux_ops);
 
 	newsksec->sid = sksec->sid;
 	newsksec->peer_sid = sksec->peer_sid;
@@ -4296,7 +4338,8 @@ static void selinux_sk_getsecid(struct sock *sk, u32 *secid)
 	if (!sk)
 		*secid = SECINITSID_ANY_SOCKET;
 	else {
-		struct sk_security_struct *sksec = sk->sk_security;
+		struct sk_security_struct *sksec =
+					lsm_get_sock(sk, &selinux_ops);
 
 		*secid = sksec->sid;
 	}
@@ -4304,8 +4347,9 @@ static void selinux_sk_getsecid(struct sock *sk, u32 *secid)
 
 static void selinux_sock_graft(struct sock *sk, struct socket *parent)
 {
-	struct inode_security_struct *isec = SOCK_INODE(parent)->i_security;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct inode_security_struct *isec =
+			lsm_get_inode(SOCK_INODE(parent), &selinux_ops);
+	struct sk_security_struct *sksec = lsm_get_sock(sk, &selinux_ops);
 
 	if (sk->sk_family == PF_INET || sk->sk_family == PF_INET6 ||
 	    sk->sk_family == PF_UNIX)
@@ -4316,7 +4360,7 @@ static void selinux_sock_graft(struct sock *sk, struct socket *parent)
 static int selinux_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 				     struct request_sock *req)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = lsm_get_sock(sk, &selinux_ops);
 	int err;
 	u16 family = sk->sk_family;
 	u32 newsid;
@@ -4346,7 +4390,7 @@ static int selinux_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 static void selinux_inet_csk_clone(struct sock *newsk,
 				   const struct request_sock *req)
 {
-	struct sk_security_struct *newsksec = newsk->sk_security;
+	struct sk_security_struct *newsksec = lsm_get_sock(newsk, &selinux_ops);
 
 	newsksec->sid = req->secid;
 	newsksec->peer_sid = req->peer_secid;
@@ -4363,7 +4407,7 @@ static void selinux_inet_csk_clone(struct sock *newsk,
 static void selinux_inet_conn_established(struct sock *sk, struct sk_buff *skb)
 {
 	u16 family = sk->sk_family;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = lsm_get_sock(sk, &selinux_ops);
 
 	/* handle mapped IPv4 packets arriving via IPv6 sockets */
 	if (family == PF_INET6 && skb->protocol == htons(ETH_P_IP))
@@ -4377,7 +4421,7 @@ static int selinux_secmark_relabel_packet(u32 sid)
 	const struct task_security_struct *__tsec;
 	u32 tsid;
 
-	__tsec = current_security();
+	__tsec = lsm_get_cred(current_cred(), &selinux_ops);
 	tsid = __tsec->sid;
 
 	return avc_has_perm(tsid, sid, SECCLASS_PACKET, PACKET__RELABELTO, NULL);
@@ -4416,7 +4460,7 @@ static int selinux_tun_dev_create(void)
 
 static void selinux_tun_dev_post_create(struct sock *sk)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = lsm_get_sock(sk, &selinux_ops);
 
 	/* we don't currently perform any NetLabel based labeling here and it
 	 * isn't clear that we would want to do so anyway; while we could apply
@@ -4434,7 +4478,7 @@ static void selinux_tun_dev_post_create(struct sock *sk)
 
 static int selinux_tun_dev_attach(struct sock *sk)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = lsm_get_sock(sk, &selinux_ops);
 	u32 sid = current_sid();
 	int err;
 
@@ -4457,7 +4501,7 @@ static int selinux_nlmsg_perm(struct sock *sk, struct sk_buff *skb)
 	int err = 0;
 	u32 perm;
 	struct nlmsghdr *nlh;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = lsm_get_sock(sk, &selinux_ops);
 
 	if (skb->len < NLMSG_SPACE(0)) {
 		err = -EINVAL;
@@ -4577,7 +4621,8 @@ static unsigned int selinux_ip_output(struct sk_buff *skb,
 	 * because we want to make sure we apply the necessary labeling
 	 * before IPsec is applied so we can leverage AH protection */
 	if (skb->sk) {
-		struct sk_security_struct *sksec = skb->sk->sk_security;
+		struct sk_security_struct *sksec =
+					lsm_get_sock(skb->sk, &selinux_ops);
 		sid = sksec->sid;
 	} else
 		sid = SECINITSID_KERNEL;
@@ -4609,7 +4654,7 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 
 	if (sk == NULL)
 		return NF_ACCEPT;
-	sksec = sk->sk_security;
+	sksec = lsm_get_sock(sk, &selinux_ops);
 
 	ad.type = LSM_AUDIT_DATA_NET;
 	ad.u.net = &net;
@@ -4677,7 +4722,8 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb, int ifindex,
 			peer_sid = SECINITSID_KERNEL;
 		}
 	} else {
-		struct sk_security_struct *sksec = sk->sk_security;
+		struct sk_security_struct *sksec =
+					lsm_get_sock(sk, &selinux_ops);
 		peer_sid = sksec->sid;
 		secmark_perm = PACKET__SEND;
 	}
@@ -4761,15 +4807,15 @@ static int ipc_alloc_security(struct task_struct *task,
 	sid = task_sid(task);
 	isec->sclass = sclass;
 	isec->sid = sid;
-	perm->security = isec;
+	lsm_set_ipc(perm, isec, &selinux_ops);
 
 	return 0;
 }
 
 static void ipc_free_security(struct kern_ipc_perm *perm)
 {
-	struct ipc_security_struct *isec = perm->security;
-	perm->security = NULL;
+	struct ipc_security_struct *isec = lsm_get_ipc(perm, &selinux_ops);
+	lsm_set_ipc(perm, NULL, &selinux_ops);
 	kfree(isec);
 }
 
@@ -4782,16 +4828,16 @@ static int msg_msg_alloc_security(struct msg_msg *msg)
 		return -ENOMEM;
 
 	msec->sid = SECINITSID_UNLABELED;
-	msg->security = msec;
+	lsm_set_msg(msg, msec, &selinux_ops);
 
 	return 0;
 }
 
 static void msg_msg_free_security(struct msg_msg *msg)
 {
-	struct msg_security_struct *msec = msg->security;
+	struct msg_security_struct *msec = lsm_get_msg(msg, &selinux_ops);
 
-	msg->security = NULL;
+	lsm_set_msg(msg, NULL, &selinux_ops);
 	kfree(msec);
 }
 
@@ -4802,7 +4848,7 @@ static int ipc_has_perm(struct kern_ipc_perm *ipc_perms,
 	struct common_audit_data ad;
 	u32 sid = current_sid();
 
-	isec = ipc_perms->security;
+	isec = lsm_get_ipc(ipc_perms, &selinux_ops);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = ipc_perms->key;
@@ -4832,7 +4878,7 @@ static int selinux_msg_queue_alloc_security(struct msg_queue *msq)
 	if (rc)
 		return rc;
 
-	isec = msq->q_perm.security;
+	isec = lsm_get_ipc(&msq->q_perm, &selinux_ops);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->q_perm.key;
@@ -4857,7 +4903,7 @@ static int selinux_msg_queue_associate(struct msg_queue *msq, int msqflg)
 	struct common_audit_data ad;
 	u32 sid = current_sid();
 
-	isec = msq->q_perm.security;
+	isec = lsm_get_ipc(&msq->q_perm, &selinux_ops);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->q_perm.key;
@@ -4902,8 +4948,8 @@ static int selinux_msg_queue_msgsnd(struct msg_queue *msq, struct msg_msg *msg,
 	u32 sid = current_sid();
 	int rc;
 
-	isec = msq->q_perm.security;
-	msec = msg->security;
+	isec = lsm_get_ipc(&msq->q_perm, &selinux_ops);
+	msec = lsm_get_msg(msg, &selinux_ops);
 
 	/*
 	 * First time through, need to assign label to the message
@@ -4947,8 +4993,8 @@ static int selinux_msg_queue_msgrcv(struct msg_queue *msq, struct msg_msg *msg,
 	u32 sid = task_sid(target);
 	int rc;
 
-	isec = msq->q_perm.security;
-	msec = msg->security;
+	isec = lsm_get_ipc(&msq->q_perm, &selinux_ops);
+	msec = lsm_get_msg(msg, &selinux_ops);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->q_perm.key;
@@ -4973,7 +5019,7 @@ static int selinux_shm_alloc_security(struct shmid_kernel *shp)
 	if (rc)
 		return rc;
 
-	isec = shp->shm_perm.security;
+	isec = lsm_get_ipc(&shp->shm_perm, &selinux_ops);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = shp->shm_perm.key;
@@ -4998,7 +5044,7 @@ static int selinux_shm_associate(struct shmid_kernel *shp, int shmflg)
 	struct common_audit_data ad;
 	u32 sid = current_sid();
 
-	isec = shp->shm_perm.security;
+	isec = lsm_get_ipc(&shp->shm_perm, &selinux_ops);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = shp->shm_perm.key;
@@ -5065,7 +5111,7 @@ static int selinux_sem_alloc_security(struct sem_array *sma)
 	if (rc)
 		return rc;
 
-	isec = sma->sem_perm.security;
+	isec = lsm_get_ipc(&sma->sem_perm, &selinux_ops);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = sma->sem_perm.key;
@@ -5090,7 +5136,7 @@ static int selinux_sem_associate(struct sem_array *sma, int semflg)
 	struct common_audit_data ad;
 	u32 sid = current_sid();
 
-	isec = sma->sem_perm.security;
+	isec = lsm_get_ipc(&sma->sem_perm, &selinux_ops);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = sma->sem_perm.key;
@@ -5172,7 +5218,7 @@ static int selinux_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 
 static void selinux_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
 {
-	struct ipc_security_struct *isec = ipcp->security;
+	struct ipc_security_struct *isec = lsm_get_ipc(ipcp, &selinux_ops);
 	*secid = isec->sid;
 }
 
@@ -5197,7 +5243,7 @@ static int selinux_getprocattr(struct task_struct *p,
 	}
 
 	rcu_read_lock();
-	__tsec = __task_cred(p)->security;
+	__tsec = lsm_get_cred(__task_cred(p), &selinux_ops);
 
 	if (!strcmp(name, "current"))
 		sid = __tsec->sid;
@@ -5306,7 +5352,7 @@ static int selinux_setprocattr(struct task_struct *p,
 	   operation.  See selinux_bprm_set_creds for the execve
 	   checks and may_create for the file creation checks. The
 	   operation will then fail if the context is not permitted. */
-	tsec = new->security;
+	tsec = lsm_get_cred(new, &selinux_ops);
 	if (!strcmp(name, "exec")) {
 		tsec->exec_sid = sid;
 	} else if (!strcmp(name, "fscreate")) {
@@ -5420,21 +5466,21 @@ static int selinux_key_alloc(struct key *k, const struct cred *cred,
 	if (!ksec)
 		return -ENOMEM;
 
-	tsec = cred->security;
+	tsec = lsm_get_cred(cred, &selinux_ops);
 	if (tsec->keycreate_sid)
 		ksec->sid = tsec->keycreate_sid;
 	else
 		ksec->sid = tsec->sid;
 
-	k->security = ksec;
+	lsm_set_key(k, ksec, &selinux_ops);
 	return 0;
 }
 
 static void selinux_key_free(struct key *k)
 {
-	struct key_security_struct *ksec = k->security;
+	struct key_security_struct *ksec = lsm_get_key(k, &selinux_ops);
 
-	k->security = NULL;
+	lsm_set_key(k, NULL, &selinux_ops);
 	kfree(ksec);
 }
 
@@ -5455,14 +5501,14 @@ static int selinux_key_permission(key_ref_t key_ref,
 	sid = cred_sid(cred);
 
 	key = key_ref_to_ptr(key_ref);
-	ksec = key->security;
+	ksec = lsm_get_key(key, &selinux_ops);
 
 	return avc_has_perm(sid, ksec->sid, SECCLASS_KEY, perm, NULL);
 }
 
 static int selinux_key_getsecurity(struct key *key, char **_buffer)
 {
-	struct key_security_struct *ksec = key->security;
+	struct key_security_struct *ksec = lsm_get_key(key, &selinux_ops);
 	char *context = NULL;
 	unsigned len;
 	int rc;
@@ -5476,7 +5522,7 @@ static int selinux_key_getsecurity(struct key *key, char **_buffer)
 
 #endif
 
-static struct security_operations selinux_ops = {
+struct security_operations selinux_ops = {
 	.name =				"selinux",
 
 	.ptrace_access_check =		selinux_ptrace_access_check,
@@ -5676,13 +5722,13 @@ static struct security_operations selinux_ops = {
 
 static __init int selinux_init(void)
 {
-	if (!security_module_enable(&selinux_ops)) {
-		selinux_enabled = 0;
+	if (!selinux_enabled) {
+		pr_info("SELinux:  Disabled at boot.\n");
 		return 0;
 	}
 
-	if (!selinux_enabled) {
-		printk(KERN_INFO "SELinux:  Disabled at boot.\n");
+	if (!security_module_enable(&selinux_ops)) {
+		selinux_enabled = 0;
 		return 0;
 	}
 
@@ -5694,13 +5740,10 @@ static __init int selinux_init(void)
 	default_noexec = !(VM_DATA_DEFAULT_FLAGS & VM_EXEC);
 
 	sel_inode_cache = kmem_cache_create("selinux_inode_security",
-					    sizeof(struct inode_security_struct),
-					    0, SLAB_PANIC, NULL);
+				    sizeof(struct inode_security_struct),
+				    0, SLAB_PANIC, NULL);
 	avc_init();
 
-	if (register_security(&selinux_ops))
-		panic("SELinux: Unable to register with kernel.\n");
-
 	if (selinux_enforcing)
 		printk(KERN_DEBUG "SELinux:  Starting in enforcing mode\n");
 	else
@@ -5824,6 +5867,8 @@ static int selinux_disabled;
 
 int selinux_disable(void)
 {
+	int rc;
+
 	if (ss_initialized) {
 		/* Not permitted after initial policy load. */
 		return -EINVAL;
@@ -5834,13 +5879,17 @@ int selinux_disable(void)
 		return -EINVAL;
 	}
 
+	rc = reset_security_ops(&selinux_ops);
+	if (rc) {
+		pr_info("SELinux:  Runtime disable disallowed.\n");
+		return rc;
+	}
+
 	printk(KERN_INFO "SELinux:  Disabled at runtime.\n");
 
 	selinux_disabled = 1;
 	selinux_enabled = 0;
 
-	reset_security_ops();
-
 	/* Try to destroy the avc node cache */
 	avc_disable();
 
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 26c7eee..1d1dd10 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -24,6 +24,7 @@
 #include <linux/binfmts.h>
 #include <linux/in.h>
 #include <linux/spinlock.h>
+#include <linux/lsm.h>
 #include "flask.h"
 #include "avc.h"
 
@@ -115,5 +116,6 @@ struct key_security_struct {
 };
 
 extern unsigned int selinux_checkreqprot;
+extern struct security_operations selinux_ops;
 
 #endif /* _SELINUX_OBJSEC_H_ */
diff --git a/security/selinux/include/xfrm.h b/security/selinux/include/xfrm.h
index 65f67cb..1219221 100644
--- a/security/selinux/include/xfrm.h
+++ b/security/selinux/include/xfrm.h
@@ -31,7 +31,7 @@ static inline struct inode_security_struct *get_sock_isec(struct sock *sk)
 	if (!sk->sk_socket)
 		return NULL;
 
-	return SOCK_INODE(sk->sk_socket)->i_security;
+	return lsm_get_inode(SOCK_INODE(sk->sk_socket), &selinux_ops);
 }
 
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index da4b8b2..7a9cbd0 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -81,7 +81,7 @@ static int selinux_netlbl_sidlookup_cached(struct sk_buff *skb,
 static struct netlbl_lsm_secattr *selinux_netlbl_sock_genattr(struct sock *sk)
 {
 	int rc;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = lsm_get_sock(sk, &selinux_ops);
 	struct netlbl_lsm_secattr *secattr;
 
 	if (sksec->nlbl_secattr != NULL)
@@ -221,7 +221,8 @@ int selinux_netlbl_skbuff_setsid(struct sk_buff *skb,
 	 * being labeled by it's parent socket, if it is just exit */
 	sk = skb->sk;
 	if (sk != NULL) {
-		struct sk_security_struct *sksec = sk->sk_security;
+		struct sk_security_struct *sksec =
+					lsm_get_sock(sk, &selinux_ops);
 		if (sksec->nlbl_state != NLBL_REQSKB)
 			return 0;
 		secattr = sksec->nlbl_secattr;
@@ -283,7 +284,7 @@ inet_conn_request_return:
  */
 void selinux_netlbl_inet_csk_clone(struct sock *sk, u16 family)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = lsm_get_sock(sk, &selinux_ops);
 
 	if (family == PF_INET)
 		sksec->nlbl_state = NLBL_LABELED;
@@ -304,7 +305,7 @@ void selinux_netlbl_inet_csk_clone(struct sock *sk, u16 family)
 int selinux_netlbl_socket_post_create(struct sock *sk, u16 family)
 {
 	int rc;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = lsm_get_sock(sk, &selinux_ops);
 	struct netlbl_lsm_secattr *secattr;
 
 	if (family != PF_INET)
@@ -402,7 +403,7 @@ int selinux_netlbl_socket_setsockopt(struct socket *sock,
 {
 	int rc = 0;
 	struct sock *sk = sock->sk;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = lsm_get_sock(sk, &selinux_ops);
 	struct netlbl_lsm_secattr secattr;
 
 	if (level == IPPROTO_IP && optname == IP_OPTIONS &&
@@ -435,7 +436,7 @@ int selinux_netlbl_socket_setsockopt(struct socket *sock,
 int selinux_netlbl_socket_connect(struct sock *sk, struct sockaddr *addr)
 {
 	int rc;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = lsm_get_sock(sk, &selinux_ops);
 	struct netlbl_lsm_secattr *secattr;
 
 	if (sksec->nlbl_state != NLBL_REQSKB &&
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 3a6e873..415c6b7 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -83,7 +83,7 @@ static int task_has_security(struct task_struct *tsk,
 	u32 sid = 0;
 
 	rcu_read_lock();
-	tsec = __task_cred(tsk)->security;
+	tsec = lsm_get_cred(__task_cred(tsk), &selinux_ops);
 	if (tsec)
 		sid = tsec->sid;
 	rcu_read_unlock();
@@ -1264,7 +1264,7 @@ static int sel_make_bools(void)
 		if (len >= PAGE_SIZE)
 			goto out;
 
-		isec = (struct inode_security_struct *)inode->i_security;
+		isec = lsm_get_inode(inode, &selinux_ops);
 		ret = security_genfs_sid("selinuxfs", page, SECCLASS_FILE, &sid);
 		if (ret)
 			goto out;
@@ -1831,7 +1831,7 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 		goto err;
 
 	inode->i_ino = ++sel_last_ino;
-	isec = (struct inode_security_struct *)inode->i_security;
+	isec = lsm_get_inode(inode, &selinux_ops);
 	isec->sid = SECINITSID_DEVNULL;
 	isec->sclass = SECCLASS_CHR_FILE;
 	isec->initialized = 1;
diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index 48665ec..02979a3 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -198,7 +198,8 @@ static int selinux_xfrm_sec_ctx_alloc(struct xfrm_sec_ctx **ctxp,
 	struct xfrm_user_sec_ctx *uctx, u32 sid)
 {
 	int rc = 0;
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec =
+				lsm_get_cred(current_cred(), &selinux_ops);
 	struct xfrm_sec_ctx *ctx = NULL;
 	char *ctx_str = NULL;
 	u32 str_len;
@@ -334,7 +335,8 @@ void selinux_xfrm_policy_free(struct xfrm_sec_ctx *ctx)
  */
 int selinux_xfrm_policy_delete(struct xfrm_sec_ctx *ctx)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec =
+				lsm_get_cred(current_cred(), &selinux_ops);
 	int rc = 0;
 
 	if (ctx) {
@@ -379,7 +381,8 @@ void selinux_xfrm_state_free(struct xfrm_state *x)
   */
 int selinux_xfrm_state_delete(struct xfrm_state *x)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec =
+				lsm_get_cred(current_cred(), &selinux_ops);
 	struct xfrm_sec_ctx *ctx = x->security;
 	int rc = 0;
 
diff --git a/security/smack/Kconfig b/security/smack/Kconfig
index 603b087..2c018a2 100644
--- a/security/smack/Kconfig
+++ b/security/smack/Kconfig
@@ -7,4 +7,3 @@ config SECURITY_SMACK
 	  Smack is useful for sensitivity, integrity, and a variety
 	  of other mandatory security schemes.
 	  If you are unsure how to answer this question, answer N.
-
diff --git a/security/smack/smack.h b/security/smack/smack.h
index 99b3612..c012d94 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -20,6 +20,7 @@
 #include <net/netlabel.h>
 #include <linux/list.h>
 #include <linux/rculist.h>
+#include <linux/lsm.h>
 #include <linux/lsm_audit.h>
 
 /*
@@ -203,6 +204,7 @@ struct smk_audit_info {
  * These functions are in smack_lsm.c
  */
 struct inode_smack *new_inode_smack(char *);
+int smk_setcurrent(char *, size_t);
 
 /*
  * These functions are in smack_access.c
@@ -243,18 +245,18 @@ extern struct security_operations smack_ops;
 /*
  * Is the directory transmuting?
  */
-static inline int smk_inode_transmutable(const struct inode *isp)
+static inline int smk_inode_transmutable(struct inode *isp)
 {
-	struct inode_smack *sip = isp->i_security;
+	struct inode_smack *sip = lsm_get_inode(isp, &smack_ops);
 	return (sip->smk_flags & SMK_INODE_TRANSMUTE) != 0;
 }
 
 /*
  * Present a pointer to the smack label in an inode blob.
  */
-static inline char *smk_of_inode(const struct inode *isp)
+static inline char *smk_of_inode(struct inode *isp)
 {
-	struct inode_smack *sip = isp->i_security;
+	struct inode_smack *sip = lsm_get_inode(isp, &smack_ops);
 	return sip->smk_inode;
 }
 
@@ -279,7 +281,9 @@ static inline char *smk_of_forked(const struct task_smack *tsp)
  */
 static inline char *smk_of_current(void)
 {
-	return smk_of_task(current_security());
+	struct task_smack *tsp = lsm_get_cred(current_cred(), &smack_ops);
+
+	return tsp->smk_task;
 }
 
 /*
diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index db14689..b4b4044 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -197,7 +197,7 @@ out_audit:
  */
 int smk_curacc(char *obj_label, u32 mode, struct smk_audit_info *a)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = lsm_get_cred(current_cred(), &smack_ops);
 	char *sp = smk_of_task(tsp);
 	int may;
 	int rc;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 38be92c..1f02f72 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -40,7 +40,16 @@
 #include <linux/binfmts.h>
 #include "smack.h"
 
-#define task_security(task)	(task_cred_xxx((task), security))
+static void *task_security(struct task_struct *task)
+{
+	const struct cred *cred;
+
+	rcu_read_lock();
+	cred = __task_cred(task);
+	rcu_read_unlock();
+
+	return lsm_get_cred(cred, &smack_ops);
+}
 
 #define TRANS_TRUE	"TRUE"
 #define TRANS_TRUE_SIZE	4
@@ -252,7 +261,7 @@ static int smack_sb_alloc_security(struct super_block *sb)
 	sbsp->smk_hat = smack_known_hat.smk_known;
 	sbsp->smk_initialized = 0;
 
-	sb->s_security = sbsp;
+	lsm_set_super(sb, sbsp, &smack_ops);
 
 	return 0;
 }
@@ -264,8 +273,10 @@ static int smack_sb_alloc_security(struct super_block *sb)
  */
 static void smack_sb_free_security(struct super_block *sb)
 {
-	kfree(sb->s_security);
-	sb->s_security = NULL;
+	struct superblock_smack *sbsp = lsm_get_super(sb, &smack_ops);
+
+	kfree(sbsp);
+	lsm_set_super(sb, NULL, &smack_ops);
 }
 
 /**
@@ -325,7 +336,7 @@ static int smack_sb_kern_mount(struct super_block *sb, int flags, void *data)
 {
 	struct dentry *root = sb->s_root;
 	struct inode *inode = root->d_inode;
-	struct superblock_smack *sp = sb->s_security;
+	struct superblock_smack *sp = lsm_get_super(sb, &smack_ops);
 	struct inode_smack *isp;
 	char *op;
 	char *commap;
@@ -368,9 +379,9 @@ static int smack_sb_kern_mount(struct super_block *sb, int flags, void *data)
 	/*
 	 * Initialize the root inode.
 	 */
-	isp = inode->i_security;
+	isp = lsm_get_inode(inode, &smack_ops);
 	if (isp == NULL)
-		inode->i_security = new_inode_smack(sp->smk_root);
+		lsm_set_inode(inode, new_inode_smack(sp->smk_root), &smack_ops);
 	else
 		isp->smk_inode = sp->smk_root;
 
@@ -386,7 +397,7 @@ static int smack_sb_kern_mount(struct super_block *sb, int flags, void *data)
  */
 static int smack_sb_statfs(struct dentry *dentry)
 {
-	struct superblock_smack *sbp = dentry->d_sb->s_security;
+	struct superblock_smack *sbp = lsm_get_super(dentry->d_sb, &smack_ops);
 	int rc;
 	struct smk_audit_info ad;
 
@@ -411,12 +422,13 @@ static int smack_sb_statfs(struct dentry *dentry)
 static int smack_sb_mount(const char *dev_name, struct path *path,
 			  const char *type, unsigned long flags, void *data)
 {
-	struct superblock_smack *sbp = path->dentry->d_sb->s_security;
+	struct superblock_smack *sbp;
 	struct smk_audit_info ad;
 
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_PATH);
 	smk_ad_setfield_u_fs_path(&ad, *path);
 
+	sbp = lsm_get_super(path->dentry->d_sb, &smack_ops);
 	return smk_curacc(sbp->smk_floor, MAY_WRITE, &ad);
 }
 
@@ -440,7 +452,7 @@ static int smack_sb_umount(struct vfsmount *mnt, int flags)
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_PATH);
 	smk_ad_setfield_u_fs_path(&ad, path);
 
-	sbp = path.dentry->d_sb->s_security;
+	sbp = lsm_get_super(path.dentry->d_sb, &smack_ops);
 	return smk_curacc(sbp->smk_floor, MAY_WRITE, &ad);
 }
 
@@ -457,7 +469,7 @@ static int smack_sb_umount(struct vfsmount *mnt, int flags)
 static int smack_bprm_set_creds(struct linux_binprm *bprm)
 {
 	struct inode *inode = bprm->file->f_path.dentry->d_inode;
-	struct task_smack *bsp = bprm->cred->security;
+	struct task_smack *bsp = lsm_get_cred(bprm->cred, &smack_ops);
 	struct inode_smack *isp;
 	int rc;
 
@@ -468,7 +480,7 @@ static int smack_bprm_set_creds(struct linux_binprm *bprm)
 	if (bprm->cred_prepared)
 		return 0;
 
-	isp = inode->i_security;
+	isp = lsm_get_inode(inode, &smack_ops);
 	if (isp->smk_task == NULL || isp->smk_task == bsp->smk_task)
 		return 0;
 
@@ -489,7 +501,7 @@ static int smack_bprm_set_creds(struct linux_binprm *bprm)
  */
 static void smack_bprm_committing_creds(struct linux_binprm *bprm)
 {
-	struct task_smack *bsp = bprm->cred->security;
+	struct task_smack *bsp = lsm_get_cred(bprm->cred, &smack_ops);
 
 	if (bsp->smk_task != bsp->smk_forked)
 		current->pdeath_signal = 0;
@@ -503,7 +515,7 @@ static void smack_bprm_committing_creds(struct linux_binprm *bprm)
  */
 static int smack_bprm_secureexec(struct linux_binprm *bprm)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = lsm_get_cred(current_cred(), &smack_ops);
 	int ret = cap_bprm_secureexec(bprm);
 
 	if (!ret && (tsp->smk_task != tsp->smk_forked))
@@ -524,9 +536,12 @@ static int smack_bprm_secureexec(struct linux_binprm *bprm)
  */
 static int smack_inode_alloc_security(struct inode *inode)
 {
-	inode->i_security = new_inode_smack(smk_of_current());
-	if (inode->i_security == NULL)
+	struct inode_smack *isp = new_inode_smack(smk_of_current());
+
+	if (isp == NULL)
 		return -ENOMEM;
+
+	lsm_set_inode(inode, isp, &smack_ops);
 	return 0;
 }
 
@@ -538,8 +553,8 @@ static int smack_inode_alloc_security(struct inode *inode)
  */
 static void smack_inode_free_security(struct inode *inode)
 {
-	kfree(inode->i_security);
-	inode->i_security = NULL;
+	kfree(lsm_get_inode(inode, &smack_ops));
+	lsm_set_inode(inode, NULL, &smack_ops);
 }
 
 /**
@@ -558,7 +573,7 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 				     void **value, size_t *len)
 {
 	struct smack_known *skp;
-	struct inode_smack *issp = inode->i_security;
+	struct inode_smack *issp = lsm_get_inode(inode, &smack_ops);
 	char *csp = smk_of_current();
 	char *isp = smk_of_inode(inode);
 	char *dsp = smk_of_inode(dir);
@@ -863,7 +878,7 @@ static void smack_inode_post_setxattr(struct dentry *dentry, const char *name,
 				      const void *value, size_t size, int flags)
 {
 	char *nsp;
-	struct inode_smack *isp = dentry->d_inode->i_security;
+	struct inode_smack *isp = lsm_get_inode(dentry->d_inode, &smack_ops);
 
 	if (strcmp(name, XATTR_NAME_SMACK) == 0) {
 		nsp = smk_import(value, size);
@@ -938,7 +953,7 @@ static int smack_inode_removexattr(struct dentry *dentry, const char *name)
 		rc = smk_curacc(smk_of_inode(dentry->d_inode), MAY_WRITE, &ad);
 
 	if (rc == 0) {
-		isp = dentry->d_inode->i_security;
+		isp = lsm_get_inode(dentry->d_inode, &smack_ops);
 		isp->smk_task = NULL;
 		isp->smk_mmap = NULL;
 	}
@@ -955,9 +970,8 @@ static int smack_inode_removexattr(struct dentry *dentry, const char *name)
  *
  * Returns the size of the attribute or an error code
  */
-static int smack_inode_getsecurity(const struct inode *inode,
-				   const char *name, void **buffer,
-				   bool alloc)
+static int smack_inode_getsecurity(const struct inode *inode, const char *name,
+					void **buffer, bool alloc)
 {
 	struct socket_smack *ssp;
 	struct socket *sock;
@@ -968,7 +982,7 @@ static int smack_inode_getsecurity(const struct inode *inode,
 	int rc = 0;
 
 	if (strcmp(name, XATTR_SMACK_SUFFIX) == 0) {
-		isp = smk_of_inode(inode);
+		isp = smk_of_inode(ip);
 		ilen = strlen(isp) + 1;
 		*buffer = isp;
 		return ilen;
@@ -985,7 +999,7 @@ static int smack_inode_getsecurity(const struct inode *inode,
 	if (sock == NULL || sock->sk == NULL)
 		return -EOPNOTSUPP;
 
-	ssp = sock->sk->sk_security;
+	ssp = lsm_get_sock(sock->sk, &smack_ops);
 
 	if (strcmp(name, XATTR_SMACK_IPIN) == 0)
 		isp = ssp->smk_in;
@@ -1015,13 +1029,11 @@ static int smack_inode_getsecurity(const struct inode *inode,
 static int smack_inode_listsecurity(struct inode *inode, char *buffer,
 				    size_t buffer_size)
 {
-	int len = strlen(XATTR_NAME_SMACK);
+	const int len = sizeof(XATTR_NAME_SMACK);
 
-	if (buffer != NULL && len <= buffer_size) {
+	if (buffer != NULL && len <= buffer_size)
 		memcpy(buffer, XATTR_NAME_SMACK, len);
-		return len;
-	}
-	return -EINVAL;
+	return len;
 }
 
 /**
@@ -1031,7 +1043,7 @@ static int smack_inode_listsecurity(struct inode *inode, char *buffer,
  */
 static void smack_inode_getsecid(const struct inode *inode, u32 *secid)
 {
-	struct inode_smack *isp = inode->i_security;
+	struct inode_smack *isp = lsm_get_inode(inode, &smack_ops);
 
 	*secid = smack_to_secid(isp->smk_inode);
 }
@@ -1070,7 +1082,7 @@ static int smack_file_permission(struct file *file, int mask)
  */
 static int smack_file_alloc_security(struct file *file)
 {
-	file->f_security = smk_of_current();
+	lsm_set_file(file, smk_of_current(), &smack_ops);
 	return 0;
 }
 
@@ -1083,7 +1095,7 @@ static int smack_file_alloc_security(struct file *file)
  */
 static void smack_file_free_security(struct file *file)
 {
-	file->f_security = NULL;
+	lsm_set_file(file, NULL, &smack_ops);
 }
 
 /**
@@ -1101,15 +1113,16 @@ static int smack_file_ioctl(struct file *file, unsigned int cmd,
 {
 	int rc = 0;
 	struct smk_audit_info ad;
+	char *fsp = lsm_get_file(file, &smack_ops);
 
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_PATH);
 	smk_ad_setfield_u_fs_path(&ad, file->f_path);
 
 	if (_IOC_DIR(cmd) & _IOC_WRITE)
-		rc = smk_curacc(file->f_security, MAY_WRITE, &ad);
+		rc = smk_curacc(fsp, MAY_WRITE, &ad);
 
 	if (rc == 0 && (_IOC_DIR(cmd) & _IOC_READ))
-		rc = smk_curacc(file->f_security, MAY_READ, &ad);
+		rc = smk_curacc(fsp, MAY_READ, &ad);
 
 	return rc;
 }
@@ -1127,7 +1140,7 @@ static int smack_file_lock(struct file *file, unsigned int cmd)
 
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_PATH);
 	smk_ad_setfield_u_fs_path(&ad, file->f_path);
-	return smk_curacc(file->f_security, MAY_WRITE, &ad);
+	return smk_curacc(lsm_get_file(file, &smack_ops), MAY_WRITE, &ad);
 }
 
 /**
@@ -1157,7 +1170,7 @@ static int smack_file_fcntl(struct file *file, unsigned int cmd,
 	case F_SETSIG:
 		smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_PATH);
 		smk_ad_setfield_u_fs_path(&ad, file->f_path);
-		rc = smk_curacc(file->f_security, MAY_WRITE, &ad);
+		rc = smk_curacc(lsm_get_file(file, &smack_ops), MAY_WRITE, &ad);
 		break;
 	default:
 		break;
@@ -1201,12 +1214,12 @@ static int smack_mmap_file(struct file *file,
 	if (dp->d_inode == NULL)
 		return 0;
 
-	isp = dp->d_inode->i_security;
+	isp = lsm_get_inode(dp->d_inode, &smack_ops);
 	if (isp->smk_mmap == NULL)
 		return 0;
 	msmack = isp->smk_mmap;
 
-	tsp = current_security();
+	tsp = lsm_get_cred(current_cred(), &smack_ops);
 	sp = smk_of_current();
 	skp = smk_find_entry(sp);
 	rc = 0;
@@ -1285,7 +1298,7 @@ static int smack_mmap_file(struct file *file,
  */
 static int smack_file_set_fowner(struct file *file)
 {
-	file->f_security = smk_of_current();
+	lsm_set_file(file, smk_of_current(), &smack_ops);
 	return 0;
 }
 
@@ -1305,22 +1318,24 @@ static int smack_file_send_sigiotask(struct task_struct *tsk,
 {
 	struct file *file;
 	int rc;
-	char *tsp = smk_of_task(tsk->cred->security);
+	char *tsp = smk_of_task(lsm_get_cred(tsk->cred, &smack_ops));
+	char *fsp;
 	struct smk_audit_info ad;
 
 	/*
 	 * struct fown_struct is never outside the context of a struct file
 	 */
 	file = container_of(fown, struct file, f_owner);
+	fsp = lsm_get_file(file, &smack_ops);
 
 	/* we don't log here as rc can be overriden */
-	rc = smk_access(file->f_security, tsp, MAY_WRITE, NULL);
+	rc = smk_access(fsp, tsp, MAY_WRITE, NULL);
 	if (rc != 0 && has_capability(tsk, CAP_MAC_OVERRIDE))
 		rc = 0;
 
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_TASK);
 	smk_ad_setfield_u_tsk(&ad, tsk);
-	smack_log(file->f_security, tsp, MAY_WRITE, rc, &ad);
+	smack_log(fsp, tsp, MAY_WRITE, rc, &ad);
 	return rc;
 }
 
@@ -1345,7 +1360,7 @@ static int smack_file_receive(struct file *file)
 	if (file->f_mode & FMODE_WRITE)
 		may |= MAY_WRITE;
 
-	return smk_curacc(file->f_security, may, &ad);
+	return smk_curacc(lsm_get_file(file, &smack_ops), may, &ad);
 }
 
 /**
@@ -1359,9 +1374,10 @@ static int smack_file_receive(struct file *file)
  */
 static int smack_file_open(struct file *file, const struct cred *cred)
 {
-	struct inode_smack *isp = file->f_path.dentry->d_inode->i_security;
+	struct inode_smack *isp;
 
-	file->f_security = isp->smk_inode;
+	isp = lsm_get_inode(file->f_path.dentry->d_inode, &smack_ops);
+	lsm_set_file(file, isp->smk_inode, &smack_ops);
 
 	return 0;
 }
@@ -1387,7 +1403,7 @@ static int smack_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 	if (tsp == NULL)
 		return -ENOMEM;
 
-	cred->security = tsp;
+	lsm_set_cred(cred, tsp, &smack_ops);
 
 	return 0;
 }
@@ -1400,14 +1416,14 @@ static int smack_cred_alloc_blank(struct cred *cred, gfp_t gfp)
  */
 static void smack_cred_free(struct cred *cred)
 {
-	struct task_smack *tsp = cred->security;
+	struct task_smack *tsp = lsm_get_cred(cred, &smack_ops);
 	struct smack_rule *rp;
 	struct list_head *l;
 	struct list_head *n;
 
 	if (tsp == NULL)
 		return;
-	cred->security = NULL;
+	lsm_set_cred(cred, NULL, &smack_ops);
 
 	list_for_each_safe(l, n, &tsp->smk_rules) {
 		rp = list_entry(l, struct smack_rule, list);
@@ -1428,7 +1444,7 @@ static void smack_cred_free(struct cred *cred)
 static int smack_cred_prepare(struct cred *new, const struct cred *old,
 			      gfp_t gfp)
 {
-	struct task_smack *old_tsp = old->security;
+	struct task_smack *old_tsp = lsm_get_cred(old, &smack_ops);
 	struct task_smack *new_tsp;
 	int rc;
 
@@ -1440,7 +1456,7 @@ static int smack_cred_prepare(struct cred *new, const struct cred *old,
 	if (rc != 0)
 		return rc;
 
-	new->security = new_tsp;
+	lsm_set_cred(new, new_tsp, &smack_ops);
 	return 0;
 }
 
@@ -1453,8 +1469,8 @@ static int smack_cred_prepare(struct cred *new, const struct cred *old,
  */
 static void smack_cred_transfer(struct cred *new, const struct cred *old)
 {
-	struct task_smack *old_tsp = old->security;
-	struct task_smack *new_tsp = new->security;
+	struct task_smack *old_tsp = lsm_get_cred(old, &smack_ops);
+	struct task_smack *new_tsp = lsm_get_cred(new, &smack_ops);
 
 	new_tsp->smk_task = old_tsp->smk_task;
 	new_tsp->smk_forked = old_tsp->smk_task;
@@ -1474,7 +1490,7 @@ static void smack_cred_transfer(struct cred *new, const struct cred *old)
  */
 static int smack_kernel_act_as(struct cred *new, u32 secid)
 {
-	struct task_smack *new_tsp = new->security;
+	struct task_smack *new_tsp = lsm_get_cred(new, &smack_ops);
 	char *smack = smack_from_secid(secid);
 
 	if (smack == NULL)
@@ -1495,8 +1511,8 @@ static int smack_kernel_act_as(struct cred *new, u32 secid)
 static int smack_kernel_create_files_as(struct cred *new,
 					struct inode *inode)
 {
-	struct inode_smack *isp = inode->i_security;
-	struct task_smack *tsp = new->security;
+	struct inode_smack *isp = lsm_get_inode(inode, &smack_ops);
+	struct task_smack *tsp = lsm_get_cred(new, &smack_ops);
 
 	tsp->smk_forked = isp->smk_inode;
 	tsp->smk_task = isp->smk_inode;
@@ -1715,7 +1731,7 @@ static int smack_task_wait(struct task_struct *p)
  */
 static void smack_task_to_inode(struct task_struct *p, struct inode *inode)
 {
-	struct inode_smack *isp = inode->i_security;
+	struct inode_smack *isp = lsm_get_inode(inode, &smack_ops);
 	isp->smk_inode = smk_of_task(task_security(p));
 }
 
@@ -1746,7 +1762,7 @@ static int smack_sk_alloc_security(struct sock *sk, int family, gfp_t gfp_flags)
 	ssp->smk_out = csp;
 	ssp->smk_packet = NULL;
 
-	sk->sk_security = ssp;
+	lsm_set_sock(sk, ssp, &smack_ops);
 
 	return 0;
 }
@@ -1759,7 +1775,8 @@ static int smack_sk_alloc_security(struct sock *sk, int family, gfp_t gfp_flags)
  */
 static void smack_sk_free_security(struct sock *sk)
 {
-	kfree(sk->sk_security);
+	kfree(lsm_get_sock(sk, &smack_ops));
+	lsm_set_sock(sk, NULL, &smack_ops);
 }
 
 /**
@@ -1812,7 +1829,7 @@ static char *smack_host_label(struct sockaddr_in *sip)
 static int smack_netlabel(struct sock *sk, int labeled)
 {
 	struct smack_known *skp;
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = lsm_get_sock(sk, &smack_ops);
 	int rc = 0;
 
 	/*
@@ -1856,7 +1873,7 @@ static int smack_netlabel_send(struct sock *sk, struct sockaddr_in *sap)
 	int rc;
 	int sk_lbl;
 	char *hostsp;
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = lsm_get_sock(sk, &smack_ops);
 	struct smk_audit_info ad;
 
 	rcu_read_lock();
@@ -1899,7 +1916,7 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
 				   const void *value, size_t size, int flags)
 {
 	char *sp;
-	struct inode_smack *nsp = inode->i_security;
+	struct inode_smack *nsp = lsm_get_inode(inode, &smack_ops);
 	struct socket_smack *ssp;
 	struct socket *sock;
 	int rc = 0;
@@ -1926,7 +1943,7 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
 	if (sock == NULL || sock->sk == NULL)
 		return -EOPNOTSUPP;
 
-	ssp = sock->sk->sk_security;
+	ssp = lsm_get_sock(sock->sk, &smack_ops);
 
 	if (strcmp(name, XATTR_SMACK_IPIN) == 0)
 		ssp->smk_in = sp;
@@ -2017,7 +2034,7 @@ static int smack_flags_to_may(int flags)
  */
 static int smack_msg_msg_alloc_security(struct msg_msg *msg)
 {
-	msg->security = smk_of_current();
+	lsm_set_msg(msg, smk_of_current(), &smack_ops);
 	return 0;
 }
 
@@ -2029,7 +2046,7 @@ static int smack_msg_msg_alloc_security(struct msg_msg *msg)
  */
 static void smack_msg_msg_free_security(struct msg_msg *msg)
 {
-	msg->security = NULL;
+	lsm_set_msg(msg, NULL, &smack_ops);
 }
 
 /**
@@ -2040,7 +2057,7 @@ static void smack_msg_msg_free_security(struct msg_msg *msg)
  */
 static char *smack_of_shm(struct shmid_kernel *shp)
 {
-	return (char *)shp->shm_perm.security;
+	return lsm_get_ipc(&shp->shm_perm, &smack_ops);
 }
 
 /**
@@ -2051,9 +2068,7 @@ static char *smack_of_shm(struct shmid_kernel *shp)
  */
 static int smack_shm_alloc_security(struct shmid_kernel *shp)
 {
-	struct kern_ipc_perm *isp = &shp->shm_perm;
-
-	isp->security = smk_of_current();
+	lsm_set_ipc(&shp->shm_perm, smk_of_current(), &smack_ops);
 	return 0;
 }
 
@@ -2065,9 +2080,7 @@ static int smack_shm_alloc_security(struct shmid_kernel *shp)
  */
 static void smack_shm_free_security(struct shmid_kernel *shp)
 {
-	struct kern_ipc_perm *isp = &shp->shm_perm;
-
-	isp->security = NULL;
+	lsm_set_ipc(&shp->shm_perm, NULL, &smack_ops);
 }
 
 /**
@@ -2079,14 +2092,13 @@ static void smack_shm_free_security(struct shmid_kernel *shp)
  */
 static int smk_curacc_shm(struct shmid_kernel *shp, int access)
 {
-	char *ssp = smack_of_shm(shp);
 	struct smk_audit_info ad;
 
 #ifdef CONFIG_AUDIT
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_IPC);
 	ad.a.u.ipc_id = shp->shm_perm.id;
 #endif
-	return smk_curacc(ssp, access, &ad);
+	return smk_curacc(smack_of_shm(shp), access, &ad);
 }
 
 /**
@@ -2098,10 +2110,7 @@ static int smk_curacc_shm(struct shmid_kernel *shp, int access)
  */
 static int smack_shm_associate(struct shmid_kernel *shp, int shmflg)
 {
-	int may;
-
-	may = smack_flags_to_may(shmflg);
-	return smk_curacc_shm(shp, may);
+	return smk_curacc_shm(shp, smack_flags_to_may(shmflg));
 }
 
 /**
@@ -2149,10 +2158,7 @@ static int smack_shm_shmctl(struct shmid_kernel *shp, int cmd)
 static int smack_shm_shmat(struct shmid_kernel *shp, char __user *shmaddr,
 			   int shmflg)
 {
-	int may;
-
-	may = smack_flags_to_may(shmflg);
-	return smk_curacc_shm(shp, may);
+	return smk_curacc_shm(shp, smack_flags_to_may(shmflg));
 }
 
 /**
@@ -2163,7 +2169,7 @@ static int smack_shm_shmat(struct shmid_kernel *shp, char __user *shmaddr,
  */
 static char *smack_of_sem(struct sem_array *sma)
 {
-	return (char *)sma->sem_perm.security;
+	return lsm_get_ipc(&sma->sem_perm, &smack_ops);
 }
 
 /**
@@ -2174,9 +2180,7 @@ static char *smack_of_sem(struct sem_array *sma)
  */
 static int smack_sem_alloc_security(struct sem_array *sma)
 {
-	struct kern_ipc_perm *isp = &sma->sem_perm;
-
-	isp->security = smk_of_current();
+	lsm_set_ipc(&sma->sem_perm, smk_of_current(), &smack_ops);
 	return 0;
 }
 
@@ -2188,9 +2192,7 @@ static int smack_sem_alloc_security(struct sem_array *sma)
  */
 static void smack_sem_free_security(struct sem_array *sma)
 {
-	struct kern_ipc_perm *isp = &sma->sem_perm;
-
-	isp->security = NULL;
+	lsm_set_ipc(&sma->sem_perm, NULL, &smack_ops);
 }
 
 /**
@@ -2221,10 +2223,7 @@ static int smk_curacc_sem(struct sem_array *sma, int access)
  */
 static int smack_sem_associate(struct sem_array *sma, int semflg)
 {
-	int may;
-
-	may = smack_flags_to_may(semflg);
-	return smk_curacc_sem(sma, may);
+	return smk_curacc_sem(sma, smack_flags_to_may(semflg));
 }
 
 /**
@@ -2292,9 +2291,7 @@ static int smack_sem_semop(struct sem_array *sma, struct sembuf *sops,
  */
 static int smack_msg_queue_alloc_security(struct msg_queue *msq)
 {
-	struct kern_ipc_perm *kisp = &msq->q_perm;
-
-	kisp->security = smk_of_current();
+	lsm_set_ipc(&msq->q_perm, smk_of_current(), &smack_ops);
 	return 0;
 }
 
@@ -2306,9 +2303,7 @@ static int smack_msg_queue_alloc_security(struct msg_queue *msq)
  */
 static void smack_msg_queue_free_security(struct msg_queue *msq)
 {
-	struct kern_ipc_perm *kisp = &msq->q_perm;
-
-	kisp->security = NULL;
+	lsm_set_ipc(&msq->q_perm, NULL, &smack_ops);
 }
 
 /**
@@ -2319,7 +2314,7 @@ static void smack_msg_queue_free_security(struct msg_queue *msq)
  */
 static char *smack_of_msq(struct msg_queue *msq)
 {
-	return (char *)msq->q_perm.security;
+	return lsm_get_ipc(&msq->q_perm, &smack_ops);
 }
 
 /**
@@ -2350,10 +2345,7 @@ static int smk_curacc_msq(struct msg_queue *msq, int access)
  */
 static int smack_msg_queue_associate(struct msg_queue *msq, int msqflg)
 {
-	int may;
-
-	may = smack_flags_to_may(msqflg);
-	return smk_curacc_msq(msq, may);
+	return smk_curacc_msq(msq, smack_flags_to_may(msqflg));
 }
 
 /**
@@ -2400,10 +2392,7 @@ static int smack_msg_queue_msgctl(struct msg_queue *msq, int cmd)
 static int smack_msg_queue_msgsnd(struct msg_queue *msq, struct msg_msg *msg,
 				  int msqflg)
 {
-	int may;
-
-	may = smack_flags_to_may(msqflg);
-	return smk_curacc_msq(msq, may);
+	return smk_curacc_msq(msq, smack_flags_to_may(msqflg));
 }
 
 /**
@@ -2431,15 +2420,14 @@ static int smack_msg_queue_msgrcv(struct msg_queue *msq, struct msg_msg *msg,
  */
 static int smack_ipc_permission(struct kern_ipc_perm *ipp, short flag)
 {
-	char *isp = ipp->security;
-	int may = smack_flags_to_may(flag);
 	struct smk_audit_info ad;
 
 #ifdef CONFIG_AUDIT
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_IPC);
 	ad.a.u.ipc_id = ipp->id;
 #endif
-	return smk_curacc(isp, may, &ad);
+	return smk_curacc(lsm_get_ipc(ipp, &smack_ops),
+				smack_flags_to_may(flag), &ad);
 }
 
 /**
@@ -2449,9 +2437,7 @@ static int smack_ipc_permission(struct kern_ipc_perm *ipp, short flag)
  */
 static void smack_ipc_getsecid(struct kern_ipc_perm *ipp, u32 *secid)
 {
-	char *smack = ipp->security;
-
-	*secid = smack_to_secid(smack);
+	*secid = smack_to_secid(lsm_get_ipc(ipp, &smack_ops));
 }
 
 /**
@@ -2477,7 +2463,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 	if (inode == NULL)
 		return;
 
-	isp = inode->i_security;
+	isp = lsm_get_inode(inode, &smack_ops);
 
 	mutex_lock(&isp->smk_lock);
 	/*
@@ -2488,7 +2474,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 		goto unlockandout;
 
 	sbp = inode->i_sb;
-	sbsp = sbp->s_security;
+	sbsp = lsm_get_super(sbp, &smack_ops);
 	/*
 	 * We're going to use the superblock default label
 	 * if there's no label on the file.
@@ -2670,40 +2656,26 @@ static int smack_getprocattr(struct task_struct *p, char *name, char **value)
 }
 
 /**
- * smack_setprocattr - Smack process attribute setting
- * @p: the object task
- * @name: the name of the attribute in /proc/.../attr
+ * smk_setcurrent - Set Smack process attribute setting
  * @value: the value to set
  * @size: the size of the value
  *
- * Sets the Smack value of the task. Only setting self
- * is permitted and only with privilege
+ * Sets the Smack value of the task. Only with privilege
  *
  * Returns the length of the smack label or an error code
  */
-static int smack_setprocattr(struct task_struct *p, char *name,
-			     void *value, size_t size)
+int smk_setcurrent(char *value, size_t size)
 {
 	struct task_smack *tsp;
 	struct cred *new;
 	char *newsmack;
 
-	/*
-	 * Changing another process' Smack value is too dangerous
-	 * and supports no sane use case.
-	 */
-	if (p != current)
-		return -EPERM;
-
 	if (!smack_privileged(CAP_MAC_ADMIN))
 		return -EPERM;
 
 	if (value == NULL || size == 0 || size >= SMK_LONGLABEL)
 		return -EINVAL;
 
-	if (strcmp(name, "current") != 0)
-		return -EINVAL;
-
 	newsmack = smk_import(value, size);
 	if (newsmack == NULL)
 		return -EINVAL;
@@ -2718,7 +2690,7 @@ static int smack_setprocattr(struct task_struct *p, char *name,
 	if (new == NULL)
 		return -ENOMEM;
 
-	tsp = new->security;
+	tsp = lsm_get_cred(new, &smack_ops);
 	tsp->smk_task = newsmack;
 
 	commit_creds(new);
@@ -2726,6 +2698,33 @@ static int smack_setprocattr(struct task_struct *p, char *name,
 }
 
 /**
+ * smack_setprocattr - Smack process attribute setting
+ * @p: the object task
+ * @name: the name of the attribute in /proc/.../attr
+ * @value: the value to set
+ * @size: the size of the value
+ *
+ * Sets the Smack value of the task. Only setting self
+ * is permitted and only with privilege
+ *
+ * Returns the length of the smack label or an error code
+ */
+static int smack_setprocattr(struct task_struct *p, char *name,
+			     void *value, size_t size)
+{
+	/*
+	 * Changing another process' Smack value is too dangerous
+	 * and supports no sane use case.
+	 */
+	if (p != current)
+		return -EPERM;
+	if (strcmp(name, "current") != 0)
+		return -EINVAL;
+
+	return smk_setcurrent(value, size);
+}
+
+/**
  * smack_unix_stream_connect - Smack access on UDS
  * @sock: one sock
  * @other: the other sock
@@ -2737,9 +2736,9 @@ static int smack_setprocattr(struct task_struct *p, char *name,
 static int smack_unix_stream_connect(struct sock *sock,
 				     struct sock *other, struct sock *newsk)
 {
-	struct socket_smack *ssp = sock->sk_security;
-	struct socket_smack *osp = other->sk_security;
-	struct socket_smack *nsp = newsk->sk_security;
+	struct socket_smack *ssp = lsm_get_sock(sock, &smack_ops);
+	struct socket_smack *osp = lsm_get_sock(other, &smack_ops);
+	struct socket_smack *nsp = lsm_get_sock(newsk, &smack_ops);
 	struct smk_audit_info ad;
 	int rc = 0;
 
@@ -2774,8 +2773,8 @@ static int smack_unix_stream_connect(struct sock *sock,
  */
 static int smack_unix_may_send(struct socket *sock, struct socket *other)
 {
-	struct socket_smack *ssp = sock->sk->sk_security;
-	struct socket_smack *osp = other->sk->sk_security;
+	struct socket_smack *ssp = lsm_get_sock(sock->sk, &smack_ops);
+	struct socket_smack *osp = lsm_get_sock(other->sk, &smack_ops);
 	struct smk_audit_info ad;
 	int rc = 0;
 
@@ -2894,7 +2893,7 @@ static char *smack_from_secattr(struct netlbl_lsm_secattr *sap,
 static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
 	struct netlbl_lsm_secattr secattr;
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = lsm_get_sock(sk, &smack_ops);
 	char *csp;
 	int rc;
 	struct smk_audit_info ad;
@@ -2953,7 +2952,7 @@ static int smack_socket_getpeersec_stream(struct socket *sock,
 	int slen = 1;
 	int rc = 0;
 
-	ssp = sock->sk->sk_security;
+	ssp = lsm_get_sock(sock->sk, &smack_ops);
 	if (ssp->smk_packet != NULL) {
 		rcp = ssp->smk_packet;
 		slen = strlen(rcp) + 1;
@@ -3000,14 +2999,14 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 		family = sock->sk->sk_family;
 
 	if (family == PF_UNIX) {
-		ssp = sock->sk->sk_security;
+		ssp = lsm_get_sock(sock->sk, &smack_ops);
 		s = smack_to_secid(ssp->smk_out);
 	} else if (family == PF_INET || family == PF_INET6) {
 		/*
 		 * Translate what netlabel gave us.
 		 */
 		if (sock != NULL && sock->sk != NULL)
-			ssp = sock->sk->sk_security;
+			ssp = lsm_get_sock(sock->sk, &smack_ops);
 		netlbl_secattr_init(&secattr);
 		rc = netlbl_skbuff_getattr(skb, family, &secattr);
 		if (rc == 0) {
@@ -3038,7 +3037,7 @@ static void smack_sock_graft(struct sock *sk, struct socket *parent)
 	    (sk->sk_family != PF_INET && sk->sk_family != PF_INET6))
 		return;
 
-	ssp = sk->sk_security;
+	ssp = lsm_get_sock(sk, &smack_ops);
 	ssp->smk_in = ssp->smk_out = smk_of_current();
 	/* cssp->smk_packet is already set in smack_inet_csk_clone() */
 }
@@ -3057,7 +3056,7 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 {
 	u16 family = sk->sk_family;
 	struct smack_known *skp;
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = lsm_get_sock(sk, &smack_ops);
 	struct netlbl_lsm_secattr secattr;
 	struct sockaddr_in addr;
 	struct iphdr *hdr;
@@ -3131,7 +3130,7 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 static void smack_inet_csk_clone(struct sock *sk,
 				 const struct request_sock *req)
 {
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = lsm_get_sock(sk, &smack_ops);
 
 	if (req->peer_secid != 0)
 		ssp->smk_packet = smack_from_secid(req->peer_secid);
@@ -3161,7 +3160,8 @@ static void smack_inet_csk_clone(struct sock *sk,
 static int smack_key_alloc(struct key *key, const struct cred *cred,
 			   unsigned long flags)
 {
-	key->security = smk_of_task(cred->security);
+	lsm_set_key(key, smk_of_task(lsm_get_cred(cred, &smack_ops)),
+			&smack_ops);
 	return 0;
 }
 
@@ -3173,7 +3173,7 @@ static int smack_key_alloc(struct key *key, const struct cred *cred,
  */
 static void smack_key_free(struct key *key)
 {
-	key->security = NULL;
+	lsm_set_key(key, NULL, &smack_ops);
 }
 
 /*
@@ -3190,16 +3190,18 @@ static int smack_key_permission(key_ref_t key_ref,
 {
 	struct key *keyp;
 	struct smk_audit_info ad;
-	char *tsp = smk_of_task(cred->security);
+	char *tsp = smk_of_task(lsm_get_cred(cred, &smack_ops));
+	char *ksp;
 
 	keyp = key_ref_to_ptr(key_ref);
 	if (keyp == NULL)
 		return -EINVAL;
+	ksp = lsm_get_key(keyp, &smack_ops);
 	/*
 	 * If the key hasn't been initialized give it access so that
 	 * it may do so.
 	 */
-	if (keyp->security == NULL)
+	if (ksp == NULL)
 		return 0;
 	/*
 	 * This should not occur
@@ -3211,8 +3213,7 @@ static int smack_key_permission(key_ref_t key_ref,
 	ad.a.u.key_struct.key = keyp->serial;
 	ad.a.u.key_struct.key_desc = keyp->description;
 #endif
-	return smk_access(tsp, keyp->security,
-				 MAY_READWRITE, &ad);
+	return smk_access(tsp, ksp, MAY_READWRITE, &ad);
 }
 #endif /* CONFIG_KEYS */
 
@@ -3577,6 +3578,7 @@ static __init void init_smack_known_list(void)
  */
 static __init int smack_init(void)
 {
+	int rc;
 	struct cred *cred;
 	struct task_smack *tsp;
 
@@ -3594,17 +3596,14 @@ static __init int smack_init(void)
 	 * Set the security state for the initial task.
 	 */
 	cred = (struct cred *) current->cred;
-	cred->security = tsp;
+
+	rc = lsm_set_init_cred(cred, tsp, &smack_ops);
+	if (rc != 0)
+		panic("smack: Unable to initialize credentials.\n");
 
 	/* initialize the smack_known_list */
 	init_smack_known_list();
 
-	/*
-	 * Register with LSM
-	 */
-	if (register_security(&smack_ops))
-		panic("smack: Unable to register with kernel.\n");
-
 	return 0;
 }
 
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 99929a5..c12a80b 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -50,6 +50,7 @@ enum smk_inos {
 	SMK_ACCESS2	= 16,	/* make an access check with long labels */
 	SMK_CIPSO2	= 17,	/* load long label -> CIPSO mapping */
 	SMK_REVOKE_SUBJ	= 18,	/* set rules with subject label to '-' */
+	SMK_CURRENT	= 19,	/* current process label */
 };
 
 /*
@@ -1582,7 +1583,7 @@ static ssize_t smk_write_onlycap(struct file *file, const char __user *buf,
 				 size_t count, loff_t *ppos)
 {
 	char *data;
-	char *sp = smk_of_task(current->cred->security);
+	char *sp = smk_of_task(lsm_get_cred(current->cred, &smack_ops));
 	int rc = count;
 
 	if (!smack_privileged(CAP_MAC_ADMIN))
@@ -1696,14 +1697,14 @@ static const struct file_operations smk_logging_ops = {
 
 static void *load_self_seq_start(struct seq_file *s, loff_t *pos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = lsm_get_cred(current_cred(), &smack_ops);
 
 	return smk_seq_start(s, pos, &tsp->smk_rules);
 }
 
 static void *load_self_seq_next(struct seq_file *s, void *v, loff_t *pos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = lsm_get_cred(current_cred(), &smack_ops);
 
 	return smk_seq_next(s, v, pos, &tsp->smk_rules);
 }
@@ -1750,7 +1751,7 @@ static int smk_open_load_self(struct inode *inode, struct file *file)
 static ssize_t smk_write_load_self(struct file *file, const char __user *buf,
 			      size_t count, loff_t *ppos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = lsm_get_cred(current_cred(), &smack_ops);
 
 	return smk_write_rules_list(file, buf, count, ppos, &tsp->smk_rules,
 				    &tsp->smk_rules_lock, SMK_FIXED24_FMT);
@@ -1905,14 +1906,14 @@ static const struct file_operations smk_load2_ops = {
 
 static void *load_self2_seq_start(struct seq_file *s, loff_t *pos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = lsm_get_cred(current_cred(), &smack_ops);
 
 	return smk_seq_start(s, pos, &tsp->smk_rules);
 }
 
 static void *load_self2_seq_next(struct seq_file *s, void *v, loff_t *pos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = lsm_get_cred(current_cred(), &smack_ops);
 
 	return smk_seq_next(s, v, pos, &tsp->smk_rules);
 }
@@ -1958,7 +1959,7 @@ static int smk_open_load_self2(struct inode *inode, struct file *file)
 static ssize_t smk_write_load_self2(struct file *file, const char __user *buf,
 			      size_t count, loff_t *ppos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = lsm_get_cred(current_cred(), &smack_ops);
 
 	return smk_write_rules_list(file, buf, count, ppos, &tsp->smk_rules,
 				    &tsp->smk_rules_lock, SMK_LONG_FMT);
@@ -2064,6 +2065,81 @@ static const struct file_operations smk_revoke_subj_ops = {
 };
 
 /**
+ * smk_read_current - read() for /smack/current
+ * @filp: file pointer, not actually used
+ * @buf: where to put the result
+ * @cn: maximum to send along
+ * @ppos: where to start
+ *
+ * Returns number of bytes read or error code, as appropriate
+ */
+static ssize_t smk_read_current(struct file *filp, char __user *buf,
+				size_t cn, loff_t *ppos)
+{
+	int asize;
+	int rc;
+	struct task_smack *tsp = lsm_get_cred(current_cred(), &smack_ops);
+	char *cp;
+
+	if (*ppos != 0)
+		return 0;
+
+	asize = strlen(tsp->smk_task);
+	if (cn < asize)
+		return -EINVAL;
+
+	cp = kstrdup(tsp->smk_task, GFP_KERNEL);
+	if (cp == NULL)
+		return -ENOMEM;
+
+	/*
+	 * kstrdup is going to give back strlen(old) + 1 for the '\0'
+	 */
+	cp[asize] = '\n';
+
+	rc = simple_read_from_buffer(buf, cn, ppos, cp, asize + 1);
+	kfree(cp);
+	return rc;
+}
+
+/**
+ * smk_write_current - write() for /smack/current
+ * @file: file pointer, not actually used
+ * @buf: where to get the data from
+ * @count: bytes sent
+ * @ppos: where to start
+ *
+ * Returns number of bytes written or error code, as appropriate
+ */
+static ssize_t smk_write_current(struct file *file, const char __user *buf,
+				 size_t count, loff_t *ppos)
+{
+	char *data;
+	int rc = count;
+
+	if (!capable(CAP_MAC_ADMIN))
+		return -EPERM;
+
+	data = kzalloc(count + 1, GFP_KERNEL);
+	if (data == NULL)
+		return -ENOMEM;
+
+	if (copy_from_user(data, buf, count) != 0)
+		rc = -EFAULT;
+	else
+		rc = smk_setcurrent(data, count);
+
+	kfree(data);
+	return rc;
+}
+
+static const struct file_operations smk_current_ops = {
+	.read		= smk_read_current,
+	.write		= smk_write_current,
+	.llseek		= default_llseek,
+};
+
+/**
  * smk_fill_super - fill the /smackfs superblock
  * @sb: the empty superblock
  * @data: unused
@@ -2112,6 +2188,8 @@ static int smk_fill_super(struct super_block *sb, void *data, int silent)
 		[SMK_REVOKE_SUBJ] = {
 			"revoke-subject", &smk_revoke_subj_ops,
 			S_IRUGO|S_IWUSR},
+		[SMK_CURRENT] = {
+			"current", &smk_current_ops, S_IRUGO|S_IWUSR},
 		/* last one */
 			{""}
 	};
diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
index d4f166b..ef0cdcc 100644
--- a/security/tomoyo/common.h
+++ b/security/tomoyo/common.h
@@ -28,6 +28,7 @@
 #include <linux/in.h>
 #include <linux/in6.h>
 #include <linux/un.h>
+#include <linux/lsm.h>
 #include <net/sock.h>
 #include <net/af_unix.h>
 #include <net/ip.h>
@@ -1079,6 +1080,7 @@ extern struct list_head tomoyo_domain_list;
 extern struct list_head tomoyo_name_list[TOMOYO_MAX_HASH];
 extern struct list_head tomoyo_namespace_list;
 extern struct mutex tomoyo_policy_lock;
+extern struct security_operations tomoyo_security_ops;
 extern struct srcu_struct tomoyo_ss;
 extern struct tomoyo_domain_info tomoyo_kernel_domain;
 extern struct tomoyo_policy_namespace tomoyo_kernel_namespace;
@@ -1202,7 +1204,7 @@ static inline void tomoyo_put_group(struct tomoyo_group *group)
  */
 static inline struct tomoyo_domain_info *tomoyo_domain(void)
 {
-	return current_cred()->security;
+	return lsm_get_cred(current_cred(), &tomoyo_security_ops);
 }
 
 /**
@@ -1215,7 +1217,7 @@ static inline struct tomoyo_domain_info *tomoyo_domain(void)
 static inline struct tomoyo_domain_info *tomoyo_real_domain(struct task_struct
 							    *task)
 {
-	return task_cred_xxx(task, security);
+	return lsm_get_cred(__task_cred(task), &tomoyo_security_ops);
 }
 
 /**
diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
index 3865145..15042e7 100644
--- a/security/tomoyo/domain.c
+++ b/security/tomoyo/domain.c
@@ -840,7 +840,7 @@ force_jump_domain:
 		domain = old_domain;
 	/* Update reference count on "struct tomoyo_domain_info". */
 	atomic_inc(&domain->users);
-	bprm->cred->security = domain;
+	lsm_set_cred(bprm->cred, domain, &tomoyo_security_ops);
 	kfree(exename.name);
 	if (!retval) {
 		ee->r.domain = domain;
diff --git a/security/tomoyo/securityfs_if.c b/security/tomoyo/securityfs_if.c
index 8592f2f..37feaf5 100644
--- a/security/tomoyo/securityfs_if.c
+++ b/security/tomoyo/securityfs_if.c
@@ -75,8 +75,10 @@ static ssize_t tomoyo_write_self(struct file *file, const char __user *buf,
 					error = -ENOMEM;
 				} else {
 					struct tomoyo_domain_info *old_domain =
-						cred->security;
-					cred->security = new_domain;
+						lsm_get_cred(cred,
+							&tomoyo_security_ops);
+					lsm_set_cred(cred, new_domain,
+							&tomoyo_security_ops);
 					atomic_inc(&new_domain->users);
 					atomic_dec(&old_domain->users);
 					commit_creds(cred);
@@ -242,7 +244,8 @@ static int __init tomoyo_initerface_init(void)
 	struct dentry *tomoyo_dir;
 
 	/* Don't create securityfs entries unless registered. */
-	if (current_cred()->security != &tomoyo_kernel_domain)
+	if (lsm_get_cred(current_cred(), &tomoyo_security_ops) !=
+			&tomoyo_kernel_domain)
 		return 0;
 
 	tomoyo_dir = securityfs_create_dir("tomoyo", NULL);
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index a2ee362..2b4cade 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -17,7 +17,7 @@
  */
 static int tomoyo_cred_alloc_blank(struct cred *new, gfp_t gfp)
 {
-	new->security = NULL;
+	lsm_set_cred(new, NULL, &tomoyo_security_ops);
 	return 0;
 }
 
@@ -33,8 +33,10 @@ static int tomoyo_cred_alloc_blank(struct cred *new, gfp_t gfp)
 static int tomoyo_cred_prepare(struct cred *new, const struct cred *old,
 			       gfp_t gfp)
 {
-	struct tomoyo_domain_info *domain = old->security;
-	new->security = domain;
+	struct tomoyo_domain_info *domain;
+
+	domain = lsm_get_cred(old, &tomoyo_security_ops);
+	lsm_set_cred(new, domain, &tomoyo_security_ops);
 	if (domain)
 		atomic_inc(&domain->users);
 	return 0;
@@ -58,9 +60,13 @@ static void tomoyo_cred_transfer(struct cred *new, const struct cred *old)
  */
 static void tomoyo_cred_free(struct cred *cred)
 {
-	struct tomoyo_domain_info *domain = cred->security;
-	if (domain)
+	struct tomoyo_domain_info *domain;
+
+	domain = lsm_get_cred(cred, &tomoyo_security_ops);
+	if (domain) {
 		atomic_dec(&domain->users);
+		lsm_set_cred(cred, NULL, &tomoyo_security_ops);
+	}
 }
 
 /**
@@ -98,13 +104,13 @@ static int tomoyo_bprm_set_creds(struct linux_binprm *bprm)
 	 * stored inside "bprm->cred->security" will be acquired later inside
 	 * tomoyo_find_next_domain().
 	 */
-	atomic_dec(&((struct tomoyo_domain_info *)
-		     bprm->cred->security)->users);
+	atomic_dec(&((struct tomoyo_domain_info *)lsm_get_cred(bprm->cred,
+						&tomoyo_security_ops))->users);
 	/*
 	 * Tell tomoyo_bprm_check_security() is called for the first time of an
 	 * execve operation.
 	 */
-	bprm->cred->security = NULL;
+	lsm_set_cred(bprm->cred, NULL, &tomoyo_security_ops);
 	return 0;
 }
 
@@ -117,8 +123,9 @@ static int tomoyo_bprm_set_creds(struct linux_binprm *bprm)
  */
 static int tomoyo_bprm_check_security(struct linux_binprm *bprm)
 {
-	struct tomoyo_domain_info *domain = bprm->cred->security;
+	struct tomoyo_domain_info *domain;
 
+	domain = lsm_get_cred(bprm->cred, &tomoyo_security_ops);
 	/*
 	 * Execute permission is checked against pathname passed to do_execve()
 	 * using current domain.
@@ -503,7 +510,7 @@ static int tomoyo_socket_sendmsg(struct socket *sock, struct msghdr *msg,
  * tomoyo_security_ops is a "struct security_operations" which is used for
  * registering TOMOYO.
  */
-static struct security_operations tomoyo_security_ops = {
+struct security_operations tomoyo_security_ops = {
 	.name                = "tomoyo",
 	.cred_alloc_blank    = tomoyo_cred_alloc_blank,
 	.cred_prepare        = tomoyo_cred_prepare,
@@ -545,16 +552,22 @@ struct srcu_struct tomoyo_ss;
  */
 static int __init tomoyo_init(void)
 {
+	int rc;
 	struct cred *cred = (struct cred *) current_cred();
 
+	/* register ourselves with the security framework */
 	if (!security_module_enable(&tomoyo_security_ops))
 		return 0;
-	/* register ourselves with the security framework */
-	if (register_security(&tomoyo_security_ops) ||
-	    init_srcu_struct(&tomoyo_ss))
+
+	if (init_srcu_struct(&tomoyo_ss))
 		panic("Failure registering TOMOYO Linux");
 	printk(KERN_INFO "TOMOYO Linux initialized\n");
-	cred->security = &tomoyo_kernel_domain;
+
+	rc = lsm_set_init_cred(cred, &tomoyo_kernel_domain,
+				&tomoyo_security_ops);
+	if (rc)
+		panic("Failure allocating credential for TOMOYO Linux");
+
 	tomoyo_mm_init();
 	return 0;
 }
diff --git a/security/yama/Kconfig b/security/yama/Kconfig
index 20ef514..a99aa1d 100644
--- a/security/yama/Kconfig
+++ b/security/yama/Kconfig
@@ -12,10 +12,3 @@ config SECURITY_YAMA
 
 	  If you are unsure how to answer this question, answer N.
 
-config SECURITY_YAMA_STACKED
-	bool "Yama stacked with other LSMs"
-	depends on SECURITY_YAMA
-	default n
-	help
-	  When Yama is built into the kernel, force it to stack with the
-	  selected primary LSM.
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index b4c2984..a68da89 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -324,7 +324,6 @@ int yama_ptrace_traceme(struct task_struct *parent)
 	return rc;
 }
 
-#ifndef CONFIG_SECURITY_YAMA_STACKED
 static struct security_operations yama_ops = {
 	.name =			"yama",
 
@@ -333,7 +332,6 @@ static struct security_operations yama_ops = {
 	.task_prctl =		yama_task_prctl,
 	.task_free =		yama_task_free,
 };
-#endif
 
 #ifdef CONFIG_SYSCTL
 static int yama_dointvec_minmax(struct ctl_table *table, int write,
@@ -380,18 +378,11 @@ static struct ctl_table yama_sysctl_table[] = {
 
 static __init int yama_init(void)
 {
-#ifndef CONFIG_SECURITY_YAMA_STACKED
 	if (!security_module_enable(&yama_ops))
 		return 0;
-#endif
 
 	printk(KERN_INFO "Yama: becoming mindful.\n");
 
-#ifndef CONFIG_SECURITY_YAMA_STACKED
-	if (register_security(&yama_ops))
-		panic("Yama: kernel registration failed.\n");
-#endif
-
 #ifdef CONFIG_SYSCTL
 	if (!register_sysctl_paths(yama_sysctl_path, yama_sysctl_table))
 		panic("Yama: sysctl registration failed.\n");


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
