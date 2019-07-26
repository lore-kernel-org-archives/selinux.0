Return-Path: <SRS0=eUs8=VX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB96FC7618F
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 23:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7663021994
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 23:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mDNhGR+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfGZXjg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 26 Jul 2019 19:39:36 -0400
Received: from sonic303-28.consmr.mail.ne1.yahoo.com ([66.163.188.154]:38034
        "EHLO sonic303-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727660AbfGZXjf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 26 Jul 2019 19:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1564184373; bh=Ka1Gx+I96hAzkKoAYSBNjQ1iDMrTZlQNs08b4b4eI/w=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=mDNhGR+ojUH0ZTzt8iLMxPAAza8eVdbsCtwHMxeeqkh4RYc09iyOFDOkclg6pZIQWypJHaceV6oeF4SgBniV145HhhifTdPc+V5ttIWesAKWBCNfZAM/8FGALXDCuuS/ty5ZM7LrM9akL5PtpqSpDX30f+bOyIhRydzDhEXq1WyLdaKxZnkwDtwc3w1O4782HlfTUtU/2u2T7vpiv7zgXul5I6eBslbiw1DBlglWDxuc9sYzNoVSMuhVVP3nqcNlknQ8wkhzXhrsna0KCrVtCFRUI7dExDEOcT1Vy65bnFiv7mXxUBvEC/1GjQG9oZ8uPglzCW6BIej0NqzMWs/lWA==
X-YMail-OSG: _Tv0mf8VM1n7NP6hSVr6OHdGwN77TL91XaiJvE.jHfP9rLvO0yME2ig3tFI6nQ5
 9o_MYxZ32c4.Gu1u37oK0R9Jz_HiwRFoAAkVtUhHPoWeT60oP1BEVJ0HLlH8i805RP.kQi4K5SBD
 Qhh6EIO_dfQSTwuocQHJytmHFwcZLwdBbu.2_EkUV1qyOteAyl89Db6rcWm.84NdSBhQDVipeVR6
 3lLfl3FlHajQ4AZo6jkEknnpFqOZU5nu5_.5UVIVG1v0E0RGqnK9BamUqtfkA2T86ofA7YkmE4H_
 dsQUdwbVmSKB4SyJ80SU6FJ1LnJrwu_nPQQEYylaCyg3YRFQB5xk0A6B.U5HqP5f4wZKpXRjEC2j
 QyhBg4baRo9TqJVbnH_O5XsfUBRiy7r0vh9U2IHV5d4UMTVXK2dBTFlcP7sQJ2E6SO9aVKP2kfQU
 _PfbxVOZM0zxI75jbLBezCBS6lwKn_EeB2OKvPwjxc91cqKqTxfZTtF093JsxdsoV5oFdJnebpNP
 4oUxY..TotUG6htzbU4R5UVifLlxB__eYONUEgbhP3c33YMde7ROup6fL6qDuGe22tYp.AmuILXF
 wO85mp5eMub6pfkSqU94hcEQT8dYaugK5UUGCQNpyFF4VzSKZgX_pEXBNFQfV2ZcLICZsA1nalxy
 wW7zyNIgZjy5M0gLjGddAQWk4qVRS2LHXiBvkhgkanDsXiBal3itTKKR97stSdqIHRn27k42zVuZ
 sUkn9fASuwuyI6vfFsCAlwKtRm9RBEz5i5qeHH5QLFzs_czqemqfmkBaOHIz7dCaRv_XMQIdYvHJ
 mAuIoX2mE3EXr0LFKl.vCIiI6IzKmK6M0TySi26d_RdBrmkVH80RpjJFDDzUmKLEzOPErtA83ALL
 VVf2YBCi4WFy1afUbwvXmRx0He5zt1njTcBKDnF0E1PKIDAi5U7I8ZqMXUycixct21BAzTJDucf4
 0BlBNuKz6MbF7nCcZY7b.H0RSSLnz5dRndAIXwEY2IhyxVBYji45Bo_s4HgeRFEPwS3JwqJ7DGJx
 SjTYhlQ350I0vIdrLG92E8GAgSuQAlfWL8OBMA73lFqy.F2eDBx0NsPD9i5zXtV6IR_dM4KFggJ6
 rtXy7OiRw_31fY3gEooCYW7o00ZM.01Nf_n2GynCkbV6C.BZBZJeWEykmizJL4ah3fRnIhsPPs2d
 pbNZidtwRRZE2RoPf6Iavn8KdvyA2fDlsudwsviryRj6AP9N5BJWvUVgfbBtDt0MD5kg75KmSBml
 Clyv4i6JoZZKtkak2HiESq0Uc..Wkrosl16gugsThYgCs9DGfvL4odVc-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Fri, 26 Jul 2019 23:39:33 +0000
Received: by smtp419.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID faf3134ce3e2400a4a56efaeaba728ba;
          Fri, 26 Jul 2019 23:39:32 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 06/27] net: Prepare UDS for security module stacking
Date:   Fri, 26 Jul 2019 16:39:02 -0700
Message-Id: <20190726233923.2570-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726233923.2570-1-casey@schaufler-ca.com>
References: <20190726233923.2570-1-casey@schaufler-ca.com>
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

