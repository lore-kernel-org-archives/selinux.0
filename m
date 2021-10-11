Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5071C433EF
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 20:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF05560F14
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 20:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbhJKUYn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 16:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234845AbhJKUYn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 16:24:43 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A124EC061570;
        Mon, 11 Oct 2021 13:22:42 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1ma1ol-00038Z-0n; Mon, 11 Oct 2021 22:22:39 +0200
From:   Florian Westphal <fw@strlen.de>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, linux-kernel@vger.kernel.org,
        omosnace@redhat.com, Florian Westphal <fw@strlen.de>
Subject: [PATCH selinux v3] selinux: remove unneeded ipv6 hook wrappers
Date:   Mon, 11 Oct 2021 22:22:29 +0200
Message-Id: <20211011202229.28289-1-fw@strlen.de>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Netfilter places the protocol number the hook function is getting called
from in state->pf, so we can use that instead of an extra wrapper.

While at it, remove one-line wrappers too and make
selinux_ip_{out,forward,postroute} useable as hook function.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 v3: also remove the one-line wrappers, just adjust function signature
 of the actual functions (Ondrej Mosnacek)

 security/selinux/hooks.c | 80 +++++++++-------------------------------
 1 file changed, 18 insertions(+), 62 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e7ebd45ca345..3f6462451921 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5688,10 +5688,11 @@ static int selinux_tun_dev_open(void *security)
 
 #ifdef CONFIG_NETFILTER
 
-static unsigned int selinux_ip_forward(struct sk_buff *skb,
-				       const struct net_device *indev,
-				       u16 family)
+static unsigned int selinux_ip_forward(void *priv, struct sk_buff *skb,
+				       const struct nf_hook_state *state)
 {
+	const struct net_device *indev = state->in;
+	u16 family = state->pf;
 	int err;
 	char *addrp;
 	u32 peer_sid;
@@ -5746,25 +5747,10 @@ static unsigned int selinux_ip_forward(struct sk_buff *skb,
 	return NF_ACCEPT;
 }
 
-static unsigned int selinux_ipv4_forward(void *priv,
-					 struct sk_buff *skb,
-					 const struct nf_hook_state *state)
-{
-	return selinux_ip_forward(skb, state->in, PF_INET);
-}
-
-#if IS_ENABLED(CONFIG_IPV6)
-static unsigned int selinux_ipv6_forward(void *priv,
-					 struct sk_buff *skb,
-					 const struct nf_hook_state *state)
-{
-	return selinux_ip_forward(skb, state->in, PF_INET6);
-}
-#endif	/* IPV6 */
-
-static unsigned int selinux_ip_output(struct sk_buff *skb,
-				      u16 family)
+static unsigned int selinux_ip_output(void *priv, struct sk_buff *skb,
+				      const struct nf_hook_state *state)
 {
+	u16 family = state->pf;
 	struct sock *sk;
 	u32 sid;
 
@@ -5804,21 +5790,6 @@ static unsigned int selinux_ip_output(struct sk_buff *skb,
 	return NF_ACCEPT;
 }
 
-static unsigned int selinux_ipv4_output(void *priv,
-					struct sk_buff *skb,
-					const struct nf_hook_state *state)
-{
-	return selinux_ip_output(skb, PF_INET);
-}
-
-#if IS_ENABLED(CONFIG_IPV6)
-static unsigned int selinux_ipv6_output(void *priv,
-					struct sk_buff *skb,
-					const struct nf_hook_state *state)
-{
-	return selinux_ip_output(skb, PF_INET6);
-}
-#endif	/* IPV6 */
 
 static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 						int ifindex,
@@ -5854,10 +5825,12 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 	return NF_ACCEPT;
 }
 
-static unsigned int selinux_ip_postroute(struct sk_buff *skb,
-					 const struct net_device *outdev,
-					 u16 family)
+static unsigned int selinux_ip_postroute(void *priv,
+					 struct sk_buff *skb,
+					 const struct nf_hook_state *state)
 {
+	const struct net_device *outdev = state->out;
+	u16 family = state->pf;
 	u32 secmark_perm;
 	u32 peer_sid;
 	int ifindex = outdev->ifindex;
@@ -5993,23 +5966,6 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb,
 
 	return NF_ACCEPT;
 }
-
-static unsigned int selinux_ipv4_postroute(void *priv,
-					   struct sk_buff *skb,
-					   const struct nf_hook_state *state)
-{
-	return selinux_ip_postroute(skb, state->out, PF_INET);
-}
-
-#if IS_ENABLED(CONFIG_IPV6)
-static unsigned int selinux_ipv6_postroute(void *priv,
-					   struct sk_buff *skb,
-					   const struct nf_hook_state *state)
-{
-	return selinux_ip_postroute(skb, state->out, PF_INET6);
-}
-#endif	/* IPV6 */
-
 #endif	/* CONFIG_NETFILTER */
 
 static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
@@ -7470,38 +7426,38 @@ DEFINE_LSM(selinux) = {
 
 static const struct nf_hook_ops selinux_nf_ops[] = {
 	{
-		.hook =		selinux_ipv4_postroute,
+		.hook =		selinux_ip_postroute,
 		.pf =		NFPROTO_IPV4,
 		.hooknum =	NF_INET_POST_ROUTING,
 		.priority =	NF_IP_PRI_SELINUX_LAST,
 	},
 	{
-		.hook =		selinux_ipv4_forward,
+		.hook =		selinux_ip_forward,
 		.pf =		NFPROTO_IPV4,
 		.hooknum =	NF_INET_FORWARD,
 		.priority =	NF_IP_PRI_SELINUX_FIRST,
 	},
 	{
-		.hook =		selinux_ipv4_output,
+		.hook =		selinux_ip_output,
 		.pf =		NFPROTO_IPV4,
 		.hooknum =	NF_INET_LOCAL_OUT,
 		.priority =	NF_IP_PRI_SELINUX_FIRST,
 	},
 #if IS_ENABLED(CONFIG_IPV6)
 	{
-		.hook =		selinux_ipv6_postroute,
+		.hook =		selinux_ip_postroute,
 		.pf =		NFPROTO_IPV6,
 		.hooknum =	NF_INET_POST_ROUTING,
 		.priority =	NF_IP6_PRI_SELINUX_LAST,
 	},
 	{
-		.hook =		selinux_ipv6_forward,
+		.hook =		selinux_ip_forward,
 		.pf =		NFPROTO_IPV6,
 		.hooknum =	NF_INET_FORWARD,
 		.priority =	NF_IP6_PRI_SELINUX_FIRST,
 	},
 	{
-		.hook =		selinux_ipv6_output,
+		.hook =		selinux_ip_output,
 		.pf =		NFPROTO_IPV6,
 		.hooknum =	NF_INET_LOCAL_OUT,
 		.priority =	NF_IP6_PRI_SELINUX_FIRST,
-- 
2.32.0

