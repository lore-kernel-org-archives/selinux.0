Return-Path: <SRS0=XbfQ=AU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B38BC433E0
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 00:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2810F206DF
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 00:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="UC8ugaO0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgGIAfb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jul 2020 20:35:31 -0400
Received: from sonic312-28.consmr.mail.bf2.yahoo.com ([74.6.128.90]:40781 "EHLO
        sonic312-28.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726081AbgGIAfb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jul 2020 20:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1594254930; bh=5odXXWfDujk1XykObZE0dSWuSsTuVUHeUo+puGRAeTM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=UC8ugaO0lvgK0fSEB+FW4HVe4fyf54YCADx5SqbjR9ZU62u2CoEgrLTvg1mM+8euLWZToMwhQe0hDtUgbepQB50SfbDldgL++hWgnVQRDNRyLQLD3sW99uWuwO9j1FzEnnoAPFUWSZb729SxFcXdGElTLYOzDj3EwPUXaIct0iCnAN2b56uYWILpTqlRQ6atxKqtPnVq6SEU/UBgMvMJ0F+vTQE8tNe7a/TbfEehw92Yxo+QdatQFja/1zRNNHAet6GyIrZPYOH/vxnhNfmsl5t4VUHWu3e745Mku0eIy5WsrNdZiOAiQ1GutzuAzu64avCblXzyA2XXhLXYt+8/1w==
X-YMail-OSG: PLHXwcAVM1n1OSYzMMP.2ytXK_ki5i9iTgo7z_1pkA5PjUtMqXusY7g4z_6dZ17
 4qxzVJTYSmqjbG1dUOn5wEu8Xw7nkwtYpYpk0DDCd4QlVYdgnoWey0duF5WZGp4gYPq6iwtaVusB
 Ey3tEAXyLiatUJpIkdaYO3bGCHFGdTcTQRetS0HbrupJ3XoloHGQOSpsi22rko8DqH2PiThhZ_03
 D8R0cjG3x_Exfzct0PIu0VHJryoFQgI.52ZzxS7R_0dac4czAWczku3jd8lmYS_lUe1pV2LRz_9h
 EVYnangYMDNTN6XFO0tLA.bJ_6IdlA2fRy1R4OrlTu8DvisKX1bLb.r9BYvg2yjwK9HUG.86O0c8
 3Mx5SZXlWFTXHdFqk52dl92Tk5n32muzA8j06fCatqlXm9DP0BYZ_1fB5vddZpcZv.7Mq8QuBkEb
 4jJOnmRN1qZjqY0FgUKMHAQ8BVwoBaIvXpz_nDZ.WGBXHFQ44gHADQRJkXozF_Bsm1fxIiVNgbzr
 TtsX5xU9rNECh7N8MvgpHdpsOesD221RoC0omgKmYC4p3xysGFItWEUb3lzsWKDd2LKYBB1ZqorM
 yaPoja5W2L3Pdwu8yTDi9iyrbTcGBtlG0jOzcbaG_diyucYpHf7eREH5nAr_a2Xh7FaxjuQEuknT
 _sqnsdPU6jvMPGd.NpeA1UksOPeTgvH0MQLXPe1G2o4r7fpjIquUFKwT_EXEbG2JKgofMBtXgZQc
 LOHqDjO08MfTZgyIq4i9RasUBuE2fx3NeINxrWRa6avy2.T8RZHPYADCfJEyWu2Ckdf6MckJsyDY
 TZl_9kJJQ64ZGVYLjk_KWTJ7kkB_94N8Mme9mKoEo99_1h08qK1W5Y6K7VcDMadn_VRBIAp8.Z9t
 XHvtN70V0d3.VouiRJwFRO6gzcOdnZpDGd4kDrmuTnAGb6I7JdTBGW6oltp2FiXk7f_FE3138kLA
 fExq7Ls96.z0euRfqXzqeMSm8beqJcmhc9UXlYj39s5ocZh1EAgSwz0cEvh2eM90hCBQTxJo8Njo
 4R_bWc87Haxe_R73Vu2vAPWW4M_OGY.NeCbSo0TdqFfZg9vGxD8TxlQh5yU3knDB9laTo1mIthin
 LNS2_kcYVU3QxV65DkUazByVDzh_7YC2ntNkPNOheFik5Ijskvb9Q.fGfD9JL4bu3nuGgx96r.Cl
 4D5z32zHV_57vswjpv30s6KveeIUls3q5VryUjyW.pwYIKaWNKCi6lz23id4Kq7o304djqw3KDwm
 CyA6XD3_Yyil7QQeKjm.NwHyQiUEawTwyiPz1u3DZzBITb98f_Qw71nR5.9rJ7pEErVLs0fHS3w5
 gnxhfIUNiKsuT.4N8heoS431_BTGtyGXI90NCj_MEURkiAPw81oCMrElQePIjqPxOZcIbysMecec
 m8q2Jr8sL4XN5J0zijnJP25iUq5Z3Jo_9Y.4t1Iqx.oK233Mf.EdPr30yLX3S
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Thu, 9 Jul 2020 00:35:30 +0000
Received: by smtp421.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID a17d14f96312026ea6748a5f709f71e9;
          Thu, 09 Jul 2020 00:35:25 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v18 16/23] LSM: Use lsmcontext in security_inode_getsecctx
Date:   Wed,  8 Jul 2020 17:12:27 -0700
Message-Id: <20200709001234.9719-17-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200709001234.9719-1-casey@schaufler-ca.com>
References: <20200709001234.9719-1-casey@schaufler-ca.com>
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
index 84afa9c09217..d75ad048ffc9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2248,9 +2248,18 @@ int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
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

