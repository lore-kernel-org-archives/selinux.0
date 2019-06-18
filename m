Return-Path: <SRS0=/AWk=UR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02051C31E5D
	for <selinux@archiver.kernel.org>; Tue, 18 Jun 2019 23:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD78D2080C
	for <selinux@archiver.kernel.org>; Tue, 18 Jun 2019 23:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="YSFKzsju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbfFRXHD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jun 2019 19:07:03 -0400
Received: from sonic316-20.consmr.mail.bf2.yahoo.com ([74.6.130.194]:41235
        "EHLO sonic316-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730966AbfFRXHD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jun 2019 19:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1560899221; bh=5+jmKlHvdVZ7YYwfP2i9ZbNBYe+Vg0tQ8ZkdMDEcwN4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=YSFKzsjumN61iPPHHxVx37Dv8lVygMendCGeHuIMh6UrFEQhavLdFSU2Ou4OsoJs85vW8TZFNRQekFxfwz6fkGeRVAvDJExyaNrqpWhJvWPqKHR1PxPjPdAJDRyDgXPn5pim9BJvJJBC/r58GGOwiaa84mClSqxIX6ss5Bxdg8KAJC1LFHXU82MFEFpr0P+bAPPGthplaNHXmuF/35o444xqhaMKU1LMrhlgnWg57hKyulvg7uYvSeZ9Ki+uHJGrcrxrThYL6FFpwpiCJO5yujlYm4Aae0p3BA6IZIxscoJODUUND/ew+Su3UcjQFnwQTKAO0N87YU0+BJYrN1Y+RQ==
X-YMail-OSG: okkV71gVM1kP_qbark3Dkc0VaXhFWEPj..dz_zdHfJ9ftwYnhZgCZuOYWjvrB0p
 0PTY827j3OozAdmJgko8WWb23cnoWyLdCEntDAuq6RKbQPyqbekAGziKW0LBPq_deQs9uf.qmLjW
 yjfwTItELRFftN6OIkEPtaJO___O6KCcl.hpDJyxOftBWSnFeqfmbMOMS.KVPA1xvNNhURyXTy3q
 7qpVJoTt1ARV65MhaeCHOxW5E5R9y3LKgge7m8yeVcPWStT0DmJWGlM6mmqzi8PdSbMhxRAcoqXv
 y93qUYX_2Bbii.xE_ZzCjSaYvGdLZYBAmglguParwN4_6.duAH_oZY3Y1PjoKeocysTrOqcmzcuZ
 1IBh4cEtLHAyLjjSRH4lmsbQRmcliJWy5hw4PJPbAPr0cwxksTHeCTq8hukO8t5Jq_sjS.J4bxiM
 KdBxLDDsRuQ0Ladd95F7M.QrjhU95nOBm.Wc5oqppD8QMp3lcoGzzzsrxj4ut3lBbUKZdHQUqne.
 vo2b_EfYACBLDnAecpK7mY7YcvVA3ZIDrv9.XGeQRr3SxLlPg1NZnNGmwh3mjJ42.0UDk05mDzBZ
 LQ0t9TbO5aEEcsZsZv049g1Qh8DL1QXM05Osag7gtSZ.v1ofLm1ZLNvYTHc1HVQg6wh7jC29sxtq
 hN57asglum0y0wdK6mZcI7ItWFEvXtomKrxiPhUv52zhogwdArIiA36BE7i6onlE6mv65JjBRX.8
 nfk72PZ6X58z7B2GNx61t81DmDw0GhTQwoZQEXje4RVlhpcPnlYOo.tv1Tc6QZRL7xYbZfSQA67C
 _o7oG2a9Q.J3VktQXxVRe35UIpN.Aif9u3cp7ReqLr5HI1WNNqXL.I70MEMqWBNefSQ8bQYGSiZc
 Onfu6Msnw2VVCM.4qvjl51Xee8XNiRQsZjt8NeSq9JkftbWUooKkFptHcLMRDc0XUWwSSrvaabk5
 1IIMi_iqcqcxHVJJASi4yo0BCItXmhgOXZsu_Jt8VrJ1D6aiCaRTHj5QvFMBKehNiFeody4zYKlJ
 7okjTQtJQKYqKBXulWWTOQpl30qCo6EjiU7rwiFIxjGQ9HSs0x5MeZNATXzh2D31H4qVF1c5w4E5
 jcvqhNFk285wekJbB2zQMYspsoTId8xtBrNK_OLTjVY2VCVzewIW05_.9pZpWu.IDgA.n.vAzRNQ
 uoVIG5PP3rWnvccHDXc9XZQFKV_D4cwNSrqwVYiNQmj2oAcW7Z4iPWXS_OzibbGIANlafMKZWUEZ
 7BvyT6PsFpgCZ1VP19Bdnl3UdvIdfvZp84eoE6EOn7aj0MgXcfsI-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Tue, 18 Jun 2019 23:07:01 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp416.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9bd52d88915a86244e569f3c22bd3931;
          Tue, 18 Jun 2019 23:06:59 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v2 18/25] LSM: Use lsmcontext in security_dentry_init_security
Date:   Tue, 18 Jun 2019 16:05:44 -0700
Message-Id: <20190618230551.7475-19-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190618230551.7475-1-casey@schaufler-ca.com>
References: <20190618230551.7475-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Chance the security_dentry_init_security() interface to
fill an lsmcontext structure instead of a void * data area
and a length. The lone caller of this interface is NFS4,
which may make copies of the data using its own mechanisms.
A rework of the nfs4 code to use the lsmcontext properly
is a significant project, so the coward's way out is taken,
and the lsmcontext data from security_dentry_init_security()
is copied, then released directly.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/nfs/nfs4proc.c        | 26 ++++++++++++++++----------
 include/linux/security.h |  7 +++----
 security/security.c      | 20 ++++++++++++++++----
 3 files changed, 35 insertions(+), 18 deletions(-)

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
index 1fd87e80656f..92c4960dd57f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -346,8 +346,8 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
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
@@ -718,8 +718,7 @@ static inline void security_inode_free(struct inode *inode)
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
index 2ea810fc4a45..23d8049ec0c1 100644
--- a/security/security.c
+++ b/security/security.c
@@ -453,6 +453,8 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 		 * secid in the lsmblob structure.
 		 */
 		if (hooks[i].head == &security_hook_heads.audit_rule_match ||
+		    hooks[i].head ==
+			&security_hook_heads.dentry_init_security ||
 		    hooks[i].head == &security_hook_heads.kernel_act_as ||
 		    hooks[i].head ==
 			&security_hook_heads.socket_getpeersec_dgram ||
@@ -1030,11 +1032,21 @@ void security_inode_free(struct inode *inode)
 }
 
 int security_dentry_init_security(struct dentry *dentry, int mode,
-					const struct qstr *name, void **ctx,
-					u32 *ctxlen)
+				  const struct qstr *name,
+				  struct lsmcontext *cp)
 {
-	return call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode,
-				name, ctx, ctxlen);
+	int *display = current->security;
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.dentry_init_security,
+			     list)
+		if (*display == 0 || *display == hp->slot) {
+			cp->slot = hp->slot;
+			return hp->hook.dentry_init_security(dentry, mode,
+					name, (void **)&cp->context, &cp->len);
+		}
+
+	return -EOPNOTSUPP;
 }
 EXPORT_SYMBOL(security_dentry_init_security);
 
-- 
2.20.1

