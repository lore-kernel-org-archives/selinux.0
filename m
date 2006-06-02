Message-ID: <4480500E.10906@trustedcs.com>
Date: Fri, 02 Jun 2006 09:49:50 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: James Morris <jmorris@redhat.com>,
        "'SELinux List'" <SELinux@tycho.nsa.gov>, redhat-lspp@redhat.com
Subject: Re: [PATCH] fix masking of capabilities over netlink in permissive
 mode
References: <447DD3D7.4050200@trustedcs.com>	 <1149098096.524.241.camel@moss-spartans.epoch.ncsc.mil>	 <447EF602.5080003@trustedcs.com> <1149172261.524.370.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1149172261.524.370.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2006-06-01 at 09:13 -0500, Darrel Goeddel wrote:
> 
>>Stephen Smalley wrote:
>>
>>>On Wed, 2006-05-31 at 12:35 -0500, Darrel Goeddel wrote:
>>>
>>>
>>>>I think I ran across the problem described in this thread:
>>>>
>>>>http://www.redhat.com/archives/linux-audit/2006-May/msg00059.html
>>>>
>>>>The process' effective capabilities are always being masked with the
>>>>allowed vector of the avc decision (for self against the capability
>>>>security class) in netlink's copy of the process capabilities (eff_cap).
>>>>The allowed vector takes on a slightly different role when SELinux
>>>>is not in enforcing mode - it starts to track used-but-not-normally-
>>>>permitted actions in the allowed vector.  That is what is causing
>>>>the first attempt to fail (the allowed vector has not been "inflated")
>>>>and the following attempts to succeed (the vector has been inflated in
>>>>response to its previous use).  Does my reasoning (and patch) seem to
>>>>be on track?
>>>
>>>
>>>Alternative:  Since the sending task SID is now saved in the netlink
>>>control buffer, we could move the netlink checking entirely to the
>>>receive side, and perform a normal avc_has_perm() check, via
>>>task_has_capability, with corresponding auditing of netlink denials.
>>>Similarly for audit_netlink_ok.  We couldn't do that in the past because
>>>the sender SID wasn't available to us on the receive side.

Here's an attempt using the above approach.  What does everyone think?  The
only issue I can see is that there may be a possibility of getting some
incorrect audit information if many queued netlink messages are processed
at the same time.  The AVC message will include information about "current",
which may not be the sending process.  Stephen suggested that the AVC message
could be modified to include the pid from the netlink message instead of
information about current.  That would lead to an AVC message stating pid=XXX,
while the syscall message would state pid=YYY.  Anyone see a way to get correct
information, or at least suppress possibly incorrect information.  I really
like the idea of getting the AVC message because tracking down cases where
SELinux was denying CAP_AUDIT_XXX was a huge pain when userspace was starting to
become audit-aware...



This patch encapsulates the usage of eff_cap (in netlink_skb_params) within
the lsm framework by extending security_netlink_recv to include a required
capability parameter and converting all direct usage of eff_caps outside
of the lsm modules to use the interface.  It also updates the SELinux
implementation of the security_netlink_send and security_netlink_recv
hooks to take advantage of the sid in the netlink_skb_params struct.

diff --git a/include/linux/security.h b/include/linux/security.h
index 1bab48f..deb3968 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -67,7 +67,7 @@ struct xfrm_state;
 struct xfrm_user_sec_ctx;
 
 extern int cap_netlink_send(struct sock *sk, struct sk_buff *skb);
-extern int cap_netlink_recv(struct sk_buff *skb);
+extern int cap_netlink_recv(struct sk_buff *skb, int cap);
 
 /*
  * Values used in the task_security_ops calls
@@ -647,6 +647,7 @@ #ifdef CONFIG_SECURITY
  *	Check permission before processing the received netlink message in
  *	@skb.
  *	@skb contains the sk_buff structure for the netlink message.
+ *	@cap indicates the capability required
  *	Return 0 if permission is granted.
  *
  * Security hooks for Unix domain networking.
@@ -1248,7 +1249,7 @@ struct security_operations {
 			  struct sembuf * sops, unsigned nsops, int alter);
 
 	int (*netlink_send) (struct sock * sk, struct sk_buff * skb);
-	int (*netlink_recv) (struct sk_buff * skb);
+	int (*netlink_recv) (struct sk_buff * skb, int cap);
 
 	/* allow module stacking */
 	int (*register_security) (const char *name,
@@ -2002,9 +2003,9 @@ static inline int security_netlink_send(
 	return security_ops->netlink_send(sk, skb);
 }
 
-static inline int security_netlink_recv(struct sk_buff * skb)
+static inline int security_netlink_recv(struct sk_buff * skb, int cap)
 {
-	return security_ops->netlink_recv(skb);
+	return security_ops->netlink_recv(skb, cap);
 }
 
 /* prototypes */
@@ -2630,9 +2631,9 @@ static inline int security_netlink_send 
 	return cap_netlink_send (sk, skb);
 }
 
-static inline int security_netlink_recv (struct sk_buff *skb)
+static inline int security_netlink_recv (struct sk_buff *skb, int cap)
 {
-	return cap_netlink_recv (skb);
+	return cap_netlink_recv (skb, cap);
 }
 
 static inline struct dentry *securityfs_create_dir(const char *name,
diff --git a/kernel/audit.c b/kernel/audit.c
index df57b49..8c6b430 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -412,7 +412,7 @@ nlmsg_failure:			/* Used by NLMSG_PUT */
  * Check for appropriate CAP_AUDIT_ capabilities on incoming audit
  * control messages.
  */
-static int audit_netlink_ok(kernel_cap_t eff_cap, u16 msg_type)
+static int audit_netlink_ok(struct sk_buff *skb, u16 msg_type)
 {
 	int err = 0;
 
@@ -426,13 +426,13 @@ static int audit_netlink_ok(kernel_cap_t
 	case AUDIT_DEL:
 	case AUDIT_DEL_RULE:
 	case AUDIT_SIGNAL_INFO:
-		if (!cap_raised(eff_cap, CAP_AUDIT_CONTROL))
+		if (security_netlink_recv(skb, CAP_AUDIT_CONTROL))
 			err = -EPERM;
 		break;
 	case AUDIT_USER:
 	case AUDIT_FIRST_USER_MSG...AUDIT_LAST_USER_MSG:
 	case AUDIT_FIRST_USER_MSG2...AUDIT_LAST_USER_MSG2:
-		if (!cap_raised(eff_cap, CAP_AUDIT_WRITE))
+		if (security_netlink_recv(skb, CAP_AUDIT_WRITE))
 			err = -EPERM;
 		break;
 	default:  /* bad msg */
@@ -453,7 +453,7 @@ static int audit_receive_msg(struct sk_b
 	uid_t			loginuid; /* loginuid of sender */
 	struct audit_sig_info   sig_data;
 
-	err = audit_netlink_ok(NETLINK_CB(skb).eff_cap, msg_type);
+	err = audit_netlink_ok(skb, msg_type);
 	if (err)
 		return err;
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 3fcfa9c..f25aac1 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -663,7 +663,7 @@ rtnetlink_rcv_msg(struct sk_buff *skb, s
 	sz_idx = type>>2;
 	kind = type&3;
 
-	if (kind != 2 && security_netlink_recv(skb)) {
+	if (kind != 2 && security_netlink_recv(skb, CAP_NET_ADMIN)) {
 		*errp = -EPERM;
 		return -1;
 	}
diff --git a/net/decnet/netfilter/dn_rtmsg.c b/net/decnet/netfilter/dn_rtmsg.c
index 74133ec..8b99bd3 100644
--- a/net/decnet/netfilter/dn_rtmsg.c
+++ b/net/decnet/netfilter/dn_rtmsg.c
@@ -107,7 +107,7 @@ static inline void dnrmg_receive_user_sk
 	if (nlh->nlmsg_len < sizeof(*nlh) || skb->len < nlh->nlmsg_len)
 		return;
 
-	if (!cap_raised(NETLINK_CB(skb).eff_cap, CAP_NET_ADMIN))
+	if (security_netlink_recv(skb, CAP_NET_ADMIN))
 		RCV_SKB_FAIL(-EPERM);
 
 	/* Eventually we might send routing messages too */
diff --git a/net/ipv4/netfilter/ip_queue.c b/net/ipv4/netfilter/ip_queue.c
index b93f049..89a42af 100644
--- a/net/ipv4/netfilter/ip_queue.c
+++ b/net/ipv4/netfilter/ip_queue.c
@@ -507,7 +507,7 @@ ipq_rcv_skb(struct sk_buff *skb)
 	if (type <= IPQM_BASE)
 		return;
 		
-	if (security_netlink_recv(skb))
+	if (security_netlink_recv(skb, CAP_NET_ADMIN))
 		RCV_SKB_FAIL(-EPERM);
 	
 	write_lock_bh(&queue_lock);
diff --git a/net/ipv6/netfilter/ip6_queue.c b/net/ipv6/netfilter/ip6_queue.c
index b4b7d44..968a14b 100644
--- a/net/ipv6/netfilter/ip6_queue.c
+++ b/net/ipv6/netfilter/ip6_queue.c
@@ -505,7 +505,7 @@ ipq_rcv_skb(struct sk_buff *skb)
 	if (type <= IPQM_BASE)
 		return;
 	
-	if (security_netlink_recv(skb))
+	if (security_netlink_recv(skb, CAP_NET_ADMIN))
 		RCV_SKB_FAIL(-EPERM);	
 
 	write_lock_bh(&queue_lock);
diff --git a/net/netfilter/nfnetlink.c b/net/netfilter/nfnetlink.c
index b88e82a..ec9f0ef 100644
--- a/net/netfilter/nfnetlink.c
+++ b/net/netfilter/nfnetlink.c
@@ -229,7 +229,7 @@ static int nfnetlink_rcv_msg(struct sk_b
 		 NFNL_SUBSYS_ID(nlh->nlmsg_type),
 		 NFNL_MSG_TYPE(nlh->nlmsg_type));
 
-	if (!cap_raised(NETLINK_CB(skb).eff_cap, CAP_NET_ADMIN)) {
+	if (security_netlink_recv(skb, CAP_NET_ADMIN)) {
 		DEBUGP("missing CAP_NET_ADMIN\n");
 		*errp = -EPERM;
 		return -1;
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index f329b72..edf084b 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -320,7 +320,7 @@ static int genl_rcv_msg(struct sk_buff *
 		goto errout;
 	}
 
-	if ((ops->flags & GENL_ADMIN_PERM) && security_netlink_recv(skb)) {
+	if ((ops->flags & GENL_ADMIN_PERM) && security_netlink_recv(skb, CAP_NET_ADMIN)) {
 		err = -EPERM;
 		goto errout;
 	}
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 81d1005..d514b3b 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1430,7 +1430,7 @@ static int xfrm_user_rcv_msg(struct sk_b
 	link = &xfrm_dispatch[type];
 
 	/* All operations require privileges, even GET */
-	if (security_netlink_recv(skb)) {
+	if (security_netlink_recv(skb, CAP_NET_ADMIN)) {
 		*errp = -EPERM;
 		return -1;
 	}
diff --git a/security/commoncap.c b/security/commoncap.c
index 841eb4e..57673ee 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -33,9 +33,9 @@ int cap_netlink_send(struct sock *sk, st
 
 EXPORT_SYMBOL(cap_netlink_send);
 
-int cap_netlink_recv(struct sk_buff *skb)
+int cap_netlink_recv(struct sk_buff *skb, int cap)
 {
-	if (!cap_raised(NETLINK_CB(skb).eff_cap, CAP_NET_ADMIN))
+	if (!cap_raised(NETLINK_CB(skb).eff_cap, cap))
 		return -EPERM;
 	return 0;
 }
diff --git a/security/dummy.c b/security/dummy.c
index 8cccccc..49ad82d 100644
--- a/security/dummy.c
+++ b/security/dummy.c
@@ -665,9 +665,9 @@ static int dummy_netlink_send (struct so
 	return 0;
 }
 
-static int dummy_netlink_recv (struct sk_buff *skb)
+static int dummy_netlink_recv (struct sk_buff *skb, int cap)
 {
-	if (!cap_raised (NETLINK_CB (skb).eff_cap, CAP_NET_ADMIN))
+	if (!cap_raised (NETLINK_CB (skb).eff_cap, cap))
 		return -EPERM;
 	return 0;
 }
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 21dad41..023da01 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3586,32 +3586,32 @@ #endif	/* CONFIG_NETFILTER */
 
 static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
 {
-	struct task_security_struct *tsec;
-	struct av_decision avd;
 	int err;
 
 	err = secondary_ops->netlink_send(sk, skb);
 	if (err)
 		return err;
 
-	tsec = current->security;
-
-	avd.allowed = 0;
-	avc_has_perm_noaudit(tsec->sid, tsec->sid,
-				SECCLASS_CAPABILITY, ~0, &avd);
-	cap_mask(NETLINK_CB(skb).eff_cap, avd.allowed);
-
 	if (policydb_loaded_version >= POLICYDB_VERSION_NLCLASS)
 		err = selinux_nlmsg_perm(sk, skb);
 
 	return err;
 }
 
-static int selinux_netlink_recv(struct sk_buff *skb)
+static int selinux_netlink_recv(struct sk_buff *skb, int capability)
 {
-	if (!cap_raised(NETLINK_CB(skb).eff_cap, CAP_NET_ADMIN))
-		return -EPERM;
-	return 0;
+	int err;
+	struct avc_audit_data ad;
+
+	err = secondary_ops->netlink_recv(skb, capability);
+	if (err)
+		return err;
+
+	AVC_AUDIT_DATA_INIT(&ad, CAP);
+	ad.u.cap = capability;
+
+	return avc_has_perm(NETLINK_CB(skb).sid, NETLINK_CB(skb).sid,
+	                    SECCLASS_CAPABILITY, CAP_TO_MASK(capability), &ad);
 }
 
 static int ipc_alloc_security(struct task_struct *task,

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
