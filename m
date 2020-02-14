Return-Path: <SRS0=qygk=4C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB38C3B1BF
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 23:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52DF222C4
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 23:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QVEvKZcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgBNXmt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:42:49 -0500
Received: from sonic310-31.consmr.mail.ne1.yahoo.com ([66.163.186.212]:41268
        "EHLO sonic310-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728126AbgBNXmt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Feb 2020 18:42:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1581723768; bh=T54rQV8CSCnr4XkKEc2qRlTsrM4kuFgwmoKr+LgYOmg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=QVEvKZcNlGDcVURdM4V3Y6Vw4se6Id6v9hsDF7E2zIURbVeiK5g9PYnzY8YQViI5zqSlRriJ2G15kA9SNfl/pEZBMJvnjSkkSruS270HQh70nTCi6CpdogFL1lebAPeUzICtsddCJNeg3TXKSPpUZxazpZIAf1ME0c/Wf2AZL4+mFo4BgCZagdHWv3F77H0+UFU/0HneY6tAQ+7VDYOgBWE5C3paUxBxKomOVOdnxPwFbyD5v7tyHJXqMvRJVBNfK0iTggHgAZ1wg3moKRRSFtAaWcXgdDHpnnmTUXkerA5d/HEsVNseYRVR6cLEeUlXIjwQx3EwfoU+v2oav0z/xw==
X-YMail-OSG: I5nkZT4VM1lHhfqfpX__2DrS2BG1gbuH_heEHSTrcDiciLCbOARPbsOcjF7qopT
 eFRM4nnyrX6yDPUxoRPmDADmERyL_zaYwkeklex3GPsMvClh4y9Oyie6ey1GuissSw.y14Bf3.VG
 SvgX2o8cuEZ9Le4jGk9CoasTCB.rdgXfX6Hbjolydhh.VDnYxc6Cbu1kyb.3ktCDY.Tp0HzRJjyo
 iY1fXkei2iHPfHzM_rr1aACwds1s.l22xcPPYiKFUfQsLWw.For39F5iKF3aYHQ2lgxeZ.TOUL0A
 slBypPqdzQ9s3D5HgKgKYjAWoCfwDEAATIhPZooaiHKo.ffmm02pmT53p_WGLKM0lmQUslWzn2_R
 UW19DFkMYz34H7NTOa8BL8T5M4dqxuobIx_uTtiTyMLJn1PN23nqSz345wamDpA3DriOPo7sn5Y8
 qbRL_ulezhpmwHCZjCzPdKocBlEdh3qVFCNZTjD_yfwjPAt7g6JSx_AzbZXZHDTpq3BDSIk1B2mX
 fJHWT9VL1ikO6JYAmwZqVOExS5wR1N6AoLuzOaCLf_lKO5D6EV6zZgPHLYde.PihNJ8ad4wrtkGG
 T_g1Mq_JO0PXZ__NzpnWwqBjnNIsdUeBx0qF2CDg8zA71c.P5xuk6aZDOu21L3mGWwvZ.Byej2nk
 i4DikE62TMyvBo7Q1FUhHnWiDsHrk3yA0bPYVkTZryuM5Oz3wiiMq7bo9ENsDdQfhEKh40kA.lVO
 soudV_3XfB0QeOJAScHBKQ1vC8JXPOJj8Cg_eslMaj7oEhy5HNuRw8fxEgpyRs3RoIP6tcbQJKrq
 wCa4pT64NwzocnjglGJp47zgMGFm_Ej0QB83MHipZPzbCi6oWSmZjiQSLfr35VlgYjVdSiqEEejn
 g6rh92fWR9Bvf8JA_lxqAbn6.rdVrGY21olOV5KbTD.gGujKW4O9iWTklz6id8yPceyj0X926kiE
 2f5LWAYFoACllI2WIfDw7fAeBXZ40.3.hXY4ZN7xcoY_ewcGf31ee_QuN54G3p3TL.lOjKuSlquZ
 u8LkqPEVGpflVKUR6Yg_QVXsJfqHl3qkugbyM1kTs7RQvsLi4hHqT9AwqHYnP3pfjlcE.H0tQNXD
 pb2oZusamAwsGSqRILpi9L2kP4HVOkWFvg9zSAJ16YeecXbxWazUxnUNaBRTLzVEDJ1iZi46YDZC
 YfLKga5XKCk7eXVLMsa9rF73YebzHVmwDvfjzY5iuO3S1Jt_7vlNMI.CffnAAo3kA1pwrK4J_sZh
 BXf3nXzuHagaqIIO8uyKIl7J2wIqFmU97tNuMKrO7gGJg97HUwM5qWyh4qH7cvpQlAqn3QsjZ.qP
 v77aAKchSb7kE4WPgZFEAmm9mP8UQ8SGQuqu2tO9qQ77jEps3g2kBTyfLBzCgstWtHAzDyawEphx
 dOADd0p7M9Fj8nuzbbRjoiZfoRUCeMMGFEjrfJWfb_8GyFHu_DS8fLCrAzqIA3Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 14 Feb 2020 23:42:48 +0000
Received: by smtp404.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b292bb0fd345409316b9003c09784b73;
          Fri, 14 Feb 2020 23:42:47 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v15 04/23] LSM: Use lsmblob in security_kernel_act_as
Date:   Fri, 14 Feb 2020 15:41:44 -0800
Message-Id: <20200214234203.7086-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214234203.7086-1-casey@schaufler-ca.com>
References: <20200214234203.7086-1-casey@schaufler-ca.com>
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

