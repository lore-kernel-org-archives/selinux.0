Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C0FC28CC6
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57ACE27982
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DRErV1oJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfFBQv1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:51:27 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:35288
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726836AbfFBQv0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494284; bh=cb378cxqvPaulkSS7n2iQ2M2+2lKAprXYeun9wbD1fs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=DRErV1oJzFjxEj86oe4cWv4dzB1rzQAmSz2QIV+5/zASkWtrOdOP6fCjEkmzW8PO8pbZmyw4RulYHF1qm57viq2c9cy+vVgzbhxai+KY31NV44KOUGIin0Ov2eIOa3xjyY5Ags9o6r5WD5RMGi30/0UZi8ODSaprQQv1tDbLSpp13n7lIBY8FvG71OLU/tUi8hGMVQ9Y8mX1XEAZeZ5PMsQt/FFqD9LDi0fbDrqlHbbkd0mJT4i18Yk349mkm7S9WUrMAH+iH0WhNK+ESdA/IBnzg/vtOyP2T6B2n1kLpU3I8QR5pv35xd5p6h8JzPhLWNS0G4AldS2GBbZd47yLGQ==
X-YMail-OSG: TkTqDKsVM1ljFDevli13pY6iKTYp0UuZIE2Fxlulvy_Obk4luqUjKGaO6LfsYHb
 6AYlqIo7oKO7sUThc_PcNn9w1wb6VyZNaygwMrlypwukXgiqyWbPfZzMTn1ky06QaudQqRc2WWSN
 pr0Hes3sgM17QfsGAwgUhNy90OIcml7BSHexJ8XbSXlL9VmSUCzKfsOM8aCLpXsSgXOTWcWuDb0w
 axuSxfHxg9Xt7G.wzQA8LQLOHDkwDucxHWAOkZ.L.SLd4LVbeCO9FP91sgLeRA2guY89hFBmGGra
 .R8Evr1.gFdSes3aTVbC5CcFVxSciEeZb.Fd6n4wUw.RGtP8MXUGNgSdQRerQy1aSzkYsHeX7WWr
 f8_ydxNsYKtQqsA09MkyaxfLarEMYxX25UcOZmw8jrvjLuDl7LDadQTo4LQxWzq1Fb4ICkzspxe4
 2gDBUAu.N9fEKYHRIh1TT8Toz.TNH3T1ozYjqurOHN9Sxa.G5s63w9GZ4sJyDaT1p.46lVBuAnV7
 ICK9nouRdIKKnzy9vO6EM87irO0tvk7tePRqhdtnYTy2E4r8v6M4CqXhHZ8Ew5v3JpN3wYi66f12
 WsdwxAjnlz5EsbSAsVZeg5CX8YwmxsUy2t2dIfYs1v1_R9xiHfHynkV3a2SLsT1D6wytu60f_y3o
 nPqKe8glQw7jtqS9DsYF7cIZm4FiK8zqrEvpIkhFeqr6zAw39RJmNEdb7jFKV7lbwliEn5sMI1IS
 isXMP7Ppkxq33yms8KmSWqL6VM4YPYpZEmeFNtYyU3K9bZREFdqKoW0S6flTKR4jS8PkeUyXAj5Y
 s3U205V_3FIh8NveahQUm8ACOoshD71YA5oFaXl.lIDX8ySzar8.WTxJq7lAHUxq05V.9IvmJjb6
 60Ub2pM3mdGB01uC8yUAD8F6dH9nEkqDcN6WOUnsGzWXnhUXuOqLnfRVYvvg6tAAPKKSyf1k2Gku
 7rEOqOuAnzsJ27TWvhv3Bz3YRU0Qu2_1kzYD3eILPIQwx.ksOWlHpbWPMPpQAVD019YkKJKf1sRQ
 U5PmQXLavv.DILwHlvFepk.Fm_zC0Z3pNP_2kV9F8dRT_QId_uN8G.D8rEYAKaNA7L.sjRuRqcGL
 vCr0Sr23Ime4KV2_v.wFUEu9yJ7Ss5QUzksWEwB4MVhRuuMjTqWybJO_DYenT1u92Rd_RsbHSHSm
 DrbAcXv3GIxfvNftraaEDdfk3PgAq4kQzLoCtygFnOuUdPqIYUJf9Fhm4C9hwVOstpYCZP5iU2Te
 sXjzsCpTHM.MKErixQQke4lP8.s_gmSMsp6dzI1ots6M-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Sun, 2 Jun 2019 16:51:24 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp429.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID eaaddcf00ddf2fd5d1fdcb38c64db575;
          Sun, 02 Jun 2019 16:51:22 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 07/58] LSM: Use lsm_export in the ipc_getsecid and task_getsecid hooks
Date:   Sun,  2 Jun 2019 09:50:10 -0700
Message-Id: <20190602165101.25079-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

