Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E5CC432C3
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 18:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D47206E1
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 18:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Nep02QOt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfKMSU7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Nov 2019 13:20:59 -0500
Received: from sonic315-26.consmr.mail.ne1.yahoo.com ([66.163.190.152]:33990
        "EHLO sonic315-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728325AbfKMSU7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Nov 2019 13:20:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573669257; bh=lhTgPrS1AxEQQsS/aZNag9ZpvOFAt3OZRx3VSKnEQPU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Nep02QOtYXw0OgCyBPiCHdUSAZi6fCkCiCu42bKbFDrNE8AhO/64DGw//9TZuFtqBkbLZqdNh6WxaxVJ4FBvnx25R5DwtThZXUXWuUyx21E85PD7zEcgekhqEDo/v5Bmd7jCt8ssNJxs9qG1d1dxOhc4fmSBXB3tYemS30Tss4Rd+NI6o+AzEbx+UFfBVKjBNSSc0sa8gdLdzFFeU6ZRP/xuSpkGZQ6lJGtPyJmPAWPYaGxI3og3qpHFCiDiCuGF9eDk/MCICCx5+UnoLMhjRWfHFRo0SHU2dp4CDMGOPFXZ4+wD51i3aaMrLhNcEP+2vvYURTaUa0ZNmbTjX/22rA==
X-YMail-OSG: FsqOttIVM1n.ILOAJeOCF3Ki9Pq_OhnEA597J85Ft75uAxnMrsAdkPMplmyDSbH
 KxoGnECw2M8buHz5gRMKNsrIVHYCreBq1fmkymkS7vzwb65G0zFnd7dRnNkAKMO23mEet2orOflL
 62rqSAmddbE2st2nKCd6xLfaWY0JyTJzHoXVoWtu.TckHY4YDE1wb72_BNYe1QfieoyIMn9R88jn
 iFVuQqil_N971qRFzZKjtQ7FwFTN7d8Yxmp0DNKHHWQodS6AngKgZD83eYt7_7wTC3A_8t1worxc
 ApqbafmAlVpq5vgqoSK4QXNIpvISwnP4Ikca3QYQFSx6o89MkUqTCi1m2W_Tx.yxpvaVYiRhvF7i
 7lX3t4wO1uJ6cQg0vd3_BZYWBZrd5hqgHdt6NpRIBpxpvajBgUqUAqC0SYIdPYy14aXiuIXz03dp
 9h5iIlOVwhWssOq2DaTDdB6gUBuHu2Pdv7ZCAD0pez12d_KEYVlYUzBY.Dw61aHVmsR16Xfg8LYM
 C0ydbvt39tvqje.d_kLB6V1Rqh1hOIx3NunAe1nTLYXcg_oBv8ORNxHRM1r_F.iyjgtMw1iW5hDh
 1DfRJ2Q4PzTetzz.SRcdmDs2A3GQMaYmDPt98CnDYvjuFF7_xvVpcWtW9PClT.oXbm8EMpkflpYc
 QUjd93Rw2IIVTPY9TcSL0MhV4hUatDEs4db0O1agjhEZCwLO.9oLlMG6fQ5w9hAe57Hgf1nqQ3sY
 .ZK0o.G7jsJOg_eQ0ASn1CIDTzygcXn7c5d_JvvQns1xaT9X8jT6SLdHGwE051V9xkuMX9UayRfB
 ZGpPtyayGebaZ0ULvS8d0BflzjnrdBdIjWmAO5K_YZ43GTNKWWAsywn4rQSrO6Xw8lV7VqPHorPH
 Rgbe188nJtOfgv5QK5R0vEkiX.Jkg7AEdyXW8ojsrMgyo33QwO3M14G7NR4yn18g54ll.uOHIoN6
 cVyG8KQkbxXw8S_O3GhDQyepLfa2cx1RLmIolYvpyriaNUrZ8VYqAhKX0pSmu9O0zskTtD3N2Wop
 daGagXhEIneEe8O6jBqFhMP4XuRMScxjzjVT12RmEvx2jZzb_kgzm0o2R.Ih3C3WoLNf.pJA0MDk
 ndf39cMZdkts2f.2SEepRyefurS0doozFKDvkOIh9sVC0lA.dYAcvCSzXCWmpbOgx8IbEIxCMWmv
 778HDA2OXJnJZu58LBs.NUhtEoloXdGJkgJ1ohVeeZMz3QHajP4VL1UZOz5MSM3s7dKwau4C8gCA
 1sHGB55O.i020cgm.jvytjZ75tiqyPqTje_pUBDyjNInFzi5Ype7ENv0AUWS6pIMe_EmIFmjQ7Wv
 dK0cfoSdt83dGg.gyulkB512.U5MhbCmChrmZq3CnrYflyF6jclJoPcq6MWRcZJwstGW3b.glXoi
 ljYjK7W.5bSL6s4r6RArQwh15_yZ82Tvq9rMOY2PHFYhD2GhXLishQQdCbvAER7optcQ-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 18:20:57 +0000
Received: by smtp405.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2a1c85ac4bdbf5da4ba3fd738885b7e0;
          Wed, 13 Nov 2019 18:20:53 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v11 17/25] LSM: Use lsmcontext in security_inode_getsecctx
Date:   Wed, 13 Nov 2019 10:19:17 -0800
Message-Id: <20191113181925.2437-18-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113181925.2437-1-casey@schaufler-ca.com>
References: <20191113181925.2437-1-casey@schaufler-ca.com>
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

