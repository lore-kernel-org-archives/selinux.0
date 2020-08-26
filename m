Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52440C433E1
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 15:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2605D2078D
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 15:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="OmkD335z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgHZPTM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:19:12 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com ([66.163.186.211]:40946
        "EHLO sonic310-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727846AbgHZPTM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 11:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1598455150; bh=iAdh/v7HVDtw1Vy+wLE/amfgBB3naUOJTo0HTDKJ/SU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=OmkD335zJLHo7S+MvbiKerTezBapFyHtLuHrWqtJ04xwSq6XN4C6aPx4wq+0OINToLxA69AJ+UTuWW4PmG9sXSUvcIhfv+JHKGgK49IyjqRqS6yFV6tGs0QlZuBK7Wkau9qQNQG+s+tpfwdy4X09KTIFvppLjkSlLXc2k6EeLDWTV3PEwSJ0zQSmJUgf56JrxVmt0YSAe/0iyQ23eCa5/XOgEmzPqYS8XD0XXaW4GxRntaXUecsGTO5w5N+eAsjxRI1LCsCIe/gZus8bXhH2nJHzt/X4B58P4XOthhjjwrb2f9cr0iUmtmdskHq2H1LzGGDvwllbp0VvthECo1i7Gg==
X-YMail-OSG: O8B5IdMVM1mqyuSkXaQ2DybSWA3z4bkQrhr_4b3UW8.SXBXEpGn4DHUpYTslrxU
 wTcCxO8YQXKbDB3QEcJvPw0tG5ZaaRcKtdbGtBC6_fkO1rx8fmLQTBWHo2LQ1RkkP7t6g7S.Ze_j
 HafLBtbdaQSiAHaGIyxeE8A.IqPmc4HbB8Eb12X9SZ5YUWO4OiXgrpAlAnOg.3TJpeTuJDDXRrtM
 gS.Y9w75tphGxQPWsKI.5jEv6b24Ogamd_D2lmGvoqgXI_0fFdvBYE7biK.oDieNyS64UVdSJCl5
 x57lSomT32bZct3SWjJHZmZPY1g.bGBkdMEWHYCf.fhHyQW5kKYHxSwmx1kDJ3iK4ZEfxPtLJ08d
 _O3uvI_h9WffwL0EW5PWd84yvS8leqQOTR6rGks1tyl3_634._TyMUGDDxocOguDtKeppmYML2Uz
 KimZyqXbr0p69olsMo7vzLmwamTkPf0ar.94N5orkMANxv.Syg2FAvEMQcOBn3IgMkGrzEEGizWu
 _qwpCacVHbKq8WonSAgwP5JzsuZWxuIdYudL9.0bbhMlaXxelvO_CttN26NA2P18Bu6SFY6dlFs8
 sTpolU7gr.gr6IUPJmOxR0z_uHZA2HLX3cWF5PPPjZyzJYlIJLvNq2KhAIJjS3HF_hOsi.fPoEFq
 7XVbelPMQTfhiv8V8LBR3ULxq_zq2LQCmsATF8..Krxr54X6xZElxfh0PqvNZ6pjOyH0dkovuUYr
 8HezKWczhZSkQ31jtu93WnjymDBr_d_JHdJT9tR3ePSxnhno2_2qEQhMPKlPEqcFWhmfhwhtvfrX
 .C.AkWODGQPCO8LJwkJv7M8m5XzYR0HPrPUrvScUfnNpGrpa8M52VhDUmSEYA22dg3Bn9tU1wxuk
 st2gK3dWx1qDr23TX0dc5kV6Mk6YBHPi9Y4t5fgrn8bpxRCCDq1i.2YxR7SIAEZJ_HAVXXIpwaFJ
 vY3viBcc1FD6HnY4wvnVBI7QeEXqgHA5jwfWS70wMV5A5X_7LxGdtIQ2nRMmbVdJf9G_I.64ojEa
 JVVrZ4c75OZU_sUGCIzu6M43H_JD35g6LTus_DOKCEaq5ujLcGHc5.W4_SXmx2hbOGihwGJ3DmcB
 vaN_TtTMmaKIS_pRSmxT7xYmi02twwPP4c9Uw4k9rwyrwIVxH74ZuS.cXdrQwT5Rj2oR4OH_r45q
 dNCyIeVY1QBXx9vXcz69.lAfRuo2Xa5NCmSOPmwtdxTBmFNQmbHcbSnFW85DZ.I9esUFrwY1FZ0S
 VQurSwRGZzbCkltpJsdfOMQzPK1cTGSH85gulXAHtMVn0jWVg_Dcey0N6NehDsNeVl0k4YSblJoD
 7OHYwzQ6f9Sg1ZO8oeVjK.jFhl1mfrSwMWbOE1Jjr8LeHr_QsPlibgGUAe.VYDc.bn0TflJ0n0BF
 OsHsK7AoV9rhlBIr6dtWVH9Y_khQ3Hm9YYH4a1Kuncc8wiA032jqtQ1DaxCrqEBqAVYdACuPcXa2
 Zp6VXU6KrkmZ9kEC_P8_OUtElL30Z1IhE1ZNif7CQs5PoLSNAhmLPI8Frg2BArHIaK9IOp6GwZmD
 EvFxtilNpydc1JNOL8WASR2P5nL9.jT4Ed8vDefnxovL3dw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 26 Aug 2020 15:19:10 +0000
Received: by smtp415.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 1377ee3152b6b6d6b3fb26df43faf948;
          Wed, 26 Aug 2020 15:19:06 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v20 16/23] LSM: Use lsmcontext in security_inode_getsecctx
Date:   Wed, 26 Aug 2020 07:52:40 -0700
Message-Id: <20200826145247.10029-17-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200826145247.10029-1-casey@schaufler-ca.com>
References: <20200826145247.10029-1-casey@schaufler-ca.com>
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
index de6b44751dee..40260bfc3a0d 100644
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

