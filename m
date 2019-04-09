Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7002AC282CE
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3753E2084B
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LY+2oQCE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfDITT1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:19:27 -0400
Received: from sonic313-26.consmr.mail.gq1.yahoo.com ([98.137.65.89]:34536
        "EHLO sonic313-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726898AbfDITTZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837565; bh=QBEwHL43ut+mDxdXHm9kJRs4xn/suS1Ne3uAL6B3bPo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=LY+2oQCEx+L2SaZZWXxCYpQZKm4ojVSWqtzsQ3T1iEy7TQbmik3sJ5/YNnPhKrZcvlTSrMMy/CqBS43NRuGBAE5DrbatLlKYauDSrGg7+AFmNCyMD87CBvundmpxX5u4ot6r0FeOl9dRXt1hSKkUl29L7c1ZjpxRBkUvkAmRGVlVW3Du8z5u6JzSayq1aj8KQVBK2PSwgDox05aX3L6SdXJRD4TLDW3+ryqV3/laPug7X7HQ5ySwqxI9WdZW4rOqCPop7nTtyyf42NxIEVRANtwKCfBlkPFykc+6RzxmXoezkvRRg4LAGV5WTGCuaSs4dPMkILLrjYBmXUfmVGxMdA==
X-YMail-OSG: hNDJJycVM1lnR_SgnrLkEnT2JXd2tZy0Dvpva3TUN9N7f13j9sfjhC0oaMwBTO2
 nby0sRLERnSzpUtcImPp9mfkP.2hZS8OkuNwcdemQUM7rMi5crDJ7gpAQxx1gdCuAwwp_t1aqplX
 2dyzdROYB2A_sLBn52itxyZtH1QczyKSFCf3HUHZGgRKqdEvx6ENei0EjV8l8gssyZaEEL0Gxc81
 DJgX9lZObgCcciDeEYk2sswG.HXAu6.Xs.o8ChVxDkAD45rtTQF.I2.YPshEkxPMayExTqQoV9fz
 8miJUcr9W6TMvmGxekxLkQKJ2ghQVXPnZR_Mx14xRubD7Bh893o.ZeFVUGI5ylIczmmwyWg0iN.L
 Rz2dctgisvK7ytJvUaWuCk0NR1D633i3CTvZJUZZ2yZztFSAn6lOud3iEVSeQ9af5BV23naMxHIB
 cBBLjMCtZFa6KX47hDyy7rbkQSuCocuEMhJfgnPpojoY2rB9xlenXi_ole33Wf5Op5fdm70TvCX5
 xEsnsUWUZuMRTRWgEtI6NxKnd6mWX.f_hDnYU0YS8K2clHlC4izhN6WmK3BO6qAVhR7fXTjk7Vkc
 HLFSjEkXvF_oByw6jiuP4RKMaAags2rGa7O5332W1KcV03HmeKAq0dTll.ieflzGjlSgmhOKMga8
 lBwLxKbHjshigvEyRoESsJYWqITDhEFzhBO7JoU_6fILstlLOSPFyh5uV325Qk0MFvMCKgWpWgOi
 gPKuXKMcHLt4qkr5lycizXB1S2yILF6_3aBv3CeNWhTpRQk4VbAOXyyScwP2C6lLh8ic9bQC2B5A
 NgpIPa9du4MZj2GA5SxD43F9zY9AbVc4rbrZYtyQDwKZxjilSNOkUXS1aRRO.zLxggDRRSk4GBm4
 Ui4_AJP3mWZyn6U4Ro30xLwRcf7LwdZ0Xot8xQf7xJg3cFGjVujUgSrFJLsF19XxKdWCHTCixN3S
 XboMZv.uI8pq3xWuy4xrI7xpODrEFoc__WLjkOg0IFts585COvk5ECoDirg5hS.elVWu_l7G7V2S
 ULEcoRG3jkyIHv6814U5LeKr7HImv7_xVsFBONUogunQL8C6dYevBA5tmOZdEvKg7r8gU0nFFE6M
 YrFf2TxowK9kqTyZsekKTQDGO8o6jt98UH2Gn.L30TVznU98bBV1fMPEF7.s-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:19:25 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 92df6dee4d3144b341710b3f28d23ef8;
          Tue, 09 Apr 2019 19:19:23 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 41/59] LSM: Use lsm_context in inode_notifysecctx hooks
Date:   Tue,  9 Apr 2019 12:18:30 -0700
Message-Id: <20190409191848.1380-42-casey@schaufler-ca.com>
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
 include/linux/lsm_hooks.h  | 5 ++---
 security/security.c        | 6 +++++-
 security/selinux/hooks.c   | 5 +++--
 security/smack/smack_lsm.c | 5 +++--
 4 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 34ed56be82b8..3344d18ba9d0 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1382,8 +1382,7 @@
  *	Must be called with inode->i_mutex locked.
  *
  *	@inode we wish to set the security context of.
- *	@ctx contains the string which we wish to set in the inode.
- *	@ctxlen contains the length of @ctx.
+ *	@cp contains the string which we wish to set in the inode.
  *
  * @inode_setsecctx:
  *	Change the security context of an inode.  Updates the
@@ -1676,7 +1675,7 @@ union security_list_options {
 	void (*release_secctx)(char *secdata, u32 seclen);
 
 	void (*inode_invalidate_secctx)(struct inode *inode);
-	int (*inode_notifysecctx)(struct inode *inode, void *ctx, u32 ctxlen);
+	int (*inode_notifysecctx)(struct inode *inode, struct lsm_context *cp);
 	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen);
 	int (*inode_getsecctx)(struct inode *inode, struct lsm_context *cp);
 
diff --git a/security/security.c b/security/security.c
index 4625a9b00d1d..ecaabc820d87 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2028,7 +2028,11 @@ EXPORT_SYMBOL(security_inode_invalidate_secctx);
 
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
 {
-	return call_int_hook(inode_notifysecctx, 0, inode, ctx, ctxlen);
+	struct lsm_context lc;
+
+	lc.context = ctx;
+	lc.len = ctxlen;
+	return call_int_hook(inode_notifysecctx, 0, inode, &lc);
 }
 EXPORT_SYMBOL(security_inode_notifysecctx);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e881f42d3ff8..633d62b97e90 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6339,10 +6339,11 @@ static void selinux_inode_invalidate_secctx(struct inode *inode)
 /*
  *	called with inode->i_mutex locked
  */
-static int selinux_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
+static int selinux_inode_notifysecctx(struct inode *inode,
+				      struct lsm_context *cp)
 {
 	int rc = selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX,
-					   ctx, ctxlen, 0);
+					   cp->context, cp->len, 0);
 	/* Do not return error when suppressing label (SBLABEL_MNT not set). */
 	return rc == -EOPNOTSUPP ? 0 : rc;
 }
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 46eead699e1d..3d24503029e5 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4474,9 +4474,10 @@ static void smack_release_secctx(char *secdata, u32 seclen)
 {
 }
 
-static int smack_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
+static int smack_inode_notifysecctx(struct inode *inode, struct lsm_context *cp)
 {
-	return smack_inode_setsecurity(inode, XATTR_SMACK_SUFFIX, ctx, ctxlen, 0);
+	return smack_inode_setsecurity(inode, XATTR_SMACK_SUFFIX, cp->context,
+				       cp->len, 0);
 }
 
 static int smack_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
-- 
2.19.1

