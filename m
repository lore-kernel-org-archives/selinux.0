Return-Path: <SRS0=vsEg=YR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6BCCA9EBE
	for <selinux@archiver.kernel.org>; Thu, 24 Oct 2019 20:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B71721929
	for <selinux@archiver.kernel.org>; Thu, 24 Oct 2019 20:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WkvwjoKU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbfJXUx6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:53:58 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com ([66.163.189.89]:43793
        "EHLO sonic306-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728659AbfJXUx6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Oct 2019 16:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1571950437; bh=D1P1+dibHRNtcc4HxrpVKZFfUWIKK/UTS6iwEk9C1pc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=WkvwjoKUmoXIwHy9FHoi/2tnynb5e8utsdhHLI58DISU/nNHOsA1fpFeMaE3pgExSRLBdx21UdzImX4K/k55Gjt12A52T1JwBtbtHCkmFmpQ6FmzfyfkPsgG7s89nKS49LTApxJhq/YnmP95NKaW49oX7yhJf6KYF3T0MYOPMkAPb38RvLR/SkcYX8ddNAm0pCz52lf1WG2uk5fQnj3yiTWQ6GE1nCESkz/0gYcL1oRsQtUz4MuVGu6wEKhoF5QF7Wx2AoLwcpBqUMBoZCu7fPHpk1hm6C+7qeY+TQ6Pp991m8osHamrMqcpxFJRH0YC2B4Ogih7PM1lEkqmN/sVVQ==
X-YMail-OSG: Z4ZbFSAVM1lrNsN_AAt84tbjYfjvZRRkHnOKRG02dGi5jqzLkdm76yx3tQ.gfLQ
 7cdhxYY4lnPyqRupxISqLE_RIY0.O.WUGgHTW6xIu6RQv2BNG8U5QcPAy_c7ZUabbaxE5_hpju.w
 QiyLL7vWyVYMY1ERGKhgF911PnXgC6VmACH5IRNJWEuTgFZ4FLnX.87Ce0KaTcxSpB27u97hCGvH
 3Sv95CZIufrnlVDOzqnwqNlEY0FHbVNr_T0LhDIqF1nbxNj4PHuOVuSBRq9xiDBFlTWPjsTWAkz2
 SbX8G7np56Dx7YHrJ5TXkAEcbQ.eVHlq1OvJoBiSuvizyDvULSRfex07cmRLXNc0Q2zxyKMG.Oar
 y8.p911F0ZCX2h3zweBN1yfAQ26zRztynRyf60ZUDcfC8O0PLyGhRJV7Tw4FYAi4QWbXMX4_ibXN
 Icbmlkrojt18ZMVKx6pY0t_r6i5EINYUBNCN7NFYFGmHfmRKuSakhZlpjf_0Vt_qv3Hu8uw0CcY6
 hGZIwWlMetuMWEWFkuFSfVZ8ObZ3nBRw2.HimXivmkBR1OqSHro9c0HIPCwS4u1ShFwjrw4BOmSM
 jQ7_284iUb2yzq6A5p6qOQAlKrKiBA575RH9eAwstreag50uBh0El4a5QjBwtj7LKc_DtOoriI3P
 M7gJtXbXlzx15GR0iPoUQYPacbd8r8KKUlI.h1jfidQuJjok_R3HqZ6eJ_HCdgxGJLBi1_X4uEYs
 a_iNkRYsJ0GBiueGKFCGgQCq3BuAuNl95PNoN7WQ7KVggduxhYH_8n3Zm3qN3L4Nxp.kIhbCpGmm
 BEHRSJofOxA0kbzqpQK0LchEZy9R74zYDsrocfQ3CsAOyhTBNd6cUWce1rt6tiLw7_834DY6877B
 m3UFAf6Vz35M5lqCfYvS5vsgEj7HoVFyDsMpA.FZh9u8pXWDC8XRQKi5hiHwhz05A82AHk5GxlT1
 QkQQTPclomFoUAPvkX_ODbd7_K2Sa6uJu8eUhlRconHP5.5c40azscBz37u9AkB0J39eLaU019MX
 GeewCCPRkNWh3c8M_69tvDdr9Kwq_cg0Takc0RnaFEadrvOf4LJFVMiiOrVYgTBDH.ZhkW.DqMmu
 QOlbeKNGVsgR9zKKOjChd38fmCIj07ugWCM.SNZ9RSqdrjMkUAwRjYVAX.5q1S6i9n_me2qh8Ut_
 c0ayQw7foqthAn.9U05_jyzP0OFN4xvGRT49gtGdaGv_xqINccxD.oKbpmODVavXEIIooW4enFMC
 rxNtSUqFRrLdUAKDQEMXN3EbbKilx1LgVfoBcFLpx2Cdp.9II4ca0W5i2v15F5m9dC.foLa0Y56D
 UFq8X1tTcit82V4_pyhlUKXHYZZt8bazyLP71xTYtQaF17RiPoBqAes5vhQcQ9ATrTkJ8dtVcJr4
 nJkoe3oEm8CQ-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Thu, 24 Oct 2019 20:53:57 +0000
Received: by smtp428.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 40856e22461a71521149fbac47a9a44a;
          Thu, 24 Oct 2019 20:53:55 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v10 17/25] LSM: Use lsmcontext in security_inode_getsecctx
Date:   Thu, 24 Oct 2019 13:52:20 -0700
Message-Id: <20191024205228.6922-18-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024205228.6922-1-casey@schaufler-ca.com>
References: <20191024205228.6922-1-casey@schaufler-ca.com>
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

