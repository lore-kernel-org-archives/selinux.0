Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95568C43331
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 00:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B3C2084E
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 00:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fDtJ3Pjp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfKMAAv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Nov 2019 19:00:51 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:45230
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726960AbfKMAAu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Nov 2019 19:00:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573603249; bh=CCN60CwQwbfIZPCY4wMAqtbUR9OPypM+nFfLfEcrWEQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=fDtJ3Pjplmh2BJFeEyZfBe+CCgdSWuj5u/UI2rmAI6TBdHPmnuPn1RcfJtlgOhwa61BWcCx6gRtZQczu+iF+DLRZOXDIG3PDL+SxjNblk2vKk4YcucCxd5MELgv6+FeDXXktAB5gtpq/nd8/K4Yg8pgEdboEaXkWwTTH22+WgIg5616Z/5sn1s1ujYjyT6J3AA0oBCoCXwckD3vCdo0TIeXjupKTb7ATMRKDLi9FgOUyeQjSVWtyJJ6CEKmCz7pxb0YYOP3oMzBnQdyo8kBxFlsBw2eKISHjwWWtTruLj6TbSb1EjOdYRSZ0LpL1KQPMPLMaEZfk/l62MklBdprecQ==
X-YMail-OSG: qiTp3VIVM1moSiW_ob46yJrcpeA1sZn6hQuDpVnzf8yi4fE6ONN6xo2E0mP_pxY
 x9CHCGpC3ZANzVYONhFWW_26J7aNMObo2MzfQRk6pkKMTX4caYf5QBG6ADwPAOZbQ3k10tS21CXk
 IlZebE6oIICvN5F6ATobeFIo451rsEmIUsCaUMXcYYY0O9l5cdt_.dHYPhqUQtQBaPSTlBS33m79
 s2K8nKYdckadB_w.WVNhJ1JvvTByjPCQHRo3W60FQCGcTNPyDWtmgVtNXgThmKXCG8hK6t7tV5NP
 6EH0LK4wWpfLp2XM4Ahf43yxKxzPvHS7oPnCfsYr66SSRHnkr6Kg2OeNMi7O8hLb8S_WatUwc1LQ
 S7mHEcNQYogUN20DKSAois9AuyewyqmkF4fDYxgzynfV0eSwrRZvyrO9xE1P1Gu4h5tIc6Nai1KU
 BkU3jwF.wm0.eIawBUz6CA9Mmm4PwENP44hqZ__7gfmMFx7upcvwpcpi1roImCCIsjl901vl6FEg
 rYRHf4Wn9vuAe3FbGLAJSiQyp2A0vK.n1TtznG1rp2T7VAugQ5ubfeic3YYoQf4PABrtaAdXo1wG
 DysGqCUnmbbI0NOKeNjKq3AE4fBCggwmwM__5c3B6LI6_FznDM9HaxvUHjYhf9sG0N_.VfSzM7aZ
 ykoYWzoKSBaR0wi.iOnxbuJ3YkY15Y4OxeEgjoFaFynyODTun1vszuNA4Mi6Jr.yyRtfYnSbAWZe
 MS0ZEZvcJxaEPmusw8TXYJ0h30NZ2CRh46vZQInDkdtDKJZe.SnplxswZirVmdsV.h9BcIyJqRur
 VWAuZkihGqgoNHn9K5qfMyczu6G7BxLfK8rAD42aecAvvSyXCJZVxpaMPrHyhPJukRMWgNSl23y8
 15Ze9OgYYcPqLKssmEYkuoEvci3wghFaNIolYPbel2l57E30GHMrPqT3IwEkKXIC4SuEukGUpWpF
 6NcKgiyFaRG6m0ZF6R.F3uL1N9MWkgs5Fpubgqtv0LGzXwvEgWUsw4l6c9TUQRfEw0Id.w9_d..C
 qU.LWzCes0C9SW6ttrrMmrcI75GjURzz4B2b8j9nufW7dXKSPmVNB1o.VGNjJ9bCh49fSAOQBAMS
 AVus3Yp.DP6bNmBxdMtWpxA9k82_Gc1vUueAJme1bfdb8vdInfAXc_okJsKl7V02J3EhOlIbsk8H
 vGryAo_dUsS3IOO.TxZsVEMsd5TGp2sZcOceCxwtZizis8PGIECr6jdU5CLPMxAtd3su5Lm1NlU6
 wVCAxwuJE0YVXKyBDTet.aAMFaYfMUCZvr6RY5K2895XT8koszM5XRwVKC74MMq_p2BiXuC4ZA..
 UOgTilHL33Iy2l3clB8GilN_dFw5rE2wHeOiu8SnrC_71wiZeL23M5OEOkVHQxUa_NoFCQ5quv1l
 QBAltn3iSSZZuw8dE7J4I7HhBZQOafkf7eljmGh4n6u0fLMV3iIB4FlCnb6E-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 00:00:49 +0000
Received: by smtp425.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID dc9164e8ec7666abe13209391dbbba67;
          Wed, 13 Nov 2019 00:00:43 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v10 04/25] LSM: Use lsmblob in security_kernel_act_as
Date:   Tue, 12 Nov 2019 16:00:01 -0800
Message-Id: <20191113000022.5300-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113000022.5300-1-casey@schaufler-ca.com>
References: <20191113000022.5300-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the security_kernel_act_as interface to use a lsmblob
structure in place of the single u32 secid in support of
module stacking. Change it's only caller, set_security_override,
to do the same. Change that one's only caller,
set_security_override_from_ctx, to call it with the new
parameter type.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/cred.h     |  3 ++-
 include/linux/security.h |  5 +++--
 kernel/cred.c            | 10 ++++++----
 security/security.c      | 14 ++++++++++++--
 4 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index efb6edf32de7..9a21c376ed97 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -22,6 +22,7 @@
 
 struct cred;
 struct inode;
+struct lsmblob;
 
 /*
  * COW Supplementary groups list
@@ -165,7 +166,7 @@ extern const struct cred *override_creds(const struct cred *);
 extern void revert_creds(const struct cred *);
 extern struct cred *prepare_kernel_cred(struct task_struct *);
 extern int change_create_files_as(struct cred *, struct inode *);
-extern int set_security_override(struct cred *, u32);
+extern int set_security_override(struct cred *, struct lsmblob *);
 extern int set_security_override_from_ctx(struct cred *, const char *);
 extern int set_create_files_as(struct cred *, struct inode *);
 extern int cred_fscmp(const struct cred *, const struct cred *);
diff --git a/include/linux/security.h b/include/linux/security.h
index c22fa5bfaad8..cd09e7b1df9f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -380,7 +380,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id);
@@ -963,7 +963,8 @@ static inline void security_transfer_creds(struct cred *new,
 {
 }
 
-static inline int security_kernel_act_as(struct cred *cred, u32 secid)
+static inline int security_kernel_act_as(struct cred *cred,
+					 struct lsmblob *blob)
 {
 	return 0;
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index 45d77284aed0..71c14dda107e 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -701,14 +701,14 @@ EXPORT_SYMBOL(prepare_kernel_cred);
 /**
  * set_security_override - Set the security ID in a set of credentials
  * @new: The credentials to alter
- * @secid: The LSM security ID to set
+ * @blob: The LSM security information to set
  *
  * Set the LSM security ID in a set of credentials so that the subjective
  * security is overridden when an alternative set of credentials is used.
  */
-int set_security_override(struct cred *new, u32 secid)
+int set_security_override(struct cred *new, struct lsmblob *blob)
 {
-	return security_kernel_act_as(new, secid);
+	return security_kernel_act_as(new, blob);
 }
 EXPORT_SYMBOL(set_security_override);
 
@@ -724,6 +724,7 @@ EXPORT_SYMBOL(set_security_override);
  */
 int set_security_override_from_ctx(struct cred *new, const char *secctx)
 {
+	struct lsmblob blob;
 	u32 secid;
 	int ret;
 
@@ -731,7 +732,8 @@ int set_security_override_from_ctx(struct cred *new, const char *secctx)
 	if (ret < 0)
 		return ret;
 
-	return set_security_override(new, secid);
+	lsmblob_init(&blob, secid);
+	return set_security_override(new, &blob);
 }
 EXPORT_SYMBOL(set_security_override_from_ctx);
 
diff --git a/security/security.c b/security/security.c
index 8fd5c8cd4f50..7879da7025d2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1566,9 +1566,19 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
 }
 EXPORT_SYMBOL(security_cred_getsecid);
 
-int security_kernel_act_as(struct cred *new, u32 secid)
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob)
 {
-	return call_int_hook(kernel_act_as, 0, new, secid);
+	struct security_hook_list *hp;
+	int rc;
+
+	hlist_for_each_entry(hp, &security_hook_heads.kernel_act_as, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		rc = hp->hook.kernel_act_as(new, blob->secid[hp->lsmid->slot]);
+		if (rc != 0)
+			return rc;
+	}
+	return 0;
 }
 
 int security_kernel_create_files_as(struct cred *new, struct inode *inode)
-- 
2.20.1

