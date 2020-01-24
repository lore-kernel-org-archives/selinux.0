Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A35C35242
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 00:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98572087E
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 00:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WqwlTRfx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgAXAXx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Jan 2020 19:23:53 -0500
Received: from sonic305-28.consmr.mail.ne1.yahoo.com ([66.163.185.154]:38488
        "EHLO sonic305-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729304AbgAXAXx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Jan 2020 19:23:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1579825431; bh=biXKdDal8avL2cs67nKa/B409u1uTk2B3mml7ZtC7Bw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=WqwlTRfxcMCQikY4H3XqHGgeySsb+j7tPoUD2SkUEMRYV8IeBUIAQZaoaSkFAE80H5SmDjI09Z4eluhUuydKpgiL8UCMXKzSJEAWSROh+7ACJoxzxCRERLCnzPEcNBRgHF6Iinb2EDVgVSPI3aebu6mU8aMEsIQyexWGZ92c6kvX0uGlo6QPBtvVYpyKVfGjTOkzssUso+G31gEEBOyzQThCMpCjoTdLkxI0iFR9TiKmMoVl635TLTQA82lVlM0XTDNXSWAahPhYEjgQ1Sxify/ZCa9j7B2OdFYjHlTuTYaDZZdnbm+alf4EaG+OdUQpprdDk1HljF0JENbBOw44cg==
X-YMail-OSG: 1yL4WVMVM1kX4JMeoA21MJawYFp3icLszaclCy4nMsBMewVt9bU2kHJrowXZpeE
 tduKy4I.LAZw4w9V9J42osF1nGVq9VnQEdQ5CvrGcUtqztzwVYyQ0ZDVMNZyHkv3KGb9xh9ZlR4N
 lPTHsRjvBQ_E.GaCUWBz9q6MP5zMeeyUTw7HR97tGNbgNCS7bT2AMSvNnqIGgfKndChwn6w3IytA
 IRIGkS8mtp_wjhQxDo.2nSxwCImNCMs9Wdo3I7knWtu7NNF2cGhgBYa.9VK34Aq4eNzdKuwwpTsP
 xkB42UDiXE7Yr83n7shIHjXHA6WurioRS4pIPrabjuqwbLq.IGl_gsK4ty0a6xwAWM3G1k5VuXAR
 AsP_cPNOyaO2luvckjJGVxLqNk0kql1gvsFalQwX9ORE7EN27UHtyBsbMoHDE.m1f_K2.kdKtdUT
 Y1STh97.R3DtbRnHrPSCzxnhsPDKqymf9W198e47REC.fP.nx6s6gXFp2_vbJhx4e2dVs02mEwND
 UKU6OgbnMDxRmTjUCimvDfnCFNZ4.sDJSU7mExGhNpaQLz.aWapVHk04qpH3j3cwjvprGH4ByJbX
 YUOsfcaww_1bL1e64OrX7rgIMYOuMWxd1FN_edZhKOScQLNT00rSYbbHr.xya0qpaccNa6lAWomP
 BkIAWDJ4adsoJqpx6A1xexTUaG2SGmlKGbLHmHd2w9LYA4Xj1sfeXtaCpwyeGi3Su0XGBZMrx1Io
 EsvHFkFyA3TyIrNZxg5CHhGTCWjQ4TkFzf2_4FENXPd6NnNdQ5aZCApMR3.JKvMNRzzTGWwb1XJv
 spmA.27UyeXkfcFj0x490fsu2yvXQnAYfwKQKaAOoNgmswGefg3LbxybvnZNJYxDuXUSLUvO_NsA
 bh9HpPhPIUn6Z3lT8RTS0kaL.dQbiMIq7RSF6kpVVkKPaxameek6muu_uqVUFSwpcbvrB3DTsFZR
 CSoSzlUJ4fZbe7KWhLCsVJSWywi0pCtS8kbbgf4M2S9YWe.P2gwOggKWjNfo6CP5bvee3KT8MESZ
 UFdCHSuNy7mHatOxvQcvRYdTphuT_ifObCZ4pa_O4r9R2HIN.LM_Dv3_7TnWufGuhU6zxXVYLgp7
 kpFSH0zAcDKfBNFdSYYyo5_QwtnJMY3ACpH3DR9ts_vMO7o1mBlhTNE.pRw8YO7JyJq1inGh8WBx
 YeE8nCcFVDTts7vv_AAgrWUCxHqIdVGgumhyDVbwyiYI5ohvmnNR5k1BEDm6263Jnl6iQrIJF3Wu
 aSj1u3qlKVRAfE5TBfXrRa8W3AkZ0hdcMfyBvXUGUbqbnPYeo2aeYas2p5h3XsDFHuof2OSvXMDJ
 _CcK8a8oK.3ivquxjla7jUTaqto34c.CzDCzHMB4iTt2pCun7kll0lrI5qZAUbWqmPgGuQh0CymT
 81oBmB4eisTX4IIV.29Is2bfQwuq8XSCu8yIklmqqmlwh0QqkLyL7oQRo
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Jan 2020 00:23:51 +0000
Received: by smtp425.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7441c4768916c3ca0a3a0d8b691cbd8c;
          Fri, 24 Jan 2020 00:23:49 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v14 04/23] LSM: Use lsmblob in security_kernel_act_as
Date:   Thu, 23 Jan 2020 16:22:47 -0800
Message-Id: <20200124002306.3552-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124002306.3552-1-casey@schaufler-ca.com>
References: <20200124002306.3552-1-casey@schaufler-ca.com>
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
index 1988b728eb3a..4f01878ca5d8 100644
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
index 9ed51b70ed80..490d72825aa5 100644
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
index 3a2529f36269..f53805de4343 100644
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
2.24.1

