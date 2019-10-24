Return-Path: <SRS0=vsEg=YR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3410CA9EAF
	for <selinux@archiver.kernel.org>; Thu, 24 Oct 2019 20:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6CDA21929
	for <selinux@archiver.kernel.org>; Thu, 24 Oct 2019 20:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="UdKtZHtd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfJXUx2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:53:28 -0400
Received: from sonic316-20.consmr.mail.bf2.yahoo.com ([74.6.130.194]:40109
        "EHLO sonic316-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728615AbfJXUx2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Oct 2019 16:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1571950406; bh=LCpRAal86o/xAMqGwYkdQW9t87uiX/01PxsMjwVKvIc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=UdKtZHtd7nOHxAVTS2P68s79/OwhBtuG+jb8KSrTFr043VktAAW0Tvi2IkWxFrmiz7U4CfYRsQ+q51ZYwN8iNcD4eypOzWiPXzkYyXl+xLFP6DjHidhnHUiWYUGl2Ee5xWky8U3PLa5BD4bgWZDGbHN9KLOwcT/SdDNODGUkimLB6srchjfYJq2OLdLfzj7gQffFtc7pquFumg029pZlz4CMyudejZnOXfCXNL+9DdvC8PM8N6XtH1blDFhkRNAwQPd/ky2J+mI6gIYL25N9IuUhFDzybqtmyYpLfpMJlgECPbJ9a8mMIFXSmy5/IBlpMh9QSRmvfFv+SNE09L5NOQ==
X-YMail-OSG: 7lvMzMkVM1nRoOMg7NovAmreC.ZYpQX6BTypk1ydTs7ZodzzZXeHS8QdiyPZzkx
 P7k2lY1uwDI5M_TGcJhS6mHLMpsKAWHRsAGPZ2ipYgoa0Xyi6IpCkNtBJ5vnYvxJNiwTgOeBYbzp
 zUnMm.pWxRUA7vCkqfWJUGz0seGlBI.v9zHUrtsrKQ.t9ORR_I1XVvow5A3bCjf4.r2XZtMp1S2M
 7GZWCKBBuZ7k_PYoA2cjl7qGY6TQ0zfluCYDzMxH.tC9dvr1p2wh4Nx1sGsqgQEA4F43gEWu1ooP
 nT.ImhoWVgd7RLsrC59xd0NhKaLope0YAdMnltJyjfmo5v99Q8uIUhO9m6mGxSBHbRMt50kfe..R
 6imDZd_UBt3ebI4NN_ExpY6vBeG1tOOrmGyYxvYW395pBqJMeRkrPDEXvfRDUEUpW4kci6TS3sYY
 MeprGnrMITFvT2wISBuF.cOC4NKBcZroCfMwovVTivgLvJmfMEWM46.SmSd0dy1MIjUNqc889.pr
 qtLb_2wC0v0dtISq.Qfld_Qp4fTVPeMlJ8WX_YBYwr51O5oOPEibCe3AGs2WaXgwvlP02uOKeLbb
 A69wEGwo5m6wprwlrHL68UM_q.VDS.loOM6MwxHdc6SAHK2x02JQ4olrl0gUhGu8Ls5td4t19j47
 IXXJ1OKqaLs7mmIZ8UblvnTvNBy6yjwM_sCyASZgFRtoBZR2fxQVFXT0yyVTC8.mrNqbHVmdrpKu
 qda9ykUnr6FgeEsn.GDThweGItoWKWvSS7_v6TT.Wwqx8bthwtJovDlXEV4Ofq6h__iVmTHoK_cw
 klcJgbxQNSVmH8ELHFZlXJfCVaZpR0MvvbBggDv8Vs50kn5JbrP.0Vbo3RupLPQ6tNFMcubE2WsG
 TgjcYGYzrj2vyQxSzcIkXHeyW.gAO7mCKllBydq5Y1m6n4LJ7nGXRP_yL4lqC7TDxVIqEKk_Gvk4
 jXQzk4G6HtziKMLhTI_pKJEzUD6wogeZqszSKsrrHaXmUz2WcuqUSaq00DP_AICkYld2v_gOexDi
 hJM5Xmr0Io.IveSkoxkSFEywJqF7cKHBTh7J3lNu4DjaE08cMLGMlQdtYPteH7DoP_IhA7Qw5B3J
 r1Z5jZWwBgldlH8q5MW_CcMmYgcsNV.dEWOvIqjXTALIjuQm4Y2bkRN75I2Hbmi5b3A2KjGxSVFs
 hFI20aNemiN5.vsBbMiSP.ZnKP3r1URPgbbytA5ztOQiFpNLr3x4RuO_3duz9NlWLHmhxOGhmWQo
 UGYKn5aUkfia8AG92.zPvEqxqRRmYh1nPipmOt0wTm6mzQu2mhM9d0EJy9g4zOEA8iPb2DGmaxmW
 B4Eou7lA3RqnrF7O3MGuB5E7_4LpssuD46qn1Tqwp9BKaYRvPOi7LUPLyzO3NHk0Lwfv8Hu1.E85
 j3XmX_LsEYPjGHA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Thu, 24 Oct 2019 20:53:26 +0000
Received: by smtp403.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0cc137411481ced1a298f2ec2316752a;
          Thu, 24 Oct 2019 20:53:21 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v10 05/25] net: Prepare UDS for security module stacking
Date:   Thu, 24 Oct 2019 13:52:08 -0700
Message-Id: <20191024205228.6922-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024205228.6922-1-casey@schaufler-ca.com>
References: <20191024205228.6922-1-casey@schaufler-ca.com>
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
index cd09e7b1df9f..02ff6250bf2b 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1272,7 +1272,8 @@ int security_socket_shutdown(struct socket *sock, int how);
 int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len);
-int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid);
+int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
+				     struct lsmblob *blob);
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
 void security_sk_free(struct sock *sk);
 void security_sk_clone(const struct sock *sk, struct sock *newsk);
@@ -1410,7 +1411,9 @@ static inline int security_socket_getpeersec_stream(struct socket *sock, char __
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
index 7879da7025d2..bd685be33b56 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2059,10 +2059,22 @@ int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
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

