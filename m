Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F37C282E0
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1286F21736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="UyYq0PYN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfDSAsZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:48:25 -0400
Received: from sonic317-33.consmr.mail.bf2.yahoo.com ([74.6.129.88]:34024 "EHLO
        sonic317-33.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726952AbfDSAsZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634903; bh=0jVxUPp+/V3kRc2gW7rNVCE5I4hyQouQVqDWX5FgND4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=UyYq0PYNsvq8o7GlFtvFecwXR+Flj1xdjo3NjqsdakBqM+2yUzqcP8Q9ld3PMV9rw1Hlln0Wj047+rC0jnOe8vZ58YmunXYpDiQ60u/1W8LHrrWm06mw4MU5xWk17rYWcidvzbqu4LevNsmh9ndQen8EOAUQkvuABBw3uEgihXeWDlW8mbVTCF6l4v7SKBfU6raCETUlaxghDHQA94llW6StMAHX0AJvnQgDOMxrwVJ30AwiMuIZxHGwlb8q6d6ifqiH8qXqdHA4cHVxKezv8R2V7cBOCYd1Xz0nKSJodZI7nhQsTKxr5C1I1aZyVex04ajbs0l/khmUVLIyn6vJdQ==
X-YMail-OSG: alIOpDwVM1kwpOG1Vfr6BpCCmwSoyw12AdvyNzFVFLG539l0ECIFEhI26U3jdCU
 Sv0tbSDkQWQgAxHyu25DafsZsZI.Fj1AdHp.9xg9xfl2LBOmKcfdJqtsEGntKWrM7nRaGFWnOz_u
 Fi.YKSSZrbVb1qg6RqUvxIdihFl0uKafm891y03H5ytYVPeHhGfdI.XJ7n19GthT.wxh7UzYKLHr
 _xWrKmUM1ZwQhFwO9bxod1zAQ4ouflJXBuOYc9rlGDzAyxhpWCiVbjYC.jIRqgdcGNgNcBSOIy1H
 BYFiDGav2TdSZbIu_qHJYqpafRXBmA9etARxnQFL8PWI4dGPBbI0jKBiNoFO1RAtAgWDYNa6XHfR
 _CtY0iorOAMtx4x52i1AlnHi.bEIEJ2Gee.ciDn6oBN6TP6GKvA4Ofslia0e2KTgLiYyzs9O34fk
 Drtt_U9hAhAlAAa2XCKdEHzZwtyERFEHj1GfpStQcCRFS_jtK.UbM15zBNTpc.PrynRqWrCn2zVU
 KwV4QZlQVhAceyeocSExcsUim49v8x5C2p7DknAkDaaBLJyO_cSOCok.x6sSY.iTbRybYQRCXdOH
 Ls4_Z.5UtUhFWAJOyJQCcW4yc.RQpLg52Y.xnsqw0xTZBDXgA4aane8x1l03tN15.J41unlq8ogm
 DxUFdDSehTVRUSFejK8b1Zt5pKQC3c5Dg73VxGUk97r1EpHAc6.jt1IzzbqQ3v4ll7Y3LfCKErO6
 V4tnscztbC4DjBfGz7T_LaA8K4ri.3Y4yyKYId03MVpU65TSG1r13glWqT58RqkcbNnyjPFQiMLL
 oFzhV.gWC8EsGDRLkLZtWoDmNVr55EywrW6uwZqEau5HMVNVa1YHi2twGVbs874KDOHOZm8PtNuN
 mIkEwN33gXwv.HPrufbdSEH46tyvdrxy4C7Bu_4dyNYJ9c8vXTN068qtCftdHphvCXA44zt.Nn.D
 oiGks_fn6GfShnOBZDpasFtmHTjgP0qvSKO8iDsLhBJ9RL.57KXdDADG3Pj_STl7OPuzOVb20ruQ
 FlJ1I7KtuPQAS75lbLRXkoDGucowTjogqvWb3EKK1AFqkpM8HMEGVKwtPuHzMCPhf4jVVYP6CSdl
 3MU_UH1PSMTXxczzF2Ody_fg0Za5QmvPVgVEtpJoRPw.n3fD4IYAaA2WXeNHOKL6J_VyAgA2kWG4
 23_dg7O3x4SLgZA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:48:23 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp425.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 48f2b950f84a4435a371532cc5391b39;
          Fri, 19 Apr 2019 00:48:21 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 53/90] LSM: Use lsm_context in security_inode_setsecctx
Date:   Thu, 18 Apr 2019 17:45:40 -0700
Message-Id: <20190419004617.64627-54-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
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
index 94c714310ab7..0be6eadd0110 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -439,7 +439,7 @@ void security_release_secctx(struct lsm_context *cp);
 
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, struct lsm_context *cp);
-int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
+int security_inode_setsecctx(struct dentry *dentry, struct lsm_context *cp);
 int security_inode_getsecctx(struct inode *inode, struct lsm_context *cp);
 #else /* CONFIG_SECURITY */
 
@@ -1237,7 +1237,8 @@ static inline int security_inode_notifysecctx(struct inode *inode,
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
index 9d09c774a1e9..363647cf1ae8 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2006,13 +2006,9 @@ int security_inode_notifysecctx(struct inode *inode, struct lsm_context *cp)
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

