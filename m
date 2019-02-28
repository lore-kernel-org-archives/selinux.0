Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F1DC10F0E
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C801C2184A
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="B8PqHWsG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731796AbfB1WUW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:22 -0500
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:34778
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731443AbfB1WUV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392420; bh=fYhale5NrsEnocMiGoPfT1RN69Aoyq8H4hNdPv6qQ04=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=B8PqHWsG0Ctp6m0qG+bApIJ2Erbo+faFqZJN3Zp0kiGkvfXpKZYCIaEjzfv3U3kWOT0u7gSFXMgJYE4L05n1UXggZNAOBpuTPUOpGTG8ukPtHF3bqE8RTrirJgxUoC4Mb/43SsI5fKn99W8L439eyM1QwAglgvU5TBZIMMQoOwKNBz6y/rCGZY02GVqC+5EfBD66wIxbBV/HS+994MecbmXumi+rr3Yra2qqHa5pKmoM8XNcSdN5clayV+6SRI9m1lCKOdg5VfQgLHs+4TzRwGf/tHgOhpULpAWUuBzeKLOQp6NMSbJxIiqlcxHoeK439nuVNF4Z3gdJ2mX9kifO6Q==
X-YMail-OSG: jNX_CiYVM1nL5RE55G6rWl5hzu7zlg8J44Q6RAux.gc37PpO3VgiLtiCSMf_AGi
 KdJ34t2TYapsVNJ36OwkpkzUCmm8HMOAjvfrxsYgYEr_WmQKOVjJy0cd0Nl8rCAS03zVO2_XWgnB
 R36WZjtpL_y..TTCs1hBzfkHdCf5pfkcpXd0seCl3M.sWMOK4r_QhRy.wJ2x.LGif6GUXy9i_Co4
 WmKqi9nca0_C2pjR4mSyTmGYtF6OL3ub3fuxOa2grzng2mJ.EJu.kb_sIoI.vYIJYBWkk7925ga1
 hdKIMnbwpvX1B2KU3EH38fFeGCyCGwmD.O5lka__LWJNbYQ6Ynfm6MITuBglUhuL2P1s6pFDlYjo
 4EG2AyBw9nwY.GAtb4QFTVTAtQe9U1.5G_nRnESiInMlQMfs42g5NX2EdXT.A35l7QJVFKV.oPfz
 _ni2rs2e4oqXI6OThSxFrbX4v1.2YHHD1ngMjlP9AJ53kNBZAbn4cduiEq8UTrH9MMWatDqNuH39
 mgo0wLmpWhDLjoBYYXRLNMK.hs9NPrrR5sx6gx_m_yuOmeDJm4zJiq7Hq2fbK5Xp39QLESpWf8wR
 rygP_yHfWBJTtIqsVi37rsSnUzfvxzohLEBOTyoGUTI6x7KdA4yq1myUiKmM6zDPugbqaNjYW2lq
 uH3OBg6iX04hFF2Y05ZoksPhKgXXZ2dSm2T5izAW2_reKSW.IPTnLjJwCX2Xq2eL2ofNfkux2SfS
 fHrlsSd5pie7esj4cKh7lXa2wLK32yMOvuZi24_.xBy29J1Uz.z5z8WlMcZ3z3JXOVZ1FQPl6AI2
 M_FSqh.iI8gHESRbHqRnW_yPywW3Y0ol_.JQYGgmUt5dmYOv50s.thHbO5GCw3QQvm9QrUDdkZia
 rDco5gIWvWNZFd_X4zvrXyHuMpJ4vjexuHZA1RFTZ2AiBdEKLUySkvhCn9NTojApYdD4xQ4jwqSm
 ONCZcNHP8Ra4ImxDmW.C9xcraG1NqysW3Qdkg.Rcv6K1DNzLiT6PBpjir21z7tC2IYqOC3WzqH2x
 y0DSdlDn7rEJtdDqC4usD_0K11d0Eq_bMTsMpTLQykRVB0BoKAlFvssYlsFTjgnm1AjX3KW7.Cr5
 .q0M.5EQz9LrHV9lmVAVyjTUdAb9mIUcRg9MjhBHurXsLNz2d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:20 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp423.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 51882fbcdd41d0138ebd23ca73a62b12;
          Thu, 28 Feb 2019 22:20:20 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 59/97] LSM: Use lsm_context in security_inode_setsecctx
Date:   Thu, 28 Feb 2019 14:18:55 -0800
Message-Id: <20190228221933.2551-60-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
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
index 9824e32b2f23..d9e408c3d0a2 100644
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
index 749acb6a28a6..cb5e685f60eb 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -436,7 +436,7 @@ void security_release_secctx(struct lsm_context *cp);
 
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, struct lsm_context *cp);
-int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
+int security_inode_setsecctx(struct dentry *dentry, struct lsm_context *cp);
 int security_inode_getsecctx(struct inode *inode, struct lsm_context *cp);
 #else /* CONFIG_SECURITY */
 
@@ -1223,7 +1223,8 @@ static inline int security_inode_notifysecctx(struct inode *inode,
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
index 42c5467ccedc..b45136a8fd81 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2007,13 +2007,9 @@ int security_inode_notifysecctx(struct inode *inode, struct lsm_context *cp)
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
2.17.0

