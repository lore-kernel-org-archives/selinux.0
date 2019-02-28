Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAA9C10F00
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC9C20851
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="aiy9EhC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731967AbfB1WUe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:34 -0500
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:46564
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732266AbfB1WUc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392430; bh=EAfxIxB1ZvUzLgH0PH4QuaL8hGRSOCB+7KrFozqHypw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=aiy9EhC64PVjnA/yvwvLHORvgNxP8Ad+yPy3mJ8fxbr/JdvWH+Dy9mxB2FgXhg2XGzN0olduGsSkiiJbj41FGhBM3SMeV650DZ1qDk1PQHx5dP5FeL2Aub9wkdgycCaUuWz5DG5G5xxH+rBwHrXeAonmhC8O/bqkQ2D+MjCeq4xLfgdNRXSdOyycjM4ch1KCozXiiXgI5dZ5GY9Ot/r+YMsEC0is86amFOu9qxi9Po+glxfMqVFhrlwxHWW/b+44eHjNiUTuNExmdyUuMsIP0ilJbIzbCTSk4KhCgW2kKweYOHyH38finWejjrD190TfZXiHseB5abLIIHzzNOcCHg==
X-YMail-OSG: sFe2TPUVM1m8vic1V9bjXZ.sBSCRF.Besdk7AQqWp53nfPhzvCkkUJLuS7HbbYh
 vDeWwm1kvrvuK98zEUJ.97khEYez2Pc_ZYZzwMMS1jC.aXczy.dn5R9.vZ9edTlksC2DUSkIKx6b
 yo7U3LYPx5y2VeycTgUj8FAuRloY9Gfad3wKji3wxUgm9j_mDZWoH6dwLp6aEQYh7arL7RUu2HE.
 nvrq.AW6X.ZjD.jSsOFkLTIXrXgQfYqe9YrMIGFmvuraOSelQ0lHlyMWvvmJVXtjOo36RdXS_DXe
 jn0w7W21LJA79Eajzwhrp9u6_Hlm5k5j3bvpjyxDrhWzSA.PVtg5ffdNE5TRc454rZ3b3KQWVfYy
 uASE8JslFsLsml6AoKGalLFx5YzS8IxaCLAQgXHqhY.3DGPdkjzvSjwmWy77ttc24aCXI5mMGMNP
 4S6JcjWiFVjk.TKK8QZDNZm1sTIDIrWDOKjD4SnBC4jdVrjflf1AuSP3BivA.OPPkXXnnD9AUAnS
 mJnUYD_34moqsWs_iUkCTzy1h7BUQZq25USgqJYpkk.Hfe5CphM99j39FShuoCKTvgOlzjpP_7gs
 aOExTqsV_.487SptbNQhTi0J9ZE_Pq44CEzFnivz_kOWR2u.IfcWxl2ZpvQydGTsLfiU0XYYUl61
 MHbmcOlMzs.QwVwaSiXKQws1BCwDX3VPry6GQVX.TrAW4W275GyrBzBinMZJ2._RGGlA28evb_7l
 Mt5AhJC1MqrVnDK0pgcMdX0MgZq7hZ5uAvB04JKt0PUupeLfO6Wv1olZJibXWiwx.R0q3OFQittR
 ._v5ZGR553181rizHKwTCtqV9huPjmSTyDlMTZ7OEm.N_US0RtMsgyUwnV3m9B0KGVw0SlKw7C2L
 RpXnVCseN42WT4qgCXa1bn0BbYL4hcgT274S2EM.esnEKnVeQACvlZTS61eV75uGGiSTxWRPRqWT
 5XpRo.OpaK7ivH2cIUAGwxzKSQ8brFiqvCCMjLQafvw3QQHT4g0oJfKcEEIvbjivLAsub0zUmH7s
 bvrKBLqRfMWQ5Ftf4d7yFMpqgujOCMoYHFgVytNnhsF6Wpwwqx.167jU88bB_OWl__MsZ5bVgY93
 fG1M.nU40F3_9PYJ.2LJZHy10Pyjer3GQvqjFIhsYiG1EtTk-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:30 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp421.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d90148b291d74b44c78573c559ceeae0;
          Thu, 28 Feb 2019 22:20:26 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 69/97] Smack: Consolidate secmark conversions
Date:   Thu, 28 Feb 2019 14:19:05 -0800
Message-Id: <20190228221933.2551-70-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a helper function smack_from_skb() that does all the checks
required and maps a valid secmark to a smack_known structure.
Replace the direct use of the secmark in surrounding code.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack_lsm.c | 39 ++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index d3ec5f49ef44..7b8ad16c09e0 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3734,6 +3734,20 @@ static int smk_skb_to_addr_ipv6(struct sk_buff *skb, struct sockaddr_in6 *sip)
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
+	if (skb == NULL || skb->secmark == 0)
+		return NULL;
+
+	return smack_from_secid(skb->secmark);
+}
+
 /**
  * smack_socket_sock_rcv_skb - Smack packet delivery access check
  * @sk: socket
@@ -3768,10 +3782,9 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		 * If there is no secmark fall back to CIPSO.
 		 * The secmark is assumed to reflect policy better.
 		 */
-		if (skb && skb->secmark != 0) {
-			skp = smack_from_secid(skb->secmark);
+		skp = smack_from_skb(skb);
+		if (skp)
 			goto access_check;
-		}
 #endif /* CONFIG_SECURITY_SMACK_NETFILTER */
 		/*
 		 * Translate what netlabel gave us.
@@ -3814,9 +3827,8 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
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
@@ -3917,9 +3929,11 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 		break;
 	case PF_INET:
 #ifdef CONFIG_SECURITY_SMACK_NETFILTER
-		s = skb->secmark;
-		if (s != 0)
+		skp = smack_from_skb(skb);
+		if (skp) {
+			s = skp->smk_secid;
 			break;
+		}
 #endif
 		/*
 		 * Translate what netlabel gave us.
@@ -3936,7 +3950,9 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
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
@@ -4014,10 +4030,9 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 	 * If there is no secmark fall back to CIPSO.
 	 * The secmark is assumed to reflect policy better.
 	 */
-	if (skb && skb->secmark != 0) {
-		skp = smack_from_secid(skb->secmark);
+	skp = smack_from_skb(skb);
+	if (skp)
 		goto access_check;
-	}
 #endif /* CONFIG_SECURITY_SMACK_NETFILTER */
 
 	netlbl_secattr_init(&secattr);
-- 
2.17.0

