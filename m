Return-Path: <SRS0=/AWk=UR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B44C31E61
	for <selinux@archiver.kernel.org>; Tue, 18 Jun 2019 23:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BEF2080C
	for <selinux@archiver.kernel.org>; Tue, 18 Jun 2019 23:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Ak2KSIRg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730955AbfFRXGr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jun 2019 19:06:47 -0400
Received: from sonic308-14.consmr.mail.gq1.yahoo.com ([98.137.68.38]:41546
        "EHLO sonic308-14.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730966AbfFRXGq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jun 2019 19:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1560899205; bh=UAYkWoZJI+Ldnv4tfh6iVKQdabbvPIitF1HrrIh8xrg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Ak2KSIRg6fws3RdoBI1N3sJax27ZnxBFcJ9fHaBm4Mu1VzbWvuYop1BNN67kLZtgF+hEA3qlgpy5YjBeUe3DIryoDAxrU7S3t6gIZDZRDePEXzmoRX0hH45rIRfehfRXF26hXUNV3QFEV4Tvccfyp0RI2bxnG174EXh88YxWIvJME2Jb16vLfzLStuydwba9JgvLp3JrK1LoJ2gMyKLKrtcowzQwvOZr/AMcDh0TqNPloKLzyR/kil/M1ldjZcjU5C3Qb1coYyEfSTI3/b0GAREeYNi40tfjda5Iz1aaVqVpjOhCt6WeHGHaANXuKu346V7x4KIUS2FQQgEUnngOHw==
X-YMail-OSG: htoFXe8VM1m_s.It3oBkerBjFcdHP7ck2EwgIi3NY7OxE9ug7EibVe_iMddVTpH
 YWzgVAP5VK50VHLY9E3JtwctQnUQEwuJUP8oGikTdCoQLCepr3g2tFGINDMG5ENh38G0mL.QXV6X
 7sy7Sh78aLKUQUNSYfnWkIqWIMG38nKc40YZ5Zj7b2bbH4Ggcn2YXqUkBzgqEB6U7SWJkSI9Wrqp
 948vtZZnwti21BDUr7g0abK4z1000BsteCgF8eETDMfTaR51nI9CNSKUb1OmE8rfGDAG6LrdqUgz
 yJBX6fLNVj_IV5585vrDgbndzKO3WZhw6jZdZAjNwH3aF2wfdknuGAaWU37y87Djj.E9YG.LaEqm
 Hphq1roO9rcbh04KDcD8uEqVyefooksHrjqweKOXOTrhUh2kcqOHSth6t7WO3nA1Gnkw9CrojMsl
 iY1oIcmncXUi7F9qnuU647BvP9UPFuYCZJQhgglcoA4e2fEykdWXkI1ArpdtsEQae5IhC_swl.hw
 SoTYC69UXndDgejPjDBpUQFpGcv5lArxf4CD022Kce6cq_GzNRC0JJ8tTJZRMXJBP.p9TglgqF6n
 xFveoKmyAcd0cDmiVsDiqMfYmT5nyav1yhMvT4bpT5zgLj.skyyeAiTXMxMBYm7WB87oSZJfd8AR
 EcviN6awVXdTOkzO75daMq0IAfo.dYMtme6BHzkHpFn0vKeeXJj3Qre5axACj7JkYFRkSCvjjJ11
 Z5yWU.uVcJzfP7bA59dAQHDLRqf3nxvDj5E4c9tY1qgL3ZmXtqy39ozJTwJx.qXOJHrAQ2RXIVV0
 JFDjMNtEgXVMsTwdCToZ3AI_FHXXfvHF_iifvZiSSpex1pjbhNfU..bgfWyYel_ey41mwRbTnS7D
 Z51M4KuytLb4kf9z8AYnbXBRuXGb39GNsyenap4MrLxRNyLMHEz2UkjV0mojHA23ReAgvQB5aiHx
 FjM.fOjHlxMmwm12.gk7ieEOvCaHrrjm2l73bi976eSBQdtJWieOKbU6hZovXlJzEMKlJZIzGQkZ
 _mtc_OS3RPJz6JkuQuL2AgJLji1Srw6XwI8tNiypiAvhwFoKmd.y3mKKLY93TC9HTdJSxkTD_WNd
 lrE8CJ0qopV59o2jIvawTzKsP1xUrEaK94fSFZKX4_PMYrSkH6Ug.sy.5fP91Ktgk7Np2D3Rc.Dd
 BRNxWeti8T8Fm081J.N1UcGgyslhJXsseR0Tcmf.o74nytTWC0_Xcai5x2kzKa6FvOlOpzBKirr.
 hR475J_c4GAxbac2.4iARI89JC...ZKD_N5zl
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Tue, 18 Jun 2019 23:06:45 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp427.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b5c484e6312471c03acab1f233ace257;
          Tue, 18 Jun 2019 23:06:41 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v2 12/25] LSM: Use lsmblob in security_inode_getsecid
Date:   Tue, 18 Jun 2019 16:05:38 -0700
Message-Id: <20190618230551.7475-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190618230551.7475-1-casey@schaufler-ca.com>
References: <20190618230551.7475-1-casey@schaufler-ca.com>
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
index c73ad27a01c0..b28d4f9c7714 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -358,7 +358,7 @@ int security_inode_killpriv(struct dentry *dentry);
 int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getsecid(struct inode *inode, struct lsmblob *l);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
 int security_file_permission(struct file *file, int mask);
@@ -854,9 +854,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
 	return 0;
 }
 
-static inline void security_inode_getsecid(struct inode *inode, u32 *secid)
+static inline void security_inode_getsecid(struct inode *inode,
+					   struct lsmblob *l)
 {
-	*secid = 0;
+	lsmblob_init(l, 0);
 }
 
 static inline int security_inode_copy_up(struct dentry *src, struct cred **new)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 851947a77a16..cdd1dd9e0eec 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1908,13 +1908,17 @@ static inline int audit_copy_fcaps(struct audit_names *name,
 void audit_copy_inode(struct audit_names *name, const struct dentry *dentry,
 		      struct inode *inode, unsigned int flags)
 {
+	struct lsmblob le;
+
 	name->ino   = inode->i_ino;
 	name->dev   = inode->i_sb->s_dev;
 	name->mode  = inode->i_mode;
 	name->uid   = inode->i_uid;
 	name->gid   = inode->i_gid;
 	name->rdev  = inode->i_rdev;
-	security_inode_getsecid(inode, &name->osid);
+	security_inode_getsecid(inode, &le);
+	/* scaffolding until osid is updated */
+	name->osid = le.secid[1];
 	if (flags & AUDIT_INODE_NOEVAL) {
 		name->fcap_ver = -1;
 		return;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index ae525a89e07f..6757cd6f4027 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -326,7 +326,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		return false;
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
-		u32 osid;
 		struct lsmblob le;
 		int retried = 0;
 
@@ -337,8 +336,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_OBJ_USER:
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
-			security_inode_getsecid(inode, &osid);
-			lsmblob_init(&le, osid);
+			security_inode_getsecid(inode, &le);
 			rc = security_filter_rule_match(&le,
 							rule->lsm[i].type,
 							Audit_equal,
diff --git a/security/security.c b/security/security.c
index c92d6e04d577..e82994667263 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1418,9 +1418,13 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
 }
 EXPORT_SYMBOL(security_inode_listsecurity);
 
-void security_inode_getsecid(struct inode *inode, u32 *secid)
+void security_inode_getsecid(struct inode *inode, struct lsmblob *l)
 {
-	call_void_hook(inode_getsecid, inode, secid);
+	struct security_hook_list *hp;
+
+	lsmblob_init(l, 0);
+	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecid, list)
+		hp->hook.inode_getsecid(inode, &l->secid[hp->slot]);
 }
 
 int security_inode_copy_up(struct dentry *src, struct cred **new)
-- 
2.20.1

