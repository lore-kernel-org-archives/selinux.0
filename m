Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0AEC04AB6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B3324630
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="BtRCULC7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfEaXM0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:12:26 -0400
Received: from sonic302-9.consmr.mail.bf2.yahoo.com ([74.6.135.48]:32803 "EHLO
        sonic302-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726541AbfEaXM0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344344; bh=kPEVpSTXbzStzk2RRdBr0uzp0UqHYw8ZEJtQ2z8HYS0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=BtRCULC7uJYz0APOGHqBysF5btLpgQbImrGj3Oo33FCuHUhEIa/DKNV7sTITkM68uu7eqFpyRs02xZsXrxX1iwjOGQDv/G2nz9EVPkWry9ot0at1Nf1E1X3yAXtgPmHj8dHxJsCMkvvlzMAJEQOcCAdhBtowE09PqZtWDxW/lNgTuqkWv5aeukHO8J/WnlAIW+i7rjxoMOLjZ+3p05A3ED13TfIsy/bEnSmcklrmVis2ZF+nLb70Vad0pQ3FNkV8Bs1AMaAvobVRbmx+EdZffUdIPHb565qoiIzFqFdzAwCl4iP0AKDogMiO5BaSR7qciDezzawmHY707S2Oe1Xg2A==
X-YMail-OSG: Fd4AGe0VM1nCYKGy7lVyAGi0JI.xoOQ22UpixIWy01pj7ii6bEI23Qhrn8QWfuw
 0U_PpxkN0Jn1BaTPviKDhRgTmtPH.A6Ls1NTk25T_x.qyd8vdTrWCpGGbif.57S96odD2mbCz9fe
 SFA9Tm0_a1LQ8WAA7EsuiR2fVo4FEJKfk6wNzcdxcgiSYuzcFc_7HGequGvlnwOZeORcyOHvmTyQ
 pVvwjY2mzOGruRekJgKcs_.fH_3ojqGEQZGLqhtyCgKpxV6Wg3fDvCgHhPxBgw7DiDfx4mwiCcae
 AqyCYuB_5Vg_IB7Yw2pgMTE39CTzJVqa7CNRywpXe.M1PjI7XX5g4uJZe2G8LD19BO6h9IxHM5SU
 LWP6iVTsklg2nYNOD5QQH9xtCxjcSIi9f3DMBqpVoLxIy1CEGsUmphOubQYf2i_N0pBAE7XDUGN0
 NnOWc9NU9VFvfvZA7vjk_W_OYyScIKkGmlOgE4fI.aRNbv2GoCrc7c5QXIBhhL8iYSMSHLouqwV6
 j.YmP43kheDzUl2dEEsccly4aDQKOM2m_RkrFo7zb0BzGUHJJX5nxURCO6cEBTm539YztOMXTwaS
 CGQsU4ETmAatxNmRkO0cK8ICZBdHvXWgf0opIJwz04xa3lRbLzOu.AQeclD8QMnQKsEdz2DmGZGn
 lq.0hE4Wh3Vg_9cFqmdLw8k8terG3Ol60ZmmxAzfJAuMr0eXM_KayV.AL.Pey94E_zJSsddGUEBt
 9R4pbMjYyiQHzb16E53hZWkj6jHZexHnECBhvZgROnwG9coyxf8ftzwwqzlbfxhMgPqmBNFPRQCs
 9E72KYzewrw4oyUJQZXLjk5zJSv1OWFktbtFOEDan2cB713152zw_6MMdDuDSwDwIzaxwI1wLSUm
 KvpZx5UYS.IfgxKopT7mbPXyB5dhoX80ZCejODuyNe75p9R3DQdC12GwATdE0UO3vJYf6JnXJ5_N
 P6goxUu5DIR9Z5qekAitrE1gZMs2fE_4.4rZZYcfb3h6GmK4p6JNsNwF_6HZXB4DgmKKaptsbUko
 7PODrQ6A1rGGIJmHv4IdZgqD5ntSGa0IV2ZXd1boyqf4FHchFw9bok18ZNoVUFScpwxMLqsZDjTe
 DLDAkWeW_YaUq0Gp.yslNN6b1hCeX0wutQNFjvA7SYRdkQV6ydef1pKqMeNprW0vDb.xeigaK.EU
 ISg1iqZ7qIOoU3so5RScIS0zDy2uSWJcxT8go8wnqBWuW6dDLTjCECh1Ko5UJNX2MiHMOmMkU7T0
 9WPRStiwi5qkwK1LJZTx3MNtgrt7yPQx5GX1VAcc4ODl8oA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Fri, 31 May 2019 23:12:24 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp401.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5c1c0ca95bce5a627929b23189b28d7a;
          Fri, 31 May 2019 23:12:20 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 14/58] LSM: Use lsm_export in security_kernel_act_as
Date:   Fri, 31 May 2019 16:09:36 -0700
Message-Id: <20190531231020.628-15-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
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
index efb6edf32de7..9305298eca17 100644
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

