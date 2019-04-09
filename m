Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A89C10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F10A2082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="o7hC9IfN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbfDIVlN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:41:13 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:45297
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726832AbfDIVlF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846063; bh=74rPh+sCnMpg6mZ/XiPS4qZefks1l7WGjfPbmrUu5zs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=o7hC9IfNh/8TViwMr01bxXjjpZNQVVGy5SVNytqVc+Gb2LNws/D7z63B0Coj0Ux/JOqtCldj3as+IB3vwjEfF8DSbcFngC+HsaEri8SESfpFTo0cpmuILUEydftLA+l1hJBjsJeybE4uEUxAtZD1miR+Wdpg6q76uasnjdpZFXg72XzD/kA3bOXwElFb81kTOt1FKL8R5TBDMcNbp1gLrQDU55z0i15LQe/UgoNpZpM0kmZgmJmIosv58m72wANSWswAK6LQkSjOfT5tiFtUIkW2IP4t0bllHg89Rv1BvoAv4GqKKUaQS/R1dV8ozCe4OlhWJh7VxvN3JPcYmjf03A==
X-YMail-OSG: WzZx2iAVM1kogtTh4MxcEZIQtsvQpkL1Ra1SELSQi6vXJYkXWlbXubI4.VKHl5b
 _HrqtCdddoMHwH1le7yC8HKVDg2Y6NGRH2uBH3jJJlT351alZekkS3YbpoCpKaVOxOoBujUNCx6z
 qUVK56pv9m6_NWaZgf4cb27kxwJHGP_cU9a53wRiqY61FDycW3M5PIz.q_EzJF7Mpm4259K4mcsu
 d_LbxfjlOGwNEQpUZdpka7M8SxuuXv2rS8iwiR385lbt1kvYBdYPhLJFi4uKDKkN69gCQKk5kDUi
 aoSFyI0TtlO7upSEReyHNsp.blBPVv7q3y3UjY1wG7QquLXDX5zRFwE0ZYIEFbroUh7laVqbCwka
 4qYLIBPe4569TdHgqJXosCWIlddDZ8RjCF3WCKWPe1UTik5tJaztlM2CnikMsjqGMuj2yQMGp2hL
 MUq1dMR_E2Z5jKa4UlWVz.jNwO5BXYbUuCR_wSw9LXapdq9cPdvcqR0O.J.9mi1ipixvD4NpuI49
 1WGWddPI9e8FuguVlCAhCPJtJQ6cF47fwLEPYGhsDl_UusK.LffYAGgiHPbNLA1kF0r3UDR0pvEp
 aA0RGIYh_smwH8tZHfMCaOezwn3fXwe2vHSfIuWYPuVsFDBYe35MMvddLceqZ5wFTCQxTsfU8qko
 uBv_Tv1Z2i.88MLSbrAaTTvUV2COH4K4eLLHOQ0n1gGkuGOLpR4tLluOgRKJOy6vdZ8i0EYbt_BN
 OqboAJDWpAOY4gT_J0Qg7t.rIu9DEBvMmIwCT9GbTqvaerg9trj5NOYDL0iPCPwqNz2yxvlwP6n_
 50iqZp.r5pE41jSInNfLo43o4Z3gOdr7URrtIg.5IU2OP4eJRdhBSptWTDK94X9YrkiObPtyiQuA
 GmXmJGy_5o0bbQRN7VTuHvyNcf7OcxWwqx2BVACmAegKMO3.YdiP_DcfF4YFLs4.j8adYbpJGRDy
 SHvocpRBzz1yfO6EmwUk8onAewTPP_r3PF763EeKaiTDQcZlpG59tTjjsWVxZk0Mkci5aGoEd5ju
 yY3ONQR66xPrE42.l3dQuKcBOB3m..GbRbnTZSNaH5vz5biXawjE3bNl9Ln6GivzuU.8aHG.v1BZ
 pWEDr18dDwZcRm8FUH8ySn3Ip8bw28JjqDPD9XIxrnRSEXkiIQT.5JiHLWqvoBQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:41:03 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp403.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0d1cdfa4e40e9d37a3e144929c04344d;
          Tue, 09 Apr 2019 21:41:02 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 43/59] LSM: Use lsm_context in security_dentry_init_security
Date:   Tue,  9 Apr 2019 14:39:30 -0700
Message-Id: <20190409213946.1667-44-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
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
index 8dd21133ede8..ba9bcdbfaebe 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -304,8 +304,8 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
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
@@ -676,8 +676,7 @@ static inline void security_inode_free(struct inode *inode)
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
index 5e35adb43d65..7069ff857f58 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1029,17 +1029,11 @@ void security_inode_free(struct inode *inode)
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

