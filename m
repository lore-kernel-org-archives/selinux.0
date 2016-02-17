Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u1HE7T3K022536
 for <selinux@tycho.nsa.gov>; Wed, 17 Feb 2016 09:07:31 -0500
From: Huw Davies <huw@codeweavers.com>
To: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov
Subject: [RFC PATCH v3 14/19] ipv6: constify the skb pointer of
 ipv6_find_tlv().
Date: Wed, 17 Feb 2016 13:22:04 +0000
Message-Id: <1455715329-9601-15-git-send-email-huw@codeweavers.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Huw Davies <huw@codeweavers.com>
---
 include/net/ipv6.h      | 2 +-
 net/ipv6/exthdrs_core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 3098e0d..df89320 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -935,7 +935,7 @@ enum {
 int ipv6_find_hdr(const struct sk_buff *skb, unsigned int *offset, int target,
 		  unsigned short *fragoff, int *fragflg);
 
-int ipv6_find_tlv(struct sk_buff *skb, int offset, int type);
+int ipv6_find_tlv(const struct sk_buff *skb, int offset, int type);
 
 struct in6_addr *fl6_update_dst(struct flowi6 *fl6,
 				const struct ipv6_txoptions *opt,
diff --git a/net/ipv6/exthdrs_core.c b/net/ipv6/exthdrs_core.c
index 5c5d23e..b522479 100644
--- a/net/ipv6/exthdrs_core.c
+++ b/net/ipv6/exthdrs_core.c
@@ -112,7 +112,7 @@ int ipv6_skip_exthdr(const struct sk_buff *skb, int start, u8 *nexthdrp,
 }
 EXPORT_SYMBOL(ipv6_skip_exthdr);
 
-int ipv6_find_tlv(struct sk_buff *skb, int offset, int type)
+int ipv6_find_tlv(const struct sk_buff *skb, int offset, int type)
 {
 	const unsigned char *nh = skb_network_header(skb);
 	int packet_len = skb_tail_pointer(skb) - skb_network_header(skb);
-- 
2.7.0
