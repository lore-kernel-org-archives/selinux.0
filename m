Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EB3C43603
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E9B21739
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Z+lGw5F+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfLPWh4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:37:56 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:33407
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727739AbfLPWh4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 17:37:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576535874; bh=IkTU4ebhP5bc/ZcCd8sps/OqKWvIBDoNVbjWD0Ij5Jc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Z+lGw5F+FzFFaR2tQoz4l00ZHEsGIPxLUzm0om89xknnIlde/HWYBEkZslTRrHBCnKUUvn2VS0bTmITDkXUg8jP28MeLq/h1s7rX2axtyv5ieFln2HBTXcr1bpPwsN2AoRPm7BPvXwfZr9XVh3LBCpNgrNGplw/GTQPPRqWixxEUuEDGH82k3dSG+yMcgP+uyG7aaialHZugxLuEVlwA2SOZxT5rZ3B86PiVwsuEkCN+F/VqoNm8CEpHAjhAOqlCu2bhXuNllb/Dd7Gcna4CIQNO8msFjCWQRcVTNEFSHWAmAr6IPs9Un84A/SOjRErLgjYi3i5yahU4KLf9hEtvxw==
X-YMail-OSG: 7VRsL2EVM1nFj2L_JBOz3scSbjcmnOpnOb3gSV7yKOS4Du7..Fp1lWzvOR_drhr
 JL_JgYtt8fPfPQ.Ohe7oswL61fvRs8KttT3hEYus7aGThRA3OEsdINo7SR7LUwA_UZrwFwuB_dst
 X0EMvBbAj27s8IqzQbe5vMyBko1MtpFIqnWtphoWq4omIAya4ZTjp3x7IAf494wWhYy20jyLZlGo
 6u5gYeHoCdj6YKGF3GZ4o78DRI9jLVmEpV8PFRf8UUfmKWYERzOraTvTcoSzRmOP04XtJIEwj0aR
 hgZxTUxlEvshwsHoJVj6rtbNQJs_xF5wnzHimp7AKDmqpQ1Z9R3yTBx4uewfIl0NsRsdXZ3FACpB
 G11dAkC0hazjIqQ.TusWZY4kDA9sHw2N2lmP_CkWTEticiKOl5DEES5k_E5TgtqEXi7trTVg4JZ7
 4qgO00UTLcf34mfKPNdS3Z.6V_sn.e91ksUdbwAKGT7yzYV8R1VNJiNtqXpCe9ToBOvWhqnv5OrQ
 YRPTVNEw7GyQSRsqx1WT56GfXTsUeB6gfSJ53bKqDS.GUxHcmvO9bIwiJcodExE_tNtR1zoRCSod
 M5UmNys3rvIvchH08K1NAcQ9egGahtzJxZY_JeWZd87Q1anJQT8ge2XdmDwQgWrZL4uwqQ5FXLSs
 AKmCxEmQvzDQdhe3GlaUzBNTh.3BmI0R9ATXvhL4BpmI0Ot7dUaZyM1rhRLZfc7cN0Xe_g63PH5R
 WVoECeUB.N0xTltrRgArBIWGlZHTG5CL8_x9831B4l.Q3UCnnSLCQWl2GvhkWJ7aqFvbm4Y9OQZS
 6uPyOEzyikxCTTJKQq4LI2Wa62zKXEpJkKuv7GNVksDM_06yRoUq4W1IitnA2iJj0izTcMQBvTSH
 k9IOey8CuD.697JFff.YQ1gFpEVd8ss9t8jpBzzmXnJMBaEMQhrhsstrPfIIBPVx1HrleMVUvGXa
 n5Xn1j0Kdf59_WK5hsqg6DKAO4B4unGk0SjUcWS2OeIFWY_mqsTzDz6eKunitYzdg5fdTOdaxCdu
 yNJjqU98u0ZZumqnwEjJ2rzW_054aOjSQChSNt8B_axek4u08EcCqUX8QHYZoh_i8zghEskdScgF
 WiNAaNUX6ugI_NUVlcspuTGYOPD5dm0E7fWUjAZY1tGuencGCvG_2CLSKnSGu6nIDf6M_tJ8Ft5J
 2OKz3hc7TcekfpPOmpIi1XYH6AaIghNzxwHsnbA6MTh0HVSgHyKAd51kNzBwXB9MmEW0JdA6NMUk
 lL2TgBBWFmHKAsOJ4wa3r4GuR5FBfb0tBsEDiCahsloKHAwdM4h_OZS8LHZQEuIhalG0jtqtZVLw
 9vgu_fbu2rJGyfmcUmDW6CU5k0kidPOfV4CX_y6lEt7yFybu.WMt3kzXDyzfgk9n4lfMiGYLt80a
 QwMAtsjbFIXowcWDLGwWYgo9OGYD_hsX0Xd0pZGCnV.L62mVyQbdFHwwMFX_hlbCZ3os-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 16 Dec 2019 22:37:54 +0000
Received: by smtp425.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8f9d0f9ff5e2996a72ce7cd8024969ae;
          Mon, 16 Dec 2019 22:37:53 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v12 17/25] LSM: Use lsmcontext in security_inode_getsecctx
Date:   Mon, 16 Dec 2019 14:36:13 -0800
Message-Id: <20191216223621.5127-18-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216223621.5127-1-casey@schaufler-ca.com>
References: <20191216223621.5127-1-casey@schaufler-ca.com>
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

