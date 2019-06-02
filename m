Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F12FC46460
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488A627982
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kpF/+Mk2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfFBQv5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:51:57 -0400
Received: from sonic310-27.consmr.mail.gq1.yahoo.com ([98.137.69.153]:42013
        "EHLO sonic310-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726933AbfFBQv4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494315; bh=wTEQTvklkThW7Dll4nUn/vb0sTDbloo0pZigu96CHzg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=kpF/+Mk252RQJYlUoCSvKS0ludUnH5RbeFVpg05iVrfEpuiF87ITAfjTwueRCIujzxrSHc/eiSULZ57Vt43toD3kGIZ/p6WQ+aOooZrGyYYVauBzFkTeqwrrdc+Dma+wNovaz61IRXwzJPE9dpu6Kr/2BQlgmbhxUG48TSj8GOq1zQE0QDcDGTyZ1pKL7GzoaM2UQMUaW2pOsDEUChCNNFLpV5IWObAyXCSnfUn/CYzDYk3IZ2PAMEn5K3OrldHrvyAMMYT5hmGPZbRu2OhLno4knipUgpVoY2TsMjZcGT4I5NJUq8e2IAacGjwWs56/6Und3HxsXmGcmkAA87Xt6A==
X-YMail-OSG: a6vQqbcVM1n3GMoC.ciFUpnAHLwYr2yHXfjnWOfVuHWWzV5aFy45OJi_8A_H1kp
 D6l2yAh8PdRVKeZpaAXCwMo3OAqoNOewgYBn8AN00xIXHoFAmoZoYM8_WBGmPKvBIESE8Oxiw502
 5V_VMMCTut9HUFvyRg51ubLMvH7tyJecMdh_vCkcZ6.naJyiOEMXzBJc1eqQkNqAIZnmj75cxXLf
 6L2oHMwgVzVAkU4wJOhSINYVhmCKa7nM6bZpG2vYjesPUAQsUCYhS6.qgC_R5XZ4E6QfLXfvRo2s
 sdBwIysfFUncy602C3w93a0rGQdZbKtZlKAXZgnj2wZRK_rBJy_WCa7.QforUUTZux0NSTg87owE
 0zmBARJNasIR0IvkmNa7bBh2qoLP0P1.GqJViYrPPUd2Qlfjws6VRlssj9iWYSG.2ayV2VbdzrLj
 Mh_ZY0CFHKc0Nlc1EeM7IGHUywOzzaYxJr6t3uGWUT2BvllklunSwn2w.GEKKlnXNz9cdzFJWFYG
 9oCgxYXa0F_MkC792g_Gm3spGBLejHyIC87zFBQIcoNmCKhhaqWx.DoL9sYsgQ3gK_5GdEON0aPl
 E_m.240A7RP7dVC4G8oAmIzA_m6n896VCeAGRuX_hAyoc2B1JxkNKoKKyQY13I.RC3xp81hUpFwZ
 5u9SAnILauATrDXrtOVIxX9e7a9VCXKYHfQnDTawXlcIK8yGroBoD22RdbUFollF2idYVdnAvu76
 .cBeQoaP7LDzjHplpfWn3j.yaWeTjX4QoMswPAq5LEpGb2ds.ZuyGokGw1rkNqChYIOt7Q41n7pU
 Ji8rLJ6tH4vALRk35x4NoDJzQLbK8XPwCSuY1s1WxrKmfiov0KvwpjX1w452S6DJ9bGdWW5gcBPY
 wmtQ.FI3.i.cCcu8fy1hxqRQWnYoPa4XeLFX1geVbK7usa43GoLoBo6JekK0WIHMKIAjR4lXvIwJ
 5oJhlWOA38JPtWPbcDYZWmy5ErSdPOOm6qSLBXLT6pvd9qEPXXXoJukXauaG6ql_M_R3SV3EKGsZ
 KbxVxlerC29N2.Z8o8Th0KY3OPeSmzPyhJyTNSlXvN37JqrHtV3g1H2hyaIAkNLUsL7ALQGIHkmN
 yl_vfVBefg5pS5wpYT4kk.I5miTVU0Td0vJaibxb2brcPVkVOAAhT7vQTZtnMK9cwIQF9b6ex_Ft
 sQyIha385UiOjbV5Im6DHLjxBW6GUqkch2pIfD1xZ..tIlF.UUaVPd1K_UQD1aCqneGw84vX8JHS
 wLPigfVKPAevVt5d1.vLEt2Ja4tVgxYXQbwrfc5A8isUw
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Sun, 2 Jun 2019 16:51:55 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp420.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID aa88b96425a9713222d71be7c480dcea;
          Sun, 02 Jun 2019 16:51:53 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 15/58] LSM: Use lsm_export in security_socket_getpeersec_dgram
Date:   Sun,  2 Jun 2019 09:50:18 -0700
Message-Id: <20190602165101.25079-16-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

