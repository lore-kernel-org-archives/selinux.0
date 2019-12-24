Return-Path: <SRS0=lMs6=2O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6A3C2D0C3
	for <selinux@archiver.kernel.org>; Tue, 24 Dec 2019 23:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF29206CB
	for <selinux@archiver.kernel.org>; Tue, 24 Dec 2019 23:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Soop2AsC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfLXXV4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Dec 2019 18:21:56 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:33822
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726246AbfLXXV4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Dec 2019 18:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577229714; bh=pk4OM2anm1/C+LQ96dtDYWeHAfHr5wLruGqEfoA0KyY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Soop2AsCLpM2Sz1G/DOJFxeQtG7xoPAtmQMygo31DkEmsQNv0S/w16dbWRw8ROIzk1/AWYBRrokZbQMthAl/bVWFYm7E+yMyBIyTQRnMCr2IhF1ADvUtFIrDnrUSlnM/95umQguqbXDC+61jwcduzhMp3+qpIXQIGNDry3Vqq3XlI5xrdDjAJGGHp1t9Q66g/B58LePwUo5Tobpu84yogfJDYYwdKVmO8fx1SB9S2N5HWEbiX+lC2iSobUbEtEbMt4yaK1pQv+9fwLwTDOpe6j25al1mJ80u2KNQOl4mL0HU/FzB2w2ATLMINbXNIcNULsS1JcNPARK0fXtldt7+rw==
X-YMail-OSG: o2124OUVM1kAI69F7iz8kRrKz6cPerXqjDrr0l.EfnBQwAs_3frsTOfx_8xhD6.
 fnGYaz4mAtHS8f7XDJNETrWyQh9.WRpkq_8Xf63Usyd0KGLMNpPC5rZIGeIpAQNgvNvOnQzNIzyT
 .v_OHDc8GQMTcYxCjV3WVpLV2KrcExNqP3DBiWqQeODhnoeOSOiK3MSCD_HDPRjPcKfePuw3X3B8
 Op8ALuDg3VaqspBypbiFlB2sqBVQ4qlOXkoH.BcfVbMyPDpQYkgMgnMkSvPFi5xlszq3aBVUdkwI
 5DTweybYQnByh3eyvYpNNWk7LUQLItKYSuOeXO0G.RoIVp7WAK3ZRVu0JiamK.bJ7AIoVlypp9Om
 rI8WeJfSkZRFZ5ke61bfEI6.ZFpbTzp9nu4gBcaFSnJ.DC1Bf7pU2cKnj74y7QS0nW6SeHxbkUOA
 OTiBmhLWYSX2C1atPiBJuozyeVwxKopq3STrt80XspX69grCQ3nHeMlfx20r3dAunRU0uQlxJ1uH
 CozQJrcdRjjim4zMxKkKvROlofHqJ5ue.YjAO4BmOX.MDj.MolPMxN1YLU6qOJzIrSkpTQa7JT8m
 yYyKZUbhZ.l3k2WEWaVPe.tl3qFPg6afwn3jwWdeodg0PbsvWbUhAdvTm1d0MJttJ7.g.ldl.B4d
 mPlMtGXT0zRAT0zlxm5mSCoWC5jrPXAQvrm8kzAapMvNfhybma401kJi9rSZx7PyNtz0IylQC4Dd
 OdUxc19DLHhJ7FDV.Jzq587ygA6kUwbBCIizzvY2b2CVDdPTdeeq16NKIlU6XWarqfrae7eyKUxb
 T7q8RNFxrldBv7YsOtAlRod4HMf581pc7lhYnj7f4iheQDUggLMlbqPLWhCwA4TYhYYz0NDACdPG
 3xmBSxXIE76qSsF0xC8oRxLKtypPRlwRe.Pc8DOaMrLkzSbz62il7Kr_DCQyM5WZnbhilB5Xjlrb
 NpySok.VrRwnXgJweOpT6Yh.icWrqzN6Uirwea8ltyCLdPhHggu8NQC2lX91PG0bAua8RMi30rZ4
 Ln.t3Yiag6tza.3hIcTJfgFzY9_gUiHqeBsREz34XEWNnJpIpkFMXEmtAelRrs10I4Da8qnqNkCP
 HTRpVqTWDszT.EtQZtOT9BZZDvkElY64w9K8NaYntMqY6CwnrSnCtN0W2FynxJTIX1NeAG9mtlZi
 92JiUYcBRHLuspX9pBCgmSBim5XaUUWTTwPAp63qt9YHKQIa1rGVR71MnM2pPllK9MTl76KU1033
 oJO_fWFizxZsQl.bAlU8bOcqt5jM20s1ndLKhAWAJyKd9zW.hPw0Eor1oNDlKi.uPT5U6hezXyY9
 le2nuXajoumWXd14WiWZoMtw6KR6aHiT83D7Hu3Crag2zhRAi5HwNgNvHKs21GiaC.yL9wbwA1..
 ge.UQQiGud_W2dSVMtEY1tHTQbkI6DCobTfCckFNb60aUTSW6HpqMt0eFGeaxNfr.IP9lnjduf4_
 x
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 24 Dec 2019 23:21:54 +0000
Received: by smtp416.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID cbb1f47b4aa1c76f1688d5d651e30c9e;
          Tue, 24 Dec 2019 23:21:53 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v12 16/25] LSM: Use lsmcontext in security_dentry_init_security
Date:   Tue, 24 Dec 2019 15:19:06 -0800
Message-Id: <20191224231915.7208-17-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224231915.7208-1-casey@schaufler-ca.com>
References: <20191224231915.7208-1-casey@schaufler-ca.com>
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
index a30e36654c57..78d63f7f0088 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -112,6 +112,7 @@ static inline struct nfs4_label *
 nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
 	struct iattr *sattr, struct nfs4_label *label)
 {
+	struct lsmcontext context;
 	int err;
 
 	if (label == NULL)
@@ -121,21 +122,26 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
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
index 00421941f683..a5eba06a9382 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -398,8 +398,8 @@ int security_add_mnt_opt(const char *option, const char *val,
 				int len, void **mnt_opts);
 int security_move_mount(const struct path *from_path, const struct path *to_path);
 int security_dentry_init_security(struct dentry *dentry, int mode,
-					const struct qstr *name, void **ctx,
-					u32 *ctxlen);
+					const struct qstr *name,
+					struct lsmcontext *ctx);
 int security_dentry_create_files_as(struct dentry *dentry, int mode,
 					struct qstr *name,
 					const struct cred *old,
@@ -790,8 +790,7 @@ static inline void security_inode_free(struct inode *inode)
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
index 4ba1a6ed36e0..8aa107b57af9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1011,12 +1011,33 @@ void security_inode_free(struct inode *inode)
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

