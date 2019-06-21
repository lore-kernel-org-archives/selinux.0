Return-Path: <SRS0=kEwY=UU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED4EC43613
	for <selinux@archiver.kernel.org>; Fri, 21 Jun 2019 18:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DDA82075E
	for <selinux@archiver.kernel.org>; Fri, 21 Jun 2019 18:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="SYSfE9lE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfFUSwz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Jun 2019 14:52:55 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:33922
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726299AbfFUSwz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Jun 2019 14:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561143173; bh=O064soN3QymagJNIdliZ2i/9J+h/1XsgVIS4eOZXl5o=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=SYSfE9lECyNXTvPGB3Q9GLL+xaLGWxIIMco4KAH4XUdkUTHKNLXG2p/lNsgrtOwLYH47ye9S7USBhi7BXCXH8fNcE/Qdw74f3VPkvX8H4Hjokus4mom/esKLzNenR/xe8vEduHnd/JjvN/LKE+rGDOcKT6w+2OU910hINBOHPfDeWtM++n6/wX+PPaUYHKrAHynYJfMRtMVSPbEy5v0MdF+QJkX9cgIDL1TPrq1msw48n93n2SPBkuiOjZJ2Zmk3hLKPDXxrnjem1bNvrOD7CbT62OcYFLhnDdq7M/ELc17RlWnunjJ8hig8fdz+rhyH5ktd3G1N15pBBrvzmueg4Q==
X-YMail-OSG: HVJneskVM1lmBkShGmHhluZ1ckhj8y_0pjmTTziVCsAMHC052aOkkntqnLDR2_D
 nCTzjk5nBLs.gAYkJUTq3wBHSBCNC6IBLKKmPVi_gC5hiONaN0aAqVhvUWVs7Woj0lz36cUzH35J
 zXQqLjhgIk6K9lcp2tlpcXdfjcKdwquPq918mt7YnYZzsKjyVZCzfdODbpW86.prntFYdH.Ejd8U
 v1YxlzlrxL8K7VJaASjXKUstScG_aa157EhO_BUQnQMscVI9qdPMRvLOppDHSg4BCaXRg8swMv2w
 HSAOkrdNl1_Rd.Vf3BKGPuMnbX_AEGNXOaIQsaXZG29VzPe4KTbq_B61AzBKguXvdputkk0ydtSo
 sc9dG5M34oAOWPdSPcLDOr_ABj0CJV93YGZr_nE6W6Pr9qWA5w9HRPf0kuI9xz36Wrvm6hPV44qU
 c81lqhfya6wEhIuFljH0.WM_s0q4hueREWxgQuqtnTcC4MkOi2vM.1mJMAqfsnGbrnnmALVwFVr3
 YXHU2Dw20ZiW3CEX9mHNNXaT4Mn3VSsEb7q4YEsMx4WSrdKg.KiLPz.wrIfsT_7BX.3Vyf3gSqUu
 qx2jsaQP1yzNjP3LdyN1uQlKxk8ZxRm3cXjHHUZmzlzMFCjvEhis1fIkMUaGOPsUahNK2fd5224P
 u.L3Qlvts53fMKKPR.iKEbPhmzqi0LpfsBOppH17Y2gyA8vUehgAkysbnPYIiP89Bm.761NfGQFu
 7Tj9GW5K_xSNB_PGTaETH.EL9qtXW8cwKFw0q9HpGonBQbFdLtdbhiHE7vD2iG4Yb_9lY5Z0AW9g
 OeQLmIO6zgHTXfd6fv7vs_13U.Epa_nltcvQEJLzFtLBHiajfn13qcgcxhTF3AK02jscD1ROKwf2
 qEhV44pv2DBik68WuR0WEKnBR0zSnZqrpZF.LwwfoxPwFqdG0XhBncNPx1ViavTxsVXPPmuHdY4x
 9Iv007iQMFAfiSvcdvdS2F7Hur3RBQFhy5A6FOK5wUh_JdujSir_SHKk2h_ESIjaIEI1Nup8Wm6W
 xDkMjLMQgWfcvmO1hFabzRzJ5Pel0F3B36WwF.QFFUZ_zjkxk5hIllKYlhrd_BtTaCfu8UVKlH5w
 Amq1rqVfCQyAr6sTLMzx6IJ7y4yvxFzdc1ldErVtZ8sWXvKvSAmS73cy0MS2SoZbQV.mdVjknMXp
 YVEsfRVstf8qMwBvFVMi9jVooc0AY9dkgPf8lPbQVDG3MMfkoqOEZyOVCVZKY8zUM5iSTap4bpmz
 QmvugLUNXRzsmfOOMwvnzvXD48QS4m1dywbLIcn1bhTR.Bw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Fri, 21 Jun 2019 18:52:53 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp416.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 1d10864c45a2fe45d2b5b4a73ef7e245;
          Fri, 21 Jun 2019 18:52:52 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v3 07/24] net: Prepare UDS for secuirty module stacking
Date:   Fri, 21 Jun 2019 11:52:16 -0700
Message-Id: <20190621185233.6766-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621185233.6766-1-casey@schaufler-ca.com>
References: <20190621185233.6766-1-casey@schaufler-ca.com>
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
 security/security.c      | 16 +++++++++++++---
 6 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 4a78516cc74a..905830a90745 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1276,7 +1276,8 @@ int security_socket_shutdown(struct socket *sock, int how);
 int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len);
-int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid);
+int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
+				     struct lsmblob *blob);
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
 void security_sk_free(struct sock *sk);
 void security_sk_clone(const struct sock *sk, struct sock *newsk);
@@ -1414,7 +1415,9 @@ static inline int security_socket_getpeersec_stream(struct socket *sock, char __
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
index 43f8018b9e13..c7b3d1a294ad 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2137,10 +2137,20 @@ int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
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
+		rc = hp->hook.socket_getpeersec_dgram(sock, skb,
+						      &blob->secid[hp->slot]);
+		if (rc != 0)
+			break;
+	}
+	return rc;
 }
 EXPORT_SYMBOL(security_socket_getpeersec_dgram);
 
-- 
2.20.1

