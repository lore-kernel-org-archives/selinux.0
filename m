Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A74C43331
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 00:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174AE2084E
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 00:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="iJbFjU8X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfKMABK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Nov 2019 19:01:10 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:41137
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726982AbfKMABK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Nov 2019 19:01:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573603269; bh=fycG53F4jMtdrVcR7ZorR5vesqPHbEzCdlJdjHnAtaI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=iJbFjU8Xd72rOZXcOh2bbsFMcNHiZIwpRnVQbLdKJu0a3ZjmzXuAWXTm4vo+Y961PMmNRBw4zGt6ofEJMNpDWSmlXTWgik0GitOXDarfOvgMoe40a1l3ZVS9SulHA9gS6r2ZsJgiLXYb0cjUp62BI4ujjyumilnZSS7GwxLZMk3ubUkooZHfQ12qvFGWW1B26auNxKnTYaTMJgnWUCSppqEbrNXUBY5ftgzBJSxlostK50Pod7/SFSmsmmNpuACNLC/tBPb8P5QfO+k9fvM3vXMqzsdvL7NfmZDyv2xWh9lvN+/QWd46oDpFaZsz8aJdCOvPPj6o/bNyx6n6FYLkuQ==
X-YMail-OSG: ZBzqPo4VM1lUS9E6pdYfAvRPR302LYnqZmJ0QennKnVL_LVGDojc06ge8OscnKq
 cdWItveloKMBqM2WUjvTKdBdWRQKIqd.XyOiCgymgohGg8_MWOe.ukW1EHZ1hwG5BtKhwca7PJVA
 c_.Jp92Bkfyt8VWbd3_6N2.NZyW750YZIiJECLlDa1B2.RLT143lvUfUcuRyqLp5Dn0R47fXBRb5
 FmbAGa9xyJ4uxRtx7SvPn1m7pooXyuxRxi_wwMguLO9FE8BOmv_snrgkNH5_vmxwrfgAFnbVC689
 PjrkXUpvQnZyJ3H4O13Kn8_.yavxQfMn0kjhDKmhezJClHGsLm70VpiunjqH7eF5e.ERUu_rDLev
 9L2Pzjdb9.cG6PeJ81f7gBW35fP0PC8x0G_nhBIhxSLaMkPZx.0Xes6bJZBayzbYhEXzXcL2P20m
 kDYi8HUq91mFShKYV8Ga3Zi9dKqvBXInt2v9JLdGzJnttk8X4wyYH6yzXBiyh0fAQITt2XT4P8DZ
 iDaQnFdSctNv0sH8xeMB0KuidwTs_W2zXHRhZs3x2qvbAIOkrlxKv4asjGRWqUlvs0h6SWdZPZvp
 LWmxFpGqStzbHKhyxGokpfCef7L7c.JAvg_78Fz3i0suQdEydeZsPFBS9MSUhSZXcp739Gkm6L66
 VtK5TnZatvdaOezozgyXOQmNe8T6uiBNYVSttXkQxw5JMXCgu6XkXWOACCCxPLHpDy.6erWSsUCI
 HebEtq66t6IrhD2bbsldBTkxqwTOAiPZC1WzIHSQgzoBObVMuhKoJVYgaYm07PQni1o1.Qj6kjN9
 WbMMqzPCJO5zeLho2cgeTpSHOjbgDf__Pj6PvBG7FFcp9VBglgW16RBL1xklC5VFdr8kS.j2N32d
 EWrpETz4NYz138PgmPPCQti2Ry_i681spUAfYCqgaUEW99IMKXlaPNyk6fVN4kndquIRTf.k1xSZ
 laviy7AlugA3VOp7tkUg2tFxElrU7J4SSCJ3922w._ffiA.UxAY7D171FXHg9glZQy_tGdKbQgCG
 CCaHu8GptJ_B5.hCNndAaGxqeqsT99TAJaNR2yGzM7pM.Xn7moOJw9sozXdbQ.qYjhVlqozhQemB
 ew4nu4g7Iq7jmDXgJZW.4XsZ8hEJdY1AtKlnxW0b0ZUzpyYyoqCUDcucTNuxkZzMNhQ4o9gQHg1J
 BItrMtS_YsEH6CbvqOuxIyaTkyscZxlI7CNg7XfgFFp65WDOSQo2SPuqk969eG4IJCsbHqLHMJX4
 WU..uoRgJsHtKEzqg4Ois04AqYmOtMbEPOvoD7pHYj3NvSmHQsDUYxDRC1kKkdpDMoR1jVGNo1yo
 cwh8iEucZDyXvKq.j5EgQliKOBaUQfPVLDmh1E_72Qrgk3hWyMYYN71s8k5hgVX4gtY5DZ9NvUmZ
 NCS138bQCzcuwrLFad_i.DJS_4png7tMq4h7cOo2JNQSS7nfdliYDcmOIoSu420kRDg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 00:01:09 +0000
Received: by smtp419.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 498aa4bc8ee3a781207e3ee551d35445;
          Wed, 13 Nov 2019 00:01:04 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v10 10/25] LSM: Use lsmblob in security_inode_getsecid
Date:   Tue, 12 Nov 2019 16:00:07 -0800
Message-Id: <20191113000022.5300-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113000022.5300-1-casey@schaufler-ca.com>
References: <20191113000022.5300-1-casey@schaufler-ca.com>
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
---
 include/linux/security.h            |  7 ++++---
 kernel/auditsc.c                    |  6 +++++-
 security/integrity/ima/ima_policy.c |  4 +---
 security/security.c                 | 11 +++++++++--
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index cac477b4c16c..d48961c43175 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -354,7 +354,7 @@ int security_inode_killpriv(struct dentry *dentry);
 int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
 int security_file_permission(struct file *file, int mask);
@@ -850,9 +850,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
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
index 10ba7459f58c..d88283007ab6 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1343,9 +1343,16 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
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

