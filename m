Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8CAC433EF
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 14:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2C776023F
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 14:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241969AbhJKOdt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 10:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbhJKOdp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 10:33:45 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90182C061346;
        Mon, 11 Oct 2021 07:25:41 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1mZwFF-0001Vl-OB; Mon, 11 Oct 2021 16:25:37 +0200
From:   Florian Westphal <fw@strlen.de>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, linux-kernel@vger.kernel.org,
        Florian Westphal <fw@strlen.de>
Subject: [PATCH v2 selinux] selinux: remove unneeded ipv6 hook wrappers
Date:   Mon, 11 Oct 2021 16:24:16 +0200
Message-Id: <20211011142416.26798-1-fw@strlen.de>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Netfilter places the protocol number the hook function is getting called
from in state->pf, so we can use that instead of an extra wrapper.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 v2: add back '#endif /* CONFIG_NETFILTER */' erronously axed in v1.
 Applies to 'next' branch of
 https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/

 security/selinux/hooks.c | 52 ++++++++++------------------------------
 1 file changed, 12 insertions(+), 40 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e7ebd45ca345..831b857d5dd7 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5746,22 +5746,13 @@ static unsigned int selinux_ip_forward(struct sk_buff *skb,
 	return NF_ACCEPT;
 }
 
-static unsigned int selinux_ipv4_forward(void *priv,
+static unsigned int selinux_hook_forward(void *priv,
 					 struct sk_buff *skb,
 					 const struct nf_hook_state *state)
 {
-	return selinux_ip_forward(skb, state->in, PF_INET);
+	return selinux_ip_forward(skb, state->in, state->pf);
 }
 
-#if IS_ENABLED(CONFIG_IPV6)
-static unsigned int selinux_ipv6_forward(void *priv,
-					 struct sk_buff *skb,
-					 const struct nf_hook_state *state)
-{
-	return selinux_ip_forward(skb, state->in, PF_INET6);
-}
-#endif	/* IPV6 */
-
 static unsigned int selinux_ip_output(struct sk_buff *skb,
 				      u16 family)
 {
@@ -5804,21 +5795,12 @@ static unsigned int selinux_ip_output(struct sk_buff *skb,
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
+static unsigned int selinux_hook_output(void *priv,
 					struct sk_buff *skb,
 					const struct nf_hook_state *state)
 {
-	return selinux_ip_output(skb, PF_INET6);
+	return selinux_ip_output(skb, state->pf);
 }
-#endif	/* IPV6 */
 
 static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 						int ifindex,
@@ -5994,22 +5976,12 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb,
 	return NF_ACCEPT;
 }
 
-static unsigned int selinux_ipv4_postroute(void *priv,
+static unsigned int selinux_hook_postroute(void *priv,
 					   struct sk_buff *skb,
 					   const struct nf_hook_state *state)
 {
-	return selinux_ip_postroute(skb, state->out, PF_INET);
+	return selinux_ip_postroute(skb, state->out, state->pf);
 }
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
@@ -7470,38 +7442,38 @@ DEFINE_LSM(selinux) = {
 
 static const struct nf_hook_ops selinux_nf_ops[] = {
 	{
-		.hook =		selinux_ipv4_postroute,
+		.hook =		selinux_hook_postroute,
 		.pf =		NFPROTO_IPV4,
 		.hooknum =	NF_INET_POST_ROUTING,
 		.priority =	NF_IP_PRI_SELINUX_LAST,
 	},
 	{
-		.hook =		selinux_ipv4_forward,
+		.hook =		selinux_hook_forward,
 		.pf =		NFPROTO_IPV4,
 		.hooknum =	NF_INET_FORWARD,
 		.priority =	NF_IP_PRI_SELINUX_FIRST,
 	},
 	{
-		.hook =		selinux_ipv4_output,
+		.hook =		selinux_hook_output,
 		.pf =		NFPROTO_IPV4,
 		.hooknum =	NF_INET_LOCAL_OUT,
 		.priority =	NF_IP_PRI_SELINUX_FIRST,
 	},
 #if IS_ENABLED(CONFIG_IPV6)
 	{
-		.hook =		selinux_ipv6_postroute,
+		.hook =		selinux_hook_postroute,
 		.pf =		NFPROTO_IPV6,
 		.hooknum =	NF_INET_POST_ROUTING,
 		.priority =	NF_IP6_PRI_SELINUX_LAST,
 	},
 	{
-		.hook =		selinux_ipv6_forward,
+		.hook =		selinux_hook_forward,
 		.pf =		NFPROTO_IPV6,
 		.hooknum =	NF_INET_FORWARD,
 		.priority =	NF_IP6_PRI_SELINUX_FIRST,
 	},
 	{
-		.hook =		selinux_ipv6_output,
+		.hook =		selinux_hook_output,
 		.pf =		NFPROTO_IPV6,
 		.hooknum =	NF_INET_LOCAL_OUT,
 		.priority =	NF_IP6_PRI_SELINUX_FIRST,
-- 
2.32.0

