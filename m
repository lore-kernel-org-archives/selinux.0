Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEB9C10F0B
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972EC2184A
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="JYJ7Z7V1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbfB1WTw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:19:52 -0500
Received: from sonic315-15.consmr.mail.gq1.yahoo.com ([98.137.65.39]:36291
        "EHLO sonic315-15.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729454AbfB1WTw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392390; bh=Vf8z+tQ8BdtbqssMgRY2k0oVtlJaIcpxVGAAVq5mSac=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=JYJ7Z7V1pJlonLcXDtHfYvBg0RqNc2yYgAWXRJVLMeFOEB5kCW7VCbmIN3Kd/QyARTsP5+n8d5YVR8sTKJ1oAkOORmQ1i1m9G8jZtJFrJ9e1VcYLA0+tWs8RKF4VPy9oq7+Sso6T+5/+JHg/9T0EJtOJqVN+jtz8OpousGZn2CQQbuYKZH00JwPCiLsGDPc0u+qTjSQhM6n9mP4zh4o8BEzjN3e6/brIxyTG4mRzshlQ9gC/rYIrx3NEakepiYFSfQ321EKrWAznXGEM9d92dhxVFg5n41ltPohKzSvpa/fxGERsYPtT9dmQzr9ZQ/7oMx0AvT1RkttXqmm7GqwJHQ==
X-YMail-OSG: icmtPHMVM1kS_HTfLG2odJqDNqEf0CL3QxvKV9wMikyUpdwzXuyhCdOof0zYgWY
 sLgpf3.qD..eejOJMNfw.781ORIUfx4EbAInfg3FZiosLAvq0oMXrClmJ0J6ooSsECUCzVqDZycp
 f23koQQkutCtVDwJzJhx7QPjLI46pPkc3Ihqx5c9Y20LZ9cbC_1H8bEp4Igm5_7L2wBRqY2fdZw_
 _Sda_nvsDkudew6Asm7mChADCyn4j3MPOSvyGzioRw2okqelrhcqODVhtsNn3P4r5aIO5G8O2Zk3
 iL49fRaEXyziDLV4_HH.ZvfwP8U9LAvSxFOHnLVI.NRvAv.4lIKGOR6qskKUcjjlgSuzygASHIF5
 QoHTKl8gVZRGASMPBAmXoFnvTNnhteuUGDP_RQUHYuNSEDzNjoOo8jyrqdwFjyG4z9hF3SVjKVTQ
 OVIvVYRcrmEF5suKp94m0PJENmwqmfXNJDSSg8enCTWrts3xyidOW.mgLKgQqopwzfTp_RAB96yj
 fHQ7VVN5GutOqFYWCfPGPSfRE_J.8evyD2qSL9lpa_H4u2H3NCeic37BPLPKqZtQLsnW5CWWrdjy
 fxHESffYPqec1FJ5_I15VcFz3lpAeOgBXE0.X8PQDCoG7icsZOzxtfp0ouAnaP.En_rvJRIFESft
 sjmdwCuLBHdASNysn2eh3aUsJW8M8jChxTSvfpZy.gEAaGjGd2FBcu6RuoMyDnoQUcdFlvjV.kKY
 AObuXRiXDM_OKkCcKuoKo3KR2tKPfn8Dob.80VVZmCPUMzNNNg1dYn40hTEVXdpro6DY2Uz129WG
 6m.7yJIIs8A6_AtsB98aM1KbsJrH4IWllzB41oNW2iq0UpdNSFB5J8Fwx5csNQMBdTa8YCpnCYpe
 1._TIsD4Rd3QLLYrnrRvo.MkL3jQCO1SjomWRfAzFmNXEzfseuV33CzC5tuoogz4SBngld7eVK0W
 XtwPzQsRMR_4CB10CuST7RIlb8INFBcB0lDS6bUZIfX.7NV5ZI0KxUPMiIbg8UagmiVmwHoU53eR
 uRJwQu90eIx4YkweIgQk_hHGwJrl8.YJ9mOwHK6d5qTH_tqI3EyHQD0G0aWwMbpOOH1rTNUZkQb8
 rhOVPAT3qaqnjJa.KuNYvXOl8HoYe7lnxtjR1j8DU_9Az5wMfB7I-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:19:50 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp403.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID eca90f2e660dab57d5d3726b0a8f0373;
          Thu, 28 Feb 2019 22:19:46 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 07/97] SCAFFOLD: Move security.h out of route.h
Date:   Thu, 28 Feb 2019 14:18:03 -0800
Message-Id: <20190228221933.2551-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Move staic inlines out of route.h so that route.h doesn't need security.h.
This makes Casey's life easier as lots less recompiles after a change
to security.h. DO NOT TAKE THIS PATCH!

Signed-off-by: Casey Schaufler <caey@schaufler-ca.com>
---
 include/net/route.h | 55 ++++++----------------------------------
 net/ipv4/route.c    | 61 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 48 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index 9883dc82f723..de599f20ea5b 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -35,7 +35,7 @@
 #include <linux/route.h>
 #include <linux/ip.h>
 #include <linux/cache.h>
-#include <linux/security.h>
+//CBS #include <linux/security.h>
 
 /* IPv4 datagram length is stored into 16bit field (tot_len) */
 #define IP_MAX_MTU	0xFFFFU
@@ -146,20 +146,11 @@ static inline struct rtable *ip_route_output(struct net *net, __be32 daddr,
 	return ip_route_output_key(net, &fl4);
 }
 
-static inline struct rtable *ip_route_output_ports(struct net *net, struct flowi4 *fl4,
+struct rtable *ip_route_output_ports(struct net *net, struct flowi4 *fl4,
 						   struct sock *sk,
 						   __be32 daddr, __be32 saddr,
 						   __be16 dport, __be16 sport,
-						   __u8 proto, __u8 tos, int oif)
-{
-	flowi4_init_output(fl4, oif, sk ? sk->sk_mark : 0, tos,
-			   RT_SCOPE_UNIVERSE, proto,
-			   sk ? inet_sk_flowi_flags(sk) : 0,
-			   daddr, saddr, dport, sport, sock_net_uid(net, sk));
-	if (sk)
-		security_sk_classify_flow(sk, flowi4_to_flowi(fl4));
-	return ip_route_output_flow(net, fl4, sk);
-}
+						   __u8 proto, __u8 tos, int oif);
 
 static inline struct rtable *ip_route_output_gre(struct net *net, struct flowi4 *fl4,
 						 __be32 daddr, __be32 saddr,
@@ -286,47 +277,15 @@ static inline void ip_route_connect_init(struct flowi4 *fl4, __be32 dst, __be32
 			   sk->sk_uid);
 }
 
-static inline struct rtable *ip_route_connect(struct flowi4 *fl4,
+struct rtable *ip_route_connect(struct flowi4 *fl4,
 					      __be32 dst, __be32 src, u32 tos,
 					      int oif, u8 protocol,
 					      __be16 sport, __be16 dport,
-					      struct sock *sk)
-{
-	struct net *net = sock_net(sk);
-	struct rtable *rt;
-
-	ip_route_connect_init(fl4, dst, src, tos, oif, protocol,
-			      sport, dport, sk);
-
-	if (!dst || !src) {
-		rt = __ip_route_output_key(net, fl4);
-		if (IS_ERR(rt))
-			return rt;
-		ip_rt_put(rt);
-		flowi4_update_output(fl4, oif, tos, fl4->daddr, fl4->saddr);
-	}
-	security_sk_classify_flow(sk, flowi4_to_flowi(fl4));
-	return ip_route_output_flow(net, fl4, sk);
-}
-
-static inline struct rtable *ip_route_newports(struct flowi4 *fl4, struct rtable *rt,
+					      struct sock *sk);
+struct rtable *ip_route_newports(struct flowi4 *fl4, struct rtable *rt,
 					       __be16 orig_sport, __be16 orig_dport,
 					       __be16 sport, __be16 dport,
-					       struct sock *sk)
-{
-	if (sport != orig_sport || dport != orig_dport) {
-		fl4->fl4_dport = dport;
-		fl4->fl4_sport = sport;
-		ip_rt_put(rt);
-		flowi4_update_output(fl4, sk->sk_bound_dev_if,
-				     RT_CONN_FLAGS(sk), fl4->daddr,
-				     fl4->saddr);
-		security_sk_classify_flow(sk, flowi4_to_flowi(fl4));
-		return ip_route_output_flow(sock_net(sk), fl4, sk);
-	}
-	return rt;
-}
-
+					       struct sock *sk);
 static inline int inet_iif(const struct sk_buff *skb)
 {
 	struct rtable *rt = skb_rtable(skb);
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index ce92f73cf104..1160f4ba5073 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -199,6 +199,67 @@ EXPORT_SYMBOL(ip_tos2prio);
 static DEFINE_PER_CPU(struct rt_cache_stat, rt_cache_stat);
 #define RT_CACHE_STAT_INC(field) raw_cpu_inc(rt_cache_stat.field)
 
+/*CBS*/
+struct rtable *ip_route_output_ports(struct net *net, struct flowi4 *fl4,
+						   struct sock *sk,
+						   __be32 daddr, __be32 saddr,
+						   __be16 dport, __be16 sport,
+						   __u8 proto, __u8 tos, int oif)
+{
+	flowi4_init_output(fl4, oif, sk ? sk->sk_mark : 0, tos,
+			   RT_SCOPE_UNIVERSE, proto,
+			   sk ? inet_sk_flowi_flags(sk) : 0,
+			   daddr, saddr, dport, sport, sock_net_uid(net, sk));
+	if (sk)
+		security_sk_classify_flow(sk, flowi4_to_flowi(fl4));
+	return ip_route_output_flow(net, fl4, sk);
+}
+EXPORT_SYMBOL(ip_route_output_ports);
+
+struct rtable *ip_route_connect(struct flowi4 *fl4,
+					      __be32 dst, __be32 src, u32 tos,
+					      int oif, u8 protocol,
+					      __be16 sport, __be16 dport,
+					      struct sock *sk)
+{
+	struct net *net = sock_net(sk);
+	struct rtable *rt;
+
+	ip_route_connect_init(fl4, dst, src, tos, oif, protocol,
+			      sport, dport, sk);
+
+	if (!dst || !src) {
+		rt = __ip_route_output_key(net, fl4);
+		if (IS_ERR(rt))
+			return rt;
+		ip_rt_put(rt);
+		flowi4_update_output(fl4, oif, tos, fl4->daddr, fl4->saddr);
+	}
+	security_sk_classify_flow(sk, flowi4_to_flowi(fl4));
+	return ip_route_output_flow(net, fl4, sk);
+}
+EXPORT_SYMBOL(ip_route_connect);
+
+struct rtable *ip_route_newports(struct flowi4 *fl4, struct rtable *rt,
+					       __be16 orig_sport, __be16 orig_dport,
+					       __be16 sport, __be16 dport,
+					       struct sock *sk)
+{
+	if (sport != orig_sport || dport != orig_dport) {
+		fl4->fl4_dport = dport;
+		fl4->fl4_sport = sport;
+		ip_rt_put(rt);
+		flowi4_update_output(fl4, sk->sk_bound_dev_if,
+				     RT_CONN_FLAGS(sk), fl4->daddr,
+				     fl4->saddr);
+		security_sk_classify_flow(sk, flowi4_to_flowi(fl4));
+		return ip_route_output_flow(sock_net(sk), fl4, sk);
+	}
+	return rt;
+}
+EXPORT_SYMBOL(ip_route_newports);
+/*CBS*/
+
 #ifdef CONFIG_PROC_FS
 static void *rt_cache_seq_start(struct seq_file *seq, loff_t *pos)
 {
-- 
2.17.0

