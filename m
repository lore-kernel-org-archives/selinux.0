Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA5LiNY9002843
	for <selinux@tycho.nsa.gov>; Mon, 5 Nov 2007 16:44:23 -0500
Received: from atlrel6.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lA5LiMU5020364
	for <selinux@tycho.nsa.gov>; Mon, 5 Nov 2007 21:44:23 GMT
Received: from smtp2.fc.hp.com (smtp.cnd.hp.com [15.11.136.114])
	by atlrel6.hp.com (Postfix) with ESMTP id 21DCB3542E
	for <selinux@tycho.nsa.gov>; Mon,  5 Nov 2007 16:44:22 -0500 (EST)
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v5 7/8] SELinux: Enable dynamic enable/disable of the
	network access checks
To: selinux@tycho.nsa.gov
Date: Mon, 05 Nov 2007 16:44:15 -0500
Message-ID: <20071105214414.9361.52849.stgit@flek.americas.hpqcorp.net>
In-Reply-To: <20071105213829.9361.58157.stgit@flek.americas.hpqcorp.net>
References: <20071105213829.9361.58157.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch introduces a mechanism for checking when labeled IPsec or SECMARK
are in use by keeping introducing a configuration reference counter for each
subsystem.  In the case of labeled IPsec, whenever a labeled SA or SPD entry
is created the labeled IPsec/XFRM reference count is increased and when the
entry is removed it is decreased.  In the case of SECMARK, when a SECMARK
target is created the reference count is increased and later decreased when the
target is removed.  These reference counters allow SELinux to quickly determine
if either of these subsystems are enabled.

NetLabel already has a similar mechanism which provides the netlbl_enabled()
function.

This patch also renames the selinux_relabel_packet_permission() function to
selinux_secmark_relabel_packet_permission() as the original name and
description were misleading in that they referenced a single packet label which
is not the case.
---

 include/linux/selinux.h         |   45 +++++++++++++++++++++++++-----
 net/netfilter/xt_SECMARK.c      |   13 ++++++++-
 security/selinux/exports.c      |   25 +++++++++++++++--
 security/selinux/hooks.c        |   32 +++++++++++++++++++++-
 security/selinux/include/xfrm.h |    2 +
 security/selinux/xfrm.c         |   58 ++++++++++++++++++++++++++++++++++++++-
 6 files changed, 161 insertions(+), 14 deletions(-)

diff --git a/include/linux/selinux.h b/include/linux/selinux.h
index d1b7ca6..691170b 100644
--- a/include/linux/selinux.h
+++ b/include/linux/selinux.h
@@ -120,16 +120,35 @@ void selinux_get_task_sid(struct task_struct *tsk, u32 *sid);
 int selinux_string_to_sid(char *str, u32 *sid);
 
 /**
- *     selinux_relabel_packet_permission - check permission to relabel a packet
- *     @sid: ID value to be applied to network packet (via SECMARK, most likely)
+ *     selinux_secmark_relabel_packet_permission - secmark permission check
+ *     @sid: SECMARK ID value to be applied to network packet
  *
- *     Returns 0 if the current task is allowed to label packets with the
- *     supplied security ID.  Note that it is implicit that the packet is always
- *     being relabeled from the default unlabled value, and that the access
- *     control decision is made in the AVC.
+ *     Returns 0 if the current task is allowed to set the SECMARK label of
+ *     packets with the supplied security ID.  Note that it is implicit that
+ *     the packet is always being relabeled from the default unlabeled value,
+ *     and that the access control decision is made in the AVC.
  */
-int selinux_relabel_packet_permission(u32 sid);
+int selinux_secmark_relabel_packet_permission(u32 sid);
 
+/**
+ *     selinux_secmark_refcount_inc - increments the secmark use counter
+ *
+ *     SELinux keeps track of the current SECMARK targets in use so it knows
+ *     when to apply SECMARK label access checks to network packets.  This
+ *     function incements this reference count to indicate that a new SECMARK
+ *     target has been configured.
+ */
+void selinux_secmark_refcount_inc(void);
+
+/**
+ *     selinux_secmark_refcount_dec - decrements the secmark use counter
+ *
+ *     SELinux keeps track of the current SECMARK targets in use so it knows
+ *     when to apply SECMARK label access checks to network packets.  This
+ *     function decements this reference count to indicate that one of the
+ *     existing SECMARK targets has been removed/flushed.
+ */
+void selinux_secmark_refcount_dec(void);
 #else
 
 static inline int selinux_audit_rule_init(u32 field, u32 op,
@@ -184,11 +203,21 @@ static inline int selinux_string_to_sid(const char *str, u32 *sid)
        return 0;
 }
 
-static inline int selinux_relabel_packet_permission(u32 sid)
+static inline int selinux_secmark_relabel_packet_permission(u32 sid)
 {
 	return 0;
 }
 
+static inline void selinux_secmark_refcount_inc(void)
+{
+	return;
+}
+
+static inline void selinux_secmark_refcount_dec(void)
+{
+	return;
+}
+
 #endif	/* CONFIG_SECURITY_SELINUX */
 
 #endif /* _LINUX_SELINUX_H */
diff --git a/net/netfilter/xt_SECMARK.c b/net/netfilter/xt_SECMARK.c
index 235806e..db4a1fe 100644
--- a/net/netfilter/xt_SECMARK.c
+++ b/net/netfilter/xt_SECMARK.c
@@ -72,12 +72,13 @@ static bool checkentry_selinux(struct xt_secmark_target_info *info)
 		return false;
 	}
 
-	err = selinux_relabel_packet_permission(sel->selsid);
+	err = selinux_secmark_relabel_packet_permission(sel->selsid);
 	if (err) {
 		printk(KERN_INFO PFX "unable to obtain relabeling permission\n");
 		return false;
 	}
 
+	selinux_secmark_refcount_inc();
 	return true;
 }
 
@@ -109,11 +110,20 @@ static bool checkentry(const char *tablename, const void *entry,
 	return true;
 }
 
+void destroy(const struct xt_target *target, void *targinfo)
+{
+	switch (mode) {
+	case SECMARK_MODE_SEL:
+		selinux_secmark_refcount_dec();
+	}
+}
+
 static struct xt_target xt_secmark_target[] __read_mostly = {
 	{
 		.name		= "SECMARK",
 		.family		= AF_INET,
 		.checkentry	= checkentry,
+		.destroy	= destroy,
 		.target		= target,
 		.targetsize	= sizeof(struct xt_secmark_target_info),
 		.table		= "mangle",
@@ -123,6 +133,7 @@ static struct xt_target xt_secmark_target[] __read_mostly = {
 		.name		= "SECMARK",
 		.family		= AF_INET6,
 		.checkentry	= checkentry,
+		.destroy	= destroy,
 		.target		= target,
 		.targetsize	= sizeof(struct xt_secmark_target_info),
 		.table		= "mangle",
diff --git a/security/selinux/exports.c b/security/selinux/exports.c
index b6f9694..eec5dd5 100644
--- a/security/selinux/exports.c
+++ b/security/selinux/exports.c
@@ -17,10 +17,15 @@
 #include <linux/selinux.h>
 #include <linux/fs.h>
 #include <linux/ipc.h>
+#include <linux/spinlock.h>
 
 #include "security.h"
 #include "objsec.h"
 
+/* SECMARK reference count */
+static DEFINE_SPINLOCK(selinux_secmark_refcount_lock);
+extern u32 selinux_secmark_refcount;
+
 int selinux_sid_to_string(u32 sid, char **ctx, u32 *ctxlen)
 {
 	if (selinux_enabled)
@@ -74,7 +79,7 @@ int selinux_string_to_sid(char *str, u32 *sid)
 }
 EXPORT_SYMBOL_GPL(selinux_string_to_sid);
 
-int selinux_relabel_packet_permission(u32 sid)
+int selinux_secmark_relabel_packet_permission(u32 sid)
 {
 	if (selinux_enabled) {
 		struct task_security_struct *tsec = current->security;
@@ -84,4 +89,20 @@ int selinux_relabel_packet_permission(u32 sid)
 	}
 	return 0;
 }
-EXPORT_SYMBOL_GPL(selinux_relabel_packet_permission);
+EXPORT_SYMBOL_GPL(selinux_secmark_relabel_packet_permission);
+
+void selinux_secmark_refcount_inc(void)
+{
+	spin_lock(&selinux_secmark_refcount_lock);
+	selinux_secmark_refcount++;
+	spin_unlock(&selinux_secmark_refcount_lock);
+}
+EXPORT_SYMBOL_GPL(selinux_secmark_refcount_inc);
+
+void selinux_secmark_refcount_dec(void)
+{
+	spin_lock(&selinux_secmark_refcount_lock);
+	selinux_secmark_refcount--;
+	spin_unlock(&selinux_secmark_refcount_lock);
+}
+EXPORT_SYMBOL_GPL(selinux_secmark_refcount_dec);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 96c6ded..510ef49 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -50,6 +50,7 @@
 #include <net/icmp.h>
 #include <net/ip.h>		/* for local_port_range[] */
 #include <net/tcp.h>		/* struct or_callable used in sock_rcv_skb */
+#include <net/netlabel.h>
 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
 #include <linux/bitops.h>
@@ -87,6 +88,12 @@ extern int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm);
 extern int selinux_compat_net;
 extern struct security_operations *security_ops;
 
+/* SECMARK reference count
+ * This reference counter is read-only via RCU (see selinux_secmark_enabled())
+ * in this file, it is updated by the selinux_secmark_refcount_[inc|dec]()
+ * functions with spinlocks providing write protection. */
+u32 selinux_secmark_refcount = 0;
+
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
 int selinux_enforcing = 0;
 
@@ -153,6 +160,27 @@ getsecurity_exit:
 	return len;
 }
 
+/**
+ * selinux_secmark_enabled - Check to see if SECMARK is currently enabled
+ *
+ * Description:
+ * This function checks the SECMARK reference counter to see if any SECMARK
+ * targets are currently configured, if the reference counter is greater than
+ * zero SECMARK is considered to be enabled.  Returns true (1) if SECMARK is
+ * enabled, false (0) if SECMARK is disabled.
+ *
+ */
+static int selinux_secmark_enabled(void)
+{
+	int rc;
+
+	rcu_read_lock();
+	rc = (selinux_secmark_refcount > 0 ? 1 : 0);
+	rcu_read_unlock();
+
+	return rc;
+}
+
 /* Allocate and free functions for each kind of security blob. */
 
 static int task_alloc_security(struct task_struct *task)
@@ -3719,7 +3747,7 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	if (selinux_compat_net)
 		err = selinux_sock_rcv_skb_compat(sk, skb, &ad, family,
 						  addrp, len);
-	else
+	else if (!selinux_policycap_netpeer || selinux_secmark_enabled())
 		err = avc_has_perm(sksec->sid, skb->secmark, SECCLASS_PACKET,
 				   PACKET__RECV, &ad);
 	if (err)
@@ -3727,6 +3755,8 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 
 	if (!selinux_policycap_netpeer)
 		return selinux_sock_recv_peer_compat(sksec, skb, family, ad);
+	if (!netlbl_enabled() && !selinux_xfrm_enabled())
+		return 0;
 	err = selinux_skb_peerlbl_sid(skb, family, &peer_sid);
 	if (err)
 		return err;
diff --git a/security/selinux/include/xfrm.h b/security/selinux/include/xfrm.h
index 31929e3..729d86e 100644
--- a/security/selinux/include/xfrm.h
+++ b/security/selinux/include/xfrm.h
@@ -7,6 +7,8 @@
 #ifndef _SELINUX_XFRM_H_
 #define _SELINUX_XFRM_H_
 
+int selinux_xfrm_enabled(void);
+
 int selinux_xfrm_policy_alloc(struct xfrm_policy *xp,
 		struct xfrm_user_sec_ctx *sec_ctx);
 int selinux_xfrm_policy_clone(struct xfrm_policy *old, struct xfrm_policy *new);
diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index 36a191e..7a96432 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -42,6 +42,8 @@
 #include <linux/tcp.h>
 #include <linux/skbuff.h>
 #include <linux/xfrm.h>
+#include <linux/spinlock.h>
+#include <linux/rcupdate.h>
 #include <net/xfrm.h>
 #include <net/checksum.h>
 #include <net/udp.h>
@@ -51,6 +53,9 @@
 #include "objsec.h"
 #include "xfrm.h"
 
+/* Labeled XFRM instance counter */
+static DEFINE_SPINLOCK(selinux_xfrm_refcount_lock);
+static u32 selinux_xfrm_refcount = 0;
 
 /*
  * Returns true if an LSM/SELinux context
@@ -70,6 +75,44 @@ static inline int selinux_authorizable_xfrm(struct xfrm_state *x)
 	return selinux_authorizable_ctx(x->security);
 }
 
+/**
+ * selinux_xfrm_enabled - Determine if labeled XFRM is enabled
+ *
+ * Description:
+ * This function checks to see if there are any labeled SAs or entries in the
+ * SPD.  If there are then labeled XFRM is currently enabled, if not it is
+ * currently disabled.  Returns true (1) if labeled XFRM is enabled, false (0)
+ * if labeled XFRM is disabled.
+ *
+ */
+int selinux_xfrm_enabled(void)
+{
+	int rc;
+
+	rcu_read_lock();
+	rc = (selinux_xfrm_refcount > 0 ? 1 : 0);
+	rcu_read_unlock();
+
+	return rc;
+}
+
+/**
+ * selinux_xfrm_refcount_adj - Adjust the labeled XFRM reference count
+ *
+ * Description:
+ * Adjust the labeled XFRM reference count which is used to determine if the
+ * labeled XFRM functionality is currently enabled/in-use.
+ *
+ */
+static void selinux_xfrm_refcount_adj(int adj)
+{
+	unsigned long sl_flags;
+
+	spin_lock_irqsave(&selinux_xfrm_refcount_lock, sl_flags);
+	selinux_xfrm_refcount += adj;
+	spin_unlock_irqrestore(&selinux_xfrm_refcount_lock, sl_flags);
+}
+
 /*
  * LSM hook implementation that authorizes that a flow can use
  * a xfrm policy rule.
@@ -292,6 +335,9 @@ int selinux_xfrm_policy_alloc(struct xfrm_policy *xp,
 	BUG_ON(!uctx);
 
 	err = selinux_xfrm_sec_ctx_alloc(&xp->security, uctx, 0);
+	if (err == 0)
+		selinux_xfrm_refcount_adj(1);
+
 	return err;
 }
 
@@ -339,10 +385,13 @@ int selinux_xfrm_policy_delete(struct xfrm_policy *xp)
 	struct xfrm_sec_ctx *ctx = xp->security;
 	int rc = 0;
 
-	if (ctx)
+	if (ctx) {
 		rc = avc_has_perm(tsec->sid, ctx->ctx_sid,
 				  SECCLASS_ASSOCIATION,
 				  ASSOCIATION__SETCONTEXT, NULL);
+		if (rc == 0)
+			selinux_xfrm_refcount_adj(-1);
+	}
 
 	return rc;
 }
@@ -359,6 +408,8 @@ int selinux_xfrm_state_alloc(struct xfrm_state *x, struct xfrm_user_sec_ctx *uct
 	BUG_ON(!x);
 
 	err = selinux_xfrm_sec_ctx_alloc(&x->security, uctx, secid);
+	if (err == 0)
+		selinux_xfrm_refcount_adj(1);
 	return err;
 }
 
@@ -381,10 +432,13 @@ int selinux_xfrm_state_delete(struct xfrm_state *x)
 	struct xfrm_sec_ctx *ctx = x->security;
 	int rc = 0;
 
-	if (ctx)
+	if (ctx) {
 		rc = avc_has_perm(tsec->sid, ctx->ctx_sid,
 				  SECCLASS_ASSOCIATION,
 				  ASSOCIATION__SETCONTEXT, NULL);
+		if (rc == 0)
+			selinux_xfrm_refcount_adj(-1);
+	}
 
 	return rc;
 }


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
