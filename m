Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5F0C282DA
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE5F2082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="SuNmFK6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfDIVlN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:41:13 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:42231
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726847AbfDIVlF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846063; bh=1W3uUkvFiV/hG0OeWxySGoGDdIhr1Nn/Tz9IT5pFX0c=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=SuNmFK6g084lWQL1MHF4HH79/GKL1Sq5elX32q0FBB0eDQ5TyMEQFpi8UGFCXCIfWSM3nNbq6Yr0j+q/HwLuw32CvcWJC3gg+XLSxAuaaqrAoEvqojwpDt+3p4Wueqxqe9HU89b0d6BxzBqFinQtee9BtZj31f7G22MBC8L1r6yp9c7nLt55qzfKDYDbtDfOIkpZzHiJSGqPq8DtseNmSQ+DsQW2tWIbaqHKPf4EYnkMjB7bn0jLmRtFKtrUCEAW75uSRCFe4gWtgsD+J9DwhHUvV05ZIMAjviVm64CUdOwZhSNecsEJFE1r5WmdkrDm8pC6HRawhWAlFF85vabW1Q==
X-YMail-OSG: LYqTMFQVM1nxh7.B2VmQnw68Pr0Tl8eSz8QHIzqI.0Lxq0BzwDIU1rigydef4oa
 jhz6q2G_iUqeaBeDAJt0vh8uzMsIALQ.xziBuS2J0e2xbaJU_050LX5H1ui3VGTSGxQ_ajikWBTq
 VeVX8F3cGJPUPUtGryO3TqABFDrgVIg5UoNVIWViA1P1NYg3BbgxbfBfAuZYwStC.9zDZ4nxGLGG
 Joy2uTgVVaERklZVr1xod.EyUcZSds94lxcM7YRUelu02a6cpABZLznCVCkdWsmYEr_s7ZpvkRdS
 3720e8m5l7o_9BSELTKrYct3ZwBgy8dpOzjZvTm16uPrfcYoRVVlxw.mtPSxdDaxEJTac43oUsaW
 WMpwHdZRe4NbsB4HyIMllhXaMvlsvtJKkJotqZ3.7OZUuBCMFSm6rkugo5hyNGIz2nwfqGyzoDSV
 uvo.08zn0c_EoFl7OOjwNeYJ6zLJthbrsQmI6Y8_E6tkn7EacuwB1MwNR.Jilif.qm_58tM8EtdO
 ykzUb1HK0x99P0wMBGp4.rxn9yYCLUpfsWKXKdUP_MmgqeHcqxdAf5tPLBfOobbFUy1_AApq5E40
 thMoO7Ms850L3NiUGR.s_PYzmxEhWH_2K4dUbFLgRv6qj9r4h2Yx_4_qVVusUgBNBA6493cwjVAC
 9HmYtNKltjG1y0qdRKpNM5k0SKZZSZs2rWi4q_g9snKcLZz3WSZHNEJAwZUE6GkDKTPk7tb6JgH8
 kOc19AEOc0F.ky6fmU6JGX5TIgnv5C9yM8RHgDOoSRVRr1r.SF.eyUicb334GBbiNaL9JvoH_SVw
 Pl0UrGHgrxdUEKsSB7ZBwtZkQytfAuIVI1Qu8cqI5WAZK5eiVSFDiwM1Ope6AZCj5mWO3XxGQsCX
 uv82aQFTUMJpQ3kSQAbw48gUnp9Ys5Hg2RxK.zRq8ar13Ge7DYgYF.Nv3Ki4ssdqxaOw70JYCv3S
 tTef3dxdz0a0EC0U8iWNBLO.AmA4.mU.0u4V3MKG9Sg_6u4ATGqO18GTEPkz_mOfErJ0du4yFHV6
 yZcmqUY060iq6Vx9xZj40TwpA2xXtDaT9v93W1dpZmo7OfHSOx78CrV0YmFSLB8qj8GsW6XM3zMb
 ijNwv8uEG_WcrsGhJN0fXXZXA_yG1nwb0rkt1pL3oTM5jXDNvrymiiy4Hu3Q-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:41:03 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp425.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d8fc391abae2ed5c1368bb3c988d9ffd;
          Tue, 09 Apr 2019 21:40:18 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 15/59] LSM: Use lsm_export in security_kernel_act_as
Date:   Tue,  9 Apr 2019 14:39:02 -0700
Message-Id: <20190409213946.1667-16-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
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

