Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3433C282DA
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5FD2084F
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="f+MN8or1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfDITTL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:19:11 -0400
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:42123
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726775AbfDITTJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837548; bh=wTEQTvklkThW7Dll4nUn/vb0sTDbloo0pZigu96CHzg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=f+MN8or10vtja8aLtO+3akHKBdGTXJvKkfeSPld9enTfoWIYR2gDkExbDAEIsV++aXiGHZetoOz8Xt+AWUEBrgXPNlvZ9MyyWRIHfloTNXeKiGy9QHZMcg6OtkCetvCYCHU/SyTDOIWeKRCyWrAxeI37LD3uSgrMu2/OeUZgf4dv9uN6A2Tf1TfXILz2Lc35IwiXye+bcSFzU1382LbaNnwrQ46FdG8GYz45JboYUSHEuXojj3fDQvkcmfgmNS3bvR5S3c5dxqGvIxh3B0zB0ToH5iPpjCR7bY95/UqPC/K8uLRycY4TIwRNSzXfxiUFhiQqKuVVtv3I/mG0KGSwog==
X-YMail-OSG: dPcxbsMVM1nTr3Be34CgZSByw46wneN6HN84NPJGDli3ETowQYHldIZT3UlDYzA
 3DglXktsvDhSKh1vFYIXe1GBNy_hhSimEk8Oh600bPJwQU3w3yQUABYoxWCgX97V4ICaIWH03gUH
 rd.7AiCgIsJLJnWn_NTt7aKtiL.Pw1R3SUGJVJMpy1p94SUNK.0eTrzWHgYSDsHvKp2rPnXb15Tb
 8dpHUm.Z9bKLeOSybMJFavn7oDsVciB.HiJjyRF2k7D6tIQitqdjvvZ1OYZcIE66GkUvbigqGwLk
 RzxDnXCl19IgGOV.R.dYdryBiumWGkO6E3UbFfb42ShoCYnIM5_KlUHBVe_SGWBvU_vdOLcBIdcJ
 8h3g94ri4Rlr2NVulmLBkiMLfme3ROYGe10L0OpsiVlDdq7v3UowdeRSgkn2SIeDCBC1Rb5Jczyq
 .CTxfTN.r1ArVl7XPqMpMGA8CoN.xIvXyRUyhW8EL6DXV4Qe4rfU0AJoXDrQbgt7x0ab1n2aXgFv
 oQtCSOHweJI9r26byr8v13m_jj9Ip88rrVvGXa17ZaeAZbL0btu6TAyGXyEtW6nHd13ZpG0pFYYz
 UvTG7x8hla_hU23PNVGuoC4_A3OyjdTEQKzrCO2.A6y9B77hzapBGRSdHPkcWFhJlWxIJV_.uhIJ
 Xd6MdvSsHqvq2zUQlG5jZ0IRpNTRaGmhDegsl51lC4G66ILwU7zSpEqe2sVhugkxXxnPi673kj8a
 DMe.iYlY1dvGmrRdrir0kCgZ573GX.gNgZLaV3IdvWnzpFNBI.tkH0y58gxqFKdepDzZDAjndeVP
 45V_.QypsMSTxLcJ6cpo69GgIvjSuKZcdQBCVb5JD_APYg2L8FJCLlgC.27rDRnAp1NL0qjtwQEK
 P70BT9eyuwPe_xf0PNeohFTmKNIDbZ9uFtn4bAnTa.fJYfp8qSsWWJvcV8ptoCTzKQUHyzqVlG7L
 5efeNnLeBkzqk0gFCmoNV.CJdJtzXxFs5JMYH6LkiOIv07VMe8PpHi0YnYofHlXymaZzE7483atT
 R1RugR.FUOTjEvjv1kA36GiLTM8oY_sTjARsCXnbX_rU.sXUa3GXqW6Bj2uNzU8aXtd.._mo1BDC
 GcT5gfXzkNX87zkuXXcNkvicDtbwWY4mHELqIjPeMcIfrUe9JmWB97Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:19:08 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp401.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 54e8f28a4675c25365c7725d1b772c7b;
          Tue, 09 Apr 2019 19:19:05 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 16/59] LSM: Use lsm_export in security_socket_getpeersec_dgram
Date:   Tue,  9 Apr 2019 12:18:05 -0700
Message-Id: <20190409191848.1380-17-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409191848.1380-1-casey@schaufler-ca.com>
References: <20190409191848.1380-1-casey@schaufler-ca.com>
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

