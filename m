Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C41C28CC3
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B65726FE4
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="bnG/YtG7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfEaXN0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:13:26 -0400
Received: from sonic302-9.consmr.mail.bf2.yahoo.com ([74.6.135.48]:44452 "EHLO
        sonic302-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726658AbfEaXN0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344404; bh=GPvWJDPXSClM26o50qIJxfLTG9C4Dy1cxsnhyj+//zw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=bnG/YtG7X1ys/e1lVNCQK/Qz4rlPFczyvVk/wBpaFoXTFbpkitohkEI3yeUTzGXr2UKPZPZBFJOWJgvlDx6z+mvvJbRX279813J8NaWz5JCTdgBgWKdpudaj5KG/pG+bsTWfN7ZqIBdsmTunliqPDECLEe02q/A+uDEIHiyZ3OlfEuJepw9EVslgMwlvhJV5T0aXbo9h+R/iQHbb/RYjrKVRE8Hty0ro79tHcPBhV7GBM8D9h1vAqLl8bVeiL542u5ehsbAMoyk5ysBGjijaxbBEv4H4xBVxEAPp5ttCMjOR0J/LWF9Y0breytfzj4fTgTBvPzITqEtD1d7r9UH7yQ==
X-YMail-OSG: Y6phVJcVM1nMLzJbqVU0lhhbGFxFToYt7WcCjyTdxzY.R9qkMsQHyay3XUzEUWw
 GRp3kV_STpNWKVmOy4hezQNAOIwht9t7u9Z3LgVbx3eZslLGLfC_6MT.ZN52SCUapLje_E3M6PH3
 7z4QjVx1u3Ojgl2io6S9HM6nXYPu1Tc_lyLgBVN_x.3IAFJqikRDRh4Zd07ZhsB9OrVlY0wnq9w9
 p3hHx.JInSkjuVuNAQUYmkRNj8oDSRq0Yzezkmt9RmJHKkhv7zQRlx.cydu5sadZ6uLM4hOeyiq4
 VTmY.kDSmj3Jl2SuMjh48PtBIuKfIWA35PwH3HO4cWrFFAc9W_ec4oFLu.IBrcMUlM9d2QA2xkp6
 .6nWAN4ItlEbkYHfg2ZkNL9NXaSq3MZlUeQMhTeFiSCXokdfpPX4StObm7sB0xO1ghZFd.wvady8
 M8RJoifUAaFXke_kdpWBfM5Wu1.6di_saWgA4JjhUgpJK5mCT8VEGXLBbSaNnQxrdf8e83tMcylV
 XRLNuFFqf89XuykYPpI0kunNMzO9zm.a3jXhh_8HTgTQMp_wHUJ22XcHNXFPRSkM3qFhqcc7a2N3
 WCtiXVoHbVLHbsRB.QHkuh8Nwk6lDMi3UT4GSHLiaJ7eJH8qcl7muFxBBmKKdtGq.WYb9SvqP88a
 xOMikjInBsn5fjxsEBsXHMp9Gc_x2G7sxvyqWp2gAI4Pc3r_8xbZymvCrla9eDzD7bDpOEcf1oWf
 yg3vKM1pMg0zgfAsKujzgpqVITohlVfOzduEmXyYeY6teT5hWU6ERv.GzeX9RG9hFPTpjEwk5mxs
 XMFlA2TtsNdD_b1HNjGimoL_2k82lwHfJX5IzRp5uSnVwR_quUWJDJtXSay78RGC6SAhWB2HsPgA
 dqwunZJleWMT.WQzHtMvNZ7DXw4gCQS7.kVNCgBv_o7Mjs4gfnM5OE1l0rhVCdnk9c9m9olrJdEN
 QbT6YhXAUGeaqtHaucjUErablNHE.7OiyTK5Sbd81Y1pzDb47Ki8ROuo4Xvm4BMhPNZWDWRqu6Cn
 iFFPB6UJ3H0C_nxloJvi4r1uFlET_c2uMNUwIPzZCzrsQ0PJ68SmHEa8a.82cJAy0uXOKAIyHCOx
 bMB66kppGDdZV3e6ghN5jnUtMOp.8jPCBiF3wZhJkjJKQXYUblYmpFQubcAEufZ1DBYwuqd5WHL7
 sGStN7q1LH4_hfkzomPF97txwPeBeP25CS_.SDzR8_b.4QzrXOAntsxzFfwWButNIZ52nnSxzAPI
 5qElX9gy8_JL20sjZeL.WUxW1PM29na4f74oaW42Ww5h6ZM96ULhrN4Ca
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Fri, 31 May 2019 23:13:24 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp411.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8fde30701a6e2f0263f97d374ac02e3d;
          Fri, 31 May 2019 23:13:22 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 20/58] LSM: Use lsm_export in security_inode_getsecid
Date:   Fri, 31 May 2019 16:09:42 -0700
Message-Id: <20190531231020.628-21-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
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

