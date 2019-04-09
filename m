Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3205C10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E2A2082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="uJwVJeaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfDIVlG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:41:06 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:46441
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726937AbfDIVlG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846063; bh=ZMFPRX5fTeMRBlSYOW6teWpgOAJGelAiTDnV//rgRYQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=uJwVJeaWW3MBe3/9VFWaJX3tP08C+nu1ywRy2SNVRiNNgebBZwUzkOvBdHn3ecLXgiuRBGpyImLVkSokjTkdG7RNpKVtO9gxAdlbN43Djl9J6mb1FnAoW34kTpUvb2Z5Rn0tmKiRMYCTHwYfOrX50Dk8xAq7zseXqChjyYTBserdDcJBh6sjYtF3pAQhblpLIi8ts5WLz80KQ2BCSS6ze4z12VZx6DIDMMbNP+LaJa/gJYTSYMDQ0QUQ/YrWSezAtI1R58Bvr6gZZ+YkrGsR95Lp1Sb4KTkRwqF9F4+UJDefflcggkb/zE1le4dcO00lPn72Fm9JyPGKxk6a+a8akA==
X-YMail-OSG: gtynvHgVM1m9oV6WpVcXHMRafEz3qHBAR8LNcamRS6ErGOIIddi4AIRODxBIs6Y
 hkY4GOOHD3nreFoc8qwSqSvd1pz4pZZ_ASDPQxexKpGbd5K4cEvx_wmCusxNdI5NJqrlkAS892qJ
 6mwyS3UbHP3yaz_OdGr1rwP79ay1BZGMHvWLroUxVyQLIm4lu2.lh_oyagDRYjhP0XDiOMWosjn8
 YsDvXXlOcESqUU5FdTLlBAyzOYQsLZuglLbxKU6O43eNrzirAmSv7vd52KlFpmndZpnNrYGPI.ci
 vFbzP0QF0Vi9IXy6JKb2I1qPBQ3FrDLeNWWEt5BWn8GS7oD.c2BRfK3XjGJl_pY8KlyphFqX4DRJ
 Vn8okiKgDQSL2z8R3wHbZVi9Q6g42LbMcM.itAE5YIlr_lDQ5UqJH8sHnCvf6OPvVufhT.PWL5Ko
 F6L_pM3wLDhFIUHyjzb42Jxh3_yO.3ZQzfTa4O36QRWonL5vX6cVhErxwOSK6ck9HQKYgZtaXUAs
 FCm48oNNva0dwZpHDgiHvL6S_6WB1zDaEkME0IziHjSqNEKwA2ukDY9yeVksXUPrQ1QAU__YA7tk
 YrSgvmBCEMoorAZjT9DVpIKwdy2h7iyCH_DprwHckHtbXjidBo4R7vx3VJXs8SQ6O1nLVXyPjHmu
 bcjybbp.He1aLKVMsbkg.Py8p_84B5l5DlV8ERpvSz7ByrfvLBLBOL9FM8U2j8jEEW_bXQ29T5W4
 KmkepmUhVvxwmNNntcxvn55kaWswjMXVHHbLZnEdKKssx5Z0eCwYgeh9qbTYPWzQ_pWRq2ulRlCC
 bGhrIpGrsrOiRekqzrWxfijkrlN_mfdttUTmGKIF293ym7gkBzcNea8pDaQBvSHW8Pri9ow.Tgw5
 EuD0lf9YnjicpnMYU8gg5HYOeudV97vof.ruL3xHR0_hUj1KdokVdlorACJ3Z6.xz2z.QQe5yI8o
 cDcmFe5tsz7OqKod6EooX3.wZjjrNGdGn6OmFTHT1SzGxvsnBrL1wpyjsksWVz.p1cKVoBgW56qt
 gmXE1KZOKRj5uZmmrAwOoVSfDfQZTh_G6oJ6ITgRuQg8NneLrRellIsjAnW7PM.OswytoeDPXC5g
 jqefsv_IXzY7TAh5y8UamB0cUQ4BYu4a86BsSjHRJ5y139Wk0vXp7SaVHXrJbUw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:41:03 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp403.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0d1cdfa4e40e9d37a3e144929c04344d;
          Tue, 09 Apr 2019 21:41:00 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 40/59] LSM: Use lsm_context in inode_getsecctx hooks
Date:   Tue,  9 Apr 2019 14:39:27 -0700
Message-Id: <20190409213946.1667-41-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
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

