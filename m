Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC21C3F68F
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 00:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D68214AF
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 00:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="rGvAkgKJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbgAXAYx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Jan 2020 19:24:53 -0500
Received: from sonic305-28.consmr.mail.ne1.yahoo.com ([66.163.185.154]:44487
        "EHLO sonic305-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729253AbgAXAYx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Jan 2020 19:24:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1579825491; bh=9RjDv9BM3moUwDIns8kmS3SpDWeAqOMGyva+HUGwu4U=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=rGvAkgKJGa/xdeCK3OVQ92U0O9AfdKhPnuD4AHN+pI5P3uwiRxQj+oEZvG/U8Hl8Gt/84RtG46oS28hfZH6s6FPgFF9QdVH70eXRxZhGhc+Up719NpvywjyCbDR3PQv4B1qK/1XarIgSyPeu5+VqYf+qdCnczIjkBu1uMIkEpuB1WZ/qPiZ7qG4gmOV3IB/rqlDO7DwPbxd9IeXHxXOgs8fn86IiNwKZHC9n3648mPdi8/pdKxdci1aDLRy95CH7xIuul6HuX7Dazpae6YKiM3wyd3s1usUqDs6X+AusXeRLDcfIoM0qv8h8LiJ+nJdyoW1Xuj0MKNqNN1c57VGrKQ==
X-YMail-OSG: cTixpBkVM1nkz4z6hObULnOQX4wuSohLsg046JD3Zwgw9Ac6AFs1N1nQ75FBK3B
 9lPNxthcZ084SuCCnCAT0XF0z4mHP2MuE8M5g.Y0oY8KlMRcYTgKEkXmNMREuyySmNUBB1Tikyzt
 0GLcf8NFoeCXJwogtUbggKXXtOcIX_Z2yNRHb0rN76J1pZpaNfwZX54JIECQ_.6BMiw1DibMYsTx
 K33h1DvitlDFHup4QWib40sNZiQjFHuGhZU2fCV0pG3VUNOf53Ned0WspS8aARGFT2Lun0ztoSpt
 O4MhYpTpoSl.VafcZT3K0zHrhNbW4xjvh0d.RXdtcrqcxLk4KfeCmlUnLAm7dGIIwfsZK99ZmB0g
 P29_Rm0yEL5VQSG5iORfVZ.JhnvKsMDOMeG93yoluJzGkPu0M1r1ob4k_JyVvyyDhYQkyPAjk3_k
 j_a_GjN8GDs1TqtE0DdPrJnSUrQywgccR9mtQn.t5i2BaNaJc56QWWv8QPZXcnXsGCtZpTfmclJG
 YeFtblb0j4ODBHmIV9CvAEFFVrx6yPVZoDjcAkjOU67PYh_vj8z5kJDevSX70PqKJSy54hyx6IIK
 lVDQsqbQpH63KSptDuc9Yy237rQA_K7M3aQ2qFwbv479IlthB0CRLXlSdSbnTXr0bVvA1NefXkQT
 UrigMHiQ.QEijAxO.0vIqvZESPnyxcTj1PWixpZZidk.9lxNrThn.uXeOzsxhydzEV6UKhy.GPFU
 0Ro7g6RGhUqDIZwgORItHEG.MBfJHhyuqlxgrWLZRHf_lsWVY6Bt5sH9j24AG1dYkYjgSpeX37_6
 uWVPInylqvw8RVp9__lUveSsNVVzDhfYuThaBclp8aapaMI9UH1IB9shLxO4NSatBDIaYr7jbKpi
 Wlz6bD5sbfFZw13FAQbeZQe0xBkJZQQoOQiH5z9gZUjnO16Et4dyUOHkHLOE1TgxNpqMNAwEoxZc
 R3Pm.L1fOfYsNDj7BcLLEwBK4jNPh1Z3mt06xswmeCgIa0dNbHUQY3ycE4iyuh37PBRUFPKWOvqx
 WhpP40t1MORx4rQDmNUm8F04iuem5VAq5OIh85KMWx.YBEw2QJI8ZwhvPBjz8ZLvENlAhvgImRDS
 XwBKhPZOIZRin2rQAR6GqN0FwG28skKsEIGfOaZ0MnXxFD1JB4zPFnTASc6_T9lj1KFx0G_C1CjZ
 HUyjHZMoFlP57hXWYRp0h58DKF1LHLFKnbcwvTiw1ojRDwugk73mlzONNMEbQh_H_Y9.si1Fh2O2
 m_U2_AGS6gSPpTtBc9NjcgHgi75Tj0vuOsBNhfDYpNNHkJgXSP0LF7FodXO9oT2XiwDYLg6k3EyJ
 L8BpUJIuY8s2tJ1o1kTM0Ak._JRSb_MEpfMBxupj3TxH1F5H.g7EHHBj_zobeoor3V_C5pwHx5N7
 oTYyvKfEWgpOYVQzf2qzH0Cl9vc12IbYHH_6ugX92Rcmk7lgdsypCm_eO6iQvZq1EyF_l
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Jan 2020 00:24:51 +0000
Received: by smtp415.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 33e3032ffce284febc475e586577a65a;
          Fri, 24 Jan 2020 00:24:48 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v14 10/23] LSM: Use lsmblob in security_inode_getsecid
Date:   Thu, 23 Jan 2020 16:22:53 -0800
Message-Id: <20200124002306.3552-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124002306.3552-1-casey@schaufler-ca.com>
References: <20200124002306.3552-1-casey@schaufler-ca.com>
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
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
cc: linux-integrity@vger.kernel.org
---
 include/linux/security.h            |  7 ++++---
 kernel/auditsc.c                    |  6 +++++-
 security/integrity/ima/ima_policy.c |  4 +---
 security/security.c                 | 11 +++++++++--
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 9ad1d01fbbe4..a3426c002644 100644
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
index 3e5ccb7a46d1..b55e66c2451d 100644
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
index 27257af4a8cd..6771c8c83105 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -425,7 +425,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		return false;
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
-		u32 osid;
 		struct lsmblob blob;
 
 		if (!ima_lsm_isset(rule->lsm[i].rules))
@@ -435,8 +434,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
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
index 78185ddf232d..a4a1a7cccd4d 100644
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
2.24.1

