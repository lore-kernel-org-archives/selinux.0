Return-Path: <SRS0=kEwY=UU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF2CC48BE0
	for <selinux@archiver.kernel.org>; Fri, 21 Jun 2019 18:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD90208C3
	for <selinux@archiver.kernel.org>; Fri, 21 Jun 2019 18:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RP1abLM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfFUSxN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Jun 2019 14:53:13 -0400
Received: from sonic310-22.consmr.mail.bf2.yahoo.com ([74.6.135.196]:36971
        "EHLO sonic310-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726395AbfFUSxK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Jun 2019 14:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561143188; bh=KAsTVg8GUa1LNW79L69YvcC+dYyTvzmUs1F1m+IWYl0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=RP1abLM71r2++hltL7hjD8f1JUvTumUYMtYVQfDW8xBOfORs/BLHkFfY52LENY3+c6F2I6/XRIaxbowd4IWw4FnRhuUyxRfeITp5oybbGNuYDCXxfc5eLS29tiBWCS6U0522KBf99/jXKKPSO+Fj6Y2tM5b2zg6owocxwa0G4MkCE1pZllOJ1k1nOVCDjByqJKNYrV5YfscLuGYRVy5j0dT72UfwL91bE4S8lSy1EhNJjRZyxBeguXoVE3k2Xp6QZs9gwaAIVfpP+NJFsPSM9OWHzGnCKc+G32Fd8M973TsUB9jH+lj3EX1ViCKJj/H35p3C+IedZ8Hi3QQ9p4tDDw==
X-YMail-OSG: Q5TjNnMVM1nOq1SU4kqrmspjhk546dVqbZI2T82tuKA.8l6uPYAtlo4I8qTqTyj
 jBakTD5G7eKYGF78m7Ma1YE8spKja0utWYu.5RLQivwJddSmonpvhP0jT.fKNkjimsJeSQTMPcAP
 FYVBkb8frs7_JusUFIGcn4dcNkQbjmS6SBjDXY.Ga86kUYKtyWBzL1hx6Ab5L2g2uN0KYfToxz3d
 E_Ubs84o1kUUyBNrzN3NUxWmT49q5sqqt_3PfXkiPpFjaXJc910eHnp1A50jiBWv3Nw17PW15lka
 bcUVSQx4jwvYanXEKsGsqOVcjkj0QvIYXmD.O3rifTk9wlSB3yotQzILmWkFl9CMNySFCZVBSTw.
 yBKeztquUO.ie1NEXL90ikTDudgXPEPMn1DIayQ43CFePE0peSJ63c2DWpbsDOPv4AjocUCxURxs
 wsqjYRbboAgr1ZJem6CNLj7VnNkbTCF4ZVomHN4lr23yB71WHyvueIRW0QCo5a66MiGzv8FNq36m
 t2ORhsDnifqzL1jBGag_DvA40LyMtlRdkj38qO322ZQHGa70jUiDvRkE2oXZWbe_8MAMPiXh8wL1
 u_W2U_H8qzfWgKOYxoF6rhZCcqDFkJ.4hjZ9W.JPS7NGAoZCAsRP6stUOCEgmTxxtYvUffYnPf.I
 WnEXZOj9bZsWxW2CnD2EsxIzlSIFO5GLjrssQjw5RHMOdnVqHFV8wNFLanULU6NEXt9vbAfJGUun
 2FwPxbI_T1NubcAtBGEeqHPfyq564gMNvNCXADws3AfdWaOQpLSFeVQBgtS4JIcm.82rQXH2Pxjj
 efvSzZ_aQx6a6Abil4PatPPkXKs0SUFvpjHJKVFi2miVf7BL.ThZ6n96.B.oUpz3hSkWJEDdgOVb
 9goA1FtInEMmhQWX_ITQlLB5NoS6AA4CFVXDZP5JIVeaPZ9dkQoHjp37LgoaL5xyWBd2OVx0IbAf
 0dmgoipPs8Yw.b7ifGAn6hcSja.I7w4iH1QsioBpqm8SEwiissnW0tErhesxhRKr6VvltdpGDeuM
 atSF_rcqauofHJTpIqWb09YnFRdVOf8N4z9FSyyERzLkWCg7VnfPUWqpgHGkUcZNx5pnBR1LYu4X
 w.zzO07hICrN7vfHwBFYeqGZbMl7MnUmmWlCBoovPyCXyjTmaka2v7TiehvdT8NlgXh962Ez8Ibt
 slbK807wfQ_4XoWMV_hKjEUdHsORJemxo7X9BmvN7q4YiQIe0R2bcgHkvW2rgFSzCtm7g.wz9jrx
 9qnMdfT.dpZl9fscxR2XbrB1rO9MlaDeGVMAZLleDGcqB3lE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Fri, 21 Jun 2019 18:53:08 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp409.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 989e9db4908b36ea4a327798a97c8ae5;
          Fri, 21 Jun 2019 18:53:05 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v3 12/24] LSM: Use lsmblob in security_inode_getsecid
Date:   Fri, 21 Jun 2019 11:52:21 -0700
Message-Id: <20190621185233.6766-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621185233.6766-1-casey@schaufler-ca.com>
References: <20190621185233.6766-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the security_inode_getsecid() interface to fill in a
lsmblob structure instead of a u32 secid. This allows for its
callers to gather data from all registered LSMs. Data is provided
for IMA and audit.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h            | 7 ++++---
 kernel/auditsc.c                    | 6 +++++-
 security/integrity/ima/ima_policy.c | 4 +---
 security/security.c                 | 8 ++++++--
 4 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index c5fdaaff8806..6eb64b7f878a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -358,7 +358,7 @@ int security_inode_killpriv(struct dentry *dentry);
 int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
 int security_file_permission(struct file *file, int mask);
@@ -854,9 +854,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
 	return 0;
 }
 
-static inline void security_inode_getsecid(struct inode *inode, u32 *secid)
+static inline void security_inode_getsecid(struct inode *inode,
+					   struct lsmblob *blob)
 {
-	*secid = 0;
+	lsmblob_init(blob, 0);
 }
 
 static inline int security_inode_copy_up(struct dentry *src, struct cred **new)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 7112fe31684d..54797c0fc3b7 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1910,13 +1910,17 @@ static inline int audit_copy_fcaps(struct audit_names *name,
 void audit_copy_inode(struct audit_names *name, const struct dentry *dentry,
 		      struct inode *inode, unsigned int flags)
 {
+	struct lsmblob blob;
+
 	name->ino   = inode->i_ino;
 	name->dev   = inode->i_sb->s_dev;
 	name->mode  = inode->i_mode;
 	name->uid   = inode->i_uid;
 	name->gid   = inode->i_gid;
 	name->rdev  = inode->i_rdev;
-	security_inode_getsecid(inode, &name->osid);
+	security_inode_getsecid(inode, &blob);
+	/* scaffolding until osid is updated */
+	name->osid = blob.secid[0];
 	if (flags & AUDIT_INODE_NOEVAL) {
 		name->fcap_ver = -1;
 		return;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index e7b8ce942950..92ee3d984c73 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -326,7 +326,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		return false;
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
-		u32 osid;
 		struct lsmblob blob;
 		int retried = 0;
 
@@ -337,8 +336,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_OBJ_USER:
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
-			security_inode_getsecid(inode, &osid);
-			lsmblob_init(&blob, osid);
+			security_inode_getsecid(inode, &blob);
 			rc = security_filter_rule_match(&blob,
 							rule->lsm[i].type,
 							Audit_equal,
diff --git a/security/security.c b/security/security.c
index 1184ef092bce..6f0635b51180 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1423,9 +1423,13 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
 }
 EXPORT_SYMBOL(security_inode_listsecurity);
 
-void security_inode_getsecid(struct inode *inode, u32 *secid)
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob)
 {
-	call_void_hook(inode_getsecid, inode, secid);
+	struct security_hook_list *hp;
+
+	lsmblob_init(blob, 0);
+	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecid, list)
+		hp->hook.inode_getsecid(inode, &blob->secid[hp->slot]);
 }
 
 int security_inode_copy_up(struct dentry *src, struct cred **new)
-- 
2.20.1

