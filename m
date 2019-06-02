Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99990C282DC
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7F32794D
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fCsxCOqP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfFBQy0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:54:26 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:44719
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727097AbfFBQy0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494464; bh=0jVxUPp+/V3kRc2gW7rNVCE5I4hyQouQVqDWX5FgND4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=fCsxCOqPQbS0JgHfLSYk2uvPXrZPY7OaAwxt2Rbn3zR+YnVfHVg27t48plJlgbUsUT689OOI30LAKjaWthBS8hB9l5Bi9pSqqszz0F9dgwkw4l/DQtP/tsR6v2DZasQFtAyT9BQnzY2LeThuOrA7bTxO+m0S1sLxtVVkxmWXK/5CuX3G5rtXLVJC3IVx5+0hFUNFipQwru0ZjKH5r5fcBGP3RDyPz/U1BUS+FCsaEEx00kEhiVHxQo9W5Lt+9VQEWCCkSgJeRJWgd6LBsU5r+TmU+JW7yBzm0WMJLgxfGUC9sfOT3OAralFX29dgN1havuJuiXrDwugj62hOfhXbAw==
X-YMail-OSG: QgOQYcAVM1lJKPnFcls6VwdLkU15blZ1NV3ZFaa1T79ksQnTlbSwtFFpAOzO8ay
 gx3rfpUx1c__cUcR0S.3OestsGtvSBR.7_87roqsO60DllDrIZw0AxKK3D.VtZwpnASQV4SCtDhB
 Os8vGczfEaalOOBKvTuMCeLJHtXGac_vedqf3JLtHBGVGKNQ9_iO5Sh_YbKHIRKGBYUe.Vuxho7U
 MRIjjggRVat7J_o.4CsogDC6JUJn9F.WP.4oHRr7MLgYWUGNa1bZF41wYVaITDP9Fg2n_.m1lef6
 TpMwM6vAHHfGVtDb0Sa4_DD3eNsIOGFtS.ceYYuEDnUz.iScWHV4eYHXzAsbJazhODtMHRyJDa5a
 f4BelTuiwgqfM8SZbVG0FMTRcCcur1FNOzll2.hxiHOcwN8Z4jds42OVZhobapgG3mM.3ATb6OOF
 9beFts0vhn3SrNwrG0xNl.xXqFgzMfsK0XdQB6GPzG7FwsSYUYwq1L1JsdhOcwvCUWoPi30tcMHk
 UPuN0qbv_HQBM0oddNZKVl5hCtSrX4Hmgmm53tzsX7ND__PJUJJO9HGK0f1BoKIKrkdBoemkUOT9
 ttqGcq18swECkSwhTS1PxB3AQWoXMpv3ZMEbDuh61YuWPx1G_tTC3zIk7uObAf_V9L0qYJCKjghP
 6VlDRqqwle3c2t1tLKwk4dZOS0Vs3E26Ln6__1Xqikpv0.BMUvFMPm3AlBPlD52RR5giemz4Pn9W
 mMt96EutDapgM5kuHEP0CeoYgei2B3Tm1KeSsUfhu38qOTVo0ustQSoHvLCfNNhMWCxqjwc7dshf
 xy7rLR.a6lKB.dH.V18Xd_YCZgxRxBvqsABtnVAu8TQgyxY8GS.eQ5iN38XmdHDyZ13IdbWopx9u
 lkuncBRMS6OZ.XCyj.Ihye..gKmQpHnz3.ZAUqGTET7ylSBbo5qjfy3b951H2xXeifCamUuc4vfD
 rpVP1j7WkFXpm4iKNnxx5wVWBQ_m2L6VmVfLdAmlFJwIXv5YWPwsK0QkFnyk6PwYcOgo_oBgUL6V
 5Kvbgz4WgU4idPJ.KiZIQFa5jPripR4HNZIfAval2.JDHKzUrmvGsgA6oPZTIcHrkRZYvzjvYxmI
 kqRKourxg71aTw2BjFH2LxxS.bBGhS0LktB_wKEdvq.60Araz0BpTkjo198JJlE5b7jipA5sJE4D
 _Jcvi.tUjUd3EqRs2MNxoa6OR27.EmPbRlpJQOSQBeUSANxkVHzgXZr3rA4zj1beN9xgengH0o05
 mhWnqO.nQDxa1duH_iI2NdoQAtKMhbj12IoFU81bQz0b35wA0X5lD5l1xV0E-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Sun, 2 Jun 2019 16:54:24 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp418.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0b8226328c4965373e1d598ce42fc97b;
          Sun, 02 Jun 2019 16:54:21 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 52/58] LSM: Use lsm_context in security_inode_setsecctx
Date:   Sun,  2 Jun 2019 09:50:55 -0700
Message-Id: <20190602165101.25079-53-casey@schaufler-ca.com>
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

Convert security_inode_setsecctx to use the lsm_context structure
instead of a context/secid pair. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/nfsd/nfs4proc.c       | 8 ++++++--
 fs/nfsd/vfs.c            | 7 ++++++-
 include/linux/security.h | 5 +++--
 security/security.c      | 8 ++------
 4 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 0cfd257ffdaf..5b4ea2a317ed 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -54,12 +54,16 @@
 static inline void
 nfsd4_security_inode_setsecctx(struct svc_fh *resfh, struct xdr_netobj *label, u32 *bmval)
 {
+	struct lsm_context lc;
 	struct inode *inode = d_inode(resfh->fh_dentry);
 	int status;
 
 	inode_lock(inode);
-	status = security_inode_setsecctx(resfh->fh_dentry,
-		label->data, label->len);
+
+	lsm_context_init(&lc);
+	lc.context = label->data;
+	lc.len = label->len;
+	status = security_inode_setsecctx(resfh->fh_dentry, &lc);
 	inode_unlock(inode);
 
 	if (status)
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 7dc98e14655d..2d6dd4bb7247 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -531,6 +531,7 @@ __be32 nfsd4_set_nfs4_label(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	__be32 error;
 	int host_error;
 	struct dentry *dentry;
+	struct lsm_context lc;
 
 	error = fh_verify(rqstp, fhp, 0 /* S_IFREG */, NFSD_MAY_SATTR);
 	if (error)
@@ -539,7 +540,11 @@ __be32 nfsd4_set_nfs4_label(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	dentry = fhp->fh_dentry;
 
 	inode_lock(d_inode(dentry));
-	host_error = security_inode_setsecctx(dentry, label->data, label->len);
+
+	lsm_context_init(&lc);
+	lc.context = label->data;
+	lc.len = label->len;
+	host_error = security_inode_setsecctx(dentry, &lc);
 	inode_unlock(d_inode(dentry));
 	return nfserrno(host_error);
 }
diff --git a/include/linux/security.h b/include/linux/security.h
index 94c714310ab7..0be6eadd0110 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -439,7 +439,7 @@ void security_release_secctx(struct lsm_context *cp);
 
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, struct lsm_context *cp);
-int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
+int security_inode_setsecctx(struct dentry *dentry, struct lsm_context *cp);
 int security_inode_getsecctx(struct inode *inode, struct lsm_context *cp);
 #else /* CONFIG_SECURITY */
 
@@ -1237,7 +1237,8 @@ static inline int security_inode_notifysecctx(struct inode *inode,
 {
 	return -EOPNOTSUPP;
 }
-static inline int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
+static inline int security_inode_setsecctx(struct dentry *dentry,
+					   struct lsm_context *cp)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/security.c b/security/security.c
index 9d09c774a1e9..363647cf1ae8 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2006,13 +2006,9 @@ int security_inode_notifysecctx(struct inode *inode, struct lsm_context *cp)
 }
 EXPORT_SYMBOL(security_inode_notifysecctx);
 
-int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
+int security_inode_setsecctx(struct dentry *dentry, struct lsm_context *cp)
 {
-	struct lsm_context lc;
-
-	lc.context = ctx;
-	lc.len = ctxlen;
-	return call_int_hook(inode_setsecctx, 0, dentry, &lc);
+	return call_int_hook(inode_setsecctx, 0, dentry, cp);
 }
 EXPORT_SYMBOL(security_inode_setsecctx);
 
-- 
2.19.1

