Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFD0C4360F
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1ED2184A
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="AfiPWjvJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbfB1WUU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:20 -0500
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:46844
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730732AbfB1WUR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392416; bh=XVFOpLqVAefZlOLGmccNrc4yiTQy07t3uJyxjT5+V8g=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=AfiPWjvJcwoMo+tKY8zO+4h4lDXJESBuP5Hp5oZ+TQ5OW9jhLoO4Qbu3Dbx8JqKJS1+Ne5u8H+Zhnb5RtPFuXUrrZOvSqsG/LpmIz5NCUBa8l+QPjXZAXbB0PV8qhZV+EC019GYk0mDBH5O6N1y6Cga7w3zRthkLA5BNbcGcShyCMPJHbP3xv7dR4777aVgNpDNQ87bN2ebM8m/nJGVRRtzQAzVZEJ36evFZgMg+GMU/AQ64v9NAOmxuGcvwyCmBdRHDlHtnztFJHy2fw3AGwWC/TvW7JdjT/BcAJtlwfquWr2fIz5eTF+lhSWLDzcjtHi+PebFUMcZm521FY38uFA==
X-YMail-OSG: tRiM2OkVM1kjcuKs4zEzYvZORS8z_UKITlP2C.Z9pfNPrAqYuaykFz2wHmOrSzo
 9bx9Iyu1LWpfm5A6Dhd9ULcIbVN9tpIJsKzEyunF.ssJPJLKi7FMMmHpUhHjOJNWPu2J5_Ay.idG
 XVSPzAKF7WVh1lyTomAdMuL9Tlfa_zBcpP5qf8nc1GTrlaDDOEPcSV3OBiG_MGXL.hMNooelAyTi
 JhMIBlpBKF5Jaqtcr3IES8KSOVTbhQg5Z0fwKYE7kOS7UBC8mhG3BD8T_lgkAzi0UJyo05lsbfRL
 fwADiYiyQcsrX8DDiAHaUvuCjWwhn4uZ5W0seyfhziHpAiiiCdKNiPAlcvDUEN.ZBL_NISBNteij
 VkggKqEU1PFuJ.k.MJAC9M5hRaer7BzvnK8y74tjn_q342jzEX7s6wcLWoTpaLaPpfusG2olA6kR
 XxxCYYjGfD8GZU21YfDhSYUvEmYvRXyXVdEjkyoZmZ6GN.VGDQrUmdHwBVodNc1IkXKypFC7gf01
 8W8ie45PEEivvAxMLlfi_HbBlYcKfQS311uGvryAeyLUksUYnmIV_lrCwhQc4NgO78GhMRVImR.m
 Jz1PRiplnUd6pND2q57hsnvnXZQW6coYxmv90kcsXqzBjMOrLm1CjDDt6zReM..PTOCPJfywD.RO
 Ii_5MpBr_R23VtvKd8VqJbms3FcWAq9tjwehX42zcUh5wf9TGUUHsKRclCowvCA32uB8mX2WL3a5
 g84QzpnvLSSo6U61DeVtnH3z_AVJkdvvCXjTf774wdrDOmwluyDO2P6YXJFyujl73kzdZbRk.znU
 EjkEgNcC5Nosx1ovlzlrOJsOSo_jkYhsSA53OMgbZAm16bZUY4SbOji_CzNytVUqdvEvXZpc08va
 fRcYLBlhBIVeEHcPTnlJ7Kk.lWy3CPDngr3AuGPmIUFtdi.ZQKMaYRpD5Ex6DJUgAQ2Ilz1Jdgnt
 ITPmEfdPiZGhRSqqlE9GSY.m2QmsGZFuKvF9nvvNt.MF7ctlBJBf84dj4ORblA9mDOELXrpfywHO
 7cGAA6NDbjEbw7vENXnIOfEaozW_T4lF03mR_6ScNVwhqai.u9a.SNa6RgTNPhGClqvwYFhGzjmD
 2xPpHDixekk_9VmsZBxM739Lvtyuf0734rgS4XtI9bql_rcU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:16 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp430.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e588ca5e0935b1286f019b02cb065c6f;
          Thu, 28 Feb 2019 22:20:13 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 49/97] LSM: Use lsm_context in security_dentry_init_security
Date:   Thu, 28 Feb 2019 14:18:45 -0800
Message-Id: <20190228221933.2551-50-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Casey Schaufler <cschaufler@schaufler-ca.com>

Convert security_dentry_init_security to use the lsm_context structure
instead of a context/secid pair. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/nfs/nfs4proc.c        |  5 ++++-
 include/linux/security.h |  7 +++----
 security/security.c      | 14 ++++----------
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 557a5d636183..f56963c995b0 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -113,6 +113,7 @@ static inline struct nfs4_label *
 nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
 	struct iattr *sattr, struct nfs4_label *label)
 {
+	struct lsm_context lc; /* Scaffolding -Casey */
 	int err;
 
 	if (label == NULL)
@@ -122,7 +123,9 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
 		return NULL;
 
 	err = security_dentry_init_security(dentry, sattr->ia_mode,
-				&dentry->d_name, (void **)&label->label, &label->len);
+					    &dentry->d_name, &lc);
+	label->label = lc.context;
+	label->len = lc.len;
 	if (err == 0)
 		return label;
 
diff --git a/include/linux/security.h b/include/linux/security.h
index b60152334d9f..7940a92e8b5c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -299,8 +299,8 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
 int security_add_mnt_opt(const char *option, const char *val,
 				int len, void **mnt_opts);
 int security_dentry_init_security(struct dentry *dentry, int mode,
-					const struct qstr *name, void **ctx,
-					u32 *ctxlen);
+					const struct qstr *name,
+					struct lsm_context *cp);
 int security_dentry_create_files_as(struct dentry *dentry, int mode,
 					struct qstr *name,
 					const struct cred *old,
@@ -660,8 +660,7 @@ static inline void security_inode_free(struct inode *inode)
 static inline int security_dentry_init_security(struct dentry *dentry,
 						 int mode,
 						 const struct qstr *name,
-						 void **ctx,
-						 u32 *ctxlen)
+						 struct lsm_context *cp)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/security.c b/security/security.c
index bacfb690392e..a821e0558370 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1015,17 +1015,11 @@ void security_inode_free(struct inode *inode)
 }
 
 int security_dentry_init_security(struct dentry *dentry, int mode,
-					const struct qstr *name, void **ctx,
-					u32 *ctxlen)
+					const struct qstr *name,
+					struct lsm_context *cp)
 {
-	struct lsm_context lc = { .context = NULL, .len = 0, };
-	int rc;
-
-	rc = call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode,
-				name, &lc);
-	*ctx = (void *)lc.context;
-	*ctxlen = lc.len;
-	return rc;
+	return call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode,
+			     name, cp);
 }
 EXPORT_SYMBOL(security_dentry_init_security);
 
-- 
2.17.0

