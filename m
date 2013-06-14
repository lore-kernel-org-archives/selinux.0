Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r5EJ3hci020696
	for <selinux@tycho.nsa.gov>; Fri, 14 Jun 2013 15:04:24 -0400
Subject: [PATCH 8/8] selinux: remove the BUG_ON() from selinux_skb_xfrm_sid()
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
From: Paul Moore <pmoore@redhat.com>
Date: Fri, 14 Jun 2013 15:04:22 -0400
Message-ID: <20130614190422.30803.22358.stgit@localhost>
In-Reply-To: <20130614185950.30803.17359.stgit@localhost>
References: <20130614185950.30803.17359.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Remove the BUG_ON() from selinux_skb_xfrm_sid() and propogate the
error code up to the caller.  Also check the return values in the
only caller function, selinux_skb_peerlbl_sid().

Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 security/selinux/hooks.c        |    8 ++++++--
 security/selinux/include/xfrm.h |    5 ++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d3555bd..4bc068b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3722,8 +3722,12 @@ static int selinux_skb_peerlbl_sid(struct sk_buff *skb, u16 family, u32 *sid)
 	u32 nlbl_sid;
 	u32 nlbl_type;
 
-	selinux_skb_xfrm_sid(skb, &xfrm_sid);
-	selinux_netlbl_skbuff_getsid(skb, family, &nlbl_type, &nlbl_sid);
+	err = selinux_skb_xfrm_sid(skb, &xfrm_sid);
+	if (unlikely(err))
+		return -EACCES;
+	err = selinux_netlbl_skbuff_getsid(skb, family, &nlbl_type, &nlbl_sid);
+	if (unlikely(err))
+		return -EACCES;
 
 	err = security_net_peersid_resolve(nlbl_sid, nlbl_type, xfrm_sid, sid);
 	if (unlikely(err)) {
diff --git a/security/selinux/include/xfrm.h b/security/selinux/include/xfrm.h
index 60774bc..7605251 100644
--- a/security/selinux/include/xfrm.h
+++ b/security/selinux/include/xfrm.h
@@ -76,10 +76,9 @@ static inline void selinux_xfrm_notify_policyload(void)
 }
 #endif
 
-static inline void selinux_skb_xfrm_sid(struct sk_buff *skb, u32 *sid)
+static inline int selinux_skb_xfrm_sid(struct sk_buff *skb, u32 *sid)
 {
-	int err = selinux_xfrm_decode_session(skb, sid, 0);
-	BUG_ON(err);
+	return selinux_xfrm_decode_session(skb, sid, 0);
 }
 
 #endif /* _SELINUX_XFRM_H_ */


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
