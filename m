Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w281sUH4030700
 for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2018 20:54:30 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC03.oob.disa.mil (Postfix) with SMTP id 3zxYTr1mvHzJnXt
 for <selinux@tycho.nsa.gov>; Thu,  8 Mar 2018 01:54:24 +0000 (UTC)
Received: from UPDC3CPA08_EEMSG_MP24.eemsg.mil (unknown [192.168.18.19])
 by UPDCF3IC03.oob.disa.mil (Postfix) with ESMTP id 3zxYTr0fc3zJnXT
 for <selinux@tycho.nsa.gov>; Thu,  8 Mar 2018 01:54:24 +0000 (UTC)
To: LSM <linux-security-module@vger.kernel.org>,
 James Morris <jmorris@namei.org>
Cc: John Johansen <john.johansen@canonical.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, Kees Cook <keescook@chromium.org>,
 Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
 SMACK-announce@lists.01.org, Casey Schaufler <casey@schaufler-ca.com>
References: <d2c25c38-e19d-1e08-8c49-4726a34e72bb@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <5316f439-4535-2296-f48f-630f5fa36c7f@schaufler-ca.com>
Date: Wed, 7 Mar 2018 17:53:51 -0800
MIME-Version: 1.0
In-Reply-To: <d2c25c38-e19d-1e08-8c49-4726a34e72bb@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Subject: [PATCH 8/8] LSM: Full security module stacking
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Subject: [PATCH 8/8] LSM: Full security module stacking

Allow any combination of existing security modules,
including those using secids and security marked networking.

The interfaces used by filesystems to maintain security
attributes:
        security_inode_setsecctx
        security_inode_getsecctx
        security_inode_notifysecctx
have been trained to keep a full set of attributes
using the "lsm1='data1',lsm2='data2'" format.

A prctl interface has been added to identify which
security module should be invoked when secids are
translated to secctx and back. If none is specified the
first module will be used. This eliminates the ambiguity
of what data will be seen in user-space at the cost of
requiring user-space code to be explicit about what it
wants to see.

A set of secids are used in most cases where a single
secid was used in the past. A single secid is used within
secuirty modules, whereas a secid for each compiled module
that uses secids is maintained elsewhere. The secmarks used
by netfilter requires a mechanism to map multiple secids into
a single u32. That is provided.

The netlabel system is enhanced to allow it to
detect that security modules are trying to set network
labels that are incompatible. If incompatibilty is detected
setting the networks label will fail. As SELinux and Smack use
the interfaces differently, a system with both enabled requires
significant configuration attention to use network labeling
effectively.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/cred.h                    |   3 +-
 include/linux/lsm_hooks.h               |  52 +++--
 include/linux/security.h                | 160 ++++++++++---
 include/net/flow.h                      |   5 +-
 include/net/netlabel.h                  |  16 +-
 include/net/scm.h                       |   4 +-
 include/uapi/linux/prctl.h              |   4 +
 kernel/audit.c                          |  23 +-
 kernel/audit.h                          |   9 +-
 kernel/auditfilter.c                    |   4 +-
 kernel/auditsc.c                        |  42 ++--
 kernel/cred.c                           |   6 +-
 kernel/fork.c                           |   3 +
 kernel/signal.c                         |   1 +
 net/ipv4/cipso_ipv4.c                   |  19 +-
 net/ipv4/ip_sockglue.c                  |   6 +-
 net/netfilter/nf_conntrack_netlink.c    |  12 +-
 net/netfilter/nf_conntrack_standalone.c |   6 +-
 net/netfilter/nfnetlink_queue.c         |   9 +-
 net/netfilter/xt_SECMARK.c              |   7 +-
 net/netlabel/netlabel_kapi.c            |  52 ++++-
 net/netlabel/netlabel_unlabeled.c       |  30 +--
 net/netlabel/netlabel_unlabeled.h       |   2 +-
 net/netlabel/netlabel_user.c            |   4 +-
 net/unix/af_unix.c                      |  22 +-
 net/xfrm/xfrm_policy.c                  |   6 +-
 net/xfrm/xfrm_state.c                   |   3 +-
 security/Kconfig                        |  25 +-
 security/Makefile                       |   1 +
 security/integrity/ima/ima_policy.c     |   7 +-
 security/security.c                     | 402 ++++++++++++++++++++++++++++----
 security/selinux/hooks.c                | 106 +++++----
 security/selinux/include/audit.h        |   2 +-
 security/selinux/include/xfrm.h         |   9 +-
 security/selinux/netlabel.c             |  10 +-
 security/selinux/ss/services.c          |  10 +-
 security/selinux/xfrm.c                 |  25 +-
 security/smack/smack.h                  |   5 +
 security/smack/smack_access.c           |   4 +-
 security/smack/smack_lsm.c              | 178 +++++++++-----
 security/smack/smack_netfilter.c        |  20 +-
 security/smack/smackfs.c                |  14 +-
 42 files changed, 979 insertions(+), 349 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 631286535d0f..217814eb1925 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -23,6 +23,7 @@
 
 struct cred;
 struct inode;
+struct secids;
 
 /*
  * COW Supplementary groups list
@@ -161,7 +162,7 @@ extern const struct cred *override_creds(const struct cred *);
 extern void revert_creds(const struct cred *);
 extern struct cred *prepare_kernel_cred(struct task_struct *);
 extern int change_create_files_as(struct cred *, struct inode *);
-extern int set_security_override(struct cred *, u32);
+extern int set_security_override(struct cred *cred, struct secids *secid);
 extern int set_security_override_from_ctx(struct cred *, const char *);
 extern int set_create_files_as(struct cred *, struct inode *);
 extern void __init cred_init(void);
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 2e05734bc46e..41e9ad8b4cf1 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -28,6 +28,7 @@
 #include <linux/security.h>
 #include <linux/init.h>
 #include <linux/rculist.h>
+#include <net/netlabel.h>
 
 /**
  * union security_list_options - Linux Security Module hook function list
@@ -837,9 +838,8 @@
  *	SO_GETPEERSEC.  For tcp sockets this can be meaningful if the
  *	socket is associated with an ipsec SA.
  *	@sock is the local socket.
- *	@optval userspace memory where the security state is to be copied.
- *	@optlen userspace int where the module should copy the actual length
- *	of the security state.
+ *	@optval the security state.
+ *	@optlen the actual length of the security state.
  *	@len as input is the maximum length to copy to userspace provided
  *	by the caller.
  *	Return 0 if all is well, otherwise, typical getsockopt return
@@ -1512,7 +1512,7 @@ union security_list_options {
 					int flags);
 	int (*inode_listsecurity)(struct inode *inode, char *buffer,
 					size_t buffer_size);
-	void (*inode_getsecid)(struct inode *inode, u32 *secid);
+	void (*inode_getsecid)(struct inode *inode, struct secids *secid);
 	int (*inode_copy_up)(struct dentry *src, struct cred **new);
 	int (*inode_copy_up_xattr)(const char *name);
 
@@ -1542,7 +1542,7 @@ union security_list_options {
 	int (*cred_prepare)(struct cred *new, const struct cred *old,
 				gfp_t gfp);
 	void (*cred_transfer)(struct cred *new, const struct cred *old);
-	int (*kernel_act_as)(struct cred *new, u32 secid);
+	int (*kernel_act_as)(struct cred *new, struct secids *secid);
 	int (*kernel_create_files_as)(struct cred *new, struct inode *inode);
 	int (*kernel_module_request)(char *kmod_name);
 	int (*kernel_read_file)(struct file *file, enum kernel_read_file_id id);
@@ -1553,7 +1553,7 @@ union security_list_options {
 	int (*task_setpgid)(struct task_struct *p, pid_t pgid);
 	int (*task_getpgid)(struct task_struct *p);
 	int (*task_getsid)(struct task_struct *p);
-	void (*task_getsecid)(struct task_struct *p, u32 *secid);
+	void (*task_getsecid)(struct task_struct *p, struct secids *secid);
 	int (*task_setnice)(struct task_struct *p, int nice);
 	int (*task_setioprio)(struct task_struct *p, int ioprio);
 	int (*task_getioprio)(struct task_struct *p);
@@ -1571,7 +1571,7 @@ union security_list_options {
 	void (*task_to_inode)(struct task_struct *p, struct inode *inode);
 
 	int (*ipc_permission)(struct kern_ipc_perm *ipcp, short flag);
-	void (*ipc_getsecid)(struct kern_ipc_perm *ipcp, u32 *secid);
+	void (*ipc_getsecid)(struct kern_ipc_perm *ipcp, struct secids *secid);
 
 	int (*msg_msg_alloc_security)(struct msg_msg *msg);
 	void (*msg_msg_free_security)(struct msg_msg *msg);
@@ -1607,8 +1607,10 @@ union security_list_options {
 	int (*getprocattr)(struct task_struct *p, char *name, char **value);
 	int (*setprocattr)(const char *name, void *value, size_t size);
 	int (*ismaclabel)(const char *name);
-	int (*secid_to_secctx)(u32 secid, char **secdata, u32 *seclen);
-	int (*secctx_to_secid)(const char *secdata, u32 seclen, u32 *secid);
+	int (*secid_to_secctx)(struct secids *secid, char **secdata,
+				u32 *seclen);
+	int (*secctx_to_secid)(const char *secdata, u32 seclen,
+				struct secids *secid);
 	void (*release_secctx)(char *secdata, u32 seclen);
 
 	void (*inode_invalidate_secctx)(struct inode *inode);
@@ -1640,22 +1642,22 @@ union security_list_options {
 	int (*socket_setsockopt)(struct socket *sock, int level, int optname);
 	int (*socket_shutdown)(struct socket *sock, int how);
 	int (*socket_sock_rcv_skb)(struct sock *sk, struct sk_buff *skb);
-	int (*socket_getpeersec_stream)(struct socket *sock,
-					char __user *optval,
-					int __user *optlen, unsigned len);
+	int (*socket_getpeersec_stream)(struct socket *sock, char **optval,
+					int *optlen, unsigned int len);
 	int (*socket_getpeersec_dgram)(struct socket *sock,
-					struct sk_buff *skb, u32 *secid);
+					struct sk_buff *skb,
+					struct secids *secid);
 	int (*sk_alloc_security)(struct sock *sk, int family, gfp_t priority);
 	void (*sk_free_security)(struct sock *sk);
 	void (*sk_clone_security)(const struct sock *sk, struct sock *newsk);
-	void (*sk_getsecid)(struct sock *sk, u32 *secid);
+	void (*sk_getsecid)(struct sock *sk, struct secids *secid);
 	void (*sock_graft)(struct sock *sk, struct socket *parent);
 	int (*inet_conn_request)(struct sock *sk, struct sk_buff *skb,
 					struct request_sock *req);
 	void (*inet_csk_clone)(struct sock *newsk,
 				const struct request_sock *req);
 	void (*inet_conn_established)(struct sock *sk, struct sk_buff *skb);
-	int (*secmark_relabel_packet)(u32 secid);
+	int (*secmark_relabel_packet)(struct secids *secid);
 	void (*secmark_refcount_inc)(void);
 	void (*secmark_refcount_dec)(void);
 	void (*req_classify_flow)(const struct request_sock *req,
@@ -1688,15 +1690,16 @@ union security_list_options {
 				struct xfrm_user_sec_ctx *sec_ctx);
 	int (*xfrm_state_alloc_acquire)(struct xfrm_state *x,
 					struct xfrm_sec_ctx *polsec,
-					u32 secid);
+					const struct secids *secid);
 	void (*xfrm_state_free_security)(struct xfrm_state *x);
 	int (*xfrm_state_delete_security)(struct xfrm_state *x);
-	int (*xfrm_policy_lookup)(struct xfrm_sec_ctx *ctx, u32 fl_secid,
-					u8 dir);
+	int (*xfrm_policy_lookup)(struct xfrm_sec_ctx *ctx,
+					struct secids *fl_secid, u8 dir);
 	int (*xfrm_state_pol_flow_match)(struct xfrm_state *x,
 						struct xfrm_policy *xp,
 						const struct flowi *fl);
-	int (*xfrm_decode_session)(struct sk_buff *skb, u32 *secid, int ckall);
+	int (*xfrm_decode_session)(struct sk_buff *skb, struct secids *secid,
+					int ckall);
 #endif	/* CONFIG_SECURITY_NETWORK_XFRM */
 
 	/* key management security hooks */
@@ -1713,8 +1716,8 @@ union security_list_options {
 	int (*audit_rule_init)(u32 field, u32 op, char *rulestr,
 				void **lsmrule);
 	int (*audit_rule_known)(struct audit_krule *krule);
-	int (*audit_rule_match)(u32 secid, u32 field, u32 op, void *lsmrule,
-				struct audit_context *actx);
+	int (*audit_rule_match)(struct secids *secid, u32 field, u32 op,
+				void *lsmrule, struct audit_context *actx);
 	void (*audit_rule_free)(void *lsmrule);
 #endif /* CONFIG_AUDIT */
 
@@ -2051,4 +2054,11 @@ void lsm_early_cred(struct cred *cred);
 void lsm_early_inode(struct inode *inode);
 #endif
 
+#ifdef CONFIG_NETLABEL
+extern int lsm_sock_vet_attr(struct sock *sk,
+			     struct netlbl_lsm_secattr *secattr, u32 flags);
+#define LSM_SOCK_SELINUX	0x00000001
+#define LSM_SOCK_SMACK		0x00000002
+#endif /* CONFIG_NETLABEL */
+
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/include/linux/security.h b/include/linux/security.h
index 2912f34c2292..377073d89ec5 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -56,6 +56,7 @@ struct msg_queue;
 struct xattr;
 struct xfrm_sec_ctx;
 struct mm_struct;
+struct sk_buff;
 
 /* If capable should audit the security request */
 #define SECURITY_CAP_NOAUDIT 0
@@ -73,6 +74,70 @@ enum lsm_event {
 	LSM_POLICY_CHANGE,
 };
 
+/*
+ * A secid is an u32 unless stacking is involved,
+ * in which case it is a set of u32s, one for each module
+ * that uses secids.
+ */
+#ifdef CONFIG_SECURITY_STACKING
+
+struct secids {
+	u32 secmark;
+#ifdef CONFIG_SECURITY_SELINUX
+	u32 selinux;
+#endif
+#ifdef CONFIG_SECURITY_SMACK
+	u32 smack;
+#endif
+	u32 flags;
+};
+
+extern void secid_from_skb(struct secids *secid, const struct sk_buff *skb);
+extern void secid_to_skb(struct secids *secid, struct sk_buff *skb);
+extern void secid_set(struct secids *secid, u32 sid);
+extern void secid_update_secmark(struct secids *secid);
+extern bool secid_valid(const struct secids *secid);
+
+#else /* CONFIG_SECURITY_STACKING */
+
+struct secids {
+	union {
+		u32 secmark;
+#ifdef CONFIG_SECURITY_SELINUX
+		u32 selinux;
+#endif
+#ifdef CONFIG_SECURITY_SMACK
+		u32 smack;
+#endif
+	};
+};
+
+static inline void secid_set(struct secids *secids, u32 secid)
+{
+	secids->secmark = secid;
+}
+
+static inline void secid_update_secmark(struct secids *secids)
+{
+}
+
+static inline bool secid_valid(const struct secids *secids)
+{
+	return secids->secmark != 0;
+}
+
+#endif /* CONFIG_SECURITY_STACKING */
+
+static inline void secid_init(struct secids *secid)
+{
+	memset(secid, 0, sizeof(*secid));
+}
+
+static inline void secid_update_modules(struct secids *secids)
+{
+	secid_set(secids, secids->secmark);
+}
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, int audit);
@@ -104,7 +169,6 @@ extern int cap_task_setnice(struct task_struct *p, int nice);
 extern int cap_vm_enough_memory(struct mm_struct *mm, long pages);
 
 struct msghdr;
-struct sk_buff;
 struct sock;
 struct sockaddr;
 struct socket;
@@ -320,7 +384,7 @@ int security_inode_killpriv(struct dentry *dentry);
 int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getsecid(struct inode *inode, struct secids *secid);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
 int security_file_permission(struct file *file, int mask);
@@ -345,7 +409,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp);
 void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct secids *secid);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_read_file(struct file *file, enum kernel_read_file_id id);
@@ -356,7 +420,7 @@ int security_task_fix_setuid(struct cred *new, const struct cred *old,
 int security_task_setpgid(struct task_struct *p, pid_t pgid);
 int security_task_getpgid(struct task_struct *p);
 int security_task_getsid(struct task_struct *p);
-void security_task_getsecid(struct task_struct *p, u32 *secid);
+void security_task_getsecid(struct task_struct *p, struct secids *secid);
 int security_task_setnice(struct task_struct *p, int nice);
 int security_task_setioprio(struct task_struct *p, int ioprio);
 int security_task_getioprio(struct task_struct *p);
@@ -373,7 +437,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct secids *secid);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct msg_queue *msq);
@@ -402,8 +466,9 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 			 size_t size);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
-int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
-int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
+int security_secid_to_secctx(struct secids *secid, char **secdata, u32 *seclen);
+int security_secctx_to_secid(const char *secdata, u32 seclen,
+				struct secids *secid);
 void security_release_secctx(char *secdata, u32 seclen);
 
 void security_inode_invalidate_secctx(struct inode *inode);
@@ -801,24 +866,31 @@ static inline int security_inode_killpriv(struct dentry *dentry)
 	return cap_inode_killpriv(dentry);
 }
 
-static inline int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc)
+static inline int security_inode_getsecurity(struct inode *inode,
+					     const char *name, void **buffer,
+					     bool alloc)
 {
 	return -EOPNOTSUPP;
 }
 
-static inline int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
+static inline int security_inode_setsecurity(struct inode *inode,
+					     const char *name,
+					     const void *value, size_t size,
+					     int flags)
 {
 	return -EOPNOTSUPP;
 }
 
-static inline int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
+static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
+					      size_t buffer_size)
 {
 	return 0;
 }
 
-static inline void security_inode_getsecid(struct inode *inode, u32 *secid)
+static inline void security_inode_getsecid(struct inode *inode,
+					   struct secids *secid)
 {
-	*secid = 0;
+	secid->secmark = 0;
 }
 
 static inline int security_inode_copy_up(struct dentry *src, struct cred **new)
@@ -931,7 +1003,8 @@ static inline void security_transfer_creds(struct cred *new,
 {
 }
 
-static inline int security_kernel_act_as(struct cred *cred, u32 secid)
+static inline int security_kernel_act_as(struct cred *cred,
+					 struct secids *secid)
 {
 	return 0;
 }
@@ -982,9 +1055,10 @@ static inline int security_task_getsid(struct task_struct *p)
 	return 0;
 }
 
-static inline void security_task_getsecid(struct task_struct *p, u32 *secid)
+static inline void security_task_getsecid(struct task_struct *p,
+					  struct secids *secid)
 {
-	*secid = 0;
+	secid->secmark = 0;
 }
 
 static inline int security_task_setnice(struct task_struct *p, int nice)
@@ -1046,7 +1120,8 @@ static inline int security_task_prctl(int option, unsigned long arg2,
 	return cap_task_prctl(option, arg2, arg3, arg4, arg5);
 }
 
-static inline void security_task_to_inode(struct task_struct *p, struct inode *inode)
+static inline void security_task_to_inode(struct task_struct *p,
+					  struct inode *inode)
 { }
 
 static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
@@ -1055,9 +1130,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
 	return 0;
 }
 
-static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp,
+					 struct secids *secid)
 {
-	*secid = 0;
+	secid->secmark = 0;
 }
 
 static inline int security_msg_msg_alloc(struct msg_msg *msg)
@@ -1177,14 +1253,15 @@ static inline int security_ismaclabel(const char *name)
 	return 0;
 }
 
-static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+static inline int security_secid_to_secctx(struct secids *secid,
+					   char **secdata, u32 *seclen)
 {
 	return -EOPNOTSUPP;
 }
 
 static inline int security_secctx_to_secid(const char *secdata,
 					   u32 seclen,
-					   u32 *secid)
+					   struct secids *secid)
 {
 	return -EOPNOTSUPP;
 }
@@ -1233,7 +1310,8 @@ int security_socket_shutdown(struct socket *sock, int how);
 int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len);
-int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid);
+int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
+				     struct secids *secid);
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
 void security_sk_free(struct sock *sk);
 void security_sk_clone(const struct sock *sk, struct sock *newsk);
@@ -1246,7 +1324,7 @@ void security_inet_csk_clone(struct sock *newsk,
 			const struct request_sock *req);
 void security_inet_conn_established(struct sock *sk,
 			struct sk_buff *skb);
-int security_secmark_relabel_packet(u32 secid);
+int security_secmark_relabel_packet(struct secids *secid);
 void security_secmark_refcount_inc(void);
 void security_secmark_refcount_dec(void);
 int security_tun_dev_alloc_security(void **security);
@@ -1354,13 +1432,17 @@ static inline int security_sock_rcv_skb(struct sock *sk,
 	return 0;
 }
 
-static inline int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
-						    int __user *optlen, unsigned len)
+static inline int security_socket_getpeersec_stream(struct socket *sock,
+						    char __user *optval,
+						    int __user *optlen,
+						    unsigned int len)
 {
 	return -ENOPROTOOPT;
 }
 
-static inline int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
+static inline int security_socket_getpeersec_dgram(struct socket *sock,
+						   struct sk_buff *skb,
+						   struct secids *secid)
 {
 	return -ENOPROTOOPT;
 }
@@ -1406,7 +1488,7 @@ static inline void security_inet_conn_established(struct sock *sk,
 {
 }
 
-static inline int security_secmark_relabel_packet(u32 secid)
+static inline int security_secmark_relabel_packet(struct secids *secid)
 {
 	return 0;
 }
@@ -1484,14 +1566,16 @@ void security_xfrm_policy_free(struct xfrm_sec_ctx *ctx);
 int security_xfrm_policy_delete(struct xfrm_sec_ctx *ctx);
 int security_xfrm_state_alloc(struct xfrm_state *x, struct xfrm_user_sec_ctx *sec_ctx);
 int security_xfrm_state_alloc_acquire(struct xfrm_state *x,
-				      struct xfrm_sec_ctx *polsec, u32 secid);
+				      struct xfrm_sec_ctx *polsec,
+				      const struct secids *secid);
 int security_xfrm_state_delete(struct xfrm_state *x);
 void security_xfrm_state_free(struct xfrm_state *x);
-int security_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid, u8 dir);
+int security_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx,
+					struct secids *fl_secid, u8 dir);
 int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 				       struct xfrm_policy *xp,
 				       const struct flowi *fl);
-int security_xfrm_decode_session(struct sk_buff *skb, u32 *secid);
+int security_xfrm_decode_session(struct sk_buff *skb, struct secids *secid);
 void security_skb_classify_flow(struct sk_buff *skb, struct flowi *fl);
 
 #else	/* CONFIG_SECURITY_NETWORK_XFRM */
@@ -1524,7 +1608,8 @@ static inline int security_xfrm_state_alloc(struct xfrm_state *x,
 }
 
 static inline int security_xfrm_state_alloc_acquire(struct xfrm_state *x,
-					struct xfrm_sec_ctx *polsec, u32 secid)
+						struct xfrm_sec_ctx *polsec,
+						const struct secids *secid)
 {
 	return 0;
 }
@@ -1538,7 +1623,8 @@ static inline int security_xfrm_state_delete(struct xfrm_state *x)
 	return 0;
 }
 
-static inline int security_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid, u8 dir)
+static inline int security_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx,
+					struct secids *fl_secid, u8 dir)
 {
 	return 0;
 }
@@ -1549,7 +1635,8 @@ static inline int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 	return 1;
 }
 
-static inline int security_xfrm_decode_session(struct sk_buff *skb, u32 *secid)
+static inline int security_xfrm_decode_session(struct sk_buff *skb,
+					       struct secids *secid)
 {
 	return 0;
 }
@@ -1685,8 +1772,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 #ifdef CONFIG_SECURITY
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
-			      struct audit_context *actx);
+int security_audit_rule_match(struct secids *secid, u32 field, u32 op,
+			      void *lsmrule, struct audit_context *actx);
 void security_audit_rule_free(void *lsmrule);
 
 #else
@@ -1702,8 +1789,9 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
 	return 0;
 }
 
-static inline int security_audit_rule_match(u32 secid, u32 field, u32 op,
-				   void *lsmrule, struct audit_context *actx)
+static inline int security_audit_rule_match(struct secids *secid, u32 field,
+					    u32 op, void *lsmrule,
+					    struct audit_context *actx)
 {
 	return 0;
 }
diff --git a/include/net/flow.h b/include/net/flow.h
index f1624fd5b1d0..1583cee0e3c7 100644
--- a/include/net/flow.h
+++ b/include/net/flow.h
@@ -11,6 +11,7 @@
 #include <linux/socket.h>
 #include <linux/in6.h>
 #include <linux/atomic.h>
+#include <linux/security.h>
 #include <net/flow_dissector.h>
 #include <linux/uidgid.h>
 
@@ -37,7 +38,7 @@ struct flowi_common {
 #define FLOWI_FLAG_ANYSRC		0x01
 #define FLOWI_FLAG_KNOWN_NH		0x02
 #define FLOWI_FLAG_SKIP_NH_OIF		0x04
-	__u32	flowic_secid;
+	struct secids flowic_secid;
 	struct flowi_tunnel flowic_tun_key;
 	kuid_t  flowic_uid;
 };
@@ -107,7 +108,7 @@ static inline void flowi4_init_output(struct flowi4 *fl4, int oif,
 	fl4->flowi4_scope = scope;
 	fl4->flowi4_proto = proto;
 	fl4->flowi4_flags = flags;
-	fl4->flowi4_secid = 0;
+	secid_init(&fl4->flowi4_secid);
 	fl4->flowi4_tun_key.tun_id = 0;
 	fl4->flowi4_uid = uid;
 	fl4->daddr = daddr;
diff --git a/include/net/netlabel.h b/include/net/netlabel.h
index 72d6435fc16c..5c7e19498a81 100644
--- a/include/net/netlabel.h
+++ b/include/net/netlabel.h
@@ -111,7 +111,7 @@ struct calipso_doi;
 
 /* NetLabel audit information */
 struct netlbl_audit {
-	u32 secid;
+	struct secids secid;
 	kuid_t loginuid;
 	unsigned int sessionid;
 };
@@ -215,7 +215,7 @@ struct netlbl_lsm_secattr {
 			struct netlbl_lsm_catmap *cat;
 			u32 lvl;
 		} mls;
-		u32 secid;
+		struct secids secid;
 	} attr;
 };
 
@@ -429,7 +429,7 @@ int netlbl_cfg_unlbl_static_add(struct net *net,
 				const void *addr,
 				const void *mask,
 				u16 family,
-				u32 secid,
+				struct secids *secid,
 				struct netlbl_audit *audit_info);
 int netlbl_cfg_unlbl_static_del(struct net *net,
 				const char *dev_name,
@@ -472,6 +472,8 @@ int netlbl_catmap_setlong(struct netlbl_lsm_catmap **catmap,
 			  u32 offset,
 			  unsigned long bitmap,
 			  gfp_t flags);
+bool netlbl_secattr_equal(const struct netlbl_lsm_secattr *secattr_a,
+			  const struct netlbl_lsm_secattr *secattr_b);
 
 /* Bitmap functions
  */
@@ -537,7 +539,7 @@ static inline int netlbl_cfg_unlbl_static_add(struct net *net,
 					      const void *addr,
 					      const void *mask,
 					      u16 family,
-					      u32 secid,
+					      struct secids *secid,
 					      struct netlbl_audit *audit_info)
 {
 	return -ENOSYS;
@@ -623,6 +625,12 @@ static inline int netlbl_catmap_setlong(struct netlbl_lsm_catmap **catmap,
 {
 	return 0;
 }
+static inline bool netlbl_secattr_equal(
+				const struct netlbl_lsm_secattr *secattr_a,
+				const struct netlbl_lsm_secattr *secattr_b)
+{
+	return true;
+}
 static inline int netlbl_enabled(void)
 {
 	return 0;
diff --git a/include/net/scm.h b/include/net/scm.h
index 903771c8d4e3..292575f75201 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -32,7 +32,7 @@ struct scm_cookie {
 	struct scm_fp_list	*fp;		/* Passed files		*/
 	struct scm_creds	creds;		/* Skb credentials	*/
 #ifdef CONFIG_SECURITY_NETWORK
-	u32			secid;		/* Passed security ID 	*/
+	struct secids		secid;		/* Passed security ID	*/
 #endif
 };
 
@@ -96,7 +96,7 @@ static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct sc
 	int err;
 
 	if (test_bit(SOCK_PASSSEC, &sock->flags)) {
-		err = security_secid_to_secctx(scm->secid, &secdata, &seclen);
+		err = security_secid_to_secctx(&scm->secid, &secdata, &seclen);
 
 		if (!err) {
 			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, seclen, secdata);
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index af5f8c2df87a..b17797d5844c 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -207,4 +207,8 @@ struct prctl_mm_map {
 # define PR_SVE_VL_LEN_MASK		0xffff
 # define PR_SVE_VL_INHERIT		(1 << 17) /* inherit across exec */
 
+/* Control the LSM specific peer information */
+#define	PR_GET_DISPLAY_LSM	52
+#define	PR_SET_DISPLAY_LSM	53
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/audit.c b/kernel/audit.c
index 227db99b0f19..5886f4b51bab 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -140,7 +140,7 @@ static u32	audit_backlog_wait_time = AUDIT_BACKLOG_WAIT_TIME;
 /* The identity of the user shutting down the audit system. */
 kuid_t		audit_sig_uid = INVALID_UID;
 pid_t		audit_sig_pid = -1;
-u32		audit_sig_sid = 0;
+struct secids	audit_sig_sid;
 
 /* Records can be lost in several ways:
    0) [suppressed in audit_alloc]
@@ -1376,20 +1376,21 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 	}
 	case AUDIT_SIGNAL_INFO:
 		len = 0;
-		if (audit_sig_sid) {
-			err = security_secid_to_secctx(audit_sig_sid, &ctx, &len);
+		if (secid_valid(&audit_sig_sid)) {
+			err = security_secid_to_secctx(&audit_sig_sid, &ctx,
+							&len);
 			if (err)
 				return err;
 		}
 		sig_data = kmalloc(sizeof(*sig_data) + len, GFP_KERNEL);
 		if (!sig_data) {
-			if (audit_sig_sid)
+			if (secid_valid(&audit_sig_sid))
 				security_release_secctx(ctx, len);
 			return -ENOMEM;
 		}
 		sig_data->uid = from_kuid(&init_user_ns, audit_sig_uid);
 		sig_data->pid = audit_sig_pid;
-		if (audit_sig_sid) {
+		if (secid_valid(&audit_sig_sid)) {
 			memcpy(sig_data->ctx, ctx, len);
 			security_release_secctx(ctx, len);
 		}
@@ -2112,12 +2113,12 @@ void audit_log_name(struct audit_context *context, struct audit_names *n,
 				 from_kgid(&init_user_ns, n->gid),
 				 MAJOR(n->rdev),
 				 MINOR(n->rdev));
-	if (n->osid != 0) {
+	if (secid_valid(&n->osid)) {
 		char *ctx = NULL;
 		u32 len;
 		if (security_secid_to_secctx(
-			n->osid, &ctx, &len)) {
-			audit_log_format(ab, " osid=%u", n->osid);
+			&n->osid, &ctx, &len)) {
+			audit_log_format(ab, " osid=%u", n->osid.secmark);
 			if (call_panic)
 				*call_panic = 2;
 		} else {
@@ -2155,13 +2156,13 @@ int audit_log_task_context(struct audit_buffer *ab)
 	char *ctx = NULL;
 	unsigned len;
 	int error;
-	u32 sid;
+	struct secids sid;
 
 	security_task_getsecid(current, &sid);
-	if (!sid)
+	if (!secid_valid(&sid))
 		return 0;
 
-	error = security_secid_to_secctx(sid, &ctx, &len);
+	error = security_secid_to_secctx(&sid, &ctx, &len);
 	if (error) {
 		if (error != -EINVAL)
 			goto error_path;
diff --git a/kernel/audit.h b/kernel/audit.h
index af5bc59487ed..d45b75ff7931 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -21,6 +21,7 @@
 
 #include <linux/fs.h>
 #include <linux/audit.h>
+#include <linux/security.h>
 #include <linux/skbuff.h>
 #include <uapi/linux/mqueue.h>
 #include <linux/tty.h>
@@ -89,7 +90,7 @@ struct audit_names {
 	kuid_t			uid;
 	kgid_t			gid;
 	dev_t			rdev;
-	u32			osid;
+	struct secids		osid;
 	struct audit_cap_data	fcap;
 	unsigned int		fcap_ver;
 	unsigned char		type;		/* record type */
@@ -146,7 +147,7 @@ struct audit_context {
 	kuid_t		    target_auid;
 	kuid_t		    target_uid;
 	unsigned int	    target_sessionid;
-	u32		    target_sid;
+	struct secids	    target_sid;
 	char		    target_comm[TASK_COMM_LEN];
 
 	struct audit_tree_refs *trees, *first_trees;
@@ -163,7 +164,7 @@ struct audit_context {
 			kuid_t			uid;
 			kgid_t			gid;
 			umode_t			mode;
-			u32			osid;
+			struct secids		osid;
 			int			has_perm;
 			uid_t			perm_uid;
 			gid_t			perm_gid;
@@ -328,7 +329,7 @@ extern char *audit_unpack_string(void **bufp, size_t *remain, size_t len);
 
 extern pid_t audit_sig_pid;
 extern kuid_t audit_sig_uid;
-extern u32 audit_sig_sid;
+extern struct secids audit_sig_sid;
 
 extern int audit_filter(int msgtype, unsigned int listtype);
 
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 4a1758adb222..cf76aa3eb6da 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1328,7 +1328,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 		for (i = 0; i < e->rule.field_count; i++) {
 			struct audit_field *f = &e->rule.fields[i];
 			pid_t pid;
-			u32 sid;
+			struct secids sid;
 
 			switch (f->type) {
 			case AUDIT_PID:
@@ -1359,7 +1359,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_CLR:
 				if (f->lsm_rule) {
 					security_task_getsecid(current, &sid);
-					result = security_audit_rule_match(sid,
+					result = security_audit_rule_match(&sid,
 							f->type, f->op, f->lsm_rule, NULL);
 				}
 				break;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index e80459f7e132..289c2f6b9ef0 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -112,7 +112,7 @@ struct audit_aux_data_pids {
 	kuid_t			target_auid[AUDIT_AUX_PIDS];
 	kuid_t			target_uid[AUDIT_AUX_PIDS];
 	unsigned int		target_sessionid[AUDIT_AUX_PIDS];
-	u32			target_sid[AUDIT_AUX_PIDS];
+	struct secids		target_sid[AUDIT_AUX_PIDS];
 	char 			target_comm[AUDIT_AUX_PIDS][TASK_COMM_LEN];
 	int			pid_count;
 };
@@ -446,10 +446,11 @@ static int audit_filter_rules(struct task_struct *tsk,
 {
 	const struct cred *cred;
 	int i, need_sid = 1;
-	u32 sid;
+	struct secids sid;
 	unsigned int sessionid;
 
-	cred = rcu_dereference_check(tsk->cred, tsk == current || task_creation);
+	cred = rcu_dereference_check(tsk->cred,
+					tsk == current || task_creation);
 
 	for (i = 0; i < rule->field_count; i++) {
 		struct audit_field *f = &rule->fields[i];
@@ -629,7 +630,8 @@ static int audit_filter_rules(struct task_struct *tsk,
 					security_task_getsecid(tsk, &sid);
 					need_sid = 0;
 				}
-				result = security_audit_rule_match(sid, f->type,
+				result = security_audit_rule_match(&sid,
+								  f->type,
 				                                  f->op,
 				                                  f->lsm_rule,
 				                                  ctx);
@@ -646,13 +648,17 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find files that match */
 				if (name) {
 					result = security_audit_rule_match(
-					           name->osid, f->type, f->op,
+						   &name->osid, f->type, f->op,
 					           f->lsm_rule, ctx);
 				} else if (ctx) {
-					list_for_each_entry(n, &ctx->names_list, list) {
-						if (security_audit_rule_match(n->osid, f->type,
-									      f->op, f->lsm_rule,
-									      ctx)) {
+					list_for_each_entry(n, &ctx->names_list,
+							list) {
+						if (security_audit_rule_match(
+								&n->osid,
+								f->type,
+								f->op,
+								f->lsm_rule,
+								ctx)) {
 							++result;
 							break;
 						}
@@ -661,7 +667,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				if (security_audit_rule_match(ctx->ipc.osid,
+				if (security_audit_rule_match(&ctx->ipc.osid,
 							      f->type, f->op,
 							      f->lsm_rule, ctx))
 					++result;
@@ -969,7 +975,7 @@ static inline void audit_free_context(struct audit_context *context)
 
 static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 				 kuid_t auid, kuid_t uid, unsigned int sessionid,
-				 u32 sid, char *comm)
+				 struct secids *sid, char *comm)
 {
 	struct audit_buffer *ab;
 	char *ctx = NULL;
@@ -1191,17 +1197,17 @@ static void show_special(struct audit_context *context, int *call_panic)
 				context->socketcall.args[i]);
 		break; }
 	case AUDIT_IPC: {
-		u32 osid = context->ipc.osid;
+		struct secids osid = context->ipc.osid;
 
 		audit_log_format(ab, "ouid=%u ogid=%u mode=%#ho",
 				 from_kuid(&init_user_ns, context->ipc.uid),
 				 from_kgid(&init_user_ns, context->ipc.gid),
 				 context->ipc.mode);
-		if (osid) {
+		if (secid_valid(&osid)) {
 			char *ctx = NULL;
 			u32 len;
-			if (security_secid_to_secctx(osid, &ctx, &len)) {
-				audit_log_format(ab, " osid=%u", osid);
+			if (security_secid_to_secctx(&osid, &ctx, &len)) {
+				audit_log_format(ab, " osid=%u", osid.secmark);
 				*call_panic = 1;
 			} else {
 				audit_log_format(ab, " obj=%s", ctx);
@@ -1424,7 +1430,7 @@ static void audit_log_exit(struct audit_context *context, struct task_struct *ts
 						  axs->target_auid[i],
 						  axs->target_uid[i],
 						  axs->target_sessionid[i],
-						  axs->target_sid[i],
+						  &axs->target_sid[i],
 						  axs->target_comm[i]))
 				call_panic = 1;
 	}
@@ -1433,7 +1439,7 @@ static void audit_log_exit(struct audit_context *context, struct task_struct *ts
 	    audit_log_pid_context(context, context->target_pid,
 				  context->target_auid, context->target_uid,
 				  context->target_sessionid,
-				  context->target_sid, context->target_comm))
+				  &context->target_sid, context->target_comm))
 			call_panic = 1;
 
 	if (context->pwd.dentry && context->pwd.mnt) {
@@ -1582,7 +1588,7 @@ void __audit_syscall_exit(int success, long return_code)
 	context->aux = NULL;
 	context->aux_pids = NULL;
 	context->target_pid = 0;
-	context->target_sid = 0;
+	memset(&context->target_sid, 0, sizeof(context->target_sid));
 	context->sockaddr_len = 0;
 	context->type = 0;
 	context->fds[0] = -1;
diff --git a/kernel/cred.c b/kernel/cred.c
index fa2061ee4955..362de31fcc5b 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -650,7 +650,7 @@ EXPORT_SYMBOL(prepare_kernel_cred);
  * Set the LSM security ID in a set of credentials so that the subjective
  * security is overridden when an alternative set of credentials is used.
  */
-int set_security_override(struct cred *new, u32 secid)
+int set_security_override(struct cred *new, struct secids *secid)
 {
 	return security_kernel_act_as(new, secid);
 }
@@ -668,14 +668,14 @@ EXPORT_SYMBOL(set_security_override);
  */
 int set_security_override_from_ctx(struct cred *new, const char *secctx)
 {
-	u32 secid;
+	struct secids secid;
 	int ret;
 
 	ret = security_secctx_to_secid(secctx, strlen(secctx), &secid);
 	if (ret < 0)
 		return ret;
 
-	return set_security_override(new, secid);
+	return set_security_override(new, &secid);
 }
 EXPORT_SYMBOL(set_security_override_from_ctx);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index be8aa5b98666..de24623b674c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1769,6 +1769,9 @@ static __latent_entropy struct task_struct *copy_process(
 	p->sequential_io	= 0;
 	p->sequential_io_avg	= 0;
 #endif
+#ifdef CONFIG_SECURITY
+	p->security = NULL;
+#endif
 
 	/* Perform scheduler related setup. Assign this task to a CPU. */
 	retval = sched_fork(clone_flags, p);
diff --git a/kernel/signal.c b/kernel/signal.c
index b033292f4beb..5cae2fa1d0ce 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -743,6 +743,7 @@ static int check_kill_permission(int sig, struct siginfo *info,
 {
 	struct pid *sid;
 	int error;
+	struct secids secid;
 
 	if (!valid_signal(sig))
 		return -EINVAL;
diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index 82178cc69c96..b3e267ca7c19 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -43,6 +43,7 @@
 #include <linux/string.h>
 #include <linux/jhash.h>
 #include <linux/audit.h>
+#include <linux/security.h>
 #include <linux/slab.h>
 #include <net/ip.h>
 #include <net/icmp.h>
@@ -120,6 +121,9 @@ int cipso_v4_rbm_strictvalid = 1;
 /* Base length of the local tag (non-standard tag).
  *  Tag definition (may change between kernel versions)
  *
+ * If module stacking is not enabled or if there is exactly
+ * one security module that uses secids.
+ *
  * 0          8          16         24         32
  * +----------+----------+----------+----------+
  * | 10000000 | 00000110 | 32-bit secid value  |
@@ -127,8 +131,17 @@ int cipso_v4_rbm_strictvalid = 1;
  * | in (host byte order)|
  * +----------+----------+
  *
+ * If module stacking is enabled
+ *
+ * 0          8          16         24         32
+ * +----------+----------+----------+----------+ ... +----------+----------+
+ * | 10000000 | 00000110 | 32-bit secid value  |     | 32-bit secid value  |
+ * +----------+----------+----------+----------+ ... +----------+----------+
+ * | in (host byte order)|
+ * +----------+----------+
+ *
  */
-#define CIPSO_V4_TAG_LOC_BLEN         6
+#define CIPSO_V4_TAG_LOC_BLEN         (2 + sizeof(struct secids))
 
 /*
  * Helper Functions
@@ -1480,7 +1493,7 @@ static int cipso_v4_gentag_loc(const struct cipso_v4_doi *doi_def,
 
 	buffer[0] = CIPSO_V4_TAG_LOCAL;
 	buffer[1] = CIPSO_V4_TAG_LOC_BLEN;
-	*(u32 *)&buffer[2] = secattr->attr.secid;
+	memcpy(&buffer[2], &secattr->attr.secid, sizeof(struct secids));
 
 	return CIPSO_V4_TAG_LOC_BLEN;
 }
@@ -1500,7 +1513,7 @@ static int cipso_v4_parsetag_loc(const struct cipso_v4_doi *doi_def,
 				 const unsigned char *tag,
 				 struct netlbl_lsm_secattr *secattr)
 {
-	secattr->attr.secid = *(u32 *)&tag[2];
+	memcpy(&secattr->attr.secid, &tag[2], sizeof(struct secids));
 	secattr->flags |= NETLBL_SECATTR_SECID;
 
 	return 0;
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 008be04ac1cc..05229e390977 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -129,14 +129,16 @@ static void ip_cmsg_recv_checksum(struct msghdr *msg, struct sk_buff *skb,
 static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
 {
 	char *secdata;
-	u32 seclen, secid;
+	u32 seclen;
+	struct secids secid;
 	int err;
 
+	secid_init(&secid);
 	err = security_socket_getpeersec_dgram(NULL, skb, &secid);
 	if (err)
 		return;
 
-	err = security_secid_to_secctx(secid, &secdata, &seclen);
+	err = security_secid_to_secctx(&secid, &secdata, &seclen);
 	if (err)
 		return;
 
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index dd177ebee9aa..e92da90b87f3 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -312,8 +312,12 @@ static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
 	struct nlattr *nest_secctx;
 	int len, ret;
 	char *secctx;
+	struct secids secid;
 
-	ret = security_secid_to_secctx(ct->secmark, &secctx, &len);
+	secid_init(&secid);
+	secid.secmark = ct->secmark;
+
+	ret = security_secid_to_secctx(&secid, &secctx, &len);
 	if (ret)
 		return 0;
 
@@ -566,8 +570,12 @@ static inline int ctnetlink_secctx_size(const struct nf_conn *ct)
 {
 #ifdef CONFIG_NF_CONNTRACK_SECMARK
 	int len, ret;
+	struct secids secid;
+
+	secid_init(&secid);
+	secid.secmark = ct->secmark;
 
-	ret = security_secid_to_secctx(ct->secmark, NULL, &len);
+	ret = security_secid_to_secctx(&secid, NULL, &len);
 	if (ret)
 		return 0;
 
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index 9123fdec5e14..37d089235659 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -181,8 +181,12 @@ static void ct_show_secctx(struct seq_file *s, const struct nf_conn *ct)
 	int ret;
 	u32 len;
 	char *secctx;
+	struct secids secid;
 
-	ret = security_secid_to_secctx(ct->secmark, &secctx, &len);
+	secid_init(&secid);
+	secid.secmark = ct->secmark;
+
+	ret = security_secid_to_secctx(&secid, &secctx, &len);
 	if (ret)
 		return;
 
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 8bba23160a68..4f1f81fe7d18 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -286,13 +286,18 @@ static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
 {
 	u32 seclen = 0;
 #if IS_ENABLED(CONFIG_NETWORK_SECMARK)
+	struct secids secid;
+
 	if (!skb || !sk_fullsock(skb->sk))
 		return 0;
 
 	read_lock_bh(&skb->sk->sk_callback_lock);
 
-	if (skb->secmark)
-		security_secid_to_secctx(skb->secmark, secdata, &seclen);
+	if (skb->secmark) {
+		secid_init(&secid);
+		secid.secmark = skb->secmark;
+		security_secid_to_secctx(&secid, secdata, &seclen);
+	}
 
 	read_unlock_bh(&skb->sk->sk_callback_lock);
 #endif
diff --git a/net/netfilter/xt_SECMARK.c b/net/netfilter/xt_SECMARK.c
index 9faf5e050b79..d5a0edf9d08b 100644
--- a/net/netfilter/xt_SECMARK.c
+++ b/net/netfilter/xt_SECMARK.c
@@ -52,12 +52,15 @@ secmark_tg(struct sk_buff *skb, const struct xt_action_param *par)
 static int checkentry_lsm(struct xt_secmark_target_info *info)
 {
 	int err;
+	struct secids secid;
 
 	info->secctx[SECMARK_SECCTX_MAX - 1] = '\0';
 	info->secid = 0;
 
 	err = security_secctx_to_secid(info->secctx, strlen(info->secctx),
-				       &info->secid);
+				       &secid);
+	info->secid = secid.secmark;
+
 	if (err) {
 		if (err == -EINVAL)
 			pr_info("invalid security context \'%s\'\n", info->secctx);
@@ -69,7 +72,7 @@ static int checkentry_lsm(struct xt_secmark_target_info *info)
 		return -ENOENT;
 	}
 
-	err = security_secmark_relabel_packet(info->secid);
+	err = security_secmark_relabel_packet(&secid);
 	if (err) {
 		pr_info("unable to obtain relabeling permission\n");
 		return err;
diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index ea7c67050792..e23bad01a149 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -224,7 +224,7 @@ int netlbl_cfg_unlbl_static_add(struct net *net,
 				const void *addr,
 				const void *mask,
 				u16 family,
-				u32 secid,
+				struct secids *secid,
 				struct netlbl_audit *audit_info)
 {
 	u32 addr_len;
@@ -1461,6 +1461,56 @@ int netlbl_cache_add(const struct sk_buff *skb, u16 family,
 	return -ENOMSG;
 }
 
+/**
+ * netlbl_secattr_equal - Compare two lsm secattrs
+ * @secattr_a: one security attribute
+ * @secattr_b: the other security attribute
+ *
+ * Description:
+ * Compare two lsm security attribute structures.
+ * Don't compare secid fields, as those are distinct.
+ * Returns true if they are the same, false otherwise.
+ *
+ */
+bool netlbl_secattr_equal(const struct netlbl_lsm_secattr *secattr_a,
+			  const struct netlbl_lsm_secattr *secattr_b)
+{
+	struct netlbl_lsm_catmap *iter_a;
+	struct netlbl_lsm_catmap *iter_b;
+
+	if (secattr_a == secattr_b)
+		return true;
+	if (!secattr_a || !secattr_b)
+		return false;
+
+	if ((secattr_a->flags & NETLBL_SECATTR_MLS_LVL) !=
+	    (secattr_b->flags & NETLBL_SECATTR_MLS_LVL))
+		return false;
+
+	if ((secattr_a->flags & NETLBL_SECATTR_MLS_LVL) &&
+	    secattr_a->attr.mls.lvl != secattr_b->attr.mls.lvl)
+		return false;
+
+	if ((secattr_a->flags & NETLBL_SECATTR_MLS_CAT) !=
+	    (secattr_b->flags & NETLBL_SECATTR_MLS_CAT))
+		return false;
+
+	iter_a = secattr_a->attr.mls.cat;
+	iter_b = secattr_b->attr.mls.cat;
+
+	while (iter_a && iter_b) {
+		if (iter_a->startbit != iter_b->startbit)
+			return false;
+		if (memcmp(iter_a->bitmap, iter_b->bitmap,
+			   sizeof(iter_a->bitmap)))
+			return false;
+		iter_a = iter_a->next;
+		iter_b = iter_b->next;
+	}
+
+	return !iter_a && !iter_b;
+}
+
 /*
  * Protocol Engine Functions
  */
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 22dc1b9d6362..a24d69b55fa9 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -80,7 +80,7 @@ struct netlbl_unlhsh_tbl {
 #define netlbl_unlhsh_addr4_entry(iter) \
 	container_of(iter, struct netlbl_unlhsh_addr4, list)
 struct netlbl_unlhsh_addr4 {
-	u32 secid;
+	struct secids secid;
 
 	struct netlbl_af4list list;
 	struct rcu_head rcu;
@@ -88,7 +88,7 @@ struct netlbl_unlhsh_addr4 {
 #define netlbl_unlhsh_addr6_entry(iter) \
 	container_of(iter, struct netlbl_unlhsh_addr6, list)
 struct netlbl_unlhsh_addr6 {
-	u32 secid;
+	struct secids secid;
 
 	struct netlbl_af6list list;
 	struct rcu_head rcu;
@@ -244,7 +244,7 @@ static struct netlbl_unlhsh_iface *netlbl_unlhsh_search_iface(int ifindex)
 static int netlbl_unlhsh_add_addr4(struct netlbl_unlhsh_iface *iface,
 				   const struct in_addr *addr,
 				   const struct in_addr *mask,
-				   u32 secid)
+				   struct secids *secid)
 {
 	int ret_val;
 	struct netlbl_unlhsh_addr4 *entry;
@@ -256,7 +256,7 @@ static int netlbl_unlhsh_add_addr4(struct netlbl_unlhsh_iface *iface,
 	entry->list.addr = addr->s_addr & mask->s_addr;
 	entry->list.mask = mask->s_addr;
 	entry->list.valid = 1;
-	entry->secid = secid;
+	entry->secid = *secid;
 
 	spin_lock(&netlbl_unlhsh_lock);
 	ret_val = netlbl_af4list_add(&entry->list, &iface->addr4_list);
@@ -284,7 +284,7 @@ static int netlbl_unlhsh_add_addr4(struct netlbl_unlhsh_iface *iface,
 static int netlbl_unlhsh_add_addr6(struct netlbl_unlhsh_iface *iface,
 				   const struct in6_addr *addr,
 				   const struct in6_addr *mask,
-				   u32 secid)
+				   struct secids *secid)
 {
 	int ret_val;
 	struct netlbl_unlhsh_addr6 *entry;
@@ -300,7 +300,7 @@ static int netlbl_unlhsh_add_addr6(struct netlbl_unlhsh_iface *iface,
 	entry->list.addr.s6_addr32[3] &= mask->s6_addr32[3];
 	entry->list.mask = *mask;
 	entry->list.valid = 1;
-	entry->secid = secid;
+	entry->secid = *secid;
 
 	spin_lock(&netlbl_unlhsh_lock);
 	ret_val = netlbl_af6list_add(&entry->list, &iface->addr6_list);
@@ -379,7 +379,7 @@ int netlbl_unlhsh_add(struct net *net,
 		      const void *addr,
 		      const void *mask,
 		      u32 addr_len,
-		      u32 secid,
+		      struct secids *secid,
 		      struct netlbl_audit *audit_info)
 {
 	int ret_val;
@@ -508,7 +508,7 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
 		if (dev != NULL)
 			dev_put(dev);
 		if (entry != NULL &&
-		    security_secid_to_secctx(entry->secid,
+		    security_secid_to_secctx(&entry->secid,
 					     &secctx, &secctx_len) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s", secctx);
 			security_release_secctx(secctx, secctx_len);
@@ -569,7 +569,7 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
 		if (dev != NULL)
 			dev_put(dev);
 		if (entry != NULL &&
-		    security_secid_to_secctx(entry->secid,
+		    security_secid_to_secctx(&entry->secid,
 					     &secctx, &secctx_len) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s", secctx);
 			security_release_secctx(secctx, secctx_len);
@@ -894,7 +894,7 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
 	void *addr;
 	void *mask;
 	u32 addr_len;
-	u32 secid;
+	struct secids secid;
 	struct netlbl_audit audit_info;
 
 	/* Don't allow users to add both IPv4 and IPv6 addresses for a
@@ -923,7 +923,7 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
 		return ret_val;
 
 	return netlbl_unlhsh_add(&init_net,
-				 dev_name, addr, mask, addr_len, secid,
+				 dev_name, addr, mask, addr_len, &secid,
 				 &audit_info);
 }
 
@@ -945,7 +945,7 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
 	void *addr;
 	void *mask;
 	u32 addr_len;
-	u32 secid;
+	struct secids secid;
 	struct netlbl_audit audit_info;
 
 	/* Don't allow users to add both IPv4 and IPv6 addresses for a
@@ -972,7 +972,7 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
 		return ret_val;
 
 	return netlbl_unlhsh_add(&init_net,
-				 NULL, addr, mask, addr_len, secid,
+				 NULL, addr, mask, addr_len, &secid,
 				 &audit_info);
 }
 
@@ -1084,7 +1084,7 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
 	struct netlbl_unlhsh_walk_arg *cb_arg = arg;
 	struct net_device *dev;
 	void *data;
-	u32 secid;
+	struct secids secid;
 	char *secctx;
 	u32 secctx_len;
 
@@ -1141,7 +1141,7 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
 		secid = addr6->secid;
 	}
 
-	ret_val = security_secid_to_secctx(secid, &secctx, &secctx_len);
+	ret_val = security_secid_to_secctx(&secid, &secctx, &secctx_len);
 	if (ret_val != 0)
 		goto list_cb_failure;
 	ret_val = nla_put(cb_arg->skb,
diff --git a/net/netlabel/netlabel_unlabeled.h b/net/netlabel/netlabel_unlabeled.h
index 3a9e5dc9511b..2c68e9f9de13 100644
--- a/net/netlabel/netlabel_unlabeled.h
+++ b/net/netlabel/netlabel_unlabeled.h
@@ -225,7 +225,7 @@ int netlbl_unlhsh_add(struct net *net,
 		      const void *addr,
 		      const void *mask,
 		      u32 addr_len,
-		      u32 secid,
+		      struct secids *secid,
 		      struct netlbl_audit *audit_info);
 int netlbl_unlhsh_remove(struct net *net,
 			 const char *dev_name,
diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index 58495f44c62a..afc1e360b5bc 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -112,8 +112,8 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 			 from_kuid(&init_user_ns, audit_info->loginuid),
 			 audit_info->sessionid);
 
-	if (audit_info->secid != 0 &&
-	    security_secid_to_secctx(audit_info->secid,
+	if (secid_valid(&audit_info->secid) &&
+	    security_secid_to_secctx(&audit_info->secid,
 				     &secctx,
 				     &secctx_len) == 0) {
 		audit_log_format(audit_buf, " subj=%s", secctx);
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index d545e1d0dea2..fe9b85267bd0 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -141,17 +141,33 @@ static struct hlist_head *unix_sockets_unbound(void *addr)
 #ifdef CONFIG_SECURITY_NETWORK
 static void unix_get_secdata(struct scm_cookie *scm, struct sk_buff *skb)
 {
-	UNIXCB(skb).secid = scm->secid;
+	UNIXCB(skb).secid = scm->secid.secmark;
+#ifdef CONFIG_SECURITY_STACKING
+	secid_to_skb(&scm->secid, skb);
+#endif
 }
 
 static inline void unix_set_secdata(struct scm_cookie *scm, struct sk_buff *skb)
 {
-	scm->secid = UNIXCB(skb).secid;
+#ifdef CONFIG_SECURITY_STACKING
+	struct secids marks;
+
+	secid_from_skb(&marks, skb);
+
+	WARN_ON(marks.secmark != UNIXCB(skb).secid);
+
+	if (marks.secmark == UNIXCB(skb).secid)
+		scm->secid = marks;
+	else
+		secid_set(&scm->secid, UNIXCB(skb).secid);
+#else
+	scm->secid.secmark = UNIXCB(skb).secid;
+#endif
 }
 
 static inline bool unix_secdata_eq(struct scm_cookie *scm, struct sk_buff *skb)
 {
-	return (scm->secid == UNIXCB(skb).secid);
+	return (scm->secid.secmark == UNIXCB(skb).secid);
 }
 #else
 static inline void unix_get_secdata(struct scm_cookie *scm, struct sk_buff *skb)
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 7a23078132cf..641f9ca0c609 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1069,8 +1069,8 @@ static int xfrm_policy_match(const struct xfrm_policy *pol,
 
 	match = xfrm_selector_match(sel, fl, family);
 	if (match)
-		ret = security_xfrm_policy_lookup(pol->security, fl->flowi_secid,
-						  dir);
+		ret = security_xfrm_policy_lookup(pol->security,
+						  &fl->flowi_secid, dir);
 
 	return ret;
 }
@@ -1182,7 +1182,7 @@ static struct xfrm_policy *xfrm_sk_policy_lookup(const struct sock *sk, int dir,
 				goto out;
 			}
 			err = security_xfrm_policy_lookup(pol->security,
-						      fl->flowi_secid,
+						      &fl->flowi_secid,
 						      dir);
 			if (!err) {
 				if (!xfrm_pol_hold_rcu(pol))
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 54e21f19d722..0cef25b641e4 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1010,7 +1010,8 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 		xfrm_init_tempstate(x, fl, tmpl, daddr, saddr, family);
 		memcpy(&x->mark, &pol->mark, sizeof(x->mark));
 
-		error = security_xfrm_state_alloc_acquire(x, pol->security, fl->flowi_secid);
+		error = security_xfrm_state_alloc_acquire(x, pol->security,
+							  &fl->flowi_secid);
 		if (error) {
 			x->km.state = XFRM_STATE_DEAD;
 			to_put = x;
diff --git a/security/Kconfig b/security/Kconfig
index 8225388b81c3..4573120e87ed 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -318,18 +318,8 @@ endmenu
 menu "Security Module Stack"
 	visible if SECURITY_STACKING
 
-choice
-	prompt "Stacked 'extreme' security module"
-	default SECURITY_SELINUX_STACKED if SECURITY_SELINUX
-	default SECURITY_SMACK_STACKED if SECURITY_SMACK
-	default SECURITY_APPARMOR_STACKED if SECURITY_APPARMOR
-
-	help
-	  Enable an extreme security module. These modules cannot
-	  be used at the same time.
-
-	config SECURITY_SELINUX_STACKED
-		bool "SELinux" if SECURITY_SELINUX=y
+config SECURITY_SELINUX_STACKED
+	bool "SELinux" if SECURITY_SELINUX=y
 	help
 	  This option instructs the system to use the SELinux checks.
 	  At this time the Smack security module is incompatible with this
@@ -337,8 +327,8 @@ choice
 	  At this time the AppArmor security module is incompatible with this
 	  module.
 
-	config SECURITY_SMACK_STACKED
-		bool "Simplified Mandatory Access Control" if SECURITY_SMACK=y
+config SECURITY_SMACK_STACKED
+	bool "Simplified Mandatory Access Control" if SECURITY_SMACK=y
 	help
 	  This option instructs the system to use the Smack checks.
 	  At this time the SELinux security module is incompatible with this
@@ -355,13 +345,6 @@ choice
 	  At this time the Smack security module is incompatible with this
 	  module.
 
-	config SECURITY_NOTHING_STACKED
-		bool "Use no 'extreme' security module"
-	help
-	  Use none of the SELinux, Smack or AppArmor security module.
-
-endchoice
-
 config SECURITY_TOMOYO_STACKED
 	bool "TOMOYO support is enabled by default"
 	depends on SECURITY_TOMOYO && SECURITY_STACKING
diff --git a/security/Makefile b/security/Makefile
index 4d2d3782ddef..9b2b87710de8 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_MMU)			+= min_addr.o
 
 # Object file lists
 obj-$(CONFIG_SECURITY)			+= security.o
+obj-$(CONFIG_SECURITY_STACKING)		+= stacking.o
 obj-$(CONFIG_SECURITYFS)		+= inode.o
 obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/
 obj-$(CONFIG_SECURITY_SMACK)		+= smack/
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 915f5572c6ff..cf68f420916c 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -287,7 +287,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		return false;
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
-		u32 osid, sid;
+		struct secids osid;
+		struct secids sid;
 		int retried = 0;
 
 		if (!rule->lsm[i].rule)
@@ -298,7 +299,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
 			security_inode_getsecid(inode, &osid);
-			rc = security_filter_rule_match(osid,
+			rc = security_filter_rule_match(&osid,
 							rule->lsm[i].type,
 							Audit_equal,
 							rule->lsm[i].rule,
@@ -308,7 +309,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
 			security_task_getsecid(tsk, &sid);
-			rc = security_filter_rule_match(sid,
+			rc = security_filter_rule_match(&sid,
 							rule->lsm[i].type,
 							Audit_equal,
 							rule->lsm[i].rule,
diff --git a/security/security.c b/security/security.c
index 70994705ad62..79b06f48c6af 100644
--- a/security/security.c
+++ b/security/security.c
@@ -29,10 +29,16 @@
 #include <linux/backing-dev.h>
 #include <linux/string.h>
 #include <linux/msg.h>
+#include <linux/prctl.h>
 #include <net/flow.h>
 #include <net/sock.h>
 
-#define MAX_LSM_EVM_XATTR	2
+/*
+ * This should depend on the number of security modules
+ * that use extended attributes. At this writing it is
+ * at least EVM, SELinux and Smack.
+ */
+#define MAX_LSM_EVM_XATTR	8
 
 /* Maximum number of letters for an LSM name string */
 #define SECURITY_NAME_MAX	10
@@ -45,7 +51,16 @@ static struct kmem_cache *lsm_file_cache;
 static struct kmem_cache *lsm_inode_cache;
 
 char *lsm_names;
-static struct lsm_blob_sizes blob_sizes;
+/*
+ * If stacking is enabled the task blob will always
+ * include an indicator of what security module data
+ * should be displayed. This is set with PR_SET_DISPLAY_LSM.
+ */
+static struct lsm_blob_sizes blob_sizes = {
+#ifdef CONFIG_SECURITY_STACKING
+	.lbs_task = SECURITY_NAME_MAX + 2,
+#endif
+};
 
 /* Boot-time LSM user choice */
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
@@ -123,6 +138,7 @@ int __init security_init(void)
 	pr_info("LSM: sock blob size       = %d\n", blob_sizes.lbs_sock);
 	pr_info("LSM: superblock blob size = %d\n", blob_sizes.lbs_superblock);
 	pr_info("LSM: task blob size       = %d\n", blob_sizes.lbs_task);
+	pr_info("LSM: secid size           = %zu\n", sizeof(struct secids));
 #endif /* CONFIG_SECURITY_LSM_DEBUG */
 
 	return 0;
@@ -320,8 +336,18 @@ void __init security_add_blobs(struct lsm_blob_sizes *needed)
 	lsm_set_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
 	lsm_set_size(&needed->lbs_file, &blob_sizes.lbs_file);
 	lsm_set_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
+#ifdef CONFIG_KEYS
 	lsm_set_size(&needed->lbs_key, &blob_sizes.lbs_key);
+#endif
 	lsm_set_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
+#ifdef CONFIG_NETWORK_SECMARK
+	/*
+	 * Store the most likely secmark with the socket
+	 * so that it doesn't have to be a managed object.
+	 */
+	if (needed->lbs_sock && blob_sizes.lbs_sock == 0)
+		blob_sizes.lbs_sock = sizeof(struct secids);
+#endif
 	lsm_set_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
 	lsm_set_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
 	lsm_set_size(&needed->lbs_task, &blob_sizes.lbs_task);
@@ -524,6 +550,25 @@ int lsm_superblock_alloc(struct super_block *sb)
 	return 0;
 }
 
+#ifdef CONFIG_SECURITY_STACKING
+static int lsm_pick_secctx(const char *lsm, const char *from, char *to)
+{
+	char fmt[SECURITY_NAME_MAX + 4];
+	char *cp;
+	int i;
+
+	sprintf(fmt, "%s='", lsm);
+	i = sscanf(from, fmt, to);
+	if (i != 1)
+		return -ENOENT;
+	cp = strchr(to, '\'');
+	if (cp == NULL)
+		return -EINVAL;
+	*cp = '\0';
+	return 0;
+}
+#endif /* CONFIG_SECURITY_STACKING */
+
 /*
  * Hook list operation macros.
  *
@@ -846,8 +891,12 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const initxattrs initxattrs, void *fs_data)
 {
 	struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
-	struct xattr *lsm_xattr, *evm_xattr, *xattr;
-	int ret;
+	struct xattr *lsm_xattr;
+	struct xattr *evm_xattr;
+	struct xattr *xattr;
+	struct security_hook_list *shp;
+	int ret = -EOPNOTSUPP;
+	int rc = 0;
 
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
@@ -855,23 +904,40 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 	if (!initxattrs)
 		return call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
 				     dir, qstr, NULL, NULL, NULL);
+
 	memset(new_xattrs, 0, sizeof(new_xattrs));
 	lsm_xattr = new_xattrs;
-	ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
-						&lsm_xattr->name,
-						&lsm_xattr->value,
-						&lsm_xattr->value_len);
-	if (ret)
-		goto out;
 
-	evm_xattr = lsm_xattr + 1;
-	ret = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
-	if (ret)
-		goto out;
-	ret = initxattrs(inode, new_xattrs, fs_data);
-out:
-	for (xattr = new_xattrs; xattr->value != NULL; xattr++)
-		kfree(xattr->value);
+	list_for_each_entry(shp, &security_hook_heads.inode_init_security,
+				list) {
+		rc = shp->hook.inode_init_security(inode, dir, qstr,
+							&lsm_xattr->name,
+							&lsm_xattr->value,
+							&lsm_xattr->value_len);
+		if (rc == 0) {
+			lsm_xattr++;
+			if (ret == -EOPNOTSUPP)
+				ret = 0;
+		} else if (rc != -EOPNOTSUPP) {
+			ret = rc;
+			break;
+		}
+	}
+
+	if (ret == 0) {
+		rc = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
+		if (rc == 0)
+			rc = initxattrs(inode, new_xattrs, fs_data);
+	}
+
+	if (lsm_xattr != new_xattrs) {
+		for (xattr = new_xattrs; xattr->value != NULL; xattr++)
+			kfree(xattr->value);
+	}
+
+	if (rc != 0)
+		return rc;
+
 	return (ret == -EOPNOTSUPP) ? 0 : ret;
 }
 EXPORT_SYMBOL(security_inode_init_security);
@@ -1100,18 +1166,22 @@ int security_inode_getattr(const struct path *path)
 int security_inode_setxattr(struct dentry *dentry, const char *name,
 			    const void *value, size_t size, int flags)
 {
-	int ret;
+	struct security_hook_list *hp;
+	int ret = -ENOSYS;
+	int trc;
 
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	/*
-	 * SELinux and Smack integrate the cap call,
-	 * so assume that all LSMs supplying this call do so.
-	 */
-	ret = call_int_hook(inode_setxattr, 1, dentry, name, value, size,
-				flags);
 
-	if (ret == 1)
+	list_for_each_entry(hp, &security_hook_heads.inode_setxattr, list) {
+		trc = hp->hook.inode_setxattr(dentry, name, value, size, flags);
+		if (trc != -ENOSYS) {
+			ret = trc;
+			break;
+		}
+	}
+
+	if (ret == -ENOSYS)
 		ret = cap_inode_setxattr(dentry, name, value, size, flags);
 	if (ret)
 		return ret;
@@ -1220,8 +1290,9 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
 }
 EXPORT_SYMBOL(security_inode_listsecurity);
 
-void security_inode_getsecid(struct inode *inode, u32 *secid)
+void security_inode_getsecid(struct inode *inode, struct secids *secid)
 {
+	secid_init(secid);
 	call_void_hook(inode_getsecid, inode, secid);
 }
 
@@ -1430,8 +1501,9 @@ void security_transfer_creds(struct cred *new, const struct cred *old)
 	call_void_hook(cred_transfer, new, old);
 }
 
-int security_kernel_act_as(struct cred *new, u32 secid)
+int security_kernel_act_as(struct cred *new, struct secids *secid)
 {
+	secid_update_modules(secid);
 	return call_int_hook(kernel_act_as, 0, new, secid);
 }
 
@@ -1489,9 +1561,9 @@ int security_task_getsid(struct task_struct *p)
 	return call_int_hook(task_getsid, 0, p);
 }
 
-void security_task_getsecid(struct task_struct *p, u32 *secid)
+void security_task_getsecid(struct task_struct *p, struct secids *secid)
 {
-	*secid = 0;
+	secid_init(secid);
 	call_void_hook(task_getsecid, p, secid);
 }
 EXPORT_SYMBOL(security_task_getsecid);
@@ -1544,12 +1616,69 @@ int security_task_kill(struct task_struct *p, struct siginfo *info,
 	return call_int_hook(task_kill, 0, p, info, sig, cred);
 }
 
+#ifdef CONFIG_SECURITY_STACKING
+static void lsm_to_display(char *lsm)
+{
+	WARN_ON(!current->security);
+	if (current->security)
+		strncpy(lsm, current->security, SECURITY_NAME_MAX + 1);
+	else
+		lsm[0] = '\0';
+}
+#else
+static void lsm_to_display(char *lsm)
+{
+}
+#endif
+
 int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			 unsigned long arg4, unsigned long arg5)
 {
 	int thisrc;
 	int rc = -ENOSYS;
 	struct security_hook_list *hp;
+#ifdef CONFIG_SECURITY_STACKING
+	char lsm[SECURITY_NAME_MAX + 1];
+	__user char *optval = (__user char *)arg2;
+	__user int *optlen = (__user int *)arg3;
+	int dlen;
+	int len;
+
+	switch (option) {
+	case PR_GET_DISPLAY_LSM:
+		lsm_to_display(lsm);
+		len = arg4;
+		dlen = strlen(lsm) + 1;
+		if (dlen > len)
+			return -ERANGE;
+		if (copy_to_user(optval, lsm, dlen))
+			return -EFAULT;
+		if (put_user(dlen, optlen))
+			return -EFAULT;
+		return 0;
+	case PR_SET_DISPLAY_LSM:
+		len = arg3;
+		if (len > SECURITY_NAME_MAX)
+			return -EINVAL;
+		if (copy_from_user(lsm, optval, len))
+			return -EFAULT;
+		lsm[len] = '\0';
+		/*
+		 * Trust the caller to know what lsm name(s) are available.
+		 */
+		if (!current) {
+			pr_info("%s BUGGER - no current!\n", __func__);
+			return -EINVAL;
+		}
+		if (!current->security) {
+			pr_info("%s %s BUGGER - no security!\n", __func__,
+				current->comm);
+			return -EINVAL;
+		}
+		strcpy(current->security, lsm);
+		return 0;
+	}
+#endif
 
 	list_for_each_entry(hp, &security_hook_heads.task_prctl, list) {
 		thisrc = hp->hook.task_prctl(option, arg2, arg3, arg4, arg5);
@@ -1572,9 +1701,9 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 	return call_int_hook(ipc_permission, 0, ipcp, flag);
 }
 
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct secids *secid)
 {
-	*secid = 0;
+	secid_init(secid);
 	call_void_hook(ipc_getsecid, ipcp, secid);
 }
 
@@ -1727,7 +1856,7 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 	struct security_hook_list *hp;
 
 	list_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsm))
+		if (lsm && lsm[0] && strcmp(lsm, hp->lsm))
 			continue;
 		return hp->hook.getprocattr(p, name, value);
 	}
@@ -1740,7 +1869,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 	struct security_hook_list *hp;
 
 	list_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsm))
+		if (lsm && lsm[0] && strcmp(lsm, hp->lsm))
 			continue;
 		return hp->hook.setprocattr(name, value, size);
 	}
@@ -1758,23 +1887,66 @@ int security_ismaclabel(const char *name)
 }
 EXPORT_SYMBOL(security_ismaclabel);
 
-int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+int security_secid_to_secctx(struct secids *secid, char **secdata, u32 *seclen)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	struct security_hook_list *hp;
+	char lsm[SECURITY_NAME_MAX + 1];
+
+	lsm_to_display(lsm);
+
+	list_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list)
+		if (lsm[0] == '\0' || !strcmp(lsm, hp->lsm))
+			return hp->hook.secid_to_secctx(secid, secdata, seclen);
+
+	return -EOPNOTSUPP;
+#else
 	return call_int_hook(secid_to_secctx, -EOPNOTSUPP, secid, secdata,
 				seclen);
+#endif
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
-int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
+int security_secctx_to_secid(const char *secdata, u32 seclen,
+				struct secids *secid)
 {
-	*secid = 0;
+#ifdef CONFIG_SECURITY_STACKING
+	struct security_hook_list *hp;
+	int rc = 0;
+
+	secid_init(secid);
+
+	list_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list) {
+		rc = hp->hook.secctx_to_secid(secdata, seclen, secid);
+		break;
+	}
+	/*
+	 * Needed by netfilter
+	 */
+	secid_update_secmark(secid);
+	return rc;
+#else
 	return call_int_hook(secctx_to_secid, 0, secdata, seclen, secid);
+#endif
 }
 EXPORT_SYMBOL(security_secctx_to_secid);
 
 void security_release_secctx(char *secdata, u32 seclen)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	struct security_hook_list *hp;
+	char lsm[SECURITY_NAME_MAX + 1];
+
+	lsm_to_display(lsm);
+
+	list_for_each_entry(hp, &security_hook_heads.release_secctx, list)
+		if (lsm[0] == '\0' || !strcmp(lsm, hp->lsm)) {
+			hp->hook.release_secctx(secdata, seclen);
+			break;
+		}
+#else
 	call_void_hook(release_secctx, secdata, seclen);
+#endif
 }
 EXPORT_SYMBOL(security_release_secctx);
 
@@ -1792,13 +1964,80 @@ EXPORT_SYMBOL(security_inode_notifysecctx);
 
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	struct security_hook_list *hp;
+	char *subctx;
+	int rc = 0;
+
+	subctx = kzalloc(ctxlen, GFP_KERNEL);
+	if (subctx == NULL)
+		return -ENOMEM;
+
+	list_for_each_entry(hp, &security_hook_heads.inode_setsecctx, list) {
+		rc = lsm_pick_secctx(hp->lsm, ctx, subctx);
+		if (rc) {
+			rc = 0;
+			continue;
+		}
+		rc = hp->hook.inode_setsecctx(dentry, subctx, strlen(subctx));
+		if (rc)
+			break;
+	}
+
+	kfree(subctx);
+	return rc;
+#else
 	return call_int_hook(inode_setsecctx, 0, dentry, ctx, ctxlen);
+#endif
 }
 EXPORT_SYMBOL(security_inode_setsecctx);
 
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	struct security_hook_list *hp;
+	struct security_hook_list *rhp;
+	char *final = NULL;
+	char *cp;
+	void *data;
+	u32 len;
+	int rc = -EOPNOTSUPP;
+
+	list_for_each_entry(hp, &security_hook_heads.inode_getsecctx, list) {
+		rc = hp->hook.inode_getsecctx(inode, &data, &len);
+		if (rc) {
+#ifdef CONFIG_SECURITY_LSM_DEBUG
+			pr_info("%s: getsecctx by %s failed.\n",
+				__func__, hp->lsm);
+#endif
+			kfree(final);
+			return rc;
+		}
+		if (final) {
+			cp = kasprintf(GFP_KERNEL, "%s,%s='%s'", final,
+					hp->lsm, (char *)data);
+			kfree(final);
+		} else
+			cp = kasprintf(GFP_KERNEL, "%s='%s'", hp->lsm,
+					(char *)data);
+
+		list_for_each_entry(rhp, &security_hook_heads.release_secctx,
+					list) {
+			if (hp->lsm == rhp->lsm) {
+				rhp->hook.release_secctx(data, len);
+				break;
+			}
+		}
+		if (cp == NULL)
+			return -ENOMEM;
+		final = cp;
+	}
+	*ctx = final;
+	*ctxlen = strlen(final);
+	return 0;
+#else
 	return call_int_hook(inode_getsecctx, -EOPNOTSUPP, inode, ctx, ctxlen);
+#endif
 }
 EXPORT_SYMBOL(security_inode_getsecctx);
 
@@ -1893,14 +2132,58 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len)
 {
-	return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
-				optval, optlen, len);
+	struct security_hook_list *hp;
+	char *tval = NULL;
+	u32 tlen;
+	int rc = -ENOPROTOOPT;
+#ifdef CONFIG_SECURITY_STACKING
+	char lsm[SECURITY_NAME_MAX + 1];
+
+	lsm_to_display(lsm);
+
+	list_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stream,
+				list) {
+		if (lsm[0] == '\0' || !strcmp(lsm, hp->lsm)) {
+			rc = hp->hook.socket_getpeersec_stream(sock, &tval,
+							       &tlen, len);
+			break;
+		}
+	}
+#else
+	list_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stream,
+				list) {
+		rc = hp->hook.socket_getpeersec_stream(sock, &tval, &tlen, len);
+		break;
+	}
+#endif
+
+	if (rc == 0) {
+		tlen = strlen(tval) + 1;
+		if (put_user(tlen, optlen))
+			rc = -EFAULT;
+		else if (copy_to_user(optval, tval, tlen))
+			rc = -EFAULT;
+	}
+	return rc;
 }
 
-int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
+int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
+				     struct secids *secid)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	struct security_hook_list *hp;
+	int rc = -ENOPROTOOPT;
+
+	secid_init(secid);
+	list_for_each_entry(hp, &security_hook_heads.socket_getpeersec_dgram,
+				list)
+		rc = hp->hook.socket_getpeersec_dgram(sock, skb, secid);
+
+	return rc;
+#else
 	return call_int_hook(socket_getpeersec_dgram, -ENOPROTOOPT, sock,
 			     skb, secid);
+#endif
 }
 EXPORT_SYMBOL(security_socket_getpeersec_dgram);
 
@@ -1966,9 +2249,21 @@ void security_inet_conn_established(struct sock *sk,
 	call_void_hook(inet_conn_established, sk, skb);
 }
 
-int security_secmark_relabel_packet(u32 secid)
+int security_secmark_relabel_packet(struct secids *secid)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	struct security_hook_list *hp;
+	int rc;
+
+	secid_update_modules(secid);
+	list_for_each_entry(hp, &security_hook_heads.secmark_relabel_packet,
+				list)
+		rc = hp->hook.secmark_relabel_packet(secid);
+
+	return 0;
+#else
 	return call_int_hook(secmark_relabel_packet, 0, secid);
+#endif
 }
 EXPORT_SYMBOL(security_secmark_relabel_packet);
 
@@ -2084,7 +2379,8 @@ int security_xfrm_state_alloc(struct xfrm_state *x,
 EXPORT_SYMBOL(security_xfrm_state_alloc);
 
 int security_xfrm_state_alloc_acquire(struct xfrm_state *x,
-				      struct xfrm_sec_ctx *polsec, u32 secid)
+				      struct xfrm_sec_ctx *polsec,
+				      const struct secids *secid)
 {
 	return call_int_hook(xfrm_state_alloc_acquire, 0, x, polsec, secid);
 }
@@ -2100,7 +2396,8 @@ void security_xfrm_state_free(struct xfrm_state *x)
 	call_void_hook(xfrm_state_free_security, x);
 }
 
-int security_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid, u8 dir)
+int security_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx,
+					struct secids *fl_secid, u8 dir)
 {
 	return call_int_hook(xfrm_policy_lookup, 0, ctx, fl_secid, dir);
 }
@@ -2129,15 +2426,22 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 	return rc;
 }
 
-int security_xfrm_decode_session(struct sk_buff *skb, u32 *secid)
+int security_xfrm_decode_session(struct sk_buff *skb, struct secids *secid)
 {
-	return call_int_hook(xfrm_decode_session, 0, skb, secid, 1);
+	int rc;
+
+	secid_init(secid);
+	rc = call_int_hook(xfrm_decode_session, 0, skb, secid, 1);
+	return rc;
 }
 
 void security_skb_classify_flow(struct sk_buff *skb, struct flowi *fl)
 {
-	int rc = call_int_hook(xfrm_decode_session, 0, skb, &fl->flowi_secid,
-				0);
+	int rc;
+
+	secid_init(&fl->flowi_secid);
+
+	rc = call_int_hook(xfrm_decode_session, 0, skb, &fl->flowi_secid, 0);
 
 	BUG_ON(rc);
 }
@@ -2198,8 +2502,8 @@ void security_audit_rule_free(void *lsmrule)
 	call_void_hook(audit_rule_free, lsmrule);
 }
 
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
-			      struct audit_context *actx)
+int security_audit_rule_match(struct secids *secid, u32 field, u32 op,
+			      void *lsmrule, struct audit_context *actx)
 {
 	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule,
 				actx);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 52f6253cbcf8..a0dc3c482a06 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3321,15 +3321,15 @@ static int selinux_inode_listsecurity(struct inode *inode, char *buffer, size_t
 	return len;
 }
 
-static void selinux_inode_getsecid(struct inode *inode, u32 *secid)
+static void selinux_inode_getsecid(struct inode *inode, struct secids *secid)
 {
 	struct inode_security_struct *isec = inode_security_novalidate(inode);
-	*secid = isec->sid;
+	secid->selinux = isec->sid;
 }
 
 static int selinux_inode_copy_up(struct dentry *src, struct cred **new)
 {
-	u32 sid;
+	struct secids sids;
 	struct task_security_struct *tsec;
 	struct cred *new_creds = *new;
 
@@ -3341,8 +3341,8 @@ static int selinux_inode_copy_up(struct dentry *src, struct cred **new)
 
 	tsec = selinux_cred(new_creds);
 	/* Get label from overlay inode and set it in create_sid */
-	selinux_inode_getsecid(d_inode(src), &sid);
-	tsec->create_sid = sid;
+	selinux_inode_getsecid(d_inode(src), &sids);
+	tsec->create_sid = sids.selinux;
 	*new = new_creds;
 	return 0;
 }
@@ -3755,18 +3755,18 @@ static void selinux_cred_transfer(struct cred *new, const struct cred *old)
  * set the security data for a kernel service
  * - all the creation contexts are set to unlabelled
  */
-static int selinux_kernel_act_as(struct cred *new, u32 secid)
+static int selinux_kernel_act_as(struct cred *new, struct secids *secid)
 {
 	struct task_security_struct *tsec = selinux_cred(new);
 	u32 sid = current_sid();
 	int ret;
 
-	ret = avc_has_perm(sid, secid,
+	ret = avc_has_perm(sid, secid->selinux,
 			   SECCLASS_KERNEL_SERVICE,
 			   KERNEL_SERVICE__USE_AS_OVERRIDE,
 			   NULL);
 	if (ret == 0) {
-		tsec->sid = secid;
+		tsec->sid = secid->selinux;
 		tsec->create_sid = 0;
 		tsec->keycreate_sid = 0;
 		tsec->sockcreate_sid = 0;
@@ -3870,9 +3870,9 @@ static int selinux_task_getsid(struct task_struct *p)
 			    PROCESS__GETSESSION, NULL);
 }
 
-static void selinux_task_getsecid(struct task_struct *p, u32 *secid)
+static void selinux_task_getsecid(struct task_struct *p, struct secids *secid)
 {
-	*secid = task_sid(p);
+	secid->selinux = task_sid(p);
 }
 
 static int selinux_task_setnice(struct task_struct *p, int nice)
@@ -4637,6 +4637,7 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 	struct common_audit_data ad;
 	struct lsm_network_audit net = {0,};
 	char *addrp;
+	struct secids marks;
 
 	ad.type = LSM_AUDIT_DATA_NET;
 	ad.u.net = &net;
@@ -4647,7 +4648,8 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 		return err;
 
 	if (selinux_secmark_enabled()) {
-		err = avc_has_perm(sk_sid, skb->secmark, SECCLASS_PACKET,
+		secid_set(&marks, skb->secmark);
+		err = avc_has_perm(sk_sid, marks.selinux, SECCLASS_PACKET,
 				   PACKET__RECV, &ad);
 		if (err)
 			return err;
@@ -4672,6 +4674,7 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	char *addrp;
 	u8 secmark_active;
 	u8 peerlbl_active;
+	struct secids marks;
 
 	if (family != PF_INET && family != PF_INET6)
 		return 0;
@@ -4721,7 +4724,8 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	}
 
 	if (secmark_active) {
-		err = avc_has_perm(sk_sid, skb->secmark, SECCLASS_PACKET,
+		secid_set(&marks, skb->secmark);
+		err = avc_has_perm(sk_sid, marks.selinux, SECCLASS_PACKET,
 				   PACKET__RECV, &ad);
 		if (err)
 			return err;
@@ -4730,10 +4734,8 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	return err;
 }
 
-static int selinux_socket_getpeersec_stream(struct socket *sock,
-					    __user char *optval,
-					    __user int *optlen,
-					    unsigned int len)
+static int selinux_socket_getpeersec_stream(struct socket *sock, char **optval,
+					    int *optlen, unsigned int len)
 {
 	int err = 0;
 	char *scontext;
@@ -4752,21 +4754,17 @@ static int selinux_socket_getpeersec_stream(struct socket *sock,
 		return err;
 
 	if (scontext_len > len) {
-		err = -ERANGE;
-		goto out_len;
+		kfree(scontext);
+		return -ERANGE;
 	}
-
-	if (copy_to_user(optval, scontext, scontext_len))
-		err = -EFAULT;
-
-out_len:
-	if (put_user(scontext_len, optlen))
-		err = -EFAULT;
-	kfree(scontext);
-	return err;
+	*optval = scontext;
+	*optlen = scontext_len;
+	return 0;
 }
 
-static int selinux_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
+static int selinux_socket_getpeersec_dgram(struct socket *sock,
+					   struct sk_buff *skb,
+					   struct secids *secid)
 {
 	u32 peer_secid = SECSID_NULL;
 	u16 family;
@@ -4788,7 +4786,7 @@ static int selinux_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *
 		selinux_skb_peerlbl_sid(skb, family, &peer_secid);
 
 out:
-	*secid = peer_secid;
+	secid->selinux = peer_secid;
 	if (peer_secid == SECSID_NULL)
 		return -EINVAL;
 	return 0;
@@ -4825,14 +4823,14 @@ static void selinux_sk_clone_security(const struct sock *sk, struct sock *newsk)
 	selinux_netlbl_sk_security_reset(newsksec);
 }
 
-static void selinux_sk_getsecid(struct sock *sk, u32 *secid)
+static void selinux_sk_getsecid(struct sock *sk, struct secids *secid)
 {
 	if (!sk)
-		*secid = SECINITSID_ANY_SOCKET;
+		secid->selinux = SECINITSID_ANY_SOCKET;
 	else {
 		struct sk_security_struct *sksec = selinux_sock(sk);
 
-		*secid = sksec->sid;
+		secid->selinux = sksec->sid;
 	}
 }
 
@@ -4898,7 +4896,7 @@ static void selinux_inet_conn_established(struct sock *sk, struct sk_buff *skb)
 	selinux_skb_peerlbl_sid(skb, family, &sksec->peer_sid);
 }
 
-static int selinux_secmark_relabel_packet(u32 sid)
+static int selinux_secmark_relabel_packet(struct secids *secid)
 {
 	const struct task_security_struct *__tsec;
 	u32 tsid;
@@ -4906,7 +4904,8 @@ static int selinux_secmark_relabel_packet(u32 sid)
 	__tsec = selinux_cred(current_cred());
 	tsid = __tsec->sid;
 
-	return avc_has_perm(tsid, sid, SECCLASS_PACKET, PACKET__RELABELTO, NULL);
+	return avc_has_perm(tsid, secid->selinux, SECCLASS_PACKET,
+				PACKET__RELABELTO, NULL);
 }
 
 static void selinux_secmark_refcount_inc(void)
@@ -4922,7 +4921,7 @@ static void selinux_secmark_refcount_dec(void)
 static void selinux_req_classify_flow(const struct request_sock *req,
 				      struct flowi *fl)
 {
-	fl->flowi_secid = req->secid;
+	fl->flowi_secid.selinux = req->secid;
 }
 
 static int selinux_tun_dev_alloc_security(void **security)
@@ -5054,6 +5053,7 @@ static unsigned int selinux_ip_forward(struct sk_buff *skb,
 	u8 secmark_active;
 	u8 netlbl_active;
 	u8 peerlbl_active;
+	struct secids marks;
 
 	if (!selinux_policycap_netpeer)
 		return NF_ACCEPT;
@@ -5083,10 +5083,12 @@ static unsigned int selinux_ip_forward(struct sk_buff *skb,
 		}
 	}
 
-	if (secmark_active)
-		if (avc_has_perm(peer_sid, skb->secmark,
+	if (secmark_active) {
+		secid_set(&marks, skb->secmark);
+		if (avc_has_perm(peer_sid, marks.selinux,
 				 SECCLASS_PACKET, PACKET__FORWARD_IN, &ad))
 			return NF_DROP;
+	}
 
 	if (netlbl_active)
 		/* we do this in the FORWARD path and not the POST_ROUTING
@@ -5183,6 +5185,7 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 	struct lsm_network_audit net = {0,};
 	char *addrp;
 	u8 proto;
+	struct secids marks;
 
 	if (sk == NULL)
 		return NF_ACCEPT;
@@ -5195,10 +5198,12 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 	if (selinux_parse_skb(skb, &ad, &addrp, 0, &proto))
 		return NF_DROP;
 
-	if (selinux_secmark_enabled())
-		if (avc_has_perm(sksec->sid, skb->secmark,
+	if (selinux_secmark_enabled()) {
+		secid_set(&marks, skb->secmark);
+		if (avc_has_perm(sksec->sid, marks.selinux,
 				 SECCLASS_PACKET, PACKET__SEND, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
+	}
 
 	if (selinux_xfrm_postroute_last(sksec->sid, skb, &ad, proto))
 		return NF_DROP_ERR(-ECONNREFUSED);
@@ -5219,6 +5224,7 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb,
 	char *addrp;
 	u8 secmark_active;
 	u8 peerlbl_active;
+	struct secids marks;
 
 	/* If any sort of compatibility mode is enabled then handoff processing
 	 * to the selinux_ip_postroute_compat() function to deal with the
@@ -5318,10 +5324,12 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb,
 	if (selinux_parse_skb(skb, &ad, &addrp, 0, NULL))
 		return NF_DROP;
 
-	if (secmark_active)
-		if (avc_has_perm(peer_sid, skb->secmark,
+	if (secmark_active) {
+		secid_set(&marks, skb->secmark);
+		if (avc_has_perm(peer_sid, marks.selinux,
 				 SECCLASS_PACKET, secmark_perm, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
+	}
 
 	if (peerlbl_active) {
 		u32 if_sid;
@@ -5719,10 +5727,11 @@ static int selinux_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 	return ipc_has_perm(ipcp, av);
 }
 
-static void selinux_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+static void selinux_ipc_getsecid(struct kern_ipc_perm *ipcp,
+				 struct secids *secid)
 {
 	struct ipc_security_struct *isec = selinux_ipc(ipcp);
-	*secid = isec->sid;
+	secid->selinux = isec->sid;
 }
 
 static void selinux_d_instantiate(struct dentry *dentry, struct inode *inode)
@@ -5914,14 +5923,17 @@ static int selinux_ismaclabel(const char *name)
 	return (strcmp(name, XATTR_SELINUX_SUFFIX) == 0);
 }
 
-static int selinux_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+static int selinux_secid_to_secctx(struct secids *secid, char **secdata,
+					u32 *seclen)
 {
-	return security_sid_to_context(secid, secdata, seclen);
+	return security_sid_to_context(secid->selinux, secdata, seclen);
 }
 
-static int selinux_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
+static int selinux_secctx_to_secid(const char *secdata, u32 seclen,
+					struct secids *secid)
 {
-	return security_context_to_sid(secdata, seclen, secid, GFP_KERNEL);
+	return security_context_to_sid(secdata, seclen, &secid->selinux,
+					GFP_KERNEL);
 }
 
 static void selinux_release_secctx(char *secdata, u32 seclen)
diff --git a/security/selinux/include/audit.h b/security/selinux/include/audit.h
index 1bdf973433cc..c9cadad5660e 100644
--- a/security/selinux/include/audit.h
+++ b/security/selinux/include/audit.h
@@ -51,7 +51,7 @@ void selinux_audit_rule_free(void *rule);
  *	Returns 1 if the context id matches the rule, 0 if it does not, and
  *	-errno on failure.
  */
-int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *rule,
+int selinux_audit_rule_match(struct secids *sid, u32 field, u32 op, void *rule,
 			     struct audit_context *actx);
 
 /**
diff --git a/security/selinux/include/xfrm.h b/security/selinux/include/xfrm.h
index 1f173a7a4daa..bcd72c412177 100644
--- a/security/selinux/include/xfrm.h
+++ b/security/selinux/include/xfrm.h
@@ -20,10 +20,12 @@ int selinux_xfrm_policy_delete(struct xfrm_sec_ctx *ctx);
 int selinux_xfrm_state_alloc(struct xfrm_state *x,
 			     struct xfrm_user_sec_ctx *uctx);
 int selinux_xfrm_state_alloc_acquire(struct xfrm_state *x,
-				     struct xfrm_sec_ctx *polsec, u32 secid);
+				     struct xfrm_sec_ctx *polsec,
+				     const struct secids *secid);
 void selinux_xfrm_state_free(struct xfrm_state *x);
 int selinux_xfrm_state_delete(struct xfrm_state *x);
-int selinux_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid, u8 dir);
+int selinux_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx,
+			       struct secids *fl_secid, u8 dir);
 int selinux_xfrm_state_pol_flow_match(struct xfrm_state *x,
 				      struct xfrm_policy *xp,
 				      const struct flowi *fl);
@@ -40,7 +42,8 @@ int selinux_xfrm_sock_rcv_skb(u32 sk_sid, struct sk_buff *skb,
 			      struct common_audit_data *ad);
 int selinux_xfrm_postroute_last(u32 sk_sid, struct sk_buff *skb,
 				struct common_audit_data *ad, u8 proto);
-int selinux_xfrm_decode_session(struct sk_buff *skb, u32 *sid, int ckall);
+int selinux_xfrm_decode_session(struct sk_buff *skb, struct secids *sid,
+				int ckall);
 int selinux_xfrm_skb_sid(struct sk_buff *skb, u32 *sid);
 
 static inline void selinux_xfrm_notify_policyload(void)
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 338b14842d49..a5a66bd97edc 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -121,7 +121,7 @@ static struct netlbl_lsm_secattr *selinux_netlbl_sock_getattr(
 		return NULL;
 
 	if ((secattr->flags & NETLBL_SECATTR_SECID) &&
-	    (secattr->attr.secid == sid))
+	    (secattr->attr.secid.selinux == sid))
 		return secattr;
 
 	return NULL;
@@ -341,6 +341,14 @@ int selinux_netlbl_socket_post_create(struct sock *sk, u16 family)
 	secattr = selinux_netlbl_sock_genattr(sk);
 	if (secattr == NULL)
 		return -ENOMEM;
+
+#ifdef CONFIG_SECURITY_STACKING
+	/* Ensure that other security modules cooperate */
+	rc = lsm_sock_vet_attr(sk, secattr, LSM_SOCK_SELINUX);
+	if (rc)
+		return rc;
+#endif
+
 	rc = netlbl_sock_setattr(sk, family, secattr);
 	switch (rc) {
 	case 0:
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 13118a9a2513..d6b4f6bd4f18 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3260,7 +3260,7 @@ int selinux_audit_rule_known(struct audit_krule *rule)
 	return 0;
 }
 
-int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule,
+int selinux_audit_rule_match(struct secids *sid, u32 field, u32 op, void *vrule,
 			     struct audit_context *actx)
 {
 	struct context *ctxt;
@@ -3280,10 +3280,10 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule,
 		goto out;
 	}
 
-	ctxt = sidtab_search(&sidtab, sid);
+	ctxt = sidtab_search(&sidtab, sid->selinux);
 	if (unlikely(!ctxt)) {
 		WARN_ONCE(1, "selinux_audit_rule_match: unrecognized SID %d\n",
-			  sid);
+			  sid->selinux);
 		match = -ENOENT;
 		goto out;
 	}
@@ -3455,7 +3455,7 @@ int security_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
 	if (secattr->flags & NETLBL_SECATTR_CACHE)
 		*sid = *(u32 *)secattr->cache->data;
 	else if (secattr->flags & NETLBL_SECATTR_SECID)
-		*sid = secattr->attr.secid;
+		*sid = secattr->attr.secid.selinux;
 	else if (secattr->flags & NETLBL_SECATTR_MLS_LVL) {
 		rc = -EIDRM;
 		ctx = sidtab_search(&sidtab, SECINITSID_NETMSG);
@@ -3526,7 +3526,7 @@ int security_netlbl_sid_to_secattr(u32 sid, struct netlbl_lsm_secattr *secattr)
 	if (secattr->domain == NULL)
 		goto out;
 
-	secattr->attr.secid = sid;
+	secattr->attr.secid.selinux = sid;
 	secattr->flags |= NETLBL_SECATTR_DOMAIN_CPY | NETLBL_SECATTR_SECID;
 	mls_export_netlbl_lvl(ctx, secattr);
 	rc = mls_export_netlbl_cat(ctx, secattr);
diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index 1ad8ad446a45..2ad17eb46aff 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -150,7 +150,8 @@ static int selinux_xfrm_delete(struct xfrm_sec_ctx *ctx)
  * LSM hook implementation that authorizes that a flow can use a xfrm policy
  * rule.
  */
-int selinux_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid, u8 dir)
+int selinux_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx,
+				struct secids *fl_secid, u8 dir)
 {
 	int rc;
 
@@ -163,7 +164,7 @@ int selinux_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid, u8 dir)
 	if (!selinux_authorizable_ctx(ctx))
 		return -EINVAL;
 
-	rc = avc_has_perm(fl_secid, ctx->ctx_sid,
+	rc = avc_has_perm(fl_secid->selinux, ctx->ctx_sid,
 			  SECCLASS_ASSOCIATION, ASSOCIATION__POLMATCH, NULL);
 	return (rc == -EACCES ? -ESRCH : rc);
 }
@@ -196,13 +197,13 @@ int selinux_xfrm_state_pol_flow_match(struct xfrm_state *x,
 
 	state_sid = x->security->ctx_sid;
 
-	if (fl->flowi_secid != state_sid)
+	if (fl->flowi_secid.selinux != state_sid)
 		return 0;
 
 	/* We don't need a separate SA Vs. policy polmatch check since the SA
 	 * is now of the same label as the flow and a flow Vs. policy polmatch
 	 * check had already happened in selinux_xfrm_policy_lookup() above. */
-	return (avc_has_perm(fl->flowi_secid, state_sid,
+	return (avc_has_perm(fl->flowi_secid.selinux, state_sid,
 			    SECCLASS_ASSOCIATION, ASSOCIATION__SENDTO,
 			    NULL) ? 0 : 1);
 }
@@ -256,13 +257,14 @@ static int selinux_xfrm_skb_sid_ingress(struct sk_buff *skb,
  * LSM hook implementation that checks and/or returns the xfrm sid for the
  * incoming packet.
  */
-int selinux_xfrm_decode_session(struct sk_buff *skb, u32 *sid, int ckall)
+int selinux_xfrm_decode_session(struct sk_buff *skb, struct secids *sid,
+				int ckall)
 {
 	if (skb == NULL) {
-		*sid = SECSID_NULL;
+		sid->selinux = SECSID_NULL;
 		return 0;
 	}
-	return selinux_xfrm_skb_sid_ingress(skb, sid, ckall);
+	return selinux_xfrm_skb_sid_ingress(skb, &sid->selinux, ckall);
 }
 
 int selinux_xfrm_skb_sid(struct sk_buff *skb, u32 *sid)
@@ -339,7 +341,8 @@ int selinux_xfrm_state_alloc(struct xfrm_state *x,
  * on a secid.
  */
 int selinux_xfrm_state_alloc_acquire(struct xfrm_state *x,
-				     struct xfrm_sec_ctx *polsec, u32 secid)
+				     struct xfrm_sec_ctx *polsec,
+				     const struct secids *secid)
 {
 	int rc;
 	struct xfrm_sec_ctx *ctx;
@@ -349,10 +352,10 @@ int selinux_xfrm_state_alloc_acquire(struct xfrm_state *x,
 	if (!polsec)
 		return 0;
 
-	if (secid == 0)
+	if (!secid_valid(secid))
 		return -EINVAL;
 
-	rc = security_sid_to_context(secid, &ctx_str, &str_len);
+	rc = security_sid_to_context(secid->selinux, &ctx_str, &str_len);
 	if (rc)
 		return rc;
 
@@ -364,7 +367,7 @@ int selinux_xfrm_state_alloc_acquire(struct xfrm_state *x,
 
 	ctx->ctx_doi = XFRM_SC_DOI_LSM;
 	ctx->ctx_alg = XFRM_SC_ALG_SELINUX;
-	ctx->ctx_sid = secid;
+	ctx->ctx_sid = secid->selinux;
 	ctx->ctx_len = str_len;
 	memcpy(ctx->ctx_str, ctx_str, str_len);
 
diff --git a/security/smack/smack.h b/security/smack/smack.h
index 87ced0fc1a19..48d0fd3b4edd 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -104,8 +104,13 @@ struct socket_smack {
 	struct smack_known	*smk_out;	/* outbound label */
 	struct smack_known	*smk_in;	/* inbound label */
 	struct smack_known	*smk_packet;	/* TCP peer label */
+	int			smk_state;	/* State of the socket */
 };
 
+#define SMACK_SOCKET_UNSET	0
+#define SMACK_SOCKET_CIPSO	1
+#define SMACK_SOCKET_UNLABELED	2
+
 /*
  * Inode smack data
  */
diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index 133774805594..1609aac48793 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -550,7 +550,9 @@ struct smack_known *smk_import_entry(const char *string, int len)
 	skp->smk_secid = smack_next_secid++;
 	skp->smk_netlabel.domain = skp->smk_known;
 	skp->smk_netlabel.flags =
-		NETLBL_SECATTR_DOMAIN | NETLBL_SECATTR_MLS_LVL;
+		NETLBL_SECATTR_DOMAIN | NETLBL_SECATTR_MLS_LVL |
+		NETLBL_SECATTR_SECID;
+	skp->smk_netlabel.attr.secid.smack = skp->smk_secid;
 	/*
 	 * If direct labeling works use it.
 	 * Otherwise use mapped labeling.
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index df096122dbeb..87a0bc16d7fd 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1471,11 +1471,11 @@ static int smack_inode_listsecurity(struct inode *inode, char *buffer,
  * @inode: inode to extract the info from
  * @secid: where result will be saved
  */
-static void smack_inode_getsecid(struct inode *inode, u32 *secid)
+static void smack_inode_getsecid(struct inode *inode, struct secids *secid)
 {
 	struct inode_smack *isp = smack_inode(inode);
 
-	*secid = isp->smk_inode->smk_secid;
+	secid->smack = isp->smk_inode->smk_secid;
 }
 
 /*
@@ -1941,12 +1941,15 @@ static void smack_cred_transfer(struct cred *new, const struct cred *old)
 	struct task_smack *old_tsp = smack_cred(old);
 	struct task_smack *new_tsp = smack_cred(new);
 
-	new_tsp->smk_task = old_tsp->smk_task;
-	new_tsp->smk_forked = old_tsp->smk_task;
-	mutex_init(&new_tsp->smk_rules_lock);
-	INIT_LIST_HEAD(&new_tsp->smk_rules);
+	int rc;
+
+	init_task_smack(new_tsp, old_tsp->smk_task, old_tsp->smk_task);
 
-	/* cbs copy rule list */
+	rc = smk_copy_rules(&new_tsp->smk_rules, &old_tsp->smk_rules,
+		GFP_KERNEL);
+	if (rc == 0)
+		rc = smk_copy_relabel(&new_tsp->smk_relabel,
+					&old_tsp->smk_relabel, GFP_KERNEL);
 }
 
 /**
@@ -1956,11 +1959,11 @@ static void smack_cred_transfer(struct cred *new, const struct cred *old)
  *
  * Set the security data for a kernel service.
  */
-static int smack_kernel_act_as(struct cred *new, u32 secid)
+static int smack_kernel_act_as(struct cred *new, struct secids *secid)
 {
 	struct task_smack *new_tsp = smack_cred(new);
 
-	new_tsp->smk_task = smack_from_secid(secid);
+	new_tsp->smk_task = smack_from_secid(secid->smack);
 	return 0;
 }
 
@@ -2046,11 +2049,11 @@ static int smack_task_getsid(struct task_struct *p)
  *
  * Sets the secid to contain a u32 version of the smack label.
  */
-static void smack_task_getsecid(struct task_struct *p, u32 *secid)
+static void smack_task_getsecid(struct task_struct *p, struct secids *secid)
 {
 	struct smack_known *skp = smk_of_task_struct(p);
 
-	*secid = skp->smk_secid;
+	secid->smack = skp->smk_secid;
 }
 
 /**
@@ -2211,6 +2214,7 @@ static int smack_sk_alloc_security(struct sock *sk, int family, gfp_t gfp_flags)
 		ssp->smk_out = skp;
 	}
 	ssp->smk_packet = NULL;
+	ssp->smk_state = SMACK_SOCKET_UNSET;
 
 	return 0;
 }
@@ -2370,11 +2374,41 @@ static int smack_netlabel(struct sock *sk, int labeled)
 	bh_lock_sock_nested(sk);
 
 	if (ssp->smk_out == smack_net_ambient ||
-	    labeled == SMACK_UNLABELED_SOCKET)
+	    labeled == SMACK_UNLABELED_SOCKET) {
+#ifdef CONFIG_SECURITY_STACKING
+		rc = lsm_sock_vet_attr(sk, NULL, LSM_SOCK_SMACK);
+		if (!rc) {
+			netlbl_sock_delattr(sk);
+			ssp->smk_state = SMACK_SOCKET_UNLABELED;
+		}
+#else
 		netlbl_sock_delattr(sk);
-	else {
+		ssp->smk_state = SMACK_SOCKET_UNLABELED;
+#endif
+	} else {
 		skp = ssp->smk_out;
-		rc = netlbl_sock_setattr(sk, sk->sk_family, &skp->smk_netlabel);
+#ifdef CONFIG_SECURITY_STACKING
+		rc = lsm_sock_vet_attr(sk, &skp->smk_netlabel, LSM_SOCK_SMACK);
+		if (!rc) {
+			rc = netlbl_sock_setattr(sk, sk->sk_family,
+						 &skp->smk_netlabel);
+			if (rc == -EDESTADDRREQ) {
+				pr_info("Smack: %s set socket deferred\n",
+					__func__);
+				rc = 0;
+			}
+			ssp->smk_state = SMACK_SOCKET_CIPSO;
+		}
+#else
+		rc = netlbl_sock_setattr(sk, sk->sk_family,
+					 &skp->smk_netlabel);
+		if (rc == -EDESTADDRREQ) {
+			pr_info("Smack: %s set socket deferred\n",
+				__func__);
+			rc = 0;
+		}
+		ssp->smk_state = SMACK_SOCKET_CIPSO;
+#endif
 	}
 
 	bh_unlock_sock(sk);
@@ -3183,12 +3217,12 @@ static int smack_ipc_permission(struct kern_ipc_perm *ipp, short flag)
  * @ipp: the object permissions
  * @secid: where result will be saved
  */
-static void smack_ipc_getsecid(struct kern_ipc_perm *ipp, u32 *secid)
+static void smack_ipc_getsecid(struct kern_ipc_perm *ipp, struct secids *secid)
 {
 	struct smack_known **blob = smack_ipc(ipp);
 	struct smack_known *iskp = *blob;
 
-	*secid = iskp->smk_secid;
+	secid->smack = iskp->smk_secid;
 }
 
 /**
@@ -3648,6 +3682,11 @@ static struct smack_known *smack_from_secattr(struct netlbl_lsm_secattr *sap,
 	int acat;
 	int kcat;
 
+	if ((sap->flags & NETLBL_SECATTR_SECID) != 0)
+		/*
+		 * Looks like a fallback, which gives us a secid.
+		 */
+		return smack_from_secid(sap->attr.secid.smack);
 	if ((sap->flags & NETLBL_SECATTR_MLS_LVL) != 0) {
 		/*
 		 * Looks like a CIPSO packet.
@@ -3695,11 +3734,6 @@ static struct smack_known *smack_from_secattr(struct netlbl_lsm_secattr *sap,
 			return &smack_known_web;
 		return &smack_known_star;
 	}
-	if ((sap->flags & NETLBL_SECATTR_SECID) != 0)
-		/*
-		 * Looks like a fallback, which gives us a secid.
-		 */
-		return smack_from_secid(sap->attr.secid);
 	/*
 	 * Without guidance regarding the smack value
 	 * for the packet fall back on the network
@@ -3778,6 +3812,9 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	struct sockaddr_in6 sadd;
 	int proto;
 #endif /* CONFIG_IPV6 */
+#ifdef CONFIG_SECURITY_SMACK_NETFILTER
+	struct secids marks;
+#endif
 
 	switch (sk->sk_family) {
 	case PF_INET:
@@ -3787,9 +3824,13 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		 * If there is no secmark fall back to CIPSO.
 		 * The secmark is assumed to reflect policy better.
 		 */
-		if (skb && skb->secmark != 0) {
-			skp = smack_from_secid(skb->secmark);
-			goto access_check;
+		if (skb) {
+			marks.smack = 0;
+			secid_set(&marks, skb->secmark);
+			if (marks.smack != 0) {
+				skp = smack_from_secid(marks.smack);
+				goto access_check;
+			}
 		}
 #endif /* CONFIG_SECURITY_SMACK_NETFILTER */
 		/*
@@ -3798,7 +3839,7 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		netlbl_secattr_init(&secattr);
 
 		rc = netlbl_skbuff_getattr(skb, sk->sk_family, &secattr);
-		if (rc == 0)
+		if (rc == 0 && secattr.flags != NETLBL_SECATTR_NONE)
 			skp = smack_from_secattr(&secattr, ssp);
 		else
 			skp = smack_net_ambient;
@@ -3823,7 +3864,7 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		rc = smk_access(skp, ssp->smk_in, MAY_WRITE, &ad);
 		rc = smk_bu_note("IPv4 delivery", skp, ssp->smk_in,
 					MAY_WRITE, rc);
-		if (rc != 0)
+		if (rc != 0 && ssp->smk_state == SMACK_SOCKET_CIPSO)
 			netlbl_skbuff_err(skb, sk->sk_family, rc, 0);
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
@@ -3832,9 +3873,12 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		if (proto != IPPROTO_UDP && proto != IPPROTO_TCP)
 			break;
 #ifdef SMACK_IPV6_SECMARK_LABELING
-		if (skb && skb->secmark != 0)
-			skp = smack_from_secid(skb->secmark);
-		else
+		if (skb) {
+			marks.smack = 0;
+			secid_set(&marks, skb->secmark);
+			if (marks.smack != 0)
+				skp = smack_from_secid(marks.smack);
+		} else
 			skp = smack_ipv6host_label(&sadd);
 		if (skp == NULL)
 			skp = smack_net_ambient;
@@ -3867,14 +3911,12 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
  *
  * returns zero on success, an error code otherwise
  */
-static int smack_socket_getpeersec_stream(struct socket *sock,
-					  char __user *optval,
-					  int __user *optlen, unsigned len)
+static int smack_socket_getpeersec_stream(struct socket *sock, char **optval,
+					  int *optlen, unsigned int len)
 {
 	struct socket_smack *ssp;
 	char *rcp = "";
 	int slen = 1;
-	int rc = 0;
 
 	ssp = smack_sock(sock->sk);
 	if (ssp->smk_packet != NULL) {
@@ -3883,14 +3925,13 @@ static int smack_socket_getpeersec_stream(struct socket *sock,
 	}
 
 	if (slen > len)
-		rc = -ERANGE;
-	else if (copy_to_user(optval, rcp, slen) != 0)
-		rc = -EFAULT;
+		return -ERANGE;
 
-	if (put_user(slen, optlen) != 0)
-		rc = -EFAULT;
-
-	return rc;
+	*optval = kstrdup(rcp, GFP_ATOMIC);
+	if (*optval == NULL)
+		return -ENOMEM;
+	*optlen = slen;
+	return 0;
 }
 
 
@@ -3903,7 +3944,8 @@ static int smack_socket_getpeersec_stream(struct socket *sock,
  * Sets the netlabel socket state on sk from parent
  */
 static int smack_socket_getpeersec_dgram(struct socket *sock,
-					 struct sk_buff *skb, u32 *secid)
+					 struct sk_buff *skb,
+					 struct secids *secid)
 
 {
 	struct netlbl_lsm_secattr secattr;
@@ -3912,6 +3954,9 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 	int family = PF_UNSPEC;
 	u32 s = 0;	/* 0 is the invalid secid */
 	int rc;
+#ifdef CONFIG_SECURITY_SMACK_NETFILTER
+	struct secids marks;
+#endif
 
 	if (skb != NULL) {
 		if (skb->protocol == htons(ETH_P_IP))
@@ -3931,9 +3976,13 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 		break;
 	case PF_INET:
 #ifdef CONFIG_SECURITY_SMACK_NETFILTER
-		s = skb->secmark;
-		if (s != 0)
-			break;
+		if (skb->secmark) {
+			marks.smack = 0;
+			secid_set(&marks, skb->secmark);
+			s = marks.smack;
+			if (s != 0)
+				break;
+		}
 #endif
 		/*
 		 * Translate what netlabel gave us.
@@ -3950,11 +3999,13 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 		break;
 	case PF_INET6:
 #ifdef SMACK_IPV6_SECMARK_LABELING
-		s = skb->secmark;
+		marks.smack = 0;
+		secid_set(&marks, skb->secmark);
+		s = marks.smack;
 #endif
 		break;
 	}
-	*secid = s;
+	secid->smack = s;
 	if (s == 0)
 		return -EINVAL;
 	return 0;
@@ -4007,6 +4058,9 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 #ifdef CONFIG_AUDIT
 	struct lsm_network_audit net;
 #endif
+#ifdef CONFIG_SECURITY_SMACK_NETFILTER
+	struct secids marks;
+#endif
 
 #if IS_ENABLED(CONFIG_IPV6)
 	if (family == PF_INET6) {
@@ -4028,9 +4082,13 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 	 * If there is no secmark fall back to CIPSO.
 	 * The secmark is assumed to reflect policy better.
 	 */
-	if (skb && skb->secmark != 0) {
-		skp = smack_from_secid(skb->secmark);
-		goto access_check;
+	if (skb) {
+		marks.smack = 0;
+		secid_set(&marks, skb->secmark);
+		if (marks.smack != 0) {
+			skp = smack_from_secid(marks.smack);
+			goto access_check;
+		}
 	}
 #endif /* CONFIG_SECURITY_SMACK_NETFILTER */
 
@@ -4078,7 +4136,7 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 	hskp = smack_ipv4host_label(&addr);
 	rcu_read_unlock();
 
-	if (hskp == NULL)
+	if (hskp == NULL && ssp->smk_state == SMACK_SOCKET_CIPSO)
 		rc = netlbl_req_setattr(req, &skp->smk_netlabel);
 	else
 		netlbl_req_delattr(req);
@@ -4301,8 +4359,8 @@ static int smack_audit_rule_known(struct audit_krule *krule)
  * The core Audit hook. It's used to take the decision of
  * whether to audit or not to audit a given object.
  */
-static int smack_audit_rule_match(u32 secid, u32 field, u32 op, void *vrule,
-				  struct audit_context *actx)
+static int smack_audit_rule_match(struct secids *secid, u32 field, u32 op,
+				  void *vrule, struct audit_context *actx)
 {
 	struct smack_known *skp;
 	char *rule = vrule;
@@ -4315,7 +4373,7 @@ static int smack_audit_rule_match(u32 secid, u32 field, u32 op, void *vrule,
 	if (field != AUDIT_SUBJ_USER && field != AUDIT_OBJ_USER)
 		return 0;
 
-	skp = smack_from_secid(secid);
+	skp = smack_from_secid(secid->smack);
 
 	/*
 	 * No need to do string comparisons. If a match occurs,
@@ -4355,9 +4413,10 @@ static int smack_ismaclabel(const char *name)
  *
  * Exists for networking code.
  */
-static int smack_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+static int smack_secid_to_secctx(struct secids *secid, char **secdata,
+					u32 *seclen)
 {
-	struct smack_known *skp = smack_from_secid(secid);
+	struct smack_known *skp = smack_from_secid(secid->smack);
 
 	if (secdata)
 		*secdata = skp->smk_known;
@@ -4373,14 +4432,15 @@ static int smack_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
  *
  * Exists for audit and networking code.
  */
-static int smack_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
+static int smack_secctx_to_secid(const char *secdata, u32 seclen,
+					struct secids *secid)
 {
 	struct smack_known *skp = smk_find_entry(secdata);
 
 	if (skp)
-		*secid = skp->smk_secid;
+		secid->smack = skp->smk_secid;
 	else
-		*secid = 0;
+		secid->smack = 0;
 	return 0;
 }
 
@@ -4403,7 +4463,7 @@ static int smack_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 static int smack_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
 {
 	int len = 0;
-	len = smack_inode_getsecurity(inode, XATTR_SMACK_SUFFIX, ctx, true);
+	len = smack_inode_getsecurity(inode, XATTR_SMACK_SUFFIX, ctx, false);
 
 	if (len < 0)
 		return len;
diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
index 701a1cc1bdcc..84a72b8c3bca 100644
--- a/security/smack/smack_netfilter.c
+++ b/security/smack/smack_netfilter.c
@@ -30,11 +30,19 @@ static unsigned int smack_ipv6_output(void *priv,
 	struct sock *sk = skb_to_full_sk(skb);
 	struct socket_smack *ssp;
 	struct smack_known *skp;
+	struct secids marks;
 
 	if (sk && smack_sock(sk)) {
 		ssp = smack_sock(sk);
 		skp = ssp->smk_out;
-		skb->secmark = skp->smk_secid;
+		secid_init(&marks);
+		if (skb->secmark) {
+			secid_set(&marks, skb->secmark);
+			marks.secmark = 0;
+		}
+		marks.smack = skp->smk_secid;
+		secid_update_secmark(&marks);
+		skb->secmark = marks.secmark;
 	}
 
 	return NF_ACCEPT;
@@ -48,11 +56,19 @@ static unsigned int smack_ipv4_output(void *priv,
 	struct sock *sk = skb_to_full_sk(skb);
 	struct socket_smack *ssp;
 	struct smack_known *skp;
+	struct secids marks;
 
 	if (sk && smack_sock(sk)) {
 		ssp = smack_sock(sk);
 		skp = ssp->smk_out;
-		skb->secmark = skp->smk_secid;
+		secid_init(&marks);
+		if (skb->secmark) {
+			secid_set(&marks, skb->secmark);
+			marks.secmark = 0;
+		}
+		marks.smack = skp->smk_secid;
+		secid_update_secmark(&marks);
+		skb->secmark = marks.secmark;
 	}
 
 	return NF_ACCEPT;
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 9d2dde608298..0a075c80abb4 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -197,7 +197,7 @@ static void smk_netlabel_audit_set(struct netlbl_audit *nap)
 
 	nap->loginuid = audit_get_loginuid(current);
 	nap->sessionid = audit_get_sessionid(current);
-	nap->secid = skp->smk_secid;
+	nap->secid.smack = skp->smk_secid;
 }
 
 /*
@@ -1165,6 +1165,7 @@ static ssize_t smk_write_net4addr(struct file *file, const char __user *buf,
 	u32 mask_bits = (1<<31);
 	__be32 nsa;
 	u32 temp_mask;
+	struct secids secid;
 
 	/*
 	 * Must have privilege.
@@ -1281,10 +1282,13 @@ static ssize_t smk_write_net4addr(struct file *file, const char __user *buf,
 	 * this host so that incoming packets get labeled.
 	 * but only if we didn't get the special CIPSO option
 	 */
-	if (rc == 0 && skp != NULL)
+	if (rc == 0 && skp != NULL) {
+		secid_init(&secid);
+		secid.smack = snp->smk_label->smk_secid;
 		rc = netlbl_cfg_unlbl_static_add(&init_net, NULL,
 			&snp->smk_host, &snp->smk_mask, PF_INET,
-			snp->smk_label->smk_secid, &audit_info);
+			&secid, &audit_info);
+	}
 
 	if (rc == 0)
 		rc = count;
@@ -2951,7 +2955,9 @@ static int __init smk_preset_netlabel(struct smack_known *skp)
 {
 	skp->smk_netlabel.domain = skp->smk_known;
 	skp->smk_netlabel.flags =
-		NETLBL_SECATTR_DOMAIN | NETLBL_SECATTR_MLS_LVL;
+		NETLBL_SECATTR_DOMAIN | NETLBL_SECATTR_MLS_LVL |
+		NETLBL_SECATTR_SECID;
+	skp->smk_netlabel.attr.secid.smack = skp->smk_secid;
 	return smk_netlbl_mls(smack_cipso_direct, skp->smk_known,
 				&skp->smk_netlabel, strlen(skp->smk_known));
 }
-- 
2.14.3
