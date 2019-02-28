Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34356C10F00
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F208E2184A
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="sdLS9Wf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbfB1WT7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:19:59 -0500
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:42221
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729553AbfB1WT4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:19:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392395; bh=8NmaL5a1XnUMjYedgHA6bQKVWhgyUWwPBtryWzYLXS8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=sdLS9Wf4EOYfAEz79ycBbP//2N33dIPnHNxdmGQNTga6066nRQHD2zFGEDltC77x9mDCd+RE96lh87NyIHKMX+tQRYMgkY+AjMPsMuFUN//7qpBdcmka9sWIsGz/nAiy6DQRFql0jVIJrjVvWzZW445acsdiD4985NGjZO31HfNfxfcUL8Get9sfqq+/jDcXoiIwhsG7KjGLrELZbEnjER0MaUgm9i0bxTglapMVcqtzH7mLxLbLvHwE/mHBTz9hqc8SENa0fmkJiol0bs3GUdZ4R0RHpvkPtJMrUFr9KfB019F+t/oe379gFWi3/4XrxRjDfOGUE1GMKFUmC9Vo6g==
X-YMail-OSG: bSuJGTQVM1kxty_9ViagayuWi8jpUfvCNSS1kVJefqrP06gbMoYMZg5leC2.56z
 9dM86QmVtfNfYnjc_l.IkyYNUQCXSR.8MWqCIQM3Ypyuh9o9Il35f4QRDk1.paJZEGT7rcAut_V6
 XdaMZUUR4nuKXr5p1YC1_Sa44PFh_7a0wPry4x_0ewvCtCxp96pidH6xR1Sxpeuxuv4JENFNBr_E
 EQ0puaiO073g7hMGxzbQRLalXkX30xaEQlh9OXGA3ESvwEhUZvwJDbwj56JkiEBk9kovWoMAy7Y3
 sWMeXmMy5c7ReIrPW9GTB1W8AqtCycDnMZF8Omv2MN2dzyxLHB3G.3YqFFLcmzC5rw.S0xgJfruk
 lSQnKtA.CLVTZ.CvjFznR7hnCyaWDQXh6dzL6P0.kVZ6f7Mw9UgV91IVeX6e26YPaqf90IMR7Hxy
 5Yj4EcPZmATaP1t7QWg155vZ4Na8aGbfUUXw7rLeZiSjpSMWFjEJtVpvvRZ2shTwpwg_AUTRIFCq
 YKYAqKKMpK4szJdMK6gbdkUyO.wa4W_8E.f8lNw5eVpck1cCTFeDr8QNRlqPwW.SA.pfL6YiPYjI
 u9J3C1wPwtCtElTkms4Bqc646_RcAEbdHJQIyR_bN8jYot8YJ4m7RCn22g58soha54JHAcHoySjs
 mAlS2y5bIgvFSc.flEiUwhSEKYkMqFoogAQwZnlRBW.Syl9gEeBehkgP9yMp4GPH9fQWkjwSyANg
 z2ZBCPNo8FWoy.LgvFBq9HYZ9xy.tz3Xt0Jr.rXdro6Dr1gThPnKfpsK05iboo8FIHw7bG4klBTu
 CRJG844UxCnKbul3wu0Co9RXFCp8il5EA5scbw0JpOZKuIz6J8TvK_pyyXbm658SxhU0pcaC4UlV
 D1jHlJ4xDcmypDQu7gVxHXxR6jaSuMCnU0B.RyC5BTyCURW9OaeqipoM4vAnq5A9KJuRuTUCBvM9
 38nKEI5x62.u8MUi0f8wUePo4qZtHFQsxyes4ZrLJiKI.GJyslHI3CmOPn6SjUfEKtEv1.iE_wEm
 hClNlzOJ_s9NXqTKvvtz7chXQWYV3G9dubauqpfzu2hYk0cO2ox0EUTMjeWeuu1dH.zPIRu2mGlE
 8JdCshbPycdWRtwCW.5y8_v3.j0MKjyyN_.Op9OGBMgiQMw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:19:55 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp427.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0da9962b364e649f4905df2b440bd211;
          Thu, 28 Feb 2019 22:19:50 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 12/97] LSM: Use lsm_export in the getpeersec_dgram hooks
Date:   Thu, 28 Feb 2019 14:18:08 -0800
Message-Id: <20190228221933.2551-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert the getpeersec_dgram hooks to use the lsm_export
structure instead of a u32 secid. There is some scaffolding
involved that will be removed when security_getpeersec_dgram()
is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  |  7 ++++---
 security/apparmor/lsm.c    |  3 ++-
 security/security.c        | 13 ++++++++++---
 security/selinux/hooks.c   |  6 ++++--
 security/smack/smack_lsm.c |  5 +++--
 5 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 796eb441be95..d4f260812c20 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -865,9 +865,9 @@
  *	the IP_PASSSEC option via getsockopt.  It can then retrieve the
  *	security state returned by this hook for a packet via the SCM_SECURITY
  *	ancillary message type.
+ *	@sock is the socket
  *	@skb is the skbuff for the packet being queried
- *	@secdata is a pointer to a buffer in which to copy the security data
- *	@seclen is the maximum length for @secdata
+ *	@l is a pointer to a buffer in which to copy the security data
  *	Return 0 on success, error on failure.
  * @sk_alloc_security:
  *	Allocate and attach a security structure to the sk->sk_security field,
@@ -1692,7 +1692,8 @@ union security_list_options {
 					char __user *optval,
 					int __user *optlen, unsigned len);
 	int (*socket_getpeersec_dgram)(struct socket *sock,
-					struct sk_buff *skb, u32 *secid);
+					struct sk_buff *skb,
+					struct lsm_export *l);
 	int (*sk_alloc_security)(struct sock *sk, int family, gfp_t priority);
 	void (*sk_free_security)(struct sock *sk);
 	void (*sk_clone_security)(const struct sock *sk, struct sock *newsk);
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 377fa4ed1518..0f8e671df5fe 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1096,7 +1096,8 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
  * Sets the netlabel socket state on sk from parent
  */
 static int apparmor_socket_getpeersec_dgram(struct socket *sock,
-					    struct sk_buff *skb, u32 *secid)
+					    struct sk_buff *skb,
+					    struct lsm_export *l)
 
 {
 	/* TODO: requires secid support */
diff --git a/security/security.c b/security/security.c
index 1a29fe08a5d9..bbb206b01e8e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2131,10 +2131,17 @@ int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				optval, optlen, len);
 }
 
-int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
+int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
+				     u32 *secid)
 {
-	return call_int_hook(socket_getpeersec_dgram, -ENOPROTOOPT, sock,
-			     skb, secid);
+	int rc;
+	struct lsm_export data = { .flags = LSM_EXPORT_NONE };
+
+	rc = call_int_hook(socket_getpeersec_dgram, -ENOPROTOOPT, sock, skb,
+			   &data);
+
+	lsm_export_secid(&data, secid);
+	return rc;
 }
 EXPORT_SYMBOL(security_socket_getpeersec_dgram);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index efcd905bdabf..1004aa4fc5db 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4845,7 +4845,9 @@ static int selinux_socket_getpeersec_stream(struct socket *sock,
 	return err;
 }
 
-static int selinux_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
+static int selinux_socket_getpeersec_dgram(struct socket *sock,
+					   struct sk_buff *skb,
+					   struct lsm_export *l)
 {
 	u32 peer_secid = SECSID_NULL;
 	u16 family;
@@ -4867,7 +4869,7 @@ static int selinux_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *
 		selinux_skb_peerlbl_sid(skb, family, &peer_secid);
 
 out:
-	*secid = peer_secid;
+	selinux_export_secid(l, peer_secid);
 	if (peer_secid == SECSID_NULL)
 		return -EINVAL;
 	return 0;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 0e1f6ef25eb2..0bed974b833b 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3887,7 +3887,8 @@ static int smack_socket_getpeersec_stream(struct socket *sock,
  * Sets the netlabel socket state on sk from parent
  */
 static int smack_socket_getpeersec_dgram(struct socket *sock,
-					 struct sk_buff *skb, u32 *secid)
+					 struct sk_buff *skb,
+					 struct lsm_export *l)
 
 {
 	struct netlbl_lsm_secattr secattr;
@@ -3938,7 +3939,7 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 #endif
 		break;
 	}
-	*secid = s;
+	smack_export_secid(l, s);
 	if (s == 0)
 		return -EINVAL;
 	return 0;
-- 
2.17.0

