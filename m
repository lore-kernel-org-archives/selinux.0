Return-Path: <SRS0=8O8t=UZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85771C48BD6
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 19:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6BA20663
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 19:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Alpy3kAr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfFZTXG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jun 2019 15:23:06 -0400
Received: from sonic309-22.consmr.mail.bf2.yahoo.com ([74.6.129.196]:45259
        "EHLO sonic309-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726505AbfFZTXF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jun 2019 15:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561576984; bh=bePKwvqaaBIyrGNisFAa2W2YrmIYwK7yzv9c5KrX4ds=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Alpy3kAri/4uRoUhTz4M7SA9864WVmNgOwEGgIR4Vzn0M7aMUBlxPWR8akkGbMWjRpBaWkhNRKai9WNTRs00Jo2YkKXIhn0GxE18UaiYUy9V9KpwrOOE7v40Qfp/tMe/xVo7zAhrWFnTXkRSFRMiR0ubnZQDnStOKc1Kdkg8gNpYdT4WHMKzRllDK/Gtw1bryWRkRJpLhIU+1Sq8+DpbgCmAbkrgzculba14GQr0dDTJtA+BZ6s4OvxmjNdVmAtCW/TMnCqcs9jxYxo3EC9v7eJri4/0rUggMNFce1aw9XjCmtB5YuTELeB5TCvufTM8Rp2V6dhI7hRQUpgpaFnO8A==
X-YMail-OSG: J1QPLWgVM1ncoPF1U3zPIgGJtSMGrPb8Rcr1MzbzD95IzYV1twidDOKOa6etI_a
 EQMCpMxzgaFvMmgEeMFDNsYxn7uDWK7osUCLOO.HoP3pal2qY4N4F0SQhQZONQIRmcivapGCY1Yo
 FnWUnrJx8BfueHE3GP5cKcM_1ZZUJ7ttLo1izh23PB_re1CTF70RNQ37JRuCYlOv.mtgFzEqWUOv
 skCvXwYLhu2mQtcjeZuo2PmquUN_6F.WYhgy9n5xJYsAdkFakAdtyQBXk5EvaMIEfeCZZPfE_T_a
 v07KLE3_NuubOcehqCUMOCBgm7ct0KthfMZ9qfzXnYnxOq5deFvGIB4fUu4dko2x9pQd0ZC7XU5A
 MEdX2.9erwSpisLc81rrG5br.2SdDB.V2Z.t765CLB1kcwiTMcSzVPtHwtD56XmymqYsBX94xcX5
 mm5oqGma.NjoRRYojeLDcVWQZhiW1tKl.0XHz6vU_Td1NoV7JvMXUnB9Et9wUCTEVp2mo6WsgC9m
 4.Dng_2R3dKKLRc4i2HFiKeNo9zTSfSRcE.HBRZpvnLru66k_31CAXRa5kuxHppZFr_wsQwEps._
 SrqNsAGonG1RJzkKoyT8nDG5BLhFORT5R6mlQTQvJrvf0aO8zd_UUMsla6m0Gamr1vL5cz8o9Sh7
 OSbSXZ3pWzVlEFU1A5LkZxETB891fbeiEHzv1FaI88s7jKSTfdq4FnledOszI_QolKm0v8yj9Yy.
 WkjwcU4jRNWR4gxWW90JwPIYakxAvP7KKR30etAQaMlgewBnA7RTXbjyhXlwJ6_s9mY_UWXflusr
 cgKPme6wyMryW94n3phhRi0BZFKXTQYly8PqRQFRBLJdA9zafyWg5Rn63plATGwSuHUw4AlHccHw
 PDS_E_3eSPat1hXPl7VR5Oxp5Xo.wPM25i_hdljQpckri3MI1byVokHhWMW4TvDAWJlDNYISYKZP
 GyzdjlaOyPCn900BbwFHZHb4H6ahVVlglMRKNT6_qN9MISG0KbVlFxOOJGY_y6Avi7TQo.PQNAgK
 9ZaGD2mOUGHdY1yUi7w25mlnQWUoHwXfihh66bOGjrW3tgSyl95ezHjvW4fuGa3.3ohIXtcrV23D
 1mZF52xUuBoSlMu3UEE9vuOZ2anVKm2E19OTPgeK3yc.LhXfz6ynoo.TLph05o3GzbX.5gByylpo
 7CZdxdDcJWb.3L2TDELHer_bso8w42cIoXPHFfedfpLr3YdEwoFlj9Zz4wLWGixt3KOernCcmz_b
 wXa2est54fCeWsXuKbzeVKTqCIC1gYcQqm.fw6GMCKoHOOfASNg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Wed, 26 Jun 2019 19:23:04 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp404.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 26b5d486eeba45c4663afdb6eeff7186;
          Wed, 26 Jun 2019 19:23:02 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v4 12/23] LSM: Use lsmblob in security_inode_getsecid
Date:   Wed, 26 Jun 2019 12:22:23 -0700
Message-Id: <20190626192234.11725-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626192234.11725-1-casey@schaufler-ca.com>
References: <20190626192234.11725-1-casey@schaufler-ca.com>
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
index 2f123003b0b3..91388553d3d7 100644
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

