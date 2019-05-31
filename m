Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50E0C28CC3
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D70B25725
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="bdtclDYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfEaXdC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:33:02 -0400
Received: from sonic316-13.consmr.mail.gq1.yahoo.com ([98.137.69.37]:40807
        "EHLO sonic316-13.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726933AbfEaXck (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559345560; bh=cb378cxqvPaulkSS7n2iQ2M2+2lKAprXYeun9wbD1fs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=bdtclDYKVmO9wXcEFbn4nCh6NB6ltWtmuPNHr1QW9K2JnRiE7BNPGwEJx5TkNqu1hItQK6sZaQdHA7p+x/vTibMD0+7eRhweatUA7aqhtlCtsqH82D+M1Agb3kXBWlmANE0KzDBalBL2ox2Hy5EK29IoBW5Po6WyJ4OtYZzJw8gotNZTy5atrANTHQ6l4fkN/cn+k3jjGMHWK6pQUBjBhooJeqRusG1n9gwfgoqYICTfxq40/eubz+zBggtHk2yetedg/q2qoDxLt0GpwHYp3BBHNwSlQ8vsQSIW8itIFmJNNOilmTeTdA/KqD/6Sq2oYxOTMZGvC/pd3Degi7HLDg==
X-YMail-OSG: 56iJK3EVM1nZZEuhAjN6TRctv_ShxK8RVSxOXRETHaiKXGZxnp039ZVSvGdTeiy
 j39Fg8CKYaCcw8lu0deuYdNo40rm3v_94MHiqUEXUubD_0k_0pr7l2zBt8X3Pi4AHpD1uqOqQMIR
 gi9qBdN3z6NMA.fvdEner09JkyJCSX7TyCUr9zdH1LFzbVWy4cZar21CpmXpoPxjN7nUF76RD1tm
 W97tuUVqnYSY2pbPEXkwRkn3jmLH5DWG2uCt5JEhKiIXoiv7ccaReV23mIMnNt_txBM4czMgm88v
 z0EjHD.Ab1s2SNJ0oHClYTPQmTx49z5FLo3EMKIzHxEXeDQaWJuNFb_U6gP1DSdPwiP.SFM2iGSU
 KVcV95nP0m6E4SEMzVhwEAy9ITBMR0m0oYWvMkHKetB5Ds4M5wQNoFdfRC4GAM.yp_5.7AR3fETL
 6AQA1bX6vR7Nm5Fe8JcgqA7KIL1v8wujG9aleuUTZoZaD7kbtmf88gWVKdhAQgtuPS_vv9RP1pX3
 k_747QnI3eKx2bpJ.PMiq4b4EaT3SVP7WKRzXQD3PADPMn3C0meB.kL1g224Zk56K_oAkcdpGR4q
 PS6iHzqVT.Ih0TjOx7MbPJGa7.M7AGyTyHLKv2GX5kxAlTuPEJhrAmZSpPfeeaREbyitxTKuja6i
 3B2sfSbw4N85NrcXv3.tS0XKujkifGhYJEZIE0rf73Vlr4Nq1GClWHy3cMZiMU0KPis0npgwSmhQ
 zBMs_e3bHwoFEQR6ggkH307CoQbZ5Cvp03ZOkWVs5Zriqc9mHrkqAlXin1MWUyrcTmarK_.TLtD.
 iQXgh85fS.Pm10R4gh0QX.laxgLidz1Ff2o6nrPwXnPHAzCIlN1n3CNZViz9RDJY2t3VFIld69oI
 fSWS7lvB1WZAG4XOMEU0EokqhfWovfheSI7_Fjkih.wTpIA4w0wYwGnvg1ffn0kbeJMPFPxParMP
 k4CnGdJ9mkVBXRQWM8tR5MlrieulHhEjKxcD_2LdLs9o5RqU.9DigltA5Qstt0Q.IJxK1hiM506W
 UzsckWoj8fpUsbFYeAaJHxd9onEzxE7riPsHH1AR5I57oYHqlWK1vs_ryC0U4R0wrfGg.OKJQDfW
 DaCUa2q8G4ZLPUiWpFJ9nCCp5855RTLEcVx5aGudjDBGVCWT8cPvnqOVPF03.kgdjXZCSbPtRTkw
 zqzAWVGuaV68jSnWr60UT2E454jZU7.y3wnK4ut5gp66cjiXUJrIujbY7tsz0nCGLlCsztbgzDGC
 GeXAFPYSTR9gQ9jobXrUfTJryT6ixdSBZoIeO0C8nTjihZwbuONjm6Y8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Fri, 31 May 2019 23:32:40 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp429.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 843b556db8dc4263deb8469fbc0cd8b5;
          Fri, 31 May 2019 23:32:38 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 07/58] LSM: Use lsm_export in the ipc_getsecid and task_getsecid hooks
Date:   Fri, 31 May 2019 16:30:58 -0700
Message-Id: <20190531233149.715-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531233149.715-1-casey@schaufler-ca.com>
References: <20190531233149.715-1-casey@schaufler-ca.com>
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

