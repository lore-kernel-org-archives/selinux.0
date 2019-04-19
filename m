Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A1BC282DD
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAFCB217F9
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PX6O+LeL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfDSAtA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:49:00 -0400
Received: from sonic317-33.consmr.mail.bf2.yahoo.com ([74.6.129.88]:36688 "EHLO
        sonic317-33.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726813AbfDSAtA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634938; bh=H1TSzSq4uFLYhDu853vDJ5OALlVedvdY2SPUi+Vr3D4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=PX6O+LeLw4rj/5XrdgDYrqC6pSt99l0RmORlFkl5h2SSMhme5ipOSmJY62XdLoTm7j4tMFfN1k9ewy4CKd/0GAicwTa3fiWaWsvSQh1V5jIBXaHhBdib95UwfxPf5hZXLGg7PQYWXRdun8OpURfNk8aS4GIUyOpwRFOdm9xrNQpWI2DDvyKNH2fZtPyhP41M8HAad7xbFtg5OLYwn8wMJ1JoEEytn3JBLR9pDldtdKJ0dd3CRtRo5XnW94yS8eJIRpGBtXQbxUp7ksXQSQuLrmJAIiZr/XSYxdhjl75XuhHlz0sW0l3NkX31O7btHZH/LqBNPLlNYvN7G1/4yqpwaQ==
X-YMail-OSG: YhxrFNwVM1mrg6C6dSnAJQBRCnKTKour8tAO5VqF5obnBQ_FyzZ6UiiHzMdIRxr
 Yr0rRGE1GGfwuMr6.gmaCW3YSOhpNN.gYN..QAN0J.BjaT0avvLOpyYtG39lAgrckRYuwZdl89T8
 ha.TNqm2amHqDuFE6TRr8GABoJ8XXlAT_fLCHikaK.LM7GESEu98Bog_tOggRJGQKxOHud0EyKSS
 JTMfr6wV497cVJKXm9uR.qgpYdK18dEojk_nKoatD6pQ3wEe0HTcS2WLy1m2RCm5ymIzwo3m0WgZ
 NeeGGiIz26aioEpWyqSWIaxk8JN9vIOXlqwb1h58ldNZsH6Q9pmvEwxhO7NNnsBpsDIjl1b1RbP7
 EI9L_ngxVxLPIJXq_4AtzkUCRvAOUFkq5jZwjNL4Xf8LXT.GJNFLgCa3FU3p8KKzuscfLcC1Dyz3
 9NejsJ6Xu61_7n.9HjcD5cpP5TpHLHJHGuWT2eIe_pgqeIe_Z1Kl5UHM.o1_i.7WBsHhlPPr39zs
 kC3F6bGzKyNLzX0NS4pKxpqF6EMfp_zMQvXr9KX6o42_idLEN0lZH8tN9xruxgIJhCzKPP_QwItR
 a7HZzTOqMJOBs9qK_sYHqbgqIOhetJmZQVgRaqdVN_6krhUwHndfED99LCts5C6wuNLcBLZiSArA
 jIQBuby_hZXnFj7z91sKPtm5ktll63WSdXFETWXVq2hVTaKIk2e0gk3jxcQwFATMj4Zi6uWnK21h
 0AjfDATBHO8Jh4AH7rM64GSbcfmbvgqit5MOV98teqpF2oOuuOQ0UX_X6FSFbr0G_UT3vYzS9qYy
 VZbwEzy9t6VELaqfXAM_KXWkAEk1sYf7Fu.w__0d_TjyKIwWZVKtV0z3xd57nW5gxk2u1y7k6GsM
 cZwijcM7MK3zWQNZLqplqVakA6Rsw_7FEnrpJ_.a6yOm4_TYYBnXZm0QSLVMcxAWfU1z0E9dmk_x
 rQbNWXVv8BIGNSB.4TN9HKLgrLKAT.RZr_5kUIKyw_wqzqKpASdugJes_.RmCr69_RrdRVIr3gXV
 4quq86RX0E_RRm7g5Gx60wwl3nuR.yCLk2XwOBg0tAvFby4mm8lrowDtx451r47kS1PWx6qH.gEi
 i5Hna8eMhy4KOu8HsrWy_xIuW9wPyfi13Vu0.20SeFMFwkjLEB1jDnXu_qe9vw0Jz
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:48:58 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp432.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 406f9efc49df2aab5b39f3872aa73829;
          Fri, 19 Apr 2019 00:48:54 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 67/90] Smack: Detect if secmarks can be safely used
Date:   Thu, 18 Apr 2019 17:45:54 -0700
Message-Id: <20190419004617.64627-68-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

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
index 7cc3a3382fee..66ad1c175002 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -544,4 +544,19 @@ static inline void smk_ad_setfield_u_net_sk(struct smk_audit_info *a,
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
index aaca4ba53032..d76aa0fc37a4 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3828,7 +3828,7 @@ static int smk_skb_to_addr_ipv6(struct sk_buff *skb, struct sockaddr_in6 *sip)
  */
 static struct smack_known *smack_from_skb(struct sk_buff *skb)
 {
-	if (skb == NULL || skb->secmark == 0)
+	if (skb == NULL || skb->secmark == 0 || !smk_use_secmark())
 		return NULL;
 
 	return smack_from_secid(skb->secmark);
@@ -3862,7 +3862,6 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 
 	switch (family) {
 	case PF_INET:
-#ifdef CONFIG_SECURITY_SMACK_NETFILTER
 		/*
 		 * If there is a secmark use it rather than the CIPSO label.
 		 * If there is no secmark fall back to CIPSO.
@@ -3871,7 +3870,6 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		skp = smack_from_skb(skb);
 		if (skp)
 			goto access_check;
-#endif /* CONFIG_SECURITY_SMACK_NETFILTER */
 		/*
 		 * Translate what netlabel gave us.
 		 */
@@ -3885,9 +3883,8 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 
 		netlbl_secattr_destroy(&secattr);
 
-#ifdef CONFIG_SECURITY_SMACK_NETFILTER
 access_check:
-#endif
+
 #ifdef CONFIG_AUDIT
 		smk_ad_init_net(&ad, __func__, LSM_AUDIT_DATA_NET, &net);
 		ad.a.u.net->family = family;
@@ -4014,13 +4011,11 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
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
@@ -4110,7 +4105,6 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 	}
 #endif /* CONFIG_IPV6 */
 
-#ifdef CONFIG_SECURITY_SMACK_NETFILTER
 	/*
 	 * If there is a secmark use it rather than the CIPSO label.
 	 * If there is no secmark fall back to CIPSO.
@@ -4119,7 +4113,6 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 	skp = smack_from_skb(skb);
 	if (skp)
 		goto access_check;
-#endif /* CONFIG_SECURITY_SMACK_NETFILTER */
 
 	netlbl_secattr_init(&secattr);
 	rc = netlbl_skbuff_getattr(skb, family, &secattr);
@@ -4129,9 +4122,7 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 		skp = &smack_known_huh;
 	netlbl_secattr_destroy(&secattr);
 
-#ifdef CONFIG_SECURITY_SMACK_NETFILTER
 access_check:
-#endif
 
 #ifdef CONFIG_AUDIT
 	smk_ad_init_net(&ad, __func__, LSM_AUDIT_DATA_NET, &net);
@@ -4708,6 +4699,9 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
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
2.19.1

