Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA9AC4360F
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56CBF206DD
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="OljgPz5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbfB1Wop (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:44:45 -0500
Received: from sonic307-10.consmr.mail.bf2.yahoo.com ([74.6.134.49]:37541 "EHLO
        sonic307-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731363AbfB1Wop (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:44:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551393883; bh=veSNDk2QMHk6L9DmOxVle7iGwxSBUaP8rL8t0q/nJ+g=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=OljgPz5f+x2qL+3c8pbKwI1RVLdJGOkwqQEmq4jy0EKz4zXBqcOjFEKr1RQSs8qNLVbkeGzGyPArjHlt97VEliKaSxHM0xU8ZHc3RwqZlHmgPmgQ1FbMZd3pCglwvv6eYkjty2JadNHcv+/QC1QT4LS5C3soWWfytz5cvBLO0Y0AC8UaZpB7nRyK+sjTmGjsiOUoQFR9FX77IOn7RPATuE8w0i1U5ykQgvwQTptJKA064dTv9sXAF4RATMKahn8k/xTux+hcZfIRbsi56uY6fBE2aEIGe1PuLBi1/sashuTgtE0pHs7AA9yuo4bGc2ROhso6HE0L3YJvwzRBfuJw6g==
X-YMail-OSG: L25urUsVM1lRuG..6p6nduoIu8B4K_.g4Kt8gOBd6wR3ygcKZHAuj0dwBRX9L0o
 Ycu2mr5KWOXOUBHCUwQT9Z8Hyo41KBn6.pZ8JzGDNvANuoA2Yhsq9E9Nzf4_0Fsf2V2fwOciGjSN
 hFgXQ8IPqbgcmYctk111RsZvHhih0QFysWM84wlkgSK.74rfKOJjUZHHC5Ke60aPZ5O3Cy8J2jC.
 LXZsIe.21e7H0Rbjx2ozUZrM4HvRQrzvqAno3yIymTiEvNco90auohhCTgmcFQmehn0YzV8FGIDe
 4uxuVNOsJvW8VGQMDaTuz9hLxSPByexICrIv5mVz2zDrK34WPrjPsrUQjqsaV11xseUne6x5CEvX
 0f3hmgbgw38LGyc0zPDGhMvyZSbmoZR5iZG8YwYncMFCK607GY_7qNDQUhw5QKDhKJaSrcTzNXOp
 txWv8a4772_KlsNdo28Wyfgzyo4Rbsa2geOL7Qf5FVnpkgUQBo53UinUS.DyVmcvKoowtRsUc7JB
 IcwGbcvMnRhBQZZOyyolakLd847WVsB2BA4xoMbOAv8gfTIBEZiLUn9dif_HlL5CPQqZzIZ55oU7
 WvObqVcXKvGQcko8IFv2KE.AawgvCFDT8hsg3rV172Z2fywlyLnEI9Fdz8aeYhjR4yDZZDvU3Df7
 kNT2bRLrJeYsjnO_YTssIH4UC9YHz_yzDGNY1VPbWMN5xE2QuILprIuWQfWD47QxL5OZXhDI4.AD
 4dLnRhJ_XNINavQ7ltr7ET14RSvB3kYnmYNwtOEbzGxWYSk0WCEM.hfjh6dU0Y5EO9tMOzCTCsph
 ardHiO512pFgFD0I14P51WsLhQP6GnzXnDJvJfai_EH.Sxe.t8IulzOd3c.HwGOyLcqz14wJPVw8
 3gxyQmMJ60IFsyDKCyew1hWuQQgM5LkGnRtgEeTl7p_00ZOsD2UPIUpMIfdAEKptWXyRFlOiHC9K
 xDMhnPt16j3pIH3AgO4ZDSV_dc.dVEWIfqjd4oQ7FTthyp_D_jSkcHSRdFkmBNOVKpzPsw2Y7Knx
 Hm7EtUBubrff5QMGv8mFg.rNIJXeqV402SUstwIOtaV.oq0d46SYvcM6uDy5o1aLKzZN_5Bl84vT
 egyGXfs45Tm7Yp7wA8LfwWSD.OqodKg2RTyIJ6Pdc4qK0UN1U7L.qvfw-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Thu, 28 Feb 2019 22:44:43 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp430.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 41bc5dec9e4ecaa87e9a199cc17828e6;
          Thu, 28 Feb 2019 22:44:39 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 96/97] LSM: Apply Netlabel consitancy checks on send and connect
Date:   Thu, 28 Feb 2019 14:43:55 -0800
Message-Id: <20190228224356.2608-27-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228224356.2608-1-casey@schaufler-ca.com>
References: <20190228224356.2608-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Verify that all security modules agree on the network labeling
for sendmsg and connect.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c              | 43 ++++++++++++++++++++++----------
 security/selinux/hooks.c         |  2 +-
 security/smack/smack_netfilter.c |  5 ++--
 3 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/security/security.c b/security/security.c
index 3c1d2f47b09f..dfee44ee4d19 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2355,7 +2355,13 @@ int security_socket_bind(struct socket *sock, struct sockaddr *address, int addr
 
 int security_socket_connect(struct socket *sock, struct sockaddr *address, int addrlen)
 {
-	return call_int_hook(socket_connect, 0, sock, address, addrlen);
+	int rc;
+
+	rc = call_int_hook(socket_connect, 0, sock, address, addrlen);
+	if (rc)
+		return rc;
+
+	return security_reconcile_netlbl(sock->sk);
 }
 
 int security_socket_listen(struct socket *sock, int backlog)
@@ -2370,6 +2376,12 @@ int security_socket_accept(struct socket *sock, struct socket *newsock)
 
 int security_socket_sendmsg(struct socket *sock, struct msghdr *msg, int size)
 {
+	int rc;
+
+	rc = security_reconcile_netlbl(sock->sk);
+	if (rc)
+		return rc;
+
 	return call_int_hook(socket_sendmsg, 0, sock, msg, size);
 }
 
@@ -2788,28 +2800,33 @@ int security_reconcile_netlbl(struct sock *sk)
 	int this_set = 0;
 	struct security_hook_list *hp;
 
+	if (sk->sk_family != PF_INET && sk->sk_family != PF_INET6)
+		return 0;
+
 	hlist_for_each_entry(hp, &security_hook_heads.socket_netlbl_secattr,
 				list) {
 		hp->hook.socket_netlbl_secattr(sk, &this, &this_set);
+		/*
+		 * If the NLTYPE has been deferred it's not
+		 * possible to decide now. A decision will be made
+		 * later.
+		 */
+		if (this_set == NETLBL_NLTYPE_ADDRSELECT)
+			return 0;
 		if (this_set == 0 || this == NULL)
 			continue;
 		if (prev != NULL) {
-			/*
-			 * Both unlabeled is easily acceptable.
-			 */
-			if (prev_set == NETLBL_NLTYPE_UNLABELED &&
-			    this_set == NETLBL_NLTYPE_UNLABELED)
-				continue;
 			/*
 			 * The nltype being different means that
-			 * the secattrs aren't comparible. Except
-			 * that ADDRSELECT means that couldn't know
-			 * when the socket was created.
+			 * the secattrs aren't comparible.
 			 */
-			if (prev_set != this_set &&
-			    prev_set != NETLBL_NLTYPE_ADDRSELECT &&
-			    this_set != NETLBL_NLTYPE_ADDRSELECT)
+			if (prev_set != this_set)
 				return -EACCES;
+			/*
+			 * Both unlabeled is easily acceptable.
+			 */
+			if (this_set == NETLBL_NLTYPE_UNLABELED)
+				continue;
 			/*
 			 * Count on the Netlabel system's judgement.
 			 */
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 4a8996b7b477..c924b454246b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5400,7 +5400,7 @@ static unsigned int selinux_ip_output(struct sk_buff *skb,
 		sid = SECINITSID_KERNEL;
 	if (selinux_netlbl_skbuff_setsid(skb, family, sid) != 0)
 		return NF_DROP;
-	/* verify that this IP option works with other security modules */
+
 	if (sk && security_reconcile_netlbl(sk))
 		return NF_DROP;
 
diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
index 55cc38ae07f5..de4145c2cdd5 100644
--- a/security/smack/smack_netfilter.c
+++ b/security/smack/smack_netfilter.c
@@ -88,9 +88,10 @@ static unsigned int smack_ipv4_output(void *priv,
 		if (rc < 0)
 			return NF_DROP;
 		ssp->smk_set = rc;
+		rc = security_reconcile_netlbl(sk);
+		if (rc < 0)
+			return NF_DROP;
 	}
-	if (security_reconcile_netlbl(sk))
-		return NF_DROP;
 
 	return NF_ACCEPT;
 }
-- 
2.17.0

