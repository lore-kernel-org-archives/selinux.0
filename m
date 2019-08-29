Return-Path: <SRS0=Y9t7=WZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93278C3A5A3
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 23:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2022173E
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 23:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="HhDvHQQc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbfH2X3t (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Aug 2019 19:29:49 -0400
Received: from sonic310-28.consmr.mail.gq1.yahoo.com ([98.137.69.154]:44051
        "EHLO sonic310-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727059AbfH2X3t (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Aug 2019 19:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1567121388; bh=Ka1Gx+I96hAzkKoAYSBNjQ1iDMrTZlQNs08b4b4eI/w=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=HhDvHQQckZhtaWCZfkK0X2+KMxc8/sBoJpqxsWEdZopL1lTuaB7ebbi0/5cj5LMz4oOhBkJSX3P8XNffc79liAKv69dcBZDQN5kMrM6OdGZhwIJppr6wMcsce+q+urvQOmfoIV/WEcFzGfhue8xYrQMbBRaUTID4CXjZFpMDE/B1aUa2CyzNwvCM2PHwc/nEf10wt7REEe6UILciZjKstI/pZvqAd1/Lby0hOVRL5Sd8luX7j2F7XSSwNf9L637L54g0qxetrnkvdllpitHi58U6sSDSklSE1BoOTcMksAp8f/s3yhbK4fHWMEaz0ONLbhaodYPs7bP+LJdUavXC2Q==
X-YMail-OSG: v5MuQD8VM1m8Fcynagn_RlVnMKrPbJjCHjxg6myIwGOd9sHXzg1a67sp2LwrMzT
 ec9RHghsREgodCn5ROuGV0QFyZuZUnlF.G75KyIKEgfCDtbAJUjqZdkjZ9HRoOgV34kPpdw2cNNL
 S8RPgnX4uczK3SAc2NJ0uZxyVX0FtugDKeeQxgZGEzJc0LoPLBsONVPyeF9OBcUzWG2sNJy_URsR
 L1yKcx3jdRr5fki9vVoNPOa_rqyZJ5ap8bU.S7hMvjt0BZty1fT_B8GZ.QejPTbf043DkEyyjZdu
 qz53G_NXMMn.51VrvL9qtRq95ZFu5U.HmY9r6R2Ct5YE.L4_iRXisX7HTGydr82Wkkt9WTd95jKN
 9w9BlBTYTNVBeu1hNxCripJu1kUZiaM43Tk16joRo0JD9COJENubHCLtS9BGwf3eYnbK3OUwkT1N
 ipK4WqoUzYTXUJkBNJqoKzSI4XGK55STy1SGaB5mGGfCWga2KO21I9rRMlo2nEnx.S..U1EBnT5h
 .NesF_BpcfW8yJx73JXoHUJxpsVasX_5A8sB46cXG22mMYSW0i1V3GL53Ns_FDH8t0KU.ibxj7iq
 6p0vrKSdFbguYH5bcgWRH.DwZzDR.w6Lau7akoqZE6zBc5nNSCGDmheCMy93lDuFH64uDFLeXhYJ
 Ez1wC7hVCBtsuRdH764qEsCCVSouum5ilNiVOeLrOJyAIoxI2zwA46wmiCZVcWQUR62BTSlaSx7s
 lguDakzr9DaA16cm6hCY1wtTn.218FRFniI7AqdJXKqG0loEYjawdvU4m5JHsQj1ocXBOiPnVZTd
 KOkTd2Dn7tKsNSp_2yBK4Jxqk0fm3SRd.tsOPmtqtpDjJSZhDFBw_hmBxp9s.g3RI9nZqagYjRvR
 ILRAdjpQhSyOfJpieE1Sv8hQub7erP3C1S5z5vpSi7b_qzMgXzUdYFavRbXf2_obUqqqIE8Zi6mx
 K2dUtwzSkYpSx5j39hJs3xjH7CxicqJ181jdweOMMhPWBxlRboxJiLk0EAguMmRdUakhEY9EFizs
 6oYDlrqDVlfcCZYHUvRkmcHdnO_d_vcO.qH.3unUmMEvUvZenJbqoBjFbCSnfb78I8coYS4LJuAu
 uwf5MpO.NAHGCG1CRbOnodWATo.c.Dh9BZ.JYPtV8fiEeGzfjebswk3d_Xq0z4jrilopUPoq9.4h
 oFPxhseQ2uOKLLqqZoapHPcWva3uQANQwGgOK2MB6OSZ3dcCv19etjxPndmwS4idTE2hpPksRjxg
 xs1VY_jEuzW8n1foAWhkxD4DnYza7jhupz1qT6n5V2exNx5JjU3iCjFA8MHymbmyWmqLT3wpaLRa
 4VsFm23NV
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Thu, 29 Aug 2019 23:29:48 +0000
Received: by smtp412.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ded9e12cc42d2f561e2af538140d1439;
          Thu, 29 Aug 2019 23:29:45 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v8 07/28] net: Prepare UDS for security module stacking
Date:   Thu, 29 Aug 2019 16:29:14 -0700
Message-Id: <20190829232935.7099-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829232935.7099-1-casey@schaufler-ca.com>
References: <20190829232935.7099-1-casey@schaufler-ca.com>
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

