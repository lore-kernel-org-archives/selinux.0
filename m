Return-Path: <SRS0=npki=DT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6C9C433DF
	for <selinux@archiver.kernel.org>; Mon, 12 Oct 2020 20:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0453E208D5
	for <selinux@archiver.kernel.org>; Mon, 12 Oct 2020 20:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="nwPOw9E1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbgJLUgH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Oct 2020 16:36:07 -0400
Received: from sonic302-28.consmr.mail.ne1.yahoo.com ([66.163.186.154]:33319
        "EHLO sonic302-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726495AbgJLUgH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Oct 2020 16:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602534965; bh=MphzoCstMOx7+KUciSlR34T6uQ57/vlfXzf66hZ60Cc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=nwPOw9E1GHwLmaydP59HgHrJZYBIlLnrmJWKQ8jQBkzumOoQnHmcj61U/R0e7FRQh1fILezjfK3DQ8YTKB6wJq97tllV62tCRHq22v8jgAQL/X+Oglrf9MplLGMzJ0v+USk9iyzyC8PZQTbR03VOQz8CaSjqpGlIR4myebPrNDTWa2Q9oredyChzzv752dNfHWcUIc1vDRYr414EROTJrAVY1vOoarPhK01v++XebKDavvKXDKFAjjFGYJUBPxbu0B5TIkrKBOzcdMZC87ZOf+/lg9HsnF7ahp4J3dkDUPNUmpEmzbi7NnI98+9jRKFypAACbFgOlxfLcJBh/ykcNQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602534965; bh=kVCg/O5/0U749SrHWFz4Ixae7Wjz+dHM8W+srt+Cr/0=; h=From:To:Subject:Date; b=QB7VLJ0auzHazu8ACaQFJqczbkq+rx57JEbtFVy+TJenk2j62w4wNSF4HCpW5tXolzIy2U6eZql3xft8SLKzwEjKqKulCPyj/gIXHPckBqXLONYLKj3VvonWN6JFHZaKj0fNgeAcVZmf5Edx5/WZRp3M4Q0eXtjxbMmdUyqHVo+s/l9dFZ4Li66KgvO8DUhdJFWhoaluME2cuwCfYpO2NhHOrvT3L6W2PcSGnD3ZlDxfYqjDHaT1bX5nDnfoRT9Z5E1nDwxrSOSePbz1KCMrRAK9cR2AruLzPVB7Yg6SsTT+7EbnYRZ5P92y7SfyR/kfuXudSPiNxE6xd4WA7DI/Ng==
X-YMail-OSG: HhqcqSIVM1lrJ9CClI.B.ns.GA7crqyEdaaRb3u9n.Czbj8.r_B4A0qnrDQwzkY
 KBAhfvpQqMAJBDqZoWopv92GijoX_EaPYADePQZN5M4vXbHcGaupA2PoeaXjNvju.qzFvdgAAnoB
 3Qd18qqLpjFxIXK3VnxFcM._jKebKJ8IcHGJUMNw.I0ORPwGe9THs7jrM4Bqoiset3Q0LgXqMA2f
 Lr_ZrhBR_CXO6aKC07Mt1fpAiaTlGPBNuJMEUDjR92MfJRCB_bYUplJSH__s9MqRkBD5mI_.NG6H
 gP4KfaPeN8nYcFyMH9fS_54OMdWwjkvf9BAJlG6FtoMwn4Y96fCPsXnzw1uqfPxznfYpEigepm5w
 1sgo8TF.XxwxNSpuKANgDVONzcbh0pcenW3kTeXzetLrZ6TgLJaBa6v5l1LujK7dXlAE2uHHE7sz
 bQ1ZeTj5LYm5q07uAp.AyuwAxWQ.kGplGFD6IR18ryJItN.rKNAOpdaMMM7XEVD7V37HmOKlrw91
 P5EsHKVeCNsZXdX_G27CwLsrygZutPLWXbQ.5Av6sxTH8z7OjGdBTWNe_CQVLxcg_ZQORhz64Dwk
 U1aNAaizoTitUdZyq_nJpdlgNiKHsljo9ybuA.IpGoTuYzXPuJBM_JRO3Pvs9I5WR1P4HC51QJRY
 L63AjVVtjRE06uIq1wKUus6Xqd69G9Pza.5n1Bs2HWZB26Sq5SX.AFeRHNlXDhr6VzBjeJTJ6cHd
 E8ar4hFsprGS3PN7heDwrKXVnO5ODSHQQglatFwYI_PcCxvyIBPSOk6XaTHTkACsdljLQUFGD8gr
 1QVDhD9fDmDJO5fHMwFJ9tuzPjAUA.PfAZpHEgFtO5CF.usuUbdAAOvw5z5.fgOuUfNvLi.bAQsb
 L1DuZkudj547M50oXaPlTaSttDtprAMoQD5c9s6vw5pMSG8MI7KuBY.56pygJtHHInQc_T4Kcbk4
 ya_CqTd6j8._JX8qJA5A7pNRUcGWWW0zmNlTIarS0AB7.Eb6DLeFHGlw.UMY_c.aejuNM6rLQ1V5
 B8MBI8V3NkhrYSqHML2TnecaqguVC.SL16E4cOvsOxXPVz18ZMx5h_rVkJZA74od1tWDWOcnMvxI
 ssq.nukVNxFckxBjJiUlzY4w_OOiBV84Jhe_gFEw5ih79QgBZRzkiSp.vkmqatq9DkfsFPGw2kM2
 KYWoSVqgnu0JKGJRdWKp7nnWH0rDzhSAicaZV9bnCVErfi5xcP5.3cN.A5URNWNaw9llG2q8m2sM
 o2Sd.OaMR0mUUoCs7S32IQquEw4NXjIxA0vKWjz2_YiHcL6zdFMw5PrC_g0eL23QTInUVzrGrcSa
 k5Xxfko5rVrAPrXJ1uj7kiIOb0gKe.q5anotXYeisxrTm7UqNPnS.4m38hTo1vi1GlfUrr_O9xke
 dZ64dX63pC2N09oifIHf.tJ_UMQxj5EEpZg3_xoCYqba96VlCLc.fnrucQSOkIZqqUPjrQVeZLxn
 LvCQtri.HpaBLW1Y.TexoVIEQPpcuQyTc1eTCXxOx9znCd_tdSi0qaY9afwBgttg2YOWguVsaqEy
 .bygfMrOaACE6UxD.0DWOYZSKSSzblGqhMe5a0tQt8WYk8EQw3KWcRA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Mon, 12 Oct 2020 20:36:05 +0000
Received: by smtp405.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 1f969a116641fdc60ea411156bc6ad8a;
          Mon, 12 Oct 2020 20:35:59 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v21 15/23] LSM: Use lsmcontext in security_inode_getsecctx
Date:   Mon, 12 Oct 2020 13:19:16 -0700
Message-Id: <20201012201924.71463-16-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201012201924.71463-1-casey@schaufler-ca.com>
References: <20201012201924.71463-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the security_inode_getsecctx() interface to fill
a lsmcontext structure instead of data and length pointers.
This provides the information about which LSM created the
context so that security_release_secctx() can use the
correct hook.

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: Paul Moore <paul@paul-moore.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/nfsd/nfs4xdr.c        | 23 +++++++++--------------
 include/linux/security.h |  5 +++--
 security/security.c      | 13 +++++++++++--
 3 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 0fc505392728..9352c05f3086 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2600,11 +2600,11 @@ nfsd4_encode_layout_types(struct xdr_stream *xdr, u32 layout_types)
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
 
@@ -2614,13 +2614,13 @@ nfsd4_encode_security_label(struct xdr_stream *xdr, struct svc_rqst *rqstp,
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
 
@@ -2717,9 +2717,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
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
@@ -2777,7 +2775,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	     bmval0 & FATTR4_WORD0_SUPPORTED_ATTRS) {
 		if (exp->ex_flags & NFSEXP_SECURITY_LABEL)
 			err = security_inode_getsecctx(d_inode(dentry),
-						&context, &contextlen);
+						       &context);
 		else
 			err = -EOPNOTSUPP;
 		contextsupport = (err == 0);
@@ -3207,8 +3205,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 	if (bmval2 & FATTR4_WORD2_SECURITY_LABEL) {
-		status = nfsd4_encode_security_label(xdr, rqstp, context,
-								contextlen);
+		status = nfsd4_encode_security_label(xdr, rqstp, &context);
 		if (status)
 			goto out;
 	}
@@ -3229,10 +3226,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 
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
index 6ddfad740277..b845de9a4aad 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -561,7 +561,7 @@ void security_release_secctx(struct lsmcontext *cp);
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
-int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp);
 int security_locked_down(enum lockdown_reason what);
 #else /* CONFIG_SECURITY */
 
@@ -1400,7 +1400,8 @@ static inline int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32
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
index 32c66a74ca15..022af5ae8525 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2265,9 +2265,18 @@ int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
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

