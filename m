Return-Path: <SRS0=cgF/=2P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D859EC2D0D2
	for <selinux@archiver.kernel.org>; Wed, 25 Dec 2019 00:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51E920679
	for <selinux@archiver.kernel.org>; Wed, 25 Dec 2019 00:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Hr4oxsnt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfLYABX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Dec 2019 19:01:23 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:41333
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726251AbfLYABX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Dec 2019 19:01:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577232081; bh=uODEMq/zKqkmLIjDrmByIQYtaBjP/DJQRTeVYv5TZOw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Hr4oxsntvTSSpLsZdgStqCRFKJdZAAizBfn1xRp/mIIZjvscWchlzjbJDMmD1M6INTrzYzmS9udjqdmHuA8PtbI0pJTk0HhVeG1nDMwFXzp+CbGOO8TDCCCBtgKLf+2O2u6YqFV+fFTfSVe9mbW0CvzpRY8kBJ5Q935lBomaYrWUT9Yo73bzlECgJ6Hx0SMD0pvSTkB+j5byXaeJl6ks+3wszZHherHA3dPzj1GsZrzO94I3CeSWixYW/TRL3JvRS5vVS+KSCKN8sT9ipKH8ZHR4gkauQHa5jP+a48ZC6f7nlxwo47WwvpXScplTAG8uuftYYv9Cp41zIoL0BITFJg==
X-YMail-OSG: plyBdoQVM1nw2l6ZQx0ep7TLPSTf_W79cG1NXebtvcGqziFHklO8rY4wCcJ312m
 Syxhh8Stunr60Zsj1sPyhm82c3YIqUIWKNzyaahk5iWT_JXDnG_X.s_FC8dyJKoYxJNlaPktyQEh
 ql0qs7l89.nlq0aDxf2.sppN1c5nKXTB5MTIiyJlTzLsk_pCuWi4xasSOHc31y0exzQVA7tJRg_q
 mXmALNk7Zc6r2GKRqU.7e7Qfkpp_DeMaAArWncwewxaK5yvR99FGW3yZYjEC6s42y1Aq6LR.G_JK
 42m1KXvDy0Y3wMY3I_UMXAP5AItYoK8f25LkrGs5gNgeEPQ3dHQuq_51ZEne.3Od9d2Ldc.vKoGy
 pmW9Ampp3rDlYz9EZmD8aKer002T2lHdCxQcccUzrS2bwX6fB1nFVILlELk5jeCvfKK7XeHkl8ov
 NGoQobGo__eLWVX8eCoAYby41V_YCVoxtnHBPXT66PdiworM7uJzjWQfLcVEuN.N0puJr9vWMIP0
 xMfb3PQ59dmcjpvRHjawJ6k2KAwD2KJ2Rjj5Wbm7135jzN7uAJFJAb2nBGRgm.M4EFHRITbeO9xR
 3NZ5G9TpJy1f0bRVRx4vCn7dFjZH2xGoAglfthxtMpqoIu6nB54vcHjnCcmlvR0gzorWbteveKtV
 _zUo0GyjB3copIR1Msgh_Yc2QVSpihWiA_SO4Cy1_ysiWc98ctQ2JPysT3DYLosNHnQgeXvSg70y
 bKtDwbQY9_f20VUXBoHgXflK_i76pBXqL.4K1.remIPOY4oPtmZ5V8P6_LKXGtAVty.5irqGs.nw
 gitod33xZDh_sIJq5oY6W0HqoqPf1Q3jFS3LzJAlq_0tXmpdfN3EREOqa8zyYHIZkKGjmDg5CIvD
 HchNl3DeYjQ8umnIi2WFEUazW9AMQK4mU7TGVY4gJxC9dwDI9EC9GpLwcWml1XNGLC1treQSHv5A
 .XksXWWV9zemSNgW41XLzVt_80YjQpEXWwj8uvp3mpRqBB1TEYUicWvgwinLFq_cmtqdYFOYXV0r
 wVZOoQ3zeI.OI7_ynzbODgSS.J1gAhr.47r5RAfUlHmF0xKRWrjgrKWxcEmY6DRm1fGpqA6Y1IjH
 cR6VXVCs7B9id2P_xEsaoBqlnEJTXfAGCZt8RAxcYlS9LXGW9c578KmjWC_sjoV8XnXy.lN0Zjan
 e2VmCj03aYWMiMwIGsxmcXdC3L4qoBpluRYXCh8vslVGGru_a3PqECkU4WZRi5Ll_9qv1gdrLso7
 EXnWjZbLFpkRPbZ2gKyMBxvULzCbcKMk2Gk4a61vDMNC6glqecbl71ehRPZ2kAkEo7xf0qWW0lHz
 RbkJBXzYNTKigskPSpLi.H9G.PzFC5HiczrB57.4tMa1Vzjp.rS6cvZ2xZS0u3jJmYlJQkLR4uMB
 Z3tV5dryCU0M8lFjw9xNAHvETuuHZi8zA0SORtNHJ3assvFbpXy0Y_B1FwgOAz_sWek35hT4WS7n
 f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 25 Dec 2019 00:01:21 +0000
Received: by smtp429.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9d1bb59a0918ecde89dfb5903b1ac451;
          Wed, 25 Dec 2019 00:01:18 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v13 10/25] LSM: Use lsmblob in security_inode_getsecid
Date:   Tue, 24 Dec 2019 15:59:24 -0800
Message-Id: <20191224235939.7483-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224235939.7483-1-casey@schaufler-ca.com>
References: <20191224235939.7483-1-casey@schaufler-ca.com>
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
index 68fe533f8a4f..c2118bb071bb 100644
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
index 7a170c02f8df..88e341ebab60 100644
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

