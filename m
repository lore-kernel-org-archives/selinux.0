Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qAKK9RIT030737
	for <selinux@tycho.nsa.gov>; Tue, 20 Nov 2012 15:09:33 -0500
Message-ID: <50ABE35B.7060103@schaufler-ca.com>
Date: Tue, 20 Nov 2012 12:08:59 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>,
        LSM <linux-security-module@vger.kernel.org>
CC: Casey Schaufler <casey@schaufler-ca.com>, SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Eric Paris <eparis@redhat.com>, Kees Cook <keescook@chromium.org>
Subject: [PATCH v8 1/2] LSM: Multiple concurrent LSMs
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Subject: [PATCH v8 1/2] LSM: Multiple concurrent LSMs

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

 security/security.c                 | 1954 +++++++++++++++++++++++++++++------

diff --git a/security/security.c b/security/security.c
index 8dcd4ae..146883d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -25,30 +25,279 @@
 #include <linux/personality.h>
 #include <linux/backing-dev.h>
 #include <net/flow.h>
+#include <linux/lsm.h>
+#include <linux/shm.h>
+#include <linux/string.h>
 
 #define MAX_LSM_EVM_XATTR	2
 
 /* Boot-time LSM user choice */
-static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
-	CONFIG_DEFAULT_SECURITY;
 
-static struct security_operations *security_ops;
-static struct security_operations default_security_ops = {
-	.name	= "default",
-};
+static __initdata char specified_lsms[COMPOSER_MAX][SECURITY_NAME_MAX + 1];
+static __initdata char allowed_lsms[COMPOSER_NAMES_MAX];
+static __initdata char present_lsm[SECURITY_NAME_MAX + 1] =
+	CONFIG_PRESENT_SECURITY;
+static __initdata int present_lsm_count;
 
-static inline int __init verify(struct security_operations *ops)
+struct list_head lsm_hooks[LSM_MAX_HOOKS];
+struct security_operations *lsm_present;
+static int lsm_count;
+
+#define for_each_hook(SOP, HOOK) \
+	list_for_each_entry(SOP, &lsm_hooks[LSM_##HOOK], list[LSM_##HOOK])
+
+/*
+ * Add an entry to a list of security operation vectors.
+ * The "interesting" logic is included here rather than in the
+ * caller to reduce the volume of the calling code.
+ */
+static void __init lsm_enlist(struct security_operations *ops,
+				const enum lsm_hooks_index index,
+				void *interesting)
 {
-	/* verify the security_operations structure exists */
-	if (!ops)
-		return -EINVAL;
-	security_fixup_ops(ops);
-	return 0;
+	struct security_operations *sop;
+
+	if (!interesting) {
+		INIT_LIST_HEAD(&ops->list[index]);
+		return;
+	}
+
+	if (list_empty(&lsm_hooks[index])) {
+		list_add_rcu(&ops->list[index], &lsm_hooks[index]);
+		return;
+	}
+
+	list_for_each_entry(sop, &lsm_hooks[index], list[index]) {
+		if (ops->order < sop->order) {
+			list_add_tail_rcu(&ops->list[index], &sop->list[index]);
+			return;
+		}
+		if (list_is_last(&sop->list[index], &lsm_hooks[index])) {
+			list_add_rcu(&ops->list[index], &sop->list[index]);
+			return;
+		}
+	}
+}
+
+static void __init lsm_enlist_ops(struct security_operations *sop)
+{
+	lsm_enlist(sop, LSM_ptrace_access_check, sop->ptrace_access_check);
+	lsm_enlist(sop, LSM_ptrace_traceme, sop->ptrace_traceme);
+	lsm_enlist(sop, LSM_capget, sop->capget);
+	lsm_enlist(sop, LSM_capset, sop->capset);
+	lsm_enlist(sop, LSM_capable, sop->capable);
+	lsm_enlist(sop, LSM_quotactl, sop->quotactl);
+	lsm_enlist(sop, LSM_quota_on, sop->quota_on);
+	lsm_enlist(sop, LSM_syslog, sop->syslog);
+	lsm_enlist(sop, LSM_settime, sop->settime);
+	lsm_enlist(sop, LSM_vm_enough_memory, sop->vm_enough_memory);
+	lsm_enlist(sop, LSM_bprm_set_creds, sop->bprm_set_creds);
+	lsm_enlist(sop, LSM_bprm_check_security, sop->bprm_check_security);
+	lsm_enlist(sop, LSM_bprm_committing_creds, sop->bprm_committing_creds);
+	lsm_enlist(sop, LSM_bprm_committed_creds, sop->bprm_committed_creds);
+	lsm_enlist(sop, LSM_bprm_secureexec, sop->bprm_secureexec);
+	lsm_enlist(sop, LSM_sb_alloc_security, sop->sb_alloc_security);
+	lsm_enlist(sop, LSM_sb_free_security, sop->sb_free_security);
+	lsm_enlist(sop, LSM_sb_copy_data, sop->sb_copy_data);
+	lsm_enlist(sop, LSM_sb_remount, sop->sb_remount);
+	lsm_enlist(sop, LSM_sb_kern_mount, sop->sb_kern_mount);
+	lsm_enlist(sop, LSM_sb_show_options, sop->sb_show_options);
+	lsm_enlist(sop, LSM_sb_statfs, sop->sb_statfs);
+	lsm_enlist(sop, LSM_sb_mount, sop->sb_mount);
+	lsm_enlist(sop, LSM_sb_umount, sop->sb_umount);
+	lsm_enlist(sop, LSM_sb_pivotroot, sop->sb_pivotroot);
+	lsm_enlist(sop, LSM_sb_set_mnt_opts, sop->sb_set_mnt_opts);
+	lsm_enlist(sop, LSM_sb_clone_mnt_opts, sop->sb_clone_mnt_opts);
+	lsm_enlist(sop, LSM_sb_parse_opts_str, sop->sb_parse_opts_str);
+	lsm_enlist(sop, LSM_inode_alloc_security, sop->inode_alloc_security);
+	lsm_enlist(sop, LSM_inode_free_security, sop->inode_free_security);
+	lsm_enlist(sop, LSM_inode_init_security, sop->inode_init_security);
+#ifdef CONFIG_SECURITY_PATH
+	lsm_enlist(sop, LSM_path_mknod, sop->path_mknod);
+	lsm_enlist(sop, LSM_path_mkdir, sop->path_mkdir);
+	lsm_enlist(sop, LSM_path_rmdir, sop->path_rmdir);
+	lsm_enlist(sop, LSM_path_unlink, sop->path_unlink);
+	lsm_enlist(sop, LSM_path_symlink, sop->path_symlink);
+	lsm_enlist(sop, LSM_path_link, sop->path_link);
+	lsm_enlist(sop, LSM_path_rename, sop->path_rename);
+	lsm_enlist(sop, LSM_path_truncate, sop->path_truncate);
+	lsm_enlist(sop, LSM_path_chmod, sop->path_chmod);
+	lsm_enlist(sop, LSM_path_chown, sop->path_chown);
+	lsm_enlist(sop, LSM_path_chroot, sop->path_chroot);
+#endif
+	lsm_enlist(sop, LSM_inode_create, sop->inode_create);
+	lsm_enlist(sop, LSM_inode_link, sop->inode_link);
+	lsm_enlist(sop, LSM_inode_unlink, sop->inode_unlink);
+	lsm_enlist(sop, LSM_inode_symlink, sop->inode_symlink);
+	lsm_enlist(sop, LSM_inode_mkdir, sop->inode_mkdir);
+	lsm_enlist(sop, LSM_inode_rmdir, sop->inode_rmdir);
+	lsm_enlist(sop, LSM_inode_mknod, sop->inode_mknod);
+	lsm_enlist(sop, LSM_inode_rename, sop->inode_rename);
+	lsm_enlist(sop, LSM_inode_readlink, sop->inode_readlink);
+	lsm_enlist(sop, LSM_inode_follow_link, sop->inode_follow_link);
+	lsm_enlist(sop, LSM_inode_permission, sop->inode_permission);
+	lsm_enlist(sop, LSM_inode_setattr, sop->inode_setattr);
+	lsm_enlist(sop, LSM_inode_getattr, sop->inode_getattr);
+	lsm_enlist(sop, LSM_inode_setxattr, sop->inode_setxattr);
+	lsm_enlist(sop, LSM_inode_post_setxattr, sop->inode_post_setxattr);
+	lsm_enlist(sop, LSM_inode_getxattr, sop->inode_getxattr);
+	lsm_enlist(sop, LSM_inode_listxattr, sop->inode_listxattr);
+	lsm_enlist(sop, LSM_inode_removexattr, sop->inode_removexattr);
+	lsm_enlist(sop, LSM_inode_need_killpriv, sop->inode_need_killpriv);
+	lsm_enlist(sop, LSM_inode_killpriv, sop->inode_killpriv);
+	lsm_enlist(sop, LSM_inode_getsecurity, sop->inode_getsecurity);
+	lsm_enlist(sop, LSM_inode_setsecurity, sop->inode_setsecurity);
+	lsm_enlist(sop, LSM_inode_listsecurity, sop->inode_listsecurity);
+	lsm_enlist(sop, LSM_inode_getsecid, sop->inode_getsecid);
+	lsm_enlist(sop, LSM_file_permission, sop->file_permission);
+	lsm_enlist(sop, LSM_file_alloc_security, sop->file_alloc_security);
+	lsm_enlist(sop, LSM_file_free_security, sop->file_free_security);
+	lsm_enlist(sop, LSM_file_ioctl, sop->file_ioctl);
+	lsm_enlist(sop, LSM_mmap_file, sop->mmap_file);
+	lsm_enlist(sop, LSM_mmap_addr, sop->mmap_addr);
+	lsm_enlist(sop, LSM_file_mprotect, sop->file_mprotect);
+	lsm_enlist(sop, LSM_file_lock, sop->file_lock);
+	lsm_enlist(sop, LSM_file_fcntl, sop->file_fcntl);
+	lsm_enlist(sop, LSM_file_set_fowner, sop->file_set_fowner);
+	lsm_enlist(sop, LSM_file_send_sigiotask, sop->file_send_sigiotask);
+	lsm_enlist(sop, LSM_file_receive, sop->file_receive);
+	lsm_enlist(sop, LSM_file_open, sop->file_open);
+	lsm_enlist(sop, LSM_task_create, sop->task_create);
+	lsm_enlist(sop, LSM_task_free, sop->task_free);
+	lsm_enlist(sop, LSM_cred_alloc_blank, sop->cred_alloc_blank);
+	lsm_enlist(sop, LSM_cred_free, sop->cred_free);
+	lsm_enlist(sop, LSM_cred_prepare, sop->cred_prepare);
+	lsm_enlist(sop, LSM_cred_transfer, sop->cred_transfer);
+	lsm_enlist(sop, LSM_kernel_act_as, sop->kernel_act_as);
+	lsm_enlist(sop, LSM_kernel_create_files_as,
+			sop->kernel_create_files_as);
+	lsm_enlist(sop, LSM_kernel_module_request, sop->kernel_module_request);
+	lsm_enlist(sop, LSM_task_fix_setuid, sop->task_fix_setuid);
+	lsm_enlist(sop, LSM_task_setpgid, sop->task_setpgid);
+	lsm_enlist(sop, LSM_task_getpgid, sop->task_getpgid);
+	lsm_enlist(sop, LSM_task_getsid, sop->task_getsid);
+	lsm_enlist(sop, LSM_task_getsecid, sop->task_getsecid);
+	lsm_enlist(sop, LSM_task_setnice, sop->task_setnice);
+	lsm_enlist(sop, LSM_task_setioprio, sop->task_setioprio);
+	lsm_enlist(sop, LSM_task_getioprio, sop->task_getioprio);
+	lsm_enlist(sop, LSM_task_setrlimit, sop->task_setrlimit);
+	lsm_enlist(sop, LSM_task_setscheduler, sop->task_setscheduler);
+	lsm_enlist(sop, LSM_task_getscheduler, sop->task_getscheduler);
+	lsm_enlist(sop, LSM_task_movememory, sop->task_movememory);
+	lsm_enlist(sop, LSM_task_kill, sop->task_kill);
+	lsm_enlist(sop, LSM_task_wait, sop->task_wait);
+	lsm_enlist(sop, LSM_task_prctl, sop->task_prctl);
+	lsm_enlist(sop, LSM_task_to_inode, sop->task_to_inode);
+	lsm_enlist(sop, LSM_ipc_permission, sop->ipc_permission);
+	lsm_enlist(sop, LSM_ipc_getsecid, sop->ipc_getsecid);
+	lsm_enlist(sop, LSM_msg_msg_alloc_security,
+			sop->msg_msg_alloc_security);
+	lsm_enlist(sop, LSM_msg_msg_free_security, sop->msg_msg_free_security);
+	lsm_enlist(sop, LSM_msg_queue_alloc_security,
+			sop->msg_queue_alloc_security);
+	lsm_enlist(sop, LSM_msg_queue_free_security,
+			sop->msg_queue_free_security);
+	lsm_enlist(sop, LSM_msg_queue_associate, sop->msg_queue_associate);
+	lsm_enlist(sop, LSM_msg_queue_msgctl, sop->msg_queue_msgctl);
+	lsm_enlist(sop, LSM_msg_queue_msgsnd, sop->msg_queue_msgsnd);
+	lsm_enlist(sop, LSM_msg_queue_msgrcv, sop->msg_queue_msgrcv);
+	lsm_enlist(sop, LSM_shm_alloc_security, sop->shm_alloc_security);
+	lsm_enlist(sop, LSM_shm_free_security, sop->shm_free_security);
+	lsm_enlist(sop, LSM_shm_associate, sop->shm_associate);
+	lsm_enlist(sop, LSM_shm_shmctl, sop->shm_shmctl);
+	lsm_enlist(sop, LSM_shm_shmat, sop->shm_shmat);
+	lsm_enlist(sop, LSM_sem_alloc_security, sop->sem_alloc_security);
+	lsm_enlist(sop, LSM_sem_free_security, sop->sem_free_security);
+	lsm_enlist(sop, LSM_sem_associate, sop->sem_associate);
+	lsm_enlist(sop, LSM_sem_semctl, sop->sem_semctl);
+	lsm_enlist(sop, LSM_sem_semop, sop->sem_semop);
+	lsm_enlist(sop, LSM_d_instantiate, sop->d_instantiate);
+	lsm_enlist(sop, LSM_getprocattr, sop->getprocattr);
+	lsm_enlist(sop, LSM_setprocattr, sop->setprocattr);
+	lsm_enlist(sop, LSM_netlink_send, sop->netlink_send);
+	lsm_enlist(sop, LSM_secid_to_secctx, sop->secid_to_secctx);
+	lsm_enlist(sop, LSM_secctx_to_secid, sop->secctx_to_secid);
+	lsm_enlist(sop, LSM_release_secctx, sop->release_secctx);
+	lsm_enlist(sop, LSM_inode_notifysecctx, sop->inode_notifysecctx);
+	lsm_enlist(sop, LSM_inode_setsecctx, sop->inode_setsecctx);
+	lsm_enlist(sop, LSM_inode_getsecctx, sop->inode_getsecctx);
+#ifdef CONFIG_SECURITY_NETWORK
+	lsm_enlist(sop, LSM_unix_stream_connect, sop->unix_stream_connect);
+	lsm_enlist(sop, LSM_unix_may_send, sop->unix_may_send);
+	lsm_enlist(sop, LSM_socket_create, sop->socket_create);
+	lsm_enlist(sop, LSM_socket_post_create, sop->socket_post_create);
+	lsm_enlist(sop, LSM_socket_bind, sop->socket_bind);
+	lsm_enlist(sop, LSM_socket_connect, sop->socket_connect);
+	lsm_enlist(sop, LSM_socket_listen, sop->socket_listen);
+	lsm_enlist(sop, LSM_socket_accept, sop->socket_accept);
+	lsm_enlist(sop, LSM_socket_sendmsg, sop->socket_sendmsg);
+	lsm_enlist(sop, LSM_socket_recvmsg, sop->socket_recvmsg);
+	lsm_enlist(sop, LSM_socket_getsockname, sop->socket_getsockname);
+	lsm_enlist(sop, LSM_socket_getpeername, sop->socket_getpeername);
+	lsm_enlist(sop, LSM_socket_getsockopt, sop->socket_getsockopt);
+	lsm_enlist(sop, LSM_socket_setsockopt, sop->socket_setsockopt);
+	lsm_enlist(sop, LSM_socket_shutdown, sop->socket_shutdown);
+	lsm_enlist(sop, LSM_socket_sock_rcv_skb, sop->socket_sock_rcv_skb);
+	lsm_enlist(sop, LSM_socket_getpeersec_stream,
+			sop->socket_getpeersec_stream);
+	lsm_enlist(sop, LSM_socket_getpeersec_dgram,
+			sop->socket_getpeersec_dgram);
+	lsm_enlist(sop, LSM_sk_alloc_security, sop->sk_alloc_security);
+	lsm_enlist(sop, LSM_sk_free_security, sop->sk_free_security);
+	lsm_enlist(sop, LSM_sk_clone_security, sop->sk_clone_security);
+	lsm_enlist(sop, LSM_req_classify_flow, sop->req_classify_flow);
+	lsm_enlist(sop, LSM_sock_graft, sop->sock_graft);
+	lsm_enlist(sop, LSM_inet_conn_request, sop->inet_conn_request);
+	lsm_enlist(sop, LSM_inet_csk_clone, sop->inet_csk_clone);
+	lsm_enlist(sop, LSM_inet_conn_established, sop->inet_conn_established);
+	lsm_enlist(sop, LSM_secmark_relabel_packet,
+			sop->secmark_relabel_packet);
+	lsm_enlist(sop, LSM_secmark_refcount_inc, sop->secmark_refcount_inc);
+	lsm_enlist(sop, LSM_secmark_refcount_dec, sop->secmark_refcount_dec);
+	lsm_enlist(sop, LSM_tun_dev_create, sop->tun_dev_create);
+	lsm_enlist(sop, LSM_tun_dev_post_create, sop->tun_dev_post_create);
+	lsm_enlist(sop, LSM_tun_dev_attach, sop->tun_dev_attach);
+#endif
+#ifdef CONFIG_SECURITY_NETWORK_XFRM
+	lsm_enlist(sop, LSM_xfrm_policy_alloc_security,
+			sop->xfrm_policy_alloc_security);
+	lsm_enlist(sop, LSM_xfrm_policy_clone_security,
+			sop->xfrm_policy_clone_security);
+	lsm_enlist(sop, LSM_xfrm_policy_free_security,
+			sop->xfrm_policy_free_security);
+	lsm_enlist(sop, LSM_xfrm_policy_delete_security,
+			sop->xfrm_policy_delete_security);
+	lsm_enlist(sop, LSM_xfrm_state_alloc_security,
+			sop->xfrm_state_alloc_security);
+	lsm_enlist(sop, LSM_xfrm_state_delete_security,
+			sop->xfrm_state_delete_security);
+	lsm_enlist(sop, LSM_xfrm_state_free_security,
+			sop->xfrm_state_free_security);
+	lsm_enlist(sop, LSM_xfrm_policy_lookup, sop->xfrm_policy_lookup);
+	lsm_enlist(sop, LSM_xfrm_state_pol_flow_match,
+			sop->xfrm_state_pol_flow_match);
+	lsm_enlist(sop, LSM_xfrm_decode_session, sop->xfrm_decode_session);
+#endif
+#ifdef CONFIG_KEYS
+	lsm_enlist(sop, LSM_key_alloc, sop->key_alloc);
+	lsm_enlist(sop, LSM_key_free, sop->key_free);
+	lsm_enlist(sop, LSM_key_permission, sop->key_permission);
+	lsm_enlist(sop, LSM_key_getsecurity, sop->key_getsecurity);
+#endif
+#ifdef CONFIG_AUDIT
+	lsm_enlist(sop, LSM_audit_rule_init, sop->audit_rule_init);
+	lsm_enlist(sop, LSM_audit_rule_known, sop->audit_rule_known);
+	lsm_enlist(sop, LSM_audit_rule_free, sop->audit_rule_free);
+	lsm_enlist(sop, LSM_audit_rule_match, sop->audit_rule_match);
+#endif
+
+	lsm_enlist(sop, LSM_name, sop->name);
 }
 
 static void __init do_security_initcalls(void)
 {
 	initcall_t *call;
+
 	call = __security_initcall_start;
 	while (call < __security_initcall_end) {
 		(*call) ();
@@ -63,24 +312,70 @@ static void __init do_security_initcalls(void)
  */
 int __init security_init(void)
 {
-	printk(KERN_INFO "Security Framework initialized\n");
+	enum lsm_hooks_index i;
+
+	for (i = 0; i < LSM_MAX_HOOKS; i++)
+		INIT_LIST_HEAD(&lsm_hooks[i]);
+
+	pr_info("Security Framework initialized\n");
 
-	security_fixup_ops(&default_security_ops);
-	security_ops = &default_security_ops;
 	do_security_initcalls();
 
 	return 0;
 }
 
-void reset_security_ops(void)
+/*
+ * Only SELinux calls reset_security_ops.
+ */
+#ifdef CONFIG_SECURITY_SELINUX_DISABLE
+
+static void lsm_delist_ops(struct security_operations *sop)
 {
-	security_ops = &default_security_ops;
+	enum lsm_hooks_index i;
+
+	for (i = 0; i < LSM_MAX_HOOKS; i++)
+		if (sop->list[i].next && !list_empty(&sop->list[i]))
+			list_del_rcu(&sop->list[i]);
+	return;
+}
+
+int reset_security_ops(struct security_operations *ops)
+{
+	/*
+	 * This LSM is configured to own /proc/.../attr.
+	 */
+	if (lsm_present == ops)
+		lsm_present = NULL;
+
+	lsm_delist_ops(ops);
+
+	return 0;
 }
+#endif /* CONFIG_SECURITY_SELINUX_DISABLE */
 
-/* Save user chosen LSM */
+/* Save user chosen LSM(s) */
 static int __init choose_lsm(char *str)
 {
-	strncpy(chosen_lsm, str, SECURITY_NAME_MAX);
+	char *cp;
+	char *ep;
+	int i;
+
+	strncpy(allowed_lsms, str, COMPOSER_NAMES_MAX);
+	cp = allowed_lsms;
+
+	for (i = 0; i < COMPOSER_MAX; i++) {
+		ep = strchr(cp, ',');
+		if (ep != NULL)
+			*ep = '\0';
+		if (strlen(cp) > SECURITY_NAME_MAX)
+			pr_warn("LSM \"%s\" is invalid and ignored.\n", cp);
+		else
+			strncpy(specified_lsms[i], cp, SECURITY_NAME_MAX);
+		if (ep == NULL)
+			break;
+		cp = ep + 1;
+	}
+
 	return 1;
 }
 __setup("security=", choose_lsm);
@@ -94,66 +389,211 @@ __setup("security=", choose_lsm);
  * to check if your LSM is currently loaded during kernel initialization.
  *
  * Return true if:
- *	-The passed LSM is the one chosen by user at boot time,
- *	-or the passed LSM is configured as the default and the user did not
- *	 choose an alternate LSM at boot time.
+ *	-The passed LSM is on the list of LSMs specified at boot time,
+ *	-or no boot list was specified.
  * Otherwise, return false.
  */
 int __init security_module_enable(struct security_operations *ops)
 {
-	return !strcmp(ops->name, chosen_lsm);
-}
+	struct security_operations *sop;
+	int i;
 
-/**
- * register_security - registers a security framework with the kernel
- * @ops: a pointer to the struct security_options that is to be registered
- *
- * This function allows a security module to register itself with the
- * kernel security subsystem.  Some rudimentary checking is done on the @ops
- * value passed to this function. You'll need to check first if your LSM
- * is allowed to register its @ops by calling security_module_enable(@ops).
- *
- * If there is already a security module registered with the kernel,
- * an error will be returned.  Otherwise %0 is returned on success.
- */
-int __init register_security(struct security_operations *ops)
-{
-	if (verify(ops)) {
-		printk(KERN_DEBUG "%s could not verify "
-		       "security_operations structure.\n", __func__);
-		return -EINVAL;
+	if (lsm_count >= COMPOSER_MAX) {
+		pr_warn("Too many security modules. %s not loaded.\n",
+				ops->name);
+		return 0;
+	}
+	/*
+	 * Set up the operation vector early, but only once.
+	 * This allows LSM specific file systems to check to see if they
+	 * should come on line.
+	 */
+	if (ops == NULL) {
+		pr_debug("%s could not verify security_operations.\n",
+				__func__);
+		return 0;
+	}
+	/*
+	 * Return success if the LSM is already resistered
+	 */
+	for_each_hook(sop, name)
+		if (sop == ops)
+			return 1;
+
+	if (specified_lsms[0][0] != '\0') {
+		ops->order = 0;
+		for (i = 0; specified_lsms[i][0] != '\0'; i++) {
+			if (strcmp(ops->name, specified_lsms[i]) == 0) {
+				ops->order = i + 1;
+				break;
+			}
+		}
+		if (ops->order == 0) {
+			pr_notice("LSM %s declined by boot options.\n",
+					ops->name);
+			return 0;
+		}
+	}
+	/*
+	 * Check for conflicting LSMs.
+	 */
+#ifdef CONFIG_SECURITY_NETWORK_XFRM
+	if (ops->xfrm_policy_alloc_security &&
+	    !list_empty(&lsm_hooks[LSM_xfrm_policy_alloc_security])) {
+		pr_warn("LSM conflict on %s. %s not loaded.\n",
+				"xfrm_policy_alloc_security", ops->name);
+		return 0;
+	}
+#endif
+	if (ops->secid_to_secctx &&
+	    !list_empty(&lsm_hooks[LSM_secid_to_secctx])) {
+		pr_warn("LSM conflict on %s. %s not loaded.\n",
+			"secid_to_secctx", ops->name);
+		return 0;
 	}
 
-	if (security_ops != &default_security_ops)
-		return -EAGAIN;
+	/*
+	 * The order will already be set if the command line
+	 * includes "security=".
+	 *
+	 * Do this before the enlisting. If there is an error
+	 * (Very unlikely!) that prevents the enlisting from
+	 * completing it is still necessary to have a blob slot
+	 * for it.
+	 */
+	lsm_count++;
+	if (ops->order == 0)
+		ops->order = lsm_count;
 
-	security_ops = ops;
+	/*
+	 * If there is an explict "present=" and that LSM registers
+	 * use it in [gs]etprocattr.
+	 *
+	 * If it isn't specified, or never registers, and there is
+	 * exactly one LSM that provides [gs]etprocattr use that
+	 * LSM as the presenter.
+	 */
+	if (!strcmp(ops->name, present_lsm)) {
+		present_lsm_count = -1;
+		lsm_present = ops;
+	} else if (present_lsm_count >= 0 &&
+		   (ops->setprocattr || ops->getprocattr)) {
+		present_lsm_count++;
+		if (present_lsm_count == 1)
+			lsm_present = ops;
+		else
+			lsm_present = NULL;
+	}
 
-	return 0;
+	/*
+	 * Return success after registering the LSM.
+	 */
+	lsm_enlist_ops(ops);
+
+	return 1;
 }
 
 /* Security operations */
 
+#ifdef CONFIG_SECURITY_COMPOSER_DEBUG
+static void lsm_blob_cleanup(int rc, struct lsm_blob *bp, const char *fn)
+{
+	int i;
+
+	if (rc != -ENOMEM && rc != 0)
+		pr_warn("%s lsm error %d unexpected\n", fn, -rc);
+	if (bp->lsm_setcount != 0) {
+		pr_warn("%s lsm counting error %d unexpected\n",
+			fn, bp->lsm_setcount);
+		for (i = 1; i < lsm_count; i++)
+			if (bp->lsm_blobs[i] != NULL)
+				pr_warn("%s lsm %d blob was not free.\n",
+					fn, i);
+		bp->lsm_setcount = 0;
+	}
+}
+#else /* CONFIG_SECURITY_COMPOSER_DEBUG */
+static inline void lsm_blob_cleanup(int rc, struct lsm_blob *bp, const char *fn)
+{
+}
+#endif /* CONFIG_SECURITY_COMPOSER_DEBUG */
+
+/*
+ * Because so many of the cases are treated the same.
+ */
+#define call_void_hook(FUNC, ...)					\
+	do {								\
+		struct security_operations *sop;			\
+									\
+		list_for_each_entry(sop, &lsm_hooks[LSM_##FUNC],	\
+					list[LSM_##FUNC])		\
+			sop->FUNC(__VA_ARGS__);				\
+	} while (0)							\
+
+#define call_int_hook(RC, FUNC, ...)					\
+	do {								\
+		struct security_operations *sop;			\
+		int thisrc;						\
+									\
+		list_for_each_entry(sop, &lsm_hooks[LSM_##FUNC],	\
+					list[LSM_##FUNC]) {		\
+			thisrc = sop->FUNC(__VA_ARGS__);		\
+			if (thisrc)					\
+				RC = thisrc;				\
+		}							\
+	} while (0)							\
+
+
+#define call_alloc_hook(RC, ALLOC, FREE, FIELD, GFP, ARG)		\
+	do {								\
+		struct security_operations *sop;			\
+		struct security_operations *note[COMPOSER_MAX];		\
+		struct lsm_blob tblob;					\
+		struct lsm_blob *bp = NULL;				\
+		int successes = 0;					\
+									\
+		memset(&tblob, 0, sizeof(tblob));			\
+		FIELD = &tblob;						\
+		for_each_hook(sop, ALLOC) {				\
+			RC = sop->ALLOC(ARG);				\
+			if (RC)						\
+				break;					\
+			note[successes++] = sop;			\
+		}							\
+		if (tblob.lsm_setcount != 0) {				\
+			if (RC == 0)					\
+				bp = kmemdup(&tblob, sizeof(tblob), GFP); \
+			if (bp == NULL) {				\
+				if (RC == 0)				\
+					RC = -ENOMEM;			\
+				while (successes > 0)			\
+					note[--successes]->FREE(ARG);	\
+				lsm_blob_cleanup(RC, &tblob, __func__);	\
+			}						\
+		}							\
+		FIELD = bp;						\
+	} while (0)							\
+
 int security_ptrace_access_check(struct task_struct *child, unsigned int mode)
 {
-#ifdef CONFIG_SECURITY_YAMA_STACKED
-	int rc;
-	rc = yama_ptrace_access_check(child, mode);
-	if (rc)
-		return rc;
-#endif
-	return security_ops->ptrace_access_check(child, mode);
+	int rc = 0;
+
+	if (list_empty(&lsm_hooks[LSM_ptrace_access_check]))
+		return cap_ptrace_access_check(child, mode);
+
+	call_int_hook(rc, ptrace_access_check, child, mode);
+	return rc;
 }
 
 int security_ptrace_traceme(struct task_struct *parent)
 {
-#ifdef CONFIG_SECURITY_YAMA_STACKED
-	int rc;
-	rc = yama_ptrace_traceme(parent);
-	if (rc)
-		return rc;
-#endif
-	return security_ops->ptrace_traceme(parent);
+	int rc = 0;
+
+	if (list_empty(&lsm_hooks[LSM_ptrace_traceme]))
+		return cap_ptrace_traceme(parent);
+
+	call_int_hook(rc, ptrace_traceme, parent);
+	return rc;
 }
 
 int security_capget(struct task_struct *target,
@@ -161,7 +601,13 @@ int security_capget(struct task_struct *target,
 		     kernel_cap_t *inheritable,
 		     kernel_cap_t *permitted)
 {
-	return security_ops->capget(target, effective, inheritable, permitted);
+	int rc = 0;
+
+	if (list_empty(&lsm_hooks[LSM_capget]))
+		return cap_capget(target, effective, inheritable, permitted);
+
+	call_int_hook(rc, capget, target, effective, inheritable, permitted);
+	return rc;
 }
 
 int security_capset(struct cred *new, const struct cred *old,
@@ -169,195 +615,306 @@ int security_capset(struct cred *new, const struct cred *old,
 		    const kernel_cap_t *inheritable,
 		    const kernel_cap_t *permitted)
 {
-	return security_ops->capset(new, old,
-				    effective, inheritable, permitted);
+	int rc = 0;
+
+	if (list_empty(&lsm_hooks[LSM_capset]))
+		return cap_capset(new, old, effective, inheritable, permitted);
+
+	call_int_hook(rc, capset, new, old, effective, inheritable, permitted);
+	return rc;
 }
 
 int security_capable(const struct cred *cred, struct user_namespace *ns,
 		     int cap)
 {
-	return security_ops->capable(cred, ns, cap, SECURITY_CAP_AUDIT);
+	int rc = 0;
+
+	if (list_empty(&lsm_hooks[LSM_capable]))
+		return cap_capable(cred, ns, cap, SECURITY_CAP_AUDIT);
+
+	call_int_hook(rc, capable, cred, ns, cap, SECURITY_CAP_AUDIT);
+	return rc;
 }
 
 int security_capable_noaudit(const struct cred *cred, struct user_namespace *ns,
 			     int cap)
 {
-	return security_ops->capable(cred, ns, cap, SECURITY_CAP_NOAUDIT);
+	int rc = 0;
+
+	if (list_empty(&lsm_hooks[LSM_capable]))
+		return cap_capable(cred, ns, cap, SECURITY_CAP_NOAUDIT);
+
+	call_int_hook(rc, capable, cred, ns, cap, SECURITY_CAP_NOAUDIT);
+	return rc;
 }
 
 int security_quotactl(int cmds, int type, int id, struct super_block *sb)
 {
-	return security_ops->quotactl(cmds, type, id, sb);
+	int rc = 0;
+
+	call_int_hook(rc, quotactl, cmds, type, id, sb);
+	return rc;
 }
 
 int security_quota_on(struct dentry *dentry)
 {
-	return security_ops->quota_on(dentry);
+	int rc = 0;
+
+	call_int_hook(rc, quota_on, dentry);
+	return rc;
 }
 
 int security_syslog(int type)
 {
-	return security_ops->syslog(type);
+	int rc = 0;
+
+	call_int_hook(rc, syslog, type);
+	return rc;
 }
 
 int security_settime(const struct timespec *ts, const struct timezone *tz)
 {
-	return security_ops->settime(ts, tz);
+	int rc = 0;
+
+	if (list_empty(&lsm_hooks[LSM_settime]))
+		return cap_settime(ts, tz);
+
+	call_int_hook(rc, settime, ts, tz);
+	return rc;
 }
 
 int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 {
-	return security_ops->vm_enough_memory(mm, pages);
+	int rc = 0;
+
+	if (list_empty(&lsm_hooks[LSM_vm_enough_memory]))
+		return cap_vm_enough_memory(mm, pages);
+
+	call_int_hook(rc, vm_enough_memory, mm, pages);
+	return rc;
 }
 
 int security_bprm_set_creds(struct linux_binprm *bprm)
 {
-	return security_ops->bprm_set_creds(bprm);
+	int rc = 0;
+
+	if (list_empty(&lsm_hooks[LSM_bprm_set_creds]))
+		return cap_bprm_set_creds(bprm);
+
+	call_int_hook(rc, bprm_set_creds, bprm);
+	return rc;
 }
 
 int security_bprm_check(struct linux_binprm *bprm)
 {
-	int ret;
+	int rc = 0;
+
+	call_int_hook(rc, bprm_check_security, bprm);
+
+	if (rc)
+		return rc;
 
-	ret = security_ops->bprm_check_security(bprm);
-	if (ret)
-		return ret;
 	return ima_bprm_check(bprm);
 }
 
+
 void security_bprm_committing_creds(struct linux_binprm *bprm)
 {
-	security_ops->bprm_committing_creds(bprm);
+	call_void_hook(bprm_committing_creds, bprm);
 }
 
 void security_bprm_committed_creds(struct linux_binprm *bprm)
 {
-	security_ops->bprm_committed_creds(bprm);
+	call_void_hook(bprm_committed_creds, bprm);
 }
 
 int security_bprm_secureexec(struct linux_binprm *bprm)
 {
-	return security_ops->bprm_secureexec(bprm);
+	int rc = 0;
+
+	if (list_empty(&lsm_hooks[LSM_bprm_secureexec]))
+		return cap_bprm_secureexec(bprm);
+
+	call_int_hook(rc, bprm_secureexec, bprm);
+	return rc;
 }
 
 int security_sb_alloc(struct super_block *sb)
 {
-	return security_ops->sb_alloc_security(sb);
+	int rc = 0;
+
+	call_alloc_hook(rc, sb_alloc_security, sb_free_security,
+			sb->s_security, GFP_KERNEL, sb);
+	return rc;
 }
 
 void security_sb_free(struct super_block *sb)
 {
-	security_ops->sb_free_security(sb);
+	call_void_hook(sb_free_security, sb);
+
+	lsm_blob_cleanup(0, sb->s_security, __func__);
+	kfree(sb->s_security);
+	sb->s_security = NULL;
 }
 
 int security_sb_copy_data(char *orig, char *copy)
 {
-	return security_ops->sb_copy_data(orig, copy);
+	int rc = 0;
+
+	call_int_hook(rc, sb_copy_data, orig, copy);
+	return rc;
 }
 EXPORT_SYMBOL(security_sb_copy_data);
 
 int security_sb_remount(struct super_block *sb, void *data)
 {
-	return security_ops->sb_remount(sb, data);
+	int rc = 0;
+
+	call_int_hook(rc, sb_remount, sb, data);
+	return rc;
 }
 
 int security_sb_kern_mount(struct super_block *sb, int flags, void *data)
 {
-	return security_ops->sb_kern_mount(sb, flags, data);
+	int rc = 0;
+
+	call_int_hook(rc, sb_kern_mount, sb, flags, data);
+	return rc;
 }
 
 int security_sb_show_options(struct seq_file *m, struct super_block *sb)
 {
-	return security_ops->sb_show_options(m, sb);
+	int rc = 0;
+
+	call_int_hook(rc, sb_show_options, m, sb);
+	return rc;
 }
 
 int security_sb_statfs(struct dentry *dentry)
 {
-	return security_ops->sb_statfs(dentry);
+	int rc = 0;
+
+	call_int_hook(rc, sb_statfs, dentry);
+	return rc;
 }
 
 int security_sb_mount(const char *dev_name, struct path *path,
                        const char *type, unsigned long flags, void *data)
 {
-	return security_ops->sb_mount(dev_name, path, type, flags, data);
+	int rc = 0;
+
+	call_int_hook(rc, sb_mount, dev_name, path, type, flags, data);
+	return rc;
 }
 
 int security_sb_umount(struct vfsmount *mnt, int flags)
 {
-	return security_ops->sb_umount(mnt, flags);
+	int rc = 0;
+
+	call_int_hook(rc, sb_umount, mnt, flags);
+	return rc;
 }
 
 int security_sb_pivotroot(struct path *old_path, struct path *new_path)
 {
-	return security_ops->sb_pivotroot(old_path, new_path);
+	int rc = 0;
+
+	call_int_hook(rc, sb_pivotroot, old_path, new_path);
+	return rc;
 }
 
 int security_sb_set_mnt_opts(struct super_block *sb,
 				struct security_mnt_opts *opts)
 {
-	return security_ops->sb_set_mnt_opts(sb, opts);
+	int rc = 0;
+
+	if (list_empty(&lsm_hooks[LSM_sb_set_mnt_opts])) {
+		if (unlikely(opts->num_mnt_opts))
+			return -EOPNOTSUPP;
+		return 0;
+	}
+
+	call_int_hook(rc, sb_set_mnt_opts, sb, opts);
+	return rc;
 }
 EXPORT_SYMBOL(security_sb_set_mnt_opts);
 
 void security_sb_clone_mnt_opts(const struct super_block *oldsb,
 				struct super_block *newsb)
 {
-	security_ops->sb_clone_mnt_opts(oldsb, newsb);
+	call_void_hook(sb_clone_mnt_opts, oldsb, newsb);
 }
 EXPORT_SYMBOL(security_sb_clone_mnt_opts);
 
 int security_sb_parse_opts_str(char *options, struct security_mnt_opts *opts)
 {
-	return security_ops->sb_parse_opts_str(options, opts);
+	int rc = 0;
+
+	call_int_hook(rc, sb_parse_opts_str, options, opts);
+	return rc;
 }
 EXPORT_SYMBOL(security_sb_parse_opts_str);
 
 int security_inode_alloc(struct inode *inode)
 {
-	inode->i_security = NULL;
-	return security_ops->inode_alloc_security(inode);
+	int rc = 0;
+
+	call_alloc_hook(rc, inode_alloc_security, inode_free_security,
+			inode->i_security, GFP_KERNEL, inode);
+	return rc;
 }
 
 void security_inode_free(struct inode *inode)
 {
 	integrity_inode_free(inode);
-	security_ops->inode_free_security(inode);
+
+	call_void_hook(inode_free_security, inode);
+
+	lsm_blob_cleanup(0, inode->i_security, __func__);
+	kfree(inode->i_security);
+	inode->i_security = NULL;
 }
 
 int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const struct qstr *qstr,
 				 const initxattrs initxattrs, void *fs_data)
 {
+	int rc = 0;
 	struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
 	struct xattr *lsm_xattr, *evm_xattr, *xattr;
-	int ret;
 
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
 
 	memset(new_xattrs, 0, sizeof new_xattrs);
-	if (!initxattrs)
-		return security_ops->inode_init_security(inode, dir, qstr,
-							 NULL, NULL, NULL);
+	if (!initxattrs) {
+		call_int_hook(rc, inode_init_security, inode, dir, qstr,
+				NULL, NULL, NULL);
+		return rc;
+	}
+
 	lsm_xattr = new_xattrs;
-	ret = security_ops->inode_init_security(inode, dir, qstr,
-						&lsm_xattr->name,
-						&lsm_xattr->value,
-						&lsm_xattr->value_len);
-	if (ret)
+
+	if (list_empty(&lsm_hooks[LSM_inode_init_security]))
+		rc = -EOPNOTSUPP;
+	else
+		call_int_hook(rc, inode_init_security, inode, dir, qstr,
+			&lsm_xattr->name, &lsm_xattr->value,
+			&lsm_xattr->value_len);
+	if (rc)
 		goto out;
 
 	evm_xattr = lsm_xattr + 1;
-	ret = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
-	if (ret)
+	rc = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
+	if (rc)
 		goto out;
-	ret = initxattrs(inode, new_xattrs, fs_data);
+	rc = initxattrs(inode, new_xattrs, fs_data);
 out:
 	for (xattr = new_xattrs; xattr->name != NULL; xattr++) {
 		kfree(xattr->name);
 		kfree(xattr->value);
 	}
-	return (ret == -EOPNOTSUPP) ? 0 : ret;
+	return (rc == -EOPNOTSUPP) ? 0 : rc;
 }
 EXPORT_SYMBOL(security_inode_init_security);
 
@@ -365,10 +922,14 @@ int security_old_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr, char **name,
 				     void **value, size_t *len)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(inode)))
 		return -EOPNOTSUPP;
-	return security_ops->inode_init_security(inode, dir, qstr, name, value,
-						 len);
+
+	call_int_hook(rc, inode_init_security, inode, dir, qstr, name,
+							value, len);
+	return rc;
 }
 EXPORT_SYMBOL(security_old_inode_init_security);
 
@@ -376,206 +937,300 @@ EXPORT_SYMBOL(security_old_inode_init_security);
 int security_path_mknod(struct path *dir, struct dentry *dentry, umode_t mode,
 			unsigned int dev)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(dir->dentry->d_inode)))
 		return 0;
-	return security_ops->path_mknod(dir, dentry, mode, dev);
+
+	call_int_hook(rc, path_mknod, dir, dentry, mode, dev);
+	return rc;
 }
 EXPORT_SYMBOL(security_path_mknod);
 
 int security_path_mkdir(struct path *dir, struct dentry *dentry, umode_t mode)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(dir->dentry->d_inode)))
 		return 0;
-	return security_ops->path_mkdir(dir, dentry, mode);
+
+	call_int_hook(rc, path_mkdir, dir, dentry, mode);
+	return rc;
 }
 EXPORT_SYMBOL(security_path_mkdir);
 
 int security_path_rmdir(struct path *dir, struct dentry *dentry)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(dir->dentry->d_inode)))
 		return 0;
-	return security_ops->path_rmdir(dir, dentry);
+
+	call_int_hook(rc, path_rmdir, dir, dentry);
+	return rc;
 }
 
 int security_path_unlink(struct path *dir, struct dentry *dentry)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(dir->dentry->d_inode)))
 		return 0;
-	return security_ops->path_unlink(dir, dentry);
+
+	call_int_hook(rc, path_unlink, dir, dentry);
+	return rc;
 }
 EXPORT_SYMBOL(security_path_unlink);
 
 int security_path_symlink(struct path *dir, struct dentry *dentry,
 			  const char *old_name)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(dir->dentry->d_inode)))
 		return 0;
-	return security_ops->path_symlink(dir, dentry, old_name);
+
+	call_int_hook(rc, path_symlink, dir, dentry, old_name);
+	return rc;
 }
 
 int security_path_link(struct dentry *old_dentry, struct path *new_dir,
 		       struct dentry *new_dentry)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(old_dentry->d_inode)))
 		return 0;
-	return security_ops->path_link(old_dentry, new_dir, new_dentry);
+
+	call_int_hook(rc, path_link, old_dentry, new_dir, new_dentry);
+	return rc;
 }
 
 int security_path_rename(struct path *old_dir, struct dentry *old_dentry,
 			 struct path *new_dir, struct dentry *new_dentry)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(old_dentry->d_inode) ||
 		     (new_dentry->d_inode && IS_PRIVATE(new_dentry->d_inode))))
 		return 0;
-	return security_ops->path_rename(old_dir, old_dentry, new_dir,
-					 new_dentry);
+
+	call_int_hook(rc, path_rename, old_dir, old_dentry, new_dir,
+						new_dentry);
+	return rc;
 }
 EXPORT_SYMBOL(security_path_rename);
 
 int security_path_truncate(struct path *path)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(path->dentry->d_inode)))
 		return 0;
-	return security_ops->path_truncate(path);
+
+	call_int_hook(rc, path_truncate, path);
+	return rc;
 }
 
 int security_path_chmod(struct path *path, umode_t mode)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(path->dentry->d_inode)))
 		return 0;
-	return security_ops->path_chmod(path, mode);
+
+	call_int_hook(rc, path_chmod, path, mode);
+	return rc;
 }
 
 int security_path_chown(struct path *path, kuid_t uid, kgid_t gid)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(path->dentry->d_inode)))
 		return 0;
-	return security_ops->path_chown(path, uid, gid);
+
+	call_int_hook(rc, path_chown, path, uid, gid);
+	return rc;
 }
 
 int security_path_chroot(struct path *path)
 {
-	return security_ops->path_chroot(path);
+	int rc = 0;
+
+	call_int_hook(rc, path_chroot, path);
+	return rc;
 }
 #endif
 
 int security_inode_create(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(dir)))
 		return 0;
-	return security_ops->inode_create(dir, dentry, mode);
+
+	call_int_hook(rc, inode_create, dir, dentry, mode);
+	return rc;
 }
 EXPORT_SYMBOL_GPL(security_inode_create);
 
 int security_inode_link(struct dentry *old_dentry, struct inode *dir,
 			 struct dentry *new_dentry)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(old_dentry->d_inode)))
 		return 0;
-	return security_ops->inode_link(old_dentry, dir, new_dentry);
+
+	call_int_hook(rc, inode_link, old_dentry, dir, new_dentry);
+	return rc;
 }
 
 int security_inode_unlink(struct inode *dir, struct dentry *dentry)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(dentry->d_inode)))
 		return 0;
-	return security_ops->inode_unlink(dir, dentry);
+
+	call_int_hook(rc, inode_unlink, dir, dentry);
+	return rc;
 }
 
 int security_inode_symlink(struct inode *dir, struct dentry *dentry,
 			    const char *old_name)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(dir)))
 		return 0;
-	return security_ops->inode_symlink(dir, dentry, old_name);
+
+	call_int_hook(rc, inode_symlink, dir, dentry, old_name);
+	return rc;
 }
 
 int security_inode_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(dir)))
 		return 0;
-	return security_ops->inode_mkdir(dir, dentry, mode);
+
+	call_int_hook(rc, inode_mkdir, dir, dentry, mode);
+	return rc;
 }
 EXPORT_SYMBOL_GPL(security_inode_mkdir);
 
 int security_inode_rmdir(struct inode *dir, struct dentry *dentry)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(dentry->d_inode)))
 		return 0;
-	return security_ops->inode_rmdir(dir, dentry);
+
+	call_int_hook(rc, inode_rmdir, dir, dentry);
+	return rc;
 }
 
 int security_inode_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(dir)))
 		return 0;
-	return security_ops->inode_mknod(dir, dentry, mode, dev);
+
+	call_int_hook(rc, inode_mknod, dir, dentry, mode, dev);
+	return rc;
 }
 
 int security_inode_rename(struct inode *old_dir, struct dentry *old_dentry,
 			   struct inode *new_dir, struct dentry *new_dentry)
 {
+	int rc = 0;
+
         if (unlikely(IS_PRIVATE(old_dentry->d_inode) ||
             (new_dentry->d_inode && IS_PRIVATE(new_dentry->d_inode))))
 		return 0;
-	return security_ops->inode_rename(old_dir, old_dentry,
-					   new_dir, new_dentry);
+
+	call_int_hook(rc, inode_rename, old_dir, old_dentry, new_dir,
+						new_dentry);
+	return rc;
 }
 
 int security_inode_readlink(struct dentry *dentry)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(dentry->d_inode)))
 		return 0;
-	return security_ops->inode_readlink(dentry);
+
+	call_int_hook(rc, inode_readlink, dentry);
+	return rc;
 }
 
 int security_inode_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(dentry->d_inode)))
 		return 0;
-	return security_ops->inode_follow_link(dentry, nd);
+
+	call_int_hook(rc, inode_follow_link, dentry, nd);
+	return rc;
 }
 
 int security_inode_permission(struct inode *inode, int mask)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
-	return security_ops->inode_permission(inode, mask);
+
+	call_int_hook(rc, inode_permission, inode, mask);
+	return rc;
 }
 
 int security_inode_setattr(struct dentry *dentry, struct iattr *attr)
 {
-	int ret;
+	int rc = 0;
 
 	if (unlikely(IS_PRIVATE(dentry->d_inode)))
 		return 0;
-	ret = security_ops->inode_setattr(dentry, attr);
-	if (ret)
-		return ret;
+
+	call_int_hook(rc, inode_setattr, dentry, attr);
+	if (rc)
+		return rc;
 	return evm_inode_setattr(dentry, attr);
 }
 EXPORT_SYMBOL_GPL(security_inode_setattr);
 
 int security_inode_getattr(struct vfsmount *mnt, struct dentry *dentry)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(dentry->d_inode)))
 		return 0;
-	return security_ops->inode_getattr(mnt, dentry);
+
+	call_int_hook(rc, inode_getattr, mnt, dentry);
+	return rc;
 }
 
 int security_inode_setxattr(struct dentry *dentry, const char *name,
 			    const void *value, size_t size, int flags)
 {
-	int ret;
+	int rc = 0;
 
 	if (unlikely(IS_PRIVATE(dentry->d_inode)))
 		return 0;
-	ret = security_ops->inode_setxattr(dentry, name, value, size, flags);
-	if (ret)
-		return ret;
-	ret = ima_inode_setxattr(dentry, name, value, size);
-	if (ret)
-		return ret;
+
+	call_int_hook(rc, inode_setxattr, dentry, name, value, size, flags);
+
+	if (rc)
+		return rc;
+	rc = ima_inode_setxattr(dentry, name, value, size);
+	if (rc)
+		return rc;
 	return evm_inode_setxattr(dentry, name, value, size);
 }
 
@@ -584,99 +1239,183 @@ void security_inode_post_setxattr(struct dentry *dentry, const char *name,
 {
 	if (unlikely(IS_PRIVATE(dentry->d_inode)))
 		return;
-	security_ops->inode_post_setxattr(dentry, name, value, size, flags);
+
+	call_void_hook(inode_post_setxattr, dentry, name, value, size, flags);
+
 	evm_inode_post_setxattr(dentry, name, value, size);
 }
 
 int security_inode_getxattr(struct dentry *dentry, const char *name)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(dentry->d_inode)))
 		return 0;
-	return security_ops->inode_getxattr(dentry, name);
+
+	call_int_hook(rc, inode_getxattr, dentry, name);
+	return rc;
 }
 
 int security_inode_listxattr(struct dentry *dentry)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(dentry->d_inode)))
 		return 0;
-	return security_ops->inode_listxattr(dentry);
+
+	call_int_hook(rc, inode_listxattr, dentry);
+	return rc;
 }
 
 int security_inode_removexattr(struct dentry *dentry, const char *name)
 {
-	int ret;
+	int rc = 0;
 
 	if (unlikely(IS_PRIVATE(dentry->d_inode)))
 		return 0;
-	ret = security_ops->inode_removexattr(dentry, name);
-	if (ret)
-		return ret;
-	ret = ima_inode_removexattr(dentry, name);
-	if (ret)
-		return ret;
+
+	if (list_empty(&lsm_hooks[LSM_inode_removexattr]))
+		return cap_inode_removexattr(dentry, name);
+
+	call_int_hook(rc, inode_removexattr, dentry, name);
+
+	if (rc)
+		return rc;
+	rc = ima_inode_removexattr(dentry, name);
+	if (rc)
+		return rc;
 	return evm_inode_removexattr(dentry, name);
 }
 
 int security_inode_need_killpriv(struct dentry *dentry)
 {
-	return security_ops->inode_need_killpriv(dentry);
+	int rc = 0;
+
+	if (list_empty(&lsm_hooks[LSM_inode_need_killpriv]))
+		return cap_inode_need_killpriv(dentry);
+
+	call_int_hook(rc, inode_need_killpriv, dentry);
+	return rc;
 }
 
 int security_inode_killpriv(struct dentry *dentry)
 {
-	return security_ops->inode_killpriv(dentry);
+	int rc = 0;
+
+	if (list_empty(&lsm_hooks[LSM_inode_killpriv]))
+		return cap_inode_killpriv(dentry);
+
+	call_int_hook(rc, inode_killpriv, dentry);
+	return rc;
 }
 
 int security_inode_getsecurity(const struct inode *inode, const char *name, void **buffer, bool alloc)
 {
+	struct security_operations *sop;
+	int rc;
+
 	if (unlikely(IS_PRIVATE(inode)))
 		return -EOPNOTSUPP;
-	return security_ops->inode_getsecurity(inode, name, buffer, alloc);
+
+	/*
+	 * Only one LSM will supply a given "name".
+	 * -EOPNOTSUPP is an indication that the LSM does not
+	 * provide a value for the provided name.
+	 */
+	for_each_hook(sop, inode_getsecurity) {
+		rc = sop->inode_getsecurity(inode, name, buffer, alloc);
+		if (rc != -EOPNOTSUPP)
+			return rc;
+	}
+	return -EOPNOTSUPP;
 }
 
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
 {
+	struct security_operations *sop;
+	int rc;
+
 	if (unlikely(IS_PRIVATE(inode)))
 		return -EOPNOTSUPP;
-	return security_ops->inode_setsecurity(inode, name, value, size, flags);
+
+	/*
+	 * Only one LSM will set a given "name".
+	 * -EOPNOTSUPP is an indication that the LSM does not
+	 * set a value for the provided name.
+	 */
+	for_each_hook(sop, inode_setsecurity) {
+		rc = sop->inode_setsecurity(inode, name, value, size, flags);
+		if (rc != -EOPNOTSUPP)
+			return rc;
+	}
+	return -EOPNOTSUPP;
 }
 
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
 {
+	struct security_operations *sop;
+	int rc = 0;
+	int thisrc;
+
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
-	return security_ops->inode_listsecurity(inode, buffer, buffer_size);
+
+	/*
+	 * inode_listsecurity hooks never return negative values.
+	 */
+	for_each_hook(sop, inode_listsecurity) {
+		thisrc = sop->inode_listsecurity(inode, buffer, buffer_size);
+		buffer += thisrc;
+		buffer_size -= thisrc;
+		rc += thisrc;
+	}
+	return rc;
 }
 
 void security_inode_getsecid(const struct inode *inode, u32 *secid)
 {
-	security_ops->inode_getsecid(inode, secid);
+	if (list_empty(&lsm_hooks[LSM_inode_getsecid]))
+		*secid = 0;
+	else
+		call_void_hook(inode_getsecid, inode, secid);
 }
 
 int security_file_permission(struct file *file, int mask)
 {
-	int ret;
+	int rc = 0;
 
-	ret = security_ops->file_permission(file, mask);
-	if (ret)
-		return ret;
+	call_int_hook(rc, file_permission, file, mask);
+
+	if (rc)
+		return rc;
 
 	return fsnotify_perm(file, mask);
 }
 
 int security_file_alloc(struct file *file)
 {
-	return security_ops->file_alloc_security(file);
+	int rc = 0;
+
+	call_alloc_hook(rc, file_alloc_security, file_free_security,
+			file->f_security, GFP_KERNEL, file);
+	return rc;
 }
 
 void security_file_free(struct file *file)
 {
-	security_ops->file_free_security(file);
+	call_void_hook(file_free_security, file);
+
+	lsm_blob_cleanup(0, file->f_security, __func__);
+	kfree(file->f_security);
+	file->f_security = NULL;
 }
 
 int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
-	return security_ops->file_ioctl(file, cmd, arg);
+	int rc = 0;
+
+	call_int_hook(rc, file_ioctl, file, cmd, arg);
+	return rc;
 }
 
 static inline unsigned long mmap_prot(struct file *file, unsigned long prot)
@@ -716,360 +1455,772 @@ static inline unsigned long mmap_prot(struct file *file, unsigned long prot)
 int security_mmap_file(struct file *file, unsigned long prot,
 			unsigned long flags)
 {
-	int ret;
-	ret = security_ops->mmap_file(file, prot,
-					mmap_prot(file, prot), flags);
-	if (ret)
-		return ret;
+	int rc = 0;
+
+	if (list_empty(&lsm_hooks[LSM_mmap_file]))
+		return cap_mmap_file(file, prot, mmap_prot(file, prot), flags);
+
+	call_int_hook(rc, mmap_file, file, prot, mmap_prot(file, prot), flags);
+
+	if (rc)
+		return rc;
 	return ima_file_mmap(file, prot);
 }
 
 int security_mmap_addr(unsigned long addr)
 {
-	return security_ops->mmap_addr(addr);
+	int rc = 0;
+
+	if (list_empty(&lsm_hooks[LSM_mmap_addr]))
+		return cap_mmap_addr(addr);
+
+	call_int_hook(rc, mmap_addr, addr);
+	return rc;
 }
 
 int security_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 			    unsigned long prot)
 {
-	return security_ops->file_mprotect(vma, reqprot, prot);
+	int rc = 0;
+
+	call_int_hook(rc, file_mprotect, vma, reqprot, prot);
+	return rc;
 }
 
 int security_file_lock(struct file *file, unsigned int cmd)
 {
-	return security_ops->file_lock(file, cmd);
+	int rc = 0;
+
+	call_int_hook(rc, file_lock, file, cmd);
+	return rc;
 }
 
 int security_file_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
 {
-	return security_ops->file_fcntl(file, cmd, arg);
+	int rc = 0;
+
+	call_int_hook(rc, file_fcntl, file, cmd, arg);
+	return rc;
 }
 
 int security_file_set_fowner(struct file *file)
 {
-	return security_ops->file_set_fowner(file);
+	int rc = 0;
+
+	call_int_hook(rc, file_set_fowner, file);
+	return rc;
 }
 
 int security_file_send_sigiotask(struct task_struct *tsk,
 				  struct fown_struct *fown, int sig)
 {
-	return security_ops->file_send_sigiotask(tsk, fown, sig);
+	int rc = 0;
+
+	call_int_hook(rc, file_send_sigiotask, tsk, fown, sig);
+	return rc;
 }
 
 int security_file_receive(struct file *file)
 {
-	return security_ops->file_receive(file);
+	int rc = 0;
+
+	call_int_hook(rc, file_receive, file);
+	return rc;
 }
 
 int security_file_open(struct file *file, const struct cred *cred)
 {
-	int ret;
+	int rc = 0;
 
-	ret = security_ops->file_open(file, cred);
-	if (ret)
-		return ret;
+	call_int_hook(rc, file_open, file, cred);
+
+	if (rc)
+		return rc;
 
 	return fsnotify_perm(file, MAY_OPEN);
 }
 
 int security_task_create(unsigned long clone_flags)
 {
-	return security_ops->task_create(clone_flags);
+	int rc = 0;
+
+	call_int_hook(rc, task_create, clone_flags);
+	return rc;
 }
 
 void security_task_free(struct task_struct *task)
 {
-#ifdef CONFIG_SECURITY_YAMA_STACKED
-	yama_task_free(task);
-#endif
-	security_ops->task_free(task);
+	call_void_hook(task_free, task);
 }
 
 int security_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 {
-	return security_ops->cred_alloc_blank(cred, gfp);
+	struct security_operations *sop;
+	struct security_operations *note[COMPOSER_MAX];
+	struct lsm_blob tblob;
+	struct lsm_blob *bp = NULL;
+	int rc = 0;
+	int successes = 0;
+
+	memset(&tblob, 0, sizeof(tblob));
+	cred->security = &tblob;
+
+	for_each_hook(sop, cred_alloc_blank) {
+		rc = sop->cred_alloc_blank(cred, gfp);
+		if (rc)
+			break;
+		note[successes++] = sop;
+	}
+
+	if (tblob.lsm_setcount != 0) {
+		if (rc == 0)
+			bp = kmemdup(&tblob, sizeof(tblob), gfp);
+		if (bp == NULL) {
+			if (rc == 0)
+				rc = -ENOMEM;
+			while (successes > 0)
+				note[--successes]->cred_free(cred);
+			lsm_blob_cleanup(rc, &tblob, __func__);
+		}
+	}
+	cred->security = bp;
+	return rc;
 }
 
 void security_cred_free(struct cred *cred)
 {
-	security_ops->cred_free(cred);
+#ifdef CONFIG_SECURITY_COMPOSER_DEBUG
+	struct lsm_blob *lbp;
+	struct security_operations *sop;
+#endif
+
+	call_void_hook(cred_free, cred);
+
+	if (cred->security == NULL)
+		return;
+
+#ifdef CONFIG_SECURITY_COMPOSER_DEBUG
+	/*
+	 * Verify that all blobs that where allocated
+	 * and used lsm_set_cred(xxx, yyy) got cleared with
+	 * lsm_set_cred(NULL, yyy).
+	 */
+	lbp = cred->security;
+	for_each_hook(sop, cred_free)
+		if (lbp->lsm_blobs[sop->order])
+			pr_err("%s:%d cred security leftover from %s\n",
+				__func__, __LINE__, sop->name);
+#endif
+	kfree(cred->security);
+	cred->security = NULL;
 }
 
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp)
 {
-	return security_ops->cred_prepare(new, old, gfp);
+	struct security_operations *sop;
+	struct security_operations *note[COMPOSER_MAX];
+	struct lsm_blob tblob;
+	struct lsm_blob *bp = NULL;
+	int rc = 0;
+	int successes = 0;
+
+	/*
+	 * new->security will be NULL on entry.
+	 */
+	memset(&tblob, 0, sizeof(tblob));
+	new->security = &tblob;
+
+	for_each_hook(sop, cred_prepare) {
+		rc = sop->cred_prepare(new, old, gfp);
+		if (rc)
+			break;
+		note[successes++] = sop;
+	}
+
+	if (tblob.lsm_setcount != 0) {
+		if (rc == 0)
+			bp = kmemdup(&tblob, sizeof(tblob), gfp);
+		if (bp == NULL) {
+			if (rc == 0)
+				rc = -ENOMEM;
+			while (successes > 0)
+				note[--successes]->cred_free(new);
+			lsm_blob_cleanup(rc, &tblob, __func__);
+		}
+	}
+	new->security = bp;
+	return rc;
 }
 
 void security_transfer_creds(struct cred *new, const struct cred *old)
 {
-	security_ops->cred_transfer(new, old);
+	call_void_hook(cred_transfer, new, old);
 }
 
 int security_kernel_act_as(struct cred *new, u32 secid)
 {
-	return security_ops->kernel_act_as(new, secid);
+	int rc = 0;
+
+	call_int_hook(rc, kernel_act_as, new, secid);
+	return rc;
 }
 
 int security_kernel_create_files_as(struct cred *new, struct inode *inode)
 {
-	return security_ops->kernel_create_files_as(new, inode);
+	int rc = 0;
+
+	call_int_hook(rc, kernel_create_files_as, new, inode);
+	return rc;
 }
 
 int security_kernel_module_request(char *kmod_name)
 {
-	return security_ops->kernel_module_request(kmod_name);
+	int rc = 0;
+
+	call_int_hook(rc, kernel_module_request, kmod_name);
+	return rc;
 }
 
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
 			     int flags)
 {
-	return security_ops->task_fix_setuid(new, old, flags);
+	int rc = 0;
+
+	if (list_empty(&lsm_hooks[LSM_task_fix_setuid]))
+		return cap_task_fix_setuid(new, old, flags);
+
+	call_int_hook(rc, task_fix_setuid, new, old, flags);
+	return rc;
 }
 
 int security_task_setpgid(struct task_struct *p, pid_t pgid)
 {
-	return security_ops->task_setpgid(p, pgid);
+	int rc = 0;
+
+	call_int_hook(rc, task_setpgid, p, pgid);
+	return rc;
 }
 
 int security_task_getpgid(struct task_struct *p)
 {
-	return security_ops->task_getpgid(p);
+	int rc = 0;
+
+	call_int_hook(rc, task_getpgid, p);
+	return rc;
 }
 
 int security_task_getsid(struct task_struct *p)
 {
-	return security_ops->task_getsid(p);
+	int rc = 0;
+
+	call_int_hook(rc, task_getsid, p);
+	return rc;
 }
 
 void security_task_getsecid(struct task_struct *p, u32 *secid)
 {
-	security_ops->task_getsecid(p, secid);
+	if (list_empty(&lsm_hooks[LSM_task_getsecid]))
+		*secid = 0;
+	else
+		call_void_hook(task_getsecid, p, secid);
 }
 EXPORT_SYMBOL(security_task_getsecid);
 
 int security_task_setnice(struct task_struct *p, int nice)
 {
-	return security_ops->task_setnice(p, nice);
+	int rc = 0;
+
+	if (list_empty(&lsm_hooks[LSM_task_setnice]))
+		return cap_task_setnice(p, nice);
+
+	call_int_hook(rc, task_setnice, p, nice);
+	return rc;
 }
 
 int security_task_setioprio(struct task_struct *p, int ioprio)
 {
-	return security_ops->task_setioprio(p, ioprio);
+	int rc = 0;
+
+	if (list_empty(&lsm_hooks[LSM_task_setioprio]))
+		return cap_task_setioprio(p, ioprio);
+
+	call_int_hook(rc, task_setioprio, p, ioprio);
+	return rc;
 }
 
 int security_task_getioprio(struct task_struct *p)
 {
-	return security_ops->task_getioprio(p);
+	int rc = 0;
+
+	call_int_hook(rc, task_getioprio, p);
+	return rc;
 }
 
 int security_task_setrlimit(struct task_struct *p, unsigned int resource,
 		struct rlimit *new_rlim)
 {
-	return security_ops->task_setrlimit(p, resource, new_rlim);
+	int rc = 0;
+
+	call_int_hook(rc, task_setrlimit, p, resource, new_rlim);
+	return rc;
 }
 
 int security_task_setscheduler(struct task_struct *p)
 {
-	return security_ops->task_setscheduler(p);
+	int rc = 0;
+
+	if (list_empty(&lsm_hooks[LSM_task_setscheduler]))
+		return cap_task_setscheduler(p);
+
+	call_int_hook(rc, task_setscheduler, p);
+	return rc;
 }
 
 int security_task_getscheduler(struct task_struct *p)
 {
-	return security_ops->task_getscheduler(p);
+	int rc = 0;
+
+	call_int_hook(rc, task_getscheduler, p);
+	return rc;
 }
 
 int security_task_movememory(struct task_struct *p)
 {
-	return security_ops->task_movememory(p);
+	int rc = 0;
+
+	call_int_hook(rc, task_movememory, p);
+	return rc;
 }
 
 int security_task_kill(struct task_struct *p, struct siginfo *info,
 			int sig, u32 secid)
 {
-	return security_ops->task_kill(p, info, sig, secid);
+	int rc = 0;
+
+	call_int_hook(rc, task_kill, p, info, sig, secid);
+	return rc;
 }
 
 int security_task_wait(struct task_struct *p)
 {
-	return security_ops->task_wait(p);
+	int rc = 0;
+
+	call_int_hook(rc, task_wait, p);
+	return rc;
 }
 
 int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			 unsigned long arg4, unsigned long arg5)
 {
-#ifdef CONFIG_SECURITY_YAMA_STACKED
+	struct security_operations *sop;
 	int rc;
-	rc = yama_task_prctl(option, arg2, arg3, arg4, arg5);
-	if (rc != -ENOSYS)
-		return rc;
-#endif
-	return security_ops->task_prctl(option, arg2, arg3, arg4, arg5);
+
+	if (list_empty(&lsm_hooks[LSM_task_prctl]))
+		return cap_task_prctl(option, arg2, arg3, arg4, arg5);
+
+	for_each_hook(sop, task_prctl) {
+		rc = sop->task_prctl(option, arg2, arg3, arg4, arg5);
+		/*
+		 * -ENOSYS returned if the lsm doesn't handle that control.
+		 * If the LSM does handle the control return the result.
+		 * The assumption for the time being is that no two LSMs
+		 * will handle a control.
+		 */
+		if (rc != -ENOSYS)
+			return rc;
+	}
+	return -ENOSYS;
 }
 
 void security_task_to_inode(struct task_struct *p, struct inode *inode)
 {
-	security_ops->task_to_inode(p, inode);
+	call_void_hook(task_to_inode, p, inode);
 }
 
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 {
-	return security_ops->ipc_permission(ipcp, flag);
+	int rc = 0;
+
+	call_int_hook(rc, ipc_permission, ipcp, flag);
+	return rc;
 }
 
 void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
 {
-	security_ops->ipc_getsecid(ipcp, secid);
+	if (list_empty(&lsm_hooks[LSM_sem_associate]))
+		*secid = 0;
+	else
+		call_void_hook(ipc_getsecid, ipcp, secid);
 }
 
 int security_msg_msg_alloc(struct msg_msg *msg)
 {
-	return security_ops->msg_msg_alloc_security(msg);
+	int rc = 0;
+
+	call_alloc_hook(rc, msg_msg_alloc_security, msg_msg_free_security,
+			msg->security, GFP_KERNEL, msg);
+	return rc;
 }
 
 void security_msg_msg_free(struct msg_msg *msg)
 {
-	security_ops->msg_msg_free_security(msg);
+	call_void_hook(msg_msg_free_security, msg);
+
+	lsm_blob_cleanup(0, msg->security, __func__);
+	kfree(msg->security);
+	msg->security = NULL;
 }
 
 int security_msg_queue_alloc(struct msg_queue *msq)
 {
-	return security_ops->msg_queue_alloc_security(msq);
+	struct kern_ipc_perm *kp = &msq->q_perm;
+	int rc = 0;
+
+	call_alloc_hook(rc, msg_queue_alloc_security, msg_queue_free_security,
+			kp->security, GFP_KERNEL, msq);
+	return rc;
 }
 
 void security_msg_queue_free(struct msg_queue *msq)
 {
-	security_ops->msg_queue_free_security(msq);
+	call_void_hook(msg_queue_free_security, msq);
+
+	lsm_blob_cleanup(0, msq->q_perm.security, __func__);
+	kfree(msq->q_perm.security);
+	msq->q_perm.security = NULL;
 }
 
 int security_msg_queue_associate(struct msg_queue *msq, int msqflg)
 {
-	return security_ops->msg_queue_associate(msq, msqflg);
+	int rc = 0;
+
+	call_int_hook(rc, msg_queue_associate, msq, msqflg);
+	return rc;
 }
 
 int security_msg_queue_msgctl(struct msg_queue *msq, int cmd)
 {
-	return security_ops->msg_queue_msgctl(msq, cmd);
+	int rc = 0;
+
+	call_int_hook(rc, msg_queue_msgctl, msq, cmd);
+	return rc;
 }
 
 int security_msg_queue_msgsnd(struct msg_queue *msq,
 			       struct msg_msg *msg, int msqflg)
 {
-	return security_ops->msg_queue_msgsnd(msq, msg, msqflg);
+	int rc = 0;
+
+	call_int_hook(rc, msg_queue_msgsnd, msq, msg, msqflg);
+	return rc;
 }
 
 int security_msg_queue_msgrcv(struct msg_queue *msq, struct msg_msg *msg,
 			       struct task_struct *target, long type, int mode)
 {
-	return security_ops->msg_queue_msgrcv(msq, msg, target, type, mode);
+	int rc = 0;
+
+	call_int_hook(rc, msg_queue_msgrcv, msq, msg, target, type, mode);
+	return rc;
 }
 
 int security_shm_alloc(struct shmid_kernel *shp)
 {
-	return security_ops->shm_alloc_security(shp);
+	struct kern_ipc_perm *kp = &shp->shm_perm;
+	int rc = 0;
+
+	call_alloc_hook(rc, shm_alloc_security, shm_free_security,
+			kp->security, GFP_KERNEL, shp);
+	return rc;
 }
 
 void security_shm_free(struct shmid_kernel *shp)
 {
-	security_ops->shm_free_security(shp);
+	call_void_hook(shm_free_security, shp);
+
+	lsm_blob_cleanup(0, shp->shm_perm.security, __func__);
+	kfree(shp->shm_perm.security);
+	shp->shm_perm.security = NULL;
 }
 
 int security_shm_associate(struct shmid_kernel *shp, int shmflg)
 {
-	return security_ops->shm_associate(shp, shmflg);
+	int rc = 0;
+
+	call_int_hook(rc, shm_associate, shp, shmflg);
+	return rc;
 }
 
 int security_shm_shmctl(struct shmid_kernel *shp, int cmd)
 {
-	return security_ops->shm_shmctl(shp, cmd);
+	int rc = 0;
+
+	call_int_hook(rc, shm_shmctl, shp, cmd);
+	return rc;
 }
 
 int security_shm_shmat(struct shmid_kernel *shp, char __user *shmaddr, int shmflg)
 {
-	return security_ops->shm_shmat(shp, shmaddr, shmflg);
+	int rc = 0;
+
+	call_int_hook(rc, shm_shmat, shp, shmaddr, shmflg);
+	return rc;
 }
 
 int security_sem_alloc(struct sem_array *sma)
 {
-	return security_ops->sem_alloc_security(sma);
+	struct kern_ipc_perm *kp = &sma->sem_perm;
+	int rc = 0;
+
+	call_alloc_hook(rc, sem_alloc_security, sem_free_security,
+			kp->security, GFP_KERNEL, sma);
+	return rc;
 }
 
 void security_sem_free(struct sem_array *sma)
 {
-	security_ops->sem_free_security(sma);
+	call_void_hook(sem_free_security, sma);
+
+	lsm_blob_cleanup(0, sma->sem_perm.security, __func__);
+	kfree(sma->sem_perm.security);
+	sma->sem_perm.security = NULL;
 }
 
 int security_sem_associate(struct sem_array *sma, int semflg)
 {
-	return security_ops->sem_associate(sma, semflg);
+	int rc = 0;
+
+	call_int_hook(rc, sem_associate, sma, semflg);
+	return rc;
 }
 
 int security_sem_semctl(struct sem_array *sma, int cmd)
 {
-	return security_ops->sem_semctl(sma, cmd);
+	int rc = 0;
+
+	call_int_hook(rc, sem_semctl, sma, cmd);
+	return rc;
 }
 
 int security_sem_semop(struct sem_array *sma, struct sembuf *sops,
 			unsigned nsops, int alter)
 {
-	return security_ops->sem_semop(sma, sops, nsops, alter);
+	int rc = 0;
+
+	call_int_hook(rc, sem_semop, sma, sops, nsops, alter);
+	return rc;
 }
 
 void security_d_instantiate(struct dentry *dentry, struct inode *inode)
 {
 	if (unlikely(inode && IS_PRIVATE(inode)))
 		return;
-	security_ops->d_instantiate(dentry, inode);
+
+	call_void_hook(d_instantiate, dentry, inode);
 }
 EXPORT_SYMBOL(security_d_instantiate);
 
 int security_getprocattr(struct task_struct *p, char *name, char **value)
 {
-	return security_ops->getprocattr(p, name, value);
+	struct security_operations *sop;
+	char *result = NULL;
+	char *values[COMPOSER_MAX];
+	int rcs[COMPOSER_MAX];
+	int only = 0;
+	int total = 0;
+	int order;
+	int j;
+
+	if (lsm_present)
+		return lsm_present->getprocattr(p, name, value);
+
+	/*
+	 * Find all the LSMs that produce procattrs and call them,
+	 * saving the results. Note if more than one gets called
+	 * and if there are any failures. Track how much space is
+	 * going to be required to combine the strings.
+	 */
+	for_each_hook(sop, getprocattr) {
+		order = sop->order;
+		rcs[order] = 0;
+		values[order] = NULL;
+		rcs[order] = sop->getprocattr(p, name, &values[order]);
+		if (rcs[order] < 0) {
+			if (values[order] == NULL)
+				values[order] = kstrdup("(null)", GFP_KERNEL);
+			total += 6;
+		} else
+			total += rcs[order];
+
+		total += strlen(sop->name) + 2;
+
+		if (only == 0)
+			only = order;
+		else
+			only = -1;
+	}
+	/*
+	 * Special cases for 0 and 1 LSMs getting called
+	 * In the multiple called case compose a string.
+	 */
+	if (only == 0)
+		return -EINVAL;
+
+	if (only > 0) {
+		*value = values[only];
+		return rcs[only];
+	}
+
+	result = kzalloc(total + 3, GFP_KERNEL);
+	for_each_hook(sop, getprocattr) {
+		order = sop->order;
+		for (j = 0; j < rcs[order]; j++)
+			if (values[order][j] == '\n')
+				values[order][j] = '\0';
+		strcat(result, "/");
+		strcat(result, sop->name);
+		strcat(result, "=");
+		strncat(result, values[order], rcs[order] + 1);
+		kfree(values[order]);
+	}
+	strcat(result, "/\n");
+
+	*value = result;
+	return strlen(result) + 1;
 }
 
-int security_setprocattr(struct task_struct *p, char *name, void *value, size_t size)
+int security_setprocattr(struct task_struct *p, char *name, void *value,
+				size_t size)
 {
-	return security_ops->setprocattr(p, name, value, size);
+	struct security_operations *sop;
+	char searches[COMPOSER_MAX][SECURITY_NAME_MAX + 4];
+	char *data = value;
+	char *values[COMPOSER_MAX];
+	int eos = 0;
+	int formatted = 0;
+	int only = 0;
+	int thisrc;
+	int rc = size;
+
+	if (lsm_present)
+		return lsm_present->setprocattr(p, name, value, size);
+
+	if (size > PAGE_SIZE - 1)
+		return -EINVAL;
+	if (size > 0)
+		eos = size - 1;
+	while (eos > 0 && (data[eos] == '\0' || data[eos] == '\n'))
+		eos--;
+
+	if (data[0] == '/' && data[eos] == '/') {
+		/*
+		 * "/smack=Howdy/apparmor=confined/bandl=12/1,2,6/"
+		 */
+		formatted = 1;
+		data[eos] = '\0';
+		for_each_hook(sop, setprocattr) {
+			sprintf(searches[sop->order], "/%s=", sop->name);
+			values[sop->order] = strnstr(data,
+						searches[sop->order], size);
+		}
+		for_each_hook(sop, setprocattr) {
+			if (values[sop->order] != NULL) {
+				*values[sop->order] = '\0';
+				values[sop->order] = values[sop->order] +
+					strlen(searches[sop->order]);
+			}
+		}
+	}
+	for_each_hook(sop, setprocattr) {
+		if (formatted && values[sop->order] == NULL)
+			continue;
+		if (only == 0)
+			only = sop->order;
+		else
+			only = -1;
+
+		if (formatted)
+			thisrc = sop->setprocattr(p, name, values[sop->order],
+					strlen(values[sop->order]) + 1);
+		else
+			thisrc = sop->setprocattr(p, name, value, size);
+
+		if (thisrc < 0)
+			rc = thisrc;
+	}
+
+	if (only == 0)
+		return -EINVAL;
+	return rc;
+
 }
 
 int security_netlink_send(struct sock *sk, struct sk_buff *skb)
 {
-	return security_ops->netlink_send(sk, skb);
+	int rc = 0;
+
+	if (list_empty(&lsm_hooks[LSM_netlink_send]))
+		return cap_netlink_send(sk, skb);
+
+	call_int_hook(rc, netlink_send, sk, skb);
+	return rc;
 }
 
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 {
-	return security_ops->secid_to_secctx(secid, secdata, seclen);
+	int rc = 0;
+
+	if (list_empty(&lsm_hooks[LSM_secid_to_secctx]))
+		return -EOPNOTSUPP;
+
+	call_int_hook(rc, secid_to_secctx, secid, secdata, seclen);
+	return rc;
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
 int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 {
-	return security_ops->secctx_to_secid(secdata, seclen, secid);
+	int rc = 0;
+
+	if (list_empty(&lsm_hooks[LSM_secctx_to_secid]))
+		*secid = 0;
+	else
+		call_int_hook(rc, secctx_to_secid, secdata, seclen, secid);
+
+	return rc;
 }
 EXPORT_SYMBOL(security_secctx_to_secid);
 
 void security_release_secctx(char *secdata, u32 seclen)
 {
-	security_ops->release_secctx(secdata, seclen);
+	call_void_hook(release_secctx, secdata, seclen);
 }
 EXPORT_SYMBOL(security_release_secctx);
 
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
 {
-	return security_ops->inode_notifysecctx(inode, ctx, ctxlen);
+	int rc = 0;
+
+	call_int_hook(rc, inode_notifysecctx, inode, ctx, ctxlen);
+	return rc;
 }
 EXPORT_SYMBOL(security_inode_notifysecctx);
 
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 {
-	return security_ops->inode_setsecctx(dentry, ctx, ctxlen);
+	int rc = 0;
+
+	call_int_hook(rc, inode_setsecctx, dentry, ctx, ctxlen);
+	return rc;
 }
 EXPORT_SYMBOL(security_inode_setsecctx);
 
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
 {
-	return security_ops->inode_getsecctx(inode, ctx, ctxlen);
+	int rc = 0;
+
+	call_int_hook(rc, inode_getsecctx, inode, ctx, ctxlen);
+	return rc;
 }
 EXPORT_SYMBOL(security_inode_getsecctx);
 
@@ -1077,188 +2228,293 @@ EXPORT_SYMBOL(security_inode_getsecctx);
 
 int security_unix_stream_connect(struct sock *sock, struct sock *other, struct sock *newsk)
 {
-	return security_ops->unix_stream_connect(sock, other, newsk);
+	int rc = 0;
+
+	call_int_hook(rc, unix_stream_connect, sock, other, newsk);
+	return rc;
 }
 EXPORT_SYMBOL(security_unix_stream_connect);
 
 int security_unix_may_send(struct socket *sock,  struct socket *other)
 {
-	return security_ops->unix_may_send(sock, other);
+	int rc = 0;
+
+	call_int_hook(rc, unix_may_send, sock, other);
+	return rc;
 }
 EXPORT_SYMBOL(security_unix_may_send);
 
 int security_socket_create(int family, int type, int protocol, int kern)
 {
-	return security_ops->socket_create(family, type, protocol, kern);
+	int rc = 0;
+
+	call_int_hook(rc, socket_create, family, type, protocol, kern);
+	return rc;
 }
 
 int security_socket_post_create(struct socket *sock, int family,
 				int type, int protocol, int kern)
 {
-	return security_ops->socket_post_create(sock, family, type,
-						protocol, kern);
+	int rc = 0;
+
+	call_int_hook(rc, socket_post_create, sock, family, type,
+			protocol, kern);
+	return rc;
 }
 
 int security_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
 {
-	return security_ops->socket_bind(sock, address, addrlen);
+	int rc = 0;
+
+	call_int_hook(rc, socket_bind, sock, address, addrlen);
+	return rc;
 }
 
 int security_socket_connect(struct socket *sock, struct sockaddr *address, int addrlen)
 {
-	return security_ops->socket_connect(sock, address, addrlen);
+	int rc = 0;
+
+	call_int_hook(rc, socket_connect, sock, address, addrlen);
+	return rc;
 }
 
 int security_socket_listen(struct socket *sock, int backlog)
 {
-	return security_ops->socket_listen(sock, backlog);
+	int rc = 0;
+
+	call_int_hook(rc, socket_listen, sock, backlog);
+	return rc;
 }
 
 int security_socket_accept(struct socket *sock, struct socket *newsock)
 {
-	return security_ops->socket_accept(sock, newsock);
+	int rc = 0;
+
+	call_int_hook(rc, socket_accept, sock, newsock);
+	return rc;
 }
 
 int security_socket_sendmsg(struct socket *sock, struct msghdr *msg, int size)
 {
-	return security_ops->socket_sendmsg(sock, msg, size);
+	int rc = 0;
+
+	call_int_hook(rc, socket_sendmsg, sock, msg, size);
+	return rc;
 }
 
 int security_socket_recvmsg(struct socket *sock, struct msghdr *msg,
 			    int size, int flags)
 {
-	return security_ops->socket_recvmsg(sock, msg, size, flags);
+	int rc = 0;
+
+	call_int_hook(rc, socket_recvmsg, sock, msg, size, flags);
+	return rc;
 }
 
 int security_socket_getsockname(struct socket *sock)
 {
-	return security_ops->socket_getsockname(sock);
+	int rc = 0;
+
+	call_int_hook(rc, socket_getsockname, sock);
+	return rc;
 }
 
 int security_socket_getpeername(struct socket *sock)
 {
-	return security_ops->socket_getpeername(sock);
+	int rc = 0;
+
+	call_int_hook(rc, socket_getpeername, sock);
+	return rc;
 }
 
 int security_socket_getsockopt(struct socket *sock, int level, int optname)
 {
-	return security_ops->socket_getsockopt(sock, level, optname);
+	int rc = 0;
+
+	call_int_hook(rc, socket_getsockopt, sock, level, optname);
+	return rc;
 }
 
 int security_socket_setsockopt(struct socket *sock, int level, int optname)
 {
-	return security_ops->socket_setsockopt(sock, level, optname);
+	int rc = 0;
+
+	call_int_hook(rc, socket_setsockopt, sock, level, optname);
+	return rc;
 }
 
 int security_socket_shutdown(struct socket *sock, int how)
 {
-	return security_ops->socket_shutdown(sock, how);
+	int rc = 0;
+
+	call_int_hook(rc, socket_shutdown, sock, how);
+	return rc;
 }
 
 int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
-	return security_ops->socket_sock_rcv_skb(sk, skb);
+	int rc = 0;
+
+	call_int_hook(rc, socket_sock_rcv_skb, sk, skb);
+	return rc;
 }
 EXPORT_SYMBOL(security_sock_rcv_skb);
 
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len)
 {
-	return security_ops->socket_getpeersec_stream(sock, optval, optlen, len);
+	int rc = 0;
+
+	if (list_empty(&lsm_hooks[LSM_socket_getpeersec_stream]))
+		return -ENOPROTOOPT;
+
+	call_int_hook(rc, socket_getpeersec_stream, sock, optval, optlen, len);
+	return rc;
 }
 
 int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
 {
-	return security_ops->socket_getpeersec_dgram(sock, skb, secid);
+	int rc = 0;
+
+	if (list_empty(&lsm_hooks[LSM_socket_getpeersec_dgram]))
+		return -ENOPROTOOPT;
+
+	call_int_hook(rc, socket_getpeersec_dgram, sock, skb, secid);
+	return rc;
 }
 EXPORT_SYMBOL(security_socket_getpeersec_dgram);
 
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority)
 {
-	return security_ops->sk_alloc_security(sk, family, priority);
+	struct security_operations *sop;
+	struct security_operations *note[COMPOSER_MAX];
+	struct lsm_blob tblob;
+	struct lsm_blob *bp = NULL;
+	int rc = 0;
+	int successes = 0;
+
+	memset(&tblob, 0, sizeof(tblob));
+	sk->sk_security = &tblob;
+
+	for_each_hook(sop, sk_alloc_security) {
+		rc = sop->sk_alloc_security(sk, family, priority);
+		if (rc)
+			break;
+		note[successes++] = sop;
+	}
+
+	if (tblob.lsm_setcount != 0) {
+		if (rc == 0)
+			bp = kmemdup(&tblob, sizeof(tblob), priority);
+		if (bp == NULL) {
+			if (rc == 0)
+				rc = -ENOMEM;
+			while (successes > 0)
+				note[--successes]->sk_free_security(sk);
+			lsm_blob_cleanup(rc, &tblob, __func__);
+		}
+	}
+	sk->sk_security = bp;
+	return rc;
 }
 
 void security_sk_free(struct sock *sk)
 {
-	security_ops->sk_free_security(sk);
+	call_void_hook(sk_free_security, sk);
+
+	lsm_blob_cleanup(0, sk->sk_security, __func__);
+	kfree(sk->sk_security);
+	sk->sk_security = NULL;
 }
 
 void security_sk_clone(const struct sock *sk, struct sock *newsk)
 {
-	security_ops->sk_clone_security(sk, newsk);
+	call_void_hook(sk_clone_security, sk, newsk);
 }
 EXPORT_SYMBOL(security_sk_clone);
 
 void security_sk_classify_flow(struct sock *sk, struct flowi *fl)
 {
-	security_ops->sk_getsecid(sk, &fl->flowi_secid);
+	call_void_hook(sk_getsecid, sk, &fl->flowi_secid);
 }
 EXPORT_SYMBOL(security_sk_classify_flow);
 
 void security_req_classify_flow(const struct request_sock *req, struct flowi *fl)
 {
-	security_ops->req_classify_flow(req, fl);
+	call_void_hook(req_classify_flow, req, fl);
 }
 EXPORT_SYMBOL(security_req_classify_flow);
 
 void security_sock_graft(struct sock *sk, struct socket *parent)
 {
-	security_ops->sock_graft(sk, parent);
+	call_void_hook(sock_graft, sk, parent);
 }
 EXPORT_SYMBOL(security_sock_graft);
 
 int security_inet_conn_request(struct sock *sk,
 			struct sk_buff *skb, struct request_sock *req)
 {
-	return security_ops->inet_conn_request(sk, skb, req);
+	int rc = 0;
+
+	call_int_hook(rc, inet_conn_request, sk, skb, req);
+	return rc;
 }
 EXPORT_SYMBOL(security_inet_conn_request);
 
 void security_inet_csk_clone(struct sock *newsk,
 			const struct request_sock *req)
 {
-	security_ops->inet_csk_clone(newsk, req);
+	call_void_hook(inet_csk_clone, newsk, req);
 }
 
 void security_inet_conn_established(struct sock *sk,
 			struct sk_buff *skb)
 {
-	security_ops->inet_conn_established(sk, skb);
+	call_void_hook(inet_conn_established, sk, skb);
 }
 
 int security_secmark_relabel_packet(u32 secid)
 {
-	return security_ops->secmark_relabel_packet(secid);
+	int rc = 0;
+
+	call_int_hook(rc, secmark_relabel_packet, secid);
+	return rc;
 }
 EXPORT_SYMBOL(security_secmark_relabel_packet);
 
 void security_secmark_refcount_inc(void)
 {
-	security_ops->secmark_refcount_inc();
+	call_void_hook(secmark_refcount_inc);
 }
 EXPORT_SYMBOL(security_secmark_refcount_inc);
 
 void security_secmark_refcount_dec(void)
 {
-	security_ops->secmark_refcount_dec();
+	call_void_hook(secmark_refcount_dec);
 }
 EXPORT_SYMBOL(security_secmark_refcount_dec);
 
 int security_tun_dev_create(void)
 {
-	return security_ops->tun_dev_create();
+	int rc = 0;
+
+	call_int_hook(rc, tun_dev_create);
+	return rc;
 }
 EXPORT_SYMBOL(security_tun_dev_create);
 
 void security_tun_dev_post_create(struct sock *sk)
 {
-	return security_ops->tun_dev_post_create(sk);
+	call_void_hook(tun_dev_post_create, sk);
 }
 EXPORT_SYMBOL(security_tun_dev_post_create);
 
 int security_tun_dev_attach(struct sock *sk)
 {
-	return security_ops->tun_dev_attach(sk);
+	int rc = 0;
+
+	call_int_hook(rc, tun_dev_attach, sk);
+	return rc;
 }
 EXPORT_SYMBOL(security_tun_dev_attach);
 
@@ -1266,78 +2522,119 @@ EXPORT_SYMBOL(security_tun_dev_attach);
 
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
 
+/*
+ * The xfrm hooks present special issues for composition
+ * as they don't use the usual scheme for passing in blobs.
+ * LSM registration checks ensure that only one xfrm using
+ * security module is loaded at a time.
+ * This shouldn't be much of an issue since SELinux is the
+ * only security module ever expected to use xfrm.
+ */
 int security_xfrm_policy_alloc(struct xfrm_sec_ctx **ctxp, struct xfrm_user_sec_ctx *sec_ctx)
 {
-	return security_ops->xfrm_policy_alloc_security(ctxp, sec_ctx);
+	int rc = 0;
+
+	call_int_hook(rc, xfrm_policy_alloc_security, ctxp, sec_ctx);
+	return rc;
 }
 EXPORT_SYMBOL(security_xfrm_policy_alloc);
 
 int security_xfrm_policy_clone(struct xfrm_sec_ctx *old_ctx,
 			      struct xfrm_sec_ctx **new_ctxp)
 {
-	return security_ops->xfrm_policy_clone_security(old_ctx, new_ctxp);
+	int rc = 0;
+
+	call_int_hook(rc, xfrm_policy_clone_security, old_ctx, new_ctxp);
+	return rc;
 }
 
 void security_xfrm_policy_free(struct xfrm_sec_ctx *ctx)
 {
-	security_ops->xfrm_policy_free_security(ctx);
+	call_void_hook(xfrm_policy_free_security, ctx);
 }
 EXPORT_SYMBOL(security_xfrm_policy_free);
 
 int security_xfrm_policy_delete(struct xfrm_sec_ctx *ctx)
 {
-	return security_ops->xfrm_policy_delete_security(ctx);
+	int rc = 0;
+
+	call_int_hook(rc, xfrm_policy_delete_security, ctx);
+	return rc;
 }
 
 int security_xfrm_state_alloc(struct xfrm_state *x, struct xfrm_user_sec_ctx *sec_ctx)
 {
-	return security_ops->xfrm_state_alloc_security(x, sec_ctx, 0);
+	int rc = 0;
+
+	call_int_hook(rc, xfrm_state_alloc_security, x, sec_ctx, 0);
+	return rc;
 }
 EXPORT_SYMBOL(security_xfrm_state_alloc);
 
 int security_xfrm_state_alloc_acquire(struct xfrm_state *x,
 				      struct xfrm_sec_ctx *polsec, u32 secid)
 {
-	if (!polsec)
-		return 0;
+	int rc = 0;
 	/*
 	 * We want the context to be taken from secid which is usually
 	 * from the sock.
 	 */
-	return security_ops->xfrm_state_alloc_security(x, NULL, secid);
+
+	if (!polsec)
+		return 0;
+
+	call_int_hook(rc, xfrm_state_alloc_security, x, NULL, secid);
+	return rc;
 }
 
 int security_xfrm_state_delete(struct xfrm_state *x)
 {
-	return security_ops->xfrm_state_delete_security(x);
+	int rc = 0;
+
+	call_int_hook(rc, xfrm_state_delete_security, x);
+	return rc;
 }
 EXPORT_SYMBOL(security_xfrm_state_delete);
 
 void security_xfrm_state_free(struct xfrm_state *x)
 {
-	security_ops->xfrm_state_free_security(x);
+	call_void_hook(xfrm_state_free_security, x);
 }
 
 int security_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid, u8 dir)
 {
-	return security_ops->xfrm_policy_lookup(ctx, fl_secid, dir);
+	int rc = 0;
+
+	call_int_hook(rc, xfrm_policy_lookup, ctx, fl_secid, dir);
+	return rc;
 }
 
 int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 				       struct xfrm_policy *xp,
 				       const struct flowi *fl)
 {
-	return security_ops->xfrm_state_pol_flow_match(x, xp, fl);
+	int rc = 0;
+
+	if (list_empty(&lsm_hooks[LSM_xfrm_state_pol_flow_match]))
+		return 1;
+
+	call_int_hook(rc, xfrm_state_pol_flow_match, x, xp, fl);
+	return rc;
 }
 
 int security_xfrm_decode_session(struct sk_buff *skb, u32 *secid)
 {
-	return security_ops->xfrm_decode_session(skb, secid, 1);
+	int rc = 0;
+
+	call_int_hook(rc, xfrm_decode_session, skb, secid, 1);
+	return rc;
 }
 
 void security_skb_classify_flow(struct sk_buff *skb, struct flowi *fl)
 {
-	int rc = security_ops->xfrm_decode_session(skb, &fl->flowi_secid, 0);
+	int rc = 0;
+
+	call_int_hook(rc, xfrm_decode_session, skb, &fl->flowi_secid, 0);
 
 	BUG_ON(rc);
 }
@@ -1350,23 +2647,63 @@ EXPORT_SYMBOL(security_skb_classify_flow);
 int security_key_alloc(struct key *key, const struct cred *cred,
 		       unsigned long flags)
 {
-	return security_ops->key_alloc(key, cred, flags);
+	struct security_operations *sop;
+	struct security_operations *note[COMPOSER_MAX];
+	struct lsm_blob tblob;
+	struct lsm_blob *bp = NULL;
+	int rc = 0;
+	int successes = 0;
+
+	memset(&tblob, 0, sizeof(tblob));
+	key->security = &tblob;
+
+	for_each_hook(sop, key_alloc) {
+		rc = sop->key_alloc(key, cred, flags);
+		if (rc)
+			break;
+		note[successes++] = sop;
+	}
+
+	if (tblob.lsm_setcount != 0) {
+		if (rc == 0)
+			bp = kmemdup(&tblob, sizeof(tblob), GFP_KERNEL);
+		if (bp == NULL) {
+			if (rc == 0)
+				rc = -ENOMEM;
+			while (successes > 0)
+				note[--successes]->key_free(key);
+			lsm_blob_cleanup(rc, &tblob, __func__);
+		}
+	}
+
+	key->security = bp;
+	return rc;
 }
 
 void security_key_free(struct key *key)
 {
-	security_ops->key_free(key);
+	call_void_hook(key_free, key);
 }
 
 int security_key_permission(key_ref_t key_ref,
 			    const struct cred *cred, key_perm_t perm)
 {
-	return security_ops->key_permission(key_ref, cred, perm);
+	int rc = 0;
+
+	call_int_hook(rc, key_permission, key_ref, cred, perm);
+	return rc;
 }
 
 int security_key_getsecurity(struct key *key, char **_buffer)
 {
-	return security_ops->key_getsecurity(key, _buffer);
+	int rc = 0;
+
+	if (list_empty(&lsm_hooks[LSM_key_getsecurity]))
+		*_buffer = NULL;
+	else
+		call_int_hook(rc, key_getsecurity, key, _buffer);
+
+	return rc;
 }
 
 #endif	/* CONFIG_KEYS */
@@ -1375,23 +2712,32 @@ int security_key_getsecurity(struct key *key, char **_buffer)
 
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
 {
-	return security_ops->audit_rule_init(field, op, rulestr, lsmrule);
+	int rc = 0;
+
+	call_int_hook(rc, audit_rule_init, field, op, rulestr, lsmrule);
+	return rc;
 }
 
 int security_audit_rule_known(struct audit_krule *krule)
 {
-	return security_ops->audit_rule_known(krule);
+	int rc = 0;
+
+	call_int_hook(rc, audit_rule_known, krule);
+	return rc;
 }
 
 void security_audit_rule_free(void *lsmrule)
 {
-	security_ops->audit_rule_free(lsmrule);
+	call_void_hook(audit_rule_free, lsmrule);
 }
 
 int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
 			      struct audit_context *actx)
 {
-	return security_ops->audit_rule_match(secid, field, op, lsmrule, actx);
+	int rc = 0;
+
+	call_int_hook(rc, audit_rule_match, secid, field, op, lsmrule, actx);
+	return rc;
 }
 
 #endif /* CONFIG_AUDIT */


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
