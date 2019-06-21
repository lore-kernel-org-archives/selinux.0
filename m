Return-Path: <SRS0=kEwY=UU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8F3C48BE3
	for <selinux@archiver.kernel.org>; Fri, 21 Jun 2019 18:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52AE1208C3
	for <selinux@archiver.kernel.org>; Fri, 21 Jun 2019 18:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Gfv7hov7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfFUSxX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Jun 2019 14:53:23 -0400
Received: from sonic311-30.consmr.mail.gq1.yahoo.com ([98.137.65.211]:42643
        "EHLO sonic311-30.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726450AbfFUSxX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Jun 2019 14:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561143201; bh=sriHXN7UISAAZOK+KnM0B2H0KrQDbRsMBI5IvhJGWAg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Gfv7hov7up7k47h/uj3iD9qw9KtF8SjEzypmndvWpdfprcrNZaz+I0JPH+uAe6tn38uuYKhF+VDwqkdaSSt2ixRceuF52kcoDQdvNibe2KQ3sOrK9lUNEbdkezbG+KrYTvNsTNFMKhd8HiryhFQ5WDlDSYimTo5/UD5k0kkIQErERxGTyjkdpJuR+2/3z2zLIBT+fGiWOV9jWFl4+xAX0oUnSGFTzDOwBl1TzUCP7PFK3B6Lbteinw8UcneIT4Naz7+jjOlfNDhNHcFcWi9vN2366UtGNnGTGV7Fh1RW+uU2IiZZ9sanaWaOWjZnWLDa0/ESjkYK0ZMTskdQql/zUw==
X-YMail-OSG: nPr7lLkVM1k2wjKekZkwKb50QGlP.fj68d4tUQMWJIiZAQh_fjKvYXBQ8mpHUEc
 Oa1flx8MRPbTEB4O4DV5w3IiROIbFZ1qPw4xXfjhQ70MDXs7btgV832pJoTTBQovpUHjTsBsmf1E
 500.QkrgzlOb7E06JoX4taKQWgOrCZcS6wSAxqz4wvSjuCTUiDC9lICnGPaS6qw7vgzyML7UCfJn
 orSUMnESdnkaCemMesF_YPUIcJOpnlHcRkAVVTN6N75c1RNpQ1MfECa_wRzYV5bimrIoywydravy
 D7KeQ9v3S6MVRWAc9WGAtX2QqSFoqAfuBuzQrTQEsaqoDnjPR54QHAMNAC_549uzekg.1bhI3Q8j
 ON10WyARhGp5NvHWJfyR8JKqGZfmaRjQII0SPGsFGUjKYk22lcMHiVachsJoIrR2cLYjD6GL.cJf
 Xa5BOruwnO8RxVPglsHv5XM7x0n3r63so87i4y6GH5VcxT.8S8eHiPFi1JznvGm4yCTZptJK9ORS
 Puuca6R_irxfmDP8SMh6Ul8ppPa8NyqJ.N9Awm5HGe228JRDrtcQcuUe1hASNiT4FiCwjFeNkg2Z
 P274C92QjK0GscF13EihCEFH6MHIVBZqs2rjes93WFNgTdg2bOIabq0.pKQIGR_Zh_TKB8YE9BnG
 3OFcKjpzQ8BZB2VUZ0Kq2Egg3yhMIkFoYFU13QlYHmPZF4S3xjEk43tGGz6Ktof94feR5OJCO9rL
 cy4s3wR5Nan4vUF1BdhoyA3tzfDDE0GbbxVSPl00.BwZcP.KmY5xvgLmSLT9n8QLKIwuSX1JeP89
 zW.betrkNRFXVHGWrU7GK4imMXHjZCGOBCw3_BYpuHh0AAdP3U.6r4Xv6Z3o5BA7d_4vzYW9FA8p
 1AEvOpeE2FDjt11ZvUz9eSZmKkWWgqOBamoFDVTDYk8.HTosSLw_sfXXFRTHWxQyQRzqS1VLAVUV
 ht4JIp68RrKJSxBOvVkMdmr_1wvi3eVEDArK8M2jvIsuBHUMNd_kb5X2VNxic660HgTjVqm4QMwG
 HLwgkQr__jZEwQ5l6Sl_91VNI9QJtFmB1xCEn72LbUAxLNuSTQ7Zv8SdLtIqGK9Ddwf2Z9LAnwbw
 kXs3y18saSUoSg8oRAflX0zIuiQaZFlgcHDHMns1jC0So9gV_30LfITmc_qJK0lFmZDZOwcJdroU
 hTtXGphnIWoPWRYpaEVkbryw8er2z_OIDi25hd8lfTusct39VKMCPQcCU8Of3_WIdUHyY076qezN
 JKU.nypB06zcR.chKJG2abKy2ZaEyY.2b1LDK0dU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.gq1.yahoo.com with HTTP; Fri, 21 Jun 2019 18:53:21 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp428.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 1ed0fb368539bdd05266211e81f02718;
          Fri, 21 Jun 2019 18:53:17 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v3 18/24] LSM: Use lsmcontext in security_dentry_init_security
Date:   Fri, 21 Jun 2019 11:52:27 -0700
Message-Id: <20190621185233.6766-19-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621185233.6766-1-casey@schaufler-ca.com>
References: <20190621185233.6766-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the security_dentry_init_security() interface to
fill an lsmcontext structure instead of a void * data area
and a length. The lone caller of this interface is NFS4,
which may make copies of the data using its own mechanisms.
A rework of the nfs4 code to use the lsmcontext properly
is a significant project, so the coward's way out is taken,
and the lsmcontext data from security_dentry_init_security()
is copied, then released directly.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/nfs/nfs4proc.c        | 26 ++++++++++++++++----------
 include/linux/security.h |  7 +++----
 security/security.c      | 20 ++++++++++++++++----
 3 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index af1c0db29c39..952f805965bb 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -113,6 +113,7 @@ static inline struct nfs4_label *
 nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
 	struct iattr *sattr, struct nfs4_label *label)
 {
+	struct lsmcontext context;
 	int err;
 
 	if (label == NULL)
@@ -122,21 +123,26 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
 		return NULL;
 
 	err = security_dentry_init_security(dentry, sattr->ia_mode,
-				&dentry->d_name, (void **)&label->label, &label->len);
-	if (err == 0)
-		return label;
+					    &dentry->d_name, &context);
+
+	if (err)
+		return NULL;
+
+	label->label = kmemdup(context.context, context.len, GFP_KERNEL);
+	if (label->label == NULL)
+		label = NULL;
+	else
+		label->len = context.len;
+
+	security_release_secctx(&context);
+
+	return label;
 
-	return NULL;
 }
 static inline void
 nfs4_label_release_security(struct nfs4_label *label)
 {
-	struct lsmcontext scaff; /* scaffolding */
-
-	if (label) {
-		lsmcontext_init(&scaff, label->label, label->len, 0);
-		security_release_secctx(&scaff);
-	}
+	kfree(label->label);
 }
 static inline u32 *nfs4_bitmask(struct nfs_server *server, struct nfs4_label *label)
 {
diff --git a/include/linux/security.h b/include/linux/security.h
index 3cbe43db16f5..2a2785a4e752 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -348,8 +348,8 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
 int security_add_mnt_opt(const char *option, const char *val,
 				int len, void **mnt_opts);
 int security_dentry_init_security(struct dentry *dentry, int mode,
-					const struct qstr *name, void **ctx,
-					u32 *ctxlen);
+					const struct qstr *name,
+					struct lsmcontext *ctx);
 int security_dentry_create_files_as(struct dentry *dentry, int mode,
 					struct qstr *name,
 					const struct cred *old,
@@ -720,8 +720,7 @@ static inline void security_inode_free(struct inode *inode)
 static inline int security_dentry_init_security(struct dentry *dentry,
 						 int mode,
 						 const struct qstr *name,
-						 void **ctx,
-						 u32 *ctxlen)
+						 struct lsmcontext *ctx)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/security.c b/security/security.c
index f461ab3fb9c4..842ac65abc08 100644
--- a/security/security.c
+++ b/security/security.c
@@ -453,6 +453,8 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 		 * secid in the lsmblob structure.
 		 */
 		if (hooks[i].head == &security_hook_heads.audit_rule_match ||
+		    hooks[i].head ==
+			&security_hook_heads.dentry_init_security ||
 		    hooks[i].head == &security_hook_heads.kernel_act_as ||
 		    hooks[i].head ==
 			&security_hook_heads.socket_getpeersec_dgram ||
@@ -1040,11 +1042,21 @@ void security_inode_free(struct inode *inode)
 }
 
 int security_dentry_init_security(struct dentry *dentry, int mode,
-					const struct qstr *name, void **ctx,
-					u32 *ctxlen)
+				  const struct qstr *name,
+				  struct lsmcontext *cp)
 {
-	return call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode,
-				name, ctx, ctxlen);
+	int *display = current->security;
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.dentry_init_security,
+			     list)
+		if (*display == 0 || *display == hp->slot) {
+			cp->slot = hp->slot;
+			return hp->hook.dentry_init_security(dentry, mode,
+					name, (void **)&cp->context, &cp->len);
+		}
+
+	return -EOPNOTSUPP;
 }
 EXPORT_SYMBOL(security_dentry_init_security);
 
-- 
2.20.1

