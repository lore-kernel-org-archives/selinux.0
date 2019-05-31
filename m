Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB813C04AB6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3952259B8
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="hrQbgI/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfEaXdj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:33:39 -0400
Received: from sonic310-28.consmr.mail.gq1.yahoo.com ([98.137.69.154]:43635
        "EHLO sonic310-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726643AbfEaXdj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559345618; bh=wTEQTvklkThW7Dll4nUn/vb0sTDbloo0pZigu96CHzg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=hrQbgI/bHVRuYwtXG6PUGQGzP1MgpWuPkgtEsP6IZmNvk2gRFZOQuzvcaa1MW1K8ReHprRQqyUkY3LI+HqPzWZX0pvSFa8mlQnjNuUCuou6H3DpFlMLhIDFb1tuyWod6ChZ3zebRH9C9eUcmvnCmGDJfCKGXlAhs/huj+bARZ/SgZYuv9leunzbZGw/CjZwjnRuBG+V7iaehRVzN6BZls3m1X0+czBMubT6F/NXKzCuEsEXHI03Jjc40QTAJxMHvITh59dlW6SzudGpPNmJ0/99ZCS9kWT+2xk1bt92Yd/k4cxJYYgxK4T6K1q3u2pEd4nZBfMRpqqEiflAW++RiKw==
X-YMail-OSG: mCpFxEQVM1nMktGpg7wlBc7aEIPnK.SSR6LxETFu9ve9X0M6i9c4z8C6cPlHwam
 vmd.gfero8RjkBcG21.bErWpZlUqq829Wf9aYlvzmtN6G2ugIL6ZPebZqDdgtfhn01ULRpPuUlU0
 6aLXiHJzZP7DjX6zdtYLC_ANbVAIbBGoOhDJWPy42AS5VQfjTX6Ef.jF4HbCx09i.tatXYz4Dz88
 9.pT_5UY186hV41hwaLTQXRcDwowjvqNPFZV3bPN9DtXwFF5Y6zPLodwN4BVDr8fwwfMNN6ryuKl
 LIY0XMuOJjfZUrAdYz4.43xjgNoFQAnnIVsvUBmx1qC6zUG2hE51oknacgs.jDktK3Y8feQlZ4Xx
 2Iy_vP3O4m56m9uYETqAXNb.Xr3xuIOhLt9ZTzOkBQXNuJ4xDjDqjKV4zsHvuZzn6kp8w.0nDO8n
 X4sVuUnNLpEOYKy32W0Y2NyKzs55xIA.BPnRdfpmXLT1OQVRDOO2y2egD.67STOeYZ2y4xnxA4U4
 VSA5NCiosCE7J6fDaJ5g18VuNF1TwboK6PCZy639_ovltNt3VNorWhQpA.Tx.irJ_OpwO.3m92IL
 ChSObBHNP4jmiPuWRmCDd5eexyCDaIim2eNLp9gSIln.VedJMa4tGEM.ZoCgBOWiyinzG2ORr.1c
 gtGWHE4LqtEINzFaggvPjg7iOhihIYNPuw7Bm0ZEuuEpJV7LaJtstKHq_gHgZltOgW31Lb4.POd2
 HPiLeK5gjkLol4PVHR2rQp2L_Fw9q1V7b_E1IhUTuUUIuQujVSAJPBrlA1Q5duW8KGFWQJmX4Gf1
 zxlDpgPlH_6VhLYe3SWpQLHYCFfcGlwfrjNo.Pmux3H6aL83.hsu6Q3S3stCXCpRcDKgO9zvYQbh
 s9u2oyIv5wWiCSX7ysL6POi0b84ZxQURzrFZI6tr44_pDsvPNo5dDFaL2DjTaVd4feI.46HbS9V9
 E4ks2lN4quxIz7jyxSjYJboXMWOt31_58ie.YO1NzB7UNXW.QDAH1QIyv35udc_wJCQ0VzObah35
 Vm.RdIIA.6.g1NoV7goKCkNUKwDFY0lplrdCgdzAvFWUs_qkeEk5ki7ZE6n.ZlfYsUTuqA_ees5O
 B7PGcO5dJenaGGb31KHkYQALSmALvE_oougtYdTHf_cNiHreDRzk.Dz8FCcAMJ8trwdUa_T3mQm8
 pVHHBsWlxLlSWKFsUljG1iuhrnqIp.mLNyBP_99ah4MdrN8uDdERIIH5j1IJJhOewokEtWaLx3Ve
 HSNt_CeE_FA0SowGtoWP3ALLOn8uHJaCjSDYO0ynACyX9mhpPT8UDLQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Fri, 31 May 2019 23:33:38 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp404.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ddbbc57c2db67044df9793aa98e74179;
          Fri, 31 May 2019 23:33:35 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 15/58] LSM: Use lsm_export in security_socket_getpeersec_dgram
Date:   Fri, 31 May 2019 16:31:06 -0700
Message-Id: <20190531233149.715-16-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531233149.715-1-casey@schaufler-ca.com>
References: <20190531233149.715-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert security_socket_getpeersec_dgram to use the lsm_export structure
instead of a u32 secid. There is some scaffolding involved
that will be removed when the related data is updated.
In particular, the le entry in scm_cookie includes the secid
data. The secid will go away.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h |  7 +++++--
 include/net/scm.h        |  4 +++-
 net/ipv4/ip_sockglue.c   |  4 +++-
 security/security.c      | 13 ++++---------
 4 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 7369cdc3a681..e3f5c61b9b2c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1270,7 +1270,8 @@ int security_socket_shutdown(struct socket *sock, int how);
 int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len);
-int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid);
+int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
+				     struct lsm_export *l);
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
 void security_sk_free(struct sock *sk);
 void security_sk_clone(const struct sock *sk, struct sock *newsk);
@@ -1408,7 +1409,9 @@ static inline int security_socket_getpeersec_stream(struct socket *sock, char __
 	return -ENOPROTOOPT;
 }
 
-static inline int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
+static inline int security_socket_getpeersec_dgram(struct socket *sock,
+						   struct sk_buff *skb,
+						   struct lsm_export *l)
 {
 	return -ENOPROTOOPT;
 }
diff --git a/include/net/scm.h b/include/net/scm.h
index 1ce365f4c256..13b8a369fd89 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -34,6 +34,7 @@ struct scm_cookie {
 	struct scm_creds	creds;		/* Skb credentials	*/
 #ifdef CONFIG_SECURITY_NETWORK
 	u32			secid;		/* Passed security ID 	*/
+	struct lsm_export	le;		/* Passed LSM data */
 #endif
 };
 
@@ -46,7 +47,8 @@ struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl);
 #ifdef CONFIG_SECURITY_NETWORK
 static __inline__ void unix_get_peersec_dgram(struct socket *sock, struct scm_cookie *scm)
 {
-	security_socket_getpeersec_dgram(sock, NULL, &scm->secid);
+	security_socket_getpeersec_dgram(sock, NULL, &scm->le);
+	lsm_export_secid(&scm->le, &scm->secid);
 }
 #else
 static __inline__ void unix_get_peersec_dgram(struct socket *sock, struct scm_cookie *scm)
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 82f341e84fae..b8ef7677a7e5 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -130,14 +130,16 @@ static void ip_cmsg_recv_checksum(struct msghdr *msg, struct sk_buff *skb,
 
 static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
 {
+	struct lsm_export le;
 	char *secdata;
 	u32 seclen, secid;
 	int err;
 
-	err = security_socket_getpeersec_dgram(NULL, skb, &secid);
+	err = security_socket_getpeersec_dgram(NULL, skb, &le);
 	if (err)
 		return;
 
+	lsm_export_secid(&le, &secid);
 	err = security_secid_to_secctx(secid, &secdata, &seclen);
 	if (err)
 		return;
diff --git a/security/security.c b/security/security.c
index edaaaef54239..d8300a6400c3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2110,16 +2110,11 @@ int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 }
 
 int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
-				     u32 *secid)
+				     struct lsm_export *l)
 {
-	int rc;
-	struct lsm_export data = { .flags = LSM_EXPORT_NONE };
-
-	rc = call_int_hook(socket_getpeersec_dgram, -ENOPROTOOPT, sock, skb,
-			   &data);
-
-	lsm_export_secid(&data, secid);
-	return rc;
+	lsm_export_init(l);
+	return call_int_hook(socket_getpeersec_dgram, -ENOPROTOOPT, sock, skb,
+			     l);
 }
 EXPORT_SYMBOL(security_socket_getpeersec_dgram);
 
-- 
2.19.1

