Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E89C433EF
	for <selinux@archiver.kernel.org>; Tue, 12 Oct 2021 22:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ABBD60724
	for <selinux@archiver.kernel.org>; Tue, 12 Oct 2021 22:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbhJLXBB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Oct 2021 19:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbhJLXBA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Oct 2021 19:01:00 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8B9C061570
        for <selinux@vger.kernel.org>; Tue, 12 Oct 2021 15:58:58 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id j8so1555987uak.9
        for <selinux@vger.kernel.org>; Tue, 12 Oct 2021 15:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=tANvC6HB3NWtAdeJdQtnoCyEGB2PxbjAgZsQ6whKglI=;
        b=nS4JP8vLSRN8hk84TXos2toQxFhx8dzOf9BdOYX3dY6z7PHXMDsugihEdgKWX6t91Y
         vbpmEFEfa6UJB4QGR4W+R9E0ko4Vgp5MqQTm1tj4D4adGO2Q+EX/XG0e7WnYtEtBTE+g
         81MHY7dxKS06DeXqxlFNnvURvNeTnkyZvwAKpdaB6Nl0eUOC0hlgoRBTb6X6xX7WnBvs
         SjM4YQy9vS/bOK3OVlILkmleZ24/NB8ERJg2ePLyQCl7CwRDzNF9eo/ynQNjfFWbqqQy
         R9FC8kjhZ8JXOzlGw5EvCYzfWagGzspNHt3lKVcVNwUh50LEsvzq8FNNL6JfdEUF1qmf
         sMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=tANvC6HB3NWtAdeJdQtnoCyEGB2PxbjAgZsQ6whKglI=;
        b=so/Op85gKuM59S2mmOZLT/X85xHTtfY65jC+SHp2r8ujXCeIos4s6N+ZW/PJ1T6yr/
         wFLVo+klpitqYXJ0VDdT3Z9/ntdhKWHEljxbmLz6TgY8rA9wnNmF1AH9x8Mu3JT1srx4
         L0N9q924CHoXcQoS1nnp3+i0eE3bo/lI+OekzYePXfID9IRz9tPDWWL3OX7r7nHO0tSn
         XdEpE4DupKAMlceq1nJ8CD4JroZUn8uouUeSpKUFiGUekAkBLMOUtTbAD+EkwIa/Ss2t
         B/4Tu70j5eahsF/73P+/PwToWCc8DqgpqGNi+qZ2cM2Ck4SG9nPh8dB8bvSTlUPf3g25
         kHOQ==
X-Gm-Message-State: AOAM533OfqMkSKD9D9dc6s4K8TVoooaVZhP0ggokDtEiV1gbaDJAILm+
        d1ypwTO4uBARsGfsTVGDvARSRlH3OsCJ
X-Google-Smtp-Source: ABdhPJzQ3mIOpTg3w6u90pLtwDT8kkLYjb3tv8949RX+dh0jRMWirYNFKV/T7FZD5XUfcFAGVMA4oQ==
X-Received: by 2002:ab0:66cd:: with SMTP id d13mr26487629uaq.110.1634079536940;
        Tue, 12 Oct 2021 15:58:56 -0700 (PDT)
Received: from localhost (pool-96-237-52-188.bstnma.fios.verizon.net. [96.237.52.188])
        by smtp.gmail.com with ESMTPSA id o196sm5615288vkc.51.2021.10.12.15.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 15:58:56 -0700 (PDT)
Subject: [PATCH v2] selinux: make better use of the nf_hook_state passed to
 the NF hooks
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Tue, 12 Oct 2021 18:58:55 -0400
Message-ID: <163407953525.224696.4280832299519853149.stgit@olly>
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
 security/selinux/hooks.c |   51 ++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 4210831d5ade..60c3ca77cbd7 100644
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
@@ -5793,25 +5791,24 @@ static unsigned int selinux_ip_output(void *priv, struct sk_buff *skb,
 
 
 static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
-						int ifindex,
-						u16 family)
+					const struct nf_hook_state *state)
 {
-	struct sock *sk = skb_to_full_sk(skb);
+	struct sock *sk;
 	struct sk_security_struct *sksec;
 	struct common_audit_data ad;
 	struct lsm_network_audit net = {0,};
-	char *addrp;
 	u8 proto;
 
-	if (sk == NULL)
+	if (state->sk == NULL)
 		return NF_ACCEPT;
+	sk = skb_to_full_sk(skb);
 	sksec = sk->sk_security;
 
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
@@ -5830,24 +5827,22 @@ static unsigned int selinux_ip_postroute(void *priv,
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
@@ -5873,6 +5868,7 @@ static unsigned int selinux_ip_postroute(void *priv,
 		return NF_ACCEPT;
 #endif
 
+	family = state->pf;
 	if (sk == NULL) {
 		/* Without an associated socket the packet is either coming
 		 * from the kernel or it is being forwarded; check the packet
@@ -5933,6 +5929,7 @@ static unsigned int selinux_ip_postroute(void *priv,
 		secmark_perm = PACKET__SEND;
 	}
 
+	ifindex = state->out->ifindex;
 	ad.type = LSM_AUDIT_DATA_NET;
 	ad.u.net = &net;
 	ad.u.net->netif = ifindex;
@@ -5950,7 +5947,7 @@ static unsigned int selinux_ip_postroute(void *priv,
 		u32 if_sid;
 		u32 node_sid;
 
-		if (sel_netif_sid(dev_net(outdev), ifindex, &if_sid))
+		if (sel_netif_sid(state->net, ifindex, &if_sid))
 			return NF_DROP;
 		if (avc_has_perm(&selinux_state,
 				 peer_sid, if_sid,

