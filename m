Return-Path: <SRS0=MX5b=5W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873B8C2BA2B
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 21:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F0920748
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 21:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ehpDnREp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgDFVBY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:01:24 -0400
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:33546
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726277AbgDFVBX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Apr 2020 17:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1586206882; bh=WJCVOWYYuSJXpVEiT7a5PyQ02j71B6bFCC0MlNxEBBU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ehpDnREppj/Y6a4/HOSEnSFE7DR6/U/Yjwwo/u9YQxHPKGYgrXzSlbEIfYG9DT3uZTs4zELzJwnruNp46sevpesiJAHZQyErowpUpYK7Unczhxwc0g5ik3z42ios2X5MflfgaB9Bb1hAB4ieQs4N9gLjjGXQ1OnIrDNnK3GFa4H9CBYeRCzkHzCIR+xNrM1VBYIy7z42gmPYz8IIipsgepuJZio6hGFpEYkJ+jNTxKiTt+O6K4193YIEHkpi5ebCkqCnE84BAiyLrLwf6raOcjVzoAX7v3Ke80H6ZiIxybCanr2qON+dml2YC5rkJ0SLDadZ/8ss7udDWVty9ppHAg==
X-YMail-OSG: B_cQgZwVM1k6Ct2g5p2La1Ts8.RyyRqC8x.NZ7w_Tm.ypPuHvcwsY8Ly3LBrvTS
 h7W0txO.9qY.KBh8c9_4QbAiDkTWDplNYJlce3TMKWGKDX77oIlaSq3IFohj1CnJJ_z_ErZmsHq3
 iwb4CS.v7o9pr28uuwCPI3brGf3nObwRYUnFeSCA2uQbxD7ZENXlzS7BKz0m4hQZs4Ta7_bwStA3
 EfXaNoq066ZkSFmezWRenFJG1aLiOXNp2qenNm_OMOwt8wTXh9TVwaaLXRmZiyihsaJgLElVqlph
 R831jlb8z0P_mUQcbc4PPhVW3ibdWrnDCIEPWHl5uNbCFg50TWCEQc2Hv9PZQYRk3GvUQqCzA28r
 sXVZnsHH.V3UJLv5wFc14rb4BtmV_OQQayxpSwXvMdoqGVJSCbQpxZRmrjTdHaxYx3SJzcoGu_Tp
 JXCSGpi_Gc_s5sFR3Auo_fKrpptLyVmdFSSPUHjlGsawE096QFXCBCdjSi0Ly5wF66kr0RPd8zMF
 wu9i4nrYz1jAIT5S0azkFGXFP67Y195zEd7cYWEKoCaBN_BttkbmM_ti9cks1YEoQ1z8zN_voCaX
 Y7oAwFuVfJFVZ3BUwO3i56kYb6a8fKwr2mLt7mNMmOlnM_3SfxL6sTiT5i7U.7_uXU15o3siYXjI
 P9wb9AQbJQRDfnnVe5nAcbIjrNR6410VdNTQW6vDbozLK3RVzCRjzzBuT8KO2pKyewzYpZP9CpDd
 ucFkXgvjdanv6gxFX8u5gH6Y.ddhtp7dcml8F9Lfm4jG.U5SRQN8ySqtDeUdufu5eGSS4mc05KVT
 Vs7QOv.1WPboq6u0xPDR9L6oTU07LuID_ARNxlaBlPRAqzxuiyFebQ_0qVbhVzT2LWhAo6_rSJH_
 3FMGCQV8j9Yi1Z70WPNw9u7ukp97ScwOmyNp7aKiGGm8.q5grgPQyDHEKQN056cEgWMq0UvjN652
 7FDsSLDPNlr2dvh.VOsXJURapuElAAA0tnOla.cEygxz7V_F6cUcYNCZ135cHmLFXDAruTD0g9bv
 qX8CkXN_KC8hvtVu7x5OCx5s.VKwjQ1mCmm4aa2lQQCpupxQe0CJNQiCUUAj2xuCOgiVDK47aUgr
 LtpuFwGkNXuSQdXpJp1j0rymdaogRGVEBiJrPNEEpdpaaOyBASrg3K_PeG3VbJU4w8aS5JYprA5n
 466kKVvPc2n.hsy3oa8YNHpZEngtU15mWY2x.QgTafiAD13s6dzNnxi23tfhvDSFc084yY_VtaJz
 2jrwTpSv9Im.qapUO_eojtQjU74xaCNt9Sy7X_sf_mS3dOolQ1NG6QKZt9GC_f6vT7NMvKD_csB9
 sCfMLM8asZJeO_ZSuj0MhtmQZKLQTiKpWCq7gQXQI3uAx2fl9LnSOYbnpRGQCsB8N.mR8Amn6iqK
 3CLiHpQrSanBUEYF865y_WvgayTAVMa2Km1__Ryxvlk0SlvIGIWLyHOx1nOfmAAtPZfQ-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 6 Apr 2020 21:01:22 +0000
Received: by smtp402.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID dbb4339f30b37371185ba459a2151b35;
          Mon, 06 Apr 2020 21:01:17 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v16 04/23] LSM: Use lsmblob in security_kernel_act_as
Date:   Mon,  6 Apr 2020 14:00:16 -0700
Message-Id: <20200406210035.42547-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200406210035.42547-1-casey@schaufler-ca.com>
References: <20200406210035.42547-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the security_kernel_act_as interface to use a lsmblob
structure in place of the single u32 secid in support of
module stacking. Change its only caller, set_security_override,
to do the same. Change that one's only caller,
set_security_override_from_ctx, to call it with the new
parameter type.

The security module hook is unchanged, still taking a secid.
The infrastructure passes the correct entry from the lsmblob.
lsmblob_init() is used to fill the lsmblob structure, however
this will be removed later in the series when security_secctx_to_secid()
is undated to provide a lsmblob instead of a secid.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/cred.h     |  3 ++-
 include/linux/security.h |  5 +++--
 kernel/cred.c            | 10 ++++++----
 security/security.c      | 14 ++++++++++++--
 4 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 18639c069263..03ae0182cba6 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -18,6 +18,7 @@
 
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
index 9d83c6832bae..1bfaf9ece13e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -439,7 +439,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id);
@@ -1045,7 +1045,8 @@ static inline void security_transfer_creds(struct cred *new,
 {
 }
 
-static inline int security_kernel_act_as(struct cred *cred, u32 secid)
+static inline int security_kernel_act_as(struct cred *cred,
+					 struct lsmblob *blob)
 {
 	return 0;
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index 809a985b1793..fae63c0a1b36 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -732,14 +732,14 @@ EXPORT_SYMBOL(prepare_kernel_cred);
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
 
@@ -755,6 +755,7 @@ EXPORT_SYMBOL(set_security_override);
  */
 int set_security_override_from_ctx(struct cred *new, const char *secctx)
 {
+	struct lsmblob blob;
 	u32 secid;
 	int ret;
 
@@ -762,7 +763,8 @@ int set_security_override_from_ctx(struct cred *new, const char *secctx)
 	if (ret < 0)
 		return ret;
 
-	return set_security_override(new, secid);
+	lsmblob_init(&blob, secid);
+	return set_security_override(new, &blob);
 }
 EXPORT_SYMBOL(set_security_override_from_ctx);
 
diff --git a/security/security.c b/security/security.c
index b3fab8fdbb57..914aecd89822 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1647,9 +1647,19 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
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
2.24.1

