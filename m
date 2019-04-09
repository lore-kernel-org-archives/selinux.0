Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576BCC282CE
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258C22084B
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="IZAtHKmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfDITTY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:19:24 -0400
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:36993
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726890AbfDITTY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837563; bh=ZMFPRX5fTeMRBlSYOW6teWpgOAJGelAiTDnV//rgRYQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=IZAtHKmJCR211IURSWJTftmNB+Z3/wqP94pNzC8F9KyXB13Q6vSWxfRjluCI17CD8Lcd51ZblFscyt7uZF5TKoYoOCGEEDYcxsrl/Ed/JWnKurTASLcvQ42rrXq+wEStPBRw+3Qeli6eFG+MNF3mfYKKIUBLGn+I/OUEqWPQBLqzZEnsH9wwsVbH/mJoztqOae79GoQiux5p8Sv4mu8WQuKgQ6EYCg9iiMc2FnN8wl2RuWvPgqo1Q+9+uXulzE0u5FpKQ+5SYVj9WAWVAs48J4QaHnS3TcMUkgsDxCUhImzxv7idvhcAqH9qJ+CBqmTjgOPtaZcEKDhVPttn/c15Pg==
X-YMail-OSG: eDJoUtQVM1kjlf9AQg0s6N07G_jfJ9g_xXHayqwvU4aURdTpPxiF25QXuo48ETZ
 G.a8QScezoUuq1adZaJaka7jjpFaVSSNgKjZGA8QZ6jby6py.B.w8tPkGbvFcfTgYG3WaAPPtRaV
 dx3RbGwEP8EzxBAe2GSWzsq4wIVLjKNssWSpvnQ5vxcpgFVZ_e3PKLPhsZs_BmAkcMFz8EN.aI3n
 EIxGv5AD9jyDjr2.wSGd4Q9kLf2CHNmsiBA_Ouoc8WpWjEL4HHlkwv8BUiizxApCpMwccM_xAMZO
 eW8p5NCyILE0imRB_0.IDxVvNfvGHmdJWyNDIW0wxrfoUQJd62kjWc3ketnk5sIYQIaJX5FARhbg
 lP89W22nTI003EHTLEwxS2YJEAhnray44xRdbR55NmKP0agTjmDnAUDkNbgtn_htp_rgHjTMwRZ6
 m1OttXEYuZ5vVGhNE28ULXbFu.fCEi._6isef5nl9T5vWeDCRbv3C09_tcrlDSM12Q4XQdThkmBK
 NUhKGctdJiZUcPcMuaOTCXlsWn7PlayVQBhZdhkF6YSO01b4nEjGv8E156ayuyGHjdPtTQg5kyGg
 .11YL1gDTB0TEZFbz8h3wZe6vkkDjy3ME0JeJa7YsNBBwUTNA7X9Hoa9F3F5q2wuZe5irskY5mim
 qu4WqcFlKrkuw_VOPi2iNXzZnJt51pE9M4m0aKNMN3FLliWZyzN6HwQFEZFS8Cm5dlpw9fC.AUtH
 ajEf78MLBTqZDB7cvOtFUm7rNCQ95BxTebectSwcRYegSCYSjhoWuHjrhlN6QyjWxbzFaRjHLwEo
 XRQHkjEkHcnpUgLnZYknYzBFiKdeKPa48qQKKN7CMeyw8kgkfNZMBIxRXnvh51_mbEZmGzYLQ3G_
 Xi64b.A82BA4tKY9v.NvWplatZECPXCej4qyGQ5XTpni6WBnZz9HmW1b7uOsIvK99FDe0.2Lui1_
 sbrtP56YUvvikXss_u4DOcmHmND8C1vmS2GuWnPu4balaSw3MueCr16pvErq1alLtRS6iR1Js0zZ
 e3dGw4VpTC2cvXfz3yDugm.OGQL0yDVdjZLomDm_7kEhY3mLM.FO3zz_MfVvK1Bd5CePyWHxPfeL
 2s.Bpn6N8hZQS4Kkf_I3K5lXJFPxoPfIDdmaJpZaWFhUAguxy0stSW3zys7rD
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:19:23 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 92df6dee4d3144b341710b3f28d23ef8;
          Tue, 09 Apr 2019 19:19:22 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 40/59] LSM: Use lsm_context in inode_getsecctx hooks
Date:   Tue,  9 Apr 2019 12:18:29 -0700
Message-Id: <20190409191848.1380-41-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409191848.1380-1-casey@schaufler-ca.com>
References: <20190409191848.1380-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert SELinux and Smack to use the lsm_context structure
instead of a context/secid pair. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  | 7 +++----
 security/security.c        | 9 ++++++++-
 security/selinux/hooks.c   | 6 +++---
 security/smack/smack_lsm.c | 6 +++---
 4 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 8b842fd13fb4..34ed56be82b8 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1401,12 +1401,11 @@
  *	@ctxlen contains the length of @ctx.
  *
  * @inode_getsecctx:
- *	On success, returns 0 and fills out @ctx and @ctxlen with the security
+ *	On success, returns 0 and fills out @cp with the security
  *	context for the given @inode.
  *
  *	@inode we wish to get the security context of.
- *	@ctx is a pointer in which to place the allocated security context.
- *	@ctxlen points to the place to put the length of @ctx.
+ *	@cp is a pointer in which to place the allocated security context.
  *
  * Security hooks for using the eBPF maps and programs functionalities through
  * eBPF syscalls.
@@ -1679,7 +1678,7 @@ union security_list_options {
 	void (*inode_invalidate_secctx)(struct inode *inode);
 	int (*inode_notifysecctx)(struct inode *inode, void *ctx, u32 ctxlen);
 	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen);
-	int (*inode_getsecctx)(struct inode *inode, void **ctx, u32 *ctxlen);
+	int (*inode_getsecctx)(struct inode *inode, struct lsm_context *cp);
 
 #ifdef CONFIG_SECURITY_NETWORK
 	int (*unix_stream_connect)(struct sock *sock, struct sock *other,
diff --git a/security/security.c b/security/security.c
index f3788840019a..4625a9b00d1d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2040,7 +2040,14 @@ EXPORT_SYMBOL(security_inode_setsecctx);
 
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
 {
-	return call_int_hook(inode_getsecctx, -EOPNOTSUPP, inode, ctx, ctxlen);
+	struct lsm_context lc = { .context = NULL, .len = 0, };
+	int rc;
+
+	rc = call_int_hook(inode_getsecctx, -EOPNOTSUPP, inode, &lc);
+
+	*ctx = (void *)lc.context;
+	*ctxlen = lc.len;
+	return rc;
 }
 EXPORT_SYMBOL(security_inode_getsecctx);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a2257ccaee5c..e881f42d3ff8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6355,14 +6355,14 @@ static int selinux_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 	return __vfs_setxattr_noperm(dentry, XATTR_NAME_SELINUX, ctx, ctxlen, 0);
 }
 
-static int selinux_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
+static int selinux_inode_getsecctx(struct inode *inode, struct lsm_context *cp)
 {
 	int len = 0;
 	len = selinux_inode_getsecurity(inode, XATTR_SELINUX_SUFFIX,
-						ctx, true);
+						(void **)&cp->context, true);
 	if (len < 0)
 		return len;
-	*ctxlen = len;
+	cp->len = len;
 	return 0;
 }
 #ifdef CONFIG_KEYS
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 78c01ef707eb..46eead699e1d 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4484,12 +4484,12 @@ static int smack_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 	return __vfs_setxattr_noperm(dentry, XATTR_NAME_SMACK, ctx, ctxlen, 0);
 }
 
-static int smack_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
+static int smack_inode_getsecctx(struct inode *inode, struct lsm_context *cp)
 {
 	struct smack_known *skp = smk_of_inode(inode);
 
-	*ctx = skp->smk_known;
-	*ctxlen = strlen(skp->smk_known);
+	cp->context = skp->smk_known;
+	cp->len = strlen(skp->smk_known);
 	return 0;
 }
 
-- 
2.19.1

