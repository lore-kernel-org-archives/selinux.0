Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27864C32765
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C4322464
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Tc1XTJ+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfLPW10 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:27:26 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:42887
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727983AbfLPWZx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 17:25:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576535152; bh=IkTU4ebhP5bc/ZcCd8sps/OqKWvIBDoNVbjWD0Ij5Jc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Tc1XTJ+G18/ByfQnzVbveNsTl9lR+UvreyuU3N9LDh21ay1g0GMO0yIlw+ySh9O3OmQ2JMBpw+ZKyP89mDxPW3UvaSGC9dLUBhm93b+7eE+f1LOVQgr7fK5CDOsEE0nMGP1SfvAtPkpkGBcc+HAdMdqhUf85U3J2UsX1sxPYVEch83+uHHt+JaUDa4TETfrrcBpssXyFJbJP0+7mZzcVV5qdRrlvuXD5NFZc+X2O8OBK32+uWLaBaifgkeWi+eyqXoDG4z2Bb1WhNuIeHiQfGjGN9ZWBd3k0G7/qNvyevp0fqVySWtk9zsy9T9HinorIlnS5kTxaNBgecNA2HJ+6Ug==
X-YMail-OSG: 8q01Uq4VM1mgaZZ301sJwSKO1PgHdUqe8OvIZ93trCmKJcKv0v46kS7yu_LPrQ2
 feBltM.3i1XirWtjrYic50oek2ijFR8j7COaqKWS.VDhz9bmrh.7VYd30wvSUXjEq5e5S6eg4Un8
 HBRKNCR5n5tP6CwSG5W7QHM75jmbnuBr524uEhc9o4VxnMFAtAA9zB2Hg54iAcmIWAVu2YLfR8D2
 XEPHXLbEUgXekpt0M953s1s57OdUxi20a0MI48dafkzsosaV2VMMcabXSl1_1cdx4W2oU__IItlo
 5PD.OYorLdPgHcfiD3ltVa3WFZ8pS9KA4ovOVGbUT6gcqv7Fu10BB1hiJiStpDHwSpU3lBl_ugeJ
 _Tpq37b8cyRUZhDJ4nv9Y6HdmyJD.T8SaCxN7.yELc5VW4oE7GKvmJ2TXbsPMXMIviO_KaDgISZS
 y4kB_j1l4nAkqAKjN1NecN8SuBThdjCpsTOSjtQHCpjz.7uHiaI56WB69n6Rcuws3xYOdbCpcpvs
 Eii0H9et7u6Ohhb0TcVAuCWVHH2dp7aJOXyK3ZXwtN3DX2aQzBRh0J9REGZ0a6klbCEBpPWC9tlk
 PV5Jh59UTOoeQjkkvaBbT_CJVUUnWTcUKgWIz.j51JgDH_LZ7uyZKl_to5BdXeWThT_SqeUyrXAM
 4mMSZ6LvWPtVd8QS4TKYpGsWfSWI7v5i0Vh1yjngPIYyRQHQPxyPSa_h3ttDcZvlDB856F3ymTtn
 zNsqvOtufp0lPxkwrg0j2ziYwmG6cL2ipqfWRz1PzuwkgKwlC7x4FdNTAxy69pW_1a4OYoR_4uon
 aVb5fNL0zKzIoGlITOANJupyhPrjUoKfe54g4sWicERzpK_jnMzi6msf.IMSw4YsN3YDuwfxqaTf
 JgHpRdAYn_OEfweEMdoVmNDoLbY5I_KVc3m902Hfx.v2aXw5ekSaZUl1TBk0nQ6E0UcwxNHL_ivu
 WMAKxbK10ZtQ3Z7KO7RMrt7lepMhxRvL1FpuUHl8Iq95A4LLxgfbPF22UpDEunGwNwpb6X4Qrdza
 D1_4RIce5klrmTcKHFb6.KqLlC06yeiI6rkCj.JwOZ7qy9FVhk71rXpQS0SinkGTaca7JTyGCZIy
 ETDRh5ZKZuxpd_ga6RxXdlMuftKPzws75D6fG8zyZF991q7rEW_R2KpYPdasIki05u19WhQiDq81
 e.KBSEmb6pHsTlGIN7sQmVdnCpBcPAIzPvpMg9SNhkmparipEnRdahdackOEkVPY4907bT9LFIk_
 oLw9G0xfHw8ZkgklWT5r5TFhGrDm6vOZvIAgUuK7d80LI35Iy9FVOdIoSOm6FP_BXqBnnzJdgGKZ
 6Apz49uTIMzkgvoRuRvGf5sCImc9dCd5aObsdz_t2whfBiDCj4PkoWXDeH94tPNFTiSIJoXsEs3a
 lQDQLhPOnDX5oZnt9Bx2Qs9xJCO3cNPXbMmHLSjKbJlOUxDbxkuwrT3uvh1U7omU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Mon, 16 Dec 2019 22:25:52 +0000
Received: by smtp426.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ad449dcdff93ede6e1b6227b68a93c45;
          Mon, 16 Dec 2019 22:25:47 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v12 17/25] LSM: Use lsmcontext in security_inode_getsecctx
Date:   Mon, 16 Dec 2019 14:24:23 -0800
Message-Id: <20191216222431.4956-18-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216222431.4956-1-casey@schaufler-ca.com>
References: <20191216222431.4956-1-casey@schaufler-ca.com>
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

