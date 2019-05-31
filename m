Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CBDC28CC2
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADBB226FE6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jVAWRXo1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfEaXRI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:17:08 -0400
Received: from sonic303-9.consmr.mail.bf2.yahoo.com ([74.6.131.48]:36982 "EHLO
        sonic303-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726787AbfEaXRI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344627; bh=zNmMomX7FtNuYn5Qpm3pclNFmgRY9BLATnDH4/IPw8o=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=jVAWRXo1koja8b2I8z09Wc/IUVN3dn+SsfWBeAvj28SNrlORMtRCYpHobSHx1sZLdOQNqhqfv+L9LpRr/XqqF76ZwACiUIK6KKocsVPxu+5HRbIsV5eBjsvXiKIsaUf6RbQug7B7ElhMskMYuLzKJ461yevF8UnscFodU7N2e8jP1cTcT8yzVnEkpVHzeF0eezOIQcbdgo9oUX9nxJmeCx4MSWBn4LxLR7Xo8ChgKaXB9BTFecOQbmGG5zpgcBe6pPPTxH2wLqNbwyJ1s1xPV0LRBk8m1sRX4T1dVMtM7ZTVjVHmsTu9f5CqBKVoHVCGWPGI4qd17YTmcJRM7GqN7w==
X-YMail-OSG: tCHU1kwVM1lvh7f75eRPw7wgKh8aZYhWYO67SdQUfpqlpTzyNjKLDv4fN_Cdr0l
 dsPiKQRII1f1ReQfN5k2PwvWUemhNVj.u9vsT.CFfP4twCdZeb81HyGNOI5TRR4Y5hkCclF1aBml
 DsVgAxul1g2VLHf66gCMAJr5iakyEKn8fzv1dvU6_RHy3gL_relyA6rjhac_8So3KazkxWjvx1Qw
 i4LsFSlQhXUxRYFSs1qsSaBw05dAe0h7_RoXkUljcls64NOKeAm_u5stIzf3_71j8px62AA2V8xw
 XWY19FgLTE3bvAsw0ARvKMcAJ4lDgYRkzg.7J5ITmtAbGs2lsMYCatzFPOJ8QTgUJlgs_PvGZUgQ
 QvoZ3QAixp2abIl2wvCbgzNNRzED6YFpPIESKyIaPIvaV.hUPY24KYzf2PzBr3.NSrLrxd79cUUu
 IbGKtBPTegq6S0s247gNfatob8WwIyG6bK3jmMWAb2EsrYxkDQZL6X35vBT.JUXUuxoyRcEJxt0x
 ao1_lzHSYJuDpwgoGgsQOe99OiQk9lv8z3eGkzObxllTvwJ3ujwLRmRJjMxGcN2pOAxwXlI5lH1B
 YtRIzZHmkt_4g1ODIzUkqCo.ZJyJz8HeILm37swceV0teWQp69P9scXX_r9zSF7II5lTgIZMs0ho
 DBwYCLZfTFD6fG_cw0pK9gf3mgbbWQYC30.7EDnTI_LHlb7n7Ut8YmS2L5zYn2BnGnSAAXhHq6Xx
 zeYUF4Qb93n4bSjUnjaqqCde9gtCdd9_tAN445z_FzmSTT8TWwUWGHcQCSekKDkXTen5KH4BJQ5N
 vZ1xHRvXTzMmER6BKfbevlmHD89j9NJqS8eHmtKoDYsZ9sjrv1AlFlMLIsDUNm9rNTREgpnUP9Er
 YRRFScUbgyVTe0YgEYbOndOQakxYJiIEVx8RkHzrySOZy7o6TK7K41atyopAY2Ba3TfAiEAkdnqS
 D.lpb8fzF8hqQ5CWi5cNNzC0hqS5.JV67rL5e6DG4aitXGW.Ln95Er5VAs.BgmdPfYQd0zl4R0N1
 hgQiuApO9BntzgzeEdXnrIx9516BHP.u.ujB.pRRiGHF9OQxuVLZ01wIunzRAv3LM3woNVMlHweQ
 EnWKsIOeXfFwAHmAi356v4yf8ss_I8E7psj9wLcOLtGYZZssm9TXoWa2jtvb02lTGwvEVl2VvlVY
 4n_BisU6zOLis8_vT5hY2FllyzZOzS0tGDC6dlDdmOwHEjhZ1N6kGwq8QcPK9.iWT4irHCcYF77h
 URDyWK4MuhtAFD6Sx8ayYEZkYptpDky1y2Yi63GXK8fNb_T2Q1_YTgqU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Fri, 31 May 2019 23:17:07 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp407.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ecbeeaf97d7184c0d421bbd47d8c0363;
          Fri, 31 May 2019 23:17:04 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 39/58] LSM: Use lsm_context in inode_getsecctx hooks
Date:   Fri, 31 May 2019 16:10:01 -0700
Message-Id: <20190531231020.628-40-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
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

