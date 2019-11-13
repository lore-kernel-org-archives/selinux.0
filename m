Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7387C47410
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 16:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A4C20637
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 16:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="MKzoJ0Ip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfKMQvi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Nov 2019 11:51:38 -0500
Received: from sonic315-26.consmr.mail.ne1.yahoo.com ([66.163.190.152]:34112
        "EHLO sonic315-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728632AbfKMQvi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Nov 2019 11:51:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573663896; bh=eVAcx7o8q0AFLreBS98x3GgYwdFEcr7jaVdmiN42/p8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=MKzoJ0Iplmg0TOHxk8cjDrsEawXycgDYNuDWY3eh6VtnCo3RsmPdLLJcIAEPP8d1lFNBAUxYAI1+M8XggCtmFL/usZBnxW0LE0QEOA21Zd1/ae39yJxftVzhhvvvpTOMd6eCRnpkDTKKI9U8SoLL+YFdDD8IylPgDz0xmWoo6ReaB5u9s4flC25lrobpwQ5v6l5Xss3RI9ROfdTr6b+x3qNIVL1xL4yeNQzp1UB7STOLYRmSgPP8U2jGSnhzh/rMf46iho1Ov0sNIDU2G+pFz4fRHujXcMIjpFwH8JikX+xcBqIEq28mNR/faKf2C0PY+WXUT9o6+GQTILP0XLXizQ==
X-YMail-OSG: p55VIqIVM1mqD8jsMnN2t1jZOm8G8.jptgFBHincN1Y68f2RFNZoyZhNMJG2fiU
 .16DBLJ8B4uKYI5SoDJJaoBPoPfT_clm0.xYC7vzky1PpLdr3Z.g9e2RHV0MnlLYpnlerhhTkXnT
 THbRDuLyL.CWiNxCrtp7g9fBMXBQc.ydtzIPK4fbS.9J4cAYbYvveavsjBS3xvDaWXa5DkegKOt5
 dSLp8JXwpu36bFjgBlUcDHKpA7UK1t7JtfHBQi4vU0myT.FWXn2ErMW2SHuexfGYHbCQHckgNAGO
 ou2Y74Wm81YvXqATk28ocR9GMx8MH6mAFIx6n2j_xNTDcUmhvP9ZgirA86hu4zzwLoCivCg_o0JF
 3hzRbx36Hr_m4eRIUK3Ym8p48jupLsvrzyU9_wlp1xT_BmJBlLndyUpVZCpTrcX5hD6KqGaK_sNX
 A1RgCwQqreP4JStjDWeSRPdEXpRm2PWjoIuuf90aen5xL3RhE_Orw1PBF.UNCcAE8iGwKEMV4UYm
 SGOif3DKPXIvr8_c0lxhqor0Sw0xqeUYRPi0bT4dlH62TCZxEVEEy_RLfDB5CfLnKUln6JVU1gc4
 De3qC779SyJmt5JZFeEX3guxH5TOgR_XHpOteyJ5UuAAqUiLsLr_bk0n2PGIB.llp34fXD_0PEav
 JfqBUJaX72Ozea7Y1gkcgWl1UpDVjdDrrWaXdb4zG4recB9pEQdQrTZBsyVBmMlirMd0FuTH6tcC
 Tsc8YVhluoqWW0DG9cqmeztn8NFGH3NUHQmLc_lgK6zId5z3soYqLeDDcpjZBJaxQDzx45ga9Xh6
 eXo.2kYEKfMzH8QIojtMzy4Hr18EKKNDeAGT3duCsVOj4rupHXFyuMos5PKvE3.r7T5CguyVBGfJ
 v3kmRVpuRBH3NuNWB7LEwzedp7CPMVkTgpt3H7xhL.oIGwaGU98FP7WEehVbcBHpoepfMSbzRIhZ
 HA9TbPu4aA4ygYTufAG1KVja2Nts9bSLM6AGFRW30m.x4inwnBAimAqfg7gLdWkRz3pRNOXZfKOb
 L1lakYBcjtXghJLX4Fu070a1uJk4pAi0n1S5lrLPEbZRhOn4ue0RHQiGyIqL49c67z6umOUyADry
 X33uh6dO.RUjwZNAMTgwMyqVSpDgAFWirhHjIbmgpgs8NT3zF0CywiDKRO_KA6yTF4hNH33PkCey
 9idMB_BxdrUXtNUxpYZ_j2qvd8VrbFTh4AcfQo80E62w_wVyQ0OEjZB2ssVowCtg15UgXKeyB7Ua
 owQoVrXfZpfrtnLTn8cS6UxqwuRiSlbnviKNIbOr_J15GlQC0zGAroRl7uKxyXqKwew4.uDzc0Ox
 2GfS3H7OJCOmBZ8Q4xz95KAXLMtkOds4h.XUrTxPoBTIwttnbk8rPKzRlyKOyUda5TMqpod4htbm
 Fagisg5Xao1gGIB.RgZJLheIUPlaIJ7pPfVbQhEFiwU8IZSdkPV9Dx5UzzQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 16:51:36 +0000
Received: by smtp406.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d1fd8dc550696f9d78519438d0af5fd1;
          Wed, 13 Nov 2019 16:51:34 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v11 04/25] LSM: Use lsmblob in security_kernel_act_as
Date:   Wed, 13 Nov 2019 08:50:50 -0800
Message-Id: <20191113165111.6744-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113165111.6744-1-casey@schaufler-ca.com>
References: <20191113165111.6744-1-casey@schaufler-ca.com>
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

