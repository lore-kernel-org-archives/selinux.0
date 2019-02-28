Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B3AC4360F
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8028C206DD
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="YMBTlj1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbfB1Woa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:44:30 -0500
Received: from sonic307-10.consmr.mail.bf2.yahoo.com ([74.6.134.49]:35519 "EHLO
        sonic307-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729362AbfB1Wo3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:44:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551393868; bh=2hYihdVmqU5qALc9NevWfXmFBQM735kkui8Pr/CoqaI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=YMBTlj1/ylHbo/3y5sQRfdj88g1jK9w6HZ7+VDdzQjO8mU6NiRlHL7CI7v2vv3zZ2Dh9qAD2KTEN9KENlja8DsUo2Zmc5940wWf7CaF+4xHqFyLCJHPAqcNHBejaQB8sDw6soJD+7odrsecvtL8sTKESpCzmOpLj6wQZYCoLWcrpq9fmg5DXDptguA4zBom68BPdyShZdc9I5jMyf6Iumdopf/OfUpSAK8DERYPQfZrF2gKY0F2itfunu/s/LAXqE1s/1GV2ZinmYHjKiA49Iol+Oxk0kz6AnBHeVdFT2clXq0flZI4y/KBXwq3qbRKMkOqVqv7k3ZzAE1Bz4E3S4A==
X-YMail-OSG: FEA2ZaMVM1n1OPndvragrJEmyr9sGjl7Kz2qA0vuCgba2jCkzv43E2P5XqUAH11
 CiAEAfaIf3FWOJ5p1feMynW27HcPHWD4TGhcDWv9vgaEIoImNTlpG9A27wvuiyqOEaYFKbi3Rrtc
 EJH3QxT3O78sbF99TyW2VSwTNCbJWykrJM.uqiFLSBHEx94V9mz52mFsKdxVfhHS40o1w2S2b9xK
 wRGntirgx8RBIDCOnHuCuoFyxqCv_3_aA64ZLG8TE1u8PLX2nKMx_mA_KgYllM1lPOW4bHIaCpaz
 Vh4A0QSYsulifp8EMaZiuQo5yXIB9mzffJy0yV3jjQGlIcePmhIyENoXiDsNKJsh7CGXqRbatgrK
 YlhaOabb1Xw_VKJxgxtd60O7K_s5JwCcL_D6gnino.mniGe2qoOm5psPbsM6pWSSqYOdkoyJfOJ2
 URwmKg0VhikTUoKMBc6k6SuyOCsm.6oEnSEj34UGpFQAUdr7Qkr07wqkMs_q6VPu.hrO2G7zpnKo
 geYvxwJEVrrem.wuYWnf6bVM2aAA6.SC3EF3nI1Itw.eNtO64wREPagCHhvt7KbEm5IN_Iv4X1n_
 HeiGk.YQsh7ZEKTKtDrn.dr8eLLgsHJCLqmjGddfyx8h2UrERAPNyXNxMhSM8zqTxnd3NXFwjKDS
 xD5huaDcWuq5ABpjMc5bhGKsa8EonxlQB653stmI7s6q_tWi2wV5iRjmc2UiJVLxHJlwt.KiOrjN
 JtKP._T.cQA8QI6FFCoDj_uiRIoiXUw0Ak9uTt9E4NkYIJL9kK2WHR7FGBK0pTDGBUJgMltJfRNi
 Ltm6TcKiNCEtZ0oNrNd.okdC8op9kscjUD6OQ2Bs3qxtTZszr71PodoLzltluAib5Z9U1J3KVsfA
 mIBZeKGgsLJgsbL601uVBaxrBJ9uYpHexP643pXp0vT4Z.c.ozdC0n8vzKCd6SCIxKuE1Whqsnw1
 .j.LgiAoMVDT5nrXC0WvA5ulwh4cSzvdgZVbnMWliCUdS0FJgUXw2IaLIdlJ__HbMQoKzveY1iIa
 lKMSSFUWJCj6X61VRHtGZwbWMufCUCht9eod4ry7ixL1b5dshwgEl4xwxUB9dzOqyG0iiljelszX
 .V2SexBYGrEh2T_dWwSkSmW7VjExECkdDqxnSsSG0G.xkYNuO8X8P5Hji
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Thu, 28 Feb 2019 22:44:28 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp415.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 46c3ca42412e81058eafbaa96f791691;
          Thu, 28 Feb 2019 22:44:28 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 88/97] Netlabel: Return the labeling type on socket
Date:   Thu, 28 Feb 2019 14:43:47 -0800
Message-Id: <20190228224356.2608-19-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228224356.2608-1-casey@schaufler-ca.com>
References: <20190228224356.2608-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change netlbl_sock_setattr() to return the labeling
type of the domain. This allows the labeling types to
be compared when two LSMs want to determine how a socket
should be used.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 net/netlabel/netlabel_kapi.c | 25 ++++++++++++-------------
 security/selinux/netlabel.c  | 11 ++++-------
 security/smack/smack_lsm.c   |  2 ++
 3 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index db6bb1c037f9..61766da2cfac 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -973,15 +973,14 @@ int netlbl_enabled(void)
  * Attach the correct label to the given socket using the security attributes
  * specified in @secattr.  This function requires exclusive access to @sk,
  * which means it either needs to be in the process of being created or locked.
- * Returns zero on success, -EDESTADDRREQ if the domain is configured to use
- * network address selectors (can't blindly label the socket), and negative
- * values on all other failures.
+ * Returns the labeling type of the domain, or negative values on failures.
  *
  */
 int netlbl_sock_setattr(struct sock *sk,
 			u16 family,
 			const struct netlbl_lsm_secattr *secattr)
 {
+	int rc;
 	int ret_val;
 	struct netlbl_dom_map *dom_entry;
 
@@ -993,17 +992,17 @@ int netlbl_sock_setattr(struct sock *sk,
 	}
 	switch (family) {
 	case AF_INET:
+		ret_val = dom_entry->def.type;
 		switch (dom_entry->def.type) {
 		case NETLBL_NLTYPE_ADDRSELECT:
-			ret_val = -EDESTADDRREQ;
 			break;
 		case NETLBL_NLTYPE_CIPSOV4:
-			ret_val = cipso_v4_sock_setattr(sk,
-							dom_entry->def.cipso,
-							secattr);
+			rc = cipso_v4_sock_setattr(sk, dom_entry->def.cipso,
+						   secattr);
+			if (rc < 0)
+				ret_val = rc;
 			break;
 		case NETLBL_NLTYPE_UNLABELED:
-			ret_val = 0;
 			break;
 		default:
 			ret_val = -ENOENT;
@@ -1011,17 +1010,17 @@ int netlbl_sock_setattr(struct sock *sk,
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6:
+		ret_val = dom_entry->def.type;
 		switch (dom_entry->def.type) {
 		case NETLBL_NLTYPE_ADDRSELECT:
-			ret_val = -EDESTADDRREQ;
 			break;
 		case NETLBL_NLTYPE_CALIPSO:
-			ret_val = calipso_sock_setattr(sk,
-						       dom_entry->def.calipso,
-						       secattr);
+			rc = calipso_sock_setattr(sk, dom_entry->def.calipso,
+						  secattr);
+			if (rc < 0)
+				ret_val = rc;
 			break;
 		case NETLBL_NLTYPE_UNLABELED:
-			ret_val = 0;
 			break;
 		default:
 			ret_val = -ENOENT;
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 4bbd50237a8a..85156a0cdfc3 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -418,15 +418,12 @@ int selinux_netlbl_socket_post_create(struct sock *sk, u16 family)
 	if (secattr == NULL)
 		return -ENOMEM;
 	rc = netlbl_sock_setattr(sk, family, secattr);
-	switch (rc) {
-	case 0:
-		sksec->nlbl_state = NLBL_LABELED;
-		break;
-	case -EDESTADDRREQ:
+	if (rc == NETLBL_NLTYPE_ADDRSELECT)
 		sksec->nlbl_state = NLBL_REQSKB;
+	else if (rc >= 0)
+		sksec->nlbl_state = NLBL_LABELED;
+	if (rc > 0)
 		rc = 0;
-		break;
-	}
 
 	return rc;
 }
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index f965c9e6287e..20eed64e91de 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2337,6 +2337,8 @@ static int smack_netlabel(struct sock *sk)
 
 	skp = ssp->smk_out;
 	rc = netlbl_sock_setattr(sk, sk->sk_family, &skp->smk_netlabel);
+	if (rc > 0)
+		rc = 0;
 
 	bh_unlock_sock(sk);
 	local_bh_enable();
-- 
2.17.0

