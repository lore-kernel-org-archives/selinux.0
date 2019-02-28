Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFBAC10F0A
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B69E206DD
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="k34uvCaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbfB1Wog (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:44:36 -0500
Received: from sonic301-10.consmr.mail.bf2.yahoo.com ([74.6.129.49]:34826 "EHLO
        sonic301-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730845AbfB1Wof (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:44:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551393874; bh=DnAJ7yFgViYIZXC7EL7fvaMU8/QHiG5SJFZe51H0huA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=k34uvCaWhOIezESOvy0kEYd1YIoyhh0P0h5hICFIArSuY7bv1NlMaVbUflJCRshkY0WNsD2Fl2/KJDcac/rXC4DG9IV911K+axi4N+OrTSCsK2UZUGDtSsH0Yu70PQwlA6SLYQ2sI8AM8PUghe6JVsNS6AkmKvwSQq7F8nXDyiFQMpPhj88eaYBRISX1qFFV8UXoQP/dO6I1L+ySn9HxdHENZFAo2+MQzZ8bFOmgJ+6Ic8XdvVQkGXnsbPOvOpyRAinbOcG2GIXXzH7Wu8pUED6/4kPYGZHkW98tOeudUKiEdkg1ToqBieLbKJZRQndz5Ashzp3GsnSfZJgGa64MwQ==
X-YMail-OSG: Z16dURAVM1lLr0yDvRQ0LOHhtf4MEz3AwvfKQyHPaE7xrBjfYlHBguVWevJqVQJ
 1QHJoI4nM66keGQ_26TYKveDuA4sdRexYNzPWVP895vaftlGQzzxkldQAGiR.Ojn.wJyzC3T1RDT
 E3p.pKq44Wmfb.qW.9WpiOypwOHCTy6GEibSntlTZXtgwYhA_CNl1hwXvfWnrJV82FyRwn.pui.L
 YD6ZVilVomQX7k5HU8Zr16CxiMWbQvVL_OZvbahugphZ410l7XtJhHAG4EvdApEUoSWEBNCnojRR
 j1oUVv1AmcOYQFXcih8qtMZIeOI1fRnCo3p56rY7Fr_YtPdCk6zqdHLdsz1agS9vyVCaU70yAdkE
 rsRw6DXkIggXcLv8zB6LQXAXxduVngpBqD.Y3BEh36UM1wE896vJk.1G8tGvWdArXncJNgFFQetD
 qOVHA0sAzOMdg27BymWBYf2xxbQLR4TrPZ7mqgy.9_OluAodNcvWPRwNDyqBEzHBgzDpDd9D21a.
 4nyUAPfCiCA3Pl0YDDwESCS4A3z1iBOyMcMbv_l7Mo_xbM_mRj.wR2GC1nvWgx2vOa.vs8rOvGN8
 15neRmMBRhYygXuNpLlVqqlpsLMyVeeEhlxu6hIoZJUiba7Y1ODwLFYz_7mhWMNEO3gV90hdqXpt
 wFUu9zzn1p2VMlCoN1fR3Fc964M0n37bv3cirxdp3Hg9E0Bw5Bzyu1B_ZNGsRzOXlabPXS259TAZ
 JiFiVGwvjmGJdA7p_dVRWwmEfhHOc_gQrLYWeQvVG_WRLLTZ58YW8.DqmzsbyiBNJqEftg8yZnk0
 1kZHrKWT.Ha4tU89Xv8uZmOSgyZCIiJCSRsxHQhALwbvA0J1hCZawo5RYUOnrgG6nt1So7Rb5AY1
 VdY6Nm.ifzB0HZIOp5.JCsRbkah2.hfRD6UP0ndDsLlLqo5l1GpMriCY9CHOC0skGGrhJQynTlcq
 qOiR75EYNGoxSzxkgI5j7h2XixxjqrVnZiRAVQWqI.gxjacN_eGnV_pdgDiJxUtifsCm5rqt0Q5h
 fE37T.Q26olHj8ahP24NLb97639HGeLK.KPfSHTWxkkBwxdzSMPAQoWech9UOK7GTXX6G8eGSluJ
 d966wpE0uBIhQed9mLElZ6XtrQ1oEkRJWK0w-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Thu, 28 Feb 2019 22:44:34 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp415.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 46c3ca42412e81058eafbaa96f791691;
          Thu, 28 Feb 2019 22:44:29 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 89/97] Netlabel: Return the labeling type on socket
Date:   Thu, 28 Feb 2019 14:43:48 -0800
Message-Id: <20190228224356.2608-20-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228224356.2608-1-casey@schaufler-ca.com>
References: <20190228224356.2608-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change netlbl_conn_setattr() to return the labeling
type of the domain. This allows the labeling types to
be compared when two LSMs want to determine how a socket
should be used.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 net/netlabel/netlabel_kapi.c | 20 ++++++++++++--------
 security/selinux/netlabel.c  |  8 ++++++--
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index 61766da2cfac..2bd765290550 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -1101,14 +1101,16 @@ int netlbl_sock_getattr(struct sock *sk,
  * Description:
  * Attach the correct label to the given connected socket using the security
  * attributes specified in @secattr.  The caller is responsible for ensuring
- * that @sk is locked.  Returns zero on success, negative values on failure.
+ * that @sk is locked.  Returns the NLTYPE on success, negative values on
+ * failure.
  *
  */
 int netlbl_conn_setattr(struct sock *sk,
 			struct sockaddr *addr,
 			const struct netlbl_lsm_secattr *secattr)
 {
-	int ret_val;
+	int rc;
+	int ret_val = 0;
 	struct sockaddr_in *addr4;
 #if IS_ENABLED(CONFIG_IPV6)
 	struct sockaddr_in6 *addr6;
@@ -1125,16 +1127,17 @@ int netlbl_conn_setattr(struct sock *sk,
 			ret_val = -ENOENT;
 			goto conn_setattr_return;
 		}
+		ret_val = entry->type;
 		switch (entry->type) {
 		case NETLBL_NLTYPE_CIPSOV4:
-			ret_val = cipso_v4_sock_setattr(sk,
-							entry->cipso, secattr);
+			rc = cipso_v4_sock_setattr(sk, entry->cipso, secattr);
+			if (rc < 0)
+				ret_val = rc;
 			break;
 		case NETLBL_NLTYPE_UNLABELED:
 			/* just delete the protocols we support for right now
 			 * but we could remove other protocols if needed */
 			netlbl_sock_delattr(sk);
-			ret_val = 0;
 			break;
 		default:
 			ret_val = -ENOENT;
@@ -1149,16 +1152,17 @@ int netlbl_conn_setattr(struct sock *sk,
 			ret_val = -ENOENT;
 			goto conn_setattr_return;
 		}
+		ret_val = entry->type;
 		switch (entry->type) {
 		case NETLBL_NLTYPE_CALIPSO:
-			ret_val = calipso_sock_setattr(sk,
-						       entry->calipso, secattr);
+			rc = calipso_sock_setattr(sk, entry->calipso, secattr);
+			if (rc < 0)
+				ret_val = rc;
 			break;
 		case NETLBL_NLTYPE_UNLABELED:
 			/* just delete the protocols we support for right now
 			 * but we could remove other protocols if needed */
 			netlbl_sock_delattr(sk);
-			ret_val = 0;
 			break;
 		default:
 			ret_val = -ENOENT;
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 85156a0cdfc3..ca47c99f964a 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -321,8 +321,10 @@ int selinux_netlbl_sctp_assoc_request(struct sctp_endpoint *ep,
 	}
 
 	rc = netlbl_conn_setattr(ep->base.sk, addr, &secattr);
-	if (rc == 0)
+	if (rc >= 0) {
 		sksec->nlbl_state = NLBL_LABELED;
+		rc = 0;
+	}
 
 assoc_request_return:
 	netlbl_secattr_destroy(&secattr);
@@ -576,8 +578,10 @@ static int selinux_netlbl_socket_connect_helper(struct sock *sk,
 		return rc;
 	}
 	rc = netlbl_conn_setattr(sk, addr, secattr);
-	if (rc == 0)
+	if (rc >= 0) {
 		sksec->nlbl_state = NLBL_CONNLABELED;
+		rc = 0;
+	}
 
 	return rc;
 }
-- 
2.17.0

