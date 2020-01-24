Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031EEC35240
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 00:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68C92087E
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 00:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="a4JPyBmY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbgAXAZy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Jan 2020 19:25:54 -0500
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:41372
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729690AbgAXAZy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Jan 2020 19:25:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1579825552; bh=vJqgCjIqmAa6l5Qj3Nspn+XKPoD3RLjhS2Uvr/qQK1Q=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=a4JPyBmYjDEWNvowUZO3mxOzLMbU+JYqlgNaogl3oXIJ+C7FSrw4eRyDSmxzmlwLTHiWn+DB3JeaaUEq9WfAVmqmlTf8wrfbRG86s0NgTccyKByz+aCtjctTCSqSHAC+Bs5wcS2/EQA5BC9KPlXBeQhs6qdzmc36Mzs760XKGOpfY/RQXB+rzpGLwAoN35rucXnP230ELMYPfECa8byeUcStLf1HqcdYQjKtMFWFNWclegykPqzRpKIy69iZc19uwuxHFZOVmYq40PcL2lYbxIj5gGY3dxrzFv/IK/RIzug0vIYUmGYXeoRwkxPAztm4oXPhsfhWjyXR+WU0LpJ/aQ==
X-YMail-OSG: 3ffwoWEVM1mz1TiXAD38i0R0zCu4kDkDO7Ekb1TcVPe20vFRSnvLvB.4Vq338L3
 XqOtQSTrJ7lbfx5ynkFbZ7HHe1RDJngWYCPOFzqRj1p4SzG4lIIXUt2yoe1aFsDR22kk80caz7Px
 2FJmFAK.N6G6qTtuUcUF794iX3eANm_lo6Sle2n6k2vY4U22aGX3OIjnvi9dj7Ptp_pX6GQ0mPUl
 EsasYWBQLcM6yXfczTbFCX5Oyang3Jk22ubYT51.B_edKUnFUyQjyf4MT8TwD8koUrVLAJyOkM3y
 mnUr.QpDfEUlT2m_EtkVBMiw_Ewh7FfU5kyGa0TtyCzKATBN2ZAd6Byrappuabd17LwUPOKQEY60
 bsZxLsxVG3dgwyf80LmqZxJO7DkpxErR19VnNRRKkMwqivB400OExeEAvcVjGYxPz0pU45CKkMXg
 nfyK9IxohpEotbYvEhAQcKqPfuupPuyzsbNlxowhDURrI28bEosspIIpWMjKsMhiECa.DpzGOTm8
 gv7MzCxDXLSlFWLKdrEp90s9uS_bmFFb6uHCQprIlBFlCk55Cgc4Khpkx7aCwzObjVv2GM6QD1Ly
 5ECl7SnSwBsWnzuptBmbYjWD19E0Du_YU_zOJWuR3.gnqoeY_pkZHGQ_4zCgHl9hpkCflGkNDTkE
 r250033zh_Vwy_u0aRvqBt81vRBGc3ur1oY8za.3CLiVFfkSKFS81nNqRT.4R25zZHkxwTe6Oaw5
 i9dJhbadL74awwjQB7D1sz6LnRqbA2tc952t_a6YfmCJ5i9FedzxUI28BcOhN.iS_yqKqLW_VTpy
 ItibY_P.VNFHlFPKvAqa9aytU13fBJc9AkN53Fb.NYDEa.yOzH30x6k0VDx79gondf3kkK4MLhei
 rQJPeHYJdGAs9VOOdoP7q2hsznXPXAmRApTgFaz9VRKhpnTgEimgtsgSLojC4VpyXK0ppNDvhIi1
 Q3AfL6H08VVI.QIg7yTsbk0.wkKgVTpXB_2nM3jY0ZgOBs3sO7gKGUYAi2UBevPbpy8eVhz2rx0y
 VbaB25dXm5Kt6UYFeoBpEwd5XyKxn98vW52x7EpgeJ2RnkSPF9QoIRE.SldWAkiKr0ZmoYHrgLrn
 .OfAxdGOl8damJCwpkytUSWU3SKpWEbouTSkED_j1.WZ3t3aAHNHd8KooMFnRYVPyApoQjscVZlb
 PPv3DxBUh6FdOy7a1YRDaXqhgXtpbY4yrMi42gkleUEu4JDO4LqBcVrfgpn8TQ8x6MLUGFxanEnk
 sBFNs5Isy.9TS2421gd1Kn1fcYElbUfQgJUqCn9enTveX8AA1evLaj1P9YY2C96lPjG3Q2igTsb6
 ACU4zzWemqkGNenvFDP9u9.RM8NSM6U6CtFXGdb6MSQEqO2pzbeBBmSK4kbtv9m7cNXkubTgYelJ
 iUr6Xu0bWQTmB7CAQsheO.Nv4_FmdA.0gS7aLRAT0x0pLolmHnPRTcNx_hL9Z
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Jan 2020 00:25:52 +0000
Received: by smtp412.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 41a84560f838fac6611e7b28424c2970;
          Fri, 24 Jan 2020 00:25:50 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v14 16/23] LSM: Use lsmcontext in security_inode_getsecctx
Date:   Thu, 23 Jan 2020 16:22:59 -0800
Message-Id: <20200124002306.3552-17-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124002306.3552-1-casey@schaufler-ca.com>
References: <20200124002306.3552-1-casey@schaufler-ca.com>
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
index 1e817130c112..f1a6c9ba907f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -533,7 +533,7 @@ void security_release_secctx(struct lsmcontext *cp);
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
-int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp);
 int security_locked_down(enum lockdown_reason what);
 #else /* CONFIG_SECURITY */
 
@@ -1359,7 +1359,8 @@ static inline int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32
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
index 24e99716f6f2..c2e5350e0f63 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2179,9 +2179,18 @@ int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
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

