Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6317CC10F00
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D022133D
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="JUAMnVGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbfB1WUD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:03 -0500
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:33157
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729776AbfB1WUC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392401; bh=FzVvjR+NFksvu4dNddqr2/PVXMCrtqnd2aRCMpeNGXA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=JUAMnVGZMy+yL+kuf3fNwhI2taDO7JFPEx5V6n1gJjZNqwxIz6SLBKVnyZE3k3ms9BPPRQpaUc1qKzqYz1kWorOVUah2fKf6bRj4J4+MSTwzhKP2PFdZ6wTXJcRS9vE0XigJP+80/eFnP9ANklMTqss4BhWFDhPV9T8CyQKxuFNOIOMUJG7R78Egc793+YkLzFdSRLl/EkGXly8Nr7bdMKFTDabu1gs16FHKOP6mx8oO2fF3m+97+aCU65NoEJWCFeUFbhl0zPTwPmItlnlCixv0mNIUqjkKdmPdc3esQHH0AM9StqBhdMDfZ4WaixI6WC63FX/t5dMWMT+Q6e5ekQ==
X-YMail-OSG: 5N3hT5EVM1mB6w_4r3.DdYZ7jqHY7GJUZhEGAJb9kW3q2ALH72dJR7EYohosJES
 GAnbRsERKq65q1XC.OHRKYzNdrInIpIw7rimQHihreh2_s8cJmcwroZzvLdXsFdQJC4gnBbfiwEV
 D_VLN8JsjKMTcvdNlSq65svyYXyLGvIhEBpeeKrTcV96FhdxEvWQFs6Gup8jvifD2lurXE97WlZD
 1Jmz1_5U6hT56CzDCVa02CmTxERBc201LPiz7qwQrX8kOddPyWbDeYFm3kLmRfzcKxgGhcSzm4pY
 yNcwjrlP8b5FLMquQXDVdPqJRh8_3EhKB0ikGDpAFfFnq9NZUS0uVSXHGWk6PssUadsiI9BqknSL
 Y1dq9MCmvwDhHxqqG1HwPnaM_F8mOzDOb3.yplJ02CHRK7glOX6RQF_JTcIiZE3pTNeUS2Mh0f2j
 DaqdciO2HPZgyM3ii4ZmWngZzC7skKWyQyxPrGb9aRGfA0Lv5Gp6YUqmpJKsZUToLCG5GOkGc.VA
 EWZ6DfCYv7rA4Bs49MO0D9scBFmGXoE6TaK5RMecsQmqAjjCAzW0DCUEL4MwwcnkvQr0N9BQv0S4
 asbWlKe.7oqYd8cRmDDbyZXL32IuN5MP0GAnhSNRXU1Whnno6_TwdtCyLaeumqMAzCMTkzNOIEUj
 PrYrYZLM9RZUqEW6nrqmYVqsdJquz38A5YoavT.W8mhBLfNUHPVDejmCZ3eH4XLItQOm42SOnsnm
 Yb3bSturQtsDFtvEM3iy6zurmv9O8IvvCdAkooC_YM8T1e8qIISLSkEYy4z0ULULzL2gEN8ecObC
 bxtu5juGwRSHQYsHoEjh7183qJH7EX2boPjt7wgr6fTZDEBa36RPTXjPWWwZO4kL7YBipjMVFHIp
 PHhOFGsttMAT3Fz4JXNdFXX.8RJSs1n2r.P5Nfq6_C765JUTIXV.uJnisgly0UvNn1kSx91cBxhu
 xjT3dZ6OJ78wzejr0IckIYSh_gzLkPgLL.MzwKCK.I_S3pAAxvx0Y9U_vhCaiftg4ma8Cr1TkKGu
 wqP3cJQLWGZLqhxb8kxTQTeMFp_CuQJvSjMqCYKq8jGf5VnV00q6kO2IX4cOaE71d7zxXV40qU2J
 nGnukyZ8jUNUDJTTtDlDb2BmzfF1RtpTnaDPITcPflLK8EJ.T
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:01 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5c7d685bea94a92cc9d12c4cc22f1f0e;
          Thu, 28 Feb 2019 22:19:59 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 27/97] LSM: Use lsm_export in security_cred_getsecid
Date:   Thu, 28 Feb 2019 14:18:23 -0800
Message-Id: <20190228221933.2551-28-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert security_cred_getsecid to use the lsm_export structure
instead of a u32 secid. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h          | 2 +-
 security/integrity/ima/ima_main.c | 3 ++-
 security/security.c               | 8 +++-----
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 07fd36f6616d..87085ff519bf 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -376,7 +376,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp);
 void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
-void security_cred_getsecid(const struct cred *c, u32 *secid);
+void security_cred_getsecid(const struct cred *c, struct lsm_export *l);
 int security_kernel_act_as(struct cred *new, struct lsm_export *l);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index e78658b26a74..7efc806eb5ab 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -374,7 +374,8 @@ int ima_bprm_check(struct linux_binprm *bprm)
 	if (ret)
 		return ret;
 
-	security_cred_getsecid(bprm->cred, &secid);
+	security_cred_getsecid(bprm->cred, &le);
+	lsm_export_secid(&le, &secid);
 	return process_measurement(bprm->file, bprm->cred, secid, NULL, 0,
 				   MAY_EXEC, CREDS_CHECK);
 }
diff --git a/security/security.c b/security/security.c
index c2cf82b063ca..06461712c881 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1590,12 +1590,10 @@ void security_transfer_creds(struct cred *new, const struct cred *old)
 	call_void_hook(cred_transfer, new, old);
 }
 
-void security_cred_getsecid(const struct cred *c, u32 *secid)
+void security_cred_getsecid(const struct cred *c, struct lsm_export *l)
 {
-	struct lsm_export data = { .flags = LSM_EXPORT_NONE };
-
-	call_void_hook(cred_getsecid, c, &data);
-	lsm_export_secid(&data, secid);
+	lsm_export_init(l);
+	call_void_hook(cred_getsecid, c, l);
 }
 EXPORT_SYMBOL(security_cred_getsecid);
 
-- 
2.17.0

