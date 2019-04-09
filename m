Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291C7C10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E175220833
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="oGcZA3S0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfDIUAx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:00:53 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:36193
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726879AbfDIUAx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 16:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554840051; bh=ZMFPRX5fTeMRBlSYOW6teWpgOAJGelAiTDnV//rgRYQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=oGcZA3S0y+RSqGgx2qRvQjfg+zrCL55Bk9khpoimL+PB0sjdfh/UG9V56Wx3bhu3afjJpmaOqYPAWr1yDB8/ZxShWN+uNPtukzHTBNN8OHS50T8PIkoFAxIQdUsllMQEBWz20MCD7jyh3EOxHEE0mFZvV7uxtatCczHCxiXAsve3/56oY6R9eryqy167BpP6WDIph8HNGry6zFP5x4h9AeubEJwxbIIpZ7ROqT66X8MHfdFMoqNOICAsJFHlyBfrux6POVUoTfNpnJPTybM9GNCcYCjgEcvNZYnPsjQlrBj0HKci1JRubRBHgHfsO7QYoHC3HWoGOI8fuvf83+OiRQ==
X-YMail-OSG: Opv0rIsVM1k.s1P0VL9NCYtM2lTIjmTuXgbqBjryNeZYXroRg1Df3OZFxtWS9XZ
 MgKcA5eXDDAqYjUUQgTzluV6jUB8Di9_d2K61FUUNg_p_311MDgy1_tqI3dpmeUCBEa6_tCWHZB1
 iaYzvOSIKcczq0gBWk.zxBKUw66oVTbCMRpvpJiqNGIIWgiI1YsjEtzECME.yfod5GLF.HW28Yxe
 8YH3yJULIyYx60vf8yexIXD3Q7NgLpgOFAVeiGHUuz1mmG7SAwwk1mAiXiCFC.MV0D7c6LV1N.hx
 jRXEvJMZkjXTCvLnetDCsq7zETz4Ot7IAvEVT.bF.nf9KXIgOQyAs8N4CBOJX5XnUQhmL9QBuQjM
 VXL3S1PnwW7OCRm_6F8bv.m2eAq9a9AwH2HX4l4R5H4ybjH2lsyHzLdgUKNZ7BxdnmvYl6qgMHG0
 8PcA92P8_3fzGyfP_ecO5GAyBy6RMDzVskQwdJ5NhmrGPVgOsTcyBpGaDgucGw8ZeH_.PatKkMuy
 VFyyI5p6Z9TwH8Sf9X_9srgzNSTOOZcThqWzBsD7kPoCW3WAHPmrT0SMoT8odu4ccAqfoh07b43s
 Id9DUT8nJfXF6D3Y5ChfXyhBftbawbxe6ucn6EmToGOV5eEu_G8tCruqkMdLO_inqz4Ck8wW8.Pg
 MajqrsrM_z55kDL6Ptpd2qZLgP736H0CcM.iDEY.UE8OkDwb58BtdmBYRlmDuyv_xhaWrn9.HYJB
 kjosHgtSSDSWgC4wwjnfpp9h9H4kSAM7on23vD_XhCFbE2O7JfSAy.ZBmLyB4LlzqRkqrDmGw1vP
 sm.DNndpmeHKZrPl6g.t3yAmIrkyUNWXkzrrIrsEFN2ea12vE.nEeH1lrQ5sLuw4cU77JPCr9K7L
 WrR6qDxl9Mr4HyCiKhDOTofPuzwf9fgp2v0uBamBsSF9MKayBPl2aGMwmdSW.oN5S9DcvpxO6ZMd
 aJ5E3BimNDdEg9KncZxi0YpdAU_BZ11DCuMXsHcaDalmdI1fDewYxaDi06JzGgVFOF0G0aZRzZYq
 CNiEF4vc7VyKqLUS7Lz21.KRUe55KIjxkcFxFfjtnByKYDgLaxgJSMG6i8vFHnIsunN_UuTokPar
 krl6.SNyLaLJSGttjx64DUTOWPCtpBuNJmIAJD6f.g3OmBdnDiSj_kg57R.0-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 20:00:51 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp420.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 096ef3b711e934e464d4464cbf2d5b53;
          Tue, 09 Apr 2019 20:00:46 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 40/59] LSM: Use lsm_context in inode_getsecctx hooks
Date:   Tue,  9 Apr 2019 12:59:05 -0700
Message-Id: <20190409195924.1509-41-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409195924.1509-1-casey@schaufler-ca.com>
References: <20190409195924.1509-1-casey@schaufler-ca.com>
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

