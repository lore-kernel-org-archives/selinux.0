Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05702C433DF
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 15:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE7072078A
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 15:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="bakJMOLa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgHZPHJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:07:09 -0400
Received: from sonic312-29.consmr.mail.ne1.yahoo.com ([66.163.191.210]:42121
        "EHLO sonic312-29.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726750AbgHZPHF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 11:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1598454424; bh=dRuIHqrYoyMrNzayqRGMBFTFg9dfnH6r1wMN86aXnlo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=bakJMOLa7GLTBD4YhOG8OSyPMD0frIZuQKQX3slJejUpKRiDeUraaQhPPgRXBQ0DzErj2sQza2nf0SJWIJVxtWUiW6SHJzXdp/LofX4NAyxp20r/QgvYwIhBMYTkgumM3FmlM9BnT8SK4hWLAfZ8YcjfaIhHG0SQQreu8IhGktO3KJozfN7p8fkigzpn0ZFWpe2UshJNyTW6sXxIn2QU0JNZevjWjOcUcpZBvBLUtXvu3BWW6aPeeJZJFwxY1uqcbc+MFJEGf1glex338Mor9e1yiVJBIwFRTKOEqxdQV7yPeFbv1zHycpz8uKmuFRreqBUgCWq/YFbD5puj0nH0uQ==
X-YMail-OSG: EvxdTMQVM1lENv2nsqalH1UCmxnrZBVivbml8.OQFWPP5FBjZdbPghPDfsIAmvR
 68SamD0I4j0tTd9oPmp5Z3obS68NL7hD5_rpKZFSgTAwqmbDNVJGQd7sw4FKDOmBHnZTbXdlLCDQ
 vsabo.pr9z4fOw64j0y_6f0.3WStwv3M9qzwmkv88Q69_FrQ5uQTt1q1dPl0gb1TN6Quim4ZPdM9
 z1JU78cvqpcP7ObqQ0si7nOUUMn6iyNNh8bjGcOclaRbu9ZCzLdu04ojo_KcoYwM.P5nLCG8W6Jy
 Z4k9hA0bUSdKt.8ZFbqhFtX_xgj5GcfTnYHM9RZp4pdN6QRSLwD3StsQVRyXDHngLDYYE3paG.GC
 jd1ye1Fa_b5LKce2bFWs8kDGix8FYLYXTG71jPOwzgHBcIQgSTDVBFvyr..awaoc.7RIOcCMOtmQ
 9VuMLnLU.cA_n_ig2udyCcogO2rmnPKZJbX5EUud7oNCLqfWI93V6zml9PAaSb28hxuzd9cyfIrc
 _DW10yoPMJYLeMBgjXray4eUjSUHWfDto3WemyNvMWODrWBRtqLdGZN8C.FaLIrYRz95.1QVj7l8
 JFP1a23y.6GEZCThhWvnPwjqFAatpUpSLDy2e_JgDvjv5mE2JlRhIh9iU1yFTmJbEiM0svhthEyS
 6uAu3EftunMbc4Aq738iQiBxB_OCL0twchqkgJDdK6xSpdomGUF_j_mxHTK5i8ZhbCmU42OAQknR
 gy6emNRHpkBbqyzJX1SAxm.H1HZfmvuStCr8fakh2glk2qayhHEj9fpzRWsqSe0jPEMeXWkbmJ0T
 w8bTmiXo8GoBecx8a5pV1a9zqB383opcWm9CiSiWzPZShlPxCcxANIeZle6myUc0tol0aNcG6Y2H
 r0gerx6dDLVoIJ7u9lv__tjaHipw7Bm2X_Q9OuQ1L5IPj3VVvv4SerTyqsuNSdKpzEHnXGmsxtUa
 gvmKbDb5B91wJ9P_hFRWpw42a12nYsRkpPErA3Vk0ZskxJV2kKy.j7Tq8NsDwEsbRhnydyrBecKk
 3wovu6r5o6VOsjTLihWifn31v3zkZMCMrQa9sJQHYVL2CbtpQeXYZZOR66L95.VhucjP5wCWv5tA
 IW3ZT2XeUwQ3wxAd.jA5tIsOZvn6ARxT_CdrS.meIc6pdfav3bnkw2JtbF1clTmJW4p1BPdOUlsG
 QONsWsE9TAhScqaGSjoJ.VQvy6y9yZ6GP37hCOWjgLOWILGn6YxPRQVN6lZ62h8Sjkh1Nwe6.BAL
 3WSO65JqpTy1vh5kgMzrdDtjzzAYGDb0UVJVDPjhpu.5P6wPHTb1knHNbOYDKlGU3SU818FaftTJ
 mkxcyiBaT1LpZQtzbDXd9n6pbgOtk71lxYmCUA6qaTBwteK8IdsuxfIaYI1DBIF0JS9RlrmjRwVb
 Z_ZUuz7AOeYYs8oofkGjMpT.RUUI7B9dsxUXToR9OlqfAA.ouNflnYpaxOY0S4Y1UBFhdy1ULChi
 KJXchxGRJVUPHxPQuiwALyNH4PSfQYHwm7qRNKi3drVp8482Nrj8v_TYt4Lg93mn_HHFpQhnLWz4
 xhl8NJpSlwNb4cr1p81F7X1OI5JQTcNVK6BBqyWc-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Wed, 26 Aug 2020 15:07:04 +0000
Received: by smtp420.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID c9bd364ef6fb7019f43de6f5fe8ff325;
          Wed, 26 Aug 2020 15:07:00 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v20 05/23] net: Prepare UDS for security module stacking
Date:   Wed, 26 Aug 2020 07:52:29 -0700
Message-Id: <20200826145247.10029-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200826145247.10029-1-casey@schaufler-ca.com>
References: <20200826145247.10029-1-casey@schaufler-ca.com>
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
index e2ef982b3dd7..ae623b89cdf4 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1398,7 +1398,8 @@ int security_socket_shutdown(struct socket *sock, int how);
 int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len);
-int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid);
+int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
+				     struct lsmblob *blob);
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
 void security_sk_free(struct sock *sk);
 void security_sk_clone(const struct sock *sk, struct sock *newsk);
@@ -1536,7 +1537,9 @@ static inline int security_socket_getpeersec_stream(struct socket *sock, char __
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
index d2c223554ff7..551dfbc717e9 100644
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
index 181ea6fb56a6..c15668b80d1d 100644
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

