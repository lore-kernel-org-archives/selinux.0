Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6737EC10F09
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3046A2133D
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DgMO7t3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfB1WUA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:00 -0500
Received: from sonic315-15.consmr.mail.gq1.yahoo.com ([98.137.65.39]:34791
        "EHLO sonic315-15.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729615AbfB1WT4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:19:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392395; bh=gSgSkfLKahMvLxEzg0eajjverS+j2pMpt07bcZcjOeA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=DgMO7t3eBYmBxF4sZbKiA6dqDNpg5/a/hdGIIZmnulWKZ3P7Y3VBpPSe1i8KzP23aYjW7yPLYMe8Mi/CuGnE97j+Gh992sD+L1cpYQWf+229KP+qymChOl0ZMznFbC8mwqaV5FwpiUs0kLHTE2Y8sOXJEbOAabkK5GViSWiZRL7YuFwbhZuOzHwlLO3bKvc+SDSUsh8mseahBv420g32HeWJ+cO3P15YTxetH9x23Jd77CdtQYDB002B10rLeZcKcIJp780I4V76nxmjQhLa83u665DT9wi0i987zCIXwDJpEWWC3eAHH5CYS/ZW9GNJjlLTdKClwrfBHDo/MNrW3Q==
X-YMail-OSG: OC7XMewVM1lFG4WmV9RboA6IyKyVEKRlrSDsOYtQlH_4k7Ow5w7oI7XTu7i8LE9
 fi0mfScT8penidCJ.ljOb87InOaP_Mc9fu74Y54P1nIiU0AlVfy7r7Zr2C_kvB1edfMIs4cvH1S3
 7i1Yf0oElfpa2cK_7OAHeIQw8cfFb86.FvqU.e0j43KCR8AJ0YQkhg0Ham1dutM9UqlAIVA5ts9j
 wTnG4vYZeFHrROOjlLQ5qn.w9Nn0h_IEmEXD7TzYEyHsDP20cKR_rGvvCd1xqmFCJ_QqzxRLnoFt
 D9rPmjvBRQFiZM_BaeI2kte15TRLithvuk.evCLSwtABprv3z8EOi8WuBOZssMFyrvPF.rXIYbVD
 TDL_vFudFKQjeEPRBkdJQ81CreUyoEDzLo.W6Muo5FdlWKYX8GUu9Ojq4YXTNeatKmW.QF8b9soU
 WSXk5CCtom7bF1HL4y5nF5Qt5KrR9hcqISl.IrEat3krenS_1pQmJR98z63Dl.YbHalzud24tII2
 4XSFyDjk5s0Xp7.wnSeb3uehCtEejFe7LBm90G.7uyqaztTzVT.uukhRBcJpUs1OXxkpkihnEzED
 Y77bRgBXW6gckB_6GvTtshwRjehHUacBT_zWOODzK6OBvEZB9F4_R7wH1Rq8B5pyvWSN66J5k27N
 Lirdu8L.F7XvFY5ZJzEVN0_OiHYcmtDyhXPJIurkdcU14SSEzwhbKEwET35w68l1oRUZlMaNWGnM
 1Abgnk0B_JRC75lwmqHcOnPcaXg0REtK46HRRllFs8Ijl8hAD1omWPg5YZNeRAJvYm4GSk6fofT_
 wgUftJoFrT8ouknAwpEx3yL8frWROT9F6JZUPwdngmKgMy.qhaHo0evQ5WkKpOxbLReHI9hD5K1X
 j4fchUnOQE5YslN0fs7ftKOlAezisKWD0__zxlmvltVc.xPk2qtHbePUn_QFm2VsnK3FoPOtn2T8
 0HhFjRUAGPDig1eZS5wL4mEbVPDGSNfCanwTFLIITtAEkJqgaP.ejS6HyuwFrJD4lSVZLcLcfZSb
 9Kn3bN_7qgS2Qtp5jA9.0lc3k6jV7MEo.fAM0Ty9hf4iU6.uh_YwKZHtY.8RLW2QLN_Z64w5LuLb
 SA_40Jv_m2c9BXnkdcsWcNlKz_S8oE5OuVRLmkKYzaBaftqk-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:19:55 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp427.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0da9962b364e649f4905df2b440bd211;
          Thu, 28 Feb 2019 22:19:54 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 18/97] LSM: Use lsm_export in security_kernel_act_as
Date:   Thu, 28 Feb 2019 14:18:14 -0800
Message-Id: <20190228221933.2551-19-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
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
index 73017c9e937a..08fb928cc86b 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -373,7 +373,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsm_export *l);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id);
@@ -945,7 +945,8 @@ static inline void security_transfer_creds(struct cred *new,
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
index 43afcdf1e424..1607f19f2824 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1601,13 +1601,9 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
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
2.17.0

