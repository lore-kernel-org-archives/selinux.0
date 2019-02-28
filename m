Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B734C43381
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ACB32184A
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="oOBgNcpH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbfB1WTx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:19:53 -0500
Received: from sonic315-15.consmr.mail.gq1.yahoo.com ([98.137.65.39]:36120
        "EHLO sonic315-15.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729478AbfB1WTw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392390; bh=lNuLNszdoMS/3Ss674xKLoLguAXJvpX6T97bTKUBjpM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=oOBgNcpHle9qLwexmRgNZvGZ16jhl5fLR5GLNfVoCXpV16eTrHBymxBPTrdwGAtMnLl3VQlHD8TIftLBNox70oSnNEzB2ysdLUWuc0+zS959a/+4tB2SqGyaPnRy5Yq/8EtVs5Oqz0mzqIMNRReZnWVE5xk55ZB2n9599jsg0FYT+lRwTnkcuLdTez4zH6oh9WCPyRzhd6SQ4v3ocIRVwcyow3mTEI2gnJQDjZMf6VbH00dJ3RzWIKjITcbps3w6Fwb5MX0zVV1Sv908lY95DGyH7qpkxY1cWUBNl1fHhn8yt8m8p+gSLQth6VRAeX4mjXfTq87z2l9nruni6ofjsA==
X-YMail-OSG: bcDa_tUVM1lfcM40j8tbI1NNe2PWyWMymjUqCspMK0SbOBnYJkVUJR2Mee6qKGs
 A9tvekxtMhN0UuDq6lQAvj0rmtAZOWtYkM3ANGnhqcH.f4NOJitIemIGXwzhan8vBFsMt.njdy5b
 ZaBW8MuDX2Z5xT.dVmfZNxC9IXHRJ1tE.oJ3hEqOuScMPFAyXAWOzAaaO.EkAyagLi3tV7XqgBw3
 yfYOjWyIFHtpdhE0Vf6bBG1aCW924sub3_rkQx_Uxq71RxGEHuqcW1sICx7oMdqRopF8C_ImsNn7
 kFgjkQARhGh65oxkeml5IPlgERq64F7A.CFvr.OjSPeIHPY3iRh4T0sgEh.02apeZyYN6fVZndQh
 s.SW11Mm2.GN5qdWl_DLBgnZADmemXnpeV1DHSKIo579GpMQsfDBP3mzj.y2kiUJuuHdgmnxREc3
 evM1JGXjJ8i4.zxt7O3TuNKiT.3nxpMFKRbhpBDvAAJtyQLL5EnfSbkEZkla23PXYkJ3_JqATsAW
 cEsTUBmYSbP.K8SGOgl2Nwfz4bfipLPBeS7yFljYF2Qs8qALfTf3JoqquPnni0.3EL1CMoc95kAU
 UcO22z2zHFLMs.OZBDPOTN0sOghdHgKlWnuO0TOOkorI2MansrzuJvTobaySsoh7mbFVmtIXY9CQ
 VZEOzvlk7g9gxuD0VzIXNdEgVPSu2Muk42Sfb5iztq4PWlAprUXqHk37_wXoLDf8Ja.3iF1Le87e
 hagQhc.goI1D37hP8yTk9AMq4N7I8qpbevWHCtoi7wbnd9HeyK9Oc_zPiNS_kowHBe2SgqPLr8yt
 8B80YQTo1uzlXTb6TV1gzBwUEvVfT11b3O9YuS7t_zxJdtO.bYRh3XAlYMpkswOTBUHRpRqiwiwc
 x6IbnNClJEHSFTXt00jSK2uzJI_xwPh_h4nPPm9Ta5VLuZyoZmp4KfjeZQeVaAJgAp3EbXovgptX
 QpsGc3qznSRUrIwnUgt36sdliGeqwT3HZEyKA_n9_nDn3tSj0ytlqRbx9xTxi28vkag3.YeHgToi
 ThSpAuytQaq1tZJMYdmq3Cx3BKvrDFaicp1wqBU4dgB3beF8gXDBcfNLSrQf.rtB6aZ6.WWOg1RT
 Oqc3HZOgtDf4Ge7zjb7eWDEt99BCTN_uBEHEKZzZVVs7Q3g--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:19:50 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp427.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0da9962b364e649f4905df2b440bd211;
          Thu, 28 Feb 2019 22:19:50 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 11/97] LSM: Use lsm_export in the kernel_ask_as hooks
Date:   Thu, 28 Feb 2019 14:18:07 -0800
Message-Id: <20190228221933.2551-12-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert the kernel_ask_as hooks to use the lsm_export
structure instead of a u32 secid. There is some scaffolding
involved that will be removed when security_kernel_ask_as()
is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  |  4 ++--
 security/security.c        | 15 ++++++++++++++-
 security/selinux/hooks.c   | 17 ++++++++++++++---
 security/smack/smack_lsm.c | 12 +++++++++++-
 4 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 44597189fea4..796eb441be95 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -562,7 +562,7 @@
  * @kernel_act_as:
  *	Set the credentials for a kernel service to act as (subjective context).
  *	@new points to the credentials to be modified.
- *	@secid specifies the security ID to be set
+ *	@l specifies the security data to be set
  *	The current task must be the one that nominated @secid.
  *	Return 0 if successful.
  * @kernel_create_files_as:
@@ -1588,7 +1588,7 @@ union security_list_options {
 				gfp_t gfp);
 	void (*cred_transfer)(struct cred *new, const struct cred *old);
 	void (*cred_getsecid)(const struct cred *c, struct lsm_export *l);
-	int (*kernel_act_as)(struct cred *new, u32 secid);
+	int (*kernel_act_as)(struct cred *new, struct lsm_export *l);
 	int (*kernel_create_files_as)(struct cred *new, struct inode *inode);
 	int (*kernel_module_request)(char *kmod_name);
 	int (*kernel_load_data)(enum kernel_load_data_id id);
diff --git a/security/security.c b/security/security.c
index 909b6b8d1a50..1a29fe08a5d9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -738,6 +738,15 @@ static inline void lsm_export_secid(struct lsm_export *data, u32 *secid)
 	}
 }
 
+static inline void lsm_export_to_all(struct lsm_export *data, u32 secid)
+{
+	data->selinux = secid;
+	data->smack = secid;
+	data->apparmor = secid;
+	data->flags = LSM_EXPORT_SELINUX | LSM_EXPORT_SMACK |
+		      LSM_EXPORT_APPARMOR;
+}
+
 /* Security operations */
 
 int security_binder_set_context_mgr(struct task_struct *mgr)
@@ -1633,7 +1642,11 @@ EXPORT_SYMBOL(security_cred_getsecid);
 
 int security_kernel_act_as(struct cred *new, u32 secid)
 {
-	return call_int_hook(kernel_act_as, 0, new, secid);
+	struct lsm_export data = { .flags = LSM_EXPORT_NONE };
+
+	lsm_export_to_all(&data, secid);
+
+	return call_int_hook(kernel_act_as, 0, new, &data);
 }
 
 int security_kernel_create_files_as(struct cred *new, struct inode *inode)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6f61a894f7c5..efcd905bdabf 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -220,6 +220,14 @@ static inline void selinux_export_secid(struct lsm_export *l, u32 secid)
 	l->flags |= LSM_EXPORT_SELINUX;
 }
 
+static inline void selinux_import_secid(struct lsm_export *l, u32 *secid)
+{
+	if (l->flags | LSM_EXPORT_SELINUX)
+		*secid = l->selinux;
+	else
+		*secid = SECSID_NULL;
+}
+
 /*
  * get the security ID of a set of credentials
  */
@@ -3669,19 +3677,22 @@ static void selinux_cred_getsecid(const struct cred *c, struct lsm_export *l)
  * set the security data for a kernel service
  * - all the creation contexts are set to unlabelled
  */
-static int selinux_kernel_act_as(struct cred *new, u32 secid)
+static int selinux_kernel_act_as(struct cred *new, struct lsm_export *l)
 {
 	struct task_security_struct *tsec = selinux_cred(new);
+	u32 nsid;
 	u32 sid = current_sid();
 	int ret;
 
+	selinux_import_secid(l, &nsid);
+
 	ret = avc_has_perm(&selinux_state,
-			   sid, secid,
+			   sid, nsid,
 			   SECCLASS_KERNEL_SERVICE,
 			   KERNEL_SERVICE__USE_AS_OVERRIDE,
 			   NULL);
 	if (ret == 0) {
-		tsec->sid = secid;
+		tsec->sid = nsid;
 		tsec->create_sid = 0;
 		tsec->keycreate_sid = 0;
 		tsec->sockcreate_sid = 0;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index d5ff34a5803b..0e1f6ef25eb2 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -473,6 +473,14 @@ static inline void smack_export_secid(struct lsm_export *l, u32 secid)
 	l->flags |= LSM_EXPORT_SMACK;
 }
 
+static inline void smack_import_secid(struct lsm_export *l, u32 *secid)
+{
+	if (l->flags | LSM_EXPORT_SMACK)
+		*secid = l->smack;
+	else
+		*secid = 0;
+}
+
 /*
  * LSM hooks.
  * We he, that is fun!
@@ -1910,10 +1918,12 @@ static void smack_cred_getsecid(const struct cred *cred, struct lsm_export *l)
  *
  * Set the security data for a kernel service.
  */
-static int smack_kernel_act_as(struct cred *new, u32 secid)
+static int smack_kernel_act_as(struct cred *new, struct lsm_export *l)
 {
+	u32 secid;
 	struct task_smack *new_tsp = smack_cred(new);
 
+	smack_import_secid(l, &secid);
 	new_tsp->smk_task = smack_from_secid(secid);
 	return 0;
 }
-- 
2.17.0

