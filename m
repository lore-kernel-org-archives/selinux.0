Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D313C282DD
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194C121736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="eAtrZyv5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfDSArE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:47:04 -0400
Received: from sonic317-33.consmr.mail.bf2.yahoo.com ([74.6.129.88]:44220 "EHLO
        sonic317-33.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726707AbfDSArE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634823; bh=wTEQTvklkThW7Dll4nUn/vb0sTDbloo0pZigu96CHzg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=eAtrZyv5I9J3UgUVhiYXqnQ7+5jf8L9W0MiP1+qOUlMnsub3zq4g5gdaKoxMXJLjvTpSKsJMEn1D5Wa3QYFsJ6UHinOhxtukPBFPcHgDQ2l4kSp6s8WgQwKZoKAZb6oEAzdi+f3hCHqmIICfrsg4y9SFPJj5/yQjnAJShOqpPERts1kYCSULOXR5PvA7x6xmVdKDqdIDKBdcOcD1gVyKFhE2aMYGbjwrsDyx6hyYKXOl77NXDgHZRy7lbFdnNNE0Bt5yduG1PSm8Ppcx1aGv4EIodlco43GwSHvU12JSbN9E4rH5dNYgiVn5vRL7999WpGEskPbeWdmROcxhAWWdQA==
X-YMail-OSG: c7bZ_EwVM1mqEvPjlWA4D2b.Q4SlzDMru3FufkDbUymLhGhjjQ7yMa2qZWWbOQf
 dSTMhq3O.8UW6k1O5GmLRIgxruHk9P75cUoPZ4mEiIcnl1tAoRh8ukzojeVO7tEaMs7aYCKp6jlN
 rVKrzZztI0F4V79TqMcvAid4C77rc5dVYg85QmbBzfVtlvR2cb0GXTiv8eXb7iriJvop3aGqUnC3
 pCDHqiqIRcxYP9McFJb5z8Zkh4f.e6Y.Y8psHL4jjy7PtDgddMrkn4lCpIfs6QwvmOpQBrnXlsU6
 UklpivA__aQTMgj8930s0ToQ020mFX8tuiQbfLeHNdrwSCjI0KHdcI9AyVL.65RGSdfuQI46BVdC
 a8y4n9ZNwV3C9enT3sCs6xw_J9yuQEFIi5jFtVo9j9RWh9EXiMFYzxznnPHzcemfIRXPoxjXkZLs
 hVVxg1SQ1o.V8bkgmpQLO0eHfoQ7l_2ZEfBGm1IOzutagWGgNnI.eItDEYh2q5VX_lSmqL6pWl2o
 QDJAaNMNrUQnYgh.Nc7zt55CxZu__Ue8B.j1JAGpSNn0KwUpLIvOZxv1kHjNmb_04z9Wbl7WbHPI
 Yo_Ea0CehWpce4Ak5N7IbqaeHTMQhmVs_uUpa4enP26qu.KcMeJKQIhR5ZKOx61F3hld.mmiY7C2
 _.gUxE.qSEg5SGkqeRxQ2y6reERF8ula6ERkdXo6gZdG2pJUeJBkaEQjCKNvZRiWAUTZrtPwrheC
 YFry7IWmvrfDecX6hecwr.U36H2q9OEwvyBExjAiRAhMKoUQLe2_aOU3bO_TAZDAW1J.Fz9Qq4Pr
 YibLxrUejz8wEuw4ee7ynssH9NbzWOtaIJMPlwbF2THTGOzoFUVN.hZbenL62fa7WV4Zs3bDGppi
 quTINV_owS_h5_teZxwsmcPn4akrIdP5FzXGbHbaUVSn8PccFYUZC6QmhWpTf7wcKA_GPFfp_ER0
 KHhE8PntJ1enE0ITopsxEDzp5Xmhk9zFQPUcbEUJPex.uMz8oeo.shnEqxkjQn97z7LkKr.QXJQE
 t9ZatejHJUQNEWuc7l.hm1MjvLHfAHT7SMncRyJpNgeSbOvsah4xaOufaoqTAK_trG5VIr.Gpz1w
 aGnPYYHr31MqyA4kmxIyyHGoEptOhWsVIN1j8JlWxJ7Po.tvPbsCMozEQSQosFbPoE3tjIgSEfCj
 fJuQacLmAccsb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:47:03 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp404.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7bfda36ec44e7fd17a13267c14302369;
          Fri, 19 Apr 2019 00:46:59 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 16/90] LSM: Use lsm_export in security_socket_getpeersec_dgram
Date:   Thu, 18 Apr 2019 17:45:03 -0700
Message-Id: <20190419004617.64627-17-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
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

