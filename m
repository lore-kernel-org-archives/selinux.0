Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5C6C10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF91D2082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Tx4hvfSP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfDIVlt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:41:49 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:39037
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727115AbfDIVlr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846093; bh=FXPJ6Gfz/Kw1RJDXF2OhaTmACwfJr6C43ZPwo4T1SLA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Tx4hvfSPIN/elJ/3kye42/xYh1BNpYNmB25tdD99SCnUwhMFdAHr5mBZSLF+CHMcYaVXXXepP1nniOLq/KabyktXIgHFmfvNqBzLwt+dbZlTC9KV9iGPuHqDarZ0NVZ9OIqJBiX3lpXh1pEwqBWaa1L1Ah8vP1H8rebgUE11uWINBLzRQKNe/UQsllm06j/iw519HkAgzjSs4pebGm2rWwzwdzdqNhlSrt6/P88AMgpFEtu3wPnfta8WQPGbYzQ5GYLXzPYDnB4KAGo5pkcRKLVTv45AOdfovwLRIqPpfBq8CSsI/ArBJIPSqspdFUZ+VGv1ZbmFuDeAk+W4M73gug==
X-YMail-OSG: _VsKVtoVM1kZKaN3MoQK6Icl.2EQRj3CewU1qPgs_EA7kVmXP9b_4wO8duUE2kd
 6L_O7eFOy8KLimBqQf_JbsbpQfkn6KR5HmJLNFBSzgzYGz4kCTAZjYeMy8AfaV7biM.F64IRJdBz
 hPnmgbL1lAOfXi7jXskhf4vDO6ynqVLg_o1YDY.VIh2557z0tXZbEP7Z4a7SLWL_Am1C9IBYgPAR
 d3WyG74elQD_4xiBbhFE.36BkDw.o.LQoQ0Ov5mddhUA2C.dwORavs1dOHy_wEa9tfPM40nHP97J
 W3Y_IJjEyYynxFDC6AsjNjxQC2aCPa76WaEG664gIBcx1t5xK_NyP2ultRK6PG8Dle1KZfwOztIL
 ewVnHZSFB2kTl_Nd0u0kXG1LuMMIfB4zdmrGbxjd0av9jtvnWRxkPC3x3daFxjDebYUeP7LlulS6
 L0H2IAYUnW4drejIGbM74lgHaWwrUQa_bjtV1EywMqqE.sWdfJJRvpRcoKwpjP6XAmuTMhR4eyKj
 qP76hLgWYFmSU45zOSaQYAdMK3nvOr4gQCeeeY6v9BHS6g9Upix744vc9OK9r113JquIQfntpC3b
 mgqz5OaC.MX2MVznBmnYF1JJppxJMTHejzUEPyNztexz2frUVOZAIUVY79jk1.2bH5ebNp7gq1RC
 n7e7nAWvmZ.NeThHuVZqblYQ8YiZ5uuHUJT7d4WW9uzOXgckHTwEtO0u0.px56_4nUbQDXf1jlmW
 9BJy8oZ7LQAqse2KLf64elFaHRSY_p3GS3dhtLguEctd1WmsV1GqUg2JP1asEHFyISJCzCYcsaSV
 wy2wb2rXkXk0MxLu1uHTCAC3jxQDKSPvZ338dLjK_UCIgXXuGzjQaOawh2qG3OSpgqYP4w9gCmmg
 Qgk2OomeQIY0bVoVTNU3WuyKjNdFNJRnTqOFc9UVlEPrdZLKvDodQa4fbMMU_4cdBgLz51E8kydd
 fVj6NIcfkTKLbUy57PCyIgByqKEbKk64gglM8bbyG5sAODhmR93momcrW2W_1qZ2nieTNH8Xt4dC
 ZL8kSz4YffFbgaLhsK3ZHaEnYls6l.zUbn7SS1Iu6DK3unA9hMi0R1ZPMhvwqXOfLx3Eq1uU9L6I
 PKuMekGPzvqcCS5T7LysquHkhedRax5T_kV3NjUwePcaGMNV6hk29r4boVA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:41:33 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp427.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 41cfc07a55038469dc17a23ac993d21e;
          Tue, 09 Apr 2019 21:40:04 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 09/59] LSM: Use lsm_export in the getpeersec_dgram hooks
Date:   Tue,  9 Apr 2019 14:38:56 -0700
Message-Id: <20190409213946.1667-10-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
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

