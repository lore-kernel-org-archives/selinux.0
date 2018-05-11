Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4B0uVRP002004
 for <selinux@tycho.nsa.gov>; Thu, 10 May 2018 20:56:32 -0400
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
Message-ID: <aa0fe6a0-3830-7e54-4f71-146d4299eb75@schaufler-ca.com>
Date: Thu, 10 May 2018 17:56:01 -0700
MIME-Version: 1.0
In-Reply-To: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Subject: [PATCH 21/23] LSM: Multiple concurrent major security
 modules
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Casey Schaufler <casey@schaufler-ca.com>
Date: Thu, 10 May 2018 16:00:42 -0700
Subject: [PATCH 21/23] LSM: Multiple concurrent major security modules

In which it becomes evident just how wildy divergent
the various networking mechanisms are.

When CONFIG_SECURITY_STACKING is defined a "struct secids"
changes from a union of u32's to a structure containing
a u32 for each of the security modules using secids.

The task blob is given space to include the name of the security
module to report with security_getpeersec_stream and SO_PEERSEC.
This can be set with a new prctl PR_SET_DISPLAY_LSM.

The CIPSO local tag will pass the full struct secids,
regardless of its size. This is safe because the local tag
never leaves the box. A function has been added to the
netlabel KAPI to check if two secattr_t structures
represent compatible on-wire labels. SELinux and Smack will
check that the label they want to set on a socket are
compatible and fail if they aren't. In the netlabel configuration
on a Fedora system creating internet domain sockets will
almost always fail, as SELinux and Smack have very different
use models for CIPSO. The result will be safe, if not
especially useful.

The interfaces used to store security attributes for
checkpoint/restart will keep the attributes for all of
the security modules.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h    |   8 ++
 include/linux/security.h     |  43 +++++-
 include/net/netlabel.h       |   8 ++
 include/uapi/linux/prctl.h   |   4 +
 kernel/fork.c                |   3 +
 net/ipv4/cipso_ipv4.c        |  19 ++-
 net/netfilter/xt_SECMARK.c   |   2 +-
 net/netlabel/netlabel_kapi.c |  50 +++++++
 net/unix/af_unix.c           |   7 +
 security/Kconfig             |  25 +---
 security/Makefile            |   1 +
 security/security.c          | 329 +++++++++++++++++++++++++++++++++++++++----
 security/selinux/netlabel.c  |   8 ++
 security/smack/smack_lsm.c   |  25 +++-
 14 files changed, 468 insertions(+), 64 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 84bc9ec01931..6c4b4acaac1c 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -28,6 +28,7 @@
 #include <linux/security.h>
 #include <linux/init.h>
 #include <linux/rculist.h>
+#include <net/netlabel.h>
 
 /**
  * union security_list_options - Linux Security Module hook function list
@@ -2096,4 +2097,11 @@ void lsm_early_task(struct task_struct *task);
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
index 712d138e0148..7258daf56494 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -53,6 +53,7 @@ struct msg_msg;
 struct xattr;
 struct xfrm_sec_ctx;
 struct mm_struct;
+struct sk_buff;
 
 /* If capable should audit the security request */
 #define SECURITY_CAP_NOAUDIT 0
@@ -70,6 +71,30 @@ enum lsm_event {
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
+extern bool secid_valid(const struct secids *secids);
+
+#else /* CONFIG_SECURITY_STACKING */
+
 struct secids {
 	union {
 		u32 secmark;
@@ -83,6 +108,8 @@ static inline bool secid_valid(const struct secids *secids)
 	return secids->secmark != 0;
 }
 
+#endif /* CONFIG_SECURITY_STACKING */
+
 static inline void secid_init(struct secids *secid)
 {
 	memset(secid, 0, sizeof(*secid));
@@ -119,7 +146,6 @@ extern int cap_task_setnice(struct task_struct *p, int nice);
 extern int cap_vm_enough_memory(struct mm_struct *mm, long pages);
 
 struct msghdr;
-struct sk_buff;
 struct sock;
 struct sockaddr;
 struct socket;
@@ -805,17 +831,23 @@ static inline int security_inode_killpriv(struct dentry *dentry)
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
@@ -1053,7 +1085,8 @@ static inline int security_task_prctl(int option, unsigned long arg2,
 	return cap_task_prctl(option, arg2, arg3, arg4, arg5);
 }
 
-static inline void security_task_to_inode(struct task_struct *p, struct inode *inode)
+static inline void security_task_to_inode(struct task_struct *p,
+					  struct inode *inode)
 { }
 
 static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
diff --git a/include/net/netlabel.h b/include/net/netlabel.h
index 51dacbb88886..5c7e19498a81 100644
--- a/include/net/netlabel.h
+++ b/include/net/netlabel.h
@@ -472,6 +472,8 @@ int netlbl_catmap_setlong(struct netlbl_lsm_catmap **catmap,
 			  u32 offset,
 			  unsigned long bitmap,
 			  gfp_t flags);
+bool netlbl_secattr_equal(const struct netlbl_lsm_secattr *secattr_a,
+			  const struct netlbl_lsm_secattr *secattr_b);
 
 /* Bitmap functions
  */
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
diff --git a/kernel/fork.c b/kernel/fork.c
index a5d21c42acfc..9336efdcaae0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1759,6 +1759,9 @@ static __latent_entropy struct task_struct *copy_process(
 	p->sequential_io	= 0;
 	p->sequential_io_avg	= 0;
 #endif
+#ifdef CONFIG_SECURITY
+	p->security = NULL;
+#endif
 
 	/* Perform scheduler related setup. Assign this task to a CPU. */
 	retval = sched_fork(clone_flags, p);
diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index 296918dff71e..b3e267ca7c19 100644
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
-	*(u32 *)&buffer[2] = secattr->attr.secid.secmark;
+	memcpy(&buffer[2], &secattr->attr.secid, sizeof(struct secids));
 
 	return CIPSO_V4_TAG_LOC_BLEN;
 }
@@ -1500,7 +1513,7 @@ static int cipso_v4_parsetag_loc(const struct cipso_v4_doi *doi_def,
 				 const unsigned char *tag,
 				 struct netlbl_lsm_secattr *secattr)
 {
-	secattr->attr.secid.secmark = *(u32 *)&tag[2];
+	memcpy(&secattr->attr.secid, &tag[2], sizeof(struct secids));
 	secattr->flags |= NETLBL_SECATTR_SECID;
 
 	return 0;
diff --git a/net/netfilter/xt_SECMARK.c b/net/netfilter/xt_SECMARK.c
index e67a6dc7ae1d..6af1f4fc837d 100644
--- a/net/netfilter/xt_SECMARK.c
+++ b/net/netfilter/xt_SECMARK.c
@@ -59,7 +59,7 @@ static int checkentry_lsm(struct xt_secmark_target_info *info)
 
 	err = security_secctx_to_secid(info->secctx, strlen(info->secctx),
 				       &secid);
-	info->secid = secid.secmark;
+	info->secid = secid.selinux;
 
 	if (err) {
 		if (err == -EINVAL)
diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index cb8a2c790081..e23bad01a149 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
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
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index f0f17fc33157..2667b9e7fd16 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -142,11 +142,18 @@ static struct hlist_head *unix_sockets_unbound(void *addr)
 static void unix_get_secdata(struct scm_cookie *scm, struct sk_buff *skb)
 {
 	UNIXCB(skb).secid = scm->secid.secmark;
+#ifdef CONFIG_SECURITY_STACKING
+	secid_to_skb(&scm->secid, skb);
+#endif
 }
 
 static inline void unix_set_secdata(struct scm_cookie *scm, struct sk_buff *skb)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	secid_from_skb(&scm->secid, skb);
+#else
 	scm->secid.secmark = UNIXCB(skb).secid;
+#endif
 }
 
 static inline bool unix_secdata_eq(struct scm_cookie *scm, struct sk_buff *skb)
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
diff --git a/security/security.c b/security/security.c
index 6144ff52d862..ef51783e967e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -29,12 +29,18 @@
 #include <linux/backing-dev.h>
 #include <linux/string.h>
 #include <linux/msg.h>
+#include <linux/prctl.h>
 #include <net/flow.h>
 #include <net/sock.h>
 
 #include <trace/events/initcall.h>
 
-#define MAX_LSM_EVM_XATTR	2
+/*
+ * This should depend on the number of security modules
+ * that use extended attributes. At this writing it is
+ * at least EVM, SELinux and Smack.
+ */
+#define MAX_LSM_EVM_XATTR	8
 
 /* Maximum number of letters for an LSM name string */
 #define SECURITY_NAME_MAX	10
@@ -47,7 +53,16 @@ static struct kmem_cache *lsm_file_cache;
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
@@ -331,6 +346,14 @@ void __init security_add_blobs(struct lsm_blob_sizes *needed)
 	lsm_set_size(&needed->lbs_key, &blob_sizes.lbs_key);
 #endif
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
@@ -552,6 +575,25 @@ int lsm_superblock_alloc(struct super_block *sb)
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
@@ -874,8 +916,12 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
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
@@ -883,23 +929,40 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
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
+	hlist_for_each_entry(shp, &security_hook_heads.inode_init_security,
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
@@ -1128,18 +1191,22 @@ int security_inode_getattr(const struct path *path)
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
+	hlist_for_each_entry(hp, &security_hook_heads.inode_setxattr, list) {
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
@@ -1580,12 +1647,65 @@ int security_task_kill(struct task_struct *p, struct siginfo *info,
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
 
 	hlist_for_each_entry(hp, &security_hook_heads.task_prctl, list) {
 		thisrc = hp->hook.task_prctl(option, arg2, arg3, arg4, arg5);
@@ -1757,7 +1877,7 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsm))
+		if (lsm && lsm[0] && strcmp(lsm, hp->lsm))
 			continue;
 		return hp->hook.getprocattr(p, name, value);
 	}
@@ -1770,7 +1890,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsm))
+		if (lsm && lsm[0] && strcmp(lsm, hp->lsm))
 			continue;
 		return hp->hook.setprocattr(name, value, size);
 	}
@@ -1790,22 +1910,60 @@ EXPORT_SYMBOL(security_ismaclabel);
 
 int security_secid_to_secctx(struct secids *secid, char **secdata, u32 *seclen)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	struct security_hook_list *hp;
+	char lsm[SECURITY_NAME_MAX + 1];
+
+	lsm_to_display(lsm);
+
+	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list)
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
 
 int security_secctx_to_secid(const char *secdata, u32 seclen,
 			     struct secids *secid)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	struct security_hook_list *hp;
+	char lsm[SECURITY_NAME_MAX + 1];
+	int rc = 0;
+
+	lsm_to_display(lsm);
 	secid_init(secid);
+	hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list)
+		if (lsm[0] == '\0' || !strcmp(lsm, hp->lsm))
+			return hp->hook.secctx_to_secid(secdata, seclen, secid);
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
+	hlist_for_each_entry(hp, &security_hook_heads.release_secctx, list)
+		if (lsm[0] == '\0' || !strcmp(lsm, hp->lsm)) {
+			hp->hook.release_secctx(secdata, seclen);
+			break;
+		}
+#else
 	call_void_hook(release_secctx, secdata, seclen);
+#endif
 }
 EXPORT_SYMBOL(security_release_secctx);
 
@@ -1823,13 +1981,80 @@ EXPORT_SYMBOL(security_inode_notifysecctx);
 
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
+	hlist_for_each_entry(hp, &security_hook_heads.inode_setsecctx, list) {
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
+	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecctx, list) {
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
+		hlist_for_each_entry(rhp, &security_hook_heads.release_secctx,
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
 
@@ -1924,12 +2149,31 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len)
 {
+	struct security_hook_list *hp;
 	char *tval = NULL;
 	u32 tlen;
-	int rc;
+	int rc = -ENOPROTOOPT;
+#ifdef CONFIG_SECURITY_STACKING
+	char lsm[SECURITY_NAME_MAX + 1];
+
+	lsm_to_display(lsm);
+
+	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stream,
+				list) {
+		if (lsm[0] == '\0' || !strcmp(lsm, hp->lsm)) {
+			rc = hp->hook.socket_getpeersec_stream(sock, &tval,
+							       &tlen, len);
+			break;
+		}
+	}
+#else
+	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stream,
+				list) {
+		rc = hp->hook.socket_getpeersec_stream(sock, &tval, &tlen, len);
+		break;
+	}
+#endif
 
-	rc = call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
-			   &tval, &tlen, len);
 	if (rc == 0) {
 		tlen = strlen(tval) + 1;
 		if (put_user(tlen, optlen))
@@ -1944,8 +2188,20 @@ int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
 				     struct secids *secid)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	struct security_hook_list *hp;
+	int rc = -ENOPROTOOPT;
+
+	secid_init(secid);
+	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_dgram,
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
 
@@ -2014,7 +2270,18 @@ EXPORT_SYMBOL(security_inet_conn_established);
 
 int security_secmark_relabel_packet(struct secids *secid)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	struct security_hook_list *hp;
+	int rc;
+
+	hlist_for_each_entry(hp, &security_hook_heads.secmark_relabel_packet,
+				list)
+		rc = hp->hook.secmark_relabel_packet(secid);
+
+	return 0;
+#else
 	return call_int_hook(secmark_relabel_packet, 0, secid);
+#endif
 }
 EXPORT_SYMBOL(security_secmark_relabel_packet);
 
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index efc87a76af72..3c31653d9a25 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -417,6 +417,14 @@ int selinux_netlbl_socket_post_create(struct sock *sk, u16 family)
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
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 12b00aac0c94..f3a2be53dd6c 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2390,13 +2390,32 @@ static int smack_netlabel(struct sock *sk, int labeled)
 	bh_lock_sock_nested(sk);
 
 	if (ssp->smk_out == smack_net_ambient ||
-	    labeled == SMACK_UNLABELED_SOCKET)
+	    labeled == SMACK_UNLABELED_SOCKET) {
+#ifdef CONFIG_SECURITY_STACKING
+		rc = lsm_sock_vet_attr(sk, NULL, LSM_SOCK_SMACK);
+		if (!rc)
+			netlbl_sock_delattr(sk);
+#else
 		netlbl_sock_delattr(sk);
-	else {
+#endif
+	} else {
 		skp = ssp->smk_out;
+#ifdef CONFIG_SECURITY_STACKING
+		rc = lsm_sock_vet_attr(sk, &skp->smk_netlabel, LSM_SOCK_SMACK);
+		if (rc)
+			goto unlock_out;
+#endif
 		rc = netlbl_sock_setattr(sk, sk->sk_family, &skp->smk_netlabel);
+		if (rc == -EDESTADDRREQ) {
+			pr_info("Smack: %s set socket deferred\n", __func__);
+			rc = 0;
+		}
 	}
 
+#ifdef CONFIG_SECURITY_STACKING
+unlock_out:
+#endif
+
 	bh_unlock_sock(sk);
 	local_bh_enable();
 
@@ -3809,7 +3828,7 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		netlbl_secattr_init(&secattr);
 
 		rc = netlbl_skbuff_getattr(skb, sk->sk_family, &secattr);
-		if (rc == 0)
+		if (rc == 0 && secattr.flags != NETLBL_SECATTR_NONE)
 			skp = smack_from_secattr(&secattr, ssp);
 		else
 			skp = smack_net_ambient;
-- 
2.14.3
