Return-Path: <SRS0=vsEg=YR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8253ACA9EBD
	for <selinux@archiver.kernel.org>; Thu, 24 Oct 2019 20:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5876C21A4C
	for <selinux@archiver.kernel.org>; Thu, 24 Oct 2019 20:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LNZk649Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbfJXUx5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:53:57 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:43926
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728669AbfJXUx5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Oct 2019 16:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1571950435; bh=mzSvHi63vjpUnBvczhTU9LKGZ5M5+g7KBf16W4CKxcU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=LNZk649ZUvhzGL5og2hg0MHQLRpP0WPIUam5RmYGGOXPtTiqaiEGwvS0TAIFhHfvkX7qwaJhjstgmHC5+MG9o+SAHjPmQ4LzTI/TIqx60zcVIGOq1GtKXcAODfHr/bvzaJc0XwjWAGsjZZpekt6vRMf3+zTNNKX9HQaCHa826rfGhpzWDSkaUwx+A+LY69TRNH1jEsTn564lPkAP8rs0SX4AWtDYqap5UE2oKjWZdcFN3B5sZH/+/URiAcsx3L2keT+JEsPRNJATPd/dOhEreAvDCMQ36a9OGUpVm4atl5UFEWT0CXqGQgX+cNCrJo0aWzPBl+m6JIF6WshPVIKmCw==
X-YMail-OSG: IaOBiqUVM1lFn9fMI1q88QUh5ScMXrjoloJZJf1MEk0MLkZLveriv_PE5oPLN6R
 4R0f.SIEVJppvQFws7pUCXlhWbhZkDL7T4rSc.OCE6B5u6fgPV1ewByrOJJmSkQnj.svE_Xo3wYD
 2piZ64br5ToueOP2yLAEiI4Xnf_YaTzcWuJCGiQWeybwVJBk0Ff9m8xPxZALAZ2lWW6uRyrM4WpM
 c1fVndJQDvdT3aa2OiGBLxdLcaKwvcMO6jWurMzYhRiavJTKdq479FtMvR1iCvSqWXAc3LDdq3RC
 wAIqrcl3d.iyNEBjEBhcWFmY3jBli0OxSY51gSJXqZL2OIQD8xyIPV5x6YY4pE101LbKC7.v0fx5
 vF.Yx4JZWvl9cypfR.YVOqFw2p8WrT6biF0D9an7xy51ClvN7x3qnHEPxBkfKtBBYlT_..KfX0Qx
 zX.yi2nvfobSN2fR7n5195x26HjxzJqQhZ452ZkF1EG8n8efTisRH26YmL6jZHQSt5qd_4HE0ZiM
 H3DeWPlb..p0qag9wVh6Uo_Ck2fLQvblDW3cxl9vQNmJdvu5yS_lxHcW2LQKC4OE66f5v7qCEm9t
 NLbESYnHpY045gJJjcwZTRHjJ4VzYhubg6cbDwEyFFCovQSvavWM.D5dwWyJQ9iO5_aCLie_74TS
 Lh_xXf2R5AhtSvOdlmuuNpYkbszldrPB8VZ0URvNXP9ZvLKY0SARUzfpDwg295U4bcbYM0E7coaK
 adycBHYH5jy66yEpQliCJsTcnKsWYXsGpzl3BGYZYsImsWtJCWFoRKbpxnejDnugrAOzTvrF41eS
 h.PDt.9bcu_eT_tl4UZNajGc3XnH5INSvzxbmUGAC4NWjsMI1VI.iM6atg5hJDfZy1WkefmTWOFS
 0rPHmowKeCobEMrqexXx.GonqB5KH3dZ4dFt2HeuQ8CkzYKHFKdvWOTx80th4_kwE5MEibzYn4l8
 w1.2YB5PTH1Jm6ilWBy3bCuEEBLp.XyxJN.mkPpTg_eMXi_pnximtq.kQK5ttPEX23ZWfdqiF0uY
 O6aJWcKdEytJQAEPOJD5l0MB4O05hcQit3l0S76N4uP9IRNwpZrWgnGCEaFd919lhggDRc5Q8DYH
 lN_hsbBS.eu0jjAQEURm2Itd92cb_XkkAa4PvaDLSCarTZHJGPwVlfMbFlYvhNLGD7jCoL.w4DM3
 83QgRV4z8lxTqf3NFCrhWdha.jnbAS30i37Yz6z6tKKMu42lP51TBE3GzC_jf8Lgu9CfuRcSTMBM
 eQcrv9vQKuK5conqMPwKFaESaqShFb_6vLgUmXoPskQf5req8xgq_zB4rxtCGpeSrYgbhvEkx8Ox
 66Li_0RXLQj2Hv6XTlJ11NQzEl8JjYJeVlo0VxouSydIAG4pt11LKRKDxOKWKdjFifWuyZLOlU5i
 _Hg5xus3BsO.GeDPvn75GXMg-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 24 Oct 2019 20:53:55 +0000
Received: by smtp428.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 40856e22461a71521149fbac47a9a44a;
          Thu, 24 Oct 2019 20:53:53 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v10 16/25] LSM: Use lsmcontext in security_dentry_init_security
Date:   Thu, 24 Oct 2019 13:52:19 -0700
Message-Id: <20191024205228.6922-17-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024205228.6922-1-casey@schaufler-ca.com>
References: <20191024205228.6922-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the security_dentry_init_security() interface to
fill an lsmcontext structure instead of a void * data area
and a length. The lone caller of this interface is NFS4,
which may make copies of the data using its own mechanisms.
A rework of the nfs4 code to use the lsmcontext properly
is a significant project, so the coward's way out is taken,
and the lsmcontext data from security_dentry_init_security()
is copied, then released directly.

This interface does not use the "display". There is currently
not case where that is useful or reasonable.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/nfs/nfs4proc.c        | 26 ++++++++++++++++----------
 include/linux/security.h |  7 +++----
 security/security.c      | 29 +++++++++++++++++++++++++----
 3 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index af1c0db29c39..952f805965bb 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -113,6 +113,7 @@ static inline struct nfs4_label *
 nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
 	struct iattr *sattr, struct nfs4_label *label)
 {
+	struct lsmcontext context;
 	int err;
 
 	if (label == NULL)
@@ -122,21 +123,26 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
 		return NULL;
 
 	err = security_dentry_init_security(dentry, sattr->ia_mode,
-				&dentry->d_name, (void **)&label->label, &label->len);
-	if (err == 0)
-		return label;
+					    &dentry->d_name, &context);
+
+	if (err)
+		return NULL;
+
+	label->label = kmemdup(context.context, context.len, GFP_KERNEL);
+	if (label->label == NULL)
+		label = NULL;
+	else
+		label->len = context.len;
+
+	security_release_secctx(&context);
+
+	return label;
 
-	return NULL;
 }
 static inline void
 nfs4_label_release_security(struct nfs4_label *label)
 {
-	struct lsmcontext scaff; /* scaffolding */
-
-	if (label) {
-		lsmcontext_init(&scaff, label->label, label->len, 0);
-		security_release_secctx(&scaff);
-	}
+	kfree(label->label);
 }
 static inline u32 *nfs4_bitmask(struct nfs_server *server, struct nfs4_label *label)
 {
diff --git a/include/linux/security.h b/include/linux/security.h
index ea06d601fe42..fb1e53029f1d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -344,8 +344,8 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
 int security_add_mnt_opt(const char *option, const char *val,
 				int len, void **mnt_opts);
 int security_dentry_init_security(struct dentry *dentry, int mode,
-					const struct qstr *name, void **ctx,
-					u32 *ctxlen);
+					const struct qstr *name,
+					struct lsmcontext *ctx);
 int security_dentry_create_files_as(struct dentry *dentry, int mode,
 					struct qstr *name,
 					const struct cred *old,
@@ -716,8 +716,7 @@ static inline void security_inode_free(struct inode *inode)
 static inline int security_dentry_init_security(struct dentry *dentry,
 						 int mode,
 						 const struct qstr *name,
-						 void **ctx,
-						 u32 *ctxlen)
+						 struct lsmcontext *ctx)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/security.c b/security/security.c
index a823f141915f..4ebf967d5b81 100644
--- a/security/security.c
+++ b/security/security.c
@@ -968,12 +968,33 @@ void security_inode_free(struct inode *inode)
 				inode_free_by_rcu);
 }
 
+/*
+ * security_dentry_init_security - initial context for a dentry
+ * @dentry: directory entry
+ * @mode: access mode
+ * @name: path name
+ * @context: resulting security context
+ *
+ * Use at most one security module to get the initial
+ * security context. Do not use the "display".
+ *
+ * Returns -EOPNOTSUPP if not supplied by any module or the module result.
+ */
 int security_dentry_init_security(struct dentry *dentry, int mode,
-					const struct qstr *name, void **ctx,
-					u32 *ctxlen)
+				  const struct qstr *name,
+				  struct lsmcontext *cp)
 {
-	return call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode,
-				name, ctx, ctxlen);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.dentry_init_security,
+			     list) {
+		cp->slot = hp->lsmid->slot;
+		return hp->hook.dentry_init_security(dentry, mode, name,
+						     (void **)&cp->context,
+						     &cp->len);
+	}
+
+	return -EOPNOTSUPP;
 }
 EXPORT_SYMBOL(security_dentry_init_security);
 
-- 
2.20.1

