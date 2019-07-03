Return-Path: <SRS0=dBUy=VA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35453C5B578
	for <selinux@archiver.kernel.org>; Wed,  3 Jul 2019 21:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31B821882
	for <selinux@archiver.kernel.org>; Wed,  3 Jul 2019 21:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="OwrY5LYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfGCV0D (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Jul 2019 17:26:03 -0400
Received: from sonic310-22.consmr.mail.bf2.yahoo.com ([74.6.135.196]:34198
        "EHLO sonic310-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727058AbfGCV0D (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Jul 2019 17:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1562189161; bh=Ka1Gx+I96hAzkKoAYSBNjQ1iDMrTZlQNs08b4b4eI/w=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=OwrY5LYS1Mxt4mmahFqr7G5ysK3PoQGClgBqPslVgaOXc1m2po+LApfo2juljyfHu5/M0acmjzYASgV+hmjRW++CjEJGUDgmgbK/80qdPAZR8tE4Iq9EjIwW65wd2bEUr/82O1JPYtjra2ol4NLse6Lb3sKYOd6Jl0RoFCX7UdfXa7Aim6eYVMmFc36pX6eO8O9CGlr+5XWa41LZIDYDmRov2OOac7ZBRP2octuyT0KRcaHhcrIg85RnSAucvC4W9K+8KaclgsPtTMllVwruoaWpW7ea5kaM8l9kGoazDpN8bK1o5bbRfFrOW2QHDq1wHMcqEYluq1XK0jBwqyIXXA==
X-YMail-OSG: JFvRtP8VM1n5NQnpSKYG6PlNok0uumQPDkcxvM9hwst7Ke2oJLXUpcRNI0urBxe
 yRr2r7enuyV6teE..yDST8nOiLD1AdSqJ6R_5t3HUf4Hum.ciriylV0S5yjdO68UQZRCxlFWPmt0
 EM2cr3TeZtKn9hyg1EjGOMOo.9_KebwCir7x9qQNaFnC7FIYjDJkI22VrxyrgMdQcfjEktKWL418
 ZYejxpnm0dwQMaxObpCV_2N3VznGeQkLHVW.C_H7_QuNGDdzhGuDf6bf3N40lllaTptdQRqzbtHB
 aC5IV_A_EXelP6Vk_kZyGiv_OPQYDoXTcpKpTlm.__msNBinIQVLzAjhbUiPOEtEJuI77gzvuPqx
 45.DOcKXheRL045XReBEfO2AhsgWn1zONCCt0LLRCGcjfhrsSnhvcIaXJUBj1thZvxBu6im1VIpA
 gQOhRRdDTwydBAp3RtURVifP_GjKIdPDu1hWlD2cqYmQxDc9fP94ECjFjRbAH5IQk6EDr4ZCU_dV
 nqsf0JtMDo24Ns3iQkGzMBiEdi9RSNwa.eq_CqZbmKtanPB7Z4VkBmvrSgeyw1MZU.n8MBPt1vCL
 4.1UyUKfxhUkJl737QlA699ziRF5wRVRuC42eMt8Uz2NyuPOQQaviNYGYDgjWgfSBXj7UPVc6pjF
 cpyNlIbNDsv1P144_4sftd.owuH96wI65Ld6_lzEAUcoW2eE.UoYtFp6uPNd_DWzsp1rVi2ziL7x
 SYExtYb41dBB015ory9GxcsTTZiteb7YfQ6mgA6YaIowQ4m5EOv1WELU3e.hOxp8MLJ6nVbNbbP5
 RHHRJC0bmdYdKc7pmgFiuKS.L57.kYzLZhJHilxQyUbnr8SYfsyt8TYEDIJw33OSR8943OLdTarb
 THR1AuXZxVt_mC_swAeVSORT0FY0_Ydk8ZLB6zceVHHXZijCY8wtbj8UwCtjwPZPsX2u5cfWqMV7
 TKCdMZdTQEP5cTNV6trdwrB5e78sOFGdERkf2s1RFKsv1WiYQ.Xa_irRvtQbSjRN6U2VUo5BtOSK
 3Dl_ZBsoZz6EqA6_.YTNJD_EkGt6G.lK9ueS89Q95q_XKYJZvBTlF6CVOphgYg5BOncKFBwep2HF
 vRq5PvKoUgpvIXIXh4bIIhUjrp5XsvDjktRy0EBMEe.ERerbIMHt6D4oqqcEzhZKGMTk.NeaI1F3
 HzQeY9IfZdoTYv1E8Veh7OAPPlR53dBtyHO5rnIoJKKkCmU0xeFgzXNvv4hYjeg.aYZhLdkCFdIA
 JV_9cur.MTd_bEeK8kDBANb8mdANnJVVppCsULV3yyzqnbLNcf6Pjqw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Wed, 3 Jul 2019 21:26:01 +0000
Received: by smtp428.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f0d1593ba5df32fb20abdbc1b1b8a4c8;
          Wed, 03 Jul 2019 21:25:56 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v5 07/23] net: Prepare UDS for secuirty module stacking
Date:   Wed,  3 Jul 2019 14:25:22 -0700
Message-Id: <20190703212538.7383-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703212538.7383-1-casey@schaufler-ca.com>
References: <20190703212538.7383-1-casey@schaufler-ca.com>
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

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
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
index 313e45a3cac3..dcf20da87d1b 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1280,7 +1280,8 @@ int security_socket_shutdown(struct socket *sock, int how);
 int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len);
-int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid);
+int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
+				     struct lsmblob *blob);
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
 void security_sk_free(struct sock *sk);
 void security_sk_clone(const struct sock *sk, struct sock *newsk);
@@ -1418,7 +1419,9 @@ static inline int security_socket_getpeersec_stream(struct socket *sock, char __
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
index 3426d6dacc45..933492c08b8c 100644
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
index 82f341e84fae..2a5c868ce135 100644
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
index ddb838a1b74c..c50a004a1389 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -143,17 +143,17 @@ static struct hlist_head *unix_sockets_unbound(void *addr)
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
index fa7ab1334f22..fe76dfa0f2fd 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2120,10 +2120,22 @@ int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
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
2.20.1

