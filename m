Return-Path: <SRS0=eUs8=VX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B03CC7618F
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 23:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6C121994
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 23:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="TTUDxSJQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfGZXjh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 26 Jul 2019 19:39:37 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:45310
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727813AbfGZXjh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 26 Jul 2019 19:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1564184375; bh=pBDl/1vQPZOTGhA3y1ZBLm/3xBXXHuqBGnmdEc2nJIk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=TTUDxSJQF+8o0CKI9PlbXN+aBhcu8qYuu5cGVQ7X7Y0TURldVHma6p9RO5wKhT4NlD0d2xuCPO6EI5N4tslAdFAmfwxTCBsg5ei33tUqRy/3N3yaYfBwe0CQK2FyzS/bSfC5awmsU3+zTdTAu33ZNrWLcxia8uam1F3RV/o8OoE60LN2S6ncq9sni33FoTgwyvgbYcioEw9iu5c/9ft72RtEMjUikrWv5pmLM1qhS5To6mAaO8FS0SLputqVGd6WBkeyvMP3Ju6EMI3hZ7Jts8M1+HMbKO5ILbda9kGYPMMmDYwtc6N28Lw0dmBJ43/pJYE9Oem0X9+WwwPfFzyC+Q==
X-YMail-OSG: 0DX1N34VM1khdQpozTpduRTfzQ2.m_FOXVWmsHrjKqGVRPV5mv1hzv6UuBmIpAF
 .7vJZ3..SE6VyVxBkB593LN9kRgz5qB0VyeFBfH.MlSck.lq9oWltxECma78saaXC.WqhMWbnnM0
 ZbKbHQWLBbK6NI7ZNmcB5VqjOFfB_Oo6G2VikmcUecURdULLhO_Ga4oXW3C7oDpGGhUYobyMjlVB
 rQpezvNirLFjqa9O0YfBvzIbweH7jFDnsngkC6yB0_TOgxczaPs.ChsoRTzuY528IV_G3nscB11n
 hCVSrbwkflotnqCKYko2QpBf6HPufBzWIVNhdb75s2rzHCsz2SyLN7BY1AhoI7eeJ_sDpWKWRLwG
 qgfFY410tW.mkovR_TiePrh53fGOUhzJtsWc1C4ZD6mdPMIx2IOvG6enFDgnL8BJKQVz7MOmIVcL
 h1rZzf6vKV1OLbcM148oLAcgMI_1EKGHoUxzoA3SPgpcbBJjL06xPz9yZ_R9wryXHy3OdROXaHEj
 EoaHMRKecoQxoVrfQy_80d..KdCiYSuy9XLUQEzLbGBWabp69L9PwyLPujyoM2PbqM1rF4xCaRdV
 XNyFpZ9mUs8tRESs7HSO7yl5sjLUYJMi9QbH.zo2d.S.nfUyNwG.QKH75SAvbvB.1p.TysQq8cIi
 7xdkq8GuE5GNrBNKvhuW7YhccRP9xFDguYU7PkXI2V3H.8ZX.GMxZqrQMf7pwwYBP1l2pXZsF_if
 H2HO5hAj.whmn7sYJ4cmzV0l4VDk_yBTmHHyqai_6k_uORMk5aRTtLd9G5_speTndhQBb.VJ0NkA
 aHmY7UyfkljGys3HgVcbZYW66qfzLA3vL5SHU18dAhgeBgnRCm7DjQorACSxwm.cYCLbHCfZ_Ku6
 gq7KZY1PiQyorAOHyQ_vi2VEhR46vYdrGUO.r_10GEwzfyDu8twAVMPIYNGb_whSgVPrCcqFCEjy
 bVM32OC9npmHJ6WcKiBQm34mNjCZs_ALXMKAWtGB_.QmbvBCc04v.J0mocFjSXYpt6__1__qRA2f
 c.OpnVCiV1orxZACZh4nOFZmS7OOzUx3yUCRiOvpOYCqYJYAx0eXiSLPx6FOgvXMHmBJcDBF_UBN
 k0KU5yX9gV.whKRV1MPa5H.QA9bE0xeEyXOdVeYofRY9pN9klVTZFSx3YMAv5.99tLpfgtYXVbse
 Y_KOFydKSF9KIXzhsue6WsCddAvx4xPImjsjSw8hmLIgoPsXrBNJURORU0hbOphIFZGo6KV4eFZN
 uf.dzSgFY3JW4KWbQxHdPLet9320wr83sjj98E9wU6g--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Fri, 26 Jul 2019 23:39:35 +0000
Received: by smtp419.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID faf3134ce3e2400a4a56efaeaba728ba;
          Fri, 26 Jul 2019 23:39:31 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 05/27] LSM: Use lsmblob in security_kernel_act_as
Date:   Fri, 26 Jul 2019 16:39:01 -0700
Message-Id: <20190726233923.2570-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726233923.2570-1-casey@schaufler-ca.com>
References: <20190726233923.2570-1-casey@schaufler-ca.com>
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

