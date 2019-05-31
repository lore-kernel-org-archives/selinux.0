Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62276C28CC3
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3935326FE6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Jj5sNSNN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfEaXLY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:11:24 -0400
Received: from sonic303-28.consmr.mail.ne1.yahoo.com ([66.163.188.154]:39646
        "EHLO sonic303-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726450AbfEaXLY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344282; bh=cb378cxqvPaulkSS7n2iQ2M2+2lKAprXYeun9wbD1fs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Jj5sNSNNnriGJl9x79+M9JkEk/iM5EOo7+AR3L9QUpK0n7tE1ssaEe5taTowQtlkcgCBUkzzdV5eDicOznF1Zu609gJQzKXbTSGfNmxbVzAuLue7VrLPJ7TjzXPtIPEU5qZnXnsLQpGrvpZ6KBkWGEMocR9lSALAgRdppi0+1f7V13dlrnxhGaFsHqYSbKiA21bscKF2kfKcN1p0Tfik/ZqC7vpRBep3mfp0uN4iRd2fIiKJqFb4sOu66Bg2gEQyQ6CLzBbNgPYLX5tpbVrghDXiI/HefE6RlCs2lV6mq4Xf3t0fbmj/+gQt5z2WyZnFvoeMfA9XfqTTJzPA2CUERQ==
X-YMail-OSG: PtWpU0IVM1mc8LCAvXcxPe1kJho60LmJSNzwsOwE7jZi.jTtLCh_3gBKAtbQb0q
 QKwv28ZwPAc.FVVBg5LpLVLmOVKGA747G3tZ8GP3CaNDtZEo7y2k6QRi16EzfCklod2JpZ8oV8kA
 U_c1T5q.OfFBOuPaJ19UTUSBtzifqp8pVMIfM5qhyHfwOXiIf8ep6Iud0IFFydxeE5bsrPxu9BZD
 ulpK9uliwVIKTAi3app7iPkOoLr1eV3RkSTZiiwrVcz71K7k0wVQ80ASgDQU1tb9Mky6cdO6LHXo
 gd.GOS_tSY4Z71iFZ2LDAkzlgdJmeKuvGlRLzrpl5rM_iAmm.zSm9Guc27IAJLsPRGGdqGvYPh.o
 1yaUtsF6t.g6IN62UNAf7U_eUdXfvEmn8WEEC.f0akxFBvnsvdg_gnD2KsRNd4y2d5IphVAjqUb6
 5dD6UN1hUeJr5mRSooDzeWRGHwdVzvJJzwtalqYloIuvlEt8Sq5dq8TuAHLPhYUc2kLNgsAUahEB
 eytU3F0AKweHVxttT2mI.Hzvkr4MYAvruEWtAD7aAhGjFW1ROzoDCovsbGAubjA3fQ0ZCe1J1mQv
 ERxpXaQgofs1bxG9BiXs.pYlkhJ_nxtOnkgNJDHD826IavXjFfk.6gaGhTVwWSQONmlg7T4_oBRT
 VQE_OhiTxM7j4Nin0WSsfaT.wVawBZEHEpI_tUOTtxuOHE52JEK22vuCnAE2M8Lhhipk7qFOr_2L
 JsVr1bDlAa1zpQcUF0NpAvDnPjOU9.pURGXxXbQV2JFH2Zd2CeimFMoNleO_Zd0teFwNYDmGvjuG
 0_fx4m6OiGKZzsldMA3a8bZDMzwl1ieF0nZ.YjjO3oq9Nf9RjToH.2iN9QQP694ekJXFpQcmYavm
 Dy2LD7u_gysNlB7iV5.IlNwAKroyegDmMle5liW13lkF2GjeXLNT6Gm0w6c_YYcXvlVB0sGk7cFw
 yUQolAXUp2lvcVDr.slgQCfiZwWJEnJESrKzL846lxoPlrHn7O3a6pQM1O3aOzQ0UJbW27MwReVp
 lHAiw0p9aRP1YEzM9LDhxmBDMliyaG807..Z35yGxvLk38LOr_pPp0ccckjfynJCu.hzSEpdYL0N
 knFSRi7e9AulYEa.92OYnwaWB7ujCDnIjV2FOacXqIo0YMwA8Q6jZUh_wDoarK2mdp7vu2ewLG04
 CLqHN29_yevLMD0_6VDA0GoKd1EE90MtzfZ0NgBvWCzyTS2Kvzgh8jeOQVqJVJS4mRKS9CXOTuLk
 RmAcIykb9H1myJCeNbAdZegYIVH.ToJc.eruseRLgIrCjRJHt1rTlkw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Fri, 31 May 2019 23:11:22 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp414.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9f21a7219dc461799002936560934de0;
          Fri, 31 May 2019 23:11:22 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 07/58] LSM: Use lsm_export in the ipc_getsecid and task_getsecid hooks
Date:   Fri, 31 May 2019 16:09:29 -0700
Message-Id: <20190531231020.628-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
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
index 0f9d4174bb6e..62783a923136 100644
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
@@ -1094,7 +1094,7 @@
  * @ipc_getsecid:
  *	Get the secid associated with the ipc object.
  *	@ipcp contains the kernel IPC permission structure.
- *	@secid contains a pointer to the location where result will be saved.
+ *	@l contains a pointer to the location where result will be saved.
  *	In case of failure, @secid will be set to zero.
  *
  * Security hooks for individual messages held in System V IPC message queues
@@ -1610,7 +1610,7 @@ union security_list_options {
 	int (*task_setpgid)(struct task_struct *p, pid_t pgid);
 	int (*task_getpgid)(struct task_struct *p);
 	int (*task_getsid)(struct task_struct *p);
-	void (*task_getsecid)(struct task_struct *p, u32 *secid);
+	void (*task_getsecid)(struct task_struct *p, struct lsm_export *l);
 	int (*task_setnice)(struct task_struct *p, int nice);
 	int (*task_setioprio)(struct task_struct *p, int ioprio);
 	int (*task_getioprio)(struct task_struct *p);
@@ -1628,7 +1628,7 @@ union security_list_options {
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

