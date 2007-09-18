Message-ID: <46F00B82.3030901@trustedcs.com>
Date: Tue, 18 Sep 2007 12:31:46 -0500
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov, paul.moore@hp.com, sds@tycho.nsa.gov,
        jmorris@namei.org
Subject: [RFC] [PATCH 2/4] Define new LSM hooks
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This defines an LSM hook for flow_out checks. It also
points out places for NetLabel integration to label
flows when a packet being forwarded has used NetLabel
or has to use a fallback to label the outgoing flow
for appropriate selection of xfrms.

diff --git a/include/linux/security.h b/include/linux/security.h
index 1a15526..f0b5ee5 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -831,6 +831,8 @@ struct request_sock;
  *     Sets the connection's peersid to the secmark on skb.
  * @req_classify_flow:
  *	Sets the flow's sid to the openreq sid.
+ * @skb_flow_out:
+ *	Determines if an skb can flow out per LSM policy.
  *
  * Security hooks for XFRM operations.
  *
@@ -1370,6 +1372,7 @@ struct security_operations {
 	void (*inet_csk_clone)(struct sock *newsk, const struct request_sock *req);
 	void (*inet_conn_established)(struct sock *sk, struct sk_buff *skb);
 	void (*req_classify_flow)(const struct request_sock *req, struct flowi *fl);
+	int (*skb_flow_out)(struct sk_buff *skb, int family);
 #endif	/* CONFIG_SECURITY_NETWORK */
 
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
@@ -2958,6 +2961,11 @@ static inline void security_req_classify_flow(const struct request_sock *req, st
 	security_ops->req_classify_flow(req, fl);
 }
 
+static inline int security_skb_flow_out(struct sk_buff *skb, int family)
+{
+	return security_ops->skb_flow_out(skb, family);
+}
+
 static inline void security_sock_graft(struct sock* sk, struct socket *parent)
 {
 	security_ops->sock_graft(sk, parent);
@@ -3115,6 +3123,11 @@ static inline void security_req_classify_flow(const struct request_sock *req, st
 {
 }
 
+static inline int security_skb_flow_out(struct sk_buff *skb, int family)
+{
+	return 0;
+}
+
 static inline void security_sock_graft(struct sock* sk, struct socket *parent)
 {
 }
@@ -3203,6 +3216,7 @@ static inline int security_xfrm_decode_session(struct sk_buff *skb, u32 *secid)
 
 static inline void security_skb_classify_flow(struct sk_buff *skb, struct flowi *fl)
 {
+	/* TODO: Use NetLabel here to label flow if no labeled-ipsec in use. */
 	int rc = security_ops->xfrm_decode_session(skb, &fl->secid, 0);
 
 	BUG_ON(rc);
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 7012891..3755e6b 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1912,6 +1912,9 @@ int __xfrm_route_forward(struct sk_buff *skb, unsigned short family)
 	if (xfrm_decode_session(skb, &fl, family) < 0)
 		return 0;
 
+	/* TODO: In case packet didn't use labeled-ipsec coming in
+	  set fl.secid here to the NetLabel/Fallback label */
+
 	return xfrm_lookup(&skb->dst, &fl, NULL, 0) == 0;
 }
 EXPORT_SYMBOL(__xfrm_route_forward);
diff --git a/security/dummy.c b/security/dummy.c
index 853ec22..46a7fa7 100644
--- a/security/dummy.c
+++ b/security/dummy.c
@@ -841,6 +841,12 @@ static inline void dummy_req_classify_flow(const struct request_sock *req,
 			struct flowi *fl)
 {
 }
+
+static inline int dummy_skb_flow_out(struct sk_buff *skb, int family)
+{
+	return 0;
+}
+
 #endif	/* CONFIG_SECURITY_NETWORK */
 
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
@@ -1113,6 +1119,7 @@ void security_fixup_ops (struct security_operations *ops)
 	set_to_dummy_if_null(ops, inet_csk_clone);
 	set_to_dummy_if_null(ops, inet_conn_established);
 	set_to_dummy_if_null(ops, req_classify_flow);
+	set_to_dummy_if_null(ops, skb_flow_out);
  #endif	/* CONFIG_SECURITY_NETWORK */
 #ifdef  CONFIG_SECURITY_NETWORK_XFRM
 	set_to_dummy_if_null(ops, xfrm_policy_alloc_security);

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
