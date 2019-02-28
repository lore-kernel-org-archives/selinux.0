Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CA9C10F09
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B04B20851
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PSWHWDvr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbfB1WUi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:38 -0500
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:37252
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731381AbfB1WUW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392420; bh=gkzlCMV5T2KxJtxeR3+bHaNuRCMRCBZQLj/xQrlkFBM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=PSWHWDvrn84dm6QlWYCBbfNh4adsQmGCOy3mlLES9Yl+vnaJ+lsq0L2b7IqrnTiOxW576gLsbsFBIZfCUe3PogI41MM7PpdCi40Dxe8U/EhZMr+Utew2OMKXDR0v72hktQX+jj23RiA6TtYfSGwvJtBZdEV5toy8mZTdkBGZugZ4Oxd1jzkfNJ3bQW87yt2vcB1B8YfaQzkjAnz0Wo+IrdZhIw5EYbD/uHhEBFMMD3Aakkb5r8746fx8lzqMeqmakA7atDDwze7PViBZSbuscb/0dZMRk1xLh+PmADEFX610XV91kt8Lj8w1jqwpVUVZdFdjnHbJXuEAXXCRxjOg0g==
X-YMail-OSG: A9Sd2BYVM1mx9HHaEGfBp9WNt1ubYGKlhJJqD__78wA3CzhCfZ9bWs8VoAjm59m
 sBPd5OmYRXQjBGqkryZZLn7tlFzPRnSj8aG4YOBbRsEQf5xOUg8kPRxkRe5d5KQqudmZNI7bL9nN
 peJR2gYHCjZi.KriwefTYz97JnWSgi4kWqNco9uj7ab_ShypFwQY2Yj1PRS9PtqnC5g9swpHvDJX
 BLQ9ti6k9XrV4b.uk4lD1lQ3JXr2M4Nhmfn_YmlhZQpulVJ_IBq1je2xXMIQzieGe9i_Qfttz.pg
 QPSd8bW9awTJ6bo.AzkBh_rV77K2rVgNlH5j9TXx6ku11br6n3dG7Vp7oqc.lGKQj.j9XSsfVpkV
 MkpcFsubkMw1J9WT.1pxtQ_nPj945FFonUv0J7F2lzaxfV3u1CuQ85Zl8ZTwbcSgRjSn8eNn0Hub
 89PnLNZ5nkvTAG0MWySyWjfAlnBytKMTPn6f_bv5Dseg.q4kvxbe1RZ5SxbDlBZr78jKK_CDKdJK
 F5DmAXzMYpLmMoZ3qsUkIuztzfKwmxPLv6GzS0NiH4GzwCREZyRtH8x8U8klG2ns7.4Tb.AyBZ2c
 k5VrU9YuH3J.B3J3jlYvoP0SpEtG1mRuuIf9_bcL1soJOdrkcVwYbSPoPBK_7T9VZDAT0etMk1xa
 79AK74TeBolhQ7yCMoO8fekyjZNA6U3u8z4EgP.hnbP.1rNaP0SpN2LdW69RjupXXGRhLt_nJg3S
 yULiamtiwPakvxeqnAGE5Q5sHWSbuixtnnp29fnQA4SNh6daBJNp2sI9ePXpMCzTi_.78LUZ0qd3
 d1coZwkX52zTk6kWFh4CmSLbYqyjSRpqEbZes0MyZuK3ksxm1UQbIEpPL2Ew4uoRrlzcG73o8I_U
 aXPo8MxSCRT0zd7Iwk3nioIO2kSdi4QHg11ZITamyxLzj49gNwjDNx7rc8aXose_H3GY4NdtvBq3
 QjMCtSGlPeD6Bzg9blzmzF3CIjxzcLqe2hH4gPGpBuNSt8Ej2FXdjiLtyatoSvJbfi.8ikEIPMx3
 WVNLUhkRnlRuJvUdiodjRe4lSCfZGxdYPiC.XVeNFjpylnqK0PBmsEvsA8Vu2gvkelt_lYPKMHf9
 i.Opy2DUmeRro6I2CEqJmCwKX5RKvCRTh0y7zw6G7vPa31W0-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:20 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp423.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 51882fbcdd41d0138ebd23ca73a62b12;
          Thu, 28 Feb 2019 22:20:18 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 56/97] fs: remove lsm_context scaffolding
Date:   Thu, 28 Feb 2019 14:18:52 -0800
Message-Id: <20190228221933.2551-57-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Casey Schaufler <cschaufler@schaufler-ca.com>

The conversion from secctx/seclen pairs to the lsm_context
structure used scaffolding in kernfs and nfs. Replace the
secctx/seclen pairs in the filesystem local datastructures
with a lsm_context.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/kernfs/dir.c             |  9 +++------
 fs/kernfs/inode.c           | 13 +++++--------
 fs/kernfs/kernfs-internal.h |  4 ++--
 fs/nfs/inode.c              | 15 ++++++---------
 fs/nfs/internal.h           |  8 ++++----
 fs/nfs/nfs4proc.c           | 27 +++++++++++----------------
 fs/nfs/nfs4xdr.c            | 16 +++++++++-------
 include/linux/nfs4.h        |  8 ++++----
 8 files changed, 44 insertions(+), 56 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index a2f8543b88f1..a99ceae97e0f 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -532,12 +532,9 @@ void kernfs_put(struct kernfs_node *kn)
 	kfree_const(kn->name);
 
 	if (kn->iattr) {
-		if (kn->iattr->ia_secdata) {
-			struct lsm_context lc;	/* Scaffolding -Casey */
-			lc.context = kn->iattr->ia_secdata;
-			lc.len = kn->iattr->ia_secdata_len;
-			security_release_secctx(&lc);
-		}
+		if (kn->iattr->ia_context.context)
+			security_release_secctx(
+					&kn->iattr->ia_context);
 		simple_xattrs_free(&kn->iattr->xattrs);
 	}
 	kfree(kn->iattr);
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 62b152c24f59..6db050b7c6ab 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -141,11 +141,11 @@ static int kernfs_node_setsecdata(struct kernfs_iattrs *attrs, void **secdata,
 	void *old_secdata;
 	size_t old_secdata_len;
 
-	old_secdata = attrs->ia_secdata;
-	old_secdata_len = attrs->ia_secdata_len;
+	old_secdata = attrs->ia_context.context;
+	old_secdata_len = attrs->ia_context.len;
 
-	attrs->ia_secdata = *secdata;
-	attrs->ia_secdata_len = *secdata_len;
+	attrs->ia_context.context = *secdata;
+	attrs->ia_context.len = *secdata_len;
 
 	*secdata = old_secdata;
 	*secdata_len = old_secdata_len;
@@ -184,7 +184,6 @@ static inline void set_inode_attr(struct inode *inode, struct iattr *iattr)
 static void kernfs_refresh_inode(struct kernfs_node *kn, struct inode *inode)
 {
 	struct kernfs_iattrs *attrs = kn->iattr;
-	struct lsm_context lc;	/* Scaffolding -Casey */
 
 	inode->i_mode = kn->mode;
 	if (attrs) {
@@ -193,9 +192,7 @@ static void kernfs_refresh_inode(struct kernfs_node *kn, struct inode *inode)
 		 * persistent copy in kernfs_node.
 		 */
 		set_inode_attr(inode, &attrs->ia_iattr);
-		lc.context = attrs->ia_secdata;
-		lc.len = attrs->ia_secdata_len;
-		security_inode_notifysecctx(inode, &lc);
+		security_inode_notifysecctx(inode, &attrs->ia_context);
 	}
 
 	if (kernfs_type(kn) == KERNFS_DIR)
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 3d83b114bb08..f9187731e2b5 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -15,13 +15,13 @@
 #include <linux/fs.h>
 #include <linux/mutex.h>
 #include <linux/xattr.h>
+#include <linux/security.h>
 
 #include <linux/kernfs.h>
 
 struct kernfs_iattrs {
 	struct iattr		ia_iattr;
-	void			*ia_secdata;
-	u32			ia_secdata_len;
+	struct lsm_context	ia_context;
 
 	struct simple_xattrs	xattrs;
 };
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index f6c339d4e6fb..1679011f7854 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -339,22 +339,19 @@ static void nfs_clear_label_invalid(struct inode *inode)
 void nfs_setsecurity(struct inode *inode, struct nfs_fattr *fattr,
 					struct nfs4_label *label)
 {
-	struct lsm_context lc;	/* Scaffolding -Casey */
 	int error;
 
 	if (label == NULL)
 		return;
 
 	if ((fattr->valid & NFS_ATTR_FATTR_V4_SECURITY_LABEL) && inode->i_security) {
-		lc.context = label->label;
-		lc.len = label->len;
-		error = security_inode_notifysecctx(inode, &lc);
+		error = security_inode_notifysecctx(inode, &label->context);
 		if (error)
 			printk(KERN_ERR "%s() %s %d "
 					"security_inode_notifysecctx() %d\n",
 					__func__,
-					(char *)label->label,
-					label->len, error);
+					label->context.context,
+					label->context.len, error);
 		nfs_clear_label_invalid(inode);
 	}
 }
@@ -374,12 +371,12 @@ struct nfs4_label *nfs4_label_alloc(struct nfs_server *server, gfp_t flags)
 	if (label == NULL)
 		return ERR_PTR(-ENOMEM);
 
-	label->label = kzalloc(NFS4_MAXLABELLEN, flags);
-	if (label->label == NULL) {
+	label->context.context = kzalloc(NFS4_MAXLABELLEN, flags);
+	if (label->context.context == NULL) {
 		kfree(label);
 		return ERR_PTR(-ENOMEM);
 	}
-	label->len = NFS4_MAXLABELLEN;
+	label->context.len = NFS4_MAXLABELLEN;
 
 	return label;
 }
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index b1e577302518..67ec16c1b6e1 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -306,20 +306,20 @@ nfs4_label_copy(struct nfs4_label *dst, struct nfs4_label *src)
 	if (!dst || !src)
 		return NULL;
 
-	if (src->len > NFS4_MAXLABELLEN)
+	if (src->context.len > NFS4_MAXLABELLEN)
 		return NULL;
 
 	dst->lfs = src->lfs;
 	dst->pi = src->pi;
-	dst->len = src->len;
-	memcpy(dst->label, src->label, src->len);
+	dst->context.len = src->context.len;
+	memcpy(dst->context.context, src->context.context, src->context.len);
 
 	return dst;
 }
 static inline void nfs4_label_free(struct nfs4_label *label)
 {
 	if (label) {
-		kfree(label->label);
+		kfree(label->context.context);
 		kfree(label);
 	}
 	return;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index fe95c055c27b..cc4d7d631feb 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -113,7 +113,6 @@ static inline struct nfs4_label *
 nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
 	struct iattr *sattr, struct nfs4_label *label)
 {
-	struct lsm_context lc; /* Scaffolding -Casey */
 	int err;
 
 	if (label == NULL)
@@ -123,9 +122,7 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
 		return NULL;
 
 	err = security_dentry_init_security(dentry, sattr->ia_mode,
-					    &dentry->d_name, &lc);
-	label->label = lc.context;
-	label->len = lc.len;
+					    &dentry->d_name, &label->context);
 	if (err == 0)
 		return label;
 
@@ -134,13 +131,8 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
 static inline void
 nfs4_label_release_security(struct nfs4_label *label)
 {
-	struct lsm_context lc;	/* Scaffolding -Casey */
-
-	if (label) {
-		lc.context = label->label;
-		lc.len = label->len;
-		security_release_secctx(&lc);
-	}
+	if (label)
+		security_release_secctx(&label->context);
 }
 static inline u32 *nfs4_bitmask(struct nfs_server *server, struct nfs4_label *label)
 {
@@ -3557,7 +3549,9 @@ nfs4_atomic_open(struct inode *dir, struct nfs_open_context *ctx,
 		int open_flags, struct iattr *attr, int *opened)
 {
 	struct nfs4_state *state;
-	struct nfs4_label l = {0, 0, 0, NULL}, *label = NULL;
+	struct nfs4_label *label = NULL;
+	struct nfs4_label l = {0, 0,
+			.context = { .context = NULL, .len = 0, }, };
 
 	label = nfs4_label_init_security(dir, ctx->dentry, attr, &l);
 
@@ -5596,7 +5590,8 @@ static int _nfs4_get_security_label(struct inode *inode, void *buf,
 {
 	struct nfs_server *server = NFS_SERVER(inode);
 	struct nfs_fattr fattr;
-	struct nfs4_label label = {0, 0, buflen, buf};
+	struct nfs4_label label = {0, 0,
+			.context = { .context = buf, .len = buflen, }, };
 
 	u32 bitmask[3] = { 0, 0, FATTR4_WORD2_SECURITY_LABEL };
 	struct nfs4_getattr_arg arg = {
@@ -5622,7 +5617,7 @@ static int _nfs4_get_security_label(struct inode *inode, void *buf,
 		return ret;
 	if (!(fattr.valid & NFS_ATTR_FATTR_V4_SECURITY_LABEL))
 		return -ENOENT;
-	if (buflen < label.len)
+	if (buflen < label.context.len)
 		return -ERANGE;
 	return 0;
 }
@@ -5714,8 +5709,8 @@ nfs4_set_security_label(struct inode *inode, const void *buf, size_t buflen)
 
 	ilabel.pi = 0;
 	ilabel.lfs = 0;
-	ilabel.label = (char *)buf;
-	ilabel.len = buflen;
+	ilabel.context.context = (char *)buf;
+	ilabel.context.len = buflen;
 
 	olabel = nfs4_label_alloc(NFS_SERVER(inode), GFP_KERNEL);
 	if (IS_ERR(olabel)) {
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 2fc8f6fa25e4..e3a237490e09 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1140,7 +1140,7 @@ static void encode_attrs(struct xdr_stream *xdr, const struct iattr *iap,
 	}
 
 	if (label && (attrmask[2] & FATTR4_WORD2_SECURITY_LABEL)) {
-		len += 4 + 4 + 4 + (XDR_QUADLEN(label->len) << 2);
+		len += 4 + 4 + 4 + (XDR_QUADLEN(label->context.len) << 2);
 		bmval[2] |= FATTR4_WORD2_SECURITY_LABEL;
 	}
 
@@ -1174,8 +1174,9 @@ static void encode_attrs(struct xdr_stream *xdr, const struct iattr *iap,
 	if (bmval[2] & FATTR4_WORD2_SECURITY_LABEL) {
 		*p++ = cpu_to_be32(label->lfs);
 		*p++ = cpu_to_be32(label->pi);
-		*p++ = cpu_to_be32(label->len);
-		p = xdr_encode_opaque_fixed(p, label->label, label->len);
+		*p++ = cpu_to_be32(label->context.len);
+		p = xdr_encode_opaque_fixed(p, label->context.context,
+					    label->context.len);
 	}
 	if (bmval[2] & FATTR4_WORD2_MODE_UMASK) {
 		*p++ = cpu_to_be32(iap->ia_mode & S_IALLUGO);
@@ -4280,8 +4281,8 @@ static int decode_attr_security_label(struct xdr_stream *xdr, uint32_t *bitmap,
 			goto out_overflow;
 		if (len < NFS4_MAXLABELLEN) {
 			if (label) {
-				memcpy(label->label, p, len);
-				label->len = len;
+				memcpy(label->context.context, p, len);
+				label->context.len = len;
 				label->pi = pi;
 				label->lfs = lfs;
 				status = NFS_ATTR_FATTR_V4_SECURITY_LABEL;
@@ -4291,9 +4292,10 @@ static int decode_attr_security_label(struct xdr_stream *xdr, uint32_t *bitmap,
 			printk(KERN_WARNING "%s: label too long (%u)!\n",
 					__func__, len);
 	}
-	if (label && label->label)
+	if (label && label->context.context)
 		dprintk("%s: label=%s, len=%d, PI=%d, LFS=%d\n", __func__,
-			(char *)label->label, label->len, label->pi, label->lfs);
+			(char *)label->context.context, label->context.len,
+			label->pi, label->lfs);
 	return status;
 
 out_overflow:
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 1b06f0b28453..d34865c57324 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -15,6 +15,7 @@
 
 #include <linux/list.h>
 #include <linux/uidgid.h>
+#include <linux/security.h>
 #include <uapi/linux/nfs4.h>
 
 enum nfs4_acl_whotype {
@@ -43,10 +44,9 @@ struct nfs4_acl {
 #define NFS4_MAXLABELLEN	2048
 
 struct nfs4_label {
-	uint32_t	lfs;
-	uint32_t	pi;
-	u32		len;
-	char	*label;
+	uint32_t		lfs;
+	uint32_t		pi;
+	struct lsm_context	context;
 };
 
 typedef struct { char data[NFS4_VERIFIER_SIZE]; } nfs4_verifier;
-- 
2.17.0

