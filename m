Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1360C43215
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 18:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2323206E1
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 18:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="I+m2A43X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfKMSTy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Nov 2019 13:19:54 -0500
Received: from sonic306-27.consmr.mail.ne1.yahoo.com ([66.163.189.89]:46184
        "EHLO sonic306-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726564AbfKMSTx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Nov 2019 13:19:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573669191; bh=fQopPU+QHEIhU1rMxngnZt5dLriz8PONEvXZFfDzj2M=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=I+m2A43XtMIyd1QHb8LRvPqHjIcEuAYsEq8mLt9n8M+sHVosCOqwKd+qRHZTW/Hfj+Do+U3CcpgXMda4A3fR5eQqMmUtBGRLsnxGrxW5/KwTSSSG9HtIE/hMMoNLE+GBBmyCDNnnJm1XI0x3NnwnhuIyUMmNXM2vSyEWhaUERmp4yKRtLf0J96OQMZcpr7eU1aBaPdOsLW1utp2MTMev/tNISC64GUm5+j09izxBV5CzPy97/53sg+EBz6ymbj0ScfGjHf0PfSo3sqZU1GQnsgHTtMi1BwABtgEtSjUTqMDee9CfbqtDnKGtHOe78xVMUXrkrfkcqhowdZl9TX7sSw==
X-YMail-OSG: 0aEN4xYVM1ksItE0rU28rCKKCUtE4jUEQ3ZjTNslL1iZprcwvN54ltEDLhKQ6y2
 Mc4cuq0tHRojNvhVbUranyyem4NxKltE7Kt_glxsAi0P0gajGi8M2HFP2c7mUTqIg3IN43cExRui
 eANM92pNbHpupXPNM85YWij4AyCPAlqRVRRvf.f0fU5nVskkUOLQpquxwpsS.skpXu5_XV6.wSwI
 RV1_9nhdKW0qQRPsMzD8YHvvYH1d_eXDF52y3wwIUCSB2daDqtCpMGJ4LCkWj20iLf.Map2Wy7G.
 rmNUu59f0_0bzWlA5uKvOzBcKpMisowLbsfsp7dJb6_oTNKcR2PlAbrXbFkWL0woR9brORZ_ZEVe
 1kfOIyczh3peM0rQhALGi5OK66l8C.YOc8THHmvN7.GppMg7_pl0AiKlEPZ4w.kKi1vbCvRBO2pz
 YF7fG7mjxKexNGZ7i_GP5nV5reD.bosxh8ULVBcFjTzRuGCoEuXLv8I_cQvWD7ykbWJ1svRt0TAF
 q3w8fTn2QFOd9MZyYF.3Y3YgPXhIKXCfiW0f_ZxSxoPobAojZ_x8Ohx7wRKSNA5B_P9b6A_bzp.w
 RN8dr8xNLLZ4omKVjglb59LBnzN3NvRYMiZaAJvebKK83MzJ5.4VlIFDmdF.1XxkwJMCQY_54cTq
 74dVtkVPuanK0XkwaDuJByWTRy.VxSMTv4GlU4csPrE.o1Kq_11vD8ed2IiazpLyxEn_byjUf04q
 g_NcYsltBZsrlKYwDA6kDNtGP4oOoO3y73NxXAsySCVFxyHp8_NFG4BFcj_QtqcELrEmTKUlzDsE
 xQzXlQ.h3DyaASdIskrDRtE98AsSgd11vtEsyGuprm40nEtwM9E8.lJqHQ2EURioUNjJ7fqoxcon
 peZ4KrTruVJVarHc45YDiXuq_8cq1KD6pq.G_GShGrMVed37IvJ9PndIycv5s34ti3e8pcbjg8lu
 7WYuHGtjxecspCDTwzScZt4OqtURofGBYTcwrv5ndy6haFZRatheHJPbcYrC7qRocR.dw39f5GFo
 44qk.5TLjrdUCOMbZffMgVvb4.tXlbyV0xQu2q8eYowxiZKkUEOR54TBbo3AvclZgJ79JXZUQVal
 2cG3AtSko.Fgc6rfJ4gyHiMljd41JHanLAAklKT5465UMiR9M.3INoT8iRI4sKijkxBkwe2Od.ot
 9BcBMAYawsCVVG1BjWzURbNE9GuKRkyE1bqHiHGdiVikb8WWFhyir1agc0dMH4lgnhhPO_77sjeJ
 jXY1pcNnkbwL9q2LgCg2jHWEdI2m11vxDsajmdP0fOS2LbmblM0r0X.PFsdNjFOAmN5OUVA7bJ1K
 ebVaxDUcHrhf1jb8WTRc8tdTsZd6IgLIulx3eNKMKaQWL9k4uyaEJMyAI9FfO9Evc2LpXLEZH0cl
 aAPPD27hxn9f5UKCab1Lp0TTUbhdQepjiEEqU8_0USWspO8IjO5ItqtO0Jx.fiDuQR5jg
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 18:19:51 +0000
Received: by smtp424.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 4b8701f92a83437184b73c262f5acc93;
          Wed, 13 Nov 2019 18:19:48 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v11 05/25] net: Prepare UDS for security module stacking
Date:   Wed, 13 Nov 2019 10:19:05 -0800
Message-Id: <20191113181925.2437-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113181925.2437-1-casey@schaufler-ca.com>
References: <20191113181925.2437-1-casey@schaufler-ca.com>
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
index 2b0ab47cfb26..d57f400a307e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1354,7 +1354,8 @@ int security_socket_shutdown(struct socket *sock, int how);
 int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len);
-int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid);
+int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
+				     struct lsmblob *blob);
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
 void security_sk_free(struct sock *sk);
 void security_sk_clone(const struct sock *sk, struct sock *newsk);
@@ -1492,7 +1493,9 @@ static inline int security_socket_getpeersec_stream(struct socket *sock, char __
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
index 0d8da809bea2..189fd6644e7f 100644
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
index dd6f212e11af..55837706e3ef 100644
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

