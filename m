Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4B0uVRS002004
 for <selinux@tycho.nsa.gov>; Thu, 10 May 2018 20:56:40 -0400
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
Message-ID: <a33d7058-e8a8-60ba-8fe8-126ef72de608@schaufler-ca.com>
Date: Thu, 10 May 2018 17:56:31 -0700
MIME-Version: 1.0
In-Reply-To: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Subject: [PATCH 23/23] Netfilter: Add a selection for Smack
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Casey Schaufler <casey@schaufler-ca.com>
Date: Thu, 10 May 2018 16:28:18 -0700
Subject: [PATCH 23/23] Netfilter: Add a selection for Smack

If you are running a single security module it's
fine to tell the netfilter system that your security
filters are for SELinux, and everything will work just
fine. If you have Smack and SELinux at the same time
you need to be able to differentiate. The netfilter
secmark (xt_SECMARK) code is set up for multiple security
modules, although as a comment points out, only one at
a time. The code wasn't set up to pass the information
about who should process the secmark in the case of
multiple security modules, so that had to be fixed.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h                 |  4 +--
 include/linux/security.h                  | 19 ++++++-----
 include/uapi/linux/netfilter/xt_SECMARK.h |  1 +
 kernel/audit.c                            |  2 ++
 kernel/auditsc.c                          |  2 ++
 net/netfilter/nf_conntrack_netlink.c      | 10 ++++++
 net/netfilter/nf_conntrack_standalone.c   |  5 +++
 net/netfilter/nfnetlink_queue.c           |  5 +++
 net/netfilter/xt_SECMARK.c                | 39 +++++++++++++++++----
 net/netlabel/netlabel_user.c              |  2 +-
 net/unix/af_unix.c                        |  8 ++++-
 security/security.c                       | 37 +++++++++++++++-----
 security/selinux/hooks.c                  | 13 +++++--
 security/smack/smack_lsm.c                | 56 ++++++++++++++++++++++++++-----
 security/smack/smack_netfilter.c          | 11 ++++++
 15 files changed, 175 insertions(+), 39 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 6c4b4acaac1c..9c9ec66e32ce 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1690,8 +1690,8 @@ union security_list_options {
 				const struct request_sock *req);
 	void (*inet_conn_established)(struct sock *sk, struct sk_buff *skb);
 	int (*secmark_relabel_packet)(struct secids *secid);
-	void (*secmark_refcount_inc)(void);
-	void (*secmark_refcount_dec)(void);
+	void (*secmark_refcount_inc)(u8 lsm);
+	void (*secmark_refcount_dec)(u8 lsm);
 	void (*req_classify_flow)(const struct request_sock *req,
 					struct flowi *fl);
 	int (*tun_dev_alloc_security)(void **security);
diff --git a/include/linux/security.h b/include/linux/security.h
index 7258daf56494..dfdff994702c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -79,13 +79,8 @@ enum lsm_event {
 #ifdef CONFIG_SECURITY_STACKING
 
 struct secids {
-	u32 secmark;
-#ifdef CONFIG_SECURITY_SELINUX
 	u32 selinux;
-#endif
-#ifdef CONFIG_SECURITY_SMACK
 	u32 smack;
-#endif
 	u32 flags;
 };
 
@@ -1290,8 +1285,9 @@ void security_inet_csk_clone(struct sock *newsk,
 void security_inet_conn_established(struct sock *sk,
 			struct sk_buff *skb);
 int security_secmark_relabel_packet(struct secids *secid);
-void security_secmark_refcount_inc(void);
-void security_secmark_refcount_dec(void);
+void security_secmark_refcount_inc(u8 lsm);
+void security_secmark_refcount_dec(u8 lsm);
+int security_secmark_mode(u8 lsm);
 int security_tun_dev_alloc_security(void **security);
 void security_tun_dev_free_security(void *security);
 int security_tun_dev_create(void);
@@ -1463,12 +1459,17 @@ static inline int security_secmark_relabel_packet(struct secids *secid)
 	return 0;
 }
 
-static inline void security_secmark_refcount_inc(void)
+static inline void security_secmark_refcount_inc(u8 lsm)
+{
+}
+
+static inline void security_secmark_refcount_dec(u8 lsm)
 {
 }
 
-static inline void security_secmark_refcount_dec(void)
+static inline int security_secmark_mode(u8 lsm)
 {
+	return 0;
 }
 
 static inline int security_tun_dev_alloc_security(void **security)
diff --git a/include/uapi/linux/netfilter/xt_SECMARK.h b/include/uapi/linux/netfilter/xt_SECMARK.h
index 1f2a708413f5..5245a9748599 100644
--- a/include/uapi/linux/netfilter/xt_SECMARK.h
+++ b/include/uapi/linux/netfilter/xt_SECMARK.h
@@ -12,6 +12,7 @@
  * packets are being marked for.
  */
 #define SECMARK_MODE_SEL	0x01		/* SELinux */
+#define SECMARK_MODE_SMACK	0x02		/* Smack */
 #define SECMARK_SECCTX_MAX	256
 
 struct xt_secmark_target_info {
diff --git a/kernel/audit.c b/kernel/audit.c
index 0c424f107b0c..6d7c9a8f47fc 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2172,7 +2172,9 @@ void audit_log_name(struct audit_context *context, struct audit_names *n,
 		u32 len;
 		if (security_secid_to_secctx(
 			&n->osid, &ctx, &len)) {
+#ifndef CONFIG_SECURITY_STACKING
 			audit_log_format(ab, " osid=%u", n->osid.secmark);
+#endif
 			if (call_panic)
 				*call_panic = 2;
 		} else {
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 3ff9a59127ba..556b4eaee4d7 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1207,7 +1207,9 @@ static void show_special(struct audit_context *context, int *call_panic)
 			char *ctx = NULL;
 			u32 len;
 			if (security_secid_to_secctx(&osid, &ctx, &len)) {
+#ifndef CONFIG_SECURITY_STACKING
 				audit_log_format(ab, " osid=%u", osid.secmark);
+#endif
 				*call_panic = 1;
 			} else {
 				audit_log_format(ab, " obj=%s", ctx);
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 379b1651c758..78c6cc2a869d 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -314,8 +314,13 @@ static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
 	char *secctx;
 	struct secids secid;
 
+#ifdef CONFIG_SECURITY_STACKING
 	secid_init(&secid);
+	secid.selinux = ct->secmark;
+	secid.smack = ct->secmark;
+#else
 	secid.secmark = ct->secmark;
+#endif
 
 	ret = security_secid_to_secctx(&secid, &secctx, &len);
 	if (ret)
@@ -598,8 +603,13 @@ static inline int ctnetlink_secctx_size(const struct nf_conn *ct)
 	int len, ret;
 	struct secids secid;
 
+#ifdef CONFIG_SECURITY_STACKING
 	secid_init(&secid);
+	secid.selinux = ct->secmark;
+	secid.smack = ct->secmark;
+#else
 	secid.secmark = ct->secmark;
+#endif
 
 	ret = security_secid_to_secctx(&secid, NULL, &len);
 	if (ret)
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index f55f3c02520a..e3f32622cc36 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -183,8 +183,13 @@ static void ct_show_secctx(struct seq_file *s, const struct nf_conn *ct)
 	char *secctx;
 	struct secids secid;
 
+#ifdef CONFIG_SECURITY_STACKING
 	secid_init(&secid);
+	secid.selinux = ct->secmark;
+	secid.smack = ct->secmark;
+#else
 	secid.secmark = ct->secmark;
+#endif
 
 	ret = security_secid_to_secctx(&secid, &secctx, &len);
 	if (ret)
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 82d50d78c851..86a2d7b5e322 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -297,8 +297,13 @@ static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
 	read_lock_bh(&skb->sk->sk_callback_lock);
 
 	if (skb->secmark) {
+#ifdef CONFIG_SECURITY_STACKING
 		secid_init(&secid);
+		secid.selinux = skb->secmark;
+		secid.smack = skb->secmark;
+#else
 		secid.secmark = skb->secmark;
+#endif
 		security_secid_to_secctx(&secid, secdata, &seclen);
 	}
 
diff --git a/net/netfilter/xt_SECMARK.c b/net/netfilter/xt_SECMARK.c
index 6af1f4fc837d..a4646c301307 100644
--- a/net/netfilter/xt_SECMARK.c
+++ b/net/netfilter/xt_SECMARK.c
@@ -41,6 +41,9 @@ secmark_tg(struct sk_buff *skb, const struct xt_action_param *par)
 	case SECMARK_MODE_SEL:
 		secmark = info->secid;
 		break;
+	case SECMARK_MODE_SMACK:
+		secmark = info->secid;
+		break;
 	default:
 		BUG();
 	}
@@ -59,7 +62,16 @@ static int checkentry_lsm(struct xt_secmark_target_info *info)
 
 	err = security_secctx_to_secid(info->secctx, strlen(info->secctx),
 				       &secid);
-	info->secid = secid.selinux;
+	switch (info->mode) {
+	case SECMARK_MODE_SEL:
+		info->secid = secid.selinux;
+		break;
+	case SECMARK_MODE_SMACK:
+		info->secid = secid.smack;
+		break;
+	default:
+		BUG();
+	}
 
 	if (err) {
 		if (err == -EINVAL)
@@ -80,7 +92,8 @@ static int checkentry_lsm(struct xt_secmark_target_info *info)
 		return err;
 	}
 
-	security_secmark_refcount_inc();
+	if (mode)
+		security_secmark_refcount_inc(mode);
 	return 0;
 }
 
@@ -96,15 +109,23 @@ static int secmark_tg_check(const struct xt_tgchk_param *par)
 		return -EINVAL;
 	}
 
-	if (mode && mode != info->mode) {
-		pr_info_ratelimited("mode already set to %hu cannot mix with rules for mode %hu\n",
-				    mode, info->mode);
+	if (mode) {
+		if (mode != info->mode) {
+			pr_info("mode already set to %hu cannot mix with "
+				"rules for mode %hu\n", mode, info->mode);
+			return -EINVAL;
+		}
+	} else if (security_secmark_mode(info->mode)) {
+		pr_info("mode already set and cannot mix with "
+			"rules for mode %hu\n", info->mode);
 		return -EINVAL;
 	}
 
 	switch (info->mode) {
 	case SECMARK_MODE_SEL:
 		break;
+	case SECMARK_MODE_SMACK:
+		break;
 	default:
 		pr_info_ratelimited("invalid mode: %hu\n", info->mode);
 		return -EINVAL;
@@ -123,8 +144,14 @@ static void secmark_tg_destroy(const struct xt_tgdtor_param *par)
 {
 	switch (mode) {
 	case SECMARK_MODE_SEL:
-		security_secmark_refcount_dec();
+		break;
+	case SECMARK_MODE_SMACK:
+		break;
+	default:
+		pr_info("invalid mode: %hu\n", mode);
+		return;
 	}
+	security_secmark_refcount_dec(mode);
 }
 
 static struct xt_target secmark_tg_reg __read_mostly = {
diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index 740db88d14f2..afc1e360b5bc 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -112,7 +112,7 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 			 from_kuid(&init_user_ns, audit_info->loginuid),
 			 audit_info->sessionid);
 
-	if (audit_info->secid.secmark != 0 &&
+	if (secid_valid(&audit_info->secid) &&
 	    security_secid_to_secctx(&audit_info->secid,
 				     &secctx,
 				     &secctx_len) == 0) {
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 2667b9e7fd16..43f81403212a 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -141,9 +141,10 @@ static struct hlist_head *unix_sockets_unbound(void *addr)
 #ifdef CONFIG_SECURITY_NETWORK
 static void unix_get_secdata(struct scm_cookie *scm, struct sk_buff *skb)
 {
-	UNIXCB(skb).secid = scm->secid.secmark;
 #ifdef CONFIG_SECURITY_STACKING
 	secid_to_skb(&scm->secid, skb);
+#else
+	UNIXCB(skb).secid = scm->secid.secmark;
 #endif
 }
 
@@ -158,7 +159,12 @@ static inline void unix_set_secdata(struct scm_cookie *scm, struct sk_buff *skb)
 
 static inline bool unix_secdata_eq(struct scm_cookie *scm, struct sk_buff *skb)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	return memcmp(&scm->secid, &(UNIXCB(skb).secid),
+		      sizeof(scm->secid)) == 0;
+#else
 	return (scm->secid.secmark == UNIXCB(skb).secid);
+#endif
 }
 #else
 static inline void unix_get_secdata(struct scm_cookie *scm, struct sk_buff *skb)
diff --git a/security/security.c b/security/security.c
index 571643cc7256..856c7506e84c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -346,10 +346,9 @@ void __init security_add_blobs(struct lsm_blob_sizes *needed)
 	lsm_set_size(&needed->lbs_key, &blob_sizes.lbs_key);
 #endif
 	lsm_set_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
-#ifdef CONFIG_NETWORK_SECMARK
+#ifdef CONFIG_SECURITY_NETWORK
 	/*
-	 * Store the most likely secmark with the socket
-	 * so that it doesn't have to be a managed object.
+	 * Store the secids with the socket for UDS.
 	 */
 	if (needed->lbs_sock && blob_sizes.lbs_sock == 0)
 		blob_sizes.lbs_sock = sizeof(struct secids);
@@ -2192,11 +2191,17 @@ int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
 #ifdef CONFIG_SECURITY_STACKING
 	struct security_hook_list *hp;
 	int rc = -ENOPROTOOPT;
+	int trc;
 
 	secid_init(secid);
 	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_dgram,
-				list)
-		rc = hp->hook.socket_getpeersec_dgram(sock, skb, secid);
+				list) {
+		trc = hp->hook.socket_getpeersec_dgram(sock, skb, secid);
+		if (trc == 0)
+			rc = 0;
+		else if (trc != -ENOPROTOOPT)
+			return trc;
+	}
 
 	return rc;
 #else
@@ -2286,18 +2291,32 @@ int security_secmark_relabel_packet(struct secids *secid)
 }
 EXPORT_SYMBOL(security_secmark_relabel_packet);
 
-void security_secmark_refcount_inc(void)
+void security_secmark_refcount_inc(u8 lsm)
 {
-	call_void_hook(secmark_refcount_inc);
+	call_void_hook(secmark_refcount_inc, lsm);
 }
 EXPORT_SYMBOL(security_secmark_refcount_inc);
 
-void security_secmark_refcount_dec(void)
+void security_secmark_refcount_dec(u8 lsm)
 {
-	call_void_hook(secmark_refcount_dec);
+	call_void_hook(secmark_refcount_dec, lsm);
 }
 EXPORT_SYMBOL(security_secmark_refcount_dec);
 
+static u8 security_secmark_mode_value;
+
+int security_secmark_mode(u8 lsm)
+{
+	if (security_secmark_mode_value == 0) {
+		security_secmark_mode_value = lsm;
+		return 0;
+	}
+	if (security_secmark_mode_value == lsm)
+		return 0;
+	return -EBUSY;
+}
+EXPORT_SYMBOL(security_secmark_mode);
+
 int security_tun_dev_alloc_security(void **security)
 {
 	return call_int_hook(tun_dev_alloc_security, 0, security);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9520341daa78..90122e311686 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -50,6 +50,7 @@
 #include <linux/mount.h>
 #include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_ipv6.h>
+#include <linux/netfilter/xt_SECMARK.h>
 #include <linux/tty.h>
 #include <net/icmp.h>
 #include <net/ip.h>		/* for local_port_range[] */
@@ -5296,13 +5297,21 @@ static int selinux_secmark_relabel_packet(struct secids *secid)
 			    PACKET__RELABELTO, NULL);
 }
 
-static void selinux_secmark_refcount_inc(void)
+static void selinux_secmark_refcount_inc(u8 lsm)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	if (lsm != SECMARK_MODE_SEL)
+		return;
+#endif
 	atomic_inc(&selinux_secmark_refcount);
 }
 
-static void selinux_secmark_refcount_dec(void)
+static void selinux_secmark_refcount_dec(u8 lsm)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	if (lsm != SECMARK_MODE_SEL)
+		return;
+#endif
 	atomic_dec(&selinux_secmark_refcount);
 }
 
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index f3a2be53dd6c..5725d39808f3 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -34,6 +34,7 @@
 #include <net/cipso_ipv4.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
+#include <linux/netfilter/xt_SECMARK.h>
 #include <linux/audit.h>
 #include <linux/magic.h>
 #include <linux/dcache.h>
@@ -51,6 +52,11 @@
 #define SMK_RECEIVING	1
 #define SMK_SENDING	2
 
+/*
+ * SECMARK reference count
+ */
+static atomic_t smack_secmark_refcount = ATOMIC_INIT(0);
+
 #ifdef SMACK_IPV6_PORT_LABELING
 DEFINE_MUTEX(smack_ipv6_lock);
 static LIST_HEAD(smk_ipv6_port_list);
@@ -3787,6 +3793,19 @@ static int smk_skb_to_addr_ipv6(struct sk_buff *skb, struct sockaddr_in6 *sip)
 }
 #endif /* CONFIG_IPV6 */
 
+#ifdef CONFIG_SECURITY_SMACK_NETFILTER
+static bool smack_owns_secmark(const struct sk_buff *skb)
+{
+	if (skb == NULL || skb->secmark == 0)
+		return false;
+#ifdef CONFIG_SECURITY_STACKING
+	return atomic_read(&smack_secmark_refcount) != 0;
+#else
+	return true;
+#endif
+}
+#endif /* CONFIG_SECURITY_SMACK_NETFILTER */
+
 /**
  * smack_socket_sock_rcv_skb - Smack packet delivery access check
  * @sk: socket
@@ -3817,7 +3836,7 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		 * If there is no secmark fall back to CIPSO.
 		 * The secmark is assumed to reflect policy better.
 		 */
-		if (skb && skb->secmark != 0) {
+		if (smack_owns_secmark(skb)) {
 			skp = smack_from_secid(skb->secmark);
 			goto access_check;
 		}
@@ -3862,7 +3881,7 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		if (proto != IPPROTO_UDP && proto != IPPROTO_TCP)
 			break;
 #ifdef SMACK_IPV6_SECMARK_LABELING
-		if (skb)
+		if (smack_owns_secmark(skb))
 			skp = smack_from_secid(skb->secmark);
 		else
 			skp = smack_ipv6host_label(&sadd);
@@ -3959,7 +3978,7 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 		break;
 	case PF_INET:
 #ifdef CONFIG_SECURITY_SMACK_NETFILTER
-		if (skb->secmark) {
+		if (smack_owns_secmark(skb)) {
 			s = skb->secmark;
 			if (s != 0)
 				break;
@@ -3980,7 +3999,8 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 		break;
 	case PF_INET6:
 #ifdef SMACK_IPV6_SECMARK_LABELING
-		s = skb->secmark;
+		if (smack_owns_secmark(skb))
+			s = skb->secmark;
 #endif
 		break;
 	}
@@ -4058,11 +4078,9 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 	 * If there is no secmark fall back to CIPSO.
 	 * The secmark is assumed to reflect policy better.
 	 */
-	if (skb) {
-		if (skb->secmark != 0) {
-			skp = smack_from_secid(skb->secmark);
-			goto access_check;
-		}
+	if (smack_owns_secmark(skb)) {
+		skp = smack_from_secid(skb->secmark);
+		goto access_check;
 	}
 #endif /* CONFIG_SECURITY_SMACK_NETFILTER */
 
@@ -4138,6 +4156,24 @@ static void smack_inet_csk_clone(struct sock *sk,
 		ssp->smk_packet = NULL;
 }
 
+static void smack_secmark_refcount_inc(u8 lsm)
+{
+#ifdef CONFIG_SECURITY_STACKING
+	if (lsm != SECMARK_MODE_SMACK)
+		return;
+#endif
+	atomic_inc(&smack_secmark_refcount);
+}
+
+static void smack_secmark_refcount_dec(u8 lsm)
+{
+#ifdef CONFIG_SECURITY_STACKING
+	if (lsm != SECMARK_MODE_SMACK)
+		return;
+#endif
+	atomic_dec(&smack_secmark_refcount);
+}
+
 /*
  * Key management security hooks
  *
@@ -4643,6 +4679,8 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sock_graft, smack_sock_graft),
 	LSM_HOOK_INIT(inet_conn_request, smack_inet_conn_request),
 	LSM_HOOK_INIT(inet_csk_clone, smack_inet_csk_clone),
+	LSM_HOOK_INIT(secmark_refcount_inc, smack_secmark_refcount_inc),
+	LSM_HOOK_INIT(secmark_refcount_dec, smack_secmark_refcount_dec),
 
  /* key management security hooks */
 #ifdef CONFIG_KEYS
diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
index 701a1cc1bdcc..596aba2e4d6b 100644
--- a/security/smack/smack_netfilter.c
+++ b/security/smack/smack_netfilter.c
@@ -16,6 +16,7 @@
 
 #include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_ipv6.h>
+#include <linux/netfilter/xt_SECMARK.h>
 #include <linux/netdevice.h>
 #include <net/inet_sock.h>
 #include <net/net_namespace.h>
@@ -31,6 +32,11 @@ static unsigned int smack_ipv6_output(void *priv,
 	struct socket_smack *ssp;
 	struct smack_known *skp;
 
+#ifdef CONFIG_SECURITY_STACKING
+	if (security_secmark_mode(SECMARK_MODE_SMACK))
+		return NF_ACCEPT;
+#endif
+
 	if (sk && smack_sock(sk)) {
 		ssp = smack_sock(sk);
 		skp = ssp->smk_out;
@@ -49,6 +55,11 @@ static unsigned int smack_ipv4_output(void *priv,
 	struct socket_smack *ssp;
 	struct smack_known *skp;
 
+#ifdef CONFIG_SECURITY_STACKING
+	if (security_secmark_mode(SECMARK_MODE_SMACK))
+		return NF_ACCEPT;
+#endif
+
 	if (sk && smack_sock(sk)) {
 		ssp = smack_sock(sk);
 		skp = ssp->smk_out;
-- 
2.14.3
