Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vADNZpIv022844
 for <selinux@tycho.nsa.gov>; Mon, 13 Nov 2017 18:35:54 -0500
From: Richard Haines <richard_c_haines@btinternet.com>
To: paul@paul-moore.com, selinux@tycho.nsa.gov, netdev@vger.kernel.org
Date: Mon, 13 Nov 2017 20:54:22 +0000
Message-Id: <20171113205422.2918-1-richard_c_haines@btinternet.com>
Subject: [PATCH] netlabel: If PF_INET6,
 check sk_buff ip header version
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When resolving a fallback label, check the sk_buff version as it
is possible (e.g. SCTP) to have family = PF_INET6 while
receiving ip_hdr(skb)->version = 4.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 net/netlabel/netlabel_unlabeled.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 22dc1b9..c070dfc 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -1472,6 +1472,16 @@ int netlbl_unlabel_getattr(const struct sk_buff *skb,
 		iface = rcu_dereference(netlbl_unlhsh_def);
 	if (iface == NULL || !iface->valid)
 		goto unlabel_getattr_nolabel;
+
+#if IS_ENABLED(CONFIG_IPV6)
+	/* When resolving a fallback label, check the sk_buff version as
+	 * it is possible (e.g. SCTP) to have family = PF_INET6 while
+	 * receiving ip_hdr(skb)->version = 4.
+	 */
+	if (family == PF_INET6 && ip_hdr(skb)->version == 4)
+		family = PF_INET;
+#endif /* IPv6 */
+
 	switch (family) {
 	case PF_INET: {
 		struct iphdr *hdr4;
-- 
2.13.6
