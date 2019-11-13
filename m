Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9337EC432C3
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 17:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80581206CB
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 17:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="M0qjUq3z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbfKMR65 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:58:57 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:40808
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728183AbfKMR65 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Nov 2019 12:58:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573667935; bh=lhTgPrS1AxEQQsS/aZNag9ZpvOFAt3OZRx3VSKnEQPU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=M0qjUq3zR25/z8UDyj4BINW88azSanaMVhiBlAUqW9p2m8yRXmvOmFzudYCwHT7RF8eQO8L9FoOHx/SWWXHegElF/DLRkWCnEKxMTPn2SqKXRwAJUcfz9eyod420+TbBGT2jKa1RNHlfpw2uDqMQ05Iw7EZ+vN1AgEB6n2+Y2ngcVNuaY1I8PiWl3WFNq5uCPnRQDRQgIsRpzKkSj3kjleFuMwgJdHgOOLCdVDidgP+XqiDMJy0HbA8cj5+MeYmh9n6ULvxgIHDQeLVHdGhlyR2BgrbFSAUwG2/QUM/rAM5HHfZ5Zc3ZA93ivYYLVV6aH/Io2Ibhpqsq/6/xiYCvlg==
X-YMail-OSG: Q9HcQCsVM1n8IzogJ0vl1wT8uX2dYAJQeR8q4y31cZOl1.12fEvazbGNYcS3idS
 ZIUdwsFYfgDTgwq5o2nXmLZMkElQn.HvuqerfzDSxaeiD4dBBp01W.JEwabRTmL2Y.Cu_P9UQq6I
 RNf6fp00ImEJ_YusSSJ0DqCta_yNRo3jYRgKuUmzbIaIYPMgCJwFfPG2dT_u_makMvXN5ZJtRinq
 6asX_IcVW.e9srTFRnIm767AEWwQSGijdfSYU2UqongeBMaPISC1Z7mnSbyhGsFEpoOQ3YQzKnF4
 ulKbPJnmv4WJhjG4bijShq3kO.1ORIeRAY0OSfQEkgXSuntEp0cHg2VcN_yL7NSo8ivk2UxSOMxx
 sb1OaUbYv7qwS0Qzm.s82YK2eUMujbatSsbksS91PeP5dsH31DN_csSqMlpltbKJypmhRQbOnC92
 a9N6WiFe4DzeblnnDZp8E67hDuF..SZ.773udDa5YeOyuywGS9EA0T85TGModOZ4AQAPrpKU9hUB
 1zQ25h7PCMQoo3oOTLyTHTpTgnNlCPXMzdHn0UdXWNq.2Uyw5jFmnxzKomQkeFjzuvb2MTm_xyEQ
 .JAsdZpdaIDC0LOBs86x3XWS.cL.YlHR3eWGRW9JUUnJJxKaq6mEukSmMFykOlxQIc2LJ1xHskPv
 P3u6tdHC.eWx.zKjAcDWBm4nzsV.eYsydR9Aa83ru15jQlb2ZdHI7Y0owGL.dHKvId_32CGOxTGO
 JAESkt_I_hHLu9rqm_T3YOrHGtqAQHL6FUOXii9naMScYyzAmPqO9gPZ.ix8lBkD.FpxYuqK4oHQ
 QvTef6.9tvA7DJi7rL664CzUnE558EsSFPpAtTWAULrH.oLkrrTiW9kDoTTXPmo7U2pee3n18AdU
 Fh0Olkdd8vIG_UowJor92b.JVoun98h_O15ucawVRiOcNXcWGpPyXCaqYUOaHP90ucZTjhzQFe4C
 K03wUdtXPUztZLGkAVwhuPgktI5qyCeMxG8f5uBDyE_ZdzDX3OmUsuXkLsUZg5bNjmJ8s5o1Z4e.
 5GOsROL6dTK5Me77q4OA3a3UPmpI3xArN.cx.D1MTnikMVCHxO09lPAGBKzpAc63pWq9.68aO2IN
 Wh5x2.pJTPRwjEevilPnnG7Apq1sUd6hT8J.xvMKYX8K4JHLucsdQCOYdcSCamjIM7rXt2dwiI.U
 XSFRT6Pnswt2e2ckx1jdZ4_dQdwvLaJTkxrtZMnBRtcOwHbgM980bupExYtWbxTmbb4lzAUbCR21
 mz4RRUvYtPJJHpiz1pOoPGjYrYBDupdJ1CTJpyJSxTb_XigJQY0RBLsxeJhRbXJWYG_JQQTgYzVE
 _eYaRpyDwlR6HzXFxyF6XR_HlikEx83_ScZnoApda9_iBUsf1GcktX3AqnfEZPFbPcqrRavwAyI_
 RxymU.SJsG8vKpW.mo49_UKWt0gcXnHlZw6G3jlMjwV.4AjjKyvzJvMvA154y
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 17:58:55 +0000
Received: by smtp417.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 1cea930ac777c9304573db67db0c3ad6;
          Wed, 13 Nov 2019 17:58:54 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v11 17/25] LSM: Use lsmcontext in security_inode_getsecctx
Date:   Wed, 13 Nov 2019 09:57:13 -0800
Message-Id: <20191113175721.2317-18-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113175721.2317-1-casey@schaufler-ca.com>
References: <20191113175721.2317-1-casey@schaufler-ca.com>
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
index b17aad082bde..3e90d7c55c74 100644
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
index 3e333104720d..5da16f97f2be 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -535,7 +535,7 @@ void security_release_secctx(struct lsmcontext *cp);
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
-int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp);
 int security_locked_down(enum lockdown_reason what);
 #else /* CONFIG_SECURITY */
 
@@ -1360,7 +1360,8 @@ static inline int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32
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
index 6f43dafe1249..101063b00aeb 100644
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

