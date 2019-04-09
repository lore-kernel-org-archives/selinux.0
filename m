Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CE3C282DE
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044BC2082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="EdesAauv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfDIVlO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:41:14 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:38854
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726805AbfDIVlN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846072; bh=zegT0UV/a0mEisN0gB9wl+y3EnZt90kYI1JdG3iO73s=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=EdesAauvk2Frv0XUrpbbX3ef001ZitkimtefsApJ80NoYa3teQqhoB8p1WOLwvO5zlkdDQ9ruY9u6dOUQpPe1EUzo1/WI5+pLZRe09ml47FwJkIIlxibIIbPtyAS0b070+lpm29pX2Tn84hg2fRUzenLYUsFOCv3R3+KbtzdX9Azvd3jxJZoaNLY7PL2UY7wALVmXT7CUd1wQBqAVBsbm5N1+50uuTbsXUOPZq4SNSBkKl+iT99b0S0K5nssY+qtAmL6JqiQKnHINii8rkRBOk4nUOTtiFkgCdByG4NA2tI1WtDILDaG/fZPgRR4dMOpbEDpC0zUQMhbifWwFVTwtg==
X-YMail-OSG: Mk0DgHkVM1nep.GQenxF8bOlYB17uKcHdPQUY0xEIH0TIcm5jIbfV14gZ0hhw.B
 924YoYL6padftpQJ_bPD5uMYMjQe9HVQtYXgbQIuxWhVBNwCTxnLePRm_i5xIks02aN.uNIKy8uM
 8SXkbM2wCgPTk7VnpIXVtPaztsphzwhb5vEfMIljsFuf3K3rtrfzcpzf6k1mGY0esTPU9zrTL5T5
 V_dzEWoWfvwKMYabL7m84rgFo_80x8J3vhLy612YS9RyWgxvr3HsE4jOPeQf4udvb45BT2klQsAT
 246pAfYp1o_U3xO3hskMvADNcCQAmoCwHPcldm3UNJ7odOA04PV8fVJ6TopyLINoEhs_mjAaSWlC
 c99uB_Qt1wQ5mING_tz3PdFrhjgiRkoB9V7QVanHFaLofVb0H2OWqBJfs4Tic.opc1VODz5GRyUe
 mIMrOgAQGmqjo15Izxgv1yboyz5v5BBck2pbowcbRlD5LL3ykPHn0MkaSE_ujQSMgYCrC4qFPsAA
 48LzyAXk3MYMkN1wsVekEfAhrana4aBRjqEnyq5HYpdXO5olYATvhslfqBwulKHjEklyQk_.jAF0
 UL_4gf6LiPNy2xAycwYD1VySIce4QpGJQtCzPvRhMmDm.MilXLZhnbLci.vXb13N3AtkI7gYNlQJ
 0MUWQT2EosugJrh_jFU0jRR_G.a1nWRNdhjX4JkXkcm6.qm7W_mmOerANp.P1vMomDGAXmIjWR91
 vyDchnugU6xb4P2EiN17LgaG5qvULWdBYw0m.NVufBFDPW7jYcwQhLLoIL2XoPgMT2cQc.Lt0M9V
 .JpgFM__.eawYFHfWgeunXZuFG7ppBJCgGcm7rG.3YLqRV4goFJ1WP4Mk0ylx8zk8LNDYrXrZwOA
 kPhdd7xsLHVoP.DwBR4rU.pmfmCo_TI5p1hGu2kaUnTBHkQfunmJKiuRtYzm.z6l2aev3dGWn_Zg
 22TxMESN0ra_PPmqIhTPysAATETACaSvofl0.pQZ3wCndkjicGDYSOpGUw5BumrMc0HkgNV6eJAS
 hdz36ungf_Bwbra3Q_wlUKNK4B98789ED1rnKFd9zi7pfJSgaezJB4Mu8Oa2R7i.CZ5N.SvMh2NB
 a0wek9U5CZlFi5uhQgECxIxM2AK_ecyM5gNE4r8a4ss4lO4qtwbPtzudY.L7stg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:41:12 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp427.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 909a163ce0f03793fff6be9a79785446;
          Tue, 09 Apr 2019 21:41:09 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 45/59] LSM: Use lsm_context in security_inode_getsecctx
Date:   Tue,  9 Apr 2019 14:39:32 -0700
Message-Id: <20190409213946.1667-46-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Casey Schaufler <cschaufler@schaufler-ca.com>

Convert security_inode_getsecctx to use the lsm_context structure
instead of a context/secid pair. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/kernfs/inode.c        | 11 +++++------
 fs/nfsd/nfs4xdr.c        | 14 ++++++--------
 include/linux/security.h |  5 +++--
 security/security.c      | 11 ++---------
 4 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 460e611b1938..41c5afc698fc 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -351,8 +351,7 @@ static int kernfs_security_xattr_set(const struct xattr_handler *handler,
 {
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_iattrs *attrs;
-	void *secdata;
-	u32 secdata_len = 0;
+	struct lsm_context lc = { .context = NULL, .len = 0, };
 	int error;
 
 	attrs = kernfs_iattrs(kn);
@@ -362,16 +361,16 @@ static int kernfs_security_xattr_set(const struct xattr_handler *handler,
 	error = security_inode_setsecurity(inode, suffix, value, size, flags);
 	if (error)
 		return error;
-	error = security_inode_getsecctx(inode, &secdata, &secdata_len);
+	error = security_inode_getsecctx(inode, &lc);
 	if (error)
 		return error;
 
 	mutex_lock(&kernfs_mutex);
-	error = kernfs_node_setsecdata(attrs, &secdata, &secdata_len);
+	error = kernfs_node_setsecdata(attrs, (void **)&lc.context, &lc.len);
 	mutex_unlock(&kernfs_mutex);
 
-	if (secdata)
-		security_release_secctx(secdata, secdata_len);
+	if (lc.context)
+		security_release_secctx(lc.context, lc.len);
 	return error;
 }
 
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 3de42a729093..1bf34730d054 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2420,8 +2420,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	__be32 status;
 	int err;
 	struct nfs4_acl *acl = NULL;
-	void *context = NULL;
-	int contextlen;
+	struct lsm_context lc = { .context = NULL, .len = 0, };
 	bool contextsupport = false;
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
 	u32 minorversion = resp->cstate.minorversion;
@@ -2477,8 +2476,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	if ((bmval2 & FATTR4_WORD2_SECURITY_LABEL) ||
 	     bmval0 & FATTR4_WORD0_SUPPORTED_ATTRS) {
 		if (exp->ex_flags & NFSEXP_SECURITY_LABEL)
-			err = security_inode_getsecctx(d_inode(dentry),
-						&context, &contextlen);
+			err = security_inode_getsecctx(d_inode(dentry), &lc);
 		else
 			err = -EOPNOTSUPP;
 		contextsupport = (err == 0);
@@ -2907,8 +2905,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	}
 
 	if (bmval2 & FATTR4_WORD2_SECURITY_LABEL) {
-		status = nfsd4_encode_security_label(xdr, rqstp, context,
-								contextlen);
+		status = nfsd4_encode_security_label(xdr, rqstp, lc.context,
+								lc.len);
 		if (status)
 			goto out;
 	}
@@ -2919,8 +2917,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 
 out:
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
-	if (context)
-		security_release_secctx(context, contextlen);
+	if (lc.context)
+		security_release_secctx(lc.context, lc.len);
 #endif /* CONFIG_NFSD_V4_SECURITY_LABEL */
 	kfree(acl);
 	if (tempfh) {
diff --git a/include/linux/security.h b/include/linux/security.h
index 2abbaf72779e..b9f824952748 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -441,7 +441,7 @@ void security_release_secctx(char *secdata, u32 seclen);
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, struct lsm_context *cp);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
-int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+int security_inode_getsecctx(struct inode *inode, struct lsm_context *cp);
 #else /* CONFIG_SECURITY */
 
 static inline int call_lsm_notifier(enum lsm_event event, void *data)
@@ -1243,7 +1243,8 @@ static inline int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32
 {
 	return -EOPNOTSUPP;
 }
-static inline int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
+static inline int security_inode_getsecctx(struct inode *inode,
+					   struct lsm_context *cp);
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/security.c b/security/security.c
index f5e332bfcdbe..b7e15cbd4021 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2038,16 +2038,9 @@ int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 }
 EXPORT_SYMBOL(security_inode_setsecctx);
 
-int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
+int security_inode_getsecctx(struct inode *inode, struct lsm_context *cp)
 {
-	struct lsm_context lc = { .context = NULL, .len = 0, };
-	int rc;
-
-	rc = call_int_hook(inode_getsecctx, -EOPNOTSUPP, inode, &lc);
-
-	*ctx = (void *)lc.context;
-	*ctxlen = lc.len;
-	return rc;
+	return call_int_hook(inode_getsecctx, -EOPNOTSUPP, inode, cp);
 }
 EXPORT_SYMBOL(security_inode_getsecctx);
 
-- 
2.19.1

