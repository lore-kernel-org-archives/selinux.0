Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87196C10F06
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5524B2184A
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tIb+WifN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732199AbfB1WUe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:34 -0500
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:36261
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731828AbfB1WU0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392425; bh=g3SbYyqnAYykVzKNW9ckS4SnvlWfIuT7xfaM+EUnDjU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=tIb+WifNJ8pN6TvXk7uyDNBgLlziA4kZSzqsmP7UReYtGs8GDvKU4u8nlKtrtFvO+nh3evwUSRIxbW8tJppx+taSBmOYtWbVrgtCcOMH+VbQNIfOs4ZZ1LNaMBa27xYm0+rPdXGGE5VLLZQLziIJdlEOWjRYzQVN2cvoyrtwaSBqGrBaIodJDvKRCA+Tw5eWCocvLXM3ESR/5MMWoJvwje2s8y6w0hiB339jUAH2qZRw1/1/mtloUqraS8eQKzRDT/x/ckAGnTGmzgINVBmJEbBjJZsM+JLP2S55ksDSPiWaWDdgx7rIwoaRrhluekYmTAiTalS6++NRQNs6NumrYA==
X-YMail-OSG: 0LlS0lAVM1m0qm0p9Mn3teGTc1PMHHwiPOckm_jm_Iqk9OeMGA4B2IzXY.ilQYQ
 wOv78D8UyIjsi5nbvCvIh9q.PP3KGqgn5e3teS13gi.Cii4bsW29vtrhvR6Tf6lX5IzirOPnHM7n
 usecXs18tvqPfQ.bPBtbNC3FxRtj6BDaavtGhu7FSHRBzoQJ.uM3ma8mNLbnoCH4y6jtyOBVy7vT
 WW9oMKDBnzD6kHFUesSqSZL_mY_eaGeoDd3GqxriUMbT33vCoRBoEGwkYHjNtElUWdArVVIZk7k6
 AnfrOooVI0.G2ngRdUE42OROVtWFdbzcqNsU.W.nMuHZuhbxoZDNF_ZqnvPx6srjL2pY0ACGm6qS
 nddGl9iJ2OLJ2Y6NVAcCxoRcB7Sv0xISx7qEfOOA98tOwaWMG7UqICtRddrUYdgDoJNN5DHrav.J
 258YFbzXnCjCxcD4j3W832byQV1CDKmQ5Q7WDW.4CYnJTL7hvd1WnO55oVvd7Dp52TZG_TKN0sZN
 ew996yoskEEdGS9ntEWXqxI4VJFynnCKd_S5pCJmCG2PZ_C7usRq95l8sraWYvv46s5d7YeJRYbz
 Q9Z3NY.i7UfIIf1H.iJfxx2y_8MjhYNud6vFjfZU5cK2_hRpUXhMPRZBaPOV8m7nD.F.gbh14n1N
 yYcBbvZwnDV7O5S6X.CVb9oNQaI6w_IIBm_pBzKmJXffr6fnP3N3txCFBMspY8UIAOObT8Vqv1b2
 mI9_MxxdWiUCwC4syP..q7pRazxcsONR2VbWI6izX0bT73RiFdVqxz7TpL3RSFNDMdHGx270N5xR
 d2W2oa1LnjQdShPfyfcA7Y0t4i7INMvhzQL_pAgzu7CYi6d6dp3A2ETblDlb.415M9DLYAXotkc1
 KHYw3KdjJljGVKoPp2_WWzj98vEgRI9Dn7T0bRaZbRUbLHXQ1d2VdstTwMgxLSKSAbGbCQ7fONtR
 YYjEvo1RGADjaosFY8tl9fHtXbzKZbqOM6AeW6_J779djtSmkfitgMCjr4QYr1znNMXdtt5CzyAs
 O9PJT_eZv71vBzN.UN8k_bXmZ9TasetniPE0aSGOJq8rbdGOreg7zAwDprtR5Z69dZvJqic7BZvF
 uQ_mEDNfYLUudLBp6JZgMH.4UTgzKu7UwbBzGLO.JFgtNvkBB
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:25 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp421.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d90148b291d74b44c78573c559ceeae0;
          Thu, 28 Feb 2019 22:20:25 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 67/97] LSM: Make getting the secmark right cleaner with lsm_export_one_secid
Date:   Thu, 28 Feb 2019 14:19:03 -0800
Message-Id: <20190228221933.2551-68-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Getting the u32 secmark from the result of security_secctx_to_secid()
requires knowledge about which LSM interpreted the context. Add a
function lsm_export_one_secid() that finds the active secid in a
lsm_export structure. Use it in secmark processing.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h   | 16 ++++++++++++++++
 net/netfilter/nft_meta.c   |  7 +------
 net/netfilter/xt_SECMARK.c |  7 +------
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index cb5e685f60eb..cb392c6b620f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -115,6 +115,22 @@ static inline bool lsm_export_equal(struct lsm_export *l, struct lsm_export *m)
 	return true;
 }
 
+/*
+ * After calling security_secctx_to_secid() one, and only one
+ * of the LSM fields will be set in the lsm_export. Return
+ * whichever one was set. Used to supply secmarks.
+ */
+static inline u32 lsm_export_one_secid(struct lsm_export *l)
+{
+	if (l->flags & LSM_EXPORT_SELINUX)
+		return l->selinux;
+	if (l->flags & LSM_EXPORT_SMACK)
+		return l->smack;
+	if (l->flags & LSM_EXPORT_APPARMOR)
+		return l->apparmor;
+	return 0;
+}
+
 extern struct lsm_export *lsm_export_skb(struct sk_buff *skb);
 
 /* Text representation of LSM specific security information - a "context" */
diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index ad1aa430f733..1a2b3efc79ee 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -576,12 +576,7 @@ static int nft_secmark_compute_secid(struct nft_secmark *priv)
 	if (err)
 		return err;
 
-	/* Use the "best" secid */
-	if (le.selinux)
-		tmp_secid = le.selinux;
-	else
-		tmp_secid = le.smack;
-
+	tmp_secid = lsm_export_one_secid(&le);
 	if (!tmp_secid)
 		return -ENOENT;
 
diff --git a/net/netfilter/xt_SECMARK.c b/net/netfilter/xt_SECMARK.c
index a06e50535194..b20753957e8d 100644
--- a/net/netfilter/xt_SECMARK.c
+++ b/net/netfilter/xt_SECMARK.c
@@ -67,12 +67,7 @@ static int checkentry_lsm(struct xt_secmark_target_info *info)
 		return err;
 	}
 
-	/* Smack is cheating, using SECMARK_MODE_SEL */
-	if (le.selinux)
-		info->secid = le.selinux;
-	else
-		info->secid = le.smack;
-
+	info->secid = lsm_export_one_secid(&le);
 	if (!info->secid) {
 		pr_info_ratelimited("unable to map security context \'%s\'\n",
 				    info->secctx);
-- 
2.17.0

