Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C0CC43331
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 00:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9552196E
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 00:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="E/Q593ZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfKMAJj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Nov 2019 19:09:39 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:40008
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726952AbfKMAJj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Nov 2019 19:09:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573603777; bh=eVAcx7o8q0AFLreBS98x3GgYwdFEcr7jaVdmiN42/p8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=E/Q593ZJN9+vG+mqxgzSKgYMyec1k4rByLbcA8w+uNqkM3ZUwXXuzqfe0o+oeg7y0ylhMMBSzMogRj4L/VZAkdLgpnaw4oqdez9jdlb3wbie5ySQYTsuwAGSEQ1c7RhNn//VEOem/rksZtPJ9Hbi2xbUMoerSigqptHJJvQhAOoq7L1LehOrLUWGaSOQq4P9brXOluZV9mNjzv5/osLWBG+/OAVsDc3M1EUhB0PYqnbFd+NJ2GBNg28bZ7I8vynuXQ523S1WR3SUyOM9sCZSZ5vBgU2MubFi3Z5qAL/OpnNCOFR1YNgLlCNKO55ARMO5i2flSNu1I7L8gDm1vn0L4A==
X-YMail-OSG: x2yE95wVM1lOJGLrlegJfpsqH1MO.nCRLG10MO1waS9CeP50mtXtUTZZXl5fi5l
 UFEyND.eCXJ1nvScqaDQyinuizCu1fmQ_.OMj8YJ4WjqQv4hwDYKTcfFOk392MeU_MzFPAGLF5U8
 sFt6W12WobOC2WTByUuMfWXiPeiycNDXb7sRqrD0matouwXz5bER6KvKBl8dv2rm1sbzI4KjyMHS
 kER2ZZJ20b8yKwpzOco46iCkl9FrwyMsP0GvSrrNbF9YPKRaZCImV1kfQEiiOdo4maj25gP12Jb0
 l5XLcQzUCqCD7CQnDeV4PQC_1QjA7D0h9uRYj5pe26qjCO8ojRR3Y0KaMafRFrIiorNHnOpVpIWm
 j.M2MdAMhrzlvqR.IN4AwGV1SBfPHYYnx7Q8Es1xhtEUIDpEvdbCCJ3x8y.W0SEo.Pvl.vkezrv5
 S_o1_hrHNTPYxA4tEZy7fjYwTMG02Gk3zWlmwlZP87T_23XSb5ZYizOOeAsB1_O21A3n9vKas8Im
 bjpud5wNXxWSL.GiXXVcwxwYV_gmsJAWwELUeB4Xoc3ixMAiyDYH_UGAvQxya3Ssk2eqhciMlKWj
 OMRe.cv4B4rvD36fMpKhwjLae8G_fyKtIZ4aov4DsG9PjMJJOBqoRC0dHOKfqBCrErahZPHMPGWm
 LQRblJ4lpIvM.RXt_nyoOFhm2qqSuWfjRgznGAv9v2mrvWYTkcx21hnYIO_fNmfGtUC9QQHAw5G5
 o6WLOTBlhcsLSFNW5QA0a536YfEB4oCptOdSsv442NWg4aKZ9RNEkEvpePzLphWaPY0gBVZ9jd7D
 KjBjdJcMbwW2Fvhs9uieGN8LBDB0zHHHPPm.zHKLG1DgfmE8ntiWML7CCR2.WZT26fTT9MFP44hm
 khRODGzL5rG05cQqbvvX0_xVbLe_W.aZINZ7ZLIeuHVoioJc7BQ0r79lqDWKuNrDdhzl5xZm1Fti
 81J829sOD2HcLIcDhEGYLRJiqEuKLUMxGR.OyUyuoRK.5Uqb9xnWRTTZWYkE1uXy5.3rR_bNvRx5
 DXlwwA2rt42HX9EByLEB9.1LbYQgTCPdDtN5uRcwkREfIJ3_wRO5NLI4kX_9J1LPZ1JWw9K1iEY1
 3oCHAc1LDA7TUiEhmAmwkSMQrxPlsVdMpiTeHH2eNnVdEmL1pUb0MKUOd.Pa_et0.1m2.uxJqlWM
 eAzfFHUfSpMPiGeCk7koXv0JNyIF2MbAHwa6f5.zJOEc4LcljRwAYBtNi2S0ZCwlDhRSELaPVYFB
 uIkbk4Jt24WZ.n2aQ0wfdXaLcEuybqcYDIsTs7xyYbSzgq2KcPXm.ekUci4u1tMfhImufbfosIDi
 RCzgCJ9DlUXgepioYdWFSeRHX3No9gwaTRWOiMk0utsjjOWFG3pcpvuP.zhA8xUp.U.UbdhqVJrO
 qZ3w3z8NlIrpxIcp16nyL.3Ug6nfvC8RPzIfDWVSnch_TKUWehMIprHwt38DTqA5w
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 00:09:37 +0000
Received: by smtp427.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID eba4c54ba4d55f2cad95fb20ef489486;
          Wed, 13 Nov 2019 00:09:37 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 04/25] LSM: Use lsmblob in security_kernel_act_as
Date:   Tue, 12 Nov 2019 16:08:52 -0800
Message-Id: <20191113000913.5414-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113000913.5414-1-casey@schaufler-ca.com>
References: <20191113000913.5414-1-casey@schaufler-ca.com>
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
index 2df58448f1f2..2b0ab47cfb26 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -435,7 +435,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id);
@@ -1041,7 +1041,8 @@ static inline void security_transfer_creds(struct cred *new,
 {
 }
 
-static inline int security_kernel_act_as(struct cred *cred, u32 secid)
+static inline int security_kernel_act_as(struct cred *cred,
+					 struct lsmblob *blob)
 {
 	return 0;
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index c0a4c12d38b2..846ac4b23c16 100644
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
index 7c386cbe4cf3..dd6f212e11af 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1615,9 +1615,19 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
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

