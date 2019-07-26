Return-Path: <SRS0=eUs8=VX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4971BC76190
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 23:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10BD021994
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 23:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="hM2HezPb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbfGZXj4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 26 Jul 2019 19:39:56 -0400
Received: from sonic310-23.consmr.mail.bf2.yahoo.com ([74.6.135.197]:44535
        "EHLO sonic310-23.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727997AbfGZXj4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 26 Jul 2019 19:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1564184394; bh=8KV41Zz+ZUNsye7fb/7IGzMRw1BF6QNdOy4helkYBxE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=hM2HezPbAEgh2Gc36INfDig2Qg0Pku0Pk4hiIvn1iT6sf4TbrEVAqMA7yMQgbp2VLoJvncI0s0IURyzQpSRDwg0lBdUdcD4AZyB55fG52ntRWWaIsBlwztD+/H6HS2u2xL0MlFTCixdLM+8/n1uW0hR2dX3LNj738sPeVt4wm66OcMgPu/r2XG63wSBh+8xd3T6vNJx/BRufQtn5kH0HtpfhMFFkCu6ddJwmUxMy93NdIiPfC8Cpmv2xbparNYYsi3SYxeX/bhz1gUSbfKEVe4kNbIZ/6hP6xsdkCPs0Yaqai4au8gY14VzhjfHuoY6zQjSMuYm/n6D9SsY9sYDcOw==
X-YMail-OSG: .GcIg5gVM1lHcep92.BLDVIb1cGswlu4jlkFzwyq8Mf42KcXDu2vmEoJDKYiwml
 cNkFcJwwkGs4FTYyC.SKVJ4d.7TK.sO4RfVGLrXyte0vZkZ6F8vUKmabXAG3USvXN0sJOpFky66B
 ue9cMXj9JaqC0rmum7Xoj311WsRVi0dFBW.49UC0pJ3eZ.uXYmCttHn1332lIk5whhTROLTd9rrR
 _QrGZ2RaHuyvnWUPjQy0sChK3tyss5GpEK00iyuRg3jBLsYYXGFTpJlvA9bnI9rUk6M0yIgzSQ.6
 EQaAndvVSIClSJKyBfkk7YDjFU_jgqHR1ZzPqgQCfLFJwroAPtftOqb9UTaCuFnANZH5FV7XG8nl
 2ve_lL_mKt5WaKQ1AJPutORAe4zN7.gNg3tnT9xB7e0gWEgfTDrv1H_9RahCMWFVzSRjt0PsXC9f
 dr3qB5zPgDSWzwFLFQ8lw3pKRfb47zB25.1hzMkVfuVOZJW.MoeESDcZLZaC9pIQez2zGVDz3jSG
 Fuxkk4c9tEUd0k2oBo_MdEVybL9.mp213U0MRydsbSw.KeETAveT0CKjt2eeuWhoTOlFFpbthyw.
 UHPjh7_30oqjAc_MtAhKyl2.WHWz_6Qd1GZXNlrRivkyKYA1.in95WOaSkbTPIxKjGAGezp5UGx_
 6GRaz5DEMrc850_rAtjgdnU9FcIH0GvF2ak0cOBWkvsBWt5HVpzLLEeS3_bnhGJRVrBH53rRnXgr
 K.0gT67E11jDgJ5oxq9wWWJs0jIXDdXvyfdrZfg2TRRj1sCsRpWp8qaBTjUmWNzzbPmEMF6DqSbB
 gXq9hwFdW6cK85KUamajtAg8OQtkNQBwb5HxJQfKIGOW1veUJcTM7SdvL_m.tnJz_Vznj0PaULfZ
 7Yk7DeZZAoWOb6d92txeBibLCbcKQhenQaAWCrNfhazKf7FeZkvEShQUFsJu4GPd1a2_p.B6.BQB
 CtQ_ygyzAly1tBS0sMzMjub0giWTs0FfBJUOj3jAf9UCeOV7qDpGyxHwnF4gaDfD05acWyDgU2.b
 Ah4Zs6kbiTzRNXkWUbwkMj4RrAQ0Vt08Xu15ie6FsEaMTHLkvORyYyxR8igr_.anTlzgzG3cevoK
 6BmZe6mXBPKIKsWKMgKIXekFXk4K8fwu4SvVmjs7tUSW3m8e9AI0BFnPxKq3PBt24TwnqN5QrPXn
 AVBQ01iQKAbQhVgRyM_4zjAymA6Vma5RPCIbkOQPft3QVK.OSHhHRznq3hxuTweSmisbMMr02ga0
 xFyDetfwy.nOFL6ow5GpOeL_BdyrFtykAe8ZVlowyaHlBKQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Fri, 26 Jul 2019 23:39:54 +0000
Received: by smtp416.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 223f61bb2347890e9e9f353c8afb834f;
          Fri, 26 Jul 2019 23:39:51 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 18/27] LSM: Use lsmcontext in security_inode_getsecctx
Date:   Fri, 26 Jul 2019 16:39:14 -0700
Message-Id: <20190726233923.2570-19-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726233923.2570-1-casey@schaufler-ca.com>
References: <20190726233923.2570-1-casey@schaufler-ca.com>
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
index 2674eb70c2d7..c16aea55be97 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -489,7 +489,7 @@ void security_release_secctx(struct lsmcontext *cp);
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
-int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp);
 #else /* CONFIG_SECURITY */
 
 static inline int call_lsm_notifier(enum lsm_event event, void *data)
@@ -1290,7 +1290,8 @@ static inline int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32
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
index b714074b1729..9a6c5d8f7678 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2198,9 +2198,18 @@ int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
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

