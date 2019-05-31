Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516E5C04AB6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2208426FE4
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="lE25/+ES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfEaXLj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:11:39 -0400
Received: from sonic303-28.consmr.mail.ne1.yahoo.com ([66.163.188.154]:46514
        "EHLO sonic303-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726559AbfEaXLj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344297; bh=7nhZ/zEyM+j0a1Luk+r19dVtPBLiOzXmF2b9tX24TkE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=lE25/+ESflbyPs7v1QW+gumzf5/Pbdw84PrERPtg77LCycnaWpUrg5xbZ6s2EqEb9XXISki7MMiYtfSSU58Z01t60dntjDH6XqullAhHqtq8vHqlDCsgVDTlmP9KUZ3kvCXgswGxrgdxjMeQm6tVAtiYOl0MgyL3fhCu6M66WkrlIk1urwckOg++4Lv2sgXy9aKUgQ3jI9J1VAQvp1ZjXTIR9TgQ2tdIoq6aoorOvGd6i874It97ZGcRE3Nny1r0Iyu6G6/qLVd4DpznmmNfQjqBCyESiiRKq524HXjSP5ACW/ULnjDvdDBbEgvH+zK0zEHfDsanTt6+4PA6TTcu8Q==
X-YMail-OSG: EcN_cIYVM1nZts.dV2QMHMSIDBeLcLrpDFn9XDq3NJDfws8yn4.O9IdEfWOQBWS
 EoUJ_bKyxW1IZ8.V_5xeuqNkQ9NGnEtNjb0KgoVWSbigSh426AvpPck1o9QLtjzxlFayt3Pxt3XA
 tfDgg8t9Y.tmZo8Kc_dvi2KasJg0cciL5UwuY6VrLdRtfqcUlKotsUg7Dzc7IGSCkt4zaRBjaPEl
 810u5iRaLMizdAf1xrgrTSBEYD0ru_Vdt48lEStgkqMumWNb3zqU1pKEt3wgtTO33IlKSg..zZnE
 fOb7HYz32BTsUHXgrjZd0SXk_C4S4PavgOiggPnFBpQNqa8BrTKnG0yzORbKyze_1KJ6l8rEOCRi
 e_FL7AcMIiYOJkBlNIJNDfqhYtbbFT1VkAL8C89XZD_CSjYWE3mgJUm_efNgHijTa_0e8F2ufdLO
 MIrPs7j2zGHpHtyj0VZR_uLvEz10oitd2mTkJEJQF67UbrJNiFhlHCGlbpi9p6s_zAzzZ.dKF5zy
 MIC6521c37RWLQ3uPUefEYCEkz7lr9QoqVKajLhSa5_yEwoLCwf0KKD74EN_80Fpuc_iHx5AqR29
 QZbs5MO8OeWry3wjYuVNY7P72uOFRmsGiXwLs8cezrBl9LXw2pklPn5o2g_05gxDHzeidnGY_76I
 GIIOXR73oA_LfnV_rT.336AcS7GaXWNS38UasiznExLnHhObfFQD623feJ06rIakgjUkBmCgwrHZ
 E.6_LqdCdLEOdjsFy4Zd5wBlbEXO3eY2EmC.tMTHF0eH0k4C2uL1Ygf0mEO89QiMQKwsXXF1SuqV
 8iDhvGuBubzyzz6JXRyD1c6HMOH8wSdlgsTOV6FLEbGmFITA1BxF6gtfyTYdGabs6SXaNf_P7gfy
 aZp1EnthZh52ogJ5Dy3LHXuo8sL8YClPGK8Oll45yuo.6WYq4.Xeq0B1oTMXhJH.GuEGEElH10p4
 h_6TlJ_OQZnMuNW35JH_i26PaDBT1yu3h34p7JCLXY2WC5jWspsaK4eK9kkrTle0HSMWP09frrpu
 DceCAbDOVlqNxBR43.DzQbcG4CBy5cdxNzAofDN4SkqXe7hUt0mhqyZ7m3u0fOGpxiMJL5DB.cER
 .ovI7LPu0aNdW7vVqhfjPu4.YL4LziQ._0Qi1BOiGLsbvGc2QceviNctgb8dKS285VYxy6AmEmga
 YOyGDaKictOGL13FEj8XWVFK56kegO.yPqcxDGk6yI9SJO2gJXh1HANLfp.zyuN.vSGw48ylKl34
 nQg8XtgC2SxdSZzaBKe3MS3WtTchYklVXNffsyLzQxe7fQKWr99HTtA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Fri, 31 May 2019 23:11:37 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp415.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 3476acdfa7cd8f6c2fbf806b530ae11f;
          Fri, 31 May 2019 23:11:37 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 09/58] LSM: Use lsm_export in the getpeersec_dgram hooks
Date:   Fri, 31 May 2019 16:09:31 -0700
Message-Id: <20190531231020.628-10-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
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
 include/linux/lsm_hooks.h  |  5 +++--
 security/apparmor/lsm.c    |  3 ++-
 security/security.c        | 13 ++++++++++---
 security/selinux/hooks.c   |  6 ++++--
 security/smack/smack_lsm.c |  5 +++--
 5 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 800040050032..bcc628cffe6a 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -881,7 +881,7 @@
  *	ancillary message type.
  *	@sock contains the peer socket. May be NULL.
  *	@skb is the sk_buff for the packet being queried. May be NULL.
- *	@secid pointer to store the secid of the packet.
+ *	@l is a pointer to a buffer in which to copy the security data
  *	Return 0 on success, error on failure.
  * @sk_alloc_security:
  *	Allocate and attach a security structure to the sk->sk_security field,
@@ -1702,7 +1702,8 @@ union security_list_options {
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
index 706e5ae09170..24b638bd4305 100644
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
index 3a766755b722..2f1355d10e0d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2145,10 +2145,17 @@ int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
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
index b88a51b6ca41..9db12f6b1221 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4949,7 +4949,9 @@ static int selinux_socket_getpeersec_stream(struct socket *sock,
 	return err;
 }
 
-static int selinux_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
+static int selinux_socket_getpeersec_dgram(struct socket *sock,
+					   struct sk_buff *skb,
+					   struct lsm_export *l)
 {
 	u32 peer_secid = SECSID_NULL;
 	u16 family;
@@ -4971,7 +4973,7 @@ static int selinux_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *
 		selinux_skb_peerlbl_sid(skb, family, &peer_secid);
 
 out:
-	*secid = peer_secid;
+	selinux_export_secid(l, peer_secid);
 	if (peer_secid == SECSID_NULL)
 		return -EINVAL;
 	return 0;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 3b77a0324c3d..3e3724bbd6ea 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3973,7 +3973,8 @@ static int smack_socket_getpeersec_stream(struct socket *sock,
  * Sets the netlabel socket state on sk from parent
  */
 static int smack_socket_getpeersec_dgram(struct socket *sock,
-					 struct sk_buff *skb, u32 *secid)
+					 struct sk_buff *skb,
+					 struct lsm_export *l)
 
 {
 	struct netlbl_lsm_secattr secattr;
@@ -4024,7 +4025,7 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 #endif
 		break;
 	}
-	*secid = s;
+	smack_export_secid(l, s);
 	if (s == 0)
 		return -EINVAL;
 	return 0;
-- 
2.19.1

