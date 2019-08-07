Return-Path: <SRS0=LK0T=WD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392D2C32754
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 22:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0355F21743
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 22:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="eAvN4Fkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389412AbfHGWm6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Aug 2019 18:42:58 -0400
Received: from sonic310-23.consmr.mail.bf2.yahoo.com ([74.6.135.197]:34750
        "EHLO sonic310-23.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389109AbfHGWm6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Aug 2019 18:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565217776; bh=MlDHtrNND4LR/EHOiuM3r7rqviYCW16Nt8FVPqFyU+I=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=eAvN4Fkrxa+33cHC3+wsBl+bc7RZGIu+8fIUWAQyOwVhvjhatfwzMXpYYB0hdNt6GHE4h/W3QNpRNJi2++8ukSIEONNlVqJwmqUPETElMB/Gh9Ll2O1qTzx7LAshYd5PXNX5p1lP3b1gZ+UpuL75rr+T85XVO2Ge7UzflPdCe8Vhsn7n6PsTfUtmu30e3rai1TIdB+/mcFEfIX+R6jRxX5OcdylGfhOfwQtaJel9l3wHGY9MdymsmWdMtEli+WlIB/rI31DYnMBbsSPFMCFJEf1nghAbvOjcOqRZsOPzqZ+VAAquzOwehiI5kBM42TgzOkRmi8JcDBLrh4sTKB2WkA==
X-YMail-OSG: Mnijg5QVM1lHv8KkzqTmj7zSTKhg7Vyco8aCQxTRsl7blq.7XNUBEDU5pi1rRAk
 PnTLtSlwn_J7oDk20NoGZddtrp0_kvRmX697R8W_0OaFH6NCfbf1Wm73xEU4kKgTGKqJAayvp7yS
 Nfv1ze_R.6sXOMioGSOm2024GMRzjy72k83nl4uFFkGv7Is_0n8KQuTdVcGvR6RrYwzdUiTej06i
 q2hPazt3SnBzHWtwn5UZwxEofQ0S2yTYTNTaJ1MX1pJNMcIF7nf5NnRe.fcohIALWMUQxtaTfliy
 kaplJ9.K09JVhq43c.tcOYNHL0aGU.YnJ8EIXag_nyw4FkeJyFZ1ws4Hw6.bpc1zd.eW90lkq.pi
 ssswME9uqS_Gqlda17PvlJ2LTTdcBvZBPWPD.2OncyrrqgEokyee7IkybEWy3SMMYtCd7qagnQQ5
 I_e2ryiY4crXf99Ww11QvuSV5GJ.WHryK4XzHnDcrmK6ntYts7xAfQZC8UAce59SmubdIi7QA99E
 SuVTO..2Umh_ls33r7mSQ9u6XijbyOs.K4tu8WpEJ.LkokXYIqbbgezYqmkDsPpogwnSXXcHAaMe
 OxbABCuuDNOrXWSXR38MeKeGFK1GIuWuRx9KLFRhnLlYd438dn6Nc1gXINWjAwWcYeaGeBK0zR04
 Gz8iy43hQUHdUG2kHhzM3GGGdvGZS8QOI_mHR9IlE.k2nuconDOps89O48nUj6KXI7ggaErtAXCa
 c_mOQTEHvVFjMar8SuhFP8VtPMZJKVCf7FFPL1uKJ2yXShWGYBo_X3RKQNTg_eUJ95JTEHqc_iRx
 skyFcXLCTs157Q7qli8PGGjnkv614Ck8Md2P5Ck212PF1Fmp1A7b7CBFQc900wu2PxXP77VTtaQC
 _a8yz.TwRAvoo0oOcfoqpQMblkK9BYXKij4H7KEcxb.KoSJPKOJtatqr3Q8g5_CheTHrj8I4qxcJ
 Zz61bBM.p8yeHxg_M9OGvojXIuZpQLr.1eOPJXmHTAT4xvYiFz1reRVbHgGmleERuxwhZPp4g2lP
 SxVgjve9LX_Xw.MW7S94LwV3pEnmpGruVdZb8VGP3w0_Q8WYT9T2jPf1X_jRVYxZx_vLh_l16G7X
 RC2NDoQ3lfFzWob3YpeUrkAyTCXJf8jb0bea1FY_kPb65zt991TxxnxGw3BldxbhuoqynzUBnF69
 J.Mb0p3D.sKFyZw9x9X4o8ZFS4bv8K4kujQurg.IP3p7pG1eP0d9Fw2zL4gEfol6zCD_a.tWp.BZ
 zshTZBWVD5WeMEriOWNWn_vQHXQaTg0TH4Hm8Z.Ci_GNyu.hQDrFERvHKkQw-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Wed, 7 Aug 2019 22:42:56 +0000
Received: by smtp429.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 824faaf1f4a5ffbf9b87c6192a4b2124;
          Wed, 07 Aug 2019 22:42:53 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v7 02/16] Smack: Detect if secmarks can be safely used
Date:   Wed,  7 Aug 2019 15:42:31 -0700
Message-Id: <20190807224245.10798-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807224245.10798-1-casey@schaufler-ca.com>
References: <20190807224245.10798-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 security/smack/smack.h           | 16 ++++++++++
 security/smack/smack_lsm.c       | 54 +++++++++++++++++++-------------
 security/smack/smack_netfilter.c | 39 +++++++++++++++++++++--
 3 files changed, 85 insertions(+), 24 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index 039bf5de56b4..f28db5a42b7b 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -545,4 +545,20 @@ static inline void smk_ad_setfield_u_net_sk(struct smk_audit_info *a,
 }
 #endif
 
+#ifdef CONFIG_SECURITY_SMACK_NETFILTER
+extern bool smack_use_secmark;
+void smack_secmark_refcount_inc(void);
+void smack_secmark_refcount_dec(void);
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
index 40c75205a914..341a9927ed5c 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3801,6 +3801,20 @@ static int smk_skb_to_addr_ipv6(struct sk_buff *skb, struct sockaddr_in6 *sip)
 }
 #endif /* CONFIG_IPV6 */
 
+/**
+ * smack_from_skb - Smack data from the secmark in an skb
+ * @skb: packet
+ *
+ * Returns smack_known of the secmark or NULL if that won't work.
+ */
+static struct smack_known *smack_from_skb(struct sk_buff *skb)
+{
+	if (skb == NULL || skb->secmark == 0 || !smk_use_secmark())
+		return NULL;
+
+	return smack_from_secid(skb->secmark);
+}
+
 /**
  * smack_socket_sock_rcv_skb - Smack packet delivery access check
  * @sk: socket
@@ -3829,17 +3843,14 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 
 	switch (family) {
 	case PF_INET:
-#ifdef CONFIG_SECURITY_SMACK_NETFILTER
 		/*
 		 * If there is a secmark use it rather than the CIPSO label.
 		 * If there is no secmark fall back to CIPSO.
 		 * The secmark is assumed to reflect policy better.
 		 */
-		if (skb && skb->secmark != 0) {
-			skp = smack_from_secid(skb->secmark);
+		skp = smack_from_skb(skb);
+		if (skp)
 			goto access_check;
-		}
-#endif /* CONFIG_SECURITY_SMACK_NETFILTER */
 		/*
 		 * Translate what netlabel gave us.
 		 */
@@ -3853,9 +3864,8 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 
 		netlbl_secattr_destroy(&secattr);
 
-#ifdef CONFIG_SECURITY_SMACK_NETFILTER
 access_check:
-#endif
+
 #ifdef CONFIG_AUDIT
 		smk_ad_init_net(&ad, __func__, LSM_AUDIT_DATA_NET, &net);
 		ad.a.u.net->family = family;
@@ -3881,9 +3891,8 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		    proto != IPPROTO_TCP && proto != IPPROTO_DCCP)
 			break;
 #ifdef SMACK_IPV6_SECMARK_LABELING
-		if (skb && skb->secmark != 0)
-			skp = smack_from_secid(skb->secmark);
-		else
+		skp = smack_from_skb(skb);
+		if (skp == NULL)
 			skp = smack_ipv6host_label(&sadd);
 		if (skp == NULL)
 			skp = smack_net_ambient;
@@ -3983,11 +3992,11 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 		s = ssp->smk_out->smk_secid;
 		break;
 	case PF_INET:
-#ifdef CONFIG_SECURITY_SMACK_NETFILTER
-		s = skb->secmark;
-		if (s != 0)
+		skp = smack_from_skb(skb);
+		if (skp) {
+			s = skp->smk_secid;
 			break;
-#endif
+		}
 		/*
 		 * Translate what netlabel gave us.
 		 */
@@ -4003,7 +4012,9 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 		break;
 	case PF_INET6:
 #ifdef SMACK_IPV6_SECMARK_LABELING
-		s = skb->secmark;
+		skp = smack_from_skb(skb);
+		if (skp)
+			s = skp->smk_secid;
 #endif
 		break;
 	}
@@ -4075,17 +4086,14 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 	}
 #endif /* CONFIG_IPV6 */
 
-#ifdef CONFIG_SECURITY_SMACK_NETFILTER
 	/*
 	 * If there is a secmark use it rather than the CIPSO label.
 	 * If there is no secmark fall back to CIPSO.
 	 * The secmark is assumed to reflect policy better.
 	 */
-	if (skb && skb->secmark != 0) {
-		skp = smack_from_secid(skb->secmark);
+	skp = smack_from_skb(skb);
+	if (skp)
 		goto access_check;
-	}
-#endif /* CONFIG_SECURITY_SMACK_NETFILTER */
 
 	netlbl_secattr_init(&secattr);
 	rc = netlbl_skbuff_getattr(skb, family, &secattr);
@@ -4095,9 +4103,7 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 		skp = &smack_known_huh;
 	netlbl_secattr_destroy(&secattr);
 
-#ifdef CONFIG_SECURITY_SMACK_NETFILTER
 access_check:
-#endif
 
 #ifdef CONFIG_AUDIT
 	smk_ad_init_net(&ad, __func__, LSM_AUDIT_DATA_NET, &net);
@@ -4673,6 +4679,10 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sk_alloc_security, smack_sk_alloc_security),
 #ifdef SMACK_IPV6_PORT_LABELING
 	LSM_HOOK_INIT(sk_free_security, smack_sk_free_security),
+#endif
+#ifdef CONFIG_SECURITY_SMACK_NETFILTER
+	LSM_HOOK_INIT(secmark_refcount_inc, smack_secmark_refcount_inc),
+	LSM_HOOK_INIT(secmark_refcount_dec, smack_secmark_refcount_dec),
 #endif
 	LSM_HOOK_INIT(sock_graft, smack_sock_graft),
 	LSM_HOOK_INIT(inet_conn_request, smack_inet_conn_request),
diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
index 701a1cc1bdcc..7b9c8d5d8408 100644
--- a/security/smack/smack_netfilter.c
+++ b/security/smack/smack_netfilter.c
@@ -21,6 +21,29 @@
 #include <net/net_namespace.h>
 #include "smack.h"
 
+bool smack_use_secmark;
+static bool smack_checked_secmark;
+
+/**
+ * smack_secmark_refcount_inc - Seize the secmark
+ *
+ * Note to the rest of the Smack code that secmarks may be used.
+ */
+void smack_secmark_refcount_inc(void)
+{
+	smack_use_secmark = true;
+	pr_info("Smack: Using network secmarks.\n");
+}
+
+/**
+ * smack_secmark_refcount_dec - Do nothing about the secmark
+ *
+ * Matches the incrementing function, but does nothing.
+ */
+void smack_secmark_refcount_dec(void)
+{
+}
+
 #if IS_ENABLED(CONFIG_IPV6)
 
 static unsigned int smack_ipv6_output(void *priv,
@@ -31,7 +54,13 @@ static unsigned int smack_ipv6_output(void *priv,
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
@@ -49,7 +78,13 @@ static unsigned int smack_ipv4_output(void *priv,
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
2.20.1

