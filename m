Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF059C43381
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79174206DD
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qXL6X91m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbfB1Wok (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:44:40 -0500
Received: from sonic307-10.consmr.mail.bf2.yahoo.com ([74.6.134.49]:35135 "EHLO
        sonic307-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730867AbfB1Wok (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:44:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551393878; bh=RSqSEvaBx7UTvvKVvcE/y3/4YoVYdeGn5BMn7pYi34w=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=qXL6X91m1HCTM0lgOpG6lXoFIxokR8MlCDffR5oIly76ZzfH/HL3gv5ptDJcJzrLOYu0vlAB6UR+kF6AYFP8acSU5z2F8z9xlU7VTFIZPv1bj4XhP691/Iu59MWhFvMn35oEehuuciLYUqGbKW09++W19yNI3r3TjK7j9gDpAstLKhP6jVggSsDxpeoeUxbJJtY+aCSU+5Sxgxmd2Xhq8AxZhBlz3yzoW58UEDQ7y27AXV1DZNYKoTZePIBt92LUxbEOkruVoGYBOePrQC+pRQQRbsBW6FU+vZmoHRgzgWeXjOGdoIsdyr9BzR20321G0ic82Zklb/qF9gHMjiG5cQ==
X-YMail-OSG: NDasVvwVM1lHNtnA9S.LkQOWcDHKY_rKfgqHYnSZtSs1fn64LGTVO9fbTm.ySZn
 63f7wJFX4qhH.BR2HaJrzOqWT5_0nxvEJMFoT7anDHU3RT40oO5M00jsIbLWvjib3AIhGOX8IkVc
 dULVvD3kY3B6nms8bXBLDkL4E66KMH23t9jfFSCYkXh5nDIogwbrDwlzpQWsf8PfqDgYvu1aQznm
 N4aR8f.d78YOVdsD0f9DPMcenr8KqBLGveGQhQEs4flcXcT70UgIcbpbp70zLc8x5LWfjLw2QnI_
 KCfB5NdKwHgrWtsLGP2XU_1hX3EuaEAfxRQ_U73jQ61F1eCyFdVXsKslxzoh.BqpMaEXt93.ZqDH
 kHrRH0TZFfU9MoaJXmx_4Z1kzqscTgSKH0P..ANSydbpuQZznItFbxmoj78uOkaZ0xNMBrOYP2m_
 WtuGfvDYpW7EoO2_XpGMo6_WW245lPC.Es9uE2_mujdTvYQzmTKl2slHwX36h6nkZblA.qqDOu4P
 KKiNP611lBSuH1pWZ.32TU0M7SL2YqRnHMXyCAwu3SX7yPaYF9KpC7aeYz2tS3ksOamru88BtSgU
 FCQM.K4VDtlGBAbOWmybTDddhQAY_E9uhQDqKkzZWgPC3xqg3fuPRpX5gREei4A30M99p3EpP0Xh
 YDGoWveKuaFNGLUDIPq9pb4G6614D5x7rBOqbngOHHp3YAQNqCxjMiL1tyjTHW5v0UflxjVPEev3
 kwSdUGfIalfcf.JuJihiASJ5eUxX16.7N7acdT7pTgl64nQU3fhr5Wtmf.IKVnfuS7tGigDosHYG
 okeZ2TAg3Zt6.F.cwaObIE__gFb2EqF6Y4SCu3t6eQ1nkds.0wmhqEXB7aPii0A2BUzcdo3JgBDA
 lZokOOC.I7V.1QhddJtAtjtw7.rwi8_qLbZmb_s0DdAblNw7CsrmgytGvA502BuFDbHfpgXQKLqJ
 F5svrvoC9VPEGnizGDjEFCek7sclYFs8M0WSyaBPcVzOygImqEg7sfpF33wW_VIzFpTk5PIfF9js
 X8yZLIEermvnmnKItgPRcGfSJDhopI_FCxbwwNwTJo1ji.x60WrUEW0Rk81EqBeIcYxuxeY0FHMT
 el2rcEecDvFoInUVNGOr_svxBebIBKrMRSdk-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Thu, 28 Feb 2019 22:44:38 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp430.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 41bc5dec9e4ecaa87e9a199cc17828e6;
          Thu, 28 Feb 2019 22:44:34 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 92/97] LSM: Remember the NLTYPE of netlabel sockets
Date:   Thu, 28 Feb 2019 14:43:51 -0800
Message-Id: <20190228224356.2608-23-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228224356.2608-1-casey@schaufler-ca.com>
References: <20190228224356.2608-1-casey@schaufler-ca.com>
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
 security/smack/smack_lsm.c        | 10 +++++++---
 4 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index c9a88b7a96a7..a860d9936ec5 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -145,6 +145,7 @@ struct sk_security_struct {
 		NLBL_REQSKB,
 		NLBL_CONNLABELED,
 	} nlbl_state;
+	int nlbl_set;			/* Raw NLTYPE	*/
 	struct netlbl_lsm_secattr *nlbl_secattr; /* NetLabel sec attributes */
 #endif
 	u32 sid;			/* SID of this object */
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 9fbf22a3ca57..b6fd905e6e9e 100644
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
index 147afb9233b4..8df0744ce38c 100644
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
index 086a3f696baa..1b9c7e5e801a 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2326,7 +2326,7 @@ static int smack_netlabel(struct sock *sk)
 {
 	struct smack_known *skp;
 	struct socket_smack *ssp = smack_sock(sk);
-	int rc = 0;
+	int rc;
 
 	/*
 	 * The netlabel code will handle changing the
@@ -2337,8 +2337,10 @@ static int smack_netlabel(struct sock *sk)
 
 	skp = ssp->smk_out;
 	rc = netlbl_sock_setattr(sk, sk->sk_family, &skp->smk_netlabel);
-	if (rc > 0)
+	if (rc >= 0) {
+		ssp->smk_set = rc;
 		rc = 0;
+	}
 
 	bh_unlock_sock(sk);
 	local_bh_enable();
@@ -4060,8 +4062,10 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 		rc = netlbl_req_setattr(req, &skp->smk_netlabel);
 	else
 		rc = netlbl_req_setattr(req, &smack_net_ambient->smk_netlabel);
-	if (rc >= 0)
+	if (rc >= 0) {
+		ssp->smk_set = rc;
 		return 0;
+	}
 
 	return rc;
 }
-- 
2.17.0

