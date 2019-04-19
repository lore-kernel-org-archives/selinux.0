Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0DAC282DF
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD1921736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="L7vqIV73"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfDSAsB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:48:01 -0400
Received: from sonic310-23.consmr.mail.bf2.yahoo.com ([74.6.135.197]:45827
        "EHLO sonic310-23.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726904AbfDSAsB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634879; bh=kOtGhOXGmB0UKJFKi7rvNlfKTHO47ha92uul7+cYnU8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=L7vqIV733+k/OjN1naZdYi1y+Z2Ft8euL3SOb0c1O1B3WEXu1Dr163obIyxht3GwPQFq2wfidz/Tah9SZlQw9cX7O6xdh6JPU59rmvRk+uUtVkqUe6+GJUP0+ipDBoNr5WXT6X66lsC7bPUjOf7xnilcsZSwIjbtHundgdDVlNlquWNF/rcgCWVEkn6n7cvcAfe452RABHv5GL3kmVRKf0Xd9RX7xFy+iJU8Ibb1LGDAuYviy1Zjw6PXPYvQ018gUBYuvsmo9U/yIVCtPLwqktX8DrFrYK3LKiBtCRWA0chCc2ebK6VevuTAebN/IQk+JKv33IzXu7PnLGP5mfDISQ==
X-YMail-OSG: V.oRz0MVM1lUNHijD8w5gOnfI8bPD5.ui.Myul.o1TEhx80BIHSXn4m6ximgPXR
 kCYdwI2zni6i3PbKdAH9KoevYuKVw527bmVq7pSXyQfNYHjiCcs.N9l6TPpqj0YkxWu4UhjL.unb
 FxKCRMfqi24cqv25glZSaBUHD7B0QXHTs1iAnJ.LYovGdpOJyH5xcsIH5icgclL_enDTJr9XZqFP
 MoJcoEQc3hWKdkQbeXon0uyzdBhgxmvqB1dziQ9PfmeN686YsVYkZQqt8thmHv4aTVzwDvMvS5G9
 e567z8ijHcruyiJLMeGy66otLJ18eFRaKuB5sLrQyjMFOvDS6YcILPiTKwtlLomFJLyNZtlJ0xt9
 Yj_cXLP7j5C2ZyZYkOHBTAzfj9phmPClKamauYcsrAuMrp3qVs13Z6GtQWIsa0udQjSo0ducsMU2
 206BK5C2unfJ3hTDCg9MT5ZUhqeRAI4XpPZsTjFUUjQ1G1gzJkvgvDhZUMgrdAq9jGNj_ZVycbQJ
 IRtOdX4knn98axJ3DI0507OWO8TYL7y812MIGm.oWyatqRpvsATotOqorZaNpaQ94wUvFfliBDQL
 VA5F1E85yaZTJbE_6.1fyz9CcKDUryt3MC46uRBd0w.B_QRX5x.VZqJPpAR_SgZ5rM34n9cPNTtQ
 uaOzHr6RoAQAxFMCyaS4igHBdMvQ48SzfGC47f0ba4twWMQ76A0QkafMi5oC.MEGj74toY2msKGW
 a26Wk4r5n5iPRNpslYOlNc_eGupC833o1.SHtMo.SCuCXrosI4FlU.tnEu1AL09DcwdkY8PwTN3E
 ahKaSu5KfgRcYqL_DcESKsbbU7Q92KoxW6u4PEicF85.XqcT3t1cfBTwKXqvykGu.Jb1IGavXZIb
 wVU4f3MRwXngx8JF27v6pum_mM4zuY0uTbYIZ1OR15OJc06yBA8axSYbvqQJGZ5w7SrrKNL7JeCU
 uFVZdBRdn1gFIM4mFNwV5T26eJoi_MNyR55zDz_yf1M9qSCXgbSdJLcVL2IuNd_LJMpE15Mz5occ
 DYq.7kYHAfwrdSPw3FgMEBGzdpouhSmB.lv0C.9Ln17E_ShK7aDYKPS6SOwAPQByphXaNCnSkjaU
 ww.DD8GE.yaVMiGsZxMdy4f5wacJywPKs4Bw3ymhgNWDGaVOlu0fT3ebL6lqkVqPqRkRt7Z3efa2
 bSFXjxQx7Q2Tv
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:47:59 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp422.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9312487679b1d62a89b866e0f3ee025b;
          Fri, 19 Apr 2019 00:47:57 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 42/90] LSM: Use lsm_context in dentry_init_security hooks
Date:   Thu, 18 Apr 2019 17:45:29 -0700
Message-Id: <20190419004617.64627-43-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Casey Schaufler <cschaufler@schaufler-ca.com>

Convert SELinux to use the lsm_context structure
instead of a context/secid pair. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h |  7 +++----
 security/security.c       | 10 ++++++++--
 security/selinux/hooks.c  |  8 ++++----
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 3344d18ba9d0..f60ec98596c8 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -166,8 +166,7 @@
  *	@dentry dentry to use in calculating the context.
  *	@mode mode used to determine resource type.
  *	@name name of the last path component used to create file
- *	@ctx pointer to place the pointer to the resulting context in.
- *	@ctxlen point to place the length of the resulting context.
+ *	@cp pointer to place the pointer to the resulting context in.
  * @dentry_create_files_as:
  *	Compute a context for a dentry as the inode is not yet available
  *	and set that context in passed in creds so that new files are
@@ -1500,8 +1499,8 @@ union security_list_options {
 	int (*sb_add_mnt_opt)(const char *option, const char *val, int len,
 			      void **mnt_opts);
 	int (*dentry_init_security)(struct dentry *dentry, int mode,
-					const struct qstr *name, void **ctx,
-					u32 *ctxlen);
+					const struct qstr *name,
+					struct lsm_context *cp);
 	int (*dentry_create_files_as)(struct dentry *dentry, int mode,
 					struct qstr *name,
 					const struct cred *old,
diff --git a/security/security.c b/security/security.c
index 5ee80bef9643..fa0500b2c15f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1017,8 +1017,14 @@ int security_dentry_init_security(struct dentry *dentry, int mode,
 					const struct qstr *name, void **ctx,
 					u32 *ctxlen)
 {
-	return call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode,
-				name, ctx, ctxlen);
+	struct lsm_context lc = { .context = NULL, .len = 0, };
+	int rc;
+
+	rc = call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode,
+				name, &lc);
+	*ctx = (void *)lc.context;
+	*ctxlen = lc.len;
+	return rc;
 }
 EXPORT_SYMBOL(security_dentry_init_security);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 633d62b97e90..fe09905d013c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2813,8 +2813,8 @@ static void selinux_inode_free_security(struct inode *inode)
 }
 
 static int selinux_dentry_init_security(struct dentry *dentry, int mode,
-					const struct qstr *name, void **ctx,
-					u32 *ctxlen)
+					const struct qstr *name,
+					struct lsm_context *cp)
 {
 	u32 newsid;
 	int rc;
@@ -2826,8 +2826,8 @@ static int selinux_dentry_init_security(struct dentry *dentry, int mode,
 	if (rc)
 		return rc;
 
-	return security_sid_to_context(&selinux_state, newsid, (char **)ctx,
-				       ctxlen);
+	return security_sid_to_context(&selinux_state, newsid, &cp->context,
+				       &cp->len);
 }
 
 static int selinux_dentry_create_files_as(struct dentry *dentry, int mode,
-- 
2.19.1

