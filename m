Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8611FC282DD
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5503D21736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DY6H6tWJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfDSAqq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:46:46 -0400
Received: from sonic310-23.consmr.mail.bf2.yahoo.com ([74.6.135.197]:39471
        "EHLO sonic310-23.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726707AbfDSAqp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634804; bh=FXPJ6Gfz/Kw1RJDXF2OhaTmACwfJr6C43ZPwo4T1SLA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=DY6H6tWJi32/Zxqs4mDtx4ofGeHrpRDbgw8FH6PJ2UjV0CoblZwIDvEhGsGY4YNgCj96k8wPmPYzvE4rJzPggttLmiKhARGJTApOp5hRJV4VzDVyv4EB5UMyI/ofQPeXcr693fanuMJ8tKsUYEjlebUfvY4XMbWziC3LYBzF98udSKhNL37AZAEVQJrhU7P7mFq8OzWNIdlE7LCWQfSiZrlXLKNzbLV9y39xU9krgZVa2g4vfFoc5SnD5MH66ZSiHVPPGZ0sK4yXTRCyL8+TglYgtguG7W/nB8iHonW7nkBlqAPVHM/KCJjtJGkrQay0wprSaLiKD5RD/tNuhxcsxA==
X-YMail-OSG: dWrFt4sVM1lgLrUOfrMI8JSDvZkFYVKiFOmWeJTOoP3V_UthczmMByNsafmujR0
 JnFueQ_PoBwFYYHzY0fLDl9ieANcS.Re5mHDYRxFJORzIHtEyRb9jjdJZdKvPzR0G6TqMyUq3Occ
 9evappFp7uDDKxIjD1yxnM4toGqZ6h9KwJ.gJKU0is6GwWMM3OrBCGlDydLDw7HIfvhs0WPBxT5g
 3464frQiMQVRLDjDV3e4zZS1NvxMMrsBJGiUmxSZnaRxA.VCp01aEg7cLPMQYdiQfeRcbXoj.BP5
 kqQSwv9TxdKj4vlf1MBzw1zfgCzi.OEHvy7DQbZAqRViou5R_OHHCB_9LFyJKZMmXMkU4SRotZbs
 NSNehWrF31lKCodgvDL6m.clz5zd05fT3foU7a7ZYJ7FPdkvVQYROZlwPUGKasAREH6.kH9CVTbt
 zz9Vm0C37AZUX3vhCacX.JtffOklryGjOaaV7ABR8grWHx8PL8SZbiAyqnyYcgMbiZPHA.HUX.zP
 8woIR4CV0R7z_3hbk_YP5ZP_GQU.T8YQrDZIYa1lwhgI4pJcFXVDLjkHzpv9gM1kkI_ntUmJENM5
 TZBGqHL4sX0D7JFFufUnQWqZK1SgSN8eKOb9PoQEZIngY9jy83DzDOBfbFVC4MMpxFm60TcR3XuQ
 CxQb2cEr7mlM0WG1CHL50poggNaxTvtznS.HGhQQ7RbN.mlWorR642SlP6_vFqd50W_Ky0D.VDns
 FxDd3mVXkTX2UQoQGo632tOuujQBA9b0YOw01gpSoyGIX01jAbJkxSU._M1lF0._4gQyhpJ9xx36
 GvwAyEyuasqt63EXQjpksSQqkjjiODW7W7DPAsTfJD4xQKKOsiLUR00ZkgzaC.4j0nfJcMNC_fWz
 yCjbywT.Qj8Q4F8NEu28FRGiV4MWEOcYYGUrwWIa5T8g2yWmC_wq.RLDIPFpyRLoz.6MNfbkxeAq
 ml.jGssZZcCsuIngZVldazQ0nK_XF9Bkj2KOLSg3DhK4E9tF5VTWos.UWFxeRKP2_Z88TGli4tET
 Sd8J0RAXx5tn3obSyW2tzNfk1API0ozor0t0WVs3HE3Zxy6mcBYwF3.ukZAYuQt6k5D0Y3ElrIVF
 tKE.f_il5QdGAvbN5lkCH8D9_RHjSLfq_bjFJuu2y7H_awjCYMZWmdkt0KT2pESs-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:46:44 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp416.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 832c03259c9605aacd6ad56a0995a740;
          Fri, 19 Apr 2019 00:46:40 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 09/90] LSM: Use lsm_export in the getpeersec_dgram hooks
Date:   Thu, 18 Apr 2019 17:44:56 -0700
Message-Id: <20190419004617.64627-10-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
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
index 85b8217ce2f2..59f38c18426a 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -881,9 +881,9 @@
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
@@ -1710,7 +1710,8 @@ union security_list_options {
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
index 8d4334f68a65..03dfa0cd6739 100644
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
index da85d607d40a..5318b9e6820a 100644
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

