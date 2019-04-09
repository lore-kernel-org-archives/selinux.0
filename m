Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B30C10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E1C20833
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="a1cwFR1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfDIT7t (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:59:49 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:35012
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726602AbfDIT7t (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554839986; bh=MmtCEsyght4Z5zl828NTA0CWqne8Yk1YCMTRtKNxpho=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=a1cwFR1maah0KCklZR0J2I0oM4I8QqunuozPaXanjTXXX5Y6BzD9P1ujHkDoBJRVolA8PBOS+HjhrgOTXnDv9N9VLdjndsNExP30ipelMDvlbIO4F3lMBAfwZZICC7robG2eAoV330PeTi8E59KFSSsjRTxxBschMS8O9gfvRO6roR/SRGBEzNJiZLjLitiE5dTxwu6uWTHq7hJkb1hh3MTmkfRiVaCC6o+o6wXvX4WKs9fZSxhsV5YVtlASkNWnwTel5NVYCqM6kt06/rdHyGRloyi8Hlp2kCLK9RC1OVUnklopgJPVQ+LpSMaIVazAnXCZ9GTTAWLdXHpvXpulbg==
X-YMail-OSG: lr_XROQVM1kTaHPTjmNTaFGoROf77fQunWQN_US18dB0tCx3ju.0PwBDyTVp.Ho
 4oFa.W9NucWsrC3pa8fHUI1u9gfJko6I1eEHmTG8WILng58QNRCBo87z8vUHZ2ZSVVTl1RY7Bn8b
 EbwyrB7O5dFg0fqFCi5aBasuvkEJe_CjtTV08kMRUvK9uNYLLlgdLxD.oBf.MH5SyNfHBcKRhzmi
 3_vn8vQzDr0f6CoejG4MwGG91I_Io_hqoFnObvuqxbjsdA5WHB8C4wUkmilRt3CtG0Pj9S2wJYAv
 KFesKsIkuMTpiSlIJFTftzK3lsgTz__g9w5cJ.CTEk5YiADcgk4NIuuCYfb18cU1CRRhl6pX3t7U
 8dq6hhgkRgR6KvJmPJBIsEx8Xwhv9GTZebDZCUK_NPHSHF5GHAihKwnA6WhGKl1imJ1a2C3YPg_o
 XD1.7uMCzQcD.0qIao_Km1fRfl2oWEdTNfftbLnooFAJxC_h9_gUajgtruWn8vXwnuX6SYuzNCPc
 C_ATpwPSbSKoWJZ6AR3kNbXkpZJDsPsSvjsxN2eU7JXbKFJfh0PicbNa4oTT4uNskXUR6Yt4wj9M
 iz_NVOC9cao.wa4Ec9Jn_SUzhEt0SxWWLc.pMNiCULhuQF7dddW8R2KAw7JUtvTC0k3SbfsN_K9r
 PPtLhYgtpRLWyHlb6hBfCfFJXuf0ZVP1GPImSsFgXs84ISy6kkSt8wFs_2BDrLaQ3XSjzTIEc8r_
 lJxveZOTQXZJOt9CmtD9hdkMlQBq6PD_cGcAes7D1xi1KjVFo5KtwrY.BDmPgmD8TABwSNWSptyw
 juxgFM6wD1eXLhgpehLZZeRHGl90gd86IgJVO3fIYHLVCXT27oWgjKQxud8QqP71EPAFIG4XfMFA
 nF7JVZs4zm9HlGR2E7_WodGYOQqvpu_y0S5N_INCg9wCDoOiJ5nYf3bnKpl28WamBaT3l.5hSEdR
 eONM3TVf4Q0GXM2lP8nqp97gaRgEWdVut25kUCCm5.fA0y1S9wy.GX03b5t4hRxwP.gmKQo8Yri4
 mJP8XczlVvnNwXQ9GPrCX6Bz0.jkRyD0m8QXanHOZH6hobHO.YjtVr9N.VjdvF1ES50SvldV58wh
 Sw05KTlm_TsyjEn98ItIv.oxNyxj5vWcH74GmoQ8t7tjSWrrPv8cT9NUUw.l5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:59:46 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp410.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 353dc739e5c49befbce16148938a824a;
          Tue, 09 Apr 2019 19:59:46 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 07/59] LSM: Use lsm_export in the ipc_getsecid and task_getsecid hooks
Date:   Tue,  9 Apr 2019 12:58:32 -0700
Message-Id: <20190409195924.1509-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409195924.1509-1-casey@schaufler-ca.com>
References: <20190409195924.1509-1-casey@schaufler-ca.com>
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

