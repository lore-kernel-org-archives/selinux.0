Message-ID: <45019F5C.3030102@trustedcs.com>
Date: Fri, 08 Sep 2006 11:50:36 -0500
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
MIME-Version: 1.0
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
CC: jmorris@namei.org, sds@tycho.nsa.gov, chanson@TrustedCS.com
Subject: [PATCH 2/7] secid reconciliation-v02: Add LSM hooks
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add skb_policy_check and skb_netfilter_check hooks to LSM to enable
reconciliation of the various security identifiers as well as enforce
flow control on inbound (INPUT/FORWARD) and outbound (OUTPUT/FORWARD)
traffic.

Signed-off-by: Venkat Yekkirala <vyekkirala@TrustedCS.com>
---
 include/linux/security.h |   32 ++++++++++++++++++++++++++++++++
 security/dummy.c         |   13 +++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 9f56fb8..032cede 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -828,6 +828,12 @@ #ifdef CONFIG_SECURITY
  *	Sets the new child socket's sid to the openreq sid.
  * @req_classify_flow:
  *	Sets the flow's sid to the openreq sid.
+ * @skb_policy_check:
+ *	Checks to see if security policy would allow skb into the system.
+ *	Returns 1 if skb allowed into system, 0 otherwise.
+ * @skb_netfilter_check:
+ *	Checks to see if security policy would allow skb to go out of system.
+ *	Returns 1 if skb allowed out of system, 0 otherwise.
  *
  * Security hooks for XFRM operations.
  *
@@ -1372,6 +1378,8 @@ #ifdef CONFIG_SECURITY_NETWORK
 					struct request_sock *req);
 	void (*inet_csk_clone)(struct sock *newsk, const struct request_sock *req);
 	void (*req_classify_flow)(const struct request_sock *req, struct flowi *fl);
+	int (*skb_policy_check)(struct sk_buff *skb, unsigned short family);
+	int (*skb_netfilter_check)(struct sk_buff *skb, u32 nf_secid);
 #endif	/* CONFIG_SECURITY_NETWORK */
 
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
@@ -2946,6 +2954,18 @@ static inline void security_req_classify
 	security_ops->req_classify_flow(req, fl);
 }
 
+static inline int security_skb_policy_check(struct sk_buff *skb,
+					unsigned short family)
+{
+	return security_ops->skb_policy_check(skb, family);
+}
+
+static inline int security_skb_netfilter_check(struct sk_buff *skb,
+					u32 nf_secid)
+{
+	return security_ops->skb_netfilter_check(skb, nf_secid);
+}
+
 static inline void security_sock_graft(struct sock* sk, struct socket *parent)
 {
 	security_ops->sock_graft(sk, parent);
@@ -3097,6 +3117,18 @@ static inline void security_req_classify
 {
 }
 
+static inline int security_skb_policy_check(struct sk_buff *skb,
+					unsigned short family)
+{
+	return 1;
+}
+
+static inline int security_skb_netfilter_check(struct sk_buff *skb,
+					u32 nf_secid)
+{
+	return 1;
+}
+
 static inline void security_sock_graft(struct sock* sk, struct socket *parent)
 {
 }
diff --git a/security/dummy.c b/security/dummy.c
index aeee705..077d3c9 100644
--- a/security/dummy.c
+++ b/security/dummy.c
@@ -832,6 +832,17 @@ static inline void dummy_req_classify_fl
 			struct flowi *fl)
 {
 }
+
+static inline int dummy_skb_policy_check(struct sk_buff *skb,
+			unsigned short family)
+{
+	return 1;
+}
+
+static inline int dummy_skb_netfilter_check(struct sk_buff *skb, u32 nf_secid)
+{
+	return 1;
+}
 #endif	/* CONFIG_SECURITY_NETWORK */
 
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
@@ -1108,6 +1119,8 @@ #ifdef CONFIG_SECURITY_NETWORK
 	set_to_dummy_if_null(ops, inet_conn_request);
 	set_to_dummy_if_null(ops, inet_csk_clone);
 	set_to_dummy_if_null(ops, req_classify_flow);
+	set_to_dummy_if_null(ops, skb_policy_check);
+	set_to_dummy_if_null(ops, skb_netfilter_check);
  #endif	/* CONFIG_SECURITY_NETWORK */
 #ifdef  CONFIG_SECURITY_NETWORK_XFRM
 	set_to_dummy_if_null(ops, xfrm_policy_alloc_security);

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
