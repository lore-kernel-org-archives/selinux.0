Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B61C17440
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 00:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ACD62196E
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 00:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WdeTnsc+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfKMAKV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Nov 2019 19:10:21 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:45433
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727284AbfKMAKU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Nov 2019 19:10:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573603819; bh=5a1Bn2oGXej0Jcc78dgWtIiwCtWaGO4LPz5VJ3J/aYQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=WdeTnsc+XRjCTTiPmXqStR1If2y5WBap2N1/5v04YScpJHtGMUZ0b/bUfYE6rmbHmq0Av2cAYrJi+HzPiZPm68cdu7R1OvT0jsPu7ngaq5aG0eC1XN0APDM3kzT6UEel20nmGfGNKRcuOIb3ACpQ+AW4HkW+M/YFjjVgzTVHs3bbbVefAutsj4f+OGCAByubEEZrz5+CjXosdDWGB3ukpDuhEPZebJrSBXIvDiHENQzOjtS4GqTE4L4j54zDhUxf7+JMHWctenGHGNPpYAeqAwz9IMZIYp21pLCdzMBvttB7jbv1+idZcfHfaKjXtdsqtwnuhfG1KhPBaOkqoPqN6A==
X-YMail-OSG: CjaTNY0VM1mBn3tSY1XQtKEGjPGG4zwjvkgWceVbO5IfUEd_9lmmsjrarjGsMIX
 SOyEcc3wEaa5GZDYE4mTHnLeZTHnTPq6nm9YXfMk.qT5ZdVGD9cdYrhxLNTKAsRKv9F9GV4SZedI
 4mTnjZhXVOxFY3zbA2l1Late9U1kc8omS1Fhyfu3pTsm1AQsla0ycF1IyoqW3hN3cOQpcCvnWntU
 6aMu21WUAkpqQqe4272nfykAVaT1mKidi4rLzbqPzbClV3C9auC.4Fo5qSbzPQJPPrJJQ2TEfYWh
 p31kIjeKooUwfliRAKvHou.YZpSVGXzVT1l78mchcoum1xX5unEdB6.0gXQRLqOibUY9VAocRyDR
 CAe4TMwC7A.lEt2z4un3bsBQc5YiqRyvHn.cKI.BBV8pxeKPVMRITD5ufP2.3_G1d_xeOWjymCFv
 aRg1GmTZT7w8LrdWiazPgxq3LvhqoMPkN4EO0Sqsx8rq3Qjv5HbgUSXRTqF72UMBIHpwUNGV.lcW
 AJE4Q.Em1MgroZjhk2cMJyZa86ayti9PzR8d9ZU7Bu0Cre0r9HoE35ba3uACxx_jPhWjB6WvIZSW
 MgBz2FHLdGBsGt_pcQWEdbzeubakfu9PtKVdPgaaYZIbx6RE3V9LrNfjeWcmzhVjbNvBNAhj2kWu
 Pv08CvNGdMFhrBTTy9mXZfSXoqQczIgH_vIuVXRXDXfMK_ZkOLd3LWTuwTw05KG9hBP3YZGTZoa8
 MVJwaF744T.fAMOCP3zoBThb096akxwydzy6g_0mu2jVOtqAQ_UCI0A36xPmHXh041alFl0A.Nci
 c4vYonrDuYiuLFfw0B.iC2xu73MTQus6CkAzy2Trehm15eh0M1QuDC.ooT3.BXY9e6xLzFp5lViw
 tOoG9Cuuj4uN5gluF1mnqYRf6YjMMGTMHi1IG0JDzW.mJuUfZDDCwx5gctcJIX6XsBVF_KdVUjsn
 amcJHjsUqJxS5Jm4RilfM253W9h3Zrz86e7_xISNaiqvECSvtV8UiDEhuIP8nnS_D_T0nfOTyNCT
 PubOnyn3X55eOoelb8mPGxZOFpQ025pCasCxZpu2srh0MiiyeS3dVMMJjnZuVd2IEbXyR6Svp8W4
 JqnQ4fPp0GvAIG5x.B6wFWj4rVLL39_VrOTKvUej3f8PD9TthtIOOUyS4K2FL9cUKEGusDFkHadc
 jAfcJnj.cS7N_eaeRRq9kbH0GUdH.29lASU.56ua.H5k.UY7Ee1Ot7fX8N_ZYrPxsgsKyk2ADxBK
 DMYU5wTg2S8M0zBRdO76tq3OnL..kSJCMwr1._d2cMzy1Dhhg9jACFm6bd1Cb7CWf8QvQr.JzlO9
 9S6.LOrRa7D1yTXqMBMQ6fjeH.bji2iS_QwJa8J_e.7brNWQd0HZz8W1qwQ_b_1Gf7UQjQyl32XU
 RTeWZjQ37HZQu5O4hdYy3xWSulSDAU4kv0ubf5OsC8l4ivWwypZte3G0zMrEdnrG0EV0h9g--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 00:10:19 +0000
Received: by smtp407.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 33c25a8a04c7aa40c3f2a9c521ee5947;
          Wed, 13 Nov 2019 00:10:16 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 16/25] LSM: Use lsmcontext in security_dentry_init_security
Date:   Tue, 12 Nov 2019 16:09:04 -0800
Message-Id: <20191113000913.5414-17-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113000913.5414-1-casey@schaufler-ca.com>
References: <20191113000913.5414-1-casey@schaufler-ca.com>
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
index 74e9f4b7cc07..2f76741ee528 100644
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
index e47cef3d62f0..3e333104720d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -396,8 +396,8 @@ int security_add_mnt_opt(const char *option, const char *val,
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
@@ -788,8 +788,7 @@ static inline void security_inode_free(struct inode *inode)
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
index 618d4f90936b..6f43dafe1249 100644
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

