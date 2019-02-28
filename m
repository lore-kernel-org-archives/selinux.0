Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92D2C10F0D
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8542F2184A
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="FpxZhZEf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbfB1WUR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:17 -0500
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:41876
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731103AbfB1WUR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392416; bh=BTDyZ53PLC2ypuQCEfAYhH3SfAb0aSVsiutkzqz2gyY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=FpxZhZEfVhzRp+2ZjLw0vr+/st206ymqbLIhsAfN2crC2OdNNQgN9eqrX5KnsindLFVHlkvczsg0/smIM9yUMFcq2a6JX/yAkAPSligNB/6vKYeVjevMcFS81lJ/6NyD6AXovU9E65jm+nZcBS2QO6VG3m8TrbOQVTyPlnu8X3V76GkN+Tz1qAqXiqaIe5Ua7DXdDQxm35T/nqm/q4p0Rx2VxcT9yviEffoI31qZ9P/L5kdzSmk4HhKSm+krlPNwZjNhDiL3obCjJC11rVPyFwnxgovh9PlxuTAIR+JXxPCcDyGiDyldI0wVm0aTKB+iGAI/pjZba0tNa7TBB7BAGQ==
X-YMail-OSG: IAcS8w4VM1l3bnEX8OLhujKRb.5ZkTt2vdoIaLVyuEY_ZEJgiW__NPP0HxHtazf
 oAZB8JgyDKP8I9m7WcI73UwYhaKo_Ws6XbKm2IR7gIb1d20orYcvPURpzZjkWrAh7B7qbC2zZShg
 EIakF1zYoXizF.AX91gLMhp.BBV3KQ2j8NlcJEq_LfqD85sz6rTkffgutplh8gcuDLTRvDn1mHeu
 TrpOWhejYOHJ7PwU4hHudwEeX70zkmVHYoAoHLhde0zWUWErLy79PqiL_BsPzAadVhExRUuMrfi1
 _mouaPGskOMYYLZyBia245n6Gi18dyoWjYdx3k_hy33QEL2Wx2LZpQTPRbL0Fs8OV0tohaLNIVNB
 MU0wBQ1SdDgPn93Dl9rk4aYJq1fZrvshjAORNeZH8.SCvLEoI0HgLXRLBtT2yZsAMcJJXwB0Q.Ct
 rd1Yk4qqxgCYVo.2enzpxkIKMWnTvS7AX3wazmV6M82C7RRa9KrQxIKDBg3IHEbPkypn0hvX.0ps
 H9E3Zy38Uxss2.4vu9.qSHySMMiYrIkNBhh9GCmmfbYUnabHzHuOE0K4V6m4ieDFUu14GO54C6cg
 eGC5c84wTdjDKT2HOkHzOp3AnoBqPMgKjICX3yzugUsJ13MCIOP5nAz96pYRgKXBNp_Fepii49As
 xkCjBevtJDDHglfk7Z.YUKdvV0TdCi2kHRBPSvZT4fQfFSwMzc4PH3NIQi5DUUT1Ybk39RpPRIuz
 lMHJYsegncfMFdLeu1BuRNwiLT05pnj5u2wBb7BX9kGIVqV7_GN4vFkNxfLXsWsSY6ZweLfbw_PY
 z8kqT4Sly6NaMhz1mHyi8aNMVwMQreqE8L6hHHs477SfuRp7DcJ9u07WlyOCgS9Tuq5bfYF9ncu6
 MUCJC7ylk12NL2G2ricBhb6BRwhKyY9.dQI4mJZyCPPJurJTc2WpBGUHvgQ2ugeFGnfVxE3FQZVm
 bbKvs5iWNlKiSUtlXHT1OY.nwXoMCr8ynpQwiyFTq74t._.1z4TpCGiGlXkhSTgva2_s8BZOcaVS
 KAuxqb71rnFEFb7HryPOCRGt2yn5zn0VriMZe6u7U8DVn7i53KeMZfJ3mcODh6qlIx1JeJiooIfC
 WxjLSzLdn2zvqU0REqJ.A8xJRVcgZfaoUbeL9NcbX66eTDZY-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:16 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp423.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 51882fbcdd41d0138ebd23ca73a62b12;
          Thu, 28 Feb 2019 22:20:15 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 51/97] LSM: Use lsm_context in security_inode_getsecctx
Date:   Thu, 28 Feb 2019 14:18:47 -0800
Message-Id: <20190228221933.2551-52-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
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
index 7c5b0d5140c4..1da14b56888e 100644
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
index 4194f6b8b97f..2d948f1104cb 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -436,7 +436,7 @@ void security_release_secctx(char *secdata, u32 seclen);
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, struct lsm_context *cp);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
-int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+int security_inode_getsecctx(struct inode *inode, struct lsm_context *cp);
 #else /* CONFIG_SECURITY */
 
 static inline int call_lsm_notifier(enum lsm_event event, void *data)
@@ -1227,7 +1227,8 @@ static inline int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32
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
index 464dee357986..fd1ce1116969 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2024,16 +2024,9 @@ int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
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
2.17.0

