Return-Path: <SRS0=lMs6=2O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60BEC2D0C3
	for <selinux@archiver.kernel.org>; Tue, 24 Dec 2019 23:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B88206D3
	for <selinux@archiver.kernel.org>; Tue, 24 Dec 2019 23:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ICLA5Tqv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfLXXVC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Dec 2019 18:21:02 -0500
Received: from sonic311-31.consmr.mail.ne1.yahoo.com ([66.163.188.212]:35937
        "EHLO sonic311-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726237AbfLXXVC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Dec 2019 18:21:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577229660; bh=uQ2URDlGHwivvTFxlkJ4ZmBWhh8fhZMuYTKrwyBZ/Yc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ICLA5TqvCuSOLvuQSrLou6YUYtPSRB7lNgUEOIMiPCpFgnxvONXkIvj9iLvq4qAfWBRkeiyjJ4Nm0XWcJwx2aITwCxN59Psk2NmiiEAF0mAgjWHebGS7FflZNWyAPfcUfoR8lHYswb57RB4H8Xwl6ZB6bF8CHg7TjeHo6OkULgknpWSBPZmlWZ0p2VKrMX+jcy86B4+WrpFSNQXb8BtlYy3igA64etGrtBX4tzmoh4hjmaVl7IXZYHC6EAoYjucg2jjrKolZ0LmuvtvLHrBm/zV/NBGltwgLHz4SpZlKM0VlX7scmjBDO7AcUYMAQBf5f71KUBOfwbgxRMVMnrfypA==
X-YMail-OSG: hViq_K4VM1nlmuMwZvtb8P2ikFczqM_GfhwmW8fbwmbFCY_IcWDs70htuHrnMRG
 2nyzMJdgy9L33HxStEBMLssPP7eG37Bi2RRA4baP3TS3aXbeQHY_VGvb1Ul1aKsia.qUgoPMo4ez
 .qhiwhYJ2NGkof459yNVfsCrBjyq.7br9bgWuB.7yJTyFXVIe1P8ukd0E6Yr56QiMIn2aCgZLdn0
 4RgMn8012ZyiGNobUDpq1RIiGdMoYorRtsSdeC5uz2VaOMkjfZGj6R23oc9ANp0kwfsjNK1_rvU6
 EQc1qXWQMzfd0iZX_51Z4z._hURL0VRJb.AfEiXu09YZ5vg5DqFj6iBKxJY4_kFvfXIwBJDjx5s_
 HBx6AAqzULBeYYhwzRX6qq61IlcctJTidCVm8aSlhFDs0C0lMaVUcwq39CEab_pAcVGKEiFoho6g
 s598afslcw3iLLAjqBr1Bz380RH0BGSCsXEJW6EI2Om2EU__NGcfwJYESkcOT2jAK3h7z59mj9_p
 w9t2bLFv5U75cRGGQbJv4op9IvbdWU4BmLc.m1Rtk25Pcojbe7TbMK2cblNOjP0Z5etSF9AqJPTc
 yOX_qArAjymtMpe2tHBk1zsNgECtFPi1CvwA7c1lMoDc0XNOykJnxgytplDtVquUklhxqg1kswY4
 Wf0AZzjXlEI10gV8GgTfNhTUxtptnKUuoPGOfvqN4XEkwRVJimgsVZyy1mq1PhmJw0nx4qnFmbbI
 IZ0IBcMOM74zD7QTh31EFCgDD8ZbH61bZE.t0deQNohC04jkWr_FkmuYqhmf58UA5G4Yi8b9gp7U
 0nu0ZxXCFpqj0Lj.2Psx12Lb2Pwir13T2y1jHlxQ8H7wgESOc6RY9n9fkfJ3pGNw1RGbDehydu1D
 GPOF_kHT2mT3TauQ7AD9fQMMQwKWYTGwIi8bstUjDuDS44hz4bg242f6IZmWRkANCLrioupSBlSM
 FUskXxs9VFohbQXefBUA1Tn9nBhQPnSchCRxICDNlBhvuklhtv3.xQVTYpVY0RwrXvmmiLA_IyU0
 oEqoSOgDe7zscc83nSAE1XL_XeNgRGVzir.oAtpETu2KB_TfXpnGcrqxf8TxU.aZ9bR6wdhe6pf6
 EyyfIKzQJ35ZZm0bhVzFTNP6QJXf6Uv32mXuLuSWHoPjH57fMANTgHI55EphyeDtEAHTuEtGUEMh
 le0dsZaaq1TIqcr5hVjhkx2vnfTGwN0fs9On83VUk_IIa2SEertF93ZIEmrjUyqDWncLoXBWOoLl
 zt21eO_GhxMDNmmi8LgZAeEfQZvWSHPtGIEswtSJ5IA23G7x4UnlYY3sj6ZcT89EVHS3MU31Ef2G
 o90HW1IndeDQ0FyYPgfOpJd45kX7g.aq40iP6e.kFHuwwJGz0VZS4lmF4Edvzv6EPsfpyZdBi3xy
 d8VUm2vdHzAnx_nrvHtN_x2qq74TCSD_B9Preir3X82krLVXpZvIM1c.AL8z9iA3d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 24 Dec 2019 23:21:00 +0000
Received: by smtp416.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 4a6483092832384a81bfb4a72da48403;
          Tue, 24 Dec 2019 23:20:55 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v12 10/25] LSM: Use lsmblob in security_inode_getsecid
Date:   Tue, 24 Dec 2019 15:19:00 -0800
Message-Id: <20191224231915.7208-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224231915.7208-1-casey@schaufler-ca.com>
References: <20191224231915.7208-1-casey@schaufler-ca.com>
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

