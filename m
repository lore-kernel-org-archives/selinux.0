Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E543C43381
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340E820851
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="YnRPj/38"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbfB1WUl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:41 -0500
Received: from sonic315-15.consmr.mail.gq1.yahoo.com ([98.137.65.39]:45649
        "EHLO sonic315-15.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729671AbfB1WUB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392401; bh=CO4B9SsgBMm8T7hrH5GKIgw3RD7XFjAFy3qVi26z7EQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=YnRPj/38PS34ReKF3eeFN95CJdywR54+AayfbtpvpEdwISBS20g/tOa7R7bLBgHQITKyl7RhM4idiWx4MoB5V1h0GEZrUGcVoV6yYwd5pO+DgOxHYOUH3mKUdrsLlDKwLErCJEKduHaub4WM3tNLKIdYgFrV5MDmm88qapAdxxcRGlzOYNCx05GdFtkmOggrAXwT0Z35hWQRRwzjrWSHFIu4iyuXPthCMJcLhSJAxdyAH1eHUtPDqnAFRc4iCH7LLGqVniEJOLV35X1MNw283NjgZixtPMujySiAHA+Dq3aXcMya7cpi6U0fHfQlEjUV60G1HlKv/Rem2pXIpjXicw==
X-YMail-OSG: vKhv93AVM1meDG1I9t.7dazypzIWDQNRlj9jHhr3BmkDSV9rRTsJHwos_MkaZf3
 OMA_B5aayvYG6JIhtLm60x_SAoAwjomSq8vdvp8lz4_gDJgqBGwgbKFbl1fBk0mWt.tlETHbdRZX
 XX66oLWCSJeaBJ1yzb_5Ur0SgXdItrqqyaS4Knijv7OYV1QHbNAEOY2kM.mV0Y0NCv84OUsB2jCg
 nODVDh6O3wQ6U2IqU0RfSc5JXAXEHjy71yT5Hq1c_pzrUZtAw6pwnnazV.4HlzSaAsU7DP961QNa
 GdyVXShhLXRmkg4BYwJuxO8qnpyOJby_R_fJIArdhy2bEByf.LyOj7B8lawTHnqrHBXOmK95W_UV
 hN1BlOEuE79J5F3tOrLsl5pen4m1wTiT5qE1GIAnaqbZWrKKHBkWUvtWINLxMR0VKpRSLSNUFciZ
 BIt3umvwzjQbgwGPaoeTv8IvWGWKfQI.WK5aAg7l5DhK7hDo98N.UbiJA5JUjULrvJXs8dyeqjMv
 rnSvx.y8mr._atM46Ip5oOsv7nCVf7D9Zy4r.R4LKJyHcetwVpRLtClN3lCjbxQpwuFzYMnzYz4v
 d64nCLiAluhm71SBzPfhUvkbSI139tOhOrZ4VPKchzTybevaWf47jgJpbSU3cmqt5CPX6BtMeHKi
 wxpEVJnnfbZcWeIjntphTN1nkVDdVVmUvlihfdHKqyEVAgWdz7pX.0mJ9EWQ2_qVYd_4QnXZRiOD
 iAbTXZAtqydnr5gDgdTrR7OvbpJa8Vl9HekCSM7UYvEiTWvf3_ysCvM.vD4q6SCMCVkxp4I1iYRD
 oYcS4jPrve05AuUXfW_dWT.aZ4IiHc337aQmG7COKh7n.sEbEAnJrjgZOJXCoPNdQHRMmzdflGcK
 Tf0kguq4mlvPiq08qawKTGXH2eNbDFq3MMYdmqh5HjzcSk2wPurpbqRL9k9axCxv8GlLowFre9SU
 D1HZRagShmJDvEOEYMbA53JOKZWly2BwL.yFnpdRXVExERICP5hGGkpaWwwH46a.d83VrLGdoqqc
 bnU5euDtadLlv2vt1c16R_y6hvkCDcA6hAoB5QaOlOtp991UC91P5meH7wHyQygNIqKsJ4HQ5iy_
 3xBnmryHBgpJ7G6V0sbZ4be.wEOrZJNTCF_q06R02GgMLRXmr
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:01 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5c7d685bea94a92cc9d12c4cc22f1f0e;
          Thu, 28 Feb 2019 22:20:00 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 28/97] LSM: REVERT Use lsm_export in the sk_getsecid hooks
Date:   Thu, 28 Feb 2019 14:18:24 -0800
Message-Id: <20190228221933.2551-29-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

REVERT sk_getsecid use of lsm_export

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h | 2 +-
 security/security.c       | 5 +----
 security/selinux/hooks.c  | 6 +++---
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 97ef535dafd0..cbfc2a9b5f27 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1699,7 +1699,7 @@ union security_list_options {
 	int (*sk_alloc_security)(struct sock *sk, int family, gfp_t priority);
 	void (*sk_free_security)(struct sock *sk);
 	void (*sk_clone_security)(const struct sock *sk, struct sock *newsk);
-	void (*sk_getsecid)(struct sock *sk, struct lsm_export *l);
+	void (*sk_getsecid)(struct sock *sk, u32 *secid);
 	void (*sock_graft)(struct sock *sk, struct socket *parent);
 	int (*inet_conn_request)(struct sock *sk, struct sk_buff *skb,
 					struct request_sock *req);
diff --git a/security/security.c b/security/security.c
index 06461712c881..e52b500adb27 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2116,10 +2116,7 @@ EXPORT_SYMBOL(security_sk_clone);
 
 void security_sk_classify_flow(struct sock *sk, struct flowi *fl)
 {
-	struct lsm_export data = { .flags = LSM_EXPORT_NONE };
-
-	call_void_hook(sk_getsecid, sk, &data);
-	lsm_export_secid(&data, &fl->flowi_secid);
+	call_void_hook(sk_getsecid, sk, &fl->flowi_secid);
 }
 EXPORT_SYMBOL(security_sk_classify_flow);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 744fa6141ae1..9879dd828e1c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4889,14 +4889,14 @@ static void selinux_sk_clone_security(const struct sock *sk, struct sock *newsk)
 	selinux_netlbl_sk_security_reset(newsksec);
 }
 
-static void selinux_sk_getsecid(struct sock *sk, struct lsm_export *l)
+static void selinux_sk_getsecid(struct sock *sk, u32 *secid)
 {
 	if (!sk)
-		selinux_export_secid(l, SECINITSID_ANY_SOCKET);
+		*secid = SECINITSID_ANY_SOCKET;
 	else {
 		struct sk_security_struct *sksec = selinux_sock(sk);
 
-		selinux_export_secid(l, sksec->sid);
+		*secid = sksec->sid;
 	}
 }
 
-- 
2.17.0

