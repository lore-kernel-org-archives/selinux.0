Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BDAC282DA
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 225BD2084F
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="aic8+MnG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfDITTI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:19:08 -0400
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:39071
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726757AbfDITTG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837545; bh=1W3uUkvFiV/hG0OeWxySGoGDdIhr1Nn/Tz9IT5pFX0c=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=aic8+MnGzRtDZ6XGLKhUrYA0W3lS+gKGCcdLs0XXAZlWzHDpy0LAeApbQYQG+hqAfUcJ9uFs+UcGRv9kZXncdL71df+A6771EYLKI6wj1jBfXyDDB3STrm07+wkwxETb/07BHcOCaVJg53cvXORpQr0gxHqi2TNrAzIfsvn5aipWnLPGQxhkSOIK8bBEV8pt/NMSgcfsP3xwHdVP7ykWZAq4++N+BPH6G4/quLN6hfStnmBSC9q6d+BedC6/exsjh3JWEAupAIKKBZPw0FOTrZC9kpiL0wRXgpNXza+Cb8kCyMQoestiJKhtIm7ZmuT4qeGIHTGqULsSXOdYOS7NFA==
X-YMail-OSG: iIZxfhgVM1kfQvxwsH.x510B8fDurjmeGpYDcMzNmiFKNXndgUHXaQJJsDzhTlq
 8JryplqVOe2F45GoFTgUmbJ8NLwGV8n5wcd5yRhTgqLeSfhS6mPl9wLF1sIfrt54c11nc8H1svjQ
 9w_d8hcrY7UGr.k9FxxBBNwW4mVVNE01QwocSlY47tQZydtzBCBFAvaTHAVCb0rMkN5obtaPODT8
 fVwgBClZ646u5O9DibTsHQrFjWmrbMzyj4izHtLn9g2w0s4vWSVvEUXJjNjBvZ5cRqqv48JFwiOC
 R9wzZ82i0Ml2MaNaqjWl2oOOqUvZjb_uSjrJI4uppEVnCgYQgf19FIEmlruaf60u2OCvbntukry6
 gmQ8EIDOyNcdzh8vpbQdFaXdJqHnbYwU1SwpEDL93C5XgwMkciXQKmZ1_e7njftp_vWMvkmBakGg
 lvylosX.HCX.9egOVQGyiOTKrhStB6olnPYIMS5ehfO9Q0EQIkjjjck6ao7gIk7OXN1G4btVJq.T
 7irkMNZd3059XG7bLmatzF1MONP2gwldmFJYJF5thswLZs.qUXNFkWt.Dkdhr8qeTfXRvL_5oZmU
 wEwEKQVYUV3tvzQXOVY2genqLIq4HlE2ik9jwTxXfPRGjpjflRNVF_izRd_8GxUuHEP5b..iSAyT
 R3W.X6GK7q3IBbfPOAQHJ2whN4woVDLuZgN7uFHh62PWzBnoWmVL.ihaLBXpCSreSyfAfI8kKyz.
 wH4OVdOIqTNkYM_iigvOWhW2CJSNm5Bnky2hfFiMx.YbBP06PnrnWb8MWOyGyTQDQS945yTYHx8C
 X8IMSPLiIICSqMlwKOp0K4sZsNT2uzMSZAWVN8F19FLNZAWyss9iIZjfKMCqXcCKuvG5GNgu7pEL
 zjno_T750RWjQbjFmYFWKDKj.RN1viMsy_dBV37CyVSLcMRqeU2_0Z.W5ouJkP7lIVBgSiWUYZ46
 CVFZTuJar1EMP7dVFKTv4l2cs2Rz9Wy5iV2Fp59Q3P.85Rvv2AsR35TQ9HIdb1LiNjG0qtBfOztj
 aydGR0i_z5BiOmG3YUoTGGy5Fzi83sYmXk._8_vYS4wVLujgkQynqSDQwj2.8ZYT9fojqfM.20Lx
 CmM0Gq6uH9BvC54R7hLzgt2tb1U4WBkqkKB.rk5rCX5yQEGSpucMD7w--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:19:05 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp401.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 54e8f28a4675c25365c7725d1b772c7b;
          Tue, 09 Apr 2019 19:19:04 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 15/59] LSM: Use lsm_export in security_kernel_act_as
Date:   Tue,  9 Apr 2019 12:18:04 -0700
Message-Id: <20190409191848.1380-16-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409191848.1380-1-casey@schaufler-ca.com>
References: <20190409191848.1380-1-casey@schaufler-ca.com>
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

