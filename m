Return-Path: <SRS0=eUs8=VX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D33C7618F
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 23:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED52E21994
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 23:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PFLdOi4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfGZXjz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 26 Jul 2019 19:39:55 -0400
Received: from sonic310-23.consmr.mail.bf2.yahoo.com ([74.6.135.197]:38377
        "EHLO sonic310-23.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727958AbfGZXjz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 26 Jul 2019 19:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1564184394; bh=gXdVAk+ckGgmy5NE6rDSU+SRJTAd7uOvOpUj3W4/c+A=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=PFLdOi4vChgINM8hELp09L8E+oiKgNQCcYBCZeCiCwW+0nkyc4iK/QZ/2jJeDaI6ujlawhl/QAgCtV/CzgebNrfeWnN0LvghjbyUuJP3UhwfHcUcDH3On5Abxb1UaqZGXZ0Og01vBn5+oWI93g9qiX9R1fJqi8R61o8ThJsJFjKeQS2eOYR9ZNKEbtyj2XWj13tVxntra8YxTCbmPdNenfpLZgRx6+3Ap6MCh/bCh7yqd5BVZXjxgv/XMhgg79B8q9pH8RRySd/Mj+Pn2PoslRx4kE2zv6Wj/i13sCZ5NR/RjQYqmuPxbU6+CKMOTrEhMQqRCTzLCkInA+o2XSp8sg==
X-YMail-OSG: S4_V.HYVM1m9g5sffM_ROLYELKrpmJTKOuRPMJA23VhKDkJGLaGmviaqWQRSBdI
 Kw0ttyrCNVH_3cZvltEDdNmujEPxTQwbebODRthq4fFON2I01Z9xBf4UO_14bGuwgHNn0AByJWUE
 hWuP.DbBB2gWJcv3hTPoYlleCKDaqSx18hLOA3fT60u6wNg0eKjOzBgDxe7ySMcMW2ygP_b0FnU.
 ..cMZBHFNK6PrpHyem0ECPCrZYqYo5_9QwrVOSrmRmWqRQvaqIq4UblgI8lJpHnFA9y6w_KhE16e
 bdeXY1jQJnUWEI.xDdGWXvNeNXGZ4bu1dKKtki_whx0TlbjFCbuq8d447SMDb4dRrCWQsFy1iqQf
 DJc.vqjv1KB5JsgipCrmOXeCYlWyuvxwc6ISJjhjrOVRwPkVLUKlp9AiShzgsteTvca2YY_K6r_m
 nzOCxuwn9c2sxXTJx6THN9pkwWt9RUgjnaONn8wbzGY7G7lMe5zekttSk.rXtmM6rRoyK60SSHiw
 WwcYbPPvpduGc9xu_FJ.IsgKCP.hc1Wxmb3EJqOUQQE7yInCfdMuCm3zuIWwzKaenyfQPegGL21g
 aCd5sEquKNKbUtXxPOGZxubEu0cOsx5e9HEc8nfBgPBArSl0jmoE24oft.Fc7DqlI0hOgJlm52BT
 qyQgthzVdvMSNwks5PPLbZNGBj3KNdss0OZ6Umkz9.kvYQAfgQjSzqehy1AlJWrAzZjauq42.1DI
 S97LfvQjrA1Fiziax8tleXm4bbX3NoUY8HO2HgPzR4BIKD5kbMMEyuAoq_T4tDa_xRz7BM7GRdli
 sfHVuu8Ioq_dUsheV5Y2f683kxSu.Kd_hfci6iH6Uy6CgM7J3bMnNJiEatX4M3lBE2wp9u5w39d6
 fkd4JxuDh9tZHlm8yTAh5xgfgbBObOcsBBkJDAvE5yc9YRRT7Kn3vNqEBmNTnlGthC3COTCXhdYZ
 GHiRaoPA4I0Ka1H_kqnVwwtSkSi9iQbhAQ.MlgpCbpi9m32BtNBbwdeSeycHbyFwfyKQiqs3gCNt
 CBeDVgladasuSJZCSpL8u7l49QJ1zQptQzeytP9EwS24693PiCIZ6xBgtotaQeyCObtntHU0it6s
 sXbFU4JLhoIqQ4tDzwDihtq6YA8ZWhdkih29FzDlIyDG6GUOHEo3evTWYVVuU04fGic.cs7HiEDW
 7kgMBffaX8VxNPtBVOPjG7KRZbHfQjItDq0d1V42wBkcWdeIjLOdKSN1XCzbOnJVDMua.daOrdyC
 3Wrb0Iprx_C_WCJNnTFM92JrcQzkgBIP_RCuoIMpQ_LCcd9TLGQP4eQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Fri, 26 Jul 2019 23:39:54 +0000
Received: by smtp416.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 223f61bb2347890e9e9f353c8afb834f;
          Fri, 26 Jul 2019 23:39:49 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 17/27] LSM: Use lsmcontext in security_dentry_init_security
Date:   Fri, 26 Jul 2019 16:39:13 -0700
Message-Id: <20190726233923.2570-18-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726233923.2570-1-casey@schaufler-ca.com>
References: <20190726233923.2570-1-casey@schaufler-ca.com>
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
index 7255825aa697..2674eb70c2d7 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -352,8 +352,8 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
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
@@ -724,8 +724,7 @@ static inline void security_inode_free(struct inode *inode)
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
index f726590ef6d3..b714074b1729 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1040,12 +1040,33 @@ void security_inode_free(struct inode *inode)
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

