Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBCAC6783B
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756A420851
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="NcG0vcs8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 756A420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbeLKWpK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:45:10 -0500
Received: from sonic308-17.consmr.mail.ne1.yahoo.com ([66.163.187.40]:36310
        "EHLO sonic308-17.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726658AbeLKWoD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Dec 2018 17:44:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544568241; bh=kRBO5gYSD2+Kt+mgu48Ix2zGEOe/PuFqithweguD1I4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=NcG0vcs8q6FWuBOgR5ItqZDKth1lO1hnIEIVY4RzASXrccqJJVKBbiK96J+blpkpTeV955HElMx6/JGPUH3s3MwPcXasudzlFBBpt56H67xsK9SO570zAKlxOhbpta3ntopoWD7cM6ZfApiBT40aDjKCUni0ljX64AyeNMWy9cBOS2AupDQgpq5Gad64deg8+gbCIw+IBECnES4xcH56+R7hf74USxHyNxBNe0OJQQZ+Fn+/V/iOLSkBpZBVuYilcumGRJvI+V4BwDhMdy929RD8acKTAGSVdfsVVZvcPPkxvoIUr3sBASnySofRGDVKw4lQ91H1KHgIEba5pmoPGA==
X-YMail-OSG: qg5pdXwVM1lg6c1AhpSy6JIeTcflRDOQi7kEW6Qy5.rjaOq9oUazFcHV6jsD40V
 fTfg1C42pqHMRlU9hHWQzKpIOdk36t4Lt.6SyXqx8C8P0I19M37SpeHaf6SeqzGZIdO.IQucphWk
 WwMaYgwg1e6a2.e3gT6yHPnNOkGA_Ha1ivAJMG8cy7fXnaOhqkzp9lTUay2micvbdj2QPU5_QcSa
 n00Gpx91cAVKYaeSZWGvXkihbpmH.6tJaFm0f310EbCIBsGk0ol3U634LCSJL7QdrPalO.Zis63r
 E1ht0R39nzuL7rBB0clK_unUVqtKnBf9bDq2lbK4071lYDIPptOLL.5u5HzWJsLbP9INHx_DQW4X
 VxETwgM2qdogeV1e4nvmgjlSxEfC.h6IjBePIEd4yHxDBOlMaDFDuPUn_DAkSkGu00L4lM4WqfR9
 RnxmjA3yRgC.xu3m_cLR5DN2zwBW6xXrnM64rzY0SLQp_stvmYI7l8fN8PWBmqR3EzVY32x.1mep
 VsfioVmVmaKAkaAWAiKEeBulE_nlKMHnfFmaNxFJmYejUMRuHWEfRokF3TfkfTR6JwHAtAvJ.PM1
 krXex9YH70jo338WI8swJg1JnczYpV6YOE8E_AL8LKnZxoDFy3Aj4PkgvR9NqRDQHQjTQCxMqpt6
 aF9ZVNo_TxhXg5UxR.4rlQjPOLno77x7dbIW3YxHrYRJTdUw4HMy7mhQKZM8rZhF_zsgM8py1iVW
 MoNPoV3TUvE94eHWQPlT9XQtpCFF9a5PT9toxCiJrqhrOhZwKy56Tb7xLp1QDJa55dYIm23yixev
 oMEr0dr7OEx7zV2Dsl7i0Zt1uLoJdFfNp1f1ar7w86FYFlQv1faQZ9OLhVy0Edk062.3_3t7wIi8
 JK9YIyfzIynaWg0F06yL7I22tAAytwh9EMMSrqIjIp_RfrU0o.eltrLaP74MPxKTqxI2TI2gnrSp
 xVTLNuCdiCueWMedV3sruojYXxFt.yrxWFtFDJKjwIdts9WM2awfmJDdmmZL0XsP3jR06ZLr5Q46
 le5h4Qsa2xsrEA2lYnGzdpHYsE2DtLb4TmLn3bqrxiE0D5s2BLJFKUXSRwg1jszQ4LEDxE4WNqtl
 X2Zn72R.zWNCNCkArWQ9CpmOOQG4YPLNnrHcoiA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Dec 2018 22:44:01 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp411.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6f4a30c5671782919fad3da3c826f035;
          Tue, 11 Dec 2018 22:44:00 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Cc:     john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, sds@tycho.nsa.gov,
        adobriyan@gmail.com, mic@digikod.net, s.mesoraca16@gmail.com,
        casey@schaufler-ca.com
Subject: [PATCH v5 31/38] SELinux: Abstract use of inode security blob
Date:   Tue, 11 Dec 2018 14:43:07 -0800
Message-Id: <20181211224314.22412-32-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181211224314.22412-1-casey@schaufler-ca.com>
References: <20181211224314.22412-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Don't use the inode->i_security pointer directly.
Provide a helper function that provides the security blob pointer.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/selinux/hooks.c          | 26 +++++++++++++-------------
 security/selinux/include/objsec.h |  6 ++++++
 security/selinux/selinuxfs.c      |  4 ++--
 3 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9669a059ce0f..3069e95d86e6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -272,7 +272,7 @@ static int __inode_security_revalidate(struct inode *inode,
 				       struct dentry *dentry,
 				       bool may_sleep)
 {
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = selinux_inode(inode);
 
 	might_sleep_if(may_sleep);
 
@@ -293,7 +293,7 @@ static int __inode_security_revalidate(struct inode *inode,
 
 static struct inode_security_struct *inode_security_novalidate(struct inode *inode)
 {
-	return inode->i_security;
+	return selinux_inode(inode);
 }
 
 static struct inode_security_struct *inode_security_rcu(struct inode *inode, bool rcu)
@@ -303,7 +303,7 @@ static struct inode_security_struct *inode_security_rcu(struct inode *inode, boo
 	error = __inode_security_revalidate(inode, NULL, !rcu);
 	if (error)
 		return ERR_PTR(error);
-	return inode->i_security;
+	return selinux_inode(inode);
 }
 
 /*
@@ -312,14 +312,14 @@ static struct inode_security_struct *inode_security_rcu(struct inode *inode, boo
 static struct inode_security_struct *inode_security(struct inode *inode)
 {
 	__inode_security_revalidate(inode, NULL, true);
-	return inode->i_security;
+	return selinux_inode(inode);
 }
 
 static struct inode_security_struct *backing_inode_security_novalidate(struct dentry *dentry)
 {
 	struct inode *inode = d_backing_inode(dentry);
 
-	return inode->i_security;
+	return selinux_inode(inode);
 }
 
 /*
@@ -330,7 +330,7 @@ static struct inode_security_struct *backing_inode_security(struct dentry *dentr
 	struct inode *inode = d_backing_inode(dentry);
 
 	__inode_security_revalidate(inode, dentry, true);
-	return inode->i_security;
+	return selinux_inode(inode);
 }
 
 static void inode_free_rcu(struct rcu_head *head)
@@ -343,7 +343,7 @@ static void inode_free_rcu(struct rcu_head *head)
 
 static void inode_free_security(struct inode *inode)
 {
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = selinux_inode(inode);
 	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
 
 	/*
@@ -1502,7 +1502,7 @@ static int selinux_genfs_get_sid(struct dentry *dentry,
 static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dentry)
 {
 	struct superblock_security_struct *sbsec = NULL;
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = selinux_inode(inode);
 	u32 task_sid, sid = 0;
 	u16 sclass;
 	struct dentry *dentry;
@@ -1802,7 +1802,7 @@ static int inode_has_perm(const struct cred *cred,
 		return 0;
 
 	sid = cred_sid(cred);
-	isec = inode->i_security;
+	isec = selinux_inode(inode);
 
 	return avc_has_perm(&selinux_state,
 			    sid, isec->sid, isec->sclass, perms, adp);
@@ -3030,7 +3030,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 
 	/* Possibly defer initialization to selinux_complete_init. */
 	if (sbsec->flags & SE_SBINITIALIZED) {
-		struct inode_security_struct *isec = inode->i_security;
+		struct inode_security_struct *isec = selinux_inode(inode);
 		isec->sclass = inode_mode_to_security_class(inode->i_mode);
 		isec->sid = newsid;
 		isec->initialized = LABEL_INITIALIZED;
@@ -3130,7 +3130,7 @@ static noinline int audit_inode_permission(struct inode *inode,
 					   unsigned flags)
 {
 	struct common_audit_data ad;
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = selinux_inode(inode);
 	int rc;
 
 	ad.type = LSM_AUDIT_DATA_INODE;
@@ -4150,7 +4150,7 @@ static int selinux_task_kill(struct task_struct *p, struct kernel_siginfo *info,
 static void selinux_task_to_inode(struct task_struct *p,
 				  struct inode *inode)
 {
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = selinux_inode(inode);
 	u32 sid = task_sid(p);
 
 	spin_lock(&isec->lock);
@@ -6529,7 +6529,7 @@ static void selinux_release_secctx(char *secdata, u32 seclen)
 
 static void selinux_inode_invalidate_secctx(struct inode *inode)
 {
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = selinux_inode(inode);
 
 	spin_lock(&isec->lock);
 	isec->initialized = LABEL_INVALID;
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 96374dbf4ace..26b4ff6b4d81 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -170,4 +170,10 @@ static inline struct file_security_struct *selinux_file(const struct file *file)
 	return file->f_security + selinux_blob_sizes.lbs_file;
 }
 
+static inline struct inode_security_struct *selinux_inode(
+						const struct inode *inode)
+{
+	return inode->i_security;
+}
+
 #endif /* _SELINUX_OBJSEC_H_ */
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index f3a5a138a096..145ee62f205a 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1378,7 +1378,7 @@ static int sel_make_bools(struct selinux_fs_info *fsi)
 			goto out;
 		}
 
-		isec = (struct inode_security_struct *)inode->i_security;
+		isec = selinux_inode(inode);
 		ret = security_genfs_sid(fsi->state, "selinuxfs", page,
 					 SECCLASS_FILE, &sid);
 		if (ret) {
@@ -1953,7 +1953,7 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 	}
 
 	inode->i_ino = ++fsi->last_ino;
-	isec = (struct inode_security_struct *)inode->i_security;
+	isec = selinux_inode(inode);
 	isec->sid = SECINITSID_DEVNULL;
 	isec->sclass = SECCLASS_CHR_FILE;
 	isec->initialized = LABEL_INITIALIZED;
-- 
2.14.5

