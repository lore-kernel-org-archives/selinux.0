Return-Path: <SRS0=Y9t7=WZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF522C3A5A3
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 23:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34DD21874
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 23:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="bf6aF+xG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfH2X3y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Aug 2019 19:29:54 -0400
Received: from sonic307-16.consmr.mail.ne1.yahoo.com ([66.163.190.39]:41393
        "EHLO sonic307-16.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727738AbfH2X3x (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Aug 2019 19:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1567121392; bh=uxcHwgOpzC/adUgk2d3S1gEWM4FTxZpivBefUTTskGw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=bf6aF+xGOkK2FLhLalqDnfQ0uAgiOCRVXH4AP6RgQrOq7huFazdsp/Q9D9iQc7ICuQO9zWSwCV/K4KMd7evUZRn5QvAIm0BsGb03JZZXOBqbaM8xTb/pSOst8mpZ3vJCfiiwGTrsXHiRdzBCH+hEirqEAuaYD1v6npnjC1wcDJZE3AMWOCaNCfgoTCZc0YYEpgzvupyUOKiJKKgUqGwABy38fL8dGb/sK6J3xoxTCvOc6+WwoTtxBmUAPCCTlizyi3/J0yB4y895Fuj1UJ5ZWg76GL0oudCAb+UJSe7b30I+a6VBbKjSmm8HANoC0Sm+SUstvaUJf0X2/0BZOWviTg==
X-YMail-OSG: pnnz.YMVM1k1BiSBcI3lsYS9LT_HaWcG5eegHolFgg64h2niY_ZYEjuU2yLrLug
 jFAclqmxUf6t8kVFOKtyEZkIIWqr._ixGA_kd4tWXv9lQGPFo1gsAuiBWEZ_S36CYwEtkyWBWFTm
 IVzyMsnQUS8EPEgwnMhFSc4a8G3W4neVYHT1FAG4_vKFdzwHmTYMv6cExc77x8kjSJUdCKaJs.7d
 Bbh1VfbkPcaHTkSakF7vjSmgMqHd8sBM9KvVMbdWkvsf4oceAAbryWCykqQ74iNU6i7y5MKaGsbx
 _mOfCNYRSsksvaahtzShZsd0U1jaRMgjYE_N3YBz.FlsfiukKfQ5hhjqnD0nNgzkyLbpme45VbY7
 MvO3edCFzWI13GZusT4VFZpBCB6KfBRZSMXxhfYbEFiyevpBC1pnRKa0.9Hhs9aZjKOj525yNdeL
 9IT385uJhAblFp8.4Jlwng6oLu4N5zPXKuhDle8pKSflHLMZKX1X0DKhrEBvbwlaoVRkXDjxmbgn
 5HfbXUGFhERTuf0svL7BKBOInwkl3vZn0qMYuPXZIhQWV9w9ct4CEAlVYaiiV0Ov19WzJNKoNX3V
 PF4ppnNai2kcX7SxlR5ynbAUTLtCP48wXh0jjEiFm4ag536W6B8cw7dIooxiAk4_VkcflWrPXY4o
 uyuZgtj33BfXE6CC8L4iVrdwT3yI1w2YMbSQt1wKBiArekZAy4M5j.nIjgEo24LzXlCCbSKgsLi7
 pKF16q5Q6kKOIPq_h2pduEpNNPJV9jNhfSAM1jyZgEzcWFS751GDN_NrkSslfG084awnBfGoQArB
 KqwAczkQIXNxTnTbogfsYC_DluCtorrXdTBSHah5QI8drchIadzSUiIfDPoCF7VEP.Vv2KxTTIva
 3bLotKUnJGUk44IXiFssfVd45istbfv1PgRHttk9di8u7dPjmwEPcX1OEMc6LADM0wfPhYs_V0s.
 49W9NZfQEehNHhYLH3tF_x9Iz_TGqZafwA4KD1aJdL2cd6vl_CTA4YwtYkEQfRw_CCQ_0N1wXXy4
 NRtXMoYolh7pKdIBPrh_LrEJfggj3yhyENce_7ifEIAKWJESmNh3eu4zUkSMuyF7cS_6_5tfzhRY
 87uh9YBvhkUEyUECPtbNcOxfFcnR0L7LcTbjyb3NRxHH3LPoSXWgQJHP.C9KwRzcaeQPsqAVy_cz
 b9Z7kRkiptTCwnRfwo9k0CUJppgMTi9jE7LuD9hsROKYXE_IiPsECTE00URwfdqjjE7tVwY0DPhR
 YlUvCL1Avu6aAB4.E.YCC.jOT81kfWLe7i0D4C7YT26HXdwI1jjmuYpvDG.KvOqfaoEa0KnU.40N
 GXqdll7Cq
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Thu, 29 Aug 2019 23:29:52 +0000
Received: by smtp416.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0a952b05a9b27bc17439acbca9e87b38;
          Thu, 29 Aug 2019 23:29:51 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v8 12/28] LSM: Use lsmblob in security_inode_getsecid
Date:   Thu, 29 Aug 2019 16:29:19 -0700
Message-Id: <20190829232935.7099-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829232935.7099-1-casey@schaufler-ca.com>
References: <20190829232935.7099-1-casey@schaufler-ca.com>
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

