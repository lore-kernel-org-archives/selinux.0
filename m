Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61472C4360F
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC56218AE
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mDSJUdZ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfB1WoP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:44:15 -0500
Received: from sonic301-10.consmr.mail.bf2.yahoo.com ([74.6.129.49]:33553 "EHLO
        sonic301-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728425AbfB1WoP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551393853; bh=T99UAwbzwl6vRkj82D5u068WAkhWTn74lvNVXW7yVTU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=mDSJUdZ9n2cb7X7U6kzHli4Ym1LUZVYsQiiAjr9UReddt7a4I0GsyeoWiIFtqJM/+bBQLNZOjkJS9s7NYIGSw+lF2p4wrhzZg7iDDOffwhE3KK1lL96XRJrhvMvpmRkcvBquoPAMqtbajRTRiookECS0MWsYGVp1v7CHFnLfUqwrqXyEoUgINYq3uH4xfqQDFHzPEfrUibp8jvsTprfPFnKRcva9W9tPfK91d1w4qINY+m/9k5p7SwFZnYC8xKLrmdtdYDRclbNCgrkby6R3vXR9heD83d6WuK6iwrxE13YBaDRLyT+5W6iRn6AYPv8OA+n+DoBywvgS+nG7MKtWmQ==
X-YMail-OSG: 5utznpUVM1kTy8ES9SgFhj.Kqs3r0bJ3pHa1hgCx5pdZ7sq3rxquDjZV7glVvlk
 1Kpwx4dKU81ApclMVOTK6.nbKQ3u13Dz9TzE.cGRJpjxtTI63FEz2CFR0hRkBszVcwSDz30C9uc9
 aDdam2y4iXT2TfIJjEIathoGDV3B70H3TxQEs4csqVhhBYceYR3slKumzaGv1wTlKGouV_dP3v2u
 HPff8IinorQQkhLgeKRbC_PILj_CyJ1LbzR0PUKjLdoZuoEyPSG79JVrZjSZZxLIEi8C.wm0oSnY
 wt1YNnq2n9KKqxlGY0Q4NeF2xTgqFOOhx571pxlZWZwJ24hkWqYExnEOUAhwUJb2kaHTIKLasATm
 MxQizyJY5mzCG3SDioez4fDkpWjILnict6.MSVSRGmkrkuFgl41jwqKo0B7ZKVjcPJ8NfaA2iHn9
 CYoxUZ2gL9t2S6_gEqC0ZFZhhR6eaVDGvN3PTQby9WVzfGgug7qh5AfVsOi8_5oaE11X8FQETvsB
 5ZJ9QUjRpiV546fxEryi5wn3IcybcUq4M33Z0btmSsWC4LD9DXsrIRv8ssntOYYVLyxNMDhJg0Aj
 9KAbyh2IU0VMFut_hjgZmfuTp1aWntAP2UM0HyxJGDzxN59lWlSJBRJrN2uYyVuSCsxs2HEJtgHW
 fU2DD5A2nwLnQY8QzdBcX4yIx299iA.Eo9cSpb9_lcvS5X0I6tN7jIzlgyFPftYa33K9kIYgPuWB
 wIoh03MFM5N.Mmj_5YMlxEQs3RGti0kinqgPGSi4nz3rhP29XglzxhwQu2XFFQyZkPNQnRQFQ8lS
 C7Qmyf.OlzxpgOQebIAypxntx6m5Cmw577_ga2Vbdz3NqZX72l3pGcunKDmmEp5D4WMwhTv853i3
 _X8M7AAv8uXFoliLaK3qD62dy84MPVzI0iI0qOFBWUA1Y.6Y62u.wLVfg8PVMaElp7oQUjZSDYGM
 MDnax_03X8H0iUclijO7xs.mtzhTqcN0A0SKe504flOib6HmU_Un9TutUEhBvCFUyBXtBSf5EQQt
 Qf877GwsaAorRxh8UG2L96WAWTM6RNTAoCDB3dvC1pnMTMAs6Bl2bfwD6f6DoAY4QaFffvrEc1Kx
 yybRnj_.Kn9JzoNolEL.Gpy.Jw6dtVA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Thu, 28 Feb 2019 22:44:13 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp428.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 731ec5e129ec3fdeedd3a533970a7e62;
          Thu, 28 Feb 2019 22:44:08 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 74/97] Smack: Detect if secmarks can be safely used
Date:   Thu, 28 Feb 2019 14:43:33 -0800
Message-Id: <20190228224356.2608-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228224356.2608-1-casey@schaufler-ca.com>
References: <20190228224356.2608-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Utilize the security_secmark_refcount_in() hooks to determine
if Smack can safely assume that IP secmarks are not being used
by another LSM. Only use secmarks if they can be determined to
belong to Smack.

[cschaufler@localhost lsm-stacking]$ head -30 ../from-lap-190128/0073*
From 796ddbf9da8e0e8180805591badf182d2578ed5a Mon Sep 17 00:00:00 2001
From: Casey Schaufler <casey@schaufler-ca.com>
Date: Thu, 3 Jan 2019 15:56:59 -0800
Subject: [PATCH 73/79] Smack: Detect if secmarks can be safely used

Utilize the security_secmark_refcount_in() hooks to determine
if Smack can safely assume that IP secmarks are not being used
by another LSM. Only use secmarks if they can be determined to
belong to Smack.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack.h           | 15 +++++++++++++++
 security/smack/smack_lsm.c       | 16 +++++-----------
 security/smack/smack_netfilter.c | 25 +++++++++++++++++++++++--
 3 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index f623d059421d..147afb9233b4 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -553,4 +553,19 @@ static inline void smk_ad_setfield_u_net_sk(struct smk_audit_info *a,
 }
 #endif
 
+#ifdef CONFIG_SECURITY_SMACK_NETFILTER
+extern bool smack_use_secmark;
+void smack_secmark_refcount_inc(void);
+
+static inline bool smk_use_secmark(void)
+{
+	return smack_use_secmark;
+}
+#else
+static inline bool smk_use_secmark(void)
+{
+	return false;
+}
+#endif
+
 #endif  /* _SECURITY_SMACK_H */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 7b8ad16c09e0..c45e2dc3f959 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3742,7 +3742,7 @@ static int smk_skb_to_addr_ipv6(struct sk_buff *skb, struct sockaddr_in6 *sip)
  */
 static struct smack_known *smack_from_skb(struct sk_buff *skb)
 {
-	if (skb == NULL || skb->secmark == 0)
+	if (skb == NULL || skb->secmark == 0 || !smk_use_secmark())
 		return NULL;
 
 	return smack_from_secid(skb->secmark);
@@ -3776,7 +3776,6 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 
 	switch (family) {
 	case PF_INET:
-#ifdef CONFIG_SECURITY_SMACK_NETFILTER
 		/*
 		 * If there is a secmark use it rather than the CIPSO label.
 		 * If there is no secmark fall back to CIPSO.
@@ -3785,7 +3784,6 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		skp = smack_from_skb(skb);
 		if (skp)
 			goto access_check;
-#endif /* CONFIG_SECURITY_SMACK_NETFILTER */
 		/*
 		 * Translate what netlabel gave us.
 		 */
@@ -3799,9 +3797,8 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 
 		netlbl_secattr_destroy(&secattr);
 
-#ifdef CONFIG_SECURITY_SMACK_NETFILTER
 access_check:
-#endif
+
 #ifdef CONFIG_AUDIT
 		smk_ad_init_net(&ad, __func__, LSM_AUDIT_DATA_NET, &net);
 		ad.a.u.net->family = family;
@@ -3928,13 +3925,11 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 		s = ssp->smk_out->smk_secid;
 		break;
 	case PF_INET:
-#ifdef CONFIG_SECURITY_SMACK_NETFILTER
 		skp = smack_from_skb(skb);
 		if (skp) {
 			s = skp->smk_secid;
 			break;
 		}
-#endif
 		/*
 		 * Translate what netlabel gave us.
 		 */
@@ -4024,7 +4019,6 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 	}
 #endif /* CONFIG_IPV6 */
 
-#ifdef CONFIG_SECURITY_SMACK_NETFILTER
 	/*
 	 * If there is a secmark use it rather than the CIPSO label.
 	 * If there is no secmark fall back to CIPSO.
@@ -4033,7 +4027,6 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 	skp = smack_from_skb(skb);
 	if (skp)
 		goto access_check;
-#endif /* CONFIG_SECURITY_SMACK_NETFILTER */
 
 	netlbl_secattr_init(&secattr);
 	rc = netlbl_skbuff_getattr(skb, family, &secattr);
@@ -4043,9 +4036,7 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 		skp = &smack_known_huh;
 	netlbl_secattr_destroy(&secattr);
 
-#ifdef CONFIG_SECURITY_SMACK_NETFILTER
 access_check:
-#endif
 
 #ifdef CONFIG_AUDIT
 	smk_ad_init_net(&ad, __func__, LSM_AUDIT_DATA_NET, &net);
@@ -4620,6 +4611,9 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sk_alloc_security, smack_sk_alloc_security),
 #ifdef SMACK_IPV6_PORT_LABELING
 	LSM_HOOK_INIT(sk_free_security, smack_sk_free_security),
+#endif
+#ifdef CONFIG_SECURITY_SMACK_NETFILTER
+	LSM_HOOK_INIT(secmark_refcount_inc, smack_secmark_refcount_inc),
 #endif
 	LSM_HOOK_INIT(sock_graft, smack_sock_graft),
 	LSM_HOOK_INIT(inet_conn_request, smack_inet_conn_request),
diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
index 701a1cc1bdcc..ea45b173f8ca 100644
--- a/security/smack/smack_netfilter.c
+++ b/security/smack/smack_netfilter.c
@@ -21,6 +21,15 @@
 #include <net/net_namespace.h>
 #include "smack.h"
 
+bool smack_use_secmark;
+static bool smack_checked_secmark;
+
+void smack_secmark_refcount_inc(void)
+{
+        smack_use_secmark = true;
+	pr_info("Smack: Using network secmarks.\n");
+}
+
 #if IS_ENABLED(CONFIG_IPV6)
 
 static unsigned int smack_ipv6_output(void *priv,
@@ -31,7 +40,13 @@ static unsigned int smack_ipv6_output(void *priv,
 	struct socket_smack *ssp;
 	struct smack_known *skp;
 
-	if (sk && smack_sock(sk)) {
+	if (!smack_checked_secmark) {
+		security_secmark_refcount_inc();
+		security_secmark_refcount_dec();
+		smack_checked_secmark = true;
+	}
+
+	if (smack_use_secmark && sk && smack_sock(sk)) {
 		ssp = smack_sock(sk);
 		skp = ssp->smk_out;
 		skb->secmark = skp->smk_secid;
@@ -49,7 +64,13 @@ static unsigned int smack_ipv4_output(void *priv,
 	struct socket_smack *ssp;
 	struct smack_known *skp;
 
-	if (sk && smack_sock(sk)) {
+	if (!smack_checked_secmark) {
+		security_secmark_refcount_inc();
+		security_secmark_refcount_dec();
+		smack_checked_secmark = true;
+	}
+
+	if (smack_use_secmark && sk && smack_sock(sk)) {
 		ssp = smack_sock(sk);
 		skp = ssp->smk_out;
 		skb->secmark = skp->smk_secid;
-- 
2.17.0

