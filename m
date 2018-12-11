Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6538BC67869
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2BB20672
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="P7Ip+FcY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F2BB20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbeLKWoD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:44:03 -0500
Received: from sonic311-28.consmr.mail.ne1.yahoo.com ([66.163.188.209]:38459
        "EHLO sonic311-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726655AbeLKWoC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Dec 2018 17:44:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544568241; bh=yMQklFwhAM+SkyFA3GlpZ7nPGFc0LOqkP3jCwe0SRVI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=P7Ip+FcY9VaKM0JrlDCwnBs2Ib7i04HSMpAqi6Ehd/ALU5oLyxiLDRp93o4xWWOzUQujmVU4EPrs7/cSUMUtutklrMZ8mTHCsxCR5KYUGTGZLEwMypJphPs5RU2iv59dml0GgwchzmsGzUz3/KH4c+I3rczQ3Z4cMN5dR266PIhkXwlFV+EFSQZBojL3iUF5h/vzLqDuXyLdRdWc1dWT3qRpQ9UmevlOIc9I6NQ3E56479yzchmCtscX8ytaAHs8K0e5bWqilCndMKrhW740vsIYHdCg5HzcUMu9k598nQ0NOCBdFgtLcJexqSJo6auudvgEYntn8BLb2eKbbj8yQA==
X-YMail-OSG: DOdPDaYVM1mkDrNNuuXu.2FaOvJbZ4539q1xAAlWDsHu1112.HpAZph4tUkQxjF
 fVBt0yodjx70VQn3c4ha0Zc6jiB9e7j2CLewotLHZBXY.VjuYbqj4dVMI3fpR3O8N.A8Cs2glSyq
 e.CzWOxlb3MXirTqygwzeyMeX3n2jHNt5ubF4vjx4pxQhDv8UVp4KnvBJ9FTfCNUHFRf2MOuXmD_
 yi_cxMSzqeT_Lxifx3k___ogaHLyl0f0LsmtRhsEq0Ke5eYlND5ON3lSp.yUjS5LY0aQQVgHAmED
 w2XrOqWhgUp2hL8YOSM8_nCP._.RZCHz_vRbwG0U8RJT...Pln60bVgOfbyreAin3Nk7ESmDeuqi
 cSKkN2ic84z7nZWmdbPbMNgl5mjt0b3cY9l4UCC98c8jGeZ4ED2A_C3.D_79TmOudu9wOdcpuIls
 nOIl16ZTEKVK3K3a_3YLP.BDIgSUAufAPvB7fRiKSw9_H3bs5_HQIzYIvDJWI5BTnghajmklhUqA
 AHxMA04.C9Qr9mGg9qq_PxPDFYzz2DBQG_VaQZzAcjNKmXfAVSL9qSDf7bwQlgPcJ6JtAI_T8J54
 IoJmTFKCBa1LJ82ehrlQBTFNlgXP2JtlhY68RCbnDKZi7aAE0FNkuK4iHbRUuGabTLU.nu01NHXD
 f.T6cYPVdG3LGRg1UmvO5FzyBoElmF.dVvW1okH4Ey3wsq3k2vjBb174Qg2hhOMOrk5bwiAwZkfQ
 7M8KnQgrHVacQEWsIBzQdCDLPzkxGM40EWfOPdnm4fyTjLX7XBHXjfcJziuCQImRQsD_MflplcQ_
 dycFsfLtdfUmZhJ3IKD9X788L7VegAfd5FJieiXuJ6Qh7aO9xFgsMWuoTG70pqkYI7CC_y4lXTAq
 nvxa1ej4qmAnLUJ8VcVFNOES.XdsRJVDc5D0QLn5e5DyiKN3EW.3.G7mpcRfDTX5gSDu.kPi0hAH
 5Y1J5kFAMjTw9nUnZJsnP9rlpMkCZvd2OTG9TCC1dHxaXwT2aXQZR.fOjbb84Ukq8mILtnTNFA8x
 uF7KkiFYosNLAUs6e1wqfAADxIcqI0bb357lvpEH8OPDJh_0nJjX2dbOLUaPHhI46L4CW_uP3COw
 y3WPT9BXCnvkW3q5lFrkLHVhqYgRp_hpNJThQWA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Dec 2018 22:44:01 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp411.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6f4a30c5671782919fad3da3c826f035;
          Tue, 11 Dec 2018 22:44:01 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Cc:     john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, sds@tycho.nsa.gov,
        adobriyan@gmail.com, mic@digikod.net, s.mesoraca16@gmail.com,
        casey@schaufler-ca.com
Subject: [PATCH v5 32/38] Smack: Abstract use of inode security blob
Date:   Tue, 11 Dec 2018 14:43:08 -0800
Message-Id: <20181211224314.22412-33-casey@schaufler-ca.com>
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
 security/smack/smack.h     |  9 +++++++--
 security/smack/smack_lsm.c | 32 ++++++++++++++++----------------
 2 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index 2007d38d0e46..436231dfae33 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -368,12 +368,17 @@ static inline struct smack_known **smack_file(const struct file *file)
 				       smack_blob_sizes.lbs_file);
 }
 
+static inline struct inode_smack *smack_inode(const struct inode *inode)
+{
+	return inode->i_security;
+}
+
 /*
  * Is the directory transmuting?
  */
 static inline int smk_inode_transmutable(const struct inode *isp)
 {
-	struct inode_smack *sip = isp->i_security;
+	struct inode_smack *sip = smack_inode(isp);
 	return (sip->smk_flags & SMK_INODE_TRANSMUTE) != 0;
 }
 
@@ -382,7 +387,7 @@ static inline int smk_inode_transmutable(const struct inode *isp)
  */
 static inline struct smack_known *smk_of_inode(const struct inode *isp)
 {
-	struct inode_smack *sip = isp->i_security;
+	struct inode_smack *sip = smack_inode(isp);
 	return sip->smk_inode;
 }
 
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index c560cb8e155c..c086110cba80 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -166,7 +166,7 @@ static int smk_bu_task(struct task_struct *otp, int mode, int rc)
 static int smk_bu_inode(struct inode *inode, int mode, int rc)
 {
 	struct task_smack *tsp = smack_cred(current_cred());
-	struct inode_smack *isp = inode->i_security;
+	struct inode_smack *isp = smack_inode(inode);
 	char acc[SMK_NUM_ACCESS_TYPE + 1];
 
 	if (isp->smk_flags & SMK_INODE_IMPURE)
@@ -198,7 +198,7 @@ static int smk_bu_file(struct file *file, int mode, int rc)
 	struct task_smack *tsp = smack_cred(current_cred());
 	struct smack_known *sskp = tsp->smk_task;
 	struct inode *inode = file_inode(file);
-	struct inode_smack *isp = inode->i_security;
+	struct inode_smack *isp = smack_inode(inode);
 	char acc[SMK_NUM_ACCESS_TYPE + 1];
 
 	if (isp->smk_flags & SMK_INODE_IMPURE)
@@ -228,7 +228,7 @@ static int smk_bu_credfile(const struct cred *cred, struct file *file,
 	struct task_smack *tsp = smack_cred(cred);
 	struct smack_known *sskp = tsp->smk_task;
 	struct inode *inode = file_inode(file);
-	struct inode_smack *isp = inode->i_security;
+	struct inode_smack *isp = smack_inode(inode);
 	char acc[SMK_NUM_ACCESS_TYPE + 1];
 
 	if (isp->smk_flags & SMK_INODE_IMPURE)
@@ -826,7 +826,7 @@ static int smack_set_mnt_opts(struct super_block *sb,
 	/*
 	 * Initialize the root inode.
 	 */
-	isp = inode->i_security;
+	isp = smack_inode(inode);
 	if (isp == NULL) {
 		isp = new_inode_smack(sp->smk_root);
 		if (isp == NULL)
@@ -914,7 +914,7 @@ static int smack_bprm_set_creds(struct linux_binprm *bprm)
 	if (bprm->called_set_creds)
 		return 0;
 
-	isp = inode->i_security;
+	isp = smack_inode(inode);
 	if (isp->smk_task == NULL || isp->smk_task == bsp->smk_task)
 		return 0;
 
@@ -994,7 +994,7 @@ static void smack_inode_free_rcu(struct rcu_head *head)
  */
 static void smack_inode_free_security(struct inode *inode)
 {
-	struct inode_smack *issp = inode->i_security;
+	struct inode_smack *issp = smack_inode(inode);
 
 	/*
 	 * The inode may still be referenced in a path walk and
@@ -1022,7 +1022,7 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr, const char **name,
 				     void **value, size_t *len)
 {
-	struct inode_smack *issp = inode->i_security;
+	struct inode_smack *issp = smack_inode(inode);
 	struct smack_known *skp = smk_of_current();
 	struct smack_known *isp = smk_of_inode(inode);
 	struct smack_known *dsp = smk_of_inode(dir);
@@ -1360,7 +1360,7 @@ static void smack_inode_post_setxattr(struct dentry *dentry, const char *name,
 				      const void *value, size_t size, int flags)
 {
 	struct smack_known *skp;
-	struct inode_smack *isp = d_backing_inode(dentry)->i_security;
+	struct inode_smack *isp = smack_inode(d_backing_inode(dentry));
 
 	if (strcmp(name, XATTR_NAME_SMACKTRANSMUTE) == 0) {
 		isp->smk_flags |= SMK_INODE_TRANSMUTE;
@@ -1441,7 +1441,7 @@ static int smack_inode_removexattr(struct dentry *dentry, const char *name)
 	if (rc != 0)
 		return rc;
 
-	isp = d_backing_inode(dentry)->i_security;
+	isp = smack_inode(d_backing_inode(dentry));
 	/*
 	 * Don't do anything special for these.
 	 *	XATTR_NAME_SMACKIPIN
@@ -1716,7 +1716,7 @@ static int smack_mmap_file(struct file *file,
 	if (unlikely(IS_PRIVATE(file_inode(file))))
 		return 0;
 
-	isp = file_inode(file)->i_security;
+	isp = smack_inode(file_inode(file));
 	if (isp->smk_mmap == NULL)
 		return 0;
 	sbsp = file_inode(file)->i_sb->s_security;
@@ -2063,7 +2063,7 @@ static int smack_kernel_act_as(struct cred *new, u32 secid)
 static int smack_kernel_create_files_as(struct cred *new,
 					struct inode *inode)
 {
-	struct inode_smack *isp = inode->i_security;
+	struct inode_smack *isp = smack_inode(inode);
 	struct task_smack *tsp = smack_cred(new);
 
 	tsp->smk_forked = isp->smk_inode;
@@ -2263,7 +2263,7 @@ static int smack_task_kill(struct task_struct *p, struct kernel_siginfo *info,
  */
 static void smack_task_to_inode(struct task_struct *p, struct inode *inode)
 {
-	struct inode_smack *isp = inode->i_security;
+	struct inode_smack *isp = smack_inode(inode);
 	struct smack_known *skp = smk_of_task_struct(p);
 
 	isp->smk_inode = skp;
@@ -2726,7 +2726,7 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
 				   const void *value, size_t size, int flags)
 {
 	struct smack_known *skp;
-	struct inode_smack *nsp = inode->i_security;
+	struct inode_smack *nsp = smack_inode(inode);
 	struct socket_smack *ssp;
 	struct socket *sock;
 	int rc = 0;
@@ -3334,7 +3334,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 	if (inode == NULL)
 		return;
 
-	isp = inode->i_security;
+	isp = smack_inode(inode);
 
 	mutex_lock(&isp->smk_lock);
 	/*
@@ -4566,7 +4566,7 @@ static int smack_inode_copy_up(struct dentry *dentry, struct cred **new)
 	/*
 	 * Get label from overlay inode and set it in create_sid
 	 */
-	isp = d_inode(dentry->d_parent)->i_security;
+	isp = smack_inode(d_inode(dentry->d_parent));
 	skp = isp->smk_inode;
 	tsp->smk_task = skp;
 	*new = new_creds;
@@ -4603,7 +4603,7 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
 	/*
 	 * the attribute of the containing directory
 	 */
-	isp = d_inode(dentry->d_parent)->i_security;
+	isp = smack_inode(d_inode(dentry->d_parent));
 
 	if (isp->smk_flags & SMK_INODE_TRANSMUTE) {
 		rcu_read_lock();
-- 
2.14.5

