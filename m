Return-Path: <SRS0=lMs6=2O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C771C2D0C3
	for <selinux@archiver.kernel.org>; Tue, 24 Dec 2019 23:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346A72053B
	for <selinux@archiver.kernel.org>; Tue, 24 Dec 2019 23:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="euq3sBWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfLXXUB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Dec 2019 18:20:01 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:32872
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726246AbfLXXUA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Dec 2019 18:20:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577229599; bh=/tjZqQ3eFg6RGmAZKeaCUxadHu2YVRy2b3KPUAFCwsc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=euq3sBWUnVXLiYFUiyecfJwbf5F/Mh/IwSWwDzUbWcvEt3Zq4ugd8NpxvYIDJO6KAwT6r1TRrvO6EC1uOStJ/FpjaME1Y6k7/6Ym0uiwNQzMVQjygQ8zoguSQQ8jJ6J0UqxuLTbD+nvV+cHMxFXp8NQXF1ljuwavRX64Neoc2V+x/GYbDqX8VvLh1ipEltQXMZvNwWdcM13dFnxUtXF0Yq4Gq8ngkjQz2biO6ppN6cvgh78hCLAkDxzWmu/Liiq5GuYtTBPtom4ncAaap6OgIflhy+QlcrSU9pzhBm0uhGmBBiyjXIsfHe1bqhpJhaCdyLD0eko0qL3Hd4t+izb2KA==
X-YMail-OSG: JYtSupUVM1lLuQVGLguz4Z06KJpZdYRUaS1TWW0j.IQyOt5LHpvzJQGpZaQRmRS
 pefHATKDqoTtFMENO5ywGWsC1tnfYAZELqyvEZ3zUpkI3q7_Tz9Ks4K1NHfWxIQ4EXXWMyHlwmJX
 2iE1YVexIItXZgKmAefY_eO2bAelX74Toxn306pIFqeK6KjfXlwrlF.guZY9yN7Ta31xnAaWid3M
 419AfvDzKYdNRpPf5DF2DMaJfar3r5kG4Sb9YP8W_u9gaJjyuyT2aTlWbp6FdcdW.FTzGDHXFrb9
 cnW9un0iltbeGZ78RpPqmwakz5e7yRDZZ8EdWROkhrMpJWG4UdutCGFMX3opFCSEzDorXnzyfCCQ
 Y6JkQ8PSbpRnLcNkZbmDVTdBdEsm8tlg.3rkUypZar8NAOn9qhGn42tcvTezunNIqWSgOL1ESbA2
 JQytwCoCBuUUR5jzXFtp4WEeIyJ15I6HDFjJBqWmWfJZChdwaclFmsmrWqgq__F3M7vvBpITZyoA
 ZPU5TQY6NCve3w_yT4itQWkpNE69_YgRJl_dHhVh4cSn2LzGi.uXAqIExvfrt64N41mv08rAYQKt
 yUB2B8tAbWqwOgTWtjjrZG.K8bJUEJyTUt_r94wtW95ZHhR.bUVHQV9B5VbXDmtf1SfAnhQOFBY4
 r1LJe52dFTMtfkCy01WV6qkm4xjyufY20jo9JLuCUOmXDee3h6zkQJeDJb.2Zr4Ii8D2Qbybwvcx
 _Ae30yUGIYrprG6BVD7FISnvp_OS65vvyMrayIOIe3pStDQh1TawFjgfCUHYcwKr1nvG4l8bcm3k
 0FbmhFOQcs0ZJtWllZbouT8WaSMctEx7XoPfFKz8h8YTHxwvvGj.cbCe78Zn5PqbQlzt5KAvKsTs
 s6KI8Dg6zcshIGXnNKrWZwny5r8iQfZ5NKXW.kh7bcph3ukdnYML.aLY7inITWec6q1WUT65jHvX
 ayGs8Ukm6X3xW0guA4G1Yb1FTyYxRf9kfRuK1q5rTfGiZVkwXIULpByu3pQkTi_YLV8vv.KqlQzQ
 _rcoStq.AsZEqOG1IFxLvnsVqKth774ih.YH5cSyAX61qNk.GEoMajPxNpXi_5yQp2Au.g4H9CBH
 EeWZpbW_OGfZMGwlCnlLh_NWEYvv.dr93rBF5zAdr0TuZgU5vu44P2DBBmUyKuAaDVKb05mkwYPL
 bdh49uxPqrI6ZZ6zFirGMRJkZ1WV7Q8eZOWGlCkCvPPpUkCQqfsUpsTxj5O3zjALoDY.kvMriSs6
 SOxSAMgCVAAEiqGlQTIGzSzCs8hQ4976Ko2dEWjzdkbNw5fHYMW3YRFTQB1hNdXlBzCvuSij4gvK
 ZoeaEszFmdaPUc8VYn.inKpuHLeV9MmeyF_mVVb9iwc0pHSkUPPG3DkylP0O__hEFmXzsr71DiMZ
 5HZrjxBc8XVsG6bHnnHjBmpaBZbk7n8tfKQhx6HNCLEosUypwXCsSddnXf8wNdubILw3iWhUXlA-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 24 Dec 2019 23:19:59 +0000
Received: by smtp411.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID de4ee649edc9f9bdc14d9d12d2a0a973;
          Tue, 24 Dec 2019 23:19:56 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v12 04/25] LSM: Use lsmblob in security_kernel_act_as
Date:   Tue, 24 Dec 2019 15:18:54 -0800
Message-Id: <20191224231915.7208-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224231915.7208-1-casey@schaufler-ca.com>
References: <20191224231915.7208-1-casey@schaufler-ca.com>
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
index 9c6dbe248eaf..322ed9622819 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -437,7 +437,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id);
@@ -1043,7 +1043,8 @@ static inline void security_transfer_creds(struct cred *new,
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
index bfea9739c084..cee032b5ce29 100644
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

