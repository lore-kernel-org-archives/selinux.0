Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAB1C282E0
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD88B2082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="cwow+n4F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfDIVla (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:41:30 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:37885
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727032AbfDIVl3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846085; bh=dRfjl1AB3/4wu0T+48nviV38M45041jZ8lVQvnspWfU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=cwow+n4FuoiKRlakPcN1oixDYawkXD7Yse38weNGLYxWDgkmCS//yzU7b3BxOTE6isHvjP7HYtNboctfc+NCuzRSBgTv0NBwarEgzU5GjHqKlqplfCtJcO61DtmUiB7x2sRcSt+iPFGIWoacz7/SviWKLWTpk7fJl5pNne0EL+vsCFBgduaUdxEStz1STio2yfECjUW4VfjNML11aCkjSAqx87SYsfTKIIzA18lJeE0YXFgvnFgWOvGXjIgqRkWH5dsyeV0t1TgOHYi+Rf4eRZFryKPCtvdCcElPbsftwqH6Zut11L+W9fakbHIlPHEhwUaG0fSSlCyPymSSEVFVmA==
X-YMail-OSG: NY0WupEVM1kbr3uLIz2bYjTrjQbNPJBwRG1IAtr7FnZZbW6K8WYWivp8sU_uoKH
 lPqu27on82nS5dBI36w.gwYVVzXO361z1aqdBIRAtDUq55cEKHhVNQA0AHfC5qsS3PgLD3agdCc8
 HmTOz.X6rQ7FOEgo7wFGG6Hc9DhP9wf7MrPaivkdDEQoBDfbMxPRexnVTrsiLVWpXo22hOfctL91
 _922eOXreNyFUwjWhOr.0EJgB17qvrfVKxJn4PYGWqItnugvn370kXxMs84hJtcyew53GTPmqhBw
 68cqVfcTODI43HdP.XZZCeVbjF7DJbNrubLqycPDojtXn6jjGLx2f4cO9AWX2b1lbN0jRN4MHgNx
 .sLKo.zxTR3Il3gVLdfDFlGlGg7WGzl1S2Ty3.jVeqz8G97I1teJiUxrWQTgmAjFiya0FsTaLOwL
 O9x8.DrSinWpIP3mCMsI_xCpTreWllKMF3I8_j1xuyzf8WMBND3PBauprVvRbfV_sbLSmvIV1mFS
 hbf_Q6_plbTUw0suAhEUB7JSXmoirCDZ6pr2mYUcdC5XVYp9TNpDDbFrvcRBzGTrB18wFZNqGUIy
 rif7Homb50PjIQTSTVFuNmIb16A6K3QzQxuhmFv87btIV9cjWAunJiq7m5qB6Qerk.me9lUta0tp
 Ryn9jOeKhnJyBhRgVOdGNGyBAEyc1laz49c1NCFLdpK3emJ7jgpFW01O2YijqMjGVopdFOtmA7iM
 RtTByn5n.KwtLkiNFZX5Z5QTNMc2xDHAKA6iuRc_hDUXgD_zdGFRUpJrh.j5Q1uIc4aGCmj20pwF
 l9pZoNE7D9e3CX4eWu2ESfHBzPQPhquesV0FkpagKyZGp0JS6bLUF.DmGvhTfUUlP8OV8UKw5ktl
 ikzTJR6AdEV8s.K_9wZkBW08ua914zzcv7AZjvuVwnBdhPGsFuMqIUumHOGOU2bM.V2jTqw2SNKi
 GSNotIbpW6ixNSWvRZXbAcRAVktXVY7zetRYLPQrpYkpmGqzdiF_5XQtQR9q5dn9JaIOV2MnZoy4
 dRt3XlVgX3altJXP2NavSLq6LGyxTQzUCaWCVg9SUt5g_7cN9vPqD9rbOLICLU8FrDf7BtbqoEHw
 Z64sKVGBua6DpWlv1LsHkOqTde3m3YMZ7Q6bRUiRfO.efCvqY0u4bSH9OlXKkSQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:41:25 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp424.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ef161db9af8fc10234759f56f4c7a0ea;
          Tue, 09 Apr 2019 21:41:20 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 53/59] LSM: Use lsm_context in security_inode_setsecctx
Date:   Tue,  9 Apr 2019 14:39:40 -0700
Message-Id: <20190409213946.1667-54-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Casey Schaufler <cschaufler@schaufler-ca.com>

Convert security_inode_setsecctx to use the lsm_context structure
instead of a context/secid pair. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/nfsd/nfs4proc.c       | 8 ++++++--
 fs/nfsd/vfs.c            | 7 ++++++-
 include/linux/security.h | 5 +++--
 security/security.c      | 8 ++------
 4 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 0cfd257ffdaf..5b4ea2a317ed 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -54,12 +54,16 @@
 static inline void
 nfsd4_security_inode_setsecctx(struct svc_fh *resfh, struct xdr_netobj *label, u32 *bmval)
 {
+	struct lsm_context lc;
 	struct inode *inode = d_inode(resfh->fh_dentry);
 	int status;
 
 	inode_lock(inode);
-	status = security_inode_setsecctx(resfh->fh_dentry,
-		label->data, label->len);
+
+	lsm_context_init(&lc);
+	lc.context = label->data;
+	lc.len = label->len;
+	status = security_inode_setsecctx(resfh->fh_dentry, &lc);
 	inode_unlock(inode);
 
 	if (status)
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 7dc98e14655d..2d6dd4bb7247 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -531,6 +531,7 @@ __be32 nfsd4_set_nfs4_label(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	__be32 error;
 	int host_error;
 	struct dentry *dentry;
+	struct lsm_context lc;
 
 	error = fh_verify(rqstp, fhp, 0 /* S_IFREG */, NFSD_MAY_SATTR);
 	if (error)
@@ -539,7 +540,11 @@ __be32 nfsd4_set_nfs4_label(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	dentry = fhp->fh_dentry;
 
 	inode_lock(d_inode(dentry));
-	host_error = security_inode_setsecctx(dentry, label->data, label->len);
+
+	lsm_context_init(&lc);
+	lc.context = label->data;
+	lc.len = label->len;
+	host_error = security_inode_setsecctx(dentry, &lc);
 	inode_unlock(d_inode(dentry));
 	return nfserrno(host_error);
 }
diff --git a/include/linux/security.h b/include/linux/security.h
index 76681aca95cb..38bb4a5f52ce 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -441,7 +441,7 @@ void security_release_secctx(struct lsm_context *cp);
 
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, struct lsm_context *cp);
-int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
+int security_inode_setsecctx(struct dentry *dentry, struct lsm_context *cp);
 int security_inode_getsecctx(struct inode *inode, struct lsm_context *cp);
 #else /* CONFIG_SECURITY */
 
@@ -1239,7 +1239,8 @@ static inline int security_inode_notifysecctx(struct inode *inode,
 {
 	return -EOPNOTSUPP;
 }
-static inline int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
+static inline int security_inode_setsecctx(struct dentry *dentry,
+					   struct lsm_context *cp)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/security.c b/security/security.c
index 36a7034d1f91..1b4b74af0cb7 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2021,13 +2021,9 @@ int security_inode_notifysecctx(struct inode *inode, struct lsm_context *cp)
 }
 EXPORT_SYMBOL(security_inode_notifysecctx);
 
-int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
+int security_inode_setsecctx(struct dentry *dentry, struct lsm_context *cp)
 {
-	struct lsm_context lc;
-
-	lc.context = ctx;
-	lc.len = ctxlen;
-	return call_int_hook(inode_setsecctx, 0, dentry, &lc);
+	return call_int_hook(inode_setsecctx, 0, dentry, cp);
 }
 EXPORT_SYMBOL(security_inode_setsecctx);
 
-- 
2.19.1

