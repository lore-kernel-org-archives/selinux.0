Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40317C17449
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 00:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B9C92084E
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 00:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DYzyN0jp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfKMABW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Nov 2019 19:01:22 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:39513
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727063AbfKMABW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Nov 2019 19:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573603281; bh=D1P1+dibHRNtcc4HxrpVKZFfUWIKK/UTS6iwEk9C1pc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=DYzyN0jp9jOpX8hyAPLCqr3lAZ8PSshLqGC4+fNKSklg1Me/mJfqY+IH3BWSWj0Mw0iPB4xgMwrSfdX8C2aEnLl5FArNEC4DWRKYOIyc/2arj3YqXlaweANUKlZaPu7ly4pmNmSNcOPVehOGUKK5MRUTO7HgkijwBDxcATxwBpEnDFkFEl4FaeI+quNSQrCvTJW4fZSIuImLNaFhskXCRfk/lPgz5UQc5NQ0weOKXYoK+/kwFazgfwa+69YeCF9Y9caCNsA+CmSlBWCpAs9oUe1oE7m/roqHykUVo5xvZgq9/EwHuZAbXLGPy2OsX1XcX18VaMZiFw0XomEhBIv9hg==
X-YMail-OSG: xuzPbEgVM1moqxyKmffX8P9hMsifsp91dw7n3HCpQM_z4iRTwPCdC853D5vCyag
 NCRzkp_Gig5agSM8ZYwWExstxiE8Uw0pewYwoqfXrr9tnzF.2F3lJI2gtNe_8lKRT9iHz8VfMo58
 5_yJfRMODS6US5jcmM3i1i4DKCdN2D7UXOcllp60Odg.GC7TL1RzixX8qsTDbJz_5sOLAvc5a1KR
 wQAGNN5.kaUduHWKrhqxrxaCnOeH.BpoU1godcnpNFEozk0p.D0iN_rYZpAiyJpvB5zbTDSfDirW
 N8cDApV.mqQTZt1sqt_HxLwXihFMtUCtCodqw3XcbUwFTLjB.175LfZyVx.DaB7FFbti91KRMb6G
 S_vneynki75nLVJnejpQJKPFagvCNloNix7LKbtB0X7tTnbb0uCviTJWk.oQn32b3FoiQ28bCv6d
 Sd0Jo9RxyKmFO72Y5RBKhP1ry_Cw8BWXCutKO1HJ0jQNYr_3ZXD7JZLm6Ek6LzVsEhSUIiw8PU07
 AT88NkrmKIGNpwvnyLVaQ8jr3Ng9lfTrFLHf.R30_DvxLVpgKtZjEkaKX3R7wGmHL4t_2QGtdwbj
 uttoeBysu9Zfos5.c7MYwSn1ZJZ3BZu4zs43wpOMeK.vZOxlFwaH6_RdtIxWEVuXnCbrDJAkMZh6
 KrGtRq5t0ImGh_3MQ7WzXgcZ5283UtI31yDdOshXmhgv4poHDxc7JOC761_FR87ywgPiYIo8mx7H
 XmPVpRIupTa5j8dRoM5Z75YCVv1wvjuo2x5CZVrzGuhRodfeUHl6OzCt3PKH5wPfnU64Qkjur1e8
 OphvNEufSdnbS_LgaYQDBAnY5cNoUy8DCzx3qoReTx2oF8qrTFspScAknhfU5W6gbhxfkEWoxs2G
 akhUxjlhmRHjKuZwy77ltKeYEgPZT_63teik5GMlW5h1V6e3.0_L62WS.3qgx54etZzAmLUJmv.m
 aoQ7TQ6AXN89MBx44_jAEG7ABP06h4ygmVqQ_4CWSkbTXBeEct1hl9iJTTfmiI5O7zzl8PdlbzhN
 zgeW8W0Xc98Fy56Pr3tynvveWT._ECaID0tlGs.Kxlp7_OWNSlK2_0zhQSTN1MX_k3yQXjMZXUoH
 iL_CoVxD6pc9aHB3rqJc3uB.dFxNlEqFn0v04AasHtNfqAnOFsFLaoOD5Z.bCMIvaYzhZqUNXMH9
 4c8yaQYy54MKpgI28hA5GPvIeFbBY1uZ3iFX81tbz7k93Jj.Gl2MKx_O5icqNTatlcYdcxu9LwxE
 WY_H0tEskW8UIZmQbOScu1lRxaWZrxbwvfzN4iI1nWPyk5cWDXpV1vtr8XhIgB0UAATA36kcKX4g
 X4bdsptDwwQL6A8W5BEOLez2l4YcExlIbJwmkOWo5b0gWdoftiJE8Dl5hoa7yWzrthFn5lTLr_i3
 R4OakMTs5w2_B9BPPRBNQZ5r9HnsMgXdCIyrB0lUnwPavdRYPHZw7eVSfy9U9f.c-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 00:01:21 +0000
Received: by smtp421.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 684ad521453aa3517b6833d573a9ff1b;
          Wed, 13 Nov 2019 00:01:18 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v10 17/25] LSM: Use lsmcontext in security_inode_getsecctx
Date:   Tue, 12 Nov 2019 16:00:14 -0800
Message-Id: <20191113000022.5300-18-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113000022.5300-1-casey@schaufler-ca.com>
References: <20191113000022.5300-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the security_inode_getsecctx() interface to fill
a lsmcontext structure instead of data and length pointers.
This provides the information about which LSM created the
context so that security_release_secctx() can use the
correct hook. A lsmcontext is used within kernfs to store
the security information as well.

security_inode_getsecctx() does not use the "display"
value. There's only one possible user at any time at
this point, and the use is only internal.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/kernfs/dir.c             |  9 ++-------
 fs/kernfs/inode.c           | 34 ++++++++++++----------------------
 fs/kernfs/kernfs-internal.h |  3 +--
 fs/nfsd/nfs4xdr.c           | 23 +++++++++--------------
 include/linux/security.h    |  5 +++--
 security/security.c         | 13 +++++++++++--
 6 files changed, 38 insertions(+), 49 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index c8362b6d556e..1d000289d8b7 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -532,13 +532,8 @@ void kernfs_put(struct kernfs_node *kn)
 	kfree_const(kn->name);
 
 	if (kn->iattr) {
-		struct lsmcontext scaff; /* scaffolding */
-
-		if (kn->iattr->ia_secdata) {
-			lsmcontext_init(&scaff, kn->iattr->ia_secdata,
-					kn->iattr->ia_secdata_len, 0);
-			security_release_secctx(&scaff);
-		}
+		if (kn->iattr->ia_context.context)
+			security_release_secctx(&kn->iattr->ia_context);
 		simple_xattrs_free(&kn->iattr->xattrs);
 		kmem_cache_free(kernfs_iattrs_cache, kn->iattr);
 	}
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 02cde9dac5ee..ffbf7863306d 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -135,21 +135,14 @@ int kernfs_iop_setattr(struct dentry *dentry, struct iattr *iattr)
 	return error;
 }
 
-static int kernfs_node_setsecdata(struct kernfs_iattrs *attrs, void **secdata,
-				  u32 *secdata_len)
+static void kernfs_node_setsecdata(struct kernfs_iattrs *attrs,
+				   struct lsmcontext *cp)
 {
-	void *old_secdata;
-	size_t old_secdata_len;
+	struct lsmcontext old_context;
 
-	old_secdata = attrs->ia_secdata;
-	old_secdata_len = attrs->ia_secdata_len;
-
-	attrs->ia_secdata = *secdata;
-	attrs->ia_secdata_len = *secdata_len;
-
-	*secdata = old_secdata;
-	*secdata_len = old_secdata_len;
-	return 0;
+	old_context = attrs->ia_context;
+	attrs->ia_context = *cp;
+	*cp = old_context;
 }
 
 ssize_t kernfs_iop_listxattr(struct dentry *dentry, char *buf, size_t size)
@@ -192,8 +185,8 @@ static void kernfs_refresh_inode(struct kernfs_node *kn, struct inode *inode)
 		 * persistent copy in kernfs_node.
 		 */
 		set_inode_attr(inode, &attrs->ia_iattr);
-		security_inode_notifysecctx(inode, attrs->ia_secdata,
-					    attrs->ia_secdata_len);
+		security_inode_notifysecctx(inode, attrs->ia_context.context,
+					    attrs->ia_context.len);
 	}
 
 	if (kernfs_type(kn) == KERNFS_DIR)
@@ -350,8 +343,6 @@ static int kernfs_security_xattr_set(const struct xattr_handler *handler,
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_iattrs *attrs;
 	struct lsmcontext context;
-	void *secdata;
-	u32 secdata_len = 0;
 	int error;
 
 	attrs = kernfs_iattrs(kn);
@@ -361,18 +352,17 @@ static int kernfs_security_xattr_set(const struct xattr_handler *handler,
 	error = security_inode_setsecurity(inode, suffix, value, size, flags);
 	if (error)
 		return error;
-	error = security_inode_getsecctx(inode, &secdata, &secdata_len);
+	error = security_inode_getsecctx(inode, &context);
 	if (error)
 		return error;
 
 	mutex_lock(&kernfs_mutex);
-	error = kernfs_node_setsecdata(attrs, &secdata, &secdata_len);
+	kernfs_node_setsecdata(attrs, &context);
 	mutex_unlock(&kernfs_mutex);
 
-	if (secdata) {
-		lsmcontext_init(&context, secdata, secdata_len, 0);
+	if (context.context)
 		security_release_secctx(&context);
-	}
+
 	return error;
 }
 
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 0b7d197a904c..844a028d282f 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -21,8 +21,7 @@
 
 struct kernfs_iattrs {
 	struct iattr		ia_iattr;
-	void			*ia_secdata;
-	u32			ia_secdata_len;
+	struct lsmcontext	ia_context;
 
 	struct simple_xattrs	xattrs;
 };
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index bb3db033e144..d2dbec9c3340 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2304,11 +2304,11 @@ nfsd4_encode_layout_types(struct xdr_stream *xdr, u32 layout_types)
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 static inline __be32
 nfsd4_encode_security_label(struct xdr_stream *xdr, struct svc_rqst *rqstp,
-			    void *context, int len)
+			    struct lsmcontext *context)
 {
 	__be32 *p;
 
-	p = xdr_reserve_space(xdr, len + 4 + 4 + 4);
+	p = xdr_reserve_space(xdr, context->len + 4 + 4 + 4);
 	if (!p)
 		return nfserr_resource;
 
@@ -2318,13 +2318,13 @@ nfsd4_encode_security_label(struct xdr_stream *xdr, struct svc_rqst *rqstp,
 	 */
 	*p++ = cpu_to_be32(0); /* lfs */
 	*p++ = cpu_to_be32(0); /* pi */
-	p = xdr_encode_opaque(p, context, len);
+	p = xdr_encode_opaque(p, context->context, context->len);
 	return 0;
 }
 #else
 static inline __be32
 nfsd4_encode_security_label(struct xdr_stream *xdr, struct svc_rqst *rqstp,
-			    void *context, int len)
+			    struct lsmcontext *context)
 { return 0; }
 #endif
 
@@ -2420,9 +2420,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	__be32 status;
 	int err;
 	struct nfs4_acl *acl = NULL;
-	struct lsmcontext scaff; /* scaffolding */
-	void *context = NULL;
-	int contextlen;
+	struct lsmcontext context = { };
 	bool contextsupport = false;
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
 	u32 minorversion = resp->cstate.minorversion;
@@ -2479,7 +2477,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	     bmval0 & FATTR4_WORD0_SUPPORTED_ATTRS) {
 		if (exp->ex_flags & NFSEXP_SECURITY_LABEL)
 			err = security_inode_getsecctx(d_inode(dentry),
-						&context, &contextlen);
+						       &context);
 		else
 			err = -EOPNOTSUPP;
 		contextsupport = (err == 0);
@@ -2908,8 +2906,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	}
 
 	if (bmval2 & FATTR4_WORD2_SECURITY_LABEL) {
-		status = nfsd4_encode_security_label(xdr, rqstp, context,
-								contextlen);
+		status = nfsd4_encode_security_label(xdr, rqstp, &context);
 		if (status)
 			goto out;
 	}
@@ -2920,10 +2917,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 
 out:
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
-	if (context) {
-		lsmcontext_init(&scaff, context, contextlen, 0); /*scaffolding*/
-		security_release_secctx(&scaff);
-	}
+	if (context.context)
+		security_release_secctx(&context);
 #endif /* CONFIG_NFSD_V4_SECURITY_LABEL */
 	kfree(acl);
 	if (tempfh) {
diff --git a/include/linux/security.h b/include/linux/security.h
index fb1e53029f1d..4b685770c399 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -481,7 +481,7 @@ void security_release_secctx(struct lsmcontext *cp);
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
-int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp);
 #else /* CONFIG_SECURITY */
 
 static inline int call_lsm_notifier(enum lsm_event event, void *data)
@@ -1282,7 +1282,8 @@ static inline int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32
 {
 	return -EOPNOTSUPP;
 }
-static inline int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
+static inline int security_inode_getsecctx(struct inode *inode,
+					   struct lsmcontext *cp)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/security.c b/security/security.c
index 4ebf967d5b81..30b0a04f14a2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2148,9 +2148,18 @@ int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 }
 EXPORT_SYMBOL(security_inode_setsecctx);
 
-int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
+int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp)
 {
-	return call_int_hook(inode_getsecctx, -EOPNOTSUPP, inode, ctx, ctxlen);
+	struct security_hook_list *hp;
+
+	memset(cp, 0, sizeof(*cp));
+
+	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecctx, list) {
+		cp->slot = hp->lsmid->slot;
+		return hp->hook.inode_getsecctx(inode, (void **)&cp->context,
+						&cp->len);
+	}
+	return -EOPNOTSUPP;
 }
 EXPORT_SYMBOL(security_inode_getsecctx);
 
-- 
2.20.1

