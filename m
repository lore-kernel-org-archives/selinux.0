Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B3DC04AB6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8034C26FE6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RP+OZI5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfEaXSe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:18:34 -0400
Received: from sonic303-9.consmr.mail.bf2.yahoo.com ([74.6.131.48]:39916 "EHLO
        sonic303-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726804AbfEaXSe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344712; bh=wFOhNcgsx3tpKVkIF6420r+ZGM2BRdr7BpTpAqXS/b0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=RP+OZI5fYx06ky/TVkMtZ2vUnoEPWviDc1PTZKqu+2P/ETgyR4864okBEFHMxfKpp4WxlT3XK1XYJF+1zOa2D5jonr5EvoNN//a4RShf4UN6hDCvCEVkzAQg231G0HZE+Fm3vgVqDZT7FdJM+yCkjHEzsfe3SE2Qcfc9rRkyUlx9hgUOG+xMgZpEyiUoQh82yoWiWnVoOL8lYuyK62OrGt/yb/xdkWVwjL44kS3rc9XSCp0siPOM+uobnH8wp2LlaPNZpM3GJpXnve2EBITfkrt8KRGFg75Oea0ButE6MkQfKRRaWzVxt7CB+Ehwo2TB1bd/+1pY/UjGAsnkkH/WPQ==
X-YMail-OSG: c3XRpsMVM1mxFHTc15W0nptzAM.fXrBZczY99pDgxINo7PYbdrTgwlhKXilz6bm
 DEJaL58MimRCu02PUDAJD7zlujqZ0.pUJKfbP21ofWOw6.E.6xYtUnNv8RnBaGz7lgkEz3W7K9RI
 jXo_glwgKv308CQRwWXYU7Ve25ZngeDKMju3Kxv2_LeWtDFcLMfThIb.Q3ljpm3gyFIpHTkTp5Ip
 m8z5xum0jJxT7q78pNLLfNyxTvMgd3PwVuc3X0m9_X.q6Vl7LCAet9OsX.TgOildSbbvogGsqWC1
 RBGSNFGxMdzgaEdm9WHUwCCWS1YrLJcQBk4wj0_QS7AIrgi_swFyoP0v4ZOsciriL82LrC2nnO30
 W84VHYJPWKkBPdLTwfOtkNnCcwYZKKsfeAnQOITPy9K10SmqgcL1tF4SOnOQiSsRM.DP3D2oNbXV
 VarcMi7gfXKWCmwRb6gzAqbfkaZ8y8cwbSXvYlxLtfuhKtzk8UCuLvBSB0l_dDCrtW8x2J.WSps5
 nl0B3D.CE2cEqWG6fKsmd0Jvo4fGTRkCkcJWQQI1B8b3yjXWAxZ1VWjX6uTpL7eJpeUzRzODD5f6
 wWs38KKFI3EbwVuIk5SOaWTFng69hPAeypuPHSYT7Jcha5IOx7O0r0cf94jgZUzsn8ULK9WnnHuN
 dgUk9J6cmYz.m6A_6ziqshCC8YMi4by3a1BTPmHeERFca68jlluKUz89vz3SGImoLUQ8IppEdhc_
 L5r8L2G9iZqt01iDR3Vn54TIzp6adabBygWoHWQUxK5lOaQhrLVIFig9xsLereO.06gWCEf4IMel
 xbk304IeQHzRXmdQnhtJgWN9XtnzjKKQrbQVr91aUQlp6ikE9cdvxHXKVyyxbTYg3F4dE2GSeiZA
 66loaUGE.On3q3AYqlQyp6SexBw4.SsGGx_mSiFn7XShClmxl1EdfsjgvzjeOmk3JMC1qkMw0Et4
 msncc.f00wmnWWPqAK0nISKKaD1rNQRgdo6A3SSxcM32e9G984.tF6cFTeK_cV9KeXIHWM6krHbq
 vS_7umvDBbzlFsEVDUMZHQ5gQniwBdzBeElylD4kOkpxk7Zt4p72EVHRc14CD5rTNSmCYGDKaFTB
 dz_5nZf_t7EuwvBfIhYUwVQzFvu77RdwMw3F_zugDG9Ab0u_HgEh3zl6efDQ_1FpXUcs7_2aHUIl
 cNoT.1Q3ndTEEd4bJb_S7w01Fwlx95sl0UnNzJ.Ikf_GKupMUrbsfS1_33K9Gtc4EU6meOcGnt8Q
 _Tg1MhQ3W_NowWE.hEruR0mp8k3ggbs5bT_JtcVafytf6DB_dyAqXIMGD
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Fri, 31 May 2019 23:18:32 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp429.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 86e200249ed5328d0602f8eedef58520;
          Fri, 31 May 2019 23:18:28 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 44/58] LSM: Use lsm_context in security_inode_getsecctx
Date:   Fri, 31 May 2019 16:10:06 -0700
Message-Id: <20190531231020.628-45-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
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
index 6b2fcca08a43..90d1ff7a2fe6 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -439,7 +439,7 @@ void security_release_secctx(char *secdata, u32 seclen);
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, struct lsm_context *cp);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
-int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+int security_inode_getsecctx(struct inode *inode, struct lsm_context *cp);
 #else /* CONFIG_SECURITY */
 
 static inline int call_lsm_notifier(enum lsm_event event, void *data)
@@ -1241,7 +1241,8 @@ static inline int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32
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
index 74f211d58e5f..4f999cfcf949 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2023,16 +2023,9 @@ int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
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

