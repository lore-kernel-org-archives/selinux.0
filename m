Return-Path: <SRS0=Hma/=BD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FDFC433E0
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 20:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CECD6206C1
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 20:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PXGmr0Vk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgGXUiR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:38:17 -0400
Received: from sonic315-22.consmr.mail.bf2.yahoo.com ([74.6.134.196]:32871
        "EHLO sonic315-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726493AbgGXUiR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jul 2020 16:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1595623095; bh=+0qYXDN0ez9Pef7FEHDfaQukLUHHTgva61PnlAre6qE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=PXGmr0Vkqb0zimP1X4dBv7t6uyddjiC91QDBJz4N+GRN79DMYxO3PvaPIfQl8KAMU2GkmHz5+tIIt67WcUlbzXJCs2XMy9p51HDIDhAfUKEh0hwS/jPMMbk1sh1UD179d4Mxr5YOGLTvmi7KaAPGzvyLdF9j/fLdk7aHb1YXy4UYz2MTNpicWH2ZmLE5Dbg/kLjBJhskBfanlv9RNGrxTrvu1M84jz92cNWB3biZmtuFg08gIrcAYm94QyTepXTB0b+QfPC06A/Ju/BRe319Arzos2qagAUFP1xEJZ6kUWwq5oviZxacRSU4T2BB6noODX/VAiYHyH8/3f5Q/dbTAA==
X-YMail-OSG: IwlBEikVM1lK1fGvTL9rDC.FVZVMTJtUCA9rGGKygCz7i6jB.52KxJ9l25XYj0X
 94vAPP2ctkLQtGXHl6fNilnwiXez1cyjNH0pE3QgTmUHVSKgrg82RQmOWeAhhsw_ZPiutPdkaCpi
 JjYVVHFd4f6brrevUx3uAihtmT2Jt9C0RTZDg4Jz2TWxOJ6tg5jkoUojkXlEd0coP7.Amo3cJphg
 Eji2mdOgjd50t5op7wWLsFF0gVoJkdM70IsnkhdJEFNtlBSJeDjPwb7qj7s_uJ7AZ5TLdA0RBymS
 sbBdfi1ilrWfh7CyjOd4bLceF8XgtEmZZApg0fwbGhaH43xGfZxfMN_pEhOMf9qw094a_1kskGYP
 SuJvpiTO.2KaurM1i4_3M_6HFrrF365sPvppoRbYH.trLnkVahwvMPIc43T1k85h.fG4eQ8BLKJW
 yRCebi_Y9pjz5KzkndtjFxAKTWKoGjI8eoGIESN3AllAdhkAZCxRWOfvc_r.qBw7B4BP4ippVA0i
 cwFkxSXqQSOH9ACl2GHivznI0yOmWF2fpZbv1uAkw02C5L3BJBBCtIjMob.WvYxkmc0Dc7k3FGof
 PdtQSHR_V.iF7Is.xm2n7RPgBojEfLHJWS11QG_SpNZdPcTeeQyN2yjkqV92S6hL34fkmNM1EaQK
 o57x.AizsnzxOP15j199ghhdql5GU2L_nC4qN2tj2jvt2r8uXszZnMvOAPCLFsg3WJRU6YiOdhKV
 EQgY2OPM_phGkVbHBJTJdrYxooTyEwakfK8lSq6Q6ooDSIiCOKEZa6fPYpw2ngmQdPepS.TI9eQ8
 t52bJvCxy7S8qsF0q9v5jlBYs44q70uZGIzm_J93WdnGljjGb02iNpc0SbKZWHJkR4d5X4snXENO
 r1zVaVfX4NdHx6MK99j8u88TTKiPqVmgIC89slenS9ktq_35zKDdSUkYege3pAupOIrdSTH6ha3y
 UPWTjR5lyKhna.a_70wx4CQn7JNVrJ65I9hL2tn3eKXiYLhLEeuLHB_nNyTq9UCXLsQy3RFYKIid
 nSAVUis8fKG6ODFi73gWYO1KGUW8Aqage2o4Y4nUe_dYzulv_uZMongMH71YSc5vcHEL2j9tSykT
 PNg8O_.pj6LuIRaQ73TAv917hIm5UR6xCBkGUbK0EI3RsMpm4ogiNUchZ6Wq1C918UTi1Uk5DvjR
 eJP0uL2yWPHcK3AaaagFCxIrcF.mY3CNMJI4ytmpIyfxUccwiU0rY5cpOk5isXmZnMKbiiFKqMeS
 QY.wiK5Qjd2ks4YsnT8SkblsPsmGDcuWiMQD2VO27deh4py0Bkw_.l2EaB6U16vPGxgUb2_oHReX
 1lqIvLy6I9UN9u1RGo7FWS9y9YccWinruzIQuFyCEPrQ5ltsF0uiGBlEc1tmoVqciAgSIjN4ysPg
 h5h8DVQrbIQnA55DiPukrEGqj0RORF8eA9bDmDN7oRVNAwsBRZqlFFA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Fri, 24 Jul 2020 20:38:15 +0000
Received: by smtp432.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 50b1192e9c340a755b331404425f5af7;
          Fri, 24 Jul 2020 20:38:10 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v19 05/23] net: Prepare UDS for security module stacking
Date:   Fri, 24 Jul 2020 13:32:08 -0700
Message-Id: <20200724203226.16374-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200724203226.16374-1-casey@schaufler-ca.com>
References: <20200724203226.16374-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the data used in UDS SO_PEERSEC processing from a
secid to a more general struct lsmblob. Update the
security_socket_getpeersec_dgram() interface to use the
lsmblob. There is a small amount of scaffolding code
that will come out when the security_secid_to_secctx()
code is brought in line with the lsmblob.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h |  7 +++++--
 include/net/af_unix.h    |  2 +-
 include/net/scm.h        |  8 +++++---
 net/ipv4/ip_sockglue.c   |  8 +++++---
 net/unix/af_unix.c       |  6 +++---
 security/security.c      | 18 +++++++++++++++---
 6 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 6d403a522918..d81e8886d799 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1397,7 +1397,8 @@ int security_socket_shutdown(struct socket *sock, int how);
 int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len);
-int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid);
+int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
+				     struct lsmblob *blob);
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
 void security_sk_free(struct sock *sk);
 void security_sk_clone(const struct sock *sk, struct sock *newsk);
@@ -1535,7 +1536,9 @@ static inline int security_socket_getpeersec_stream(struct socket *sock, char __
 	return -ENOPROTOOPT;
 }
 
-static inline int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
+static inline int security_socket_getpeersec_dgram(struct socket *sock,
+						   struct sk_buff *skb,
+						   struct lsmblob *blob)
 {
 	return -ENOPROTOOPT;
 }
diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index f42fdddecd41..a86da0cb5ec1 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -36,7 +36,7 @@ struct unix_skb_parms {
 	kgid_t			gid;
 	struct scm_fp_list	*fp;		/* Passed files		*/
 #ifdef CONFIG_SECURITY_NETWORK
-	u32			secid;		/* Security ID		*/
+	struct lsmblob		lsmblob;	/* Security LSM data	*/
 #endif
 	u32			consumed;
 } __randomize_layout;
diff --git a/include/net/scm.h b/include/net/scm.h
index 1ce365f4c256..e2e71c4bf9d0 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -33,7 +33,7 @@ struct scm_cookie {
 	struct scm_fp_list	*fp;		/* Passed files		*/
 	struct scm_creds	creds;		/* Skb credentials	*/
 #ifdef CONFIG_SECURITY_NETWORK
-	u32			secid;		/* Passed security ID 	*/
+	struct lsmblob		lsmblob;	/* Passed LSM data	*/
 #endif
 };
 
@@ -46,7 +46,7 @@ struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl);
 #ifdef CONFIG_SECURITY_NETWORK
 static __inline__ void unix_get_peersec_dgram(struct socket *sock, struct scm_cookie *scm)
 {
-	security_socket_getpeersec_dgram(sock, NULL, &scm->secid);
+	security_socket_getpeersec_dgram(sock, NULL, &scm->lsmblob);
 }
 #else
 static __inline__ void unix_get_peersec_dgram(struct socket *sock, struct scm_cookie *scm)
@@ -97,7 +97,9 @@ static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct sc
 	int err;
 
 	if (test_bit(SOCK_PASSSEC, &sock->flags)) {
-		err = security_secid_to_secctx(scm->secid, &secdata, &seclen);
+		/* Scaffolding - it has to be element 0 for now */
+		err = security_secid_to_secctx(scm->lsmblob.secid[0],
+					       &secdata, &seclen);
 
 		if (!err) {
 			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, seclen, secdata);
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 84ec3703c909..3ea1103b4c29 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -130,15 +130,17 @@ static void ip_cmsg_recv_checksum(struct msghdr *msg, struct sk_buff *skb,
 
 static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
 {
+	struct lsmblob lb;
 	char *secdata;
-	u32 seclen, secid;
+	u32 seclen;
 	int err;
 
-	err = security_socket_getpeersec_dgram(NULL, skb, &secid);
+	err = security_socket_getpeersec_dgram(NULL, skb, &lb);
 	if (err)
 		return;
 
-	err = security_secid_to_secctx(secid, &secdata, &seclen);
+	/* Scaffolding - it has to be element 0 */
+	err = security_secid_to_secctx(lb.secid[0], &secdata, &seclen);
 	if (err)
 		return;
 
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 3385a7a0b231..a676dc264464 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -138,17 +138,17 @@ static struct hlist_head *unix_sockets_unbound(void *addr)
 #ifdef CONFIG_SECURITY_NETWORK
 static void unix_get_secdata(struct scm_cookie *scm, struct sk_buff *skb)
 {
-	UNIXCB(skb).secid = scm->secid;
+	UNIXCB(skb).lsmblob = scm->lsmblob;
 }
 
 static inline void unix_set_secdata(struct scm_cookie *scm, struct sk_buff *skb)
 {
-	scm->secid = UNIXCB(skb).secid;
+	scm->lsmblob = UNIXCB(skb).lsmblob;
 }
 
 static inline bool unix_secdata_eq(struct scm_cookie *scm, struct sk_buff *skb)
 {
-	return (scm->secid == UNIXCB(skb).secid);
+	return lsmblob_equal(&scm->lsmblob, &(UNIXCB(skb).lsmblob));
 }
 #else
 static inline void unix_get_secdata(struct scm_cookie *scm, struct sk_buff *skb)
diff --git a/security/security.c b/security/security.c
index d6d882b1f7d5..c42873876954 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2219,10 +2219,22 @@ int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				optval, optlen, len);
 }
 
-int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
+int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
+				     struct lsmblob *blob)
 {
-	return call_int_hook(socket_getpeersec_dgram, -ENOPROTOOPT, sock,
-			     skb, secid);
+	struct security_hook_list *hp;
+	int rc = -ENOPROTOOPT;
+
+	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_dgram,
+			     list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		rc = hp->hook.socket_getpeersec_dgram(sock, skb,
+						&blob->secid[hp->lsmid->slot]);
+		if (rc != 0)
+			break;
+	}
+	return rc;
 }
 EXPORT_SYMBOL(security_socket_getpeersec_dgram);
 
-- 
2.24.1

