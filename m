Return-Path: <SRS0=dBUy=VA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB492C06513
	for <selinux@archiver.kernel.org>; Wed,  3 Jul 2019 21:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B452021882
	for <selinux@archiver.kernel.org>; Wed,  3 Jul 2019 21:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="S0zqjYm3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfGCVZz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Jul 2019 17:25:55 -0400
Received: from sonic314-22.consmr.mail.bf2.yahoo.com ([74.6.132.196]:42578
        "EHLO sonic314-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727248AbfGCVZz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Jul 2019 17:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1562189153; bh=pBDl/1vQPZOTGhA3y1ZBLm/3xBXXHuqBGnmdEc2nJIk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=S0zqjYm3aYQBFvT1WOH02G708ynBIUqD5yWFNm0QgbYPwkBOsgHzhBoVWNktWrj18otsr7H29Is+aS7/aFoCE1SU6fb/fmVsUFF2+lSqvF1s3zCPC+0iYxIGXIHR87SgzGafJhIriecPTmby/bZ8fGh4NaM/9XK/A9V7/3Jr7YIFd4ZY5ATwJxHXAO/yj2jJI1DAOd7B3FH3w4ETY0mMTwflD5/8kaPGzMeinkjBebfr6FdnlkTqXKeNq/cprRSyh/OxXkjr3smdMdOCxFAj6zzYgN988P5y7u8Byc0CW0/WvX2L5CEAs7oBACSesrztSFnRbJZPntCgGk95no1QRg==
X-YMail-OSG: GzwLOm4VM1kUQNH3mUS6_zvC_e47Y58.WaKWgZQ5H.zz3xq5DRf1tHvMbj2wL9f
 Xnxxsza22_bovqdWDgs9eSJA5Q3HDYZ2BuyIA9MziPbp6EpzxmyOLVeLjUkhZrLAO6QPHixVmLSA
 7ujjbsW9ePIrqMIAT3eAN.atE4rHuMrJfcoVAjXXlIXQxqJngDEVIlKkMtu9QAnDcCPYB5xzQfiS
 E21vovKUvlyNg0r_hQsgGRunYaSolvHRAetB2vjNh.e9BpDkHJ0Hly7l7N8972hs4cdFWn_dtlAm
 5GzP5FmFWf0AZdrrLqoqvTiXoPyF0kJf0BdjanOJ38rHnWZP89xGNQ.S446FDJriLMNF9qcogK1K
 7jw.gx8U_jWDdBjUBWuWI12yN4FURo3u3gXn03jc2_dKUDFQ1Vff.a.qcVMHYwQ9UGh4gty22Ln5
 nPoNMNKGzqjDY4W1VmwczZiA4i1k6wGjS7.DIWpgLcOcLGi_8zJr0NmiR5OcGN9t_ajaQBNxaTuo
 .S8mX4QGiVaJ.CSPNOK3qNhVDX_4hwikFM0bV1LEM9M.usGM_mikQUJ_dCyDqVjB9D7iZ8QDwsgQ
 4KJBZ_7agYf7qm_AFG7R.ywzZx9IUNKValivZr7TriN.PzP6MzVArzp0QnlIJpkL0qFE01HfkQYZ
 e92uiYlUZghs4lekecb5bSlSHeRatQ4A6E8V7DTcls3epQuviUCQ3iwSGft2f0JJ6QkI.o8pfAIq
 7q6pGkrfz7KQJgK7_Fm4htzRMXCFukZbUnmi9mW6FGzo6lAKOovs1F_p1HFdJmIx3UvieIboeR5f
 trmsa1G2H5JLdSBIXK9zRaJAI715Uh4jmE.aH24meFE3jkL3cmfpG.eyAOqyOmBxUWw0w1cnKFtW
 yTnIkxDL9qGxBrKrPPq2WqBuTwOhigUTMQ3QYwjF0WmOtq_Wo056z9_7LX2vYdmztXgLqrEZWfKv
 2W7XCHEJTWW.BaoptPVZ3Xfr.mIJCokTpsZiui2F_8029dAv5ekw9rmb4cErnedAPV0kBPwtz1xn
 vTIt1.V8W9q4nwac1xh3sF6UdEpGUqW7E11g7pyncfM27F9VcYsfVykKhFTEk8f3yHPOlcxEwaKq
 ZiY1kdI3tF039eDSyWd2D7uvWfR25M7uzEwKj7DSqBY.h0J..E3PBpW_0IfiHteoc0KWUh1Nj2pu
 mx_N1.AqhXoOYEFAcdkElTvx8QSwZbHorYeSG1eVu5lvphmHAQ63AgSIhVvEyL0sVd9MWh833GQV
 2hhDv_YcuK3xb2IS6lkr5KBdSxUNGPDyOjMUAheCigZ9uMan5gyA-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.bf2.yahoo.com with HTTP; Wed, 3 Jul 2019 21:25:53 +0000
Received: by smtp428.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f0d1593ba5df32fb20abdbc1b1b8a4c8;
          Wed, 03 Jul 2019 21:25:52 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v5 06/23] LSM: Use lsmblob in security_kernel_act_as
Date:   Wed,  3 Jul 2019 14:25:21 -0700
Message-Id: <20190703212538.7383-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703212538.7383-1-casey@schaufler-ca.com>
References: <20190703212538.7383-1-casey@schaufler-ca.com>
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
index 4f8b478bc3a1..313e45a3cac3 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -388,7 +388,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id);
@@ -971,7 +971,8 @@ static inline void security_transfer_creds(struct cred *new,
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
index fa6e425e6f29..fa7ab1334f22 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1627,9 +1627,19 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
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

