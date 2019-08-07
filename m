Return-Path: <SRS0=LK0T=WD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3955FC41514
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 22:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B75217D9
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 22:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="nhC3Khol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388488AbfHGWnQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Aug 2019 18:43:16 -0400
Received: from sonic310-23.consmr.mail.bf2.yahoo.com ([74.6.135.197]:38885
        "EHLO sonic310-23.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389611AbfHGWnQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Aug 2019 18:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565217793; bh=NcR9H7CD11MKd3LBKLjdg9p2YChurfqM33tVMOrp+JM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=nhC3Kholby+ym7pI8f0RXunb2thRhByp0v4XmKEDZ/Dza67HnJplrf5ViTOT/hygzyL6SkZ914k4+RUGm1+Lr6wv6owWEKqtImEwJTipVAhPxNVTUsOps0OBJr6a7amkUevOsCiSImbDrj+JvoSZ6mucLFnZpczLwTJlNtjB/l7XfYwFZDFbvd+UNohD5h4SpNtmV5pcoK+OWOYxu5kl/unjAbhHZoCKrU4iG0oG3dIBVYsiCV9rp1uOO5VAFi3tmzmDambYSv2dSrtSrb94zwOybDMR8tJ1QcU4Kho1+FT/EnRI0WnXnpHywEm61wdk9gr0tUM/IJMu2GCi0142MA==
X-YMail-OSG: L8Q.vVQVM1nhxEA6JF8_WlMxrVMd16p6mUKYVmYlKAxZp51UYiArnD.7uPnIoC.
 0x62lToLN6L5Hz7LCNG8RSbtfQ3zGzixyFl.uxg_EfSUMxt7lzPqWCdAUZxWxbFB4gXtHLjY9pwn
 PaNMbtOVKkYwdGQ8g83Wiyio0dc8pDTHLxWRInfcpc305c_e9D.JBlkz.AkMDuBqqz6FQ2Q98CZ7
 Sc5DbqUcrhoVJPoGNcbKPKNUWsMt6JOxmYoA7Da5nOWLDdzzYpjcdyrYzeQCRpzDLkgGAwHcSP2K
 Gtz4Oxtmrt7ha6Ni3Upb8xNPe8MnbyS4neZEcae.YWvxfp.GKhI6uoYhU1SMOV9zGhoyS1zqLXJf
 FG00A6MceGxlMApLSY_T5jWSKRNWKQAubj4ylqojSn5usifDHx0NrhuHWFEEtYSH.4yEaYUcOlfJ
 XK.ZfiqbiCiykkRaJhZ_.jCcQo_9o5gMWygeuOWwPomfj3W8wkKwdBOsBamINdSG7zBaQbxvTILg
 FbFdq7Jdj8Z9TvSZJlAFVr33sot2iyHqiGCXuEEKF0SOEuSoJB.k.o2EX1AWb45c33tvUziL5_EK
 bv2nPLslo3XX3WfUSO9OwNsei3kA.w3wDm1KS.ePMwELk9CMNHEb3gCPe8gAZJje9G4SkjsjWNka
 yYJSVR_xsZiXNsKM2m6SpSkQEi3g5bcZtpePqznJ3X3i.18nSVsjiDnQOXUpBHH.oSx9YLDN4EhF
 y.7T6m6XYWMS0wmw7yRcEqL9jqcKdldsiE3XorQ6faIpxQAkOErxiU5KLvwQOojZ32bSJNojDm_P
 gcV07tqdNbUMXrgHHugTlRlO4lhOYK5FMs25Wi5XZaguMfKmEsSztbIXE6dwiX0yDLCLge9YNGKL
 bqqhXAwMXR3.Z0HhZczx2cX.Y43KsxypEKFhj5463B4PAv32kUX1RWmxFF6fc5rSeQHiz.3iky2I
 nK1QV_hIscNPhT5d3107_3YE9YtwZlLVqvVjniOcgmk75KNex.LpN.OmOOdKuJO1cEmN0t1Rj39_
 tPDqmsDRK.92xkBa9UIl10XBIg07Wj7vwKBxW65D6xumyhuj0ie2J7u6AHxxQGp.GmKCKxqmRxp2
 g63fSoljFR_Z5_9OuCDEoRcfLOZjB9mVH13U.GpyCN9lKzMBZRTbzNNmWm7R7zr_OzriD2rknsMH
 1mPq_YKZ2a7daXcfPqnFajZ54uf1CpYAboBSAoYMRDCajzI3ULnWnj1xw5PtdSWmpdw5cWILzYnt
 hkzV6SMSLrij_oDehqYAjqwk.kBxABjjRnd_2tQ38.yyG714L.Zsp_0rrwHOAWYJPzsE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Wed, 7 Aug 2019 22:43:13 +0000
Received: by smtp401.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 90d0e6b59b40235a6b1cae6254f016be;
          Wed, 07 Aug 2019 22:43:12 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v7 13/16] LSM: Remember the NLTYPE of netlabel sockets
Date:   Wed,  7 Aug 2019 15:42:42 -0700
Message-Id: <20190807224245.10798-15-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807224245.10798-1-casey@schaufler-ca.com>
References: <20190807224245.10798-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add the NLTYPE returned when setting labels on sockets
to the information retained by SELinux and Smack.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/selinux/include/objsec.h |  1 +
 security/selinux/netlabel.c       | 20 ++++++++++++++------
 security/smack/smack.h            |  1 +
 security/smack/smack_lsm.c        | 17 ++++++++++++-----
 4 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 3b78aa4ee98f..5ab0d0d212bd 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -124,6 +124,7 @@ struct sk_security_struct {
 		NLBL_REQSKB,
 		NLBL_CONNLABELED,
 	} nlbl_state;
+	int nlbl_set;			/* Raw NLTYPE	*/
 	struct netlbl_lsm_secattr *nlbl_secattr; /* NetLabel sec attributes */
 #endif
 	u32 sid;			/* SID of this object */
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 8088a787777a..56e780340114 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -185,6 +185,7 @@ void selinux_netlbl_sk_security_free(struct sk_security_struct *sksec)
 void selinux_netlbl_sk_security_reset(struct sk_security_struct *sksec)
 {
 	sksec->nlbl_state = NLBL_UNSET;
+	sksec->nlbl_set = NETLBL_NLTYPE_NONE;
 }
 
 /**
@@ -244,14 +245,14 @@ int selinux_netlbl_skbuff_setsid(struct sk_buff *skb,
 	int rc;
 	struct netlbl_lsm_secattr secattr_storage;
 	struct netlbl_lsm_secattr *secattr = NULL;
+	struct sk_security_struct *sksec;
 	struct sock *sk;
 
 	/* if this is a locally generated packet check to see if it is already
 	 * being labeled by it's parent socket, if it is just exit */
 	sk = skb_to_full_sk(skb);
 	if (sk != NULL) {
-		struct sk_security_struct *sksec = selinux_sock(sk);
-
+		sksec = selinux_sock(sk);
 		if (sksec->nlbl_state != NLBL_REQSKB)
 			return 0;
 		secattr = selinux_netlbl_sock_getattr(sk, sid);
@@ -266,8 +267,11 @@ int selinux_netlbl_skbuff_setsid(struct sk_buff *skb,
 	}
 
 	rc = netlbl_skbuff_setattr(skb, family, secattr);
-	if (rc > 0)
+	if (rc >= 0) {
+		if (sk != NULL)
+			sksec->nlbl_set = rc;
 		rc = 0;
+	}
 
 skbuff_setsid_return:
 	if (secattr == &secattr_storage)
@@ -325,6 +329,7 @@ int selinux_netlbl_sctp_assoc_request(struct sctp_endpoint *ep,
 	rc = netlbl_conn_setattr(ep->base.sk, addr, &secattr);
 	if (rc >= 0) {
 		sksec->nlbl_state = NLBL_LABELED;
+		sksec->nlbl_set = rc;
 		rc = 0;
 	}
 
@@ -428,8 +433,10 @@ int selinux_netlbl_socket_post_create(struct sock *sk, u16 family)
 		sksec->nlbl_state = NLBL_REQSKB;
 	else if (rc >= 0)
 		sksec->nlbl_state = NLBL_LABELED;
-	if (rc > 0)
+	if (rc >= 0) {
+		sksec->nlbl_set = rc;
 		rc = 0;
+	}
 
 	return rc;
 }
@@ -573,8 +580,8 @@ static int selinux_netlbl_socket_connect_helper(struct sock *sk,
 	if (addr->sa_family == AF_UNSPEC) {
 		netlbl_sock_delattr(sk);
 		sksec->nlbl_state = NLBL_REQSKB;
-		rc = 0;
-		return rc;
+		sksec->nlbl_set = NETLBL_NLTYPE_ADDRSELECT;
+		return 0;
 	}
 	secattr = selinux_netlbl_sock_genattr(sk);
 	if (secattr == NULL) {
@@ -584,6 +591,7 @@ static int selinux_netlbl_socket_connect_helper(struct sock *sk,
 	rc = netlbl_conn_setattr(sk, addr, secattr);
 	if (rc >= 0) {
 		sksec->nlbl_state = NLBL_CONNLABELED;
+		sksec->nlbl_set = rc;
 		rc = 0;
 	}
 
diff --git a/security/smack/smack.h b/security/smack/smack.h
index f28db5a42b7b..b531f7ea21a7 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -104,6 +104,7 @@ struct socket_smack {
 	struct smack_known	*smk_out;	/* outbound label */
 	struct smack_known	*smk_in;	/* inbound label */
 	struct smack_known	*smk_packet;	/* TCP peer label */
+	int			smk_set;	/* Netlabel NLTYPE */
 };
 
 /*
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 62189558bb6a..87c81cbc8c67 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2409,13 +2409,16 @@ static int smack_netlabel(struct sock *sk, int labeled)
 	bh_lock_sock_nested(sk);
 
 	if (ssp->smk_out == smack_net_ambient ||
-	    labeled == SMACK_UNLABELED_SOCKET)
+	    labeled == SMACK_UNLABELED_SOCKET) {
 		netlbl_sock_delattr(sk);
-	else {
+		ssp->smk_set = NETLBL_NLTYPE_UNLABELED;
+	} else {
 		skp = ssp->smk_out;
 		rc = netlbl_sock_setattr(sk, sk->sk_family, &skp->smk_netlabel);
-		if (rc > 0)
+		if (rc >= 0) {
 			rc = 0;
+			ssp->smk_set = rc;
+		}
 	}
 
 	bh_unlock_sock(sk);
@@ -4145,10 +4148,14 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 
 	if (hskp == NULL) {
 		rc = netlbl_req_setattr(req, &skp->smk_netlabel);
-		if (rc > 0)
+		if (rc >= 0) {
+			ssp->smk_set = rc;
 			rc = 0;
-	} else
+		}
+	} else {
 		netlbl_req_delattr(req);
+		rc = NETLBL_NLTYPE_UNLABELED;
+	}
 
 	return rc;
 }
-- 
2.20.1

