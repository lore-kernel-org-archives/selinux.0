Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9E3C04AB6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B03025725
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="V1ShR1Lo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfEaXc5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:32:57 -0400
Received: from sonic310-28.consmr.mail.gq1.yahoo.com ([98.137.69.154]:33832
        "EHLO sonic310-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727014AbfEaXcy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559345573; bh=7nhZ/zEyM+j0a1Luk+r19dVtPBLiOzXmF2b9tX24TkE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=V1ShR1Loo8VXyO+Gx1pe0xudut24P9U4mknWeF8DsvhPMKlFW7Qw3xkRf3NyMhK5g16HuoWh+tfzkChpc7PQPz0LB6XLJQ30HAAOGDVvkk5T5pN5mmmQu5gKPKqW6sjhSKb1EmNk4ngfm+id2+kjnDP02c5e7o/BGNXpzu/9wt/ZuyrPUehRQy2z5nXKHUhcgijFqArRue0U5VQEXO064/8S2fIHGo4NPHSRU0XKxNA6wRwdgjOvwOH2VXTjsxOaEKn2h4Sz6rWDood00yeXGeqdkjF5E4oyjq7XzUqSH2F5TURh0fZlN2vOxEdXtGQXwARDwif0aISJ87dZDDDGZQ==
X-YMail-OSG: PpSUWlkVM1nYRWsiqE74u_mv7p9DAlutqeitxl3DqwDIMc9hm0mU8og4r.nssuC
 todeLVnhLrC9t7DNrKyWfeKA4YvwESj2_ofkuEIPe7C1zeWOR1XVLRxPBa05dQ96_3fyJ3NZnEZQ
 AzkP7d6q.PLOidwLme9DUbveBJL3TgKccwC_Vit2uMv8mjYFihJ0ltC390qd.Zug3xs3QdU3rX5T
 Wyl_MWIwX3KPdFwy55A69d1ojBdGD_.EQYc31LwvE3M.fZAYDQfFZ0pT08aCHpBf5CK_7EGJkBF1
 Q.ANZNdyZaVpJa_JMF.0ca3zDd4DNp91nXK2yQ9ymGzsHDql7gApBR4z9G3hzP29K5HDLIDPpUa4
 4b8Ufddd2JGW7bMb4sUcac.wtoGMgFAQgQV0MVqyCYzMljBEPmcSKEV4wUbV4aJnXVBFbf2wFXHz
 OSpogymI1AXiACw4sr5ib0SkcmiacfgxQ4u256uysJD6s2h8ntLNK_Z2EaLeHb9HVx.a314C30ME
 N8zczGeJUMQjJeZUdUDP80SOtruX1FUfdLIrHtm4ls6.YHoepuK9Rt2jsNuTWDDMYQnjaBp0ILnW
 mZpQEe2YoIy0Xl3gDYgJC_2q7XDVFTyMD4jckvoX23YBEH8LbflFm53gWyfL8wkr7AT1nrO6wa5w
 jlzYGLH_ErPhsp8tdx2dYoKReV.xp1jGB0Iy3krXLvsI2WoQfHivJ0KyZqhPK1yn57KNGsLyGVoB
 V.rKOuki4HANFnaW8N1hbIuj9Cb9pldskEbzQDFOxMu7OO7L6xzdA3ufCFNB0JcEbVx7GSGKUbzm
 q4mt3LUL9mY.l0U7xv7aJgcY.EARGAaj0o7xZ5bRV2EmVg4_u0K2NMbg.HCnAfBgCCB1XnggMe8Y
 m8Ipn0LJ2lG5_pHVq8vbVg0idw92hnrf76hqIOL8fRySl80F5pR1Bd_XMR.XA2Gpbj5JXiuu71UN
 kiB0u9wnrOqpYjhtzOwC1EMDg_pvF95gt90CUzjjx6Xsv8GpWksgR.0qFMYXkJhO5XipzGDwQhWf
 YE1sRfg_17RwwQdZuojvV_YA0N5.Ra4RV4gZ.11z9e2xfzf73USRnHv0ItknEclsjnKjEsPhk0WE
 EvqeitR8SzoGyS.Rikvoy4ozEpnyEmpnqxorIuyyHKh5AWhsnyHnmn7S1W6L7fSfOWKu7w4AHf4M
 Dp1mIrvLyA2xB05ah2w5igbVKun.iOlQ3Wes6BkXAGaf.IaOx7NA2HzdN.76fdQsXExTE2iZDfqb
 z.e3pSdJTXhjo03sIVI8DvoHCwEwYAP0MJOmB2Pv2ru86rkU1T9g3IQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Fri, 31 May 2019 23:32:53 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0aed19b0f4054920f56ab546d7f94096;
          Fri, 31 May 2019 23:32:52 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 09/58] LSM: Use lsm_export in the getpeersec_dgram hooks
Date:   Fri, 31 May 2019 16:31:00 -0700
Message-Id: <20190531233149.715-10-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531233149.715-1-casey@schaufler-ca.com>
References: <20190531233149.715-1-casey@schaufler-ca.com>
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

