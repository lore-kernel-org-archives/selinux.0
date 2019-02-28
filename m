Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF2DC4360F
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A09920851
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="KjoWFm1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbfB1WUY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:24 -0500
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:41300
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730046AbfB1WUR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392415; bh=rVz/jD/0lGdOCPoY1Eyzu/ubGMwNwJfIW2d1l8+RcpQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=KjoWFm1NsSFT8tKxPqJo/WOt7zwT5kmqTS1MSz4GQQD1luiGJpTe444VkrVjrx7/F6H8VtkAb+WUpC8838QjpipZSthuSQToaIf+6+oQXtH8w5V56yzlAtsHbkRoWF1V3Cgf9AOtveD6381EzmMZnAznBabOnquaUGlWR25ix4pk555vLbyb/IRO+jaaI4O5+t+szN9OrPfDmt0U59iNB3ABCLV7Ckm1j1+rBG9f/zsTxLQtxrs1Def+OVTGIdN0Wi0V33OV5eI1H8tPqCs2WRsl4B1Cznwp9zd6uH+uNrjctPllPfJ0dlex9hYal7szoztZpImUiun+uvPGcrKNcQ==
X-YMail-OSG: CFg3pgsVM1lOrGh2l1rorJqHZFZm32HAnszLaf92rYoQoi4MwuTBVkKE4NFnBvT
 KHD7NAEZa8Q58NA_4zx6ks8CVJ248N0tSIaUaQBrD7Mb6ITCGu3Y8xc6cv9jK55tMAUF24aZaV.N
 9y8jbHQhcxtDhmacftfU5QJFGP3P0P1X_d.ChKl.e21HkHJDZE2xQ5KNU_DuZZktmgt_mGKVEyGS
 XUwoawE3dZhOXvUWRBDLFarV3p6nH2PfnkEswHuJxGi0kGrlAIib3WLyJHT1qH9ZwMmCGfrvaZ8y
 fpIxvAcaLo1cVuB7qEETeDhzyzWSIHU.jhIdS9Fgsz7j127D8bkkRfnkjaCg_kyLA7L8QGwd80WY
 OQJIfnfINrvtzKcyGW4IUGPq21EzSE3mvdK7C063IUubtzHiwyJtYyOQUeey0p1.d9yDgGZ_G3Wd
 5T.aUFB.Rvl8P5FmCi0_1ihf.ORI1ZkQGHIC05kBgW6K497mpOT.X5OVlK6TcqAQKBsiHyqnKmz6
 iXn_e_e6g25FcGhOGjnRiTY5tKJgaEdbn.6QC9uk4Ls0Ff4JM_CNf7q8j686HUAxgVrWYJw_cHJl
 unO7biJuMrhdI9DAxwJuJrvQANUBe0aJuT6jT1KDhkPbVs42.FQxWT1IJU3j_SJaPWNkHjM.rGEr
 ncs.lBGjs1fXh_cihFY5U0hBa2QMWLI7nEVkdl2idbAx7AkrkMlpeYNs9wm7a4Lai3hY_WKiIVNf
 FRIntsLQrFUlz8C.leQGYjWftubIPiq3.SAzywlidnjUc1_XFB_ZNJPpVZCvOoKStkpdWax6Zaj0
 C.opgQy53DnDs6oGClpuKPtBsGD1h1R5KgDt_CN6OoTE0xVwYEbbpM0hir7NmjI9htTbaRlFMkyj
 GkwYPLh8gdWK0KovXj.tAY3LyHFMwVkxe_mH5UgG9xUnbi9hiHT1gFfkvM3C93NjZPwAPHmpte2N
 hCjH6hPSJkJlEQDqB6ADQaeY98uaFNJ8R28UiSWyLTivQNsnardpH0AvxAS62lcT4KM2grLux6ST
 DCHhP2vU.Z8UafUxmJ1pGmTULJIazaigDMk7MwsXvu1eKzzpOXiJ8ouEgk5yjogx_07od6J33SYA
 gKOdbyMNrIcigoOvm7I17wfiXDUG05kPUnio2.5ZuxiloJp8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:15 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp430.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e588ca5e0935b1286f019b02cb065c6f;
          Thu, 28 Feb 2019 22:20:12 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 48/97] LSM: Use lsm_context in dentry_init_security hooks
Date:   Thu, 28 Feb 2019 14:18:44 -0800
Message-Id: <20190228221933.2551-49-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
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
index a7a68be7e507..29e52aedd6ac 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -150,8 +150,7 @@
  *	@dentry dentry to use in calculating the context.
  *	@mode mode used to determine resource type.
  *	@name name of the last path component used to create file
- *	@ctx pointer to place the pointer to the resulting context in.
- *	@ctxlen point to place the length of the resulting context.
+ *	@cp pointer to place the pointer to the resulting context in.
  * @dentry_create_files_as:
  *	Compute a context for a dentry as the inode is not yet available
  *	and set that context in passed in creds so that new files are
@@ -1482,8 +1481,8 @@ union security_list_options {
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
index a0c4ae7da840..bacfb690392e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1018,8 +1018,14 @@ int security_dentry_init_security(struct dentry *dentry, int mode,
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
index 33e58efe59ce..8b8eb5115d6d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2715,8 +2715,8 @@ static void selinux_inode_free_security(struct inode *inode)
 }
 
 static int selinux_dentry_init_security(struct dentry *dentry, int mode,
-					const struct qstr *name, void **ctx,
-					u32 *ctxlen)
+					const struct qstr *name,
+					struct lsm_context *cp)
 {
 	u32 newsid;
 	int rc;
@@ -2728,8 +2728,8 @@ static int selinux_dentry_init_security(struct dentry *dentry, int mode,
 	if (rc)
 		return rc;
 
-	return security_sid_to_context(&selinux_state, newsid, (char **)ctx,
-				       ctxlen);
+	return security_sid_to_context(&selinux_state, newsid, &cp->context,
+				       &cp->len);
 }
 
 static int selinux_dentry_create_files_as(struct dentry *dentry, int mode,
-- 
2.17.0

