Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07DCC282E2
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF742082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fZlkZk4n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfDIVlF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:41:05 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:45480
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726825AbfDIVlF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846063; bh=C4pqK0cCjqPg2OjmA/YdWF8k0OBv4qNwJVjWV8L6d5Y=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=fZlkZk4nZdTzvhvLXQ/ddDxXTNlOBuLzyfZN3UpIf99kAX5JGgXAkarjhzJPeWX6uOkbEIbWbYaN+tjtGm9uYV3prGnOoUpspuG0xIN6ptx7f9ntRtQJPEHGSQn0AUe694Nl0PAInwa/cNVRCW+e52afMXbqxKFY7+E5BMnxj8KWQ4nXJUCpP+HwW0DWtXR3sFgI34QCA+gis21tU9ACHwlbof7qINt0RcZuGMBjt74qO2rbY2z3K8wUtLLe5GZ+jq+2fiv1Cmt3rhXiwhfg9IId6PTlt5qUw3mvY1Yxx7+xD1bP2DCrMAff8i9YW4K/rQNPwuuCAHKUTnjMMUXurg==
X-YMail-OSG: e3veqNAVM1kSoxepAwlHGf3KiVIvBtb6XPteWfgW5fhisQsLWkVXGm9pcgd8RNr
 B17tL8sXyozBhkedTgbi8izk3NYfp_mpoZiDQph4GuuDEjQSeya5MFMmV57THtXm4aBsRwDXpppA
 VXhsmwSfxRGU55x0rkJRHvH0lE2NSeIUbhTsFJDAOqqIJgmN9wIqNaCYXXWRsg9esu71kKLH4rRV
 CT0Grz_2SsAv3swkWFR84j0Deib2BTnUUCJc5K3jOtSfLjU.j6ch0oJLEbiaOJ7qnpGDO6x.iYTu
 3ckFys_NvA4.4oPej6jU.ih0fDVW75i0y7440.RQMw.QXJ1TDsgESbKMqhkP2_JR5STwPWCjkY42
 apoSKmK6BjUXLTOXzCrjGyTahEtPjb_cVC9YDCQjB7Byx9ZazvAzodTNB8PvM.heC0GR.oEcnSrc
 TlwGCinuJxxgs1MmSfR2sN1oCreourL9Z76dx2JqhfPLBL_790EmdFIvywZUMqCDsbgtgRmz6v12
 rMj6h7ltdGuCLBb3dIOUYeaPRUzw9srK8DA_gp20WTm7Xzm4nQBth2jucP2SK5dJAp0hUeUTRDWg
 KKudCjYNcCYICVxWL5i9B_G7foAi6EgQrJazvdAc9OKCs3df5koWgME9wc9nrmvQlY1ZPrKOnG9Z
 HqcNXDsv_yXxeVfdDgwUwkFP6tgkqhw_ggweE.TACdUyTgnI.zXhrCsZi9VBy.c7BVP.wWwgR0G3
 Yds28uz2Cgt8MQDYGgzfVPo3lTf7rmDbCd.akPNv9sWUhSRat2yQBuTTTzwKjM4VzHMd_YjCg.m9
 r8HfivXgpxfzVTa8a0kqhsTKNeTaIT7cE.BqPeYoj4jetIC6YqBQERQOF.eJiThvPJkP6Me8LLrf
 AvUT6QEC1F.QQ8._Zgfn85hm5nHUuFLE6lrlTr8k3AYvgWtdfnjmXEPQCTnuNI73UYPQrPQ7IBo5
 yXtMyD2ueg1mLoFNfdZZPZxJ3LWKhWRI8_ho3w.tY78VLSrCvObIenwgo38kJfCz9B7XYX65EjVw
 2L7LbNSnpgUwB1fUeMI3IuglUkkGfJW5yyHaCQIOVU3vL_8WnS8tlCUPO9OZZc2Dk6ApnVUUr5CH
 UjLP74x9GVg3V..CUhTo17L.YVTrcQ6wHTqKMvqgaKMKQTslh9qSK480AkIdPcg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:41:03 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp403.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0d1cdfa4e40e9d37a3e144929c04344d;
          Tue, 09 Apr 2019 21:41:02 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 42/59] LSM: Use lsm_context in dentry_init_security hooks
Date:   Tue,  9 Apr 2019 14:39:29 -0700
Message-Id: <20190409213946.1667-43-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
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
index 3344d18ba9d0..f60ec98596c8 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -166,8 +166,7 @@
  *	@dentry dentry to use in calculating the context.
  *	@mode mode used to determine resource type.
  *	@name name of the last path component used to create file
- *	@ctx pointer to place the pointer to the resulting context in.
- *	@ctxlen point to place the length of the resulting context.
+ *	@cp pointer to place the pointer to the resulting context in.
  * @dentry_create_files_as:
  *	Compute a context for a dentry as the inode is not yet available
  *	and set that context in passed in creds so that new files are
@@ -1500,8 +1499,8 @@ union security_list_options {
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
index ecaabc820d87..5e35adb43d65 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1032,8 +1032,14 @@ int security_dentry_init_security(struct dentry *dentry, int mode,
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
index 633d62b97e90..fe09905d013c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2813,8 +2813,8 @@ static void selinux_inode_free_security(struct inode *inode)
 }
 
 static int selinux_dentry_init_security(struct dentry *dentry, int mode,
-					const struct qstr *name, void **ctx,
-					u32 *ctxlen)
+					const struct qstr *name,
+					struct lsm_context *cp)
 {
 	u32 newsid;
 	int rc;
@@ -2826,8 +2826,8 @@ static int selinux_dentry_init_security(struct dentry *dentry, int mode,
 	if (rc)
 		return rc;
 
-	return security_sid_to_context(&selinux_state, newsid, (char **)ctx,
-				       ctxlen);
+	return security_sid_to_context(&selinux_state, newsid, &cp->context,
+				       &cp->len);
 }
 
 static int selinux_dentry_create_files_as(struct dentry *dentry, int mode,
-- 
2.19.1

