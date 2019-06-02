Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B13C282DC
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF7927982
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="bjEsYmg8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfFBQv4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:51:56 -0400
Received: from sonic310-27.consmr.mail.gq1.yahoo.com ([98.137.69.153]:37371
        "EHLO sonic310-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726925AbfFBQv4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494315; bh=kPEVpSTXbzStzk2RRdBr0uzp0UqHYw8ZEJtQ2z8HYS0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=bjEsYmg8mUyUxMo86dOhp3oKiFOX+nZxDYTIcJ9BSV48CLxP8hyzEgyeZkmPZkOSr+UmQyEFXWjEdGm8Cu4i1L8fMZ+6FXld0F3NMX69SaDcziM4Pjnqj8ttj/J9fwbDg9g+0TnlOoSJQedmOMhfcb4SGF+MCqWbzX3dvRkI2DPCW6TV3Bfq5dUGrgs7UeCvlD5iBNRXFwCwcoW33NkGovkXqfB5UrXs0iVUhlYRZbGqzmhhwUqrq2cyXnfDZ6NnmQ4T8tvoHf9p26UT3XSJXwOdL4V1IBdWf23Pv5488dCMS9n0iKw/fw0j3N6LWXwdzYVN4UfyzhYuAVW74xjc7Q==
X-YMail-OSG: Zc0eaEIVM1nQ06dGpx.Oe.OAT5KY1I2AlPnHzADXle1PznDbCpWiBivLbGcl6qO
 qF3ErUi1yRcoRs60t0fbcd5BgQ5ILji5vC381OyaKfHVq9FufPyfPRbl4jXcFM9Hg_bcCDSwyLjY
 Jst8zjAH6NUvYsyUHA3XjteDAe_jligBcanwEV2Me30.2sNCDAG7dDfvqxJ8ifgdGndHHZAE4kam
 60KfsIFA.u8XgdBxWfxltQc2UvJR_LakNYQw2RkpaYT5qOXES_cKyXI7fDUYC7j1zB3TXaCez3Br
 vdfKl4pbaBa.cvojv4Hn78jGFLpu7vK7RNzrMA9VvnubUG1tb70VP3Ty3KGamZLiqIcKyd3UIKm3
 kJc93C7Qo1fv_cxA9jb__A.Bk3JF0bhCaz73YbDR2aexYlX14VnOYN3xcaNIwIjIvc0UHrqnOg3f
 o7jjGKsN1aOaSAJpfHL2hIjNxUAcVWnjWC6dYhmcakDSh0ukIkNaoja79lxL2Cll9FP1yJVdDDSz
 ezzGUVoFynR2lNDXuoaO5RNpIeKj7szWDQqdidq2Mreqv2ClPoc.GaC2lWrj44Q23PbWE2og2Ull
 5SiG1tkTa2PSP_jUQa5vw_K45BdG3KdcqZWXn0aAasWDm2fWHdq7dgxFTqM_oNBp_FRLPvjzIb2S
 7FHbARoASYN65QAa6X_0bTnoS1Uc3r3qqdIrkRlehrRZP0IwqCrDPfST3aAKooWqM4tF49FJUFk8
 3nLMpJ.vTKaJ3MZq_wrFQXTAHEc3f6jacX2qeexXerJVL6eY7sanzvzm_OMx4KbCi_gYoYVCrjzT
 vQ92sWFKuNcZ.c.eHow4eEhHKpiX1QkPgecSChIfHwxvQ4XsQyNZ0QGvqbxtO63BiAQ6xwo1PZXk
 UidDLS7LYhzhVfu09QT1U.Vvaj3kov9B5EB2TbrhkeexFOsNJxopaYBR.uSstkMcO070W_.Ah7rU
 1rkMUWyYpkgQuAfiUWUHlHTFPgL83ImnWY9L5hK_nGPQJ3GoECr89zMHlPb_N3H1FVV0FZPNAhkO
 0C_7L4ttuwoOoE_sx1Jd8pkLC_YT1sqIjarnwenaXmMnACfHm_tFauDM4LbpXVs8cmK4wCH.QPbV
 Dmn8fKBmGtcylFIZPansZVsg8ktxToeWim2FIYXYS0rxchzpf.mOFgKvaCS0GKjZ0qIwafiWRFdP
 ZI7pqVV0R2SWex7CiiU38NrvuYiJrpfKEv9WM3uflsHBwrVig_2qXX8YT3yPffLfnMgTx0WG5CYz
 1gMKpqa56tjQ3C.K5vZR753FdpuQsLbbW2ga3tVxM3oE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Sun, 2 Jun 2019 16:51:55 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp420.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID aa88b96425a9713222d71be7c480dcea;
          Sun, 02 Jun 2019 16:51:53 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 14/58] LSM: Use lsm_export in security_kernel_act_as
Date:   Sun,  2 Jun 2019 09:50:17 -0700
Message-Id: <20190602165101.25079-15-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index efb6edf32de7..9305298eca17 100644
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

