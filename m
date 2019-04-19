Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB35BC282DF
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A770421736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="EKYe0M1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfDSAsZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:48:25 -0400
Received: from sonic317-33.consmr.mail.bf2.yahoo.com ([74.6.129.88]:46157 "EHLO
        sonic317-33.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726906AbfDSAsZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634903; bh=d2rFad6uz38tqOOEQ2L2mVhN9yxg3v+SnsOxi83s/3Y=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=EKYe0M1Byoo+toa8ZM9wgM+aUMFdd47LnQ6sV9vob7s3UhQOg8taSskvHUiv8/MbTEHhyeyplxL4rg06yuM9mglt+HJgdtrlNv1ouzsizA2rJRWUN5jbI5BpeuwnUY1MSf24t7K42mLSAuycsD/7CCMUSZ/5nlfg3eD/CNohYabw4Sb29g6IAqRLp0rTG354NZvVtoZ+BZpiij529U+gKpd9Mg3u/tZSvdYNm20D2VhirAVBM3f3yq01Q01kRDtqjiR9wjX7avfwDfF4Wm/0CQvyssmvFIVnEHFArjxBFXM0/2HkgKpELb+3E/IuBmoj7LxL+Ul/uSPvZdob0oNZ1g==
X-YMail-OSG: CiU0OywVM1n6w9O6NaHL5FAqbsypNCuUtrQVDoV2Tf8O2_qXnCd1fmJ55U3ERxW
 1DOkFXfBWiQx7FTdILzt3sG4Ou_4OFaWRBoDXUZmlbzwVO02miHRgeH33nJfja5tzrJZhQPU46v5
 EyJBoU6HppJnE8cpLE7CEGNyQ5HG3j5xJJaX2zTXaEffLgeCI9CH_L0RG3W7gjassI5JfgQErBHz
 zccCqJCTAuro0viZZ4Tws1PSN4zODQKg8L4t8HaAPMG34Ly.jJnHSSwL5UfowPpZd5A5iIzM5xws
 q1yAXEnmHv8BEHYMJN7GzDwzZeKDWealqPWLuICWic2hRz_WgZuTfT1X4jdEV9cYcD7Vw19hZBeq
 cqvxGqrRbI_db_VelicA6_giu9hHxvVOai5LBbdE3ILT8o00lbQ6L_p163TLElAWugZYP1WmcE6j
 QQg4YNg2KZCcAV54aC6cX_A8aLwYzA9C2PD3ijtJggRus8VC4ScMrSmkc2nfYbhQn4pBUTMd74L7
 TCTwT1ZwCKI3lDDFhIUWMamwvTf21h9P_O_iT7W.sfSq6FOGCNcyLRWxpsEDXgxgqbPadEDIQS6o
 igQl05Bgg0ld6VF0BNGHIREn_xu2r19sjOx9U1HkdoX_1FJrdJG76pwRoxnT6LjUl8K120pxKhQg
 OUZi4aAv44FE.stgz.SEQuyaieiy0jhQdbjutZ5DbOtL6wR8GKsFa2vcV03qM3AIDa.7Q2CpAmev
 BSnMKD7fE3pK1qiQB_bs8ybPlO_HSngztGOFhixcXvLM2XjInDxNjx4JPr8UkCgJdBobRN.T_b4b
 nyYTKDTF9eKOAvEM4Nq.vtrTalCo_xMvWvTbyeWFKZ5gGccF1kApD34te0k2o1dgZlpVXQpokSfO
 erafOvmh5uM5pjjcurTc4IYsixUWeUmir3Pd_5lJGF8UuA2J2uW6oi_Wwo5ypH1_BMKIRX9F6e.q
 EQuWEalDo_AtuKvwsdPeVvLzgZqj57cRqGwSjpQyDNMaWum0OkAxwvWd7ibzVNRjADsD2emjKkRx
 95PNZwiAEb9L0sP3q9wmGRwznq2pK.kURrLsKG834lH00_NJks3PMU2lpPqHlVuMdnqeyJ6IKXnW
 GtCFQbuau6WwTnDB63JoBLAZb3Qsau.ufrnDnMsGewXzO1RHx0THCuU6sDSpMVcSN2inc3UMqRGO
 2znkFVG5lLYjb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:48:23 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp425.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 48f2b950f84a4435a371532cc5391b39;
          Fri, 19 Apr 2019 00:48:20 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 52/90] LSM: Use lsm_context in inode_setsecctx hooks
Date:   Thu, 18 Apr 2019 17:45:39 -0700
Message-Id: <20190419004617.64627-53-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert SELinux and Smack to use the lsm_context structure
instead of a context/secid pair. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  | 5 ++---
 security/security.c        | 6 +++++-
 security/selinux/hooks.c   | 6 ++++--
 security/smack/smack_lsm.c | 5 +++--
 4 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 1d364e211639..014791349bbd 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1390,8 +1390,7 @@
  *	Must be called with inode->i_mutex locked.
  *
  *	@dentry contains the inode we wish to set the security context of.
- *	@ctx contains the string which we wish to set in the inode.
- *	@ctxlen contains the length of @ctx.
+ *	@cp contains the string which we wish to set in the inode.
  *
  * @inode_getsecctx:
  *	On success, returns 0 and fills out @cp with the security
@@ -1669,7 +1668,7 @@ union security_list_options {
 
 	void (*inode_invalidate_secctx)(struct inode *inode);
 	int (*inode_notifysecctx)(struct inode *inode, struct lsm_context *cp);
-	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen);
+	int (*inode_setsecctx)(struct dentry *dentry, struct lsm_context *cp);
 	int (*inode_getsecctx)(struct inode *inode, struct lsm_context *cp);
 
 #ifdef CONFIG_SECURITY_NETWORK
diff --git a/security/security.c b/security/security.c
index c8ce190dcdda..9d09c774a1e9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2008,7 +2008,11 @@ EXPORT_SYMBOL(security_inode_notifysecctx);
 
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 {
-	return call_int_hook(inode_setsecctx, 0, dentry, ctx, ctxlen);
+	struct lsm_context lc;
+
+	lc.context = ctx;
+	lc.len = ctxlen;
+	return call_int_hook(inode_setsecctx, 0, dentry, &lc);
 }
 EXPORT_SYMBOL(security_inode_setsecctx);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0e347a26c3d8..af0d98f4dd37 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6356,9 +6356,11 @@ static int selinux_inode_notifysecctx(struct inode *inode,
 /*
  *	called with inode->i_mutex locked
  */
-static int selinux_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
+static int selinux_inode_setsecctx(struct dentry *dentry,
+				   struct lsm_context *cp)
 {
-	return __vfs_setxattr_noperm(dentry, XATTR_NAME_SELINUX, ctx, ctxlen, 0);
+	return __vfs_setxattr_noperm(dentry, XATTR_NAME_SELINUX, cp->context,
+				     cp->len, 0);
 }
 
 static int selinux_inode_getsecctx(struct inode *inode, struct lsm_context *cp)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index e00346799cdf..4570e8cac1b3 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4480,9 +4480,10 @@ static int smack_inode_notifysecctx(struct inode *inode, struct lsm_context *cp)
 				       cp->len, 0);
 }
 
-static int smack_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
+static int smack_inode_setsecctx(struct dentry *dentry, struct lsm_context *cp)
 {
-	return __vfs_setxattr_noperm(dentry, XATTR_NAME_SMACK, ctx, ctxlen, 0);
+	return __vfs_setxattr_noperm(dentry, XATTR_NAME_SMACK, cp->context,
+				     cp->len, 0);
 }
 
 static int smack_inode_getsecctx(struct inode *inode, struct lsm_context *cp)
-- 
2.19.1

