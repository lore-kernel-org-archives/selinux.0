Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C22C282DC
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0099327982
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Lq1Nt1X5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfFBQvi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:51:38 -0400
Received: from sonic303-8.consmr.mail.bf2.yahoo.com ([74.6.131.47]:46220 "EHLO
        sonic303-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726608AbfFBQvi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494297; bh=7nhZ/zEyM+j0a1Luk+r19dVtPBLiOzXmF2b9tX24TkE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Lq1Nt1X5WZ/nAO+4+9oXo459tlz9c2zoJIDsgDTIpq2EDsd5RhNb98nHPUV3LBP8gnYfVUkw3YCXNvBmYDdWhklUqbsueIktHNwdTNM2wMUJ3FLpHI5h8isjwWeGGlM9RxnV/I/4q6EhdznOrJCHGTBDmkfm/gussbr+EG2DS/d5BC6NGTnvRQ8HfAuPJQDhuCLYpeJCWS91WwtLT7gx/UeW4jFI1GFgd6A9I6+RqM2NjPUV39BEbNXJ1+YLDUviyCPskG/xNOZymsi3geFNxW3iJopSmeJSeZS8U4C/iVx0BfA6fi87HnSh1vZVnmn4Ps6jgkBmXvfq0RFBfoJjoA==
X-YMail-OSG: 9drs37oVM1kYwhdJ38NZvL40ooWFUJm6WNMIriyyWOr2u.tQvvhXu_B356emIuG
 lWhJKDsTstPPJ8HXRFqaxaArIVE.eYi1XWr0wg3f6exwnYXXXkr4GrIIbczaXOhsEJwjW1GQocIo
 i6CZ26eQoLztNJYV0CitYH6e8twwfgXlFUk1J7JE56vaezUSHY25Ejz5XUBkiONKw2klG9NJBYnM
 ernAnsADVTWABp8.qsSeUjNCs_yLpj7TgrHNd29OWCup7E4SBCR1IWFcq0OQ3P6WdIE0ToMeexi3
 XOvzrM6lZgRP0NzjHOnRez2vx7k6L11qusT8a3Obq.isBBoi5SuVI2dG4JbSIauAOT5TmeaQYoh9
 zUB2aDUJNoBOb9iZ4pIisedSBCF4viV.DvcSDgtTQLemZEeokHLlmiHSPcdHDAi2x3WIpAc54cJT
 N0uE0ywPTvWXiBqJZwTC0pY5Sf5L9xWYdkTlBbeksVgvoRVw57av2l3e6c1lPctmVudltvqvUUy_
 KEYLjSv8cx_sqQ8vE1XG1ndt2R_dD5VICxupgXYkp7lLrsfZ7zWTkKjQcVYXM_zJLP3xSCxD9bwL
 mv3zUlBL9b8JBoc20yIDpCBvSGCL6lb08sUtZrd3cxVINn462pVh3LR5LXAhLFdzXJG.yCK_qNhN
 6IJcRjUFFNH4FuHpHvSrB5KIY7gwkVeIzubbyKtHyS84iOM4U9B6sSsrTAQ59csH0f1zv1P57Pzc
 MvKRVXfUfDPwQkQA9w60YbrFiW7.4cB2MgzbvKjfqzBsmAuwC0f2DnHH0p36Nt9uB5VxUhsMUN7H
 8wZf3PzrRJx8B_xZvUmq5ZjmaEOCgmGOA15RNC9SJh7xz0oneUBRxqoiHwpqgK.KMWgz.IAT7bE_
 7JeOouJvg6uA_6AYFuyIElKSx8ie8XRCzsOFHe2MIYMQNWTRU11565yfqI.k0SzDYKKsEwRkoZzA
 R16MHAUkZvajWhyWwUtHX_feyCcfv.mtsuKmK3ARIHUMaCZ22S0Lthq.vRUw7.0EKu6ZFb3sRqTz
 YyRJXRmBfX5x26GxPJzQ4wLtO06_yD_qQperwsxw715tOg6tEXJUanTxW_UkjEO.r7iDWKXSOisl
 FR_eKHSYd275vS8Rxpo0s9XRLzdYfI0ae99povykHdzQycLZt6zBaGxeBwHxuIYgFH_t.CIHshds
 8rBy2qDF2mSdbWpLzWfRsmmyAH2qmca8V5my9ij_boykRAbsJ_uLGhs8aEr1x.ZVEyLvP_hYp6CO
 4AX_8yA.9lH2j2pwlWEcuAjle1G0rXUThcPVB8WYTcA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Sun, 2 Jun 2019 16:51:37 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp413.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b3a8ad7d79501e3c392fdc3d79d8fa55;
          Sun, 02 Jun 2019 16:51:36 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 09/58] LSM: Use lsm_export in the getpeersec_dgram hooks
Date:   Sun,  2 Jun 2019 09:50:12 -0700
Message-Id: <20190602165101.25079-10-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

