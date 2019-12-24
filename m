Return-Path: <SRS0=lMs6=2O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B2DC2D0C3
	for <selinux@archiver.kernel.org>; Tue, 24 Dec 2019 23:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 859A7206CB
	for <selinux@archiver.kernel.org>; Tue, 24 Dec 2019 23:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mSakiErB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfLXXWC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Dec 2019 18:22:02 -0500
Received: from sonic311-31.consmr.mail.ne1.yahoo.com ([66.163.188.212]:41048
        "EHLO sonic311-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726258AbfLXXWC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Dec 2019 18:22:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577229720; bh=IkTU4ebhP5bc/ZcCd8sps/OqKWvIBDoNVbjWD0Ij5Jc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=mSakiErBUpph0KPDCPGP0unMf5Zv0XxoJ/KJ2ZM9vuZVjuY9PGw5PIUIPfs/cXbh2gDlTfFMZDD/kTqQnpKE9bdL45VKX5S4hcVz3EAAz+aEpe5KtciDI4AVX+/Vc4e1DlR6Ql2MbJYtlsbHiFxwBxTgYUn51zJCS5lGb9HM2B5BxVMpB5D7ho55dQERbHDdCIhQ0XSmCqIkNOLusbvw/cRzdegdL1lHmmI0nwWUCLD34vwaOLicr6zznxFWcZSN6C9GLuGDav6tSj9jAIVtmoeCMW/Bd6PsJCZhcOUVxN11AgbuFMcwkh3ACeJ33IACA4pQghj7GGNOsl85N/7qkg==
X-YMail-OSG: fWEW9dIVM1lx_9KXQDj5p090zluPSenh1omahxP8KddM9tkYKODE5FTpT4LGgh0
 hyYpy6jEnvK_otkrk_Gw0gQZSE2l2IUGEyVPPCRTTW3B1OsaCxkgLxgVm4JlJgIjgNCHIW0OG9s4
 wcE8IPytuWdIniKQzCr0soUF0UGJJF02vXXCHPASbD2pZdUicY_1JNhV7mDrslURdeEgWdkQTYBC
 BbjgG5ZSXK8pb0eoIt0R9NNQLhS.slY4UjivFhIRPfXDEssN41eGuCB4rNlNsKBVMDgtu1.6pDBw
 loycKdhUPvCxd8s0sS5Mh8W8FO22aOzYhPeoRso0DK.VgGZ.cc6vR4fBYQ6i2iNX2WXHMiy4TXpY
 sQh3.MafdGjsB8C59YsJrgdKxXDJtY_w14Izw2Q1yesHfoEHOVjddjI9W6QXxb4MZHE_.DLofd0d
 nNaHpjcKawceuboQkJL6dPTa3F_JabHxKgMb9wzfLusH5zOAaIgG7TQyH30x_BRbGQ8fnqt25fBX
 R7OG1q5FgXV6tKoxkoUklaG34nxYLU.d8Q.kFdo6UuvrHfWajAgK8WWPn7q_xD8AQxfBS7JSHwjE
 XzsuyzFr_P5fPgfozkP4z4m1mQirBuCRn5s4_2H934rswOO3B__rtaniUlS3KklESiM4qmgMc3fg
 6851V3PrVusfqr.bnzZvRIJS_tYT.801z_G62F13Tgg8AS5TQxiUUSNv46qKcwepZW9Wuv7Y7wp4
 4PoU25pBeYihOIuGy7YfOOd6zUsOfClxLie7MnpGSofkzmRB5034OJLdqCS0sCTDvuTt3sBAhMlG
 OKUYlrg3quWioOV3FCQMfkKi7E07mYwora.w7T7DO_HcZF6K7U0c1hh.U4dW2Q2lrnrem_zzRr3w
 7loXAPkhClvD3njAvtP8XksRNMWd6mrV1k37o2Gk7GrBhkhpJK_5iOms_ffcQq2t6gWX9IuVmaou
 nnVdzOBPuj6bI5J7i.ijaSaI4A_Xgd8RSnE9L00TXvhpCESlEUPHJIRaDPdm2_d9iiQ7pft.CCGN
 jEgMh_g9T_.SlpgYvoJT9skW4P286dcO.6xdMXKkb2JTGlGSgAljbf8jg_EMF8pHKwfIkqzD5GoB
 pGyCT9fnuA95r9AYzYA1ZOX7qqHm3qYjK4EYM21BjF55uLvf8qjmrAbD9kM15qBKvRwfb0sLajFS
 jdkTPFhXePUIAgAuRCcfuyvEHBbAhtLj1_3JO0vH0Y9dysxpmbei4qajwf1BtkzPRcCJUx7Uel1z
 Rk3tFt9DFynYdAQsO26FoEXGPfC0tq..SlFd.r9.3FAFvw2PQAwszuDKO8RlJrmq59amXq2SObSc
 joNKtCLmgXacB.MIUT1emLQHXaznH.L1xM.x7tj7vzpkdsglaDDaFijneB1Snh2BR0_Vfe3DvX9W
 lop4j0OQJUoicmYlDgFwq9zT4KiCD5kDyX6xn3_dBNLwj8O0CcxGMZvZmHIOXFA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 24 Dec 2019 23:22:00 +0000
Received: by smtp416.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID cbb1f47b4aa1c76f1688d5d651e30c9e;
          Tue, 24 Dec 2019 23:21:55 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v12 17/25] LSM: Use lsmcontext in security_inode_getsecctx
Date:   Tue, 24 Dec 2019 15:19:07 -0800
Message-Id: <20191224231915.7208-18-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224231915.7208-1-casey@schaufler-ca.com>
References: <20191224231915.7208-1-casey@schaufler-ca.com>
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
correct hook.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/nfsd/nfs4xdr.c        | 23 +++++++++--------------
 include/linux/security.h |  5 +++--
 security/security.c      | 13 +++++++++++--
 3 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index e20011281915..98d20178e60f 100644
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
 
@@ -2421,9 +2421,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	int err;
 	struct nfs4_acl *acl = NULL;
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
-	struct lsmcontext scaff; /* scaffolding */
-	void *context = NULL;
-	int contextlen;
+	struct lsmcontext context = { };
 #endif
 	bool contextsupport = false;
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
@@ -2481,7 +2479,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	     bmval0 & FATTR4_WORD0_SUPPORTED_ATTRS) {
 		if (exp->ex_flags & NFSEXP_SECURITY_LABEL)
 			err = security_inode_getsecctx(d_inode(dentry),
-						&context, &contextlen);
+						       &context);
 		else
 			err = -EOPNOTSUPP;
 		contextsupport = (err == 0);
@@ -2911,8 +2909,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 	if (bmval2 & FATTR4_WORD2_SECURITY_LABEL) {
-		status = nfsd4_encode_security_label(xdr, rqstp, context,
-								contextlen);
+		status = nfsd4_encode_security_label(xdr, rqstp, &context);
 		if (status)
 			goto out;
 	}
@@ -2924,10 +2921,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 
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
index a5eba06a9382..d0fab9f5dddf 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -537,7 +537,7 @@ void security_release_secctx(struct lsmcontext *cp);
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
-int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp);
 int security_locked_down(enum lockdown_reason what);
 #else /* CONFIG_SECURITY */
 
@@ -1362,7 +1362,8 @@ static inline int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32
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
index 8aa107b57af9..963641acf9dc 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2207,9 +2207,18 @@ int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
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

