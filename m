Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAFGUGdd007693
	for <selinux@tycho.nsa.gov>; Thu, 15 Nov 2007 11:30:16 -0500
Received: from g1t0028.austin.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAFGUCai010734
	for <selinux@tycho.nsa.gov>; Thu, 15 Nov 2007 16:30:12 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v7 10/13] SELinux: Enable dynamic enable/disable of the
	network access checks
To: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Date: Thu, 15 Nov 2007 11:30:03 -0500
Message-ID: <20071115163003.9970.21138.stgit@flek.americas.hpqcorp.net>
In-Reply-To: <20071115162053.9970.49166.stgit@flek.americas.hpqcorp.net>
References: <20071115162053.9970.49166.stgit@flek.americas.hpqcorp.net>
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

 include/linux/selinux.h         |   45 ++++++++++++++++++++++++++++++++-------
 net/netfilter/xt_SECMARK.c      |   13 ++++++++++-
 security/selinux/exports.c      |   20 ++++++++++++++++-
 security/selinux/hooks.c        |   45 ++++++++++++++++++++++++++++++++-------
 security/selinux/include/xfrm.h |   17 +++++++++++++++
 security/selinux/xfrm.c         |   18 ++++++++++++++--
 6 files changed, 137 insertions(+), 21 deletions(-)

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
index b6f9694..87d2bb3 100644
--- a/security/selinux/exports.c
+++ b/security/selinux/exports.c
@@ -17,10 +17,14 @@
 #include <linux/selinux.h>
 #include <linux/fs.h>
 #include <linux/ipc.h>
+#include <asm/atomic.h>
 
 #include "security.h"
 #include "objsec.h"
 
+/* SECMARK reference count */
+extern atomic_t selinux_secmark_refcount;
+
 int selinux_sid_to_string(u32 sid, char **ctx, u32 *ctxlen)
 {
 	if (selinux_enabled)
@@ -74,7 +78,7 @@ int selinux_string_to_sid(char *str, u32 *sid)
 }
 EXPORT_SYMBOL_GPL(selinux_string_to_sid);
 
-int selinux_relabel_packet_permission(u32 sid)
+int selinux_secmark_relabel_packet_permission(u32 sid)
 {
 	if (selinux_enabled) {
 		struct task_security_struct *tsec = current->security;
@@ -84,4 +88,16 @@ int selinux_relabel_packet_permission(u32 sid)
 	}
 	return 0;
 }
-EXPORT_SYMBOL_GPL(selinux_relabel_packet_permission);
+EXPORT_SYMBOL_GPL(selinux_secmark_relabel_packet_permission);
+
+void selinux_secmark_refcount_inc(void)
+{
+	atomic_inc(&selinux_secmark_refcount);
+}
+EXPORT_SYMBOL_GPL(selinux_secmark_refcount_inc);
+
+void selinux_secmark_refcount_dec(void)
+{
+	atomic_dec(&selinux_secmark_refcount);
+}
+EXPORT_SYMBOL_GPL(selinux_secmark_refcount_dec);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8aeb1c0..22789b5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -50,8 +50,10 @@
 #include <net/icmp.h>
 #include <net/ip.h>		/* for local_port_range[] */
 #include <net/tcp.h>		/* struct or_callable used in sock_rcv_skb */
+#include <net/netlabel.h>
 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
+#include <asm/atomic.h>
 #include <linux/bitops.h>
 #include <linux/interrupt.h>
 #include <linux/netdevice.h>	/* for network interface checks */
@@ -87,6 +89,9 @@ extern int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm);
 extern int selinux_compat_net;
 extern struct security_operations *security_ops;
 
+/* SECMARK reference count */
+atomic_t selinux_secmark_refcount = ATOMIC_INIT(0);
+
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
 int selinux_enforcing = 0;
 
@@ -153,6 +158,21 @@ getsecurity_exit:
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
+	return (atomic_read(&selinux_secmark_refcount) > 0);
+}
+
 /* Allocate and free functions for each kind of security blob. */
 
 static int task_alloc_security(struct task_struct *task)
@@ -3731,15 +3751,24 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		return selinux_sock_rcv_skb_compat(sk, skb, &ad, family,
 						   addrp, len);
 
-	err = avc_has_perm(sk_sid, skb->secmark, SECCLASS_PACKET,
-			   PACKET__RECV, &ad);
-	if (err)
-		return err;
+	if (selinux_secmark_enabled()) {
+		err = avc_has_perm(sk_sid, skb->secmark, SECCLASS_PACKET,
+				   PACKET__RECV, &ad);
+		if (err)
+			return err;
+	}
 
-	err = selinux_skb_peerlbl_sid(skb, family, &peer_sid);
-	if (err)
-		return err;
-	return avc_has_perm(sk_sid, peer_sid, SECCLASS_PEER, PEER__RECV, &ad);
+	if (netlbl_enabled() || selinux_xfrm_enabled()) {
+		err = selinux_skb_peerlbl_sid(skb, family, &peer_sid);
+		if (err)
+			return err;
+		err = avc_has_perm(sk_sid, peer_sid, SECCLASS_PEER,
+				   PEER__RECV, &ad);
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
 
 static int selinux_socket_getpeersec_stream(struct socket *sock, char __user *optval,
diff --git a/security/selinux/include/xfrm.h b/security/selinux/include/xfrm.h
index 31929e3..d641f39 100644
--- a/security/selinux/include/xfrm.h
+++ b/security/selinux/include/xfrm.h
@@ -7,6 +7,23 @@
 #ifndef _SELINUX_XFRM_H_
 #define _SELINUX_XFRM_H_
 
+extern atomic_t selinux_xfrm_refcount;
+
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
+static inline int selinux_xfrm_enabled(void)
+{
+	return (atomic_read(&selinux_xfrm_refcount) > 0);
+}
+
 int selinux_xfrm_policy_alloc(struct xfrm_policy *xp,
 		struct xfrm_user_sec_ctx *sec_ctx);
 int selinux_xfrm_policy_clone(struct xfrm_policy *old, struct xfrm_policy *new);
diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index e076039..7e15820 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -46,11 +46,14 @@
 #include <net/checksum.h>
 #include <net/udp.h>
 #include <asm/semaphore.h>
+#include <asm/atomic.h>
 
 #include "avc.h"
 #include "objsec.h"
 #include "xfrm.h"
 
+/* Labeled XFRM instance counter */
+atomic_t selinux_xfrm_refcount = ATOMIC_INIT(0);
 
 /*
  * Returns true if an LSM/SELinux context
@@ -293,6 +296,9 @@ int selinux_xfrm_policy_alloc(struct xfrm_policy *xp,
 	BUG_ON(!uctx);
 
 	err = selinux_xfrm_sec_ctx_alloc(&xp->security, uctx, 0);
+	if (err == 0)
+		atomic_inc(&selinux_xfrm_refcount);
+
 	return err;
 }
 
@@ -340,10 +346,13 @@ int selinux_xfrm_policy_delete(struct xfrm_policy *xp)
 	struct xfrm_sec_ctx *ctx = xp->security;
 	int rc = 0;
 
-	if (ctx)
+	if (ctx) {
 		rc = avc_has_perm(tsec->sid, ctx->ctx_sid,
 				  SECCLASS_ASSOCIATION,
 				  ASSOCIATION__SETCONTEXT, NULL);
+		if (rc == 0)
+			atomic_dec(&selinux_xfrm_refcount);
+	}
 
 	return rc;
 }
@@ -360,6 +369,8 @@ int selinux_xfrm_state_alloc(struct xfrm_state *x, struct xfrm_user_sec_ctx *uct
 	BUG_ON(!x);
 
 	err = selinux_xfrm_sec_ctx_alloc(&x->security, uctx, secid);
+	if (err == 0)
+		atomic_inc(&selinux_xfrm_refcount);
 	return err;
 }
 
@@ -382,10 +393,13 @@ int selinux_xfrm_state_delete(struct xfrm_state *x)
 	struct xfrm_sec_ctx *ctx = x->security;
 	int rc = 0;
 
-	if (ctx)
+	if (ctx) {
 		rc = avc_has_perm(tsec->sid, ctx->ctx_sid,
 				  SECCLASS_ASSOCIATION,
 				  ASSOCIATION__SETCONTEXT, NULL);
+		if (rc == 0)
+			atomic_dec(&selinux_xfrm_refcount);
+	}
 
 	return rc;
 }


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
