Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733DBC282DA
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406BF2084B
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mxBMZdEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfDITTa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:19:30 -0400
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:41188
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726898AbfDITT3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837568; bh=zegT0UV/a0mEisN0gB9wl+y3EnZt90kYI1JdG3iO73s=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=mxBMZdEg+7Y+PpGnvQ4reYphkiXQETjt/pR9APP6fYKWqmL8c26UYJAkGS9DtG/Q+1qwwi3Rv7U4h6Ypsny+exoOorulF5y4ToSF8PWbmAzs6fp7VYRmd+IfAof8LuK0ypaKv7plcemm+563n4UEHzg/nKUVlg3Ipjxgi2YB+PDsNX2dN/Mr2J1HRSKnm1U6tl3kgN261zKf+WT4LR8tlBVujvhs2HdcjoHOdTAfCk+2ocDI8Q0NLtja3Agkfu9dgLcHwZiqyjyPLadb2qenYXrHdUCR8VffZc4iZUAzlxNgVfhBt1lNJNan3rGJWyCBlRyDq6guoHYFDRxz81FZ4g==
X-YMail-OSG: 9pd_l5kVM1mmSpdjFnlFTOwiCfkG56q2be6n_ttXAFO19Ecj1gtCxd.WiPAq_Fy
 RIV.0c5RQH3r3OxUGR0wAD_HTUDIB.pzF_haYq4SkOiZUHR_fjEF7b54UCbRFlMXCdc0cJl6moPr
 QMMscrwmz06j4cirbJMrfIn0MOgIT3PhXhM2fcQkxCREx6KnQcKiasRlO742c54ZAF30vM9jVQ6L
 VwZTIsfmgMafFRP6tlsgExqaDpYRDY.i3XfC9_FxN0tH1AgM2UWikjMsOTw57_Q_uhpKsUEUJenW
 bLuIl6vy_2lXTUZNKv5DqojkFV5WORpzuWd08nUcVqye9fFolV2qw2SVvlcAUUrHnQmXFqwxYyaV
 S26Sz3RDIr_ev99pAB.77tn1rS0hb1Vo_TuEcm_lWYpvpJN_nZEZLoAW260daWpMQ9iy5y34sEl2
 ct1zh0UWLfrvadtaQWn.4QrhLF.o8LE1AJ7VFu2OQE5O3iM0X.547GBW3XWe_Fd.hQ_rkFuyZbRn
 cFB3uE1hLeQmpd247DaOOhOq2g8Ks0.ZC9fwsLR_bmaRvayki.pfihZXj56T2luacJe7l9jqKqOg
 RxF7ISZqkLinGnmncB3u43qMVss1qYMb8clmKrsu0XnDS.aIwvUz1hxO.fJcIYY04uOWd65v5q2R
 oJXsnM5PG3seASIWvl7ttlrWxVW5RCp9SHgR4k8vC90tzcgmzBIlqtbF22T1rWpXcKfLvjLkH0QM
 XK1nP3DwX_ldcgbHSXPz0CfX8vFjJKJ5maeIY5F_APEP3fYFXl2VBksmOXD9yXONVj5RZ69alTKr
 EMFhH2AX5G9oa.mkU8_01EQ_sGJkgtegVUUuSLaaLR5MOjDhnnm6zb_RaYAfEJ7ZR3SBVnWneoG4
 Je83QlL0eNx7dsMCpCH3cbjYglmaGNToxzLDRbJzAUmK9QzDa0mw2wurpUwGFAY6I1NMhY8Iq82Q
 0psIxkhWiNXTRHHFjU0yGIqM3E_ptn.c75DPV6oVOfM4_Le3TloUPI0GcDn3TmrxXX9.kxdJpDnK
 iEeOQ7T.FYePobRnr9DpLf6bLXfsuWjnEG6MnoBRYV0zjbOsW6MT42Mkjuj3ykGabCjbPU0yWvrN
 s4XokpR5rMDVNf3cefW4E1k6mBVKVGcgnYgG2ICagOe9IR_qZJ2eXPlpbthGz
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:19:28 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 92df6dee4d3144b341710b3f28d23ef8;
          Tue, 09 Apr 2019 19:19:25 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 45/59] LSM: Use lsm_context in security_inode_getsecctx
Date:   Tue,  9 Apr 2019 12:18:34 -0700
Message-Id: <20190409191848.1380-46-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409191848.1380-1-casey@schaufler-ca.com>
References: <20190409191848.1380-1-casey@schaufler-ca.com>
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

