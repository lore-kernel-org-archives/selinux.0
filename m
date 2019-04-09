Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D70C282DA
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694992082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="GHW9REds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfDIVl3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:41:29 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:39798
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726993AbfDIVl0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846080; bh=obxKrBiGm3LYlnlm6RakpP9K6J8LRUBE6b25/AUVMcY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=GHW9REdsKqBQdqwtidxbnIJ7dTXbxC95fHbb7bn7uXkfMMDPai2pKxkzg1iNh9BoU+UECUn+JRaJxik+1hbudRaudogBckbf9nqZyvJ1K2GahcvDFarNjfJR2wqjXBF0cVv5SQu3xmHSIMAcjXx/XM6OCafFIVGNgeqSr87g/EbQag4ThecHdGBBMMFeVqIOCYY3GPcIXOdoKYDuGecWvgmkuRGgjbI8oLKEW03oOX315+YuHtychTlyOm2LVlRPHs4XNga8NSkm5dMpDNe4jP3ffOv8GkByeohW7M99sOH2G/tM+0edNDz++62z0Xz29cZUE2aEiYHtbqHe7/HX5g==
X-YMail-OSG: Y2tkzTIVM1ni_sOX1OIM1i3kpz2aQmSLrPq3ZuHH3CtKL0s0mQCY2xY8XG1uKQr
 v4nDykfpfB9W7d7tzdoCnQPtTkEKPRdsVnXOS357I2t5WCxO4GYZqnMQEMp6MA.TZt7k6UykyOXl
 WL.MmStVwlwvBLI59PIWJQ3O9bQt7F3n6MSNLqftfZy67JLJ2Nb7SSJyGz0PjgbsFSHetfgoJgeJ
 ynMdQ6qO7.x2xLy438E6rbTPedI3Z1IK8elLJDjJ3i8tOi0H6GYUoe_I7fsJ5o32i02pwJrwpxBX
 21mlsWm8a1t9926LAOFyaBnbVo3UtKvrogDd1vlD2gCtVJHm1zNgNHxzJ.P7jga4HRhnjsc4DjM4
 cWO_PHPcjEU7EABpht4HOdUl7Viy5ttr3A_BQdT6Qs9vgXrHwPlsaMaSdUdE8HH5TVL5hpvEuGzV
 FoMAex2BLxrbMPfXRetIBlqscR.Xek4eQbvdxrd8g7vPu9BgZNTtGXJiJN43poAf73mUD5JrbKgh
 Mvxn2Vc7kWh13yJ9uccTUD2_bXSlzeNQeiMn2lFMus87cg7b8QjIskCc5gDA.r6MaAd0.wARQ64c
 jjgpYptBWkY1PgajSxDMZga29lcBcXJZ3qqoguM8ZtVq2_e51uBKJGvX4h9FX6VG1D0sRzUVlLu4
 TcKdMnnAkM2eRsgL1GFm.q4cydA4.owV4CbA0S1lrsCclF_WhLNaJcbYogHuU5DXbwW8Iq8yDcvC
 2bm0DCIcy39vDU.zA.K.IE2GyW34FswFEeyOSyC0ET_5RPDxPDA8dsuCg1661wGvlDD7VB8HaVDk
 PgEF92KB4uroAGjJ7nVkzPvcAULNsFvopbg_w6BpAhepCbqZgzfCEdFKWwzHTxonaAcNpnbGdL9l
 gOacjiRhhZIhO4xobk0ZeUXqBHj6BdWebkLFMkVjEcnuYJKatKXVzD6YCAbDHvFxfHrMBkXZg3b5
 bYaMAWXjziG8OEkIaJjM9a1m4fZ1OUQctFfs.rE26toM_YhR3f.Za3408vA.9pw.O.V_pTtRk60t
 UKDoyVWa453h8LiREzGP4nDNmd3fm71fdpMA93uYBat9Yh_DDlt3uFCYttJUFscL8EnEbCqW3Fw2
 CrLYgi7MZomWZmAGmWP.sjIZJH86x0FWKKpuqbG1KkKLf8NcK6Qs1EKGtT7qF1Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:41:20 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp424.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ef161db9af8fc10234759f56f4c7a0ea;
          Tue, 09 Apr 2019 21:41:18 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 50/59] fs: remove lsm_context scaffolding
Date:   Tue,  9 Apr 2019 14:39:37 -0700
Message-Id: <20190409213946.1667-51-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The conversion from secctx/seclen pairs to the lsm_context
structure used scaffolding in kernfs and nfs. Replace the
secctx/seclen pairs in the filesystem local datastructures
with a lsm_context.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/kernfs/dir.c             |  9 +++------
 fs/kernfs/inode.c           | 13 +++++--------
 fs/kernfs/kernfs-internal.h |  3 +--
 fs/nfs/inode.c              | 15 ++++++---------
 fs/nfs/internal.h           |  8 ++++----
 fs/nfs/nfs4proc.c           | 27 +++++++++++----------------
 fs/nfs/nfs4xdr.c            | 16 +++++++++-------
 include/linux/nfs4.h        |  8 ++++----
 8 files changed, 43 insertions(+), 56 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 11672c075a8b..48506e856573 100644
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
 		kmem_cache_free(kernfs_iattrs_cache, kn->iattr);
 	}
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 45781f0da80f..4c7da446d210 100644
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
index 0b7d197a904c..2a870795bb3e 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -21,8 +21,7 @@
 
 struct kernfs_iattrs {
 	struct iattr		ia_iattr;
-	void			*ia_secdata;
-	u32			ia_secdata_len;
+	struct lsm_context	ia_context;
 
 	struct simple_xattrs	xattrs;
 };
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 8d0be9767b14..a9a3ec40a90c 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -340,22 +340,19 @@ static void nfs_clear_label_invalid(struct inode *inode)
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
@@ -375,12 +372,12 @@ struct nfs4_label *nfs4_label_alloc(struct nfs_server *server, gfp_t flags)
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
index c7cf23ae6597..63de73024b5f 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -307,20 +307,20 @@ nfs4_label_copy(struct nfs4_label *dst, struct nfs4_label *src)
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
index 8dee01eda643..b2480d0341f1 100644
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
@@ -3556,7 +3548,9 @@ nfs4_atomic_open(struct inode *dir, struct nfs_open_context *ctx,
 		int open_flags, struct iattr *attr, int *opened)
 {
 	struct nfs4_state *state;
-	struct nfs4_label l = {0, 0, 0, NULL}, *label = NULL;
+	struct nfs4_label *label = NULL;
+	struct nfs4_label l = {0, 0,
+			.context = { .context = NULL, .len = 0, }, };
 
 	label = nfs4_label_init_security(dir, ctx->dentry, attr, &l);
 
@@ -5595,7 +5589,8 @@ static int _nfs4_get_security_label(struct inode *inode, void *buf,
 {
 	struct nfs_server *server = NFS_SERVER(inode);
 	struct nfs_fattr fattr;
-	struct nfs4_label label = {0, 0, buflen, buf};
+	struct nfs4_label label = {0, 0,
+			.context = { .context = buf, .len = buflen, }, };
 
 	u32 bitmask[3] = { 0, 0, FATTR4_WORD2_SECURITY_LABEL };
 	struct nfs4_getattr_arg arg = {
@@ -5621,7 +5616,7 @@ static int _nfs4_get_security_label(struct inode *inode, void *buf,
 		return ret;
 	if (!(fattr.valid & NFS_ATTR_FATTR_V4_SECURITY_LABEL))
 		return -ENOENT;
-	if (buflen < label.len)
+	if (buflen < label.context.len)
 		return -ERANGE;
 	return 0;
 }
@@ -5713,8 +5708,8 @@ nfs4_set_security_label(struct inode *inode, const void *buf, size_t buflen)
 
 	ilabel.pi = 0;
 	ilabel.lfs = 0;
-	ilabel.label = (char *)buf;
-	ilabel.len = buflen;
+	ilabel.context.context = (char *)buf;
+	ilabel.context.len = buflen;
 
 	olabel = nfs4_label_alloc(NFS_SERVER(inode), GFP_KERNEL);
 	if (IS_ERR(olabel)) {
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index cfcabc33e24d..85a527ccd6d7 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1141,7 +1141,7 @@ static void encode_attrs(struct xdr_stream *xdr, const struct iattr *iap,
 	}
 
 	if (label && (attrmask[2] & FATTR4_WORD2_SECURITY_LABEL)) {
-		len += 4 + 4 + 4 + (XDR_QUADLEN(label->len) << 2);
+		len += 4 + 4 + 4 + (XDR_QUADLEN(label->context.len) << 2);
 		bmval[2] |= FATTR4_WORD2_SECURITY_LABEL;
 	}
 
@@ -1175,8 +1175,9 @@ static void encode_attrs(struct xdr_stream *xdr, const struct iattr *iap,
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
@@ -4163,8 +4164,8 @@ static int decode_attr_security_label(struct xdr_stream *xdr, uint32_t *bitmap,
 			return -EIO;
 		if (len < NFS4_MAXLABELLEN) {
 			if (label) {
-				memcpy(label->label, p, len);
-				label->len = len;
+				memcpy(label->context.context, p, len);
+				label->context.len = len;
 				label->pi = pi;
 				label->lfs = lfs;
 				status = NFS_ATTR_FATTR_V4_SECURITY_LABEL;
@@ -4174,9 +4175,10 @@ static int decode_attr_security_label(struct xdr_stream *xdr, uint32_t *bitmap,
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
 }
 
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 22494d170619..1189aad71592 100644
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
2.19.1

