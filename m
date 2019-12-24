Return-Path: <SRS0=lMs6=2O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA32C2D0D2
	for <selinux@archiver.kernel.org>; Tue, 24 Dec 2019 23:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC00E206D3
	for <selinux@archiver.kernel.org>; Tue, 24 Dec 2019 23:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="dghlInyw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfLXXUE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Dec 2019 18:20:04 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:36715
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726272AbfLXXUE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Dec 2019 18:20:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577229602; bh=yhnI760CPr/sBafiHMdBGzxWiIu4dshXzgZSP8tu4fE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=dghlInyw3nF9hd7xT727DzxyEOPBeSbTi5bHopmSBG+WZIgPaJev7OH3pR6VFx40F+trIXot4fOvLWl5KFHVLCgMRof6bFHRxsu6dotwIc5uNa//S9FzMXwXJ5GFsXABOPvsW7YCHJSyw8xHN7iSdS7B43ps0Tt2idZV7Eh3MTzotb2RaMTfRiKOnMvwouboSMHfh3cLpRFByfMpveGFiOGi7llup7Z03NbltV7VbyCwAJWMaUUoE0WRGU0bnD7vALkXPYNfxTpbag6XdA6UKQCdzrYdEm+/GKbXCztPwG4PGBNiBNpgr8gl9SL0zItfadYBBEdlZ24kwOV0NUg0/A==
X-YMail-OSG: aygCMf0VM1mWdWfs5xz.L08uRcnxyg51y.VNcLn1G.ya4Rd2d1xeji5iN7L00Oy
 dpqYB5wWzJqr1DsT3fo4s3XXGNEtxDZJloufEsAFzxnoCFq2CCJ1lpzR1kzll_IlfwCtycAt_oIF
 eyjdxeEtvB09A0mZPfuI7AZqaeRXbGLk7tBKdypHFUAfQ9fXoYlGtRhRTSQMDdFmVwW06rE.XPH.
 wm6AkSFCxsGPn20LPMCA5l2XFATr0byCOBwZnZB2jKiH8.Km_60SGC35dlulC_clt3pGPOhKPJli
 Q5JiOToChtRcjiaRExLcDmO78XnjMAVqre6HzndMaUULdIi4ab8sB3ueeVGvwv2qVq4o6SGMEVqS
 8nHhFPEIuvDZR_jUOrP1j9HzKdbo9gHRHbr50grWzS3lN.PvU7mr4NxsNpy.tz0jlNNWMo_VK6J5
 qxbyhIJn7Oi32gH.0e07Q1YHsCwYGOiUyUOHQxZG87JJzgdYa90K714faHIe8ChyoaKKsFG613Z0
 9B_VaLp1BP4Myc4BSJyeGpyUXf9Sw1wgsKndOC8P5XLwsxFy2eE5zS5iHeZ_kba6AlCGvC4RtOl6
 rxY6hCbZAr6RBl_IGdTtGQd7bsJFEan99tHTyJpp4Ujd3eHxoDMcKzayVwlnBt7LeoMxtZ_Kl7rq
 8WvbOg0r61u4h61e6T_6oP1RXTfq5_EhZlNtT2lIXKod.5jtnUKYUCxlcx3LWSEc2lE5DQ7DEByp
 58fSEj3GORG_iOgW8dwQAB1dyZSdmhGLl1dP91X.TTsEXn9.3SQVvAJBj8EiVAGnAc0u27ItZova
 eNqVd2KE.WjvcKiXHwzowKU9LVRvNjcyBPlSznd3uDE.DrN4oz6j8un0g7tDS8Kerrq6vzs_cb2J
 s5OyV0NtwrsJFCQxRlSDqkwV4hK5SqjTkLbvm3e69nHI8FMELOsmoED0DJNuU6qPxM2Ln15tFMa7
 RaHpQl7FDhuG4927iqHoLIJIbpMnghA8g0YZbdMHgMPFk0ggbUP9AjM7D0oioZcfoY8H5gsWBiGJ
 xGZB4.XVVI0UOG8IZp3eRxEuqBg3uOxAgxku9F5G1yLNX.T3Wg4bo5cueOUI.EmJU4Fo4zIN_0i_
 fVS66UEnK0yXLZq1art5W_h7rs92GQB_r5Ajl9qMCvieE3Hw.BS4ueFMaqJVB_7WiOe.0315m_oE
 EomH3zSUT51oHHGpP9DZ1Cj8g2Fp4Jef4OzZfcNcRMTuDYFk0Vi6L7DJlL_mIjLeLo2FnRfbt_6X
 SANPMAePLaVMXS1b8vtw.2VCD73nTWpSQsAK5A9aEyiSWhwVuPnudgZ4eCpLIPEdbrHCmugZxfEr
 ITv_pskcxxCRD52g0XYp3J8eisZ995lwJsdEbKE79Rg3NI1z8g.0gsXJN5Z2I9ozDtuHK0F2Wp0e
 4rlAu6JMap2g8vTeK7jeIxGUU19V7yOTvsBJrHWM3E7uZXpT4QyCQp6JbQGppoj3v43U-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 24 Dec 2019 23:20:02 +0000
Received: by smtp411.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID de4ee649edc9f9bdc14d9d12d2a0a973;
          Tue, 24 Dec 2019 23:19:59 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v12 05/25] net: Prepare UDS for security module stacking
Date:   Tue, 24 Dec 2019 15:18:55 -0800
Message-Id: <20191224231915.7208-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224231915.7208-1-casey@schaufler-ca.com>
References: <20191224231915.7208-1-casey@schaufler-ca.com>
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
cc: netdev@vger.kernel.org
---
 include/linux/security.h |  7 +++++--
 include/net/af_unix.h    |  2 +-
 include/net/scm.h        |  8 +++++---
 net/ipv4/ip_sockglue.c   |  8 +++++---
 net/unix/af_unix.c       |  6 +++---
 security/security.c      | 18 +++++++++++++++---
 6 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 322ed9622819..995faba7393f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1356,7 +1356,8 @@ int security_socket_shutdown(struct socket *sock, int how);
 int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len);
-int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid);
+int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
+				     struct lsmblob *blob);
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
 void security_sk_free(struct sock *sk);
 void security_sk_clone(const struct sock *sk, struct sock *newsk);
@@ -1494,7 +1495,9 @@ static inline int security_socket_getpeersec_stream(struct socket *sock, char __
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
index aa3fd61818c4..6cf57d5ac899 100644
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
index 7cfdce10de36..73d32f655f18 100644
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
index cee032b5ce29..a3be3929a60a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2108,10 +2108,22 @@ int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
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

