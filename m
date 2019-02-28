Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7FFC10F00
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9AFC20851
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Ar1orKcz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730698AbfB1WUU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:20 -0500
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:43238
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730892AbfB1WUR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392416; bh=+ZC0413d4ELtG59P/A2XiAmWA5XGQXEoI8H0mOHofco=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Ar1orKcz+MhWk0rQC03esnY7yzxZ9phGzAFjqmsw9eaEDlnUU+07HG1xagPms4DV/mY2MkOsyx2wTcJ7RnVNjCchBhPlH9IiHjjD6gPk0bd/KQnPASomuiHgoJl/pnd/N/FC7nDTIzbTY4yZl89suyMLuPq3ctwz/NPpIyTGq+m0U+9xZk8yhm5d+tEmqjYzdzPn8I39HhjA96oJd59E5CAVPDofTUEiR02W/9dNCU46G2BgRJ1wOQmxY8XIPoFdtMmKu3+eifQD1chB2/wxRRRqDSstlUQ/rGIxNC19iU9YwvBvEDnBmDyVP2NkNz4mtt+suLjFDW6/xrKI6AWANA==
X-YMail-OSG: 4aL33zMVM1npadfWcZrzBWDc59NRQwuOlMO3ujCCiQlpkPJNQ41dwbwO96s4a_X
 uPv8S7Wn1odvBK0jbYECs8_rkrdFnffW7dZeswHRMHDZeZn7q45etMj5o5gp5TQUjLfH8xLEpzTn
 7BVH0phxcmHfqz3kwi8M5Ssu0xKBAb9dKnltRLEkE3zbAQcQp6td6oiTzapa.9BXbascBWP48fff
 J7fOr8BuOPoVMWYXnncx9EccXjIhWY5d0aMzuCZ4plBpFRQlH1UDKyUKGnhWmJNGgjE6_NiEaJCl
 HWiQvRA5UygX3eR9IHxUbrxoQVoAIWIy8U7NTj1_7fBvoiWcBlW5M1_fN1YWrONUfs9xG.W8Nood
 OH.ek3.qBId4XRqwCrEoDKpAaWpAoHEHvxTgdV3h7sAr8nUIUC3ECp8CBsaHmPj89z.Rq3IudHE7
 3ovuvd.4tTkvjkEmJMKjbrmGHo.lDinqo6wNoulBHtvN81xTqLoQ6avZy0vZLRnndGo74XbtZjZ7
 GpJWqjP_ZqdYQEzpiTTJ58zgoIRd6tOcLmgZwZfhjo5Yv1RbZnrjCDLPRuiGcEsZvJTBz51nofxo
 MEhMuBley80Wg.BP_ijlGd1zStoY510mLlyMlBmIkHK8m3lkUBRazIo8VUTfcIcvgrI8RgL.bojq
 gi9MHAt.FHA60o0RaMboNBIPUb12dMyEU4w8DzX6cIjeAkTJrbbuzNMG.exv_vxYbm7GuVYF9SMJ
 a34emVXr6.3RKGBvk2CaoIFDOjrqoriQVJOQB2DLhYrIuHySd7KOrfnJ.1kZ6ql9VoKUqOc9Clz2
 eotKMriJnOsEwPKBMLU4ykZLRDNXZg1qQqWZM.Ftu6dq1MfH9sQClfJu0JCHE.a1stfbWOnpqomQ
 MdRu58e0E9U2ul27HYaADX5UPb7__Y3yW6nEia29MHplUdUSbzKBDGEQoy4quo9F5161W5Zy2xvP
 mxqVd9cgP47jMxTCaIMjYlCJ.vgl1dIkYU__V.yhkAvfGkhrjuX2D_eUwf8I.iECJ5bDK.0HR_5H
 xMfGh0fmIEmfUVL5reFc5Z5BOC3htiJDoLj6EIu0GxWwZLX7DwzeUwN6Grnhch43w1hZ6THFFOVN
 HfAVZ2iyh9eyT2sw47hFQ1UJDHLTs1iGKVv9GmwS6XeofWi22
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:16 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp430.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e588ca5e0935b1286f019b02cb065c6f;
          Thu, 28 Feb 2019 22:20:11 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 46/97] LSM: Use lsm_context in inode_getsecctx hooks
Date:   Thu, 28 Feb 2019 14:18:42 -0800
Message-Id: <20190228221933.2551-47-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
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
index bb748b0a045b..713378bdd69a 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1386,12 +1386,11 @@
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
@@ -1661,7 +1660,7 @@ union security_list_options {
 	void (*inode_invalidate_secctx)(struct inode *inode);
 	int (*inode_notifysecctx)(struct inode *inode, void *ctx, u32 ctxlen);
 	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen);
-	int (*inode_getsecctx)(struct inode *inode, void **ctx, u32 *ctxlen);
+	int (*inode_getsecctx)(struct inode *inode, struct lsm_context *cp);
 
 #ifdef CONFIG_SECURITY_NETWORK
 	int (*unix_stream_connect)(struct sock *sock, struct sock *other,
diff --git a/security/security.c b/security/security.c
index fa94f012a7ab..b2aa50a583c7 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2026,7 +2026,14 @@ EXPORT_SYMBOL(security_inode_setsecctx);
 
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
index 00b47c01960b..a67b8a3e6b9c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6245,14 +6245,14 @@ static int selinux_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
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
index a5108215ed49..b3d4410696a6 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4399,12 +4399,12 @@ static int smack_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
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
2.17.0

