Return-Path: <SRS0=Hma/=BD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFDFC433E0
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 20:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DDEA206D7
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 20:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RH+gIm2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgGXUuY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:50:24 -0400
Received: from sonic311-22.consmr.mail.bf2.yahoo.com ([74.6.131.196]:43935
        "EHLO sonic311-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726652AbgGXUuX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jul 2020 16:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1595623822; bh=8Cq4pwHn76JInmXbO/aBlXavf5Lvp53X1jdPy6OFczo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=RH+gIm2s7HANuJwD2LL6ZjRXhKmY85fLTg7d91ZC55raZe76asjr63gmNXmSaSh9xEE11WbvIIFAdCZkcxcHMNBVNQK+h3VxVP1tf+grItWTtuaknTmpTn10P18hfNDv+E0YPJnZOpVIbkwen+STnnmPBwty+X6J/myOXCkkClMjhmRwK97kHiajqWEIuD/wjrXqrh12uFA9TAmKBr/VsxtVTO+/YZhvetOdlu4GuHO1ZYmWjWifzlr2BBOf71OEAG2I9yiBgcuoZj4qEeMxsQ0mnI11rpaorIqekTDmGAuj/h+XxkvkQASWhJbHy1ToeYq2PPcZsr2yqIvzWPNJnQ==
X-YMail-OSG: 7N9tpWEVM1nbstJT7cnDTIcoObPKYvKTk.CdKWmXk9_8tfTA35znK0IeIj4Mb3_
 IRJfund9qwktTegmaIiQUKSP4vVh9k4KwiYw8fY9r9AS5dvOzJY7HyFlIsl8cK9W.eD5421.BZ5O
 TEgTJiFGEfcUobFfSKrwXlING3PEhGL6TWzGS_wXo3Z2vGrG5REyJrPL33fLD5l09xYzjiXLpEVw
 a0WxxXtx7KayAtxR8kN39YEaLU8mpBYoqADVtgE_aqnShLwNerGRcuiLWUtRGPz7qYkjLZPASgdm
 WQ_gQDp07KpMUb99QVOw5hl1Rreji.UBRupS_cWHkQblRN_GnKFyJMLdX.YN1bL4Erb5fLzlxN5g
 lAptx7b3HaUxQpm.22giVE.ZO_QyEq5sASrSBKFk7pYNMYQmKk_FbfFB84GXCc_PEUZwB3TSDYzH
 pBRhZ5pM0XzA3AQ5oV3xLTJhg5c.umXbGbWKhT.p2XUsbB39cE6F7deddXtlQZDcvwwJoTqXNXCf
 IY49xWrimUtjN.CHsTNh_zJPEvNBJ5ddv.PgPV3QfpC5MzGql9lpYy9XWYUQw5DRb76CXEPpye5E
 pIwzwcVrVvO6uRUnYBXCo2jbbrKgRLqKdCB49PKi5hLyP.IIAWuGvTSS4z4bcRizYnhV5zsHqUo8
 BxUyKC639cFkLcRj77karGm_jUX2wobvl1G47.CxIEc.hspXbRqrXZahG7v3GWuN47KGnvCFUowy
 p26QTXSnH0sTe3uLfPNriITTGwrhnrCA0XThhdvxcR0aNoc_klT3a1SjUaQhU8KQ8.ybgi8orcap
 6kMpUo1x.0jpF7v.d8RTUiMUX5PwVZ98dzW35AGDTBy0is59G6Dz4WWjzDS2dj3NNF_sHFgpBNiQ
 qqfSkEWt1YVvXPLqJOadgz7vztYYXYQ1a_95d8N2lpV6_9wShHsS4QPjm3_Ue.iczJ18vqS1jI9L
 2Y1uNWn2L9kPHxVEIKCu9txIRm6Q6BeNjGKSq.adWPYlfuG6lsHoMc5Bob54gcah8vapA7L3kb8z
 qvksMYOLzb1t6SjbpqIV7fJeksbI09eU.4gUcoEd1S8YxXE5NoHZux1YPxHxXa4.rryImugG9C5b
 YNPRP45OTc7A3gHDxMj1X1xPB34x5HdhiEPZb_yQIarEi_QZ0jG0rOlc0.SEBEhcerhenXQvFkKr
 i0cfZP8hz3mMwr1UtwE0V.MI29fFUzpQ3OstvNnhD7YSgcEMe_wGQE5YEebxlycHaTnNPkOXc6bG
 LxceRv9DV3VPPv7oRYK0IYCNAK_J78N.R0NVBhs7aCRiOJVam0bjwA08Bz95SOu.N419Tu6Kw8ex
 fjt8nGb9UCQpyhtEitMf_XDUgqTOmtODjBhRGIH2CLKuLnv9vXtEdBuNQHC.ArIOv9Er0rnXmJqX
 MMwk5BB0Op.ro7XaMacJ5YJYwMHtfr1mqjqJOpBcA9nKLwyOptRG91kFN5bEbY70-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Fri, 24 Jul 2020 20:50:22 +0000
Received: by smtp419.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 60c342417e9848f4eb43b1eee7277e1e;
          Fri, 24 Jul 2020 20:50:19 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v19 16/23] LSM: Use lsmcontext in security_inode_getsecctx
Date:   Fri, 24 Jul 2020 13:32:19 -0700
Message-Id: <20200724203226.16374-17-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200724203226.16374-1-casey@schaufler-ca.com>
References: <20200724203226.16374-1-casey@schaufler-ca.com>
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

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/nfsd/nfs4xdr.c        | 23 +++++++++--------------
 include/linux/security.h |  5 +++--
 security/security.c      | 13 +++++++++++--
 3 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 61d6b8a0e8f0..6673221d5606 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2379,11 +2379,11 @@ nfsd4_encode_layout_types(struct xdr_stream *xdr, u32 layout_types)
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
 
@@ -2393,13 +2393,13 @@ nfsd4_encode_security_label(struct xdr_stream *xdr, struct svc_rqst *rqstp,
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
 
@@ -2496,9 +2496,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
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
@@ -2556,7 +2554,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	     bmval0 & FATTR4_WORD0_SUPPORTED_ATTRS) {
 		if (exp->ex_flags & NFSEXP_SECURITY_LABEL)
 			err = security_inode_getsecctx(d_inode(dentry),
-						&context, &contextlen);
+						       &context);
 		else
 			err = -EOPNOTSUPP;
 		contextsupport = (err == 0);
@@ -2986,8 +2984,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 	if (bmval2 & FATTR4_WORD2_SECURITY_LABEL) {
-		status = nfsd4_encode_security_label(xdr, rqstp, context,
-								contextlen);
+		status = nfsd4_encode_security_label(xdr, rqstp, &context);
 		if (status)
 			goto out;
 	}
@@ -2999,10 +2996,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 
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
index 43f8a2660d37..02dc3b5ef57b 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -560,7 +560,7 @@ void security_release_secctx(struct lsmcontext *cp);
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
-int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp);
 int security_locked_down(enum lockdown_reason what);
 #else /* CONFIG_SECURITY */
 
@@ -1399,7 +1399,8 @@ static inline int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32
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
index 862f0bc2f114..ddbaf2073b02 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2263,9 +2263,18 @@ int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
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
2.24.1

