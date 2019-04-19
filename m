Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFF9C282E0
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AEB0217F9
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Ltx0FLBw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfDSAsL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:48:11 -0400
Received: from sonic308-9.consmr.mail.bf2.yahoo.com ([74.6.130.48]:34124 "EHLO
        sonic308-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726906AbfDSAsL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634889; bh=uiAdlfWT162BGGCBUsovr8p/pYfM4L4llbF+V9SFdMc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Ltx0FLBw3TDQCHt3dYHPtIdvA7W9DuHlp2d3vIQn5HdRrjsGog8iQjDI5XpF+kLnsBAA3PiFgKNYGtaocZ8rpZiqm6z/JWWBNVEkka6zjC6Q/LGKVX2USFYvbXk2o6+C57wr9x0aWCAaY+aKwiZMVLvJGCm70UxJuhcVA7cBQBcaH9Tpu4O/OykEER6jkka6A+XLEkUOWBT4KmlwmkgcvwKHb6kcQVyWYPUQsOgTiSMHhB8z1Oh57DuvuV8BffomP5LPS+L/BU4N9winePdaiY7KpdTAnwhkyG+6hyhIdGlp7rgZAFo7qxons0GVeng5dh4TO44pm46sB+OaiLny/w==
X-YMail-OSG: 47EKMg0VM1l5fk3P1Pe97.Xv5vEMenAbvWdlc81WnuoMQbm7vwC1kvBpJty0E8V
 xqzo6uvCJuQJVBm4eilfc3aGjonCw7CznH6RyTEXFJuwNjBxWUYozMGhisfUv0fjcXBUkmSrOnzf
 zD1rdXA1rqpzkwfI6yLvT_Y9Uu1WYygfQl_xLfmA52o5QzMeRm5wOYr9ntq6T02jUC2GXpsq0KOi
 yLZLuJDkVFlO4P1Zp9vcoqcuMjz4Dr_L7X0kIwD_WMTHbEZW1yLiEzVLBwlEUcvnC.c.3I77sISf
 ds1nyXclHDj3KwvefYeiXXyB2evnITZfXvVC7BBcV7ukbfkJSIwazlfhPi..BByidsVchSVEEDga
 g2cT2MIY2By062BJTZnwP3YGFg02fbG2DLFjA0EhCItcZ29P.dNusvgh2l.VVesKgVQVQ2aDujLm
 NhWjxRbY8Vj54ela4ISixPW_3mpBiE05yjCQUuuyqtP8JYstoisVuomnsk65CSJjzf6gY0_3A.77
 m5n.SflL0xLCfhCK5mhx0h1xNpr_U2NEJyKDzaJGo3wcnb6EzXiDPI8mcv5EeDxGEzIL.GphOp5m
 73Z3AAYXwEE51nJ4g6PEV2w1CB6BBSo_lq2C2pES1q1Wp2x5Is9WYottIZCg.M2npc5t18NIVdOf
 sfNm41fUx9wNkrch6dyRJjmIb3Qf19jb5DYKGlno4AExZnST4DXMorIQTrlU5C7hfQIbGVgopTwj
 gcBxzzdfLbMFvEZNmRaNMiR9Wrhp7OyqTe4DbexzBTUkHsIxwPYi5kRInrICyM0f8dQOwMeIR_Ep
 h9P9ZPQhl5srFs2BBmZxKPHeuN5wUjk6O6UMQ1QqYvFfNnHScqfdvS.dbHQXxCOQp.r4SiZuTqfl
 3KANIiwtEDR0rDnQNuET7kKCKwA87csRbpQEamnHnmT2I6sfaiy6NPsbaNCNf7qGDzTRkHEtRY_v
 Harq0X4rXVcaefVCPZP1zF3jS548uxW7E3SuJWaecHkU22Z8Q2CzUu4DGih9nLKPkbwmTARCmcsP
 YRo4fLHeuwfAWF49EVJfiRem8y3U_asg.GCFDYERCjgSf.wE5PkXzQ4YWWhrTWyqe.Aib4KlVgAf
 xKTv4y3TRxlVdr2oOdHZSVt9XepEV6s8ICLiY6sDMsPzydZGP0LT9jhoxy9r3Rmg_iU2sTLX78As
 R44kQcrQ3x4Fs
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:48:09 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp404.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 354bec82e8db1938f39555b4d4e62c9d;
          Fri, 19 Apr 2019 00:48:07 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 45/90] LSM: Use lsm_context in security_inode_getsecctx
Date:   Thu, 18 Apr 2019 17:45:32 -0700
Message-Id: <20190419004617.64627-46-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Casey Schaufler <cschaufler@schaufler-ca.com>

Convert security_inode_getsecctx to use the lsm_context structure
instead of a context/secid pair. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/kernfs/inode.c        | 11 +++++------
 fs/nfsd/nfs4xdr.c        | 14 ++++++--------
 include/linux/security.h |  5 +++--
 security/security.c      | 11 ++---------
 4 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 460e611b1938..41c5afc698fc 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -351,8 +351,7 @@ static int kernfs_security_xattr_set(const struct xattr_handler *handler,
 {
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_iattrs *attrs;
-	void *secdata;
-	u32 secdata_len = 0;
+	struct lsm_context lc = { .context = NULL, .len = 0, };
 	int error;
 
 	attrs = kernfs_iattrs(kn);
@@ -362,16 +361,16 @@ static int kernfs_security_xattr_set(const struct xattr_handler *handler,
 	error = security_inode_setsecurity(inode, suffix, value, size, flags);
 	if (error)
 		return error;
-	error = security_inode_getsecctx(inode, &secdata, &secdata_len);
+	error = security_inode_getsecctx(inode, &lc);
 	if (error)
 		return error;
 
 	mutex_lock(&kernfs_mutex);
-	error = kernfs_node_setsecdata(attrs, &secdata, &secdata_len);
+	error = kernfs_node_setsecdata(attrs, (void **)&lc.context, &lc.len);
 	mutex_unlock(&kernfs_mutex);
 
-	if (secdata)
-		security_release_secctx(secdata, secdata_len);
+	if (lc.context)
+		security_release_secctx(lc.context, lc.len);
 	return error;
 }
 
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 3de42a729093..1bf34730d054 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2420,8 +2420,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	__be32 status;
 	int err;
 	struct nfs4_acl *acl = NULL;
-	void *context = NULL;
-	int contextlen;
+	struct lsm_context lc = { .context = NULL, .len = 0, };
 	bool contextsupport = false;
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
 	u32 minorversion = resp->cstate.minorversion;
@@ -2477,8 +2476,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	if ((bmval2 & FATTR4_WORD2_SECURITY_LABEL) ||
 	     bmval0 & FATTR4_WORD0_SUPPORTED_ATTRS) {
 		if (exp->ex_flags & NFSEXP_SECURITY_LABEL)
-			err = security_inode_getsecctx(d_inode(dentry),
-						&context, &contextlen);
+			err = security_inode_getsecctx(d_inode(dentry), &lc);
 		else
 			err = -EOPNOTSUPP;
 		contextsupport = (err == 0);
@@ -2907,8 +2905,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	}
 
 	if (bmval2 & FATTR4_WORD2_SECURITY_LABEL) {
-		status = nfsd4_encode_security_label(xdr, rqstp, context,
-								contextlen);
+		status = nfsd4_encode_security_label(xdr, rqstp, lc.context,
+								lc.len);
 		if (status)
 			goto out;
 	}
@@ -2919,8 +2917,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 
 out:
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
-	if (context)
-		security_release_secctx(context, contextlen);
+	if (lc.context)
+		security_release_secctx(lc.context, lc.len);
 #endif /* CONFIG_NFSD_V4_SECURITY_LABEL */
 	kfree(acl);
 	if (tempfh) {
diff --git a/include/linux/security.h b/include/linux/security.h
index 6b2fcca08a43..90d1ff7a2fe6 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -439,7 +439,7 @@ void security_release_secctx(char *secdata, u32 seclen);
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, struct lsm_context *cp);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
-int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+int security_inode_getsecctx(struct inode *inode, struct lsm_context *cp);
 #else /* CONFIG_SECURITY */
 
 static inline int call_lsm_notifier(enum lsm_event event, void *data)
@@ -1241,7 +1241,8 @@ static inline int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32
 {
 	return -EOPNOTSUPP;
 }
-static inline int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
+static inline int security_inode_getsecctx(struct inode *inode,
+					   struct lsm_context *cp);
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/security.c b/security/security.c
index 89bd384c14df..b37bce99107c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2023,16 +2023,9 @@ int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 }
 EXPORT_SYMBOL(security_inode_setsecctx);
 
-int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
+int security_inode_getsecctx(struct inode *inode, struct lsm_context *cp)
 {
-	struct lsm_context lc = { .context = NULL, .len = 0, };
-	int rc;
-
-	rc = call_int_hook(inode_getsecctx, -EOPNOTSUPP, inode, &lc);
-
-	*ctx = (void *)lc.context;
-	*ctxlen = lc.len;
-	return rc;
+	return call_int_hook(inode_getsecctx, -EOPNOTSUPP, inode, cp);
 }
 EXPORT_SYMBOL(security_inode_getsecctx);
 
-- 
2.19.1

