Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0C0C28CC2
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D725624ABF
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gccMiXe0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfEaXM1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:12:27 -0400
Received: from sonic305-9.consmr.mail.bf2.yahoo.com ([74.6.133.48]:34225 "EHLO
        sonic305-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726450AbfEaXM1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344346; bh=wTEQTvklkThW7Dll4nUn/vb0sTDbloo0pZigu96CHzg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=gccMiXe0//Mh4+T5Jh2/uomOEAmCZq3sQsYsdahw8cK65hvQcnLyaKsNrUg7CSzBpLasfqbaEDYkY2DCyeKt/GghMJk4Jshsp2Ho/Gh8GrEzejBp9pOwuFti0czqgKvjpY1rdpHAD6Jqgpv7PercPm+moevjp5IQcI/HXAMcfWiECa160NUaXrbk4DjA6jMcWkDFruBsewLwHIB/zFb7kcB/dSsmzf9jhabMRsMg7+1MyroTS0v3pdeOlghCDqOanNCJfH95fhylQ6GeC0BFYPSOqRAFwx5I7F42ZK+9bILE8v3h/f6zLUYFkO/5f9UUppWBb02r8J+OtZ9IuhWurA==
X-YMail-OSG: VVe2x2QVM1nd1jQJdy5IMgCOi9wJeTwwVFPRx7I.OVD0ZTVtxOOYA3i8Wxl7NPd
 nOidz_YnRlgyBWlb_6drxjTSvIMI8.jOKLmp7xpgFvGmG1okipbnaMJHQe69A60yoyJa3y.7uVwe
 2U2w60b_o7lQXQ_KYkis2tDlCI9d1PdDtCydibvhtU9IzUIUL5yURIQ1kdPF0eWtTQE1EvlUouYB
 Qdk_IRE.0fJ1SV04ieXibX89kxp2JbRxsVHDP5MYXYzSyt6pcYgACvDipoCwxRttGAbjFrA.9z3p
 I4UvEOdYvAbQB71N_zJKFhq12kilhwCDY4sLe6YM9IV6fAONJIYgOd.QWXIS4P.yMvJcQWheWgoL
 C7mHNLRW0r.J44hvJ9Y1F2dc6OXwfTR5m_bD1.AZ7tbFqs3IntHtVwAkMh409Q.kGeea.iYUZVwi
 MNLJoihiybgHZbXzwwft36zmWX3.bwxpIXqlud1CBWgeWFHrSZIyiTkVkrPC6iTtxGHD_jTkwkWV
 mikHO5YQF_UlRffFWGOqUqXmE_Q1OWfHwSmE4Rd5YzADetQmhmJaMUrXtA3GZT81EeQ2zVktf425
 yq3vZSjQVwiMemJ5HAK9OnVyy.MnykNP9Osb7y3yFlZXGfk1VUay3TWj1u2gZPqnga80xSbmDG_n
 uRVPxqkEngQrWuNhNd0zWgcjmJ3Fzhk0fkzqGW2bClkpxzifmnJ7MWoRmt2cMCa8JI1BsTWvVuL1
 _yDDP8PnKThTNCar97Tpdz7c6PpkWMLLETPNqM3_GPNHH0UFWAX9GrVQbbUrNp9QIXYNNiJJzJZv
 _fG9q4SJM_CWYchc_Z2HNT.7Y00GJlg13wH7RjL9XKv0iJbi9OwKt4PTctaldVVJML5jNRUwoEZv
 oTmzvf4k7johP78f51eFVNgc8tuJ9JkhpegDXEiD.yWtJtlBovzlzQKo_cAJc6Rt7rZj7TPEW8zP
 Brrxfi.q4lrHVchqNHnLsOpXxYnzIRN9gYl7q3.jpZ052MSZ54OhMrPNVdTcHw.6MWDY_jU2Clp7
 8A5Bv8Q0_v2OJgJF1OTHRaaAuM7AG.3ZzQuJEqoy1ulnbTyOSDhtYUHEPKuGrYsAjvYUeyxh8Wrw
 YxzfRh5gVbJ8Fp678UKT64FpyG5_wiYi7IRhgrXhOD.BTunuwc.DHtBdnBl_NXowXJ1jJyCqGewy
 Mc6Z1TJv5.5Ml33D6s0icrDTdi40P8iYTwe4ocO4bASGQo962VIA4xicBLNKWrkdOGQ4wuMfJnV_
 t47J9iCf3.._xQaUaorfQj0O0quSefEb514aEoyypzG.pW..lLm5pv08-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Fri, 31 May 2019 23:12:26 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp401.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5c1c0ca95bce5a627929b23189b28d7a;
          Fri, 31 May 2019 23:12:22 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 15/58] LSM: Use lsm_export in security_socket_getpeersec_dgram
Date:   Fri, 31 May 2019 16:09:37 -0700
Message-Id: <20190531231020.628-16-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
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

