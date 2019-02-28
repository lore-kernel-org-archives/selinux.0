Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE217C4360F
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D882133D
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="lGOx6UNZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbfB1WTy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:19:54 -0500
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:37532
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729362AbfB1WTw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392390; bh=wDH2jWq/5InVuEensvl7qeoLag9X/nJnC3tKz8KwL2Q=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=lGOx6UNZVB8VI8tQqNqzxlzJguwCeEzU8kWDlYRMdjB7AkTSy/OFv58Y85p+2i9MuJ8r2cKgrnZo3eBz+WvdQClZIHB6kts+YbBLIrWGS85I867WXftzYcVFDG4TOqQgBQ+wqKbIrW6iJBl1lKGwI1IvqFIB24t0mVzyekrWgsvjB1NiCCK+5Gk/M/PO34Btl434lHsNWBD2AZmeQD9tLhBvN6PLRuxLZpP6djmUYeFMygLTSu0jU8aw/CuiFX0myEro/p5+heGUMW5E9dZqi1LBlSGp4nZFoMu4F7TFBoK/mo4XSXgSXH9bUspC///O0SMt5zjqjJVxNBGy0/EwxQ==
X-YMail-OSG: mE.q.MQVM1ntIQf_vIxqd92ca3bzczhxbS4aBBs8Vfj5kS0QHj09EJojU6e28rF
 Ebu77oeH0gdpGWzULUIIPVlyAxNCbSFA7MMh9UK2iS2ZkGD6rp7OoCkAdyCunlNJs5g46Edgm2UD
 7Q516koT8wMTGa0n2TZ8C3aItYpsra_zN8ixjUK2Y4WK1JlEYmS1pwtEexA64OGCddSCx11rS5JD
 I63mvVRfwargfYCyU1o.YzKwR81uDDK4xmzOhAcvUFRCViTrNd88TcEXhito6XnGB7EySPDI0yzM
 sYVn9w17YMDbZp4JNbcrHSGhLrQf8jVUykK6WSaA.8pB4LD4YD1SfbQv3k8d5ufYRYih8c9EyERX
 jMMqOQP3rOBpgcMLZoPlc6XvdrYZBUlYws3B5RYRXTD04eVrgPhW65KuyYidUjvI4VX9qI.XoWsA
 T8fnauPSVxd37CAxQEa50KEEVzU4JdPReYnkg6QGRNm7I.wrd.9ynTjw542bcrMCwF3AsCuONxPQ
 Pb5OEwgdSIvQiayvJwh2r.jVgDpi2k9Z.MZG4GQH7GrEsLY..53jI525eQWTG23U2rL03biLLqzU
 .7CtaAcSLA9uyHtLsgMLpfrn2QvXUsujSqXsCRvaHQ5OVQcaw5MLiU7diJ7FfmIg7nBsxftdP.iE
 cP2UGrKruUAQxpm9VZ3vhzcHt4KzuJfWuWUuqiGSjSTnM9LKJ0tVLV4VlDfsreoaTgr.VWyuzLeO
 A.OrZJnU8yqH.D1AUyhzix7ZUu0WOb._kAcXIkqWRxeSnEgnOsTyAjvtagF42WEntz41uwKaV4Xg
 D7g_U6nXC7If.8U5rAo0ccm82xriKV0E4HQUDSar7Ms5bD.jHe6xLkgbBTt5FYZsObn0c3usoAuo
 QuQSKG0dOXbZLClnhfPBNAj9sxxI45o65lJq27ViZupenMcsc5numCZx6d33SWOWDYucaLtWiTgr
 .P4laoyaXb1uw5t7nWwM6Z85iZuviO2O0bzx7_Cgsny3r7dPY6e40jcIkdMwfod5ytgAMhO2wH3S
 ZNE_NklpAb7L3kb.hxbr.R_C0TdiVfCLPPQeqCPxtbxqWn44CySAtKWRnOaF9YCWpswWjVXJOGSi
 AXwt_1i0.lXmA.87DHWk6DVtbX6sXSRigkd8Jklbfu.E-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:19:50 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp403.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID eca90f2e660dab57d5d3726b0a8f0373;
          Thu, 28 Feb 2019 22:19:48 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 09/97] LSM: Use lsm_export in the ipc_getsecid and task_getsecid hooks
Date:   Thu, 28 Feb 2019 14:18:05 -0800
Message-Id: <20190228221933.2551-10-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
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
index 2e8516447bfd..f798a947bf8d 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -622,7 +622,7 @@
  *	Return 0 if permission is granted.
  * @task_getsecid:
  *	Retrieve the security identifier of the process @p.
- *	@p contains the task_struct for the process and place is into @secid.
+ *	@p contains the task_struct for the process and place is into @l.
  *	In case of failure, @secid will be set to zero.
  *
  * @task_setnice:
@@ -1080,7 +1080,7 @@
  * @ipc_getsecid:
  *	Get the secid associated with the ipc object.
  *	@ipcp contains the kernel IPC permission structure.
- *	@secid contains a pointer to the location where result will be saved.
+ *	@l contains a pointer to the location where result will be saved.
  *	In case of failure, @secid will be set to zero.
  *
  * Security hooks for individual messages held in System V IPC message queues
@@ -1600,7 +1600,7 @@ union security_list_options {
 	int (*task_setpgid)(struct task_struct *p, pid_t pgid);
 	int (*task_getpgid)(struct task_struct *p);
 	int (*task_getsid)(struct task_struct *p);
-	void (*task_getsecid)(struct task_struct *p, u32 *secid);
+	void (*task_getsecid)(struct task_struct *p, struct lsm_export *l);
 	int (*task_setnice)(struct task_struct *p, int nice);
 	int (*task_setioprio)(struct task_struct *p, int ioprio);
 	int (*task_getioprio)(struct task_struct *p);
@@ -1618,7 +1618,7 @@ union security_list_options {
 	void (*task_to_inode)(struct task_struct *p, struct inode *inode);
 
 	int (*ipc_permission)(struct kern_ipc_perm *ipcp, short flag);
-	void (*ipc_getsecid)(struct kern_ipc_perm *ipcp, u32 *secid);
+	void (*ipc_getsecid)(struct kern_ipc_perm *ipcp, struct lsm_export *l);
 
 	int (*msg_msg_alloc_security)(struct msg_msg *msg);
 	void (*msg_msg_free_security)(struct msg_msg *msg);
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index b77571ddbed3..377fa4ed1518 100644
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
index 9c10d9aae83f..f6ee25ebfa3c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1708,8 +1708,10 @@ int security_task_getsid(struct task_struct *p)
 
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
 
@@ -1791,8 +1793,10 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 
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
index d9179b75acb7..104b2315d36d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3807,9 +3807,9 @@ static int selinux_task_getsid(struct task_struct *p)
 			    PROCESS__GETSESSION, NULL);
 }
 
-static void selinux_task_getsecid(struct task_struct *p, u32 *secid)
+static void selinux_task_getsecid(struct task_struct *p, struct lsm_export *l)
 {
-	*secid = task_sid(p);
+	selinux_export_secid(l, task_sid(p));
 }
 
 static int selinux_task_setnice(struct task_struct *p, int nice)
@@ -5987,10 +5987,12 @@ static int selinux_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
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
index e3639d6f1b62..d5ff34a5803b 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2000,11 +2000,11 @@ static int smack_task_getsid(struct task_struct *p)
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
@@ -3144,12 +3144,12 @@ static int smack_ipc_permission(struct kern_ipc_perm *ipp, short flag)
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
2.17.0

