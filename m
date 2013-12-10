Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rBAJrbGt025342
	for <selinux@tycho.nsa.gov>; Tue, 10 Dec 2013 14:53:37 -0500
Subject: [PATCH 1/2] selinux: look for IPsec labels on both inbound and
 outbound packets
To: selinux@tycho.nsa.gov
From: Paul Moore <pmoore@redhat.com>
Cc: janak.desai@gtri.gatech.edu
Date: Tue, 10 Dec 2013 14:53:18 -0500
Message-ID: <20131210195317.3404.16510.stgit@localhost>
In-Reply-To: <20131210195150.3404.61178.stgit@localhost>
References: <20131210195150.3404.61178.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Previously selinux_skb_peerlbl_sid() would only check for labeled
IPsec security labels on inbound packets, this patch enables it to
check both inbound and outbound traffic for labeled IPsec security
labels.

Reported-by: Janak Desai <Janak.Desai@gtri.gatech.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 security/selinux/hooks.c        |    2 +-
 security/selinux/include/xfrm.h |    8 ++++--
 security/selinux/xfrm.c         |   51 +++++++++++++++++++++++++++++++--------
 3 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 17d7689..95cb134 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3829,7 +3829,7 @@ static int selinux_skb_peerlbl_sid(struct sk_buff *skb, u16 family, u32 *sid)
 	u32 nlbl_sid;
 	u32 nlbl_type;
 
-	err = selinux_skb_xfrm_sid(skb, &xfrm_sid);
+	err = selinux_xfrm_skb_sid(skb, &xfrm_sid);
 	if (unlikely(err))
 		return -EACCES;
 	err = selinux_netlbl_skbuff_getsid(skb, family, &nlbl_type, &nlbl_sid);
diff --git a/security/selinux/include/xfrm.h b/security/selinux/include/xfrm.h
index 0dec76c..48c3cc9 100644
--- a/security/selinux/include/xfrm.h
+++ b/security/selinux/include/xfrm.h
@@ -39,6 +39,7 @@ int selinux_xfrm_sock_rcv_skb(u32 sk_sid, struct sk_buff *skb,
 int selinux_xfrm_postroute_last(u32 sk_sid, struct sk_buff *skb,
 				struct common_audit_data *ad, u8 proto);
 int selinux_xfrm_decode_session(struct sk_buff *skb, u32 *sid, int ckall);
+int selinux_xfrm_skb_sid(struct sk_buff *skb, u32 *sid);
 
 static inline void selinux_xfrm_notify_policyload(void)
 {
@@ -79,11 +80,12 @@ static inline int selinux_xfrm_decode_session(struct sk_buff *skb, u32 *sid,
 static inline void selinux_xfrm_notify_policyload(void)
 {
 }
-#endif
 
-static inline int selinux_skb_xfrm_sid(struct sk_buff *skb, u32 *sid)
+static inline int selinux_xfrm_skb_sid(struct sk_buff *skb, u32 *sid)
 {
-	return selinux_xfrm_decode_session(skb, sid, 0);
+	*sid = SECSID_NULL;
+	return 0;
 }
+#endif
 
 #endif /* _SELINUX_XFRM_H_ */
diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index cf79a45..0462cb3 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -209,19 +209,26 @@ int selinux_xfrm_state_pol_flow_match(struct xfrm_state *x,
 			    NULL) ? 0 : 1);
 }
 
-/*
- * LSM hook implementation that checks and/or returns the xfrm sid for the
- * incoming packet.
- */
-int selinux_xfrm_decode_session(struct sk_buff *skb, u32 *sid, int ckall)
+static u32 selinux_xfrm_skb_sid_egress(struct sk_buff *skb)
 {
-	u32 sid_session = SECSID_NULL;
-	struct sec_path *sp;
+	struct dst_entry *dst = skb_dst(skb);
+	struct xfrm_state *x;
 
-	if (skb == NULL)
-		goto out;
+	if (dst == NULL)
+		return SECSID_NULL;
+	x = dst->xfrm;
+	if (x == NULL || !selinux_authorizable_xfrm(x))
+		return SECSID_NULL;
+
+	return x->security->ctx_sid;
+}
+
+static int selinux_xfrm_skb_sid_ingress(struct sk_buff *skb,
+					u32 *sid, int ckall)
+{
+	u32 sid_session = SECSID_NULL;
+	struct sec_path *sp = skb->sp;
 
-	sp = skb->sp;
 	if (sp) {
 		int i;
 
@@ -248,6 +255,30 @@ out:
 }
 
 /*
+ * LSM hook implementation that checks and/or returns the xfrm sid for the
+ * incoming packet.
+ */
+int selinux_xfrm_decode_session(struct sk_buff *skb, u32 *sid, int ckall)
+{
+	if (skb == NULL) {
+		*sid = SECSID_NULL;
+		return 0;
+	}
+	return selinux_xfrm_skb_sid_ingress(skb, sid, ckall);
+}
+
+int selinux_xfrm_skb_sid(struct sk_buff *skb, u32 *sid)
+{
+	int rc;
+
+	rc = selinux_xfrm_skb_sid_ingress(skb, sid, 0);
+	if (rc == 0 && *sid == SECSID_NULL)
+		*sid = selinux_xfrm_skb_sid_egress(skb);
+
+	return rc;
+}
+
+/*
  * LSM hook implementation that allocs and transfers uctx spec to xfrm_policy.
  */
 int selinux_xfrm_policy_alloc(struct xfrm_sec_ctx **ctxp,


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
