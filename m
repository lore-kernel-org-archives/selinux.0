Return-Path: <SRS0=XbfQ=AU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC4AC433DF
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 00:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83CCD20772
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 00:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="UHtHQZDm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgGIAWR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jul 2020 20:22:17 -0400
Received: from sonic310-23.consmr.mail.bf2.yahoo.com ([74.6.135.197]:41441
        "EHLO sonic310-23.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725848AbgGIAWQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jul 2020 20:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1594254135; bh=gmKYodA13f/iqNza1r9bZEiXRTaYnvzCdsmQYA8RU9Y=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=UHtHQZDm8+rq4GEtCt6yxHTOV83tBRpyouI2jtz+mK4txZVekAPFclT2M27UhSq2CvivoHU17/5g7dKzYe2PCBpRFMW5qq4GUigTQFGvYTI7/XE3f9SKAFjNp7Eo0jedn3oOL620+JKTRdS1U/CrfOg639tuhIZaINu16BBqgSO1WmNyxx322ZAv88qu21mXeeM113wkvd672nKr1KBbpewdUwPU2Ep9/FOUasy3NcIM4PnGZzSOaLF+GzUNHgg0zHnHdWtBCYuWN1NBsGuIGpMq52Ar9i3oRKSoblqLZDuW+UwyChRY7tDusw9nb4SJpjAwavH0UpsFDxJclxkjtg==
X-YMail-OSG: iyfpUnYVM1msR7b.xcN7Dmhq8G8KWR3pUC77yjio.bWDxn489cgvZ93k.sc7vYp
 zsQz7RrLs3DgD9rZP63RssW8JRXUHdubanc5ngwRfOef.Ai53k87T1aAROBcjoHo1FyZrGsjEIPi
 jPhZ.Ggb1LKcoUy.LFcObzoJJWRE34aSNEXZ582fKPA332j2KWEo8e2Xx8._uKkSd7yJZM81dczQ
 VtzN1B113sPi0hl.1TnIgdx4xl1iRNcua7VYHSrDr.I0JBHYlOfPFch.ovnbL46ErvwCE6gqofoo
 fsXFuzDVx1fAsIEl4Ylcn5C1jW0X4zPIWCOKDnWUHVHPMFp6okSEzDuhXrw5Abxi9Q9DQ9SjFOUR
 zLQcRjFshMNI8kzLWYosBSYru9qNhwhnIFkkmi4SLmsj3UB9rEUqzoz8duNoiPqnwNSc5SesbIya
 dr2r8k6qp1bS.nsFZJtPdyB3rcUGis.agmVH6JU0YA_7TwXK5Rn4bdE4vxnLfJ9uFETBERze.rno
 ymJjjU3dUpRngxfTIO_WhjST9LdjJCgmwK6U0kTbh3zsBkmiqSYDerbypP95ic__.GkjI5EShxM.
 704L08fpHzQ53vBZjIsHpEfX.X2l9ZM0aYu4aTtbI6pTVsksXVT_3dh8Cxs.mufLZMgNTrTZpLB.
 vkJ3T86DGh03NEntoG7Z2XDcCInHaHUC6uwIXFrEq5.eL41n5F8w5kUxVJE8n8FkUXHdBK.Xi1Je
 sqSQmTaV_5z4POOR8pu5oW_GOhk2hBmmEhigRm7612LKniBLKbjmtPMI9IcFb5hKplukghq1heav
 i93_cC_F7arzCm.GIbupGES5KEEuJvZm7g4KLT8b8pVC3wGX.5SekVoK8LW2ILKBS9egdIwDCqM9
 WV6YtmsoiFBdczvDRsTvxF.FIHPeTmuyRKCXy3zXnz7n7LPzfwKfZdxe6TbRJTO5EHsRG7njF5lu
 V2JrZJYdhhMlFW3OmZgxfW.EpzNERoE2urbavriwqOm5nbvTG3gcUj8Y7w_mKgppYMJ8Qxf4rZGc
 M4m3je5V6uEgCjtb5TaRMRKwuhC9qeiGtZjtDNC8gebcGFT4EDNFYQA5h1RDpsRxz6yHuXqxKAXT
 YiYFWKAMg9HSegvzHbQCp7XMeWbqdC.ISQK7SnGR7vR1BCVMIPmma7sWGbyYq7uJgBgHbzXHP_IJ
 20oUVpb0Af4fMI8Gc.4Qky8Yaf_C2VPnw8tRk2FZF8s5LqoN3GsskGxlf17JQCYqAMQJb9WG2iLp
 FJS8i1RxzrUHpMsNFW3Nhi1ZGPfFsKWGwakNCgcUj8VKjpda8G0q9BtGBYvXaC3yVOStkWfhjqHg
 uAqULcF2CPc48OeZEUspQ2dKnoQt2EpEgs8xCPfoBKEWjZEKLxlIzFi7b3DhMa4Gleu7xgnxXee3
 d9xtxNSSBmPccokcrdB1RyoZjGK.C7o7sCA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Thu, 9 Jul 2020 00:22:15 +0000
Received: by smtp411.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 1ef9d1152283ec87df72ecdd60c48e1b;
          Thu, 09 Jul 2020 00:22:13 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v18 04/23] LSM: Use lsmblob in security_kernel_act_as
Date:   Wed,  8 Jul 2020 17:12:15 -0700
Message-Id: <20200709001234.9719-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200709001234.9719-1-casey@schaufler-ca.com>
References: <20200709001234.9719-1-casey@schaufler-ca.com>
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
index 294410533b51..6d403a522918 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -441,7 +441,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id);
@@ -1055,7 +1055,8 @@ static inline void security_transfer_creds(struct cred *new,
 {
 }
 
-static inline int security_kernel_act_as(struct cred *cred, u32 secid)
+static inline int security_kernel_act_as(struct cred *cred,
+					 struct lsmblob *blob)
 {
 	return 0;
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index 421b1149c651..22e0e7cbefde 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -733,14 +733,14 @@ EXPORT_SYMBOL(prepare_kernel_cred);
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
 
@@ -756,6 +756,7 @@ EXPORT_SYMBOL(set_security_override);
  */
 int set_security_override_from_ctx(struct cred *new, const char *secctx)
 {
+	struct lsmblob blob;
 	u32 secid;
 	int ret;
 
@@ -763,7 +764,8 @@ int set_security_override_from_ctx(struct cred *new, const char *secctx)
 	if (ret < 0)
 		return ret;
 
-	return set_security_override(new, secid);
+	lsmblob_init(&blob, secid);
+	return set_security_override(new, &blob);
 }
 EXPORT_SYMBOL(set_security_override_from_ctx);
 
diff --git a/security/security.c b/security/security.c
index 3bbd01e8192e..f54c6dfd9b89 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1677,9 +1677,19 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
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

