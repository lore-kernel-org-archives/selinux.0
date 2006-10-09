Message-Id: <20061009195850.814267000@hp.com>
References: <20061009194223.402695000@hp.com>
Date: Mon, 09 Oct 2006 15:42:31 -0400
From: paul.moore@hp.com
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: vyekkirala@TrustedCS.com, jmorris@namei.org, sds@tycho.nsa.gov
Subject: [PATCH 08/11] secid reconciliation: Use secmark when classifying flow using skb
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Venkat Yekkirala <vyekkirala@TrustedCS.com>

This beings secmark into the picture when classifying flows
using an skb.

Signed-off-by: Venkat Yekkirala <vyekkirala@TrustedCS.com>
---
 include/linux/security.h |   10 ----------
 include/linux/skbuff.h   |   20 ++++++++++++++++++++
 2 files changed, 20 insertions(+), 10 deletions(-)

Index: net-2.6_secidfinal/include/linux/security.h
===================================================================
--- net-2.6_secidfinal.orig/include/linux/security.h
+++ net-2.6_secidfinal/include/linux/security.h
@@ -3224,12 +3224,6 @@ static inline int security_xfrm_decode_s
 	return security_ops->xfrm_decode_session(skb, secid, 1);
 }
 
-static inline void security_skb_classify_flow(struct sk_buff *skb, struct flowi *fl)
-{
-	int rc = security_ops->xfrm_decode_session(skb, &fl->secid, 0);
-
-	BUG_ON(rc);
-}
 #else	/* CONFIG_SECURITY_NETWORK_XFRM */
 static inline int security_xfrm_policy_alloc(struct xfrm_policy *xp, struct xfrm_user_sec_ctx *sec_ctx)
 {
@@ -3298,10 +3292,6 @@ static inline int security_xfrm_decode_s
 	return 0;
 }
 
-static inline void security_skb_classify_flow(struct sk_buff *skb, struct flowi *fl)
-{
-}
-
 #endif	/* CONFIG_SECURITY_NETWORK_XFRM */
 
 #ifdef CONFIG_KEYS
Index: net-2.6_secidfinal/include/linux/skbuff.h
===================================================================
--- net-2.6_secidfinal.orig/include/linux/skbuff.h
+++ net-2.6_secidfinal/include/linux/skbuff.h
@@ -30,6 +30,7 @@
 #include <net/checksum.h>
 #include <linux/dmaengine.h>
 #include <net/flow.h>
+#include <linux/security.h>
 
 #define HAVE_ALLOC_SKB		/* For the drivers to know */
 #define HAVE_ALIGNABLE_SKB	/* Ditto 8)		   */
@@ -1514,6 +1515,20 @@ static inline void security_flow_classif
 	skb->secmark = fl->secid;
 }
 
+static inline void security_skb_classify_flow(struct sk_buff *skb,
+					struct flowi *fl)
+{
+	/*
+	 * We need to check for xfrm label here since secid reconciliation
+	 * may or may not have happened yet and we want the
+	 * flow to use the best available label.
+	 */
+	int rc = security_xfrm_decode_session(skb, &fl->secid);
+
+	if (rc || !fl->secid)
+		fl->secid = skb->secmark;
+}
+
 #else
 
 static inline void security_skb_classify_skb(struct sk_buff *from,
@@ -1526,6 +1541,11 @@ static inline void security_flow_classif
 {
 }
 
+static inline void security_skb_classify_flow(struct sk_buff *skb,
+					struct flowi *fl)
+{
+}
+
 #endif /* CONFIG_SECURITY_NETWORK */
 
 #endif	/* __KERNEL__ */

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
