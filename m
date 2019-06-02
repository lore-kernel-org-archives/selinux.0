Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCA4C282DC
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D372794D
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PAzThKba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfFBQx5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:53:57 -0400
Received: from sonic305-8.consmr.mail.bf2.yahoo.com ([74.6.133.47]:40078 "EHLO
        sonic305-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727053AbfFBQx4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494435; bh=wFOhNcgsx3tpKVkIF6420r+ZGM2BRdr7BpTpAqXS/b0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=PAzThKbawFsvOXbqC7ZwU8rziQvhFxolhpPRI8q4PDSZQ7VVkIDyy2PTaSQqmSZUOnJeKcDcnF6GljBpmVl/PHZrqi1U4vsJ47o430z5hwq6GFNOj3qliH56klqHDRk8dpkUq+GUSw+kTdRhGm4NrbLhkLkKZ3BbFShRutZLNcFussTAqm79a3sVFBi6V97VqPaBr/WfcBrLXe5nyKttjHQCMQXrogPf9OxalqNUPppU7010N4TMngCuc9pAVwI89UZiR972oo/CkQ+XrNLgLUQPs9YXgwwSreNmkI1QH7MunSgQsE9Zf2a/JIZclM3+R5XLXlP6pa9iho+PdLjE+Q==
X-YMail-OSG: nPSL5d0VM1liFWyVmiacJ1x3WkHKN1tm2CubOp7DFFdqZCis7sibKWS0W1SEFgO
 EPzGR76Iwi7Ai_8bwu2iT02JbTx8dy7Hz1cT5Sso.P72I.PRHspCSec57bsZ3fbqtEif_ojlkqpp
 aLG2FqVn8o1_LFFcYanCEJcRTxYBYRtpnQLTAXremGFSi1bUXYJyV4azp8qa4v2AlZab5u0vjZTs
 SYykKoJnWmU2fd3hU1tVxJEunSh5RehLujLA2JCBw9Vi0eVjRFbF1hCTkkwNSJBTItLHARifqPU5
 1rKrZD1Uiyra7uhn8nrp7Q87f9GghY2Dj_vpNkD7ZoyqVfARqESIgkwkDmZZ4dzpM8yYrdxBfYF3
 vkG0kAB74.uM66iXoeHTKbrTCk4BraDLbthXw05kDyhUPtXaeH37fTecyJs6lt8I3GN.9s0IlfSu
 2kR7DEIPycpeOnTwyT_LBYTlYazXAYVo64WwjVW.MsBd1S2CsQPW99cpcdGY5a7LEcDrLp.h4Gvo
 T8a3z5HYZbvJD.WgAqgtEU9JAoGHYjQihgGyTFsRxAlu7ZfCfXo_A8BqkkyEk6Ou.0T8GtAanUKt
 N5.Kj5oHZV4YOsRqvJeJCzzHwGIfPvawxnZz9KdiLorQUOvHD7rr3w._UrNPndqNVGXiM5LcESxH
 ..jdWmiXZ3QHDmyht4z.tWpuRD6QiMJ3cHMEWei6Wr_DEgZ2z975ThiJ8_6kvPxmjHFOYVgoBBVU
 vedQ1a400Q0ncLLeiWBI16_r7_TjbRZumFehW9B4AF5_XYSAyFdSPCBgygxweZ_2uFQnPtOOfzzW
 gU.BOHF0OaNguyYAzwmr8E.glz5YiOMj3Y5pzO4b1srVJ6.d80c3.hOm5dL6vBFd5wsaTbE4xR98
 TlknqKnYFR6ACDG1QD5uC1AfJJ5xPSJcp299NNVI7tEVHtpcF2BbnPqiIVGRx5LvtcFRsfU5La3S
 n0Dn51BqDVTzLPD3swlXq8D4z6REW33g0sDdfdMobs.nlzQl6s0.IPN2rOkl2dP.2pB0E3HhU4cp
 QJ_lp0yIvnQT0U25ZBwsa6ywRMfLdatlff4X1zyGG2lC3PWvnjPG1W7d95ZZ0A0sQruaJtVKPBTV
 srJiuypV.Qn2B3qh5gy3sGS9Ilx9164wKIvNeKeT2V4HDDN2yW2ruVpp8POAjBa_OnQfYX7LMweR
 Ns0zApgl7MvxUop3Q4dqGxQ.r_ctqyVIzxzSmP1tApMPxJrPq5F38TY1KPZZISIVoHv4.qmC8P8Z
 .S6JQHq_mnmTmdnT06Ks9wZ0WKH3b2uZZSBQiv6J7rVmPkvdXEZJ4j8cz
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Sun, 2 Jun 2019 16:53:55 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp427.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 378fb4b825ee861f1e4674117ce93fdc;
          Sun, 02 Jun 2019 16:53:51 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 44/58] LSM: Use lsm_context in security_inode_getsecctx
Date:   Sun,  2 Jun 2019 09:50:47 -0700
Message-Id: <20190602165101.25079-45-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

