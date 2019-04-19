Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9798DC282E0
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6910921736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="KU0s5cSP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfDSAsB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:48:01 -0400
Received: from sonic308-9.consmr.mail.bf2.yahoo.com ([74.6.130.48]:35477 "EHLO
        sonic308-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726906AbfDSAsB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634879; bh=TM2ZUN68jEXypRJ0f+YHN9yBHBRv2sOZZODRyMmX3oI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=KU0s5cSPnoHr4Ll6bS8ntjqMxsSHJ9wC4N3CLjS4XgIlvJ5dhgc3S/rfPNEqbE8KWdfcUVLVmS2FGcBeq4CypGosM23X/s5ULpOBwZtUh7EPfrDQ80WnpUf7pHFFxzh6tcKAg+XjPlGsQHS67HJ2IX5o6Ra2ERa8TT/ZVjWy7lh8f/KpSLRinAhldTHiBdoeq9H5bIBsXBj2BGUKbB+iZVxm5mLdQOJog2OHuVXvgEWoZxa9cjVHbiHnTjSQtyOPYH9Nz8v5jY4UfHMR2T6XTBWeTeII3WdBIE1whKibSfVQErDIJazLFUWO0Mtvke6ixUeOYStvceHw5yurBIEjrg==
X-YMail-OSG: Z.leZAkVM1mASe86KhCsb1fXdlq.fkoHn80YtduhkRJbeEVOgB2r_MHhgJBV86Y
 kJbizoJkBaaPF4D4L6UMLW18aBQZurV8oJz6EvFNtybSu1p0c8W3Q8sJxfc2cmm1Zsgel3.ilFSV
 fxMHhSRbnSuDhHoGGg7NP_5xgjiExElakCXGuGJVJMFA6f43TjgjwbEaN2bq48_tgK5oWb74jz7q
 w2OcLRh9j76nI7HixGcExRE3lTRtcwHKW5IBLrTDI9yLSW3v1YoXDuqturHyzMeiY0A.fc2IK1IZ
 2nmWmtHLksgv_mVSe35182W6QjTn.6zAkg3jcDCTt5ANL5keRuL3aeny33ngCzoIhuoMOcU56Lip
 1wWd9nXElwWoeoUx1NYTVhq7avB086pqrQ..j5eQfZRHv4ZObtKWuhSd_5P4.Fxwf1hTHEgdmdgz
 G1UFX0wiQBTSk18e5aIw4arzj7t8SrIlm.3Ou4.7I4EhWfi.lT78sumPqZ_xho2WSlcXpIo0mIbg
 uaO34FhEuih2Ms9wQaQ3FIRxNsw1CNLiP9H6YULymznq03DZrf6amj.bx3IkGcfrVUnKLs2.oU6P
 E2.M61oCV6VOwy5dXWYF.1X6_3rps6TkatCvvLAJ6DIu53ukvZhZ6rAko6ZShTuwauHcGNKN0kxC
 E7_GQQ1uif1CnBuQynz2exm_1bV9PzrwQV6EGZmMI2JEtqjbs9JnycglOfnjatHmOQt0B32ooNfW
 Rq5XSX3NyQM_80bifAT_AdiLfd_sXCDp3qkiYGwyBHdTc.zHDKsP8psyFsP_0BQarjVq_Nvf4A0p
 l9Y7CR.q4eLPE0t4H6b9zVpCts25oJrHbpy6ySaoG3R0XokIbR93czW.axRv7b4gbFpbNv4hGvCH
 zTeDoaikwABQdAKsRtLx7qW1eKP43IUfANO323bOij9lb2Pn_YEiebnn9rBCBggepZ7b.Kwf0WC9
 2Jw2a_MnGpa08i7lgIqYQx497PVOzol34eB7e9kBiejvAr0PZ.eLKLiccsFmxZnsfvyNxTBzs_yW
 rn10LnKMSyds5lA5S4S9H5M0oB_Ojfc0yIJ91BntEesgWCDiaE00efXVC_sAdWYyD2xLAOpUtKc1
 gF1BMle.ivMjaHyeFr024oJ7gU4jwXTKU8Aw.X22ZqH.X2X._8KnjdICrYFqkbTs-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:47:59 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp422.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9312487679b1d62a89b866e0f3ee025b;
          Fri, 19 Apr 2019 00:47:59 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 43/90] LSM: Use lsm_context in security_dentry_init_security
Date:   Thu, 18 Apr 2019 17:45:30 -0700
Message-Id: <20190419004617.64627-44-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Casey Schaufler <cschaufler@schaufler-ca.com>

Convert security_dentry_init_security to use the lsm_context structure
instead of a context/secid pair. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/nfs/nfs4proc.c        |  5 ++++-
 include/linux/security.h |  7 +++----
 security/security.c      | 14 ++++----------
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 4dbb0ee23432..de000649f9f3 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -113,6 +113,7 @@ static inline struct nfs4_label *
 nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
 	struct iattr *sattr, struct nfs4_label *label)
 {
+	struct lsm_context lc; /* Scaffolding -Casey */
 	int err;
 
 	if (label == NULL)
@@ -122,7 +123,9 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
 		return NULL;
 
 	err = security_dentry_init_security(dentry, sattr->ia_mode,
-				&dentry->d_name, (void **)&label->label, &label->len);
+					    &dentry->d_name, &lc);
+	label->label = lc.context;
+	label->len = lc.len;
 	if (err == 0)
 		return label;
 
diff --git a/include/linux/security.h b/include/linux/security.h
index e12b169deed6..6c3a74a44a59 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -302,8 +302,8 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
 int security_add_mnt_opt(const char *option, const char *val,
 				int len, void **mnt_opts);
 int security_dentry_init_security(struct dentry *dentry, int mode,
-					const struct qstr *name, void **ctx,
-					u32 *ctxlen);
+					const struct qstr *name,
+					struct lsm_context *cp);
 int security_dentry_create_files_as(struct dentry *dentry, int mode,
 					struct qstr *name,
 					const struct cred *old,
@@ -674,8 +674,7 @@ static inline void security_inode_free(struct inode *inode)
 static inline int security_dentry_init_security(struct dentry *dentry,
 						 int mode,
 						 const struct qstr *name,
-						 void **ctx,
-						 u32 *ctxlen)
+						 struct lsm_context *cp)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/security.c b/security/security.c
index fa0500b2c15f..649fd13cdda1 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1014,17 +1014,11 @@ void security_inode_free(struct inode *inode)
 }
 
 int security_dentry_init_security(struct dentry *dentry, int mode,
-					const struct qstr *name, void **ctx,
-					u32 *ctxlen)
+					const struct qstr *name,
+					struct lsm_context *cp)
 {
-	struct lsm_context lc = { .context = NULL, .len = 0, };
-	int rc;
-
-	rc = call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode,
-				name, &lc);
-	*ctx = (void *)lc.context;
-	*ctxlen = lc.len;
-	return rc;
+	return call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode,
+			     name, cp);
 }
 EXPORT_SYMBOL(security_dentry_init_security);
 
-- 
2.19.1

