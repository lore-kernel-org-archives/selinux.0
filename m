Return-Path: <SRS0=cgF/=2P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87732C2D0C3
	for <selinux@archiver.kernel.org>; Wed, 25 Dec 2019 00:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548BC206D7
	for <selinux@archiver.kernel.org>; Wed, 25 Dec 2019 00:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mtyHwAxb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfLYAA0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Dec 2019 19:00:26 -0500
Received: from sonic311-31.consmr.mail.ne1.yahoo.com ([66.163.188.212]:44180
        "EHLO sonic311-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726245AbfLYAAZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Dec 2019 19:00:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577232024; bh=SPCO4lR2F95VbSXktcVi3IVHOM/5Y9D7ZIbUnkfCtYg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=mtyHwAxbqQCzvizGxebqJ/UK0MHwVX/8IwYPFV6LXGt2JEk1pjz5kdM+I4JedGhjTzdenO/JvFkzIZEtjKFzD7aNt6jUBFoVhJH/HGgrsinH2rsdH1+39h6zJyQLMss05QCZzwVcgPuPDfaAsiN9mjXNtMwisaXwh3kKaU3vSTJN41Yn3PGPrjnvCTWSuAnvDBPR4cIDihziyd6VCtfHZyeI24eRD4pfX1e/ak2QLiOoo4s4lNTR3oxG4ZIVhSOTYjzTwgAq5Xs+TUhY5YdaNbNClGAP1cpErRh5n06gXhttCiRUjbqUFvnEp32iA0kSYWNP3B/13/oQmyzodMifeg==
X-YMail-OSG: Racte10VM1kGWPmfGT9RJw8Wl4eGdB0lJRCgrzOEv.fTswW3F7bCHo1OYn6YmOl
 bi4JthrolHfqAS4z.0v9BsfixoR9VJMIa4ccIbKr2gAwJlhSUiF7mTHpoA.HDt6xzmh2HjVjYkgi
 XJz7Grgj.O.qFqrytXJZ08K5f7Ft4p6C6iKrIiJJnJ6L.DFgkmpeCxE6shU5wpqwEAv9luF935wv
 AjcIZ6vWc3qsnLZdq_bTLQx.GoraBSymlEVumRmS57DysmM64GWE2k7Of5yuGqPSV458uc_ZgOb7
 GI13ltA.shKh.RjhWnccN1ZcwbwQ9otFvot1Y51urmxA.p0nRXrggJjSWo4uB4SK3GvbJ_5sA8LE
 fVAsvTYGvXOaTNZiWbKWMQfF8Z5fyqkpRusaDJIHS_A656KCFFjYQ_WqRRHv7d08Zzt.fOu_xEwp
 sE1d91BdfLHWdVBbLls69Z0Wb2.81q4NExg9xKyUacWKN3d1AtKgLnWb2nyFXxXs44FOmTOLKzKH
 KvBnS9ZwRwmJiYi_xAvdWzqlbH5K4tnwDjYoGXmVu08rtNgQPzUCxlAYEskk2EPIZdIVC6YNmAGb
 IFVGpiuzxyjk.zm8d4.kmTbaDi4zDt2DDf6TkaNbvtS5CLRV3xEsIbe390nLorC6_uRcMOlPUCM6
 5SWTDI1hafhj00XnPd92ntQWMX.k4qf6hRptJiMh9bwIVNHdC7GCE5uFRkSsPlm1fl479eWaxLIl
 _AIXWJSAQID0lKx9U_qyOaRPldSOcBTnG..P9Q7Wabp0X2.eXOy.dljUvRUeukx8rtdoZftTdP40
 7g0YmaLLcXs8TTRGnkZKMOPCmMzZXCOcQcuT7U25jGts_Ylb9M40p659WnnNKIiuNTfjflXiKwPN
 NvuMMrpJvtr7_HB0LZws0lRjL.MzLeEAJtu7jjOA8Cho2Wgj2Hq6O1mKkvtS_Nx8GjlNCvvnXAlN
 .snLnm..1QP0EzJXdh2nVly72Q5UEtxIwWhvS90blszx34hIqwHlhQ86Sdu_3c_BA3D6ert_VxZT
 2aV3c5zKUJ0SkUZZxq1O3vXFdq1l8Nt01XdeKZjq0Fm3sidBcwuQuy6m90eBoopKYMbQywjeUogl
 yJR.zE8Yyx2c2x4m5qz_4aHJhoA.5JT3B9NVNSj.bwf.Ppyq0IgqHlZ95xi7zC3_ZlBZIK5KoXX0
 MZyYUjHNDiUFtnkLuZgrY8jGdm7jDlGHwYsqeiY6Im9pxE7Xi9Mig2d7FImzuD8nSbNIiDjyehfY
 wXFFGVAI1sDgxA.Eu8YyX4288KZK4dAavk.XjFSz68zWgHzCL8TLxXupc.fTS7BYGpboCOGhQM3F
 OaR3kWV.eKsb7KmKooshb.GdsOJuhQ.xvmphz01CE.Mx3oXfdUtERcPA1Mo2pJsFDFWPD.nDXILq
 TeJ8BvaCBrZWaWR6WsEegFBVd.HxAsvQyN6vqbXdK6r0fptTu1HfL_UyoYWCrZtQ2WJAGKiW4Y8Y
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 25 Dec 2019 00:00:24 +0000
Received: by smtp421.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9f51ac67b3903eb00da6f8340730a4c1;
          Wed, 25 Dec 2019 00:00:21 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v13 04/25] LSM: Use lsmblob in security_kernel_act_as
Date:   Tue, 24 Dec 2019 15:59:18 -0800
Message-Id: <20191224235939.7483-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224235939.7483-1-casey@schaufler-ca.com>
References: <20191224235939.7483-1-casey@schaufler-ca.com>
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
index 12e1e6223233..674042c6f03f 100644
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

