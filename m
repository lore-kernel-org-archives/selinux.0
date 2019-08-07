Return-Path: <SRS0=LK0T=WD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49832C32751
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 19:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC7221EF2
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 19:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RKkwrBg2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbfHGTob (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Aug 2019 15:44:31 -0400
Received: from sonic310-27.consmr.mail.gq1.yahoo.com ([98.137.69.153]:45290
        "EHLO sonic310-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730010AbfHGTob (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Aug 2019 15:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565207069; bh=Ka1Gx+I96hAzkKoAYSBNjQ1iDMrTZlQNs08b4b4eI/w=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=RKkwrBg2YQsccDAD+RnombiWAltxqr9vwdQFJuYBSSQoNcde14MnS78PKdk6WK9j3JFVyq2CFM+E6b0u6TUSNlRfXuq+j3eDCqsQFBHERgJpWhqVURk8C7IkZhH2/QMlGJjpXbFbR/uFrMt2DE9wgPPVY1GB9Q/EdMSvbklw6BtkmeY5GWwIL+ZtFDFkg/w2koS3xboSEZcXTz1i/xizhar/eXwrpKBlW/EcTeVFFtW4s9LjrVYI2rNLdivEwwopFs7WKj0adaac9AAvvbB0SChfVEDrRppmq3k0gVSYaTBbatXh8ksaEQ3ojK6J//1RmOcTZKjQVrqEixc/KMiNBg==
X-YMail-OSG: mYT_7fwVM1mJCXF3249rhkV7wVR27r9nbDlJkVHNjqA9KumjpM.XpqZkeRUIglt
 sZRUYdCgMKZdzJr7EH15kWQqRBTH6ZQOVk4W.9IQg8wgMocLeTPDhxM7Fwl0pktkDWYubAmLlSv.
 DGzFOwXFxsNabnGTUA0Ompd6oeoF3hG_jgh8M8J6I4D.NHKYFKn5O8b4S95cqaGcFjEG8NHXCNK1
 M1LPkboJVyB.g_6E2zRg5KOGRaYrAV6XHFc.cgSEO16j_hjqJbUeEyYrAxRd_mVrhggLObtrNJU1
 dJVT9HuS90tKNnBwk23Ea22hQ2vawK62nBWNum1KO22gE5VDuSxmmSRN8Y3tW2V_9VKpMWQpmDsz
 A60m8Tz.KS1nSQRWCilmlHpv26Zj0l3lfk9s9oL3NBPny9XXgyMRAuVXec9EWOGx7S7YtjgNfGFC
 XISiTormEZIzhzYcxK6DGY._VQ1iW_g74rnCDJeG6v6yYKOOcgrzpnwGzD0rufRnz37bno4PXGIb
 wARo0.RdArsHao.KvPdzeVdZeivECUlEhG8WJ_DW4DtlbWvHTWZqvY5DX1zgA1mSDj1kFQJRLG0g
 RxAsIb_BHcnpacZpuiE2WAjPKMhVZ1Swb_aTYpnDnA3fPWvGZPTE3b26FcFI_NiRZO6v3NcR3dC6
 8isadcMZ8oPz3elfST5.ceKxXU0J41nZcrkXCiaIc8rqxjiA9povnTQO2UZVLjnt9lXMF7rLfztE
 VxZ8gx3Wbis3svohkeBXwmxITRZD6Tz5uciWAk_ZIEJSKHv30I6CBK_gLIZiXy2Q7Z8lWBvro722
 1ZvFLUaTp73BdbtUSK5Vr456tsGoT5sGWTSZiN7b5kXYTqnVciA5TbQKL6aryPgnPBtDl3LjyrhC
 1UzNBWkzeqoK8iXAK1MK8rBDqF68IYl.c3eJgSuJnVbKo8PJ8GWrjWwi1CcLf7whQHxVHzBzjelo
 pySebF54p54PgMts6eZiK6_RzuhYAx55R9VY1hpgoRJdi2bXNW5O7SGvjolxFSSn3gXATerfDbIr
 nrxFeyyHd1H3PQKCEI2flVXqcqz4XKlINc4YdKoW6Mjamr84qwbl.fcmtXnEwcDxh_1o_.YB2hXo
 xVEdXH.PAsl8tbq3AtuL7S_hZICc1vxLXSfNB9kwhq8b8SLmiJByspKdBBCaTKxxNqXVJgw77DnT
 00AxCjRm1cdyMjaErkE7YSo7iRjJXVvV8S4aFepzcSbLK5ZfbEoZCkENjF.z_2lNYmwyQmPpiA2O
 fxF1Xr7ZxBw6bg0TuQjvqOoaw4x8ZkccaZU_m0qNyLk.5BiV5Co460lXAH18aURMNGr3UJVcsZwq
 hBSDkQHI3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Wed, 7 Aug 2019 19:44:29 +0000
Received: by smtp403.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 58c279a944991d666e27c38577be4792;
          Wed, 07 Aug 2019 19:44:26 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v7 07/28] net: Prepare UDS for security module stacking
Date:   Wed,  7 Aug 2019 12:43:49 -0700
Message-Id: <20190807194410.9762-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807194410.9762-1-casey@schaufler-ca.com>
References: <20190807194410.9762-1-casey@schaufler-ca.com>
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

