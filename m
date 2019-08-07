Return-Path: <SRS0=LK0T=WD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9D1C433FF
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 19:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27CB21EF2
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 19:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QZk/rpiu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387985AbfHGToj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Aug 2019 15:44:39 -0400
Received: from sonic309-22.consmr.mail.bf2.yahoo.com ([74.6.129.196]:42836
        "EHLO sonic309-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389094AbfHGToj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Aug 2019 15:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565207078; bh=uxcHwgOpzC/adUgk2d3S1gEWM4FTxZpivBefUTTskGw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=QZk/rpiu7VtT87huanqFa6f91PUD0zMWScwcX8+alzMojBinu6ZjyEzCdNbyTHy3I/CrY4Uc5oqnwt1v3zF1ESWqHva1gBEBnGBHHQ+4u4QfV2DUbSIWw5Z9Bh1yV9uZj+WkDg4qB8kzZOp7baU15XlVD6O0LULPKH8m5MIqnPaYHL/WDxvWpL8cRiQoomGzVqIKtspo8egtL2/x3gN+hM/xUQJR52Zyf77j3smsu/ZCUub3NAXWIf2ggN21vmGXzahyk1q+C5JqUAZHSJRptusFsCVwVY3MI9f/JLXY5n7CB59P/P02WR8C4zNrpL0GbgWuvCF9BSGyBoHVDq/OkA==
X-YMail-OSG: L1tfDusVM1m9aybYihLf8ykQl4geyynz61tXNcckA35opF99P7t1k6nCjKiAyVh
 uLqG2JswXmjGzWmIuuI0uOtf_7UtawJe46ZQSnqvOh8g2FRiN6E.0ryytku7hQutFObhXJ6uMjnU
 LaGLXvXaE309Q3ABNURXWcmhvWWx.PVygKi2UZ47oTZzHEOL872cv3zwPeHZfRe1cNanr6tzlOAB
 AZS_D5ng0j7gnOwS4Qm8qc20IkdCE5uefOOlslEEzzvdJK0i0w9FXadSSVMJ7.DHBG6kHuofDuGm
 bBRSlzSgQ36DufJ6F81Buk8Y.2nWvduMR6QG4BRvmzn9uOQNomSmOWK6EdMKx9a54uE.7xoldkYT
 TM4nYnLEX5p1LDeyzp2X6UYhbDwtQ1gimkYfKZHf2t8U07rskmky_QLnb4jbfZJ_XPa0tmhjsscV
 MpBTbBzfmioZMGkJniBaqeqUaynCsEaHbficDAoRCEIS2h4FNRE9Lkl4LwowwrE9WahstlzH4FJI
 e3VGQ02VEFHOkgFTt3wt6LkA0yMI.UO7FL1z3wB.d9hRhsN9bRgPDS3Jg3YHl2jAaqkD.0S.sOBB
 zobr.AUj0cwCD.zy3z7zWz4cjJ5E9I6GmJexcwqWuNTMJ6kAPf9NEoD94we3bdZVscxPO5NhbRj2
 Nap99nc6zt9_KEtz1aOCLKPAUjvfPMBv.LjJ95AugTejbj_LQ1eIfhbZToGIkPC05Z8lboe.8Z82
 2q51L.Jb29F151HnHw7ovnMHgQ6f0ATTKwtCT8f3C2KSvsADaoN16YFKZIP5tcbWUpefSxoHY2HN
 gBcldpvw4pJOANbZQ.joRM0zZ0.QjxQscLLnFIL0WUrWLO1cDXcmhg6tGUq9iUR20OvleYERJPV2
 AlFkCqrAy_YHGPVl8_svvEDYMnt.J0vOC.jATgNU6aU69TPYyw4dlpE4t9ERcPrvLGal3ndGtJF.
 zXXzLYpMPwmvr2O.qrUIvQUUPzjFXhgzxe2Lnf7EjCidZgc92ZjSZNGLjJ4hhHliLPg3t.HedDFT
 9SB.Ez0J3hyH.t5GVkALqIT5_YiC9e28YzXfJ0b4BYAXmDOesu8KA1ru8nIkBgl1_5Hbs3lE.XlC
 WXxYLqMc9M6jaQbsTOdhC2Q_v8sAaEvyqITEvoKwB8uHSL1YGnAQ7AtSPMNLaZuhq2vIz_j_h682
 u27yKZORZmSJW4rTggT_pKocImp3BEIxRgDLjvdNSn2JjAqHdktOGFibsLiBqOUxEfGZ2YUSYgVO
 yATz_IVQyMKbqh7LSxVQzEuav9vGuV4CKdKUmRLNOoB_h_gOlHzlchrHz_s639cIaqNJdEcasgDt
 X7xRFwKeMwA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Wed, 7 Aug 2019 19:44:37 +0000
Received: by smtp427.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5794cbfdaa50515bb41c5d22b089570d;
          Wed, 07 Aug 2019 19:44:36 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v7 12/28] LSM: Use lsmblob in security_inode_getsecid
Date:   Wed,  7 Aug 2019 12:43:54 -0700
Message-Id: <20190807194410.9762-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807194410.9762-1-casey@schaufler-ca.com>
References: <20190807194410.9762-1-casey@schaufler-ca.com>
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
index cfd7cf4b0be9..2d81cac418e3 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -362,7 +362,7 @@ int security_inode_killpriv(struct dentry *dentry);
 int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
 int security_file_permission(struct file *file, int mask);
@@ -858,9 +858,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
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
index 43076ae0373f..745e8791b6e3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1404,9 +1404,16 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
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

