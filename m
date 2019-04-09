Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70172C282E0
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC462082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="YLt91O1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfDIVkK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:40:10 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:38123
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726663AbfDIVkJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846008; bh=MmtCEsyght4Z5zl828NTA0CWqne8Yk1YCMTRtKNxpho=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=YLt91O1c7WgylMvRKH9RLviTxv2cmvhYAbEq3Hsu3MGd+wuyAkdMQnhz3bqpyVvTHYOAFFzra5cJusBgAdKK1cWNZt2EM5Tg/X0CUjRj2YI28PoYeLvUjmMkE/KoTs/l0E2l8hhXfTMETrBii0xjK2pf5RfkzwfcZD2NllqUCCwFD8ydVgCW5Q0ScRS7Xmc3DhdrvIvJ7ey/oZB8ImgJ7ukeOh47gzd1rbGUPojgNAYvJVolZcA0PzQVIsNOem+JPTrYM+Tc6fLmSqxdORaBOMjBZ955vdpCRCRreQ3nf37BOaQtEof0opus2ZR75mNZdu7910k6oA0jbP35QsxL9w==
X-YMail-OSG: k4EfCOwVM1mKBhuVMcr4ulfCv51meTDF864CBMmCq2NhWGVxcnLib5J.AzL8UT9
 8OLA23oEibw377w6qeP78lnTXXhEUZ9m6HgZBZowwv8YvRzd10.51pHluWha.3pK1y3eoESoxg55
 mTu3e72wpkbX5KlyNJSKrRToUroB7EqQkk1fpePvBujEXlemLnd2pZpxKfxvTdLnuVkT64cE6d43
 CvPeEi7wtkuJoCnkM4LzaHmU4GRBA4.Q323386s0cmNpXSaXpbYamVmYnaZMvmnzdV6OzS1gfdBJ
 OV757sQAAJUOefxRSPHCtaxzQyCKVn2UuBoWk9iCUbea6RFyxERoer_ZD139NQSKzecruaWNBcax
 CJCAOQhOOi5enhm8IUKwoueQvCJXIQw2THMFekCzCtIo6LjrSvsLSuHajPLh5LHgkbqNRY4me754
 NdoBYq_1rcp_xT5CcNi9vx._yxc.oDluwgeMkEnxF8rNzBcvcPF.jHyC250zwxliHbmZ6pbU1hGU
 3DwWcgf1hzspLGmk3YHHvOuzwljy3Jlb5ji1F8Nk5KNv3PobJe6NLcu90ZmWkJgM8IgnKGGxGBXK
 7xw9PtZmZWPXmwQKM39YJOXo022xRtmWNGkrPN5XmtBnjDggw4sKGPEiFeDi2ik_Ypzemqz55mS6
 DpUyUNTlKNXbf5EsKODx7q_31h3PjdY9VM4_n.GgU8k7rxK65diOy774Id0aD1.XYZVe9lQac4nz
 gGJNBzcgIPzdUVt0jfoQXD9vUmnsI7LIDIU.yWjrH8babVEeESICvCFpl.5YsThTM_mo.XY9ZZbQ
 dWJS3LwZBdLsNpYe3gE9Pal8VXbIAdOFtGeo.cHvWaRjbEGTJHnX1FcZzJAySxyQdrEzNzkLstss
 wxFxPew.xO54WMODbmgusCd_t6LuF0PgZowa4p7RzglZKX3zb4hp3GKUZ8YgIy956yR2cbhGd9dz
 xsVjlK9ooYmEP3bxdJspyeq.XKO2X3J4m_FLUd2DxR395UXY6sy8XYLpEKOHlrAJd8TgdYoKMyHt
 ULuG8e_HeDO4lMBLWGJOGTs.wdEw0wwMkj.NJM_2HylZQHeGnMnwR.H9fJrW0RA44t0sKHCs7kO8
 CJjAZxeBi53QvNfvhP_ma.Q2d5oulc6svUsgzZRHgraFnA2cQdi1RkH7U
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:40:08 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp427.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 41cfc07a55038469dc17a23ac993d21e;
          Tue, 09 Apr 2019 21:40:03 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 07/59] LSM: Use lsm_export in the ipc_getsecid and task_getsecid hooks
Date:   Tue,  9 Apr 2019 14:38:54 -0700
Message-Id: <20190409213946.1667-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert the cred_getsecid and task_getsecid hooks to use the
lsm_export structure instead of a u32 secid. There is some
scaffolding involved that will be removed when
security_ipc_getsecid() and security_task_getsecid() are
updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  |  8 ++++----
 security/apparmor/lsm.c    | 12 ++++++++++--
 security/security.c        | 12 ++++++++----
 security/selinux/hooks.c   | 10 ++++++----
 security/smack/smack_lsm.c |  8 ++++----
 5 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 2fe54dff3efa..544671f44dfa 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -638,7 +638,7 @@
  *	Return 0 if permission is granted.
  * @task_getsecid:
  *	Retrieve the security identifier of the process @p.
- *	@p contains the task_struct for the process and place is into @secid.
+ *	@p contains the task_struct for the process and place is into @l.
  *	In case of failure, @secid will be set to zero.
  *
  * @task_setnice:
@@ -1096,7 +1096,7 @@
  * @ipc_getsecid:
  *	Get the secid associated with the ipc object.
  *	@ipcp contains the kernel IPC permission structure.
- *	@secid contains a pointer to the location where result will be saved.
+ *	@l contains a pointer to the location where result will be saved.
  *	In case of failure, @secid will be set to zero.
  *
  * Security hooks for individual messages held in System V IPC message queues
@@ -1618,7 +1618,7 @@ union security_list_options {
 	int (*task_setpgid)(struct task_struct *p, pid_t pgid);
 	int (*task_getpgid)(struct task_struct *p);
 	int (*task_getsid)(struct task_struct *p);
-	void (*task_getsecid)(struct task_struct *p, u32 *secid);
+	void (*task_getsecid)(struct task_struct *p, struct lsm_export *l);
 	int (*task_setnice)(struct task_struct *p, int nice);
 	int (*task_setioprio)(struct task_struct *p, int ioprio);
 	int (*task_getioprio)(struct task_struct *p);
@@ -1636,7 +1636,7 @@ union security_list_options {
 	void (*task_to_inode)(struct task_struct *p, struct inode *inode);
 
 	int (*ipc_permission)(struct kern_ipc_perm *ipcp, short flag);
-	void (*ipc_getsecid)(struct kern_ipc_perm *ipcp, u32 *secid);
+	void (*ipc_getsecid)(struct kern_ipc_perm *ipcp, struct lsm_export *l);
 
 	int (*msg_msg_alloc_security)(struct msg_msg *msg);
 	void (*msg_msg_free_security)(struct msg_msg *msg);
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 2716e7731279..706e5ae09170 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -49,6 +49,14 @@ int apparmor_initialized;
 
 DEFINE_PER_CPU(struct aa_buffers, aa_buffers);
 
+/*
+ * Set the AppArmor secid in an lsm_export structure
+ */
+static inline void apparmor_export_secid(struct lsm_export *l, u32 secid)
+{
+	l->apparmor = secid;
+	l->flags |= LSM_EXPORT_APPARMOR;
+}
 
 /*
  * LSM hook functions
@@ -710,10 +718,10 @@ static void apparmor_bprm_committed_creds(struct linux_binprm *bprm)
 	return;
 }
 
-static void apparmor_task_getsecid(struct task_struct *p, u32 *secid)
+static void apparmor_task_getsecid(struct task_struct *p, struct lsm_export *l)
 {
 	struct aa_label *label = aa_get_task_label(p);
-	*secid = label->secid;
+	apparmor_export_secid(l, label->secid);
 	aa_put_label(label);
 }
 
diff --git a/security/security.c b/security/security.c
index ca485a777ca1..802557ff6f60 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1722,8 +1722,10 @@ int security_task_getsid(struct task_struct *p)
 
 void security_task_getsecid(struct task_struct *p, u32 *secid)
 {
-	*secid = 0;
-	call_void_hook(task_getsecid, p, secid);
+	struct lsm_export data = { .flags = LSM_EXPORT_NONE };
+
+	call_void_hook(task_getsecid, p, &data);
+	lsm_export_secid(&data, secid);
 }
 EXPORT_SYMBOL(security_task_getsecid);
 
@@ -1805,8 +1807,10 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 
 void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
 {
-	*secid = 0;
-	call_void_hook(ipc_getsecid, ipcp, secid);
+	struct lsm_export data = { .flags = LSM_EXPORT_NONE };
+
+	call_void_hook(ipc_getsecid, ipcp, &data);
+	lsm_export_secid(&data, secid);
 }
 
 int security_msg_msg_alloc(struct msg_msg *msg)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f97dd414ac8d..c82108793fb5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3911,9 +3911,9 @@ static int selinux_task_getsid(struct task_struct *p)
 			    PROCESS__GETSESSION, NULL);
 }
 
-static void selinux_task_getsecid(struct task_struct *p, u32 *secid)
+static void selinux_task_getsecid(struct task_struct *p, struct lsm_export *l)
 {
-	*secid = task_sid(p);
+	selinux_export_secid(l, task_sid(p));
 }
 
 static int selinux_task_setnice(struct task_struct *p, int nice)
@@ -6094,10 +6094,12 @@ static int selinux_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 	return ipc_has_perm(ipcp, av);
 }
 
-static void selinux_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+static void selinux_ipc_getsecid(struct kern_ipc_perm *ipcp,
+				 struct lsm_export *l)
 {
 	struct ipc_security_struct *isec = selinux_ipc(ipcp);
-	*secid = isec->sid;
+
+	selinux_export_secid(l, isec->sid);
 }
 
 static void selinux_d_instantiate(struct dentry *dentry, struct inode *inode)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 15579bdd7244..13ac3045a388 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2087,11 +2087,11 @@ static int smack_task_getsid(struct task_struct *p)
  *
  * Sets the secid to contain a u32 version of the smack label.
  */
-static void smack_task_getsecid(struct task_struct *p, u32 *secid)
+static void smack_task_getsecid(struct task_struct *p, struct lsm_export *l)
 {
 	struct smack_known *skp = smk_of_task_struct(p);
 
-	*secid = skp->smk_secid;
+	smack_export_secid(l, skp->smk_secid);
 }
 
 /**
@@ -3231,12 +3231,12 @@ static int smack_ipc_permission(struct kern_ipc_perm *ipp, short flag)
  * @ipp: the object permissions
  * @secid: where result will be saved
  */
-static void smack_ipc_getsecid(struct kern_ipc_perm *ipp, u32 *secid)
+static void smack_ipc_getsecid(struct kern_ipc_perm *ipp, struct lsm_export *l)
 {
 	struct smack_known **blob = smack_ipc(ipp);
 	struct smack_known *iskp = *blob;
 
-	*secid = iskp->smk_secid;
+	smack_export_secid(l, iskp->smk_secid);
 }
 
 /**
-- 
2.19.1

