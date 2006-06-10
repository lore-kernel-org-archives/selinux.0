Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5CFoGxM007899
	for <selinux@tycho.nsa.gov>; Mon, 12 Jun 2006 11:50:16 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5CFoElb024181
	for <selinux@tycho.nsa.gov>; Mon, 12 Jun 2006 15:50:14 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6) with ESMTP id k5CFoNHL010582
	for <selinux@tycho.nsa.gov>; Mon, 12 Jun 2006 11:50:23 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6/Submit) id k5CFoNVx010581
	for selinux@tycho.nsa.gov; Mon, 12 Jun 2006 11:50:23 -0400
Message-ID: <36282A1733C57546BE392885C0618592012D626F@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: redhat-lspp@redhat.com, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        jmorris@redhat.com, tjaeger@cse.psu.edu, latten@austin.ibm.com
Cc: Chad Hanson <chanson@TrustedCS.com>,
        Darrel Goeddel
	 <DGoeddel@TrustedCS.com>
Subject: [RFC] [SELXFRM 2/4] Add support to SELinux LSM
Date: Sat, 10 Jun 2006 17:37:55 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds enforcement of controls added to the xfrm subsystem. Three
new hooks are added to help with this. Security for IP sockets at the sock
level is also added. A polmatch permission is also added to the association
access vector to enable arbitration of flow/state access to a policy rule.

Signed-off-by: Venkat Yekkirala <vyekkirala@TrustedCS.com>

---

In the design for this patch set, SAs operate at given single levels whereas
IPSec policies operate at ranges (including single levels). Thus there are
semantic differences between matching a policy Vs. sendto/recvfrom a
Security Association as described further in the below. Hence the need for a
new polmatch avperm.

 include/linux/security.h                     |   97 ++++++++++++--
 security/dummy.c                             |   23 +++
 security/selinux/hooks.c                     |   27 +++
 security/selinux/include/av_perm_to_string.h |    1 
 security/selinux/include/av_permissions.h    |    1 
 security/selinux/include/objsec.h            |    1 
 security/selinux/include/security.h          |    2 
 security/selinux/include/xfrm.h              |    9 +
 security/selinux/ss/mls.c                    |   20 --
 security/selinux/ss/mls.h                    |   20 ++
 security/selinux/ss/services.c               |   48 +++++++
 security/selinux/xfrm.c                      |  185
++++++++++++++++++++++-----
 12 files changed, 365 insertions(+), 69 deletions(-)

diff -purN -X linux-2.6.16.i686.lspp34/Documentation/dontdiff
linux-2.6.16.i686.lspp34/include/linux/security.h
linux-2.6.16.i686.ipsec/include/linux/security.h
--- linux-2.6.16.i686.lspp34/include/linux/security.h	2006-06-09
09:01:30.000000000 -0500
+++ linux-2.6.16.i686.ipsec/include/linux/security.h	2006-06-08
18:16:52.000000000 -0500
@@ -31,6 +31,7 @@
 #include <linux/msg.h>
 #include <linux/sched.h>
 #include <linux/key.h>
+#include <linux/xfrm.h>
 
 struct ctl_table;
 
@@ -794,6 +795,8 @@ struct swap_info_struct;
  *      which is used to copy security attributes between local stream
sockets.
  * @sk_free_security:
  *	Deallocate security structure.
+ * @sk_clone_security:
+ *	Clone/copy security structure.
  * @sk_getsid:
  *	Retrieve the LSM-specific sid for the sock to enable caching of
network
  *	authorizations.
@@ -823,9 +826,14 @@ struct swap_info_struct;
  *	Database by the XFRM system.
  *	@sec_ctx contains the security context information being provided by
  *	the user-level SA generation program (e.g., setkey or racoon).
- *	Allocate a security structure to the x->sel.security field.  The
+ *	@polsec contains the security context information associated with a
xfrm
+ *	policy rule from which to take the context.
+ *	@sid contains the sid from which to take the mls portion of the
context.
+ *	Allocate a security structure to the x->sel.security field; the
  *	security field is initialized to NULL when the xfrm_state is
- *	allocated.
+ *	allocated. Set the context to correspond to either the provided
sec_ctx
+ *	or the provided pol, with the mls portion taken from sid in the
latter
+ *	case.
  *	Return 0 if operation was successful (memory to allocate, legal
context).
  * @xfrm_state_free_security:
  *	@x contains the xfrm_state.
@@ -833,13 +841,26 @@ struct swap_info_struct;
  * @xfrm_policy_lookup:
  *	@xp contains the xfrm_policy for which the access control is being
  *	checked.
- *	@sk_sid contains the sock security label that is used to authorize
+ *	@fl_sid contains the flow security label that is used to authorize
  *	access to the policy xp.
  *	@dir contains the direction of the flow (input or output).
- *	Check permission when a sock selects a xfrm_policy for processing
+ *	Check permission when a flow selects a xfrm_policy for processing
  *	XFRMs on a packet.  The hook is called when selecting either a
  *	per-socket policy or a generic xfrm policy.
  *	Return 0 if permission is granted.
+ * @xfrm_state_pol_flow_match:
+ *	@x contains the state to match.
+ *	@xp contains the policy to check for a match.
+ *	@fl contains the flow to check for a match.
+ *	Return 1 if there is a match.
+ * @xfrm_flow_state_match:
+ *	@fl contains the flow key to match.
+ *	@xfrm points to the xfrm_state to match.
+ *	Return 1 if there is a match.
+ * @xfrm_decode_session:
+ *	@skb points to skb to decode.
+ *	@fl points to the flow key to set.
+ *	Return 0 if successful decoding.
  *
  * Security hooks affecting all Key Management operations
  *
@@ -1291,6 +1312,7 @@ struct security_operations {
 	int (*socket_getpeersec_dgram) (struct sk_buff *skb, char **secdata,
u32 *seclen);
 	int (*sk_alloc_security) (struct sock *sk, int family, gfp_t
priority);
 	void (*sk_free_security) (struct sock *sk);
+	void (*sk_clone_security) (struct sock *sk, struct sock *newsk);
 	unsigned int (*sk_getsid) (struct sock *sk, struct flowi *fl, u8
dir);
 #endif	/* CONFIG_SECURITY_NETWORK */
 
@@ -1298,9 +1320,15 @@ struct security_operations {
 	int (*xfrm_policy_alloc_security) (struct xfrm_policy *xp, struct
xfrm_user_sec_ctx *sec_ctx);
 	int (*xfrm_policy_clone_security) (struct xfrm_policy *old, struct
xfrm_policy *new);
 	void (*xfrm_policy_free_security) (struct xfrm_policy *xp);
-	int (*xfrm_state_alloc_security) (struct xfrm_state *x, struct
xfrm_user_sec_ctx *sec_ctx);
+	int (*xfrm_state_alloc_security) (struct xfrm_state *x,
+		struct xfrm_user_sec_ctx *sec_ctx, struct xfrm_sec_ctx
*polsec,
+		u32 sid);
 	void (*xfrm_state_free_security) (struct xfrm_state *x);
-	int (*xfrm_policy_lookup)(struct xfrm_policy *xp, u32 sk_sid, u8
dir);
+	int (*xfrm_policy_lookup)(struct xfrm_policy *xp, u32 fl_sid, u8
dir);
+	int (*xfrm_state_pol_flow_match)(struct xfrm_state *x, struct
xfrm_policy *xp,
+		struct flowi *fl);
+	int (*xfrm_flow_state_match)(struct flowi *fl, struct xfrm_state
*xfrm);
+	int (*xfrm_decode_session)(struct sk_buff *skb, struct flowi *fl);
 #endif	/* CONFIG_SECURITY_NETWORK_XFRM */
 
 	/* key management security hooks */
@@ -2785,6 +2813,11 @@ static inline void security_sk_free(stru
 	return security_ops->sk_free_security(sk);
 }
 
+static inline void security_sk_clone(struct sock *sk, struct sock *newsk)
+{
+	return security_ops->sk_clone_security(sk, newsk);
+}
+
 static inline unsigned int security_sk_sid(struct sock *sk, struct flowi
*fl, u8 dir)
 {
 	return security_ops->sk_getsid(sk, fl, dir);
@@ -2912,6 +2945,10 @@ static inline void security_sk_free(stru
 {
 }
 
+static inline void security_sk_clone(struct sock *sk, struct sock *newsk)
+{
+}
+
 static inline unsigned int security_sk_sid(struct sock *sk, struct flowi
*fl, u8 dir)
 {
 	return 0;
@@ -2934,9 +2971,10 @@ static inline void security_xfrm_policy_
 	security_ops->xfrm_policy_free_security(xp);
 }
 
-static inline int security_xfrm_state_alloc(struct xfrm_state *x, struct
xfrm_user_sec_ctx *sec_ctx)
+static inline int security_xfrm_state_alloc(struct xfrm_state *x,
+	struct xfrm_user_sec_ctx *sec_ctx, struct xfrm_sec_ctx *polsec, u32
sid)
 {
-	return security_ops->xfrm_state_alloc_security(x, sec_ctx);
+	return security_ops->xfrm_state_alloc_security(x, sec_ctx, polsec,
sid);
 }
 
 static inline void security_xfrm_state_free(struct xfrm_state *x)
@@ -2944,9 +2982,25 @@ static inline void security_xfrm_state_f
 	security_ops->xfrm_state_free_security(x);
 }
 
-static inline int security_xfrm_policy_lookup(struct xfrm_policy *xp, u32
sk_sid, u8 dir)
+static inline int security_xfrm_policy_lookup(struct xfrm_policy *xp, u32
fl_sid, u8 dir)
 {
-	return security_ops->xfrm_policy_lookup(xp, sk_sid, dir);
+	return security_ops->xfrm_policy_lookup(xp, fl_sid, dir);
+}
+
+static inline int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
+			struct xfrm_policy *xp, struct flowi *fl)
+{
+	return security_ops->xfrm_state_pol_flow_match(x, xp, fl);
+}
+
+static inline int security_xfrm_flow_state_match(struct flowi *fl, struct
xfrm_state *xfrm)
+{
+	return security_ops->xfrm_flow_state_match(fl, xfrm);
+}
+
+static inline int security_xfrm_decode_session(struct sk_buff *skb, struct
flowi *fl)
+{
+	return security_ops->xfrm_decode_session(skb, fl);
 }
 #else	/* CONFIG_SECURITY_NETWORK_XFRM */
 static inline int security_xfrm_policy_alloc(struct xfrm_policy *xp, struct
xfrm_user_sec_ctx *sec_ctx)
@@ -2963,7 +3017,8 @@ static inline void security_xfrm_policy_
 {
 }
 
-static inline int security_xfrm_state_alloc(struct xfrm_state *x, struct
xfrm_user_sec_ctx *sec_ctx)
+static inline int security_xfrm_state_alloc(struct xfrm_state *x,
+	struct xfrm_user_sec_ctx *sec_ctx, struct xfrm_sec_ctx *polsec, u32
sid)
 {
 	return 0;
 }
@@ -2972,10 +3027,28 @@ static inline void security_xfrm_state_f
 {
 }
 
-static inline int security_xfrm_policy_lookup(struct xfrm_policy *xp, u32
sk_sid, u8 dir)
+static inline int security_xfrm_policy_lookup(struct xfrm_policy *xp, u32
fl_sid, u8 dir)
 {
 	return 0;
 }
+
+static inline int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
+			struct xfrm_policy *xp, struct flowi *fl)
+{
+	return 1;
+}
+
+static inline int security_xfrm_flow_state_match(struct flowi *fl,
+                                struct xfrm_state *xfrm)
+{
+	return 1;
+}
+
+static inline int security_xfrm_decode_session(struct sk_buff *skb, struct
flowi *fl)
+{
+	return 0;
+}
+
 #endif	/* CONFIG_SECURITY_NETWORK_XFRM */
 
 #ifdef CONFIG_KEYS
diff -purN -X linux-2.6.16.i686.lspp34/Documentation/dontdiff
linux-2.6.16.i686.lspp34/security/dummy.c
linux-2.6.16.i686.ipsec/security/dummy.c
--- linux-2.6.16.i686.lspp34/security/dummy.c	2006-06-09
09:01:33.000000000 -0500
+++ linux-2.6.16.i686.ipsec/security/dummy.c	2006-06-08
18:16:52.000000000 -0500
@@ -810,7 +810,8 @@ static void dummy_xfrm_policy_free_secur
 {
 }
 
-static int dummy_xfrm_state_alloc_security(struct xfrm_state *x, struct
xfrm_user_sec_ctx *sec_ctx)
+static int dummy_xfrm_state_alloc_security(struct xfrm_state *x,
+	struct xfrm_user_sec_ctx *sec_ctx, struct xfrm_sec_ctx *pol, u32
sid)
 {
 	return 0;
 }
@@ -823,6 +824,23 @@ static int dummy_xfrm_policy_lookup(stru
 {
 	return 0;
 }
+
+static int dummy_xfrm_state_pol_flow_match(struct xfrm_state *x,
+				struct xfrm_policy *xp, struct flowi *fl)
+{
+	return 0;
+}
+
+static int dummy_xfrm_flow_state_match(struct flowi *fl, struct xfrm_state
*xfrm)
+{
+	return 0;
+}
+
+static int dummy_xfrm_decode_session(struct sk_buff *skb, struct flowi *fl)
+{
+	return 0;
+}
+
 #endif /* CONFIG_SECURITY_NETWORK_XFRM */
 static int dummy_register_security (const char *name, struct
security_operations *ops)
 {
@@ -1027,6 +1045,9 @@ void security_fixup_ops (struct security
 	set_to_dummy_if_null(ops, xfrm_state_alloc_security);
 	set_to_dummy_if_null(ops, xfrm_state_free_security);
 	set_to_dummy_if_null(ops, xfrm_policy_lookup);
+	set_to_dummy_if_null(ops, xfrm_state_pol_flow_match);
+	set_to_dummy_if_null(ops, xfrm_flow_state_match);
+	set_to_dummy_if_null(ops, xfrm_decode_session);
 #endif	/* CONFIG_SECURITY_NETWORK_XFRM */
 #ifdef CONFIG_KEYS
 	set_to_dummy_if_null(ops, key_alloc);
diff -purN -X linux-2.6.16.i686.lspp34/Documentation/dontdiff
linux-2.6.16.i686.lspp34/security/selinux/hooks.c
linux-2.6.16.i686.ipsec/security/selinux/hooks.c
--- linux-2.6.16.i686.lspp34/security/selinux/hooks.c	2006-06-09
09:01:39.000000000 -0500
+++ linux-2.6.16.i686.ipsec/security/selinux/hooks.c	2006-06-08
18:16:52.000000000 -0500
@@ -267,15 +267,13 @@ static int sk_alloc_security(struct sock
 {
 	struct sk_security_struct *ssec;
 
-	if (family != PF_UNIX)
-		return 0;
-
 	ssec = kzalloc(sizeof(*ssec), priority);
 	if (!ssec)
 		return -ENOMEM;
 
 	ssec->sk = sk;
 	ssec->peer_sid = SECINITSID_UNLABELED;
+	ssec->sid = SECINITSID_UNLABELED;
 	sk->sk_security = ssec;
 
 	return 0;
@@ -285,9 +283,6 @@ static void sk_free_security(struct sock
 {
 	struct sk_security_struct *ssec = sk->sk_security;
 
-	if (sk->sk_family != PF_UNIX)
-		return;
-
 	sk->sk_security = NULL;
 	kfree(ssec);
 }
@@ -2927,6 +2922,7 @@ static void selinux_socket_post_create(s
 {
 	struct inode_security_struct *isec;
 	struct task_security_struct *tsec;
+	struct sk_security_struct *sksec;
 
 	isec = SOCK_INODE(sock)->i_security;
 
@@ -2935,6 +2931,10 @@ static void selinux_socket_post_create(s
 	isec->sid = kern ? SECINITSID_KERNEL : tsec->sid;
 	isec->initialized = 1;
 
+	if (sock->sk) {
+		sksec = sock->sk->sk_security;
+		sksec->sid = isec->sid;
+	}
 	return;
 }
 
@@ -3394,6 +3394,15 @@ static void selinux_sk_free_security(str
 	sk_free_security(sk);
 }
 
+static void selinux_sk_clone_security(struct sock *sk, struct sock *newsk)
+{
+	struct sk_security_struct *ssec = sk->sk_security;
+	struct sk_security_struct *newssec = newsk->sk_security;
+
+	newssec->sid = ssec->sid;
+	newssec->peer_sid = ssec->peer_sid;
+}
+
 static unsigned int selinux_sk_getsid_security(struct sock *sk, struct
flowi *fl, u8 dir)
 {
 	struct inode_security_struct *isec;
@@ -3407,6 +3416,8 @@ static unsigned int selinux_sk_getsid_se
 
 	if (isec)
 		sock_sid = isec->sid;
+	else
+		sock_sid = ((struct sk_security_struct
*)(sk->sk_security))->sid;
 
 	read_unlock_bh(&sk->sk_callback_lock);
 	return sock_sid;
@@ -4365,6 +4376,7 @@ static struct security_operations selinu
 	.socket_getpeersec_dgram =	selinux_socket_getpeersec_dgram,
 	.sk_alloc_security =		selinux_sk_alloc_security,
 	.sk_free_security =		selinux_sk_free_security,
+	.sk_clone_security =		selinux_sk_clone_security,
 	.sk_getsid = 			selinux_sk_getsid_security,
 
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
@@ -4374,6 +4386,9 @@ static struct security_operations selinu
 	.xfrm_state_alloc_security =	selinux_xfrm_state_alloc,
 	.xfrm_state_free_security =	selinux_xfrm_state_free,
 	.xfrm_policy_lookup = 		selinux_xfrm_policy_lookup,
+	.xfrm_state_pol_flow_match =	selinux_xfrm_state_pol_flow_match,
+	.xfrm_flow_state_match =	selinux_xfrm_flow_state_match,
+	.xfrm_decode_session =		selinux_xfrm_decode_session,
 #endif
 };
 
diff -purN -X linux-2.6.16.i686.lspp34/Documentation/dontdiff
linux-2.6.16.i686.lspp34/security/selinux/include/av_permissions.h
linux-2.6.16.i686.ipsec/security/selinux/include/av_permissions.h
--- linux-2.6.16.i686.lspp34/security/selinux/include/av_permissions.h
2006-03-19 23:53:29.000000000 -0600
+++ linux-2.6.16.i686.ipsec/security/selinux/include/av_permissions.h
2006-06-08 18:16:52.000000000 -0500
@@ -909,6 +909,7 @@
 #define ASSOCIATION__SENDTO                       0x00000001UL
 #define ASSOCIATION__RECVFROM                     0x00000002UL
 #define ASSOCIATION__SETCONTEXT                   0x00000004UL
+#define ASSOCIATION__POLMATCH                     0x00000008UL
 
 #define NETLINK_KOBJECT_UEVENT_SOCKET__IOCTL      0x00000001UL
 #define NETLINK_KOBJECT_UEVENT_SOCKET__READ       0x00000002UL
diff -purN -X linux-2.6.16.i686.lspp34/Documentation/dontdiff
linux-2.6.16.i686.lspp34/security/selinux/include/av_perm_to_string.h
linux-2.6.16.i686.ipsec/security/selinux/include/av_perm_to_string.h
--- linux-2.6.16.i686.lspp34/security/selinux/include/av_perm_to_string.h
2006-03-19 23:53:29.000000000 -0600
+++ linux-2.6.16.i686.ipsec/security/selinux/include/av_perm_to_string.h
2006-06-08 18:16:52.000000000 -0500
@@ -239,3 +239,4 @@
    S_(SECCLASS_ASSOCIATION, ASSOCIATION__SENDTO, "sendto")
    S_(SECCLASS_ASSOCIATION, ASSOCIATION__RECVFROM, "recvfrom")
    S_(SECCLASS_ASSOCIATION, ASSOCIATION__SETCONTEXT, "setcontext")
+   S_(SECCLASS_ASSOCIATION, ASSOCIATION__POLMATCH, "polmatch")
diff -purN -X linux-2.6.16.i686.lspp34/Documentation/dontdiff
linux-2.6.16.i686.lspp34/security/selinux/include/objsec.h
linux-2.6.16.i686.ipsec/security/selinux/include/objsec.h
--- linux-2.6.16.i686.lspp34/security/selinux/include/objsec.h	2006-03-19
23:53:29.000000000 -0600
+++ linux-2.6.16.i686.ipsec/security/selinux/include/objsec.h	2006-06-08
18:16:52.000000000 -0500
@@ -96,6 +96,7 @@ struct netif_security_struct {
 
 struct sk_security_struct {
 	struct sock *sk;		/* back pointer to sk object */
+	u32 sid;			/* SID of this object */
 	u32 peer_sid;			/* SID of peer */
 };
 
diff -purN -X linux-2.6.16.i686.lspp34/Documentation/dontdiff
linux-2.6.16.i686.lspp34/security/selinux/include/security.h
linux-2.6.16.i686.ipsec/security/selinux/include/security.h
--- linux-2.6.16.i686.lspp34/security/selinux/include/security.h
2006-06-09 09:01:33.000000000 -0500
+++ linux-2.6.16.i686.ipsec/security/selinux/include/security.h	2006-06-08
18:16:52.000000000 -0500
@@ -78,6 +78,8 @@ int security_node_sid(u16 domain, void *
 int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
                                  u16 tclass);
 
+int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid);
+
 #define SECURITY_FS_USE_XATTR		1 /* use xattr */
 #define SECURITY_FS_USE_TRANS		2 /* use transition SIDs, e.g.
devpts/tmpfs */
 #define SECURITY_FS_USE_TASK		3 /* use task SIDs, e.g.
pipefs/sockfs */
diff -purN -X linux-2.6.16.i686.lspp34/Documentation/dontdiff
linux-2.6.16.i686.lspp34/security/selinux/include/xfrm.h
linux-2.6.16.i686.ipsec/security/selinux/include/xfrm.h
--- linux-2.6.16.i686.lspp34/security/selinux/include/xfrm.h	2006-06-09
09:01:33.000000000 -0500
+++ linux-2.6.16.i686.ipsec/security/selinux/include/xfrm.h	2006-06-08
18:16:52.000000000 -0500
@@ -9,9 +9,14 @@
 int selinux_xfrm_policy_alloc(struct xfrm_policy *xp, struct
xfrm_user_sec_ctx *sec_ctx);
 int selinux_xfrm_policy_clone(struct xfrm_policy *old, struct xfrm_policy
*new);
 void selinux_xfrm_policy_free(struct xfrm_policy *xp);
-int selinux_xfrm_state_alloc(struct xfrm_state *x, struct xfrm_user_sec_ctx
*sec_ctx);
+int selinux_xfrm_state_alloc(struct xfrm_state *x, struct xfrm_user_sec_ctx
*sec_ctx,
+				struct xfrm_sec_ctx *pol, u32 sid);
 void selinux_xfrm_state_free(struct xfrm_state *x);
-int selinux_xfrm_policy_lookup(struct xfrm_policy *xp, u32 sk_sid, u8 dir);
+int selinux_xfrm_policy_lookup(struct xfrm_policy *xp, u32 fl_sid, u8 dir);
+int selinux_xfrm_state_pol_flow_match(struct xfrm_state *x, struct
xfrm_policy *xp,
+			struct flowi *fl);
+int selinux_xfrm_flow_state_match(struct flowi *fl, struct xfrm_state
*xfrm);
+int selinux_xfrm_decode_session(struct sk_buff *skb, struct flowi *fl);
 
 /*
  * Extract the security blob from the sock (it's actually on the socket)
diff -purN -X linux-2.6.16.i686.lspp34/Documentation/dontdiff
linux-2.6.16.i686.lspp34/security/selinux/ss/mls.c
linux-2.6.16.i686.ipsec/security/selinux/ss/mls.c
--- linux-2.6.16.i686.lspp34/security/selinux/ss/mls.c	2006-06-09
09:01:33.000000000 -0500
+++ linux-2.6.16.i686.ipsec/security/selinux/ss/mls.c	2006-06-08
18:16:52.000000000 -0500
@@ -212,26 +212,6 @@ int mls_context_isvalid(struct policydb 
 }
 
 /*
- * Copies the MLS range from `src' into `dst'.
- */
-static inline int mls_copy_context(struct context *dst,
-				   struct context *src)
-{
-	int l, rc = 0;
-
-	/* Copy the MLS range from the source context */
-	for (l = 0; l < 2; l++) {
-		dst->range.level[l].sens = src->range.level[l].sens;
-		rc = ebitmap_cpy(&dst->range.level[l].cat,
-				 &src->range.level[l].cat);
-		if (rc)
-			break;
-	}
-
-	return rc;
-}
-
-/*
  * Set the MLS fields in the security context structure
  * `context' based on the string representation in
  * the string `*scontext'.  Update `*scontext' to
diff -purN -X linux-2.6.16.i686.lspp34/Documentation/dontdiff
linux-2.6.16.i686.lspp34/security/selinux/ss/mls.h
linux-2.6.16.i686.ipsec/security/selinux/ss/mls.h
--- linux-2.6.16.i686.lspp34/security/selinux/ss/mls.h	2006-06-09
09:01:33.000000000 -0500
+++ linux-2.6.16.i686.ipsec/security/selinux/ss/mls.h	2006-06-08
18:16:52.000000000 -0500
@@ -17,6 +17,26 @@
 #include "context.h"
 #include "policydb.h"
 
+/*
+ * Copies the MLS range from `src' into `dst'.
+ */
+static inline int mls_copy_context(struct context *dst,
+				   struct context *src)
+{
+	int l, rc = 0;
+
+	/* Copy the MLS range from the source context */
+	for (l = 0; l < 2; l++) {
+		dst->range.level[l].sens = src->range.level[l].sens;
+		rc = ebitmap_cpy(&dst->range.level[l].cat,
+				 &src->range.level[l].cat);
+		if (rc)
+			break;
+	}
+
+	return rc;
+}
+
 int mls_compute_context_len(struct context *context);
 void mls_sid_to_context(struct context *context, char **scontext);
 int mls_context_isvalid(struct policydb *p, struct context *c);
diff -purN -X linux-2.6.16.i686.lspp34/Documentation/dontdiff
linux-2.6.16.i686.lspp34/security/selinux/ss/services.c
linux-2.6.16.i686.ipsec/security/selinux/ss/services.c
--- linux-2.6.16.i686.lspp34/security/selinux/ss/services.c	2006-06-09
09:01:39.000000000 -0500
+++ linux-2.6.16.i686.ipsec/security/selinux/ss/services.c	2006-06-08
18:16:52.000000000 -0500
@@ -1817,6 +1817,54 @@ out:
 	return rc;
 }
 
+/*
+ * security_sid_mls_copy() - computes a new sid based on the given
+ * sid and the mls portion of mls_sid.
+ */
+int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid)
+{
+	struct context *context1 = NULL;
+	struct context *context2 = NULL;
+	struct context newcon;
+	int rc = 0;
+
+	if (!ss_initialized) {
+		*new_sid = sid;
+		goto out;
+	}
+
+	POLICY_RDLOCK;
+	context1 = sidtab_search(&sidtab, sid);
+	if (!context1) {
+		printk(KERN_ERR "security_sid_mls_copy:  unrecognized SID "
+		       "%d\n", sid);
+		rc = -EINVAL;
+		goto out_unlock;
+	}
+
+	context2 = sidtab_search(&sidtab, mls_sid);
+	if (!context2) {
+		printk(KERN_ERR "security_sid_mls_copy:  unrecognized SID "
+		       "%d\n", mls_sid);
+		rc = -EINVAL;
+		goto out_unlock;
+	}
+
+	newcon.user = context1->user;
+	newcon.role = context1->role;
+	newcon.type = context1->type;
+	rc = mls_copy_context(&newcon, context2);
+	if (rc)
+		goto out_unlock;
+
+	rc = sidtab_context_to_sid(&sidtab, &newcon, new_sid);
+
+out_unlock:
+	POLICY_RDUNLOCK;
+out:
+	return rc;
+}
+
 struct selinux_audit_rule {
 	u32 au_seqno;
 	struct context au_ctxt;
diff -purN -X linux-2.6.16.i686.lspp34/Documentation/dontdiff
linux-2.6.16.i686.lspp34/security/selinux/xfrm.c
linux-2.6.16.i686.ipsec/security/selinux/xfrm.c
--- linux-2.6.16.i686.lspp34/security/selinux/xfrm.c	2006-06-09
09:01:33.000000000 -0500
+++ linux-2.6.16.i686.ipsec/security/selinux/xfrm.c	2006-06-08
18:16:52.000000000 -0500
@@ -68,10 +68,10 @@ static inline int selinux_authorizable_x
 }
 
 /*
- * LSM hook implementation that authorizes that a socket can be used
- * with the corresponding xfrm_sec_ctx and direction.
+ * LSM hook implementation that authorizes that a flow can use
+ * a xfrm policy rule.
  */
-int selinux_xfrm_policy_lookup(struct xfrm_policy *xp, u32 sk_sid, u8 dir)
+int selinux_xfrm_policy_lookup(struct xfrm_policy *xp, u32 fl_sid, u8 dir)
 {
 	int rc = 0;
 	u32 sel_sid = SECINITSID_UNLABELED;
@@ -85,24 +85,131 @@ int selinux_xfrm_policy_lookup(struct xf
 		sel_sid = ctx->ctx_sid;
 	}
 
-	rc = avc_has_perm(sk_sid, sel_sid, SECCLASS_ASSOCIATION,
-			  ((dir == FLOW_DIR_IN) ? ASSOCIATION__RECVFROM :
-			   ((dir == FLOW_DIR_OUT) ?  ASSOCIATION__SENDTO :
-			    (ASSOCIATION__SENDTO | ASSOCIATION__RECVFROM))),
+	rc = avc_has_perm(fl_sid, sel_sid, SECCLASS_ASSOCIATION,
+			  ASSOCIATION__POLMATCH,
 			  NULL);
 
 	return rc;
 }
 
 /*
+ * LSM hook implementation that authorizes that a state matches
+ * the given policy, flow combo.
+ */
+
+int selinux_xfrm_state_pol_flow_match(struct xfrm_state *x, struct
xfrm_policy *xp,
+			struct flowi *fl)
+{
+	u32 state_sid;
+	u32 pol_sid;
+	int err;
+
+	if (x->security)
+		state_sid = x->security->ctx_sid;
+	else
+		state_sid = SECINITSID_UNLABELED;
+
+	if (xp->security)
+		pol_sid = xp->security->ctx_sid;
+	else
+		pol_sid = SECINITSID_UNLABELED;
+
+	err = avc_has_perm(state_sid, pol_sid, SECCLASS_ASSOCIATION,
+			  ASSOCIATION__POLMATCH,
+			  NULL);
+
+	if (err)
+		return 0;
+
+	return selinux_xfrm_flow_state_match(fl, x);
+}
+
+/*
+ * LSM hook implementation that authorizes that a particular outgoing flow
+ * can use a given security association.
+ */
+
+int selinux_xfrm_flow_state_match(struct flowi *fl, struct xfrm_state
*xfrm)
+{
+	int rc = 0;
+	u32 sel_sid = SECINITSID_UNLABELED;
+	struct xfrm_sec_ctx *ctx;
+
+	printk(KERN_DEBUG "%s: authorize\n", __FUNCTION__);
+
+	/* Context sid is either set to label or ANY_ASSOC */
+	if ((ctx = xfrm->security)) {
+		if (!selinux_authorizable_ctx(ctx))
+			return 0;
+
+		sel_sid = ctx->ctx_sid;
+		printk(KERN_DEBUG "%s: output for context %.50s; sid: %d;
sock: %d\n",
+					__FUNCTION__,
+					ctx->ctx_str,
+					sel_sid,
+					fl->sid);
+	}
+
+	rc = avc_has_perm(fl->sid, sel_sid, SECCLASS_ASSOCIATION,
+			  ASSOCIATION__SENDTO,
+			  NULL)? 0:1;
+
+	return rc;
+}
+
+/*
+ * LSM hook implementation that determines the sid for the session.
+ */
+
+int selinux_xfrm_decode_session(struct sk_buff *skb, struct flowi *fl)
+{
+	struct sec_path *sp;
+
+	fl->sid = SECSID_NULL;
+
+	if (skb == NULL)
+		return 0;
+
+	sp = skb->sp;
+	if (sp) {
+		int i, sid_set = 0;
+
+		for (i = sp->len-1; i >= 0; i--) {
+			struct xfrm_state *x = sp->xvec[i];
+			if (selinux_authorizable_xfrm(x)) {
+				struct xfrm_sec_ctx *ctx = x->security;
+
+				if (!sid_set) {
+					fl->sid = ctx->ctx_sid;
+					sid_set = 1;
+				}
+				else if (fl->sid != ctx->ctx_sid)
+					return -EINVAL;
+			}
+		}
+	}
+
+	return 0;
+}
+
+/*
  * Security blob allocation for xfrm_policy and xfrm_state
  * CTX does not have a meaningful value on input
  */
-static int selinux_xfrm_sec_ctx_alloc(struct xfrm_sec_ctx **ctxp, struct
xfrm_user_sec_ctx *uctx)
+static int selinux_xfrm_sec_ctx_alloc(struct xfrm_sec_ctx **ctxp,
+	struct xfrm_user_sec_ctx *uctx, struct xfrm_sec_ctx *pol, u32 sid)
 {
 	int rc = 0;
 	struct task_security_struct *tsec = current->security;
-	struct xfrm_sec_ctx *ctx;
+	struct xfrm_sec_ctx *ctx = NULL;
+	char *ctx_str = NULL;
+	u32 str_len;
+	u32 ctx_sid;
+
+	BUG_ON(uctx && pol);
+
+	if (pol)
+		goto from_policy;
 
 	BUG_ON(!uctx);
 	BUG_ON(uctx->ctx_doi != XFRM_SC_ALG_SELINUX);
@@ -145,9 +252,39 @@ static int selinux_xfrm_sec_ctx_alloc(st
 
 	return rc;
 
+from_policy:
+	rc = security_sid_mls_copy(pol->ctx_sid, sid, &ctx_sid);
+	if (rc)
+		goto out;
+
+	rc = security_sid_to_context(ctx_sid, &ctx_str, &str_len);
+	if (rc)
+		goto out;
+
+	*ctxp = ctx = kmalloc(sizeof(*ctx) +
+			      str_len,
+			      GFP_KERNEL);
+
+	if (!ctx) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+
+	ctx->ctx_doi = XFRM_SC_DOI_LSM;
+	ctx->ctx_alg = XFRM_SC_ALG_SELINUX;
+	ctx->ctx_sid = ctx_sid;
+	ctx->ctx_len = str_len;
+	memcpy(ctx->ctx_str,
+	       ctx_str,
+	       str_len);
+
+	return rc;
+
 out:
 	*ctxp = NULL;
 	kfree(ctx);
+	kfree(ctx_str);
 	return rc;
 }
 
@@ -161,7 +298,7 @@ int selinux_xfrm_policy_alloc(struct xfr
 
 	BUG_ON(!xp);
 
-	err = selinux_xfrm_sec_ctx_alloc(&xp->security, uctx);
+	err = selinux_xfrm_sec_ctx_alloc(&xp->security, uctx, NULL, 0);
 	return err;
 }
 
@@ -204,13 +341,14 @@ void selinux_xfrm_policy_free(struct xfr
  * LSM hook implementation that allocs and transfers sec_ctx spec to
  * xfrm_state.
  */
-int selinux_xfrm_state_alloc(struct xfrm_state *x, struct xfrm_user_sec_ctx
*uctx)
+int selinux_xfrm_state_alloc(struct xfrm_state *x, struct xfrm_user_sec_ctx
*uctx,
+		struct xfrm_sec_ctx *pol, u32 sid)
 {
 	int err;
 
 	BUG_ON(!x);
 
-	err = selinux_xfrm_sec_ctx_alloc(&x->security, uctx);
+	err = selinux_xfrm_sec_ctx_alloc(&x->security, uctx, pol, sid);
 	return err;
 }
 
@@ -303,34 +441,25 @@ int selinux_xfrm_sock_rcv_skb(u32 isec_s
 {
 	int i, rc = 0;
 	struct sec_path *sp;
+	u32 sel_sid = SECINITSID_UNLABELED;
 
 	sp = skb->sp;
 
 	if (sp) {
-		/*
-		 * __xfrm_policy_check does not approve unless
xfrm_policy_ok
-		 * says that spi's match for policy and the socket.
-		 *
-		 *  Only need to verify the existence of an authorizable sp.
-		 */
 		for (i = 0; i < sp->len; i++) {
 			struct xfrm_state *x = sp->xvec[i];
 
-			if (x && selinux_authorizable_xfrm(x))
-				goto accept;
+			if (x && selinux_authorizable_xfrm(x)) {
+				struct xfrm_sec_ctx *ctx = x->security;
+				sel_sid = ctx->ctx_sid;
+				break;
+			}
 		}
 	}
 
-	/* check SELinux sock for unlabelled access */
-	rc = avc_has_perm(isec_sid, SECINITSID_UNLABELED,
SECCLASS_ASSOCIATION,
+	rc = avc_has_perm(isec_sid, sel_sid, SECCLASS_ASSOCIATION,
 			  ASSOCIATION__RECVFROM, NULL);
-	if (rc)
-		goto drop;
 
-accept:
-	return 0;
-
-drop:
 	return rc;
 }
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
