Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB81EC43603
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884E4206E0
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Tnv0tPJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfLPWea (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:34:30 -0500
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:37818
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727632AbfLPWe3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 17:34:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576535668; bh=uQ2URDlGHwivvTFxlkJ4ZmBWhh8fhZMuYTKrwyBZ/Yc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Tnv0tPJJ7+D3bunKm3wZxazT5uzxFml8imFv/7GyR2ddFZqvPVz2WhJJj0isAw6MYTTkxXsZoT3ue1/bYNW5Pi+fPw0yU2r753BLVL0qMRGYcNa9bpC5m//VEb9Vu9uqDJ94ZRIhao5feWx66Zf7zlGAue2Ges8OSJcaeNFDMST9xNhBT3m1naklL57tmKDY1g3m26v4hbQhUq9x8cfmiF5FRZ+WjZlYr5eDOC2s1f0c9558xPLVbdtLVe2hhzu/VTwV1f/CCsjrVp+PWPXzfRMIV4pU7YcDVZrv5inx7D5ZKWl+aXb5srR5uBv6bAdJ4B0RqFST4iqNiwS2Y48vpg==
X-YMail-OSG: ui.NJdsVM1nQ79MHStuKiZtTrvbtwYRcRZlBreYmUJQQmGOzp8a_4glDJ6Fqh8k
 Eilmit4gMlUTPtbFgPUGe7BnVfX4Gx4b3ewG6MvABP2yqrmxjG_4moBCzQELsBrhRkkf1Es0hrz2
 7205f0MEmWpG1dwf1HPnvnhqhNTZU60TvNimlVdNi.BwUtP06_KPeHPbvVfdnYjAi8TtsCiDLz25
 c3rZALL02etarvQ3OnlGO9m0e1yrCgwBJ2aBHClGf1P3DL0BiGNutmoJ3XISva426rWs_4sAX4xt
 XiiU2UF27wvEw0jLWiRAYacVr5zPIsFl25.U9aOXwTd8LU6MD2aip0mFcusHg4Y1xctu2ikvPC.K
 DhrcLpaEq40GhS5Afv0DxrVypdDuX3TxRl_0izO__3fAldFFkyhI2u9wQDD2p2ipK8ZhH4j8m9Ik
 GYuL1ywZvGOLsHOfgXFRvBz0BTPMgGgn8HeWCFLFpeplRw8srodIriTwAKV5zO6pT2ruWau9n1HD
 dVyQNdIuSWu4H7iN1ZljFUklPY6aVvTqNh81CuCoUdUzMyaOkkZW1YtKVv2lHy2b6GpE6p3aq58w
 .K62yaOWBk4hWz4O8AcDTz7UhiGQNeIuWebAB2.aEPRa09eY6Y8CLjz0NOaM2D7wfYOGzt_9zxLT
 .i2skuK6qARXU3Oeyz4PVmW6pFcue6cwSEMByymaG096WY31pCg730AJc5W7ZseKB.nAWsxT1YT4
 Qfwt049Rs_USPf9DtblrUbgt21RRfi7tw5VY5nHdeIf_1nbvRxjHew.OMCkcPH6tnpygojxWpJhG
 AZAgFPjoGn6u_XEh5Tg3q9FrfCtzRwZ63vXj.yJRtmErwKv_rdpjQF2khPPmGdYOcGN9BpQyoBV3
 V6nkHhPEVLTHZ5i8KROh_jA8Z5PWnApc11aLZJeUGJWdkhfOCjy_DYib8FYFWP63r9nPgkjDdDhU
 FveuPNy7MkK0iQ8zErT5q_QdAXxU8vavGmzZgPyBcLLHoYoZeZP94Z8SZZ_PrAR20VOsqOCkWt4x
 q5jrimMSiaK_ayqZgTzToFAjA_gpv5pRgPi2s4XX8D.v6MEYHviJuHOI5c0OJ95QkH5x_Q7Qmsm8
 JRNSvOiAuDJTkOGoKgM.LFGBkhC0pTnDmF.pPPFg232X9jqPJSAa3IHl0tyPGmH_ubdV5Yt.DNYQ
 MKbvcZ1mLDOF0RbEpbshe5XbnSRY7Uq6hwuqmbqX.l.km_l5rtre8juikuP9oMroarLYtYPbNtgZ
 RFunHv7ChvmZvFk3P2txIOeUtr_WAGyx2rH4C5MZqk3yZxS_twkivls9K.jjsDBoO4L8AZwgHQJE
 MK7CGkXKWQvmwzS6IvCK18VGzLPjHBXi8zxaiXcEEApSnseSK1H5RhQAQU.qU6rlDHvXlMIVTV.d
 wKwetEvwe5i6nBBAMhrazSvlQj5xro..MV_d7QDKyEUJzb.Vt1H_qHNbUnCFENMM-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 16 Dec 2019 22:34:28 +0000
Received: by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 534f0963b73bb8eca427a24b6d6f3465;
          Mon, 16 Dec 2019 22:34:25 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v12 10/25] LSM: Use lsmblob in security_inode_getsecid
Date:   Mon, 16 Dec 2019 14:33:30 -0800
Message-Id: <20191216223345.5066-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216223345.5066-1-casey@schaufler-ca.com>
References: <20191216223345.5066-1-casey@schaufler-ca.com>
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

