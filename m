Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940FFC10F00
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FCF8206DD
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="MnGyKpMb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730951AbfB1Wog (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:44:36 -0500
Received: from sonic301-10.consmr.mail.bf2.yahoo.com ([74.6.129.49]:45597 "EHLO
        sonic301-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730892AbfB1Wof (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:44:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551393874; bh=mBl/BTOGpw7zkbjPkI0ZSNky0iR3x9y1FbWRTLx/zrE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=MnGyKpMb671zrYH5kS7t0dX89JqlqbqUKBsfP3okqW4DIH1YzpkcxkW75lbcZH4gIJPEqaRV1iE88QaQIJ1E7/7wgBaP9edcOZdHic0b72e5K+pkHNnT42YLZYbkZfcwvyFqdDFcS1cF4REdivW0Jj3vOp4osht0QAELtUxaY9oTqkrclB2i52eijLLn0UO7Gu7WSLj7xtqm6OSCB4FXC0NAZIPBXzmcvWQBYMqpBw8lc26aU3humTvxQditXZxDGSUuZYxLE8Sarq5w7CNN4vjuaJo4DibBZGjWyNaudJ22SMkUMLjSzF+ZIyMt6gin7+5iTckCKszdma0L+Ev93w==
X-YMail-OSG: leitoa0VM1k3Y0qz8zWWkxRBpN5E5rT8UMH9zeBnkVXWyQWdF.VHi2n3TTCFa.h
 4_tdUwxN.uUgCuGNb6uhygbPvhdrArk4dXUQxeBUMnj8nch92TRa6F2SRpJ54xfDGQdkoPrbnVE1
 8t4mtyqsPr7ZTfXriVqLJzTsNPb98NTlPH6llQ9xyUpUC_8c_MFrVR65zLcJzs7_LRNqRFWU.p0B
 WSV3CjX3Io2CXbuDSEx_LOYj4c0Nohm_K9TrqPvPDnsUIzr2SYNM19VzvhRQxP64Yy1bXx9KybkK
 9m3zlUsGZAhmM935cxFret3vbBCXOSx6WG9AWYEgrnCucXxVjF5sHzjFhI3zTzrxbb3zS2R83fZD
 ERkVXtoeF3J6jTCUQGlv5ySRTRppHEpJbmlFXOeatCyeILsjZVrCrEfDws_28HZjDjojdmZMdFTT
 vcOQU1u3XppLp9j80ZoRlTSnUEzUpdFzg0SrrO6Xpn2LYIqPvFUyT_grXrPDcJtGsHBOMa5_Ym00
 D7HftiA9w5SVgrxoRuEaB17kIe4qgzBaVZEN7y6Otx8s4wALccSlAK6QhnnMVnZWhye2_eoTxM2u
 d3RQ8upzUFnp21ZEmL43j.Ov6J4XfpCg5urYhkG_OulfbwMSGi4th9NuDzIUySdXof8bnwbr3Lh3
 iy0fcEmX98a9snD2FjT7GidUmvwBSEVvTlFdFjwAvbKJmpWgIdWOTN5CovDN7621czXTSd7iXPoe
 uuHnRszkY9XHyM0POUAWIfgeLxyt7uR_bxSOCkiHJNKKa2N8HiZLwKtK3.ck17cXInyFuir9ofeJ
 lv3Z2WDgecn1BYbTjWvZ0r4LVRPzztGn4wvIvSdPy3EBQrnBl0_h9vb_o2RXJFYLyzKITJZpmK20
 Vy5LJ2Sz0Nhs91qwcopelmxXfWCx8D77C8zsbHTec1pmQc8OeIkkOLGIOGMr8q7q5jJ5ESdFHnIG
 fYPzzj.ZpjdoJtd7kAUDhuTIkfSFd5KWUNeTZ99hMmFWuAp94PuB9rlRUTbbSRQoC1tDjJ0OnKlr
 mHmW9uu6qLE_jDPk.edV0a8_zJVdn4Cx5CiK322GrSnZ2JCPJJsWdqfskmecGgRBWQLcdfS3URk6
 wwXVt3tQPRJL.2WyFDoOiULtDNqQPjSL7Yl28vuzH7nLHIdBW06Wz.erR
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Thu, 28 Feb 2019 22:44:34 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp430.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 41bc5dec9e4ecaa87e9a199cc17828e6;
          Thu, 28 Feb 2019 22:44:33 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 91/97] Netlabel: Return the labeling type on socket
Date:   Thu, 28 Feb 2019 14:43:50 -0800
Message-Id: <20190228224356.2608-22-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228224356.2608-1-casey@schaufler-ca.com>
References: <20190228224356.2608-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change netlbl_req_setattr() to return the labeling
type of the domain. This allows the labeling types to
be compared when two LSMs want to determine how a socket
should be used.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 net/netlabel/netlabel_kapi.c | 18 +++++++++++-------
 security/selinux/netlabel.c  |  2 ++
 security/smack/smack_lsm.c   |  2 ++
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index 1d362a38dd05..5c5825171281 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -1185,12 +1185,14 @@ int netlbl_conn_setattr(struct sock *sk,
  *
  * Description:
  * Attach the correct label to the given socket using the security attributes
- * specified in @secattr.  Returns zero on success, negative values on failure.
+ * specified in @secattr.  Returns the NLTYPE on success, negative values on
+ * failure.
  *
  */
 int netlbl_req_setattr(struct request_sock *req,
 		       const struct netlbl_lsm_secattr *secattr)
 {
+	int rc;
 	int ret_val;
 	struct netlbl_dommap_def *entry;
 	struct inet_request_sock *ireq = inet_rsk(req);
@@ -1204,14 +1206,15 @@ int netlbl_req_setattr(struct request_sock *req,
 			ret_val = -ENOENT;
 			goto req_setattr_return;
 		}
+		ret_val = entry->type;
 		switch (entry->type) {
 		case NETLBL_NLTYPE_CIPSOV4:
-			ret_val = cipso_v4_req_setattr(req,
-						       entry->cipso, secattr);
+			rc = cipso_v4_req_setattr(req, entry->cipso, secattr);
+			if (rc < 0)
+				ret_val = rc;
 			break;
 		case NETLBL_NLTYPE_UNLABELED:
 			netlbl_req_delattr(req);
-			ret_val = 0;
 			break;
 		default:
 			ret_val = -ENOENT;
@@ -1225,14 +1228,15 @@ int netlbl_req_setattr(struct request_sock *req,
 			ret_val = -ENOENT;
 			goto req_setattr_return;
 		}
+		ret_val = entry->type;
 		switch (entry->type) {
 		case NETLBL_NLTYPE_CALIPSO:
-			ret_val = calipso_req_setattr(req,
-						      entry->calipso, secattr);
+			rc = calipso_req_setattr(req, entry->calipso, secattr);
+			if (rc < 0)
+				ret_val = rc;
 			break;
 		case NETLBL_NLTYPE_UNLABELED:
 			netlbl_req_delattr(req);
-			ret_val = 0;
 			break;
 		default:
 			ret_val = -ENOENT;
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index b6eede4406bd..9fbf22a3ca57 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -358,6 +358,8 @@ int selinux_netlbl_inet_conn_request(struct request_sock *req, u16 family)
 	if (rc != 0)
 		goto inet_conn_request_return;
 	rc = netlbl_req_setattr(req, &secattr);
+	if (rc > 0)
+		rc = 0;
 inet_conn_request_return:
 	netlbl_secattr_destroy(&secattr);
 	return rc;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 20eed64e91de..086a3f696baa 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4060,6 +4060,8 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 		rc = netlbl_req_setattr(req, &skp->smk_netlabel);
 	else
 		rc = netlbl_req_setattr(req, &smack_net_ambient->smk_netlabel);
+	if (rc >= 0)
+		return 0;
 
 	return rc;
 }
-- 
2.17.0

