Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E8CC33C8C
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 16:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA884206D3
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 16:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="MWDN0KTq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbfKMQwO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Nov 2019 11:52:14 -0500
Received: from sonic313-14.consmr.mail.ne1.yahoo.com ([66.163.185.37]:41811
        "EHLO sonic313-14.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727112AbfKMQwO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Nov 2019 11:52:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573663933; bh=fVLWr87l6j0R/gnScLqNrHSBH1hKgEnFzkqP1Bp6da8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=MWDN0KTqFRGL6PyFl6uZD5BbsXJb8h23Hchjhhg47NNDWKaFc0HffCQFb03dGOyN8LgBxEtZuZKzQISuacrlPvkBdXduKW+FtAcHrM6WmU/vtkFsM4NmUr+qcxOE1VSVUsmE6SMY9phCoCMzwOvb/rv16cbU0WAZ9Lx/9UpiDev7NVi0DIqQKTEQqxcWuVdIcvJrCs61/2+txZm0cfBp5vMdTZSw9FUMuwn2vMt7v2H0HbRKCQLS0UqDAHuzTRN1QiYMGW3GYIVPHeyEckO6j41ME1rRrD5VBxSh+S3HrBLoQmXOKPj4JN18Y3Eby7nQ0E4tnQLYM5ZUEUvWJqIcDQ==
X-YMail-OSG: eVp_7AYVM1kaaHmjhM6tYP16fr0mquKLp_8LtAB6mKfI6Gn9OcOF6WpEweuh5Xh
 vBaaQZJcmwgeyFEzIVpwqqdlnLuSiwxmRwT9_mYs686X1qw.oze.Y3kNbhajCTyZxHkPDEIOR_0G
 iuPPZQ99LJNysqY3xZYoNS3qGwhY4D0BYZXf0I.h4t1SEq_dU.7TL60PEJgWQPDQLb71pMxTF8pt
 16w6kXQ09ryUQBMWtf5wZQziPJ6742.QBdcWGiLgQw0upUj0STqA8Ki_9ibv1ozYhOAXqF0hA_VH
 lC6GRRzJPdrY7YZQCJvid0lTzLqrtLrvoZoaxg_ivWWxgpt.dcreSBBSQNQx7jXvHmDgg4mlTUJh
 MVno_qJMDiHitYe4HNXOdc.z9lP9GL9OQbcA1IoPyJ1bKf1TKrpdxVc6fddR.Yb0aR1nZfjughAz
 esyfp4kZ8.7mDGQoJDfh8xPayvp6ql8QEYS2kbHU28jwjKCgTNc4r8lFI9OOJp.fuY54pvZ1pAz9
 OyNJn7CSrMpS0gTYxWlDIpkXfXXtBhEY3uf6CFZwqleMk1YRhdrwPb6.FRU3ONGxH79NCq.A_rLf
 tno3XcHNXf83DMjCWyT8AI2FDy8k8ssJGtHSJJI5qzAxcIxrtw.lCEnHLmMGJ9mgJb4tuZgFWer7
 IyBZZh3q3J_sW_d5ccFCTZykWRKa_cVhCjxGJjglFBQ2ifCbGTsgKrRiwSeGTkM8Fn7QrevKsYv9
 d6XGLYWl74q3FGxbn28_gh63vXHB_8aCW8Nt4k2a8jof0vuO9ai73LlGs_uCldEoslpcyeupeLjT
 Lof.tvNj_CSTOIsEpo7_BPCBMwxQsWu7wQbbQe6gwRgPMnf5u90F6gLlO9pdghTmLuPW1Rip6AXF
 sS9ZemY36_fVj6BT82b4qE1_Ce7ScIesoR5REzIPFuyqyrdiwGswbJG6R447eDMo.9kmmAdf4CCD
 PAGqadWIGWUaPJF0cy4IY3iQ0AKLEUL2SfTkllJyjjimXwmKpRzOsPvNsiBm6nRFiany9O_2Rsg8
 OkUAckAJ7QSjZSJlk6pkbTp4KUvmw3LbZlFgnE541xTVWBaC3uJzBEC57g2g5t3RMZFWpkiTZ9a.
 Dh_Bz.IU83dWyKUHnH7606Z6_oGH1m05bVotzJ3omywtZCbfpJtWAWLW_SPdfNMw_fjEZNZFZTgq
 19rvhGpyCPPa_UA6KVAJ99reoYchZgaLLDtGCFTiGTR6LDkB4nvBYvsN3KvwNfwUhQhasVhD7fd.
 59UQWa8J4q1C8ISewXJTLZbxMWm4bCe4p_LWxGCJMwMBUy9yloWWm5GmTR5mX3..i17TfYNRGWmh
 h2gcUUhjTrRzLiy_nKx_nE.MFgLUtMcvVj2GzCVBoFcdP9B5x8utDWFAPnsTxdrzDeB3ZTjGpTT6
 uonVI96rTtnOdDdInQ0aHa9YQC3bTCM9HGQVrm.X4RJOB.7XrSwpP9nz14x_.4IBcShgQW4uyKvc
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 16:52:13 +0000
Received: by smtp412.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f3b88226f6e8715356d93ea0c8357736;
          Wed, 13 Nov 2019 16:52:08 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v11 10/25] LSM: Use lsmblob in security_inode_getsecid
Date:   Wed, 13 Nov 2019 08:50:56 -0800
Message-Id: <20191113165111.6744-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113165111.6744-1-casey@schaufler-ca.com>
References: <20191113165111.6744-1-casey@schaufler-ca.com>
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

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
cc: linux-integrity@vger.kernel.org
---
 include/linux/security.h            |  7 ++++---
 kernel/auditsc.c                    |  6 +++++-
 security/integrity/ima/ima_policy.c |  4 +---
 security/security.c                 | 11 +++++++++--
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 67f95a335b5d..a845254fc415 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -407,7 +407,7 @@ int security_inode_killpriv(struct dentry *dentry);
 int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
@@ -922,9 +922,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
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
index cccb681ad081..5752e51883d5 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1931,13 +1931,17 @@ static void audit_copy_inode(struct audit_names *name,
 			     const struct dentry *dentry,
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
index 7711cc6a3fe3..c5417045e165 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -413,7 +413,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		return false;
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
-		u32 osid;
 		struct lsmblob blob;
 
 		if (!rule->lsm[i].rule)
@@ -423,8 +422,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
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
index e1f216d453bf..bd279a24adfc 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1386,9 +1386,16 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
 }
 EXPORT_SYMBOL(security_inode_listsecurity);
 
-void security_inode_getsecid(struct inode *inode, u32 *secid)
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob)
 {
-	call_void_hook(inode_getsecid, inode, secid);
+	struct security_hook_list *hp;
+
+	lsmblob_init(blob, 0);
+	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecid, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		hp->hook.inode_getsecid(inode, &blob->secid[hp->lsmid->slot]);
+	}
 }
 
 int security_inode_copy_up(struct dentry *src, struct cred **new)
-- 
2.20.1

