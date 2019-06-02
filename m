Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4826C282DC
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89FB9243C7
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="BsjqrDsc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfFBQw1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:52:27 -0400
Received: from sonic302-8.consmr.mail.bf2.yahoo.com ([74.6.135.47]:44844 "EHLO
        sonic302-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726084AbfFBQw1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494345; bh=GPvWJDPXSClM26o50qIJxfLTG9C4Dy1cxsnhyj+//zw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=BsjqrDscnkX10X+9vdFINt+Qqxxd3DhvWRMczJg0O5F7lWdNnNgCU+pxvrnShGVoHJApULUCMZbU4kr/of44TPh6wwuADAtHpOWxl/jq8cCBAVsOTG5ERVjY31yxa/WwPxzz8GbYbOkfRGvNYCLhF350N1vKigBKkWclhk8juL6WV7jt12dmybmuvODITAuVzFnIOhapzV22vn6KtmVpTSgwzZi+2MXFW1ZYp+6cHeG1CRJZGVf4sbqJOSBGhW+fKG2lQERUfDRHIAVn3EWm/fV4uH4vodg6tBmE9TCu8SYTFaUyu2rPa2hR8UM/G0VmV5OqntUFcvRQXDRFUwEBaw==
X-YMail-OSG: P61FTtQVM1l6Kw8KHRZD04agvBf.51QU..DOS41thBcGghX3dKIJmMddR_9Cyop
 mYEwnxCp5yE3YRysRuQAEeL8WZgnmlr2wzaolMwfbq_E6xcnbb0o72XPVQdcFRfIW_gQBQsWgt.Y
 gBYSpoi8rJQuidRbK2ZXL8ooVWueKs.o6qI1I7YzVxZqxz77thmGBcYKiH1Q4CyO0zqNgcH3LLQA
 3eBKNG7jUUhvuCwbGOfz94E8ZsQiNEMG6v_.Qnhmzlf7hCNAz76faWJo9DAG_tzPDkgVtq1JMg5Y
 e.J3qa_ns_H88auJce8_iUc4umjPHA0OyV70OyYlPoa2ARyYokjIYdUeahe5XP9ZRHv14Rpjqpj4
 7k_B_GQGgvDmiYxTtW6axgF5qwwwk8lhHaTqxYG0MRecM2L2pwMGnchsj50ne6N3lErCh8nSOf.p
 yFK9joEo6j9KaeEM7nK3luO4ImtVjgxJFxxuiPTJnx.TfNieEf5QYbhnRZ47.uMUD9eIiUBsPB08
 ziYMK8oJWIaJACtkG5hjCD4RzR5L6Gum4.4One8ztOfH2EgZmt8jE9IA4GMfe5heDAsSh4WyDNzm
 qpwKfYPxCV09RSDOV26vnVwhZROR95GZ1SgeKiyDu6dSKfxI9zYpNmbaPbmWF2QOKymbqx3LopMn
 1w6r5R8R4i6PQ01y9qf8SJRKllpDcr5WeNG9g.R6iK6h_xPpV7dumx1e3hHZBVgKD1vqARSbDpuV
 bQUyQ4i2e6q6sbohKUxs2BEdOMljeXd5I3TauUEJQE.Wd0i1VPFd5BawYFsgHGGSiS5pG0A6n8yq
 jtfjB5jEHXpVpsZjWzrMrZmKYLZ6Tn6Zb9IHU6jwSwynDFyEaMrqZ.KZMMGzO6rbFnrQE6bCNdU.
 _6qc8pm21Nr8BciVrCs6JizUnDuoiZ_F_aKKMPyMpq7k1MmTqc1lXCN8uiNEkj.CapC0GmRjJem3
 8rtnlkTiEHCHZTYdBidm8HgJczRQlfbd_FxKWH5sbXhi8LbTL.ayJqOKWCB6orcGkTpoOAizVtS_
 KqS60q6N.loywBBQB3KLczB79qEWT1Wk2ou5n.BcUY6CjS4jKbY66VK84XZ7e5cwUMnu.Gox6GbD
 kLVG_YY_2RQ86fMeysLseo7Y5Q_8NiRf76_ZRyHO_fYCd60.i0OGdh.nDPa_LekAE7c2UF08Gr9F
 6Z5uGspZa56BE9yvlDtJzSrBZo9DJfICUNSoRkYRaBO9obGZ.mjqrqu7Fn1QCGCCP.U8VDA9Mwaw
 PLS.c6I5KLgXsjskkhLSjgd0o2mOpFje0CLsPOAntybCtvGLZ5Zg-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Sun, 2 Jun 2019 16:52:25 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp403.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f0b498552947f6b5133c1cce9fc77f09;
          Sun, 02 Jun 2019 16:52:20 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 20/58] LSM: Use lsm_export in security_inode_getsecid
Date:   Sun,  2 Jun 2019 09:50:23 -0700
Message-Id: <20190602165101.25079-21-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert security_inode_getsecid to use the lsm_export structure
instead of a u32 secid. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h            | 7 ++++---
 kernel/auditsc.c                    | 5 ++++-
 security/integrity/ima/ima_policy.c | 4 +---
 security/security.c                 | 8 +++-----
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index ae4c058abc5e..2d04687c3fa9 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -356,7 +356,7 @@ int security_inode_killpriv(struct dentry *dentry);
 int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getsecid(struct inode *inode, struct lsm_export *l);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
 int security_file_permission(struct file *file, int mask);
@@ -852,9 +852,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
 	return 0;
 }
 
-static inline void security_inode_getsecid(struct inode *inode, u32 *secid)
+static inline void security_inode_getsecid(struct inode *inode,
+					   struct lsm_export *l)
 {
-	*secid = 0;
+	lsm_export_init(l);
 }
 
 static inline int security_inode_copy_up(struct dentry *src, struct cred **new)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index b06ffcf9bb9f..71daead619e5 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1908,13 +1908,16 @@ static inline int audit_copy_fcaps(struct audit_names *name,
 void audit_copy_inode(struct audit_names *name, const struct dentry *dentry,
 		      struct inode *inode, unsigned int flags)
 {
+	struct lsm_export le;
+
 	name->ino   = inode->i_ino;
 	name->dev   = inode->i_sb->s_dev;
 	name->mode  = inode->i_mode;
 	name->uid   = inode->i_uid;
 	name->gid   = inode->i_gid;
 	name->rdev  = inode->i_rdev;
-	security_inode_getsecid(inode, &name->osid);
+	security_inode_getsecid(inode, &le);
+	lsm_export_secid(&le, &name->osid);
 	if (flags & AUDIT_INODE_NOEVAL) {
 		name->fcap_ver = -1;
 		return;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 090ef8ceb116..280f2410e551 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -326,7 +326,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		return false;
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
-		u32 osid;
 		struct lsm_export le;
 		int retried = 0;
 
@@ -337,8 +336,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_OBJ_USER:
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
-			security_inode_getsecid(inode, &osid);
-			lsm_export_to_all(&le, osid);
+			security_inode_getsecid(inode, &le);
 			rc = security_filter_rule_match(&le,
 							rule->lsm[i].type,
 							Audit_equal,
diff --git a/security/security.c b/security/security.c
index 22ea709593f3..e12ce930dfd9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1387,12 +1387,10 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
 }
 EXPORT_SYMBOL(security_inode_listsecurity);
 
-void security_inode_getsecid(struct inode *inode, u32 *secid)
+void security_inode_getsecid(struct inode *inode, struct lsm_export *l)
 {
-	struct lsm_export data = { .flags = LSM_EXPORT_NONE };
-
-	call_void_hook(inode_getsecid, inode, &data);
-	lsm_export_secid(&data, secid);
+	lsm_export_init(l);
+	call_void_hook(inode_getsecid, inode, l);
 }
 
 int security_inode_copy_up(struct dentry *src, struct cred **new)
-- 
2.19.1

