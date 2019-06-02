Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC284C282DC
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22892794D
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="aMpTOcLi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfFBQxa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:53:30 -0400
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:42202
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727030AbfFBQxa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494409; bh=zNmMomX7FtNuYn5Qpm3pclNFmgRY9BLATnDH4/IPw8o=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=aMpTOcLiL6ujpI5QGhUlcxkom4UoLJED/eCIlYT2G7c4q0Regke0VNaH9ksRDfZrjbd5y52824/3m1oFc/xPvGoVxSz8/IdDAqSSG1/V3xzLuDT0FNkdQYWWXdejFwWPky/VSuexn1D9ueSXgkwnv3z9kabA+YnUpD5euMcNr7X+xSAZSgv7NCuGf+d+/bPjmVgJUd080bCTyxtN0jVLxqpp33QPC9LiEurE1mJRA6etPxPBuFbdYXCVQ/IXDz24lH6f2iGTxFLQ5Tbult0xO3ywan2Sq3AAwT2qQDKpt0d5Tnx4VyLLfckSdtHP+X5T5HposhYSV86p+I5ZiVuW3g==
X-YMail-OSG: l_5SAcAVM1nJIxoKOlXJ6ODQnh9GQbP8efptKpipssAffHeAdDRO8CisBOOuQdd
 HIOvm97oAgaVqd31kSDO0E0ycUgvBM5fV5ihoduZg7GC1U1Q3XNwHRJqLhKUcF4.lHArZSYHIabP
 fLt5fErWdMk2.YL8Pi3f0YSrsmvAg1m5UYF3hEZdnfrjJ0qxnKgqcXl.kQ3Y0ymmXZYzceilrdGU
 BwVCJl4.lQCpHoipGyIlpLCo4YiuD88TkhECS8JE9YXr4S_zFc9W2uts_uSQiufU6nQxTEvirQtT
 aNvAHM1Wf0cYCtWqnClgWdNDfrnbQyXYUo0sKj4Sxj1PGaa33TKDmr3_.DFFPb.xPQ.w_2mEF6yX
 SSKACqOihBkjuQtF76J5Cq4h_hlykGF7m0jKHo2P.AEShh.jpUqqX3.jRHaaP8buEcX7uj7DRi0A
 bMsEua.Uh7he9KR4rwtEuuHKrvsChjhYov.geH8sxiCq59MPHIYcoeZGaZ46c296Mt7X9iLcJV.r
 5pLVSs_86NqS6Xz57_9Kn90X5AfawKWR.r53nOag4wR8PCxmLJUMde2g_hk7UP0Y5R9FPCftXJqb
 2cRhis6Pl1Rr3ME_7kroeIU9Z_UbHmWYurBC0xtenakK.wUyvqSEkMGydOgKS9LvOyIKod.FqKS.
 OfxRrbln1Ej4iBsyAYy5C8HSsIXpEHjMxhleFkOVIFlxNMwsRkUF8ylwDNglL0f8UvR4unq6KDSa
 0aukPEhcJOnO3Tkx0YX2pMopWi.grq0mOp1uIt7xe49SxsotspDprkaEqG8xNFVKfgnKsPHzZbMW
 AdiGx01ucHh9d92A0FmYCOLmsDDkfiz_9JR.cJ9NhlLjNYhBRyXipKRL6cEF7KmrrdiYtZhlM_X4
 KoK8S9s6CkZfpYQKgAuTCfBAsF7INahPfsATM4Gx5dY3t8bnqlvYnlp8VtN5CevrR6NPg5dmaOKD
 N8uqVlaeWQ_7Hhaf.zHEMScit9zzg94oSjSncTXIxgbKFAo2fwIoIfWxjhFZdC0Ez8GUm.tlENCM
 9GZke2bMLMve86.lO2rGDfjWB.OiQftMorDN3rqiisp0TmNt0bs1ry6lwjbWe_zCq2PXW75yfk6a
 WrbR.NUaooHk0A8amGx.9ZyLW00H94yYkn5jdzuYBf43wUCz_VR7xxtYRydnJW4e8ffs6CeZIJ4t
 xwu1kxXG6apSfJj6oXJv7LjBlIRSq6hRolxKEYEh2sC3oO3UaEvQGn23ydGWPdrQpqprReYWSeeC
 Lp5qBh50.YpyCC7dbVO.1Rt3UpNiIspAMFQ94hBLXk0jDXAkmozd87A--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Sun, 2 Jun 2019 16:53:29 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp414.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 037f0ce5b74e0a8af50a9035f5845b74;
          Sun, 02 Jun 2019 16:53:25 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 39/58] LSM: Use lsm_context in inode_getsecctx hooks
Date:   Sun,  2 Jun 2019 09:50:42 -0700
Message-Id: <20190602165101.25079-40-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert SELinux and Smack to use the lsm_context structure
instead of a context/secid pair. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  |  7 +++----
 security/security.c        | 11 +++++++++--
 security/selinux/hooks.c   |  6 +++---
 security/smack/smack_lsm.c |  6 +++---
 4 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index c983d573a005..20e59e0b775f 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1394,11 +1394,10 @@
  *	@ctxlen contains the length of @ctx.
  *
  * @inode_getsecctx:
- *	On success, returns 0 and fills out @ctx and @ctxlen with the security
+ *	On success, returns 0 and fills out @cp with the security
  *	context for the given @inode.
  *	@inode we wish to get the security context of.
- *	@ctx is a pointer in which to place the allocated security context.
- *	@ctxlen points to the place to put the length of @ctx.
+ *	@cp is a pointer in which to place the allocated security context.
  *
  * Security hooks for using the eBPF maps and programs functionalities through
  * eBPF syscalls.
@@ -1671,7 +1670,7 @@ union security_list_options {
 	void (*inode_invalidate_secctx)(struct inode *inode);
 	int (*inode_notifysecctx)(struct inode *inode, void *ctx, u32 ctxlen);
 	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen);
-	int (*inode_getsecctx)(struct inode *inode, void **ctx, u32 *ctxlen);
+	int (*inode_getsecctx)(struct inode *inode, struct lsm_context *cp);
 
 #ifdef CONFIG_SECURITY_NETWORK
 	int (*unix_stream_connect)(struct sock *sock, struct sock *other,
diff --git a/security/security.c b/security/security.c
index 84f27428b62d..0c23ffdd92c9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1992,7 +1992,7 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
 {
 	struct lsm_context lc;
 
-	lc.context = secdata;
+	lc.context = (char *)secdata;
 	lc.len = seclen;
 	lsm_export_init(l);
 	return call_one_int_hook(secctx_to_secid, 0, &lc, l);
@@ -2025,7 +2025,14 @@ EXPORT_SYMBOL(security_inode_setsecctx);
 
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

