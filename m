Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286F5C282E0
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9FA421736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="F49mIX/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfDSAsq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:48:46 -0400
Received: from sonic310-23.consmr.mail.bf2.yahoo.com ([74.6.135.197]:41621
        "EHLO sonic310-23.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727003AbfDSAsq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634924; bh=vf/aL6n6NKaDhEgvGBqKFINI51OYLza2qYfAZZQENPo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=F49mIX/KrQ2E0/HTdASxZscGbNnL5SE3WPm3rMLMBZEBPQrzrRG7PKSa8M0/ZIcQSElkFmAddzY4NvVZEvaCt5gtlGQekkod8Jqowz8RBkk11RxgBXUzhuBt6iOOiBjBF/CCAnqdR9nts10wok2RvD4+59SuLcLjQWw4klYjg2azYTmCLDg5TUEvqAeihixdrsuFh8oDjYgviOEekyAm4d5MhpGb1p1QGjf0e6uhxp+fcpe+NoqxWFli81WDyvzdVSoLOqEje2WvBaZaz85OSd3IL+xL9An4Ejuxo/IpfTljq/JIJkIMz5CGr/0U+Dlp6EysZoAPocbYZUjjqzdkxA==
X-YMail-OSG: 59TOLCkVM1l95IFCeTnF0VwwVEzxzkYlrbEoaLdqnGLy3Y3eXsHowYtQjI3s_rc
 Qm22ZybwDU4ZCr5CRGWjmBTCcHmDrne7EP.R_Pc5oxVTWk3NPRs3QZ3_RorZaMgLfeebM7SYDdxw
 ikWGRGslXpI6HzsCvKzq_VkeZ909T2A4rsTJT0ke_baeyFVvOMpAvdoEqiSvGqF_LyF66c3f4aEl
 xvl1ZgSi13Lwef1PWMGbYE_RDzk85KnzsmZF19t_LoT4OCLjEpiLiR5NKpoLBUZ2BbmiZ3ZuBrOi
 5TUwORuheQ37MGzWmfDrHrqMihq9J5NNuuvH4QIEvIwCMc7a6G4ATrUGlTUVUQ3u7YJW0..yfYjS
 AjiIwj1QX2vUw3Zpsp973BY.i2UkdqMw3gcs0Qxff5hbLIH.1_QrFI_RUvbX4AFcVwcstK1cGywV
 eztyIczSRhdKApptzIVqD8Rk4F7Mhm50GGNPlPRlSgRoLGnkYGXGdASa9i8FlgF9WBIEt4P0gef3
 tTfZVkh9yylKJjOsYdjepcloXJGpanDKVZ72740QmyRAmY_LrQTrSOCNq05XbEx9vqKgELyuzaUe
 wP65VBv_IFUJh4OEG3kVBESTEoNwHT8A9oB9Klq24_G.BDjsa33VDTEIy27_h6j8I58l.Q4qKhYN
 eAOw5tpjpSTjfM3euid0eAzYNA7XtnMxtl803QvsChbN7qfEe0yNP.b1tBrffx35lnr83Qm93Y_0
 mPFDIm0nLgmVXBe1reucSRHSkrJfxX9yfjhdtFE.YOoAboefCUw5LF3WCxkME3OhCRE.JF4m..38
 CzZQM0DgrAHsgdhZVqcG8xek1Dv.DCr.HZKjdOQm9s.JlaO73rAzixDsssN2jWSP_wDxjFZbKQhr
 Ezyi5e7ESgf6pJIngj4Z.vTS7OtTf3Era6rRB5bk4xsM0UCvUEGQXh439.IfaQzVYmtIIJtd1b91
 Jb8mdXObfWqpaY240RROs7QnX_2j7GeIQAa4U9wPVoyy6E2bUm5lFNaMrfTY_oKbLuMfTuGxL7QI
 Lpyx_89oz0Yed0FxWfZ28rgv5qef9kQyao4n4xmJr7UJwy9ShUNUqAZIc1UtDZ5tuLm4X2PDDWmM
 _QklKDk5kw8FZii3awQWkuUvCbXIcSI0Zg1C3F375KR0jMVH899dnGOKzaHjEuanZ8075.cq2_7N
 58vYHHDArpuod
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:48:44 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp415.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 33cedab91c06b09a1d8646eb41267569;
          Fri, 19 Apr 2019 00:48:44 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 63/90] Smack: Consolidate secmark conversions
Date:   Thu, 18 Apr 2019 17:45:50 -0700
Message-Id: <20190419004617.64627-64-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
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
index 4570e8cac1b3..aaca4ba53032 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3820,6 +3820,20 @@ static int smk_skb_to_addr_ipv6(struct sk_buff *skb, struct sockaddr_in6 *sip)
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
@@ -3854,10 +3868,9 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
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
@@ -3900,9 +3913,8 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
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
@@ -4003,9 +4015,11 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
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
@@ -4022,7 +4036,9 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
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
@@ -4100,10 +4116,9 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
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
2.19.1

