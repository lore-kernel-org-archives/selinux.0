Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD277C433EF
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 23:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4A5860EFE
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 23:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbhJKXI2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 19:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235569AbhJKXI2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 19:08:28 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653D6C061570
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 16:06:27 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id o42so332318vkf.9
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 16:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=axexLhVa3x+9VkJXJLEwKq6+iuQi9E7/qkj9gXZcOxQ=;
        b=4vsi0W96n63aCSpvTmTy9k/FkrbFfccXOiobsZkioG4wlK5rQEgWRVNy57rSw4JhJ0
         Hy8u8on6LT5WbxpNiOU267cRRlN1KekcvKu0HCHsSA2cA1OcVSimk62exC+YI6dueniM
         ahB4ju4N2M4az3+YrHOOsgLI88uRrl8kEO3ebdOiZzZCo5RbUbE3kjhib1Ns7mKkgsBb
         k2/sd5c0ifUgiHI+JEDmWwTZqrgFUOVpajze7WZaDLVW4dQNn0fZ2gmrBRJk3MPrhZEr
         C0nSn4+hUKwK0BJqvn5R2639TbKdQ3Tme9WMsNob5fzfaniIBXDDeb/n6w7mboBdl/BT
         xLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=axexLhVa3x+9VkJXJLEwKq6+iuQi9E7/qkj9gXZcOxQ=;
        b=q1u+X+b+Otvd5153znV3YYX0d3kH+So2oktmuMl1RFcGqYQZ3AoCNWtckHVVQI5OrF
         Yia8NeS9JWxWQl/G/7IYA0ZFYL8tLNrbo8rp40hi8DhvtExsW7fAq2xQt91xl02oawKE
         uWFOM7bxWGL8fYL6JU4OWM/Pc93QHl5JU3RBul3Bh5nJOJrkhgMFIX2qMgN2SGoOh5dd
         evIwr4FuGHYsqTZmolPULAqsGE9IaNm8wPLnN08RE+bWUpqhR/pTBJ04IbgeQk6WS4Pc
         9MvpakEKYgtpnQve27RLtLnox03JbPaZf6wOOiA4y6Xyh1YH8eD3XSIJxJwebF6nft+K
         GD1A==
X-Gm-Message-State: AOAM5334yhY+5NcCCCSq95prS3VK9aadMGLcLm4PwS2rm6xpzm4YAQWY
        1/vdOjCfphtF2GZ8cT+G+D276KtrvIf4
X-Google-Smtp-Source: ABdhPJyCVJibCRCVhAPfeW/ZAWrBetYXhuFhnSTpcINWfHxq5LsAIoIBVNilKQtbKM/hbPUL4JUaSQ==
X-Received: by 2002:a67:ea16:: with SMTP id g22mr26790498vso.14.1633993586065;
        Mon, 11 Oct 2021 16:06:26 -0700 (PDT)
Received: from localhost (pool-96-237-52-188.bstnma.fios.verizon.net. [96.237.52.188])
        by smtp.gmail.com with ESMTPSA id m48sm2289377vkf.50.2021.10.11.16.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 16:06:25 -0700 (PDT)
Subject: [PATCH] selinux: make better use of the nf_hook_state passed to the
 NF hooks
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Mon, 11 Oct 2021 19:06:24 -0400
Message-ID: <163399358463.185926.1386262780774440656.stgit@olly>
User-Agent: StGit/1.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch builds on a previous SELinux/netfilter patch by Florian
Westphal and makes better use of the nf_hook_state variable passed
into the SELinux/netfilter hooks as well as a number of other small
cleanups in the related code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c |   53 +++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 4210831d5ade..4c9ff2e9af31 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5692,38 +5692,37 @@ static int selinux_tun_dev_open(void *security)
 static unsigned int selinux_ip_forward(void *priv, struct sk_buff *skb,
 				       const struct nf_hook_state *state)
 {
-	const struct net_device *indev = state->in;
-	u16 family = state->pf;
-	int err;
+	int ifindex;
+	u16 family;
 	char *addrp;
 	u32 peer_sid;
 	struct common_audit_data ad;
 	struct lsm_network_audit net = {0,};
-	u8 secmark_active;
-	u8 netlbl_active;
-	u8 peerlbl_active;
+	int secmark_active, peerlbl_active;
 
 	if (!selinux_policycap_netpeer())
 		return NF_ACCEPT;
 
 	secmark_active = selinux_secmark_enabled();
-	netlbl_active = netlbl_enabled();
 	peerlbl_active = selinux_peerlbl_enabled();
 	if (!secmark_active && !peerlbl_active)
 		return NF_ACCEPT;
 
+	family = state->pf;
 	if (selinux_skb_peerlbl_sid(skb, family, &peer_sid) != 0)
 		return NF_DROP;
 
+	ifindex = state->in->ifindex;
 	ad.type = LSM_AUDIT_DATA_NET;
 	ad.u.net = &net;
-	ad.u.net->netif = indev->ifindex;
+	ad.u.net->netif = ifindex;
 	ad.u.net->family = family;
 	if (selinux_parse_skb(skb, &ad, &addrp, 1, NULL) != 0)
 		return NF_DROP;
 
 	if (peerlbl_active) {
-		err = selinux_inet_sys_rcv_skb(dev_net(indev), indev->ifindex,
+		int err;
+		err = selinux_inet_sys_rcv_skb(state->net, ifindex,
 					       addrp, family, peer_sid, &ad);
 		if (err) {
 			selinux_netlbl_err(skb, family, err, 1);
@@ -5737,7 +5736,7 @@ static unsigned int selinux_ip_forward(void *priv, struct sk_buff *skb,
 				 SECCLASS_PACKET, PACKET__FORWARD_IN, &ad))
 			return NF_DROP;
 
-	if (netlbl_active)
+	if (netlbl_enabled())
 		/* we do this in the FORWARD path and not the POST_ROUTING
 		 * path because we want to make sure we apply the necessary
 		 * labeling before IPsec is applied so we can leverage AH
@@ -5751,7 +5750,6 @@ static unsigned int selinux_ip_forward(void *priv, struct sk_buff *skb,
 static unsigned int selinux_ip_output(void *priv, struct sk_buff *skb,
 				      const struct nf_hook_state *state)
 {
-	u16 family = state->pf;
 	struct sock *sk;
 	u32 sid;
 
@@ -5785,7 +5783,7 @@ static unsigned int selinux_ip_output(void *priv, struct sk_buff *skb,
 		sid = sksec->sid;
 	} else
 		sid = SECINITSID_KERNEL;
-	if (selinux_netlbl_skbuff_setsid(skb, family, sid) != 0)
+	if (selinux_netlbl_skbuff_setsid(skb, state->pf, sid) != 0)
 		return NF_DROP;
 
 	return NF_ACCEPT;
@@ -5793,25 +5791,22 @@ static unsigned int selinux_ip_output(void *priv, struct sk_buff *skb,
 
 
 static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
-						int ifindex,
-						u16 family)
+					const struct nf_hook_state *state)
 {
-	struct sock *sk = skb_to_full_sk(skb);
 	struct sk_security_struct *sksec;
 	struct common_audit_data ad;
 	struct lsm_network_audit net = {0,};
-	char *addrp;
 	u8 proto;
 
-	if (sk == NULL)
+	if (state->sk == NULL)
 		return NF_ACCEPT;
-	sksec = sk->sk_security;
+	sksec = state->sk->sk_security;
 
 	ad.type = LSM_AUDIT_DATA_NET;
 	ad.u.net = &net;
-	ad.u.net->netif = ifindex;
-	ad.u.net->family = family;
-	if (selinux_parse_skb(skb, &ad, &addrp, 0, &proto))
+	ad.u.net->netif = state->out->ifindex;
+	ad.u.net->family = state->pf;
+	if (selinux_parse_skb(skb, &ad, NULL, 0, &proto))
 		return NF_DROP;
 
 	if (selinux_secmark_enabled())
@@ -5830,31 +5825,29 @@ static unsigned int selinux_ip_postroute(void *priv,
 					 struct sk_buff *skb,
 					 const struct nf_hook_state *state)
 {
-	const struct net_device *outdev = state->out;
-	u16 family = state->pf;
+	u16 family;
 	u32 secmark_perm;
 	u32 peer_sid;
-	int ifindex = outdev->ifindex;
+	int ifindex;
 	struct sock *sk;
 	struct common_audit_data ad;
 	struct lsm_network_audit net = {0,};
 	char *addrp;
-	u8 secmark_active;
-	u8 peerlbl_active;
+	int secmark_active, peerlbl_active;
 
 	/* If any sort of compatibility mode is enabled then handoff processing
 	 * to the selinux_ip_postroute_compat() function to deal with the
 	 * special handling.  We do this in an attempt to keep this function
 	 * as fast and as clean as possible. */
 	if (!selinux_policycap_netpeer())
-		return selinux_ip_postroute_compat(skb, ifindex, family);
+		return selinux_ip_postroute_compat(skb, state);
 
 	secmark_active = selinux_secmark_enabled();
 	peerlbl_active = selinux_peerlbl_enabled();
 	if (!secmark_active && !peerlbl_active)
 		return NF_ACCEPT;
 
-	sk = skb_to_full_sk(skb);
+	sk = state->sk;
 
 #ifdef CONFIG_XFRM
 	/* If skb->dst->xfrm is non-NULL then the packet is undergoing an IPsec
@@ -5873,6 +5866,7 @@ static unsigned int selinux_ip_postroute(void *priv,
 		return NF_ACCEPT;
 #endif
 
+	family = state->pf;
 	if (sk == NULL) {
 		/* Without an associated socket the packet is either coming
 		 * from the kernel or it is being forwarded; check the packet
@@ -5933,6 +5927,7 @@ static unsigned int selinux_ip_postroute(void *priv,
 		secmark_perm = PACKET__SEND;
 	}
 
+	ifindex = state->out->ifindex;
 	ad.type = LSM_AUDIT_DATA_NET;
 	ad.u.net = &net;
 	ad.u.net->netif = ifindex;
@@ -5950,7 +5945,7 @@ static unsigned int selinux_ip_postroute(void *priv,
 		u32 if_sid;
 		u32 node_sid;
 
-		if (sel_netif_sid(dev_net(outdev), ifindex, &if_sid))
+		if (sel_netif_sid(state->net, ifindex, &if_sid))
 			return NF_DROP;
 		if (avc_has_perm(&selinux_state,
 				 peer_sid, if_sid,

