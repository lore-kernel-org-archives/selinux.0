Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232DDC282E0
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E15D5217F4
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="R5AB5/Qs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfDIUAY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:00:24 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:36804
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726716AbfDIUAH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 16:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554840005; bh=1W3uUkvFiV/hG0OeWxySGoGDdIhr1Nn/Tz9IT5pFX0c=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=R5AB5/QsNW6qTRRvSqcJDWwHS8a9VpQykSQsM9QuS2Af9jEzNEs9opSgh1HjJlawFDYC2xPoNOhgSRQynQcMQjdNL7bbthpAT4l1yMkmNtz+w1R1u6rpzuWkSDVVmU4bHXnz4ZlyOq1xinKPqReAb1CyCVcyfjxM1D27QvK1Mv7PJ96z5WhxirvYqqK3YI0MZUoBtcDrw7XImQOIjFPK4QlYzACvXS/V+DaY3e57MxIRt+fpPGDsz46s7J+vBoZumqJ2HdRlikxvT5AH5XhZ0j9ri74TmOUT/shI++HDclqQUipz9uPKRoa34abvdyTf6PN74gDlrKxx8nD/kMTXDw==
X-YMail-OSG: zikZL7sVM1mzwXOAIP2Ul3rJidadrHKwB1_sFG3l2PruR51XSZzJxwvC6XTHBKL
 MG4dZAKueXXYWVJa3bZ7ZWl3t6nsWvVxHZ2WE9vGuUUe1b_eRweJns1ophP0IFBlFWHbdXNA4qiV
 .HmdquXgo3Cj1Mm_PWGPemz1Kdu7Nh7VsNliRUgeEMEpqYpc0OovOASG09AzLFqzHh2Lwu2SS2kB
 mm0m_VIuSheQpQ41MxMahTgHredzLzsW2dYRZzEIg24v_WD59t_Z_NdAfnoiURdLxs7Tvh6IqCrt
 yLvEE9iz8DppBpe.NSfYUixpq9F5LLfLIX6YYX4hkWs5PGTDg2RBULaUIRnRKMQ9JKiKmxa4I1HV
 vBvMfq5KnUTGt2TpILeWYgB3Y7_no1dwrzibIabR86MfFy03fPdJ1cHFYQWxd3etSrkHRIVurHoz
 vcfvxo0t8EAg14Qb6IY.Zx1k5pE34YiN6FVfqE.sgeu5gDWQWGulTp4zK1ptohSZHsGevwITYUYA
 XSz5J2PHdaPcn7wk8jALpRU0L0.IIVT6X5tFu1yec08eWNNdLkY7M5KOD2l2k0YiDYdRyfdRdtvn
 hpT1V4fqkFPEuZ1_xX5md4PE3ROqGiy5GOmMz.wZmaiHkn9sspdqH7Igh8UmYWt_2RUGXW8lLErP
 SXmtd5bN6FxOvpqi2kxxUF7C5yXm66ENLCKqB7I9mXwXeZk0aYEjyZ2lWqFhwmFHXUAWh8Qy4jsn
 XmBUvPQzbXN9spYkPbYl3dUaYKRi4YLe2F_jgZFsFo1I3orAXLjyTl_6BmJlIHQ9r5YRKh.jvUsZ
 PSnTiVvzLVwrubXM7nJmFDjv1h47bosKr8DSczJ0bqyibgBF7N3pI_rNLKNKrBAnKtcbdNF9N.D2
 vk8Tp0tLqf7Zuml4P3TEZUi7ws7aV3X7yWnk9Q5yg56aNVIfQENSss34tzY3SKWR33H.VL2_.1ky
 EG.4W1c_FwGRsdDzbIAjSYT6Hj6sSNpnrzA.MhywlUfKH4uYjk7nLZR._DoVZWXI8mcVhAD1XS_p
 _aX1_fb0c6yzTruOA.ClfUVQt0YvRMdBJXwnrFcQGB70k52EX471NAWji59DJ_VTzazQa9Vv1pE9
 u6X_1.6FPHVGx_fwWSRY8K.oqBbtsMquK61Oh0PzhyTm.KnolrIyMB4e3J80-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 20:00:05 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp430.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 552806e231f63bbc1dbaec1014ade557;
          Tue, 09 Apr 2019 20:00:01 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 15/59] LSM: Use lsm_export in security_kernel_act_as
Date:   Tue,  9 Apr 2019 12:58:40 -0700
Message-Id: <20190409195924.1509-16-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409195924.1509-1-casey@schaufler-ca.com>
References: <20190409195924.1509-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Casey Schaufler <cschaufler@schaufler-ca.com>

Convert security_kernel_act_as to use the lsm_export structure
instead of a u32 secid. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/cred.h     |  3 ++-
 include/linux/security.h |  5 +++--
 kernel/cred.c            | 10 ++++++----
 security/security.c      |  8 ++------
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index ddd45bb74887..023f422eefd6 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -22,6 +22,7 @@
 
 struct cred;
 struct inode;
+struct lsm_export;
 
 /*
  * COW Supplementary groups list
@@ -165,7 +166,7 @@ extern const struct cred *override_creds(const struct cred *);
 extern void revert_creds(const struct cred *);
 extern struct cred *prepare_kernel_cred(struct task_struct *);
 extern int change_create_files_as(struct cred *, struct inode *);
-extern int set_security_override(struct cred *, u32);
+extern int set_security_override(struct cred *, struct lsm_export *);
 extern int set_security_override_from_ctx(struct cred *, const char *);
 extern int set_create_files_as(struct cred *, struct inode *);
 extern int cred_fscmp(const struct cred *, const struct cred *);
diff --git a/include/linux/security.h b/include/linux/security.h
index ea2c6c4e88db..7369cdc3a681 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -378,7 +378,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsm_export *l);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id);
@@ -961,7 +961,8 @@ static inline void security_transfer_creds(struct cred *new,
 {
 }
 
-static inline int security_kernel_act_as(struct cred *cred, u32 secid)
+static inline int security_kernel_act_as(struct cred *cred,
+					 struct lsm_export *l)
 {
 	return 0;
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index 45d77284aed0..40a3fde22667 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -701,14 +701,14 @@ EXPORT_SYMBOL(prepare_kernel_cred);
 /**
  * set_security_override - Set the security ID in a set of credentials
  * @new: The credentials to alter
- * @secid: The LSM security ID to set
+ * @l: The LSM security information to set
  *
  * Set the LSM security ID in a set of credentials so that the subjective
  * security is overridden when an alternative set of credentials is used.
  */
-int set_security_override(struct cred *new, u32 secid)
+int set_security_override(struct cred *new, struct lsm_export *l)
 {
-	return security_kernel_act_as(new, secid);
+	return security_kernel_act_as(new, l);
 }
 EXPORT_SYMBOL(set_security_override);
 
@@ -724,6 +724,7 @@ EXPORT_SYMBOL(set_security_override);
  */
 int set_security_override_from_ctx(struct cred *new, const char *secctx)
 {
+	struct lsm_export le;
 	u32 secid;
 	int ret;
 
@@ -731,7 +732,8 @@ int set_security_override_from_ctx(struct cred *new, const char *secctx)
 	if (ret < 0)
 		return ret;
 
-	return set_security_override(new, secid);
+	lsm_export_to_all(&le, secid);
+	return set_security_override(new, &le);
 }
 EXPORT_SYMBOL(set_security_override_from_ctx);
 
diff --git a/security/security.c b/security/security.c
index 1e819ecf26ff..edaaaef54239 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1615,13 +1615,9 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
 }
 EXPORT_SYMBOL(security_cred_getsecid);
 
-int security_kernel_act_as(struct cred *new, u32 secid)
+int security_kernel_act_as(struct cred *new, struct lsm_export *l)
 {
-	struct lsm_export data = { .flags = LSM_EXPORT_NONE };
-
-	lsm_export_to_all(&data, secid);
-
-	return call_int_hook(kernel_act_as, 0, new, &data);
+	return call_int_hook(kernel_act_as, 0, new, l);
 }
 
 int security_kernel_create_files_as(struct cred *new, struct inode *inode)
-- 
2.19.1

