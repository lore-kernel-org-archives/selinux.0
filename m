Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7D4C43603
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1100321835
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="f1RjrKvu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfLPWZX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:25:23 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:40036
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727189AbfLPWZX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 17:25:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576535122; bh=uQ2URDlGHwivvTFxlkJ4ZmBWhh8fhZMuYTKrwyBZ/Yc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=f1RjrKvusSGHQ2iAL8Izp0VzZWlZFSuZpKpdDE4qYUi7RdBx3xmh7hWV80cHpCaga2mdxXPAAcOJI08idJ32t1jmm6UJb/nISP453cjhDYfZ9ABnv5XzH2kaD1I3klfIG9mFuC3Jp9nCPxe6evCd3KZf9N/sVjO4c7wJzhHjj3MhhdnL1xbGpigiu32IDoKlAQsYqv3oZJIKdddrnAEMXMtKxGJbzkHYfoSoTGk//42tg/gcRVhLtPTBLYb52BSbHiMFQxuI8eS0oOrDSLPviS++KwLHxm1eJmGYJ+5LDvGeM5IvBkJ42aDu+Z3Ll3NauyQq7pu40a5/zIWIJBAe/Q==
X-YMail-OSG: gXstzTIVM1mGKEwmxHPSFCjCmMEfvQgHcF0nmCxS.RJ4ng1VDO9X_jm8fl_qe0R
 _tkGrK4X1mAmmXx6HjqDLKxKYe_qvs9_tl16QOPlNDEbynY8T7bKWT1uqggBCfaoM_BNGek_HAb7
 2.m9faUira.zHTygcIFZeBmVCzzs7bEAMQdUPG.s5HnY8cU46zlOd4II4MbZ9_mCXVV2GVrx1dUx
 ZVQdOkUdqfqrrjmjpaUJSc3mjq2tfsc6R1gkZKsQIUmFeUW498cNfGg5fIltSuK68g3zEkT8QWix
 3TQbWLTCBgKrGNejdM.GmvuO9nu0ZSXWZW2BDLbc7eD0HCZCCaOaAiw6h6D3GCgE9MRqgekhaLSX
 DBU5NEgwY4m0bSaK8K..M9vbpsVp_ec2SO7t8hr1Gy4Uj1z84TZP1lJQzlUYdaEbeCP3px2ZBS0o
 AkKRIag29nV5P61l2myPOF3XO2T_E8zm9xpHqejA2coss1o8jzlVXagK51l8NdA4qzi0WNiIh8Ya
 B2dii7PLs2p8LpYK5n1bJm0BBFQbHWOoQorCI9AAW7vZEW.qjYQ4amGOkwrdrwcZq.a7jmjrUQXS
 OwdYMIt.3Mg2Hu7pnvaPEhx6aJdU3dbzQ9zlUN_VBsLhZxF0bSuMx0hIhOrE6YMZ97JESGVUccFb
 6tr5IgExCptVSeIsDbpOVdn0I2RRYg1cjtqhCTHv6f5aUtCGRePSk6vMS1e9LJwObIf9wyRWCxLZ
 3Irt9VPKxg3HdHwVwCHkRThKnzGYPsajcyYG2XS8h2kBCyTbiKE7FeQAHBxEtOGsg2ZW3LhMmeeT
 PyzewCiFQn7SsAWxgD2pH0kE2BT2qAH0nWzxOLsZbs999Hmj3aKBPmjK2YXTOFTn84tNRzq5IO.F
 QToSimIcUvZZztfJYTwcEy4xU_yKTlShxGbJ0NZ2FiPnE2nM0ReTXaIdyTFbKtkxFh7_kQElIuDN
 aB2Adtn7K8FmszfJhj3cJoHu6mD_jSFNP8Vg9SS3cv_90qgT03MePsjmdSvHXcL2o3CH13B9Auaq
 gx.CoGEMIIycywMHKFvYs.zkaOYTuUlVnbFMKj9jeFGcdk_fNI8jJgxK2uVOs36Op.a_p5Ekg6Jx
 _BH4pdEyzroeuwHqwgjh5wdFI4e2BKSi8QrFYHWdnU0KhMcZTwLdHuaYdgHu7gAigWPF7YZWMJgL
 Ofifm64Jo4iUCMyhSs_9So1PwgUudGJi7J5Q9hNg_bpBZadWSHMxhyIAks9f.9f3tLHhxEu_RA0l
 nd4HhUYGgHMoAIsLxJtwXjDAPpg5hgTaB.Acfyiu7kRTUXFVN_HBo._VgG7HSSRraayK4lxnG.YB
 dbARkS7t4nlOHIp.zGuw1cGDHEBB5egGz1JYPi_5ZCXsMPyvZuDKf4cf5h7RCE2l9kz0cq1dXSUV
 FgC91XcjYJNmK6oXx3Ib4th55iwQT9Nev..Qe4fsfH7mzps5NOZqWkHssKH9zA._C36Yw
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Mon, 16 Dec 2019 22:25:22 +0000
Received: by smtp403.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ace9b923345e057175895f41ef70a2ca;
          Mon, 16 Dec 2019 22:25:15 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v12 10/25] LSM: Use lsmblob in security_inode_getsecid
Date:   Mon, 16 Dec 2019 14:24:16 -0800
Message-Id: <20191216222431.4956-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216222431.4956-1-casey@schaufler-ca.com>
References: <20191216222431.4956-1-casey@schaufler-ca.com>
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
index b6d5475f8196..e0acc09a79fe 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -409,7 +409,7 @@ int security_inode_killpriv(struct dentry *dentry);
 int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
@@ -924,9 +924,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
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
index 193ddd55420b..c7d2ea47a326 100644
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
index c42573958630..66322a2a2beb 100644
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

