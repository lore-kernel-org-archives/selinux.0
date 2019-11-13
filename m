Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E76C33C99
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 17:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9A6206EE
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 17:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Pf/rwrAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfKMR5t (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:57:49 -0500
Received: from sonic315-26.consmr.mail.ne1.yahoo.com ([66.163.190.152]:40254
        "EHLO sonic315-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728389AbfKMR5t (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Nov 2019 12:57:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573667866; bh=fQopPU+QHEIhU1rMxngnZt5dLriz8PONEvXZFfDzj2M=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Pf/rwrAOPPwDBDJIdfGdy0Fc7QTchKdc9p1cIr/a0enX0Pf8D1axDDxk/1XjHTQko8QEQl78l36YRAkPIY/XzyMqP/eYmGlgn8OL7SfUsrrZcR99TdQih5sjEwScA+JQHjkqvZuySXCdSVdIl0JZUiAyaVdpV1THgdcrcUa2NhurxK6D6npErRHqbe8tFZHdfcnCsAk7znqVGSOT5Na+k1hHd+3goj0zHb6XoDwOXpXugqqmdpEpfEMcDIyiDNW+6W08cWHDtu6/cAWwG3M+OWQ2u5/XJmxGAcH4VstmZv06YJzcO2x8zE2XO7opJe8PEf0T5weIL9bf6/qy0527/w==
X-YMail-OSG: nT1cT1cVM1k_jFBrN8wP7wV6SHSyLtNT8mFdL1RHEdsaLyN_frafdSQbp7wBxgV
 opiYq9zPFbF_xbmCQdOpF0BMjRkmn7Njow96X8fUJ4rvw9d6BVo.sdLRqri3H1R6dQja_3jrjWRj
 s8kCNJKkOX..D3YHvyrtW4rc8g5U4_rfBbRUq64cmFNJ6icExYDrxbNWLXUtqOGwRsP5IgBPjQ7d
 SxayTvUqqB2nG3aUrieBorOA_zGvyTGWHslXPeiKs5We4dTrOminFcc0vGbLh.peQDJjCTpu05cq
 YKUpJZqxzyUSt7j_.L8kpG3XFbN8YbNSfLZzbp8vmJ1.gqIbqTdW99l1OJa4eTUHMJQ6BkAa5WdB
 NPNvIvuq65YVBNlKSEwpVepdzaGPl1vBFPstCozoVdk9tj0lMtbiqMSLg..NjF7kQD.El74OgnNI
 zzVbPdI6K8ZTDF8J8maqRBEsyQXvNy2IVKv9CyC_Ca7kdKQkDf34rqj.FwG0IXlgj_0hcngbUseP
 OAjg3047BakchADracdOWkZCXz2RO8akSFwyNbkYbVzWddn8B9Cehv57Qs4uvIetERFJykEyZ5N.
 KkTCC2GkM.5uJUR64yKAtnXjXabvzS5B6a7Pbnl9WdXPknrvVdckh3ZWAe4DLIo4ReSfV1YvCzNN
 rwUMUYQMD2nH_5FmDbCXRaj_j4YxZBKhR.sjZ7s9WE2e2BqRohw.NkMWt0vOhZO2gJnk7HwGXyGX
 YcxJA_OiIYlowHuDasRDNIrdWlPr3hrNm_2rlWRCks7gJxN5nJvTDeN1vUFC8eHk236scmj8iCvg
 sXhNu28Hm8yl1twtBEXZ1SVxl4sbZig7DKUdsOiMrJBd0sqmBNbg68VRuyxIkJSb_7bXdH3PXNCe
 G.pEcGRD0RpB1Jb4o3bnCADX8R8nufbjm.qUkIRnR2Qny2pup2MvsdG3TZ3qopZRYu3leleQO2Ld
 7IihxAmLyovXKz3NAYXGUTBDXf8oJq9okBcWX.mWQLV_gKsYgWQwdfJhG4imeDuhcxEPpuOAYPRZ
 Zuq0wZNl6pUWoCM3Xk1v1QxuY9JcO0fZ0Q6HJdxnQ7WR.A1EqldSr.U0sJKtxsBoH0_pBefsNb0I
 EMGZIjej9kO0FV0PazpqRutz3qJObI.BBxzlsHyxqMzcB9ELor6Lt4Ity1..3v74acyM2Xm.sHfZ
 XZobTCPKpBYwupzrhpl9uBA_wtvAjy.446IirYNfnIrSYPmPUsTFkv7.6ggkWpHS2GfLDCHlv4sR
 xjPKszt8CkuQ9Mg7T5Lz4lXjrip1waNplTcoUU8gARQkIe9kvyakzxdrqLfjTW0xcNHxSg8SlCFx
 Yhe3owBmt4s9qbniEyHASzfSMcKrIgcdB4dXT9cMLP5MDHurbSLghryS2wzZSdAUxY_DXe21.shF
 yNxUSBfCIPM8GWBil8DaNsBnqJx_zI1bMRvK6G3lRpLZf77vEuTblKvdzEWXgWO7qCRA4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 17:57:46 +0000
Received: by smtp408.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 86d8955fc8bdd0cf32fd2f9119ccd325;
          Wed, 13 Nov 2019 17:57:44 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v11 05/25] net: Prepare UDS for security module stacking
Date:   Wed, 13 Nov 2019 09:57:01 -0800
Message-Id: <20191113175721.2317-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113175721.2317-1-casey@schaufler-ca.com>
References: <20191113175721.2317-1-casey@schaufler-ca.com>
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

