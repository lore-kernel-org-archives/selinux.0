Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D39C10F14
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1150821736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ZAsGd4ba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfDSAqo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:46:44 -0400
Received: from sonic317-33.consmr.mail.bf2.yahoo.com ([74.6.129.88]:39100 "EHLO
        sonic317-33.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726650AbfDSAqo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634802; bh=bnhiZa2kx1PJdglKUm2qCM3rIeOnoh8kwEckh5gvzqc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ZAsGd4bafd56PFRMHUc5qyPabsfvhNJTWom+YPXuEtKNz3O/0PnJfSCGYTvuCrInqFp+oU3d802iSAqTuUn5xIdxm1mRcldioONUXOIaASgsk+1w7CZgzffDolotti/Ut25FrlBI6PfHbl8eaefGZ0gJ605/zSDO3Y6QkByObvhQVe3PJviEi4jJjn1OEw6E+uIQVPVOaQtJ2eBXaoaPBAVjOrojXR5w3bTElLtuPj4DUqpvO04g1r9kI1MbKVAxmqCXTS4ZOKmfULsglLs2HZ7NEcCC8LpY7l7MtPfJ7ZFMFCQQSz8Bsjluih2PspY4KL51qjJFAbiMpfMJJyriuw==
X-YMail-OSG: lGfr7bYVM1l4ratKVDr8.b7L_mOFAQq6iaoueN7pW.axNRQJEts8JZfU0AsccVf
 rhXYcXQLT0grva5xgAgjdpaXWMrurTyRH05uahlqdgPb_eHQWpMPwzYBlm9.vw_73uCx4soJRnGr
 E8hrjf2J.PRKxyKXVqhyiINwbKTa.BkIIx93V.C.QsHskq07ErRMd8qO0_z8CE2TeG7V_iGcjExR
 ibbkQgN_iGACv9SDq2feWmiQS.umgCqOvIw1At9rWFfzxrG5XBjKvXM8qpk2CvNMV_xKQ2wDlylE
 l43AZqaZSz44wi.5D8jyVjOwPLl7Izf7GSpFKdmyG4jjK2Z3eYhVsdF.Y_zYWQwvu5QBr7TvoMoU
 DHWsey9fH.43da4yUwFafpFV6DqVw04_gB30Q4cPyzjYVzuRnYXd5ORQAWBzI9RXspWhc.WC6FAc
 6nVKWLQbwM0UMvGn8Kvh.lKzjy8MEFeT99tHsfIvw6WFGOLmEExfMw.w.XC7dw7MoK7Ns.SS7HgC
 Pb6CN5yzfyQqrCuap3hlx6C9XsSHFAYW.JGYov2irT3nTYPbuCvUjBgmYCwdMu2s_lCcP4FmPqBi
 ukCX1x483BSDFPfUT6P.cqVPFmEiX0X7kz3_qW.Lj7S09og9QPLFkvcDiLhiEvl16gB2onTPGvt7
 ZKyFXChc6ebkNvPWOagrvnhwvBkZ8CwkopM3kwEX3DmiEqXDNjN2aYRC_v6acK5rTUx46kq1x9g8
 KL8G3FJf4EHXNWFVJ6_M7K0lcalvHrXCgug5lBj2l4F91nb6FpwriuYY9Dzma3edV5_6kKvkMoWh
 b35O4YRm4nIwXQseM_8aWLW5ELAh6YR5X.9dKItFrtfn21lHoxdN_t2Le.tGnPNZVOxYOxYbtcin
 vIvp39PmfAy6aZXRLaPnRxGVbumtfSeb0EP6P9Puo.6jJ2fFLp.vqHIz5z95mAfsm3sCVxcIyYqA
 en906KhxjPsfBCtcK.VW0EkjS9Tf_8aWVwbuXqENpW0gca_gXdlkQ2ecNMSNRbnuvUJulEnuLHlM
 9c6RMMVR94kIYSYQ7YFtD6Aa0iwrcCnEV.SL66yzoQQyof6pN5qq9JtE6PcmpXspaYAFUZ.NricL
 g0dc8LkpNG8Xaie5IDvD_BeNyiVLMNon2DaeRjAKJGp7zwlbkVoYRVSDvRm9.muqRae1K9jpqqow
 wNtnGZDALPeE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:46:42 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp416.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 832c03259c9605aacd6ad56a0995a740;
          Fri, 19 Apr 2019 00:46:39 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 08/90] LSM: Use lsm_export in the kernel_ask_as hooks
Date:   Thu, 18 Apr 2019 17:44:55 -0700
Message-Id: <20190419004617.64627-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert the kernel_ask_as hooks to use the lsm_export
structure instead of a u32 secid. There is some scaffolding
involved that will be removed when security_kernel_ask_as()
is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  |  4 ++--
 security/security.c        | 15 ++++++++++++++-
 security/selinux/hooks.c   | 17 ++++++++++++++---
 security/smack/smack_lsm.c | 12 +++++++++++-
 4 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 544671f44dfa..85b8217ce2f2 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -578,7 +578,7 @@
  * @kernel_act_as:
  *	Set the credentials for a kernel service to act as (subjective context).
  *	@new points to the credentials to be modified.
- *	@secid specifies the security ID to be set
+ *	@l specifies the security data to be set
  *	The current task must be the one that nominated @secid.
  *	Return 0 if successful.
  * @kernel_create_files_as:
@@ -1606,7 +1606,7 @@ union security_list_options {
 				gfp_t gfp);
 	void (*cred_transfer)(struct cred *new, const struct cred *old);
 	void (*cred_getsecid)(const struct cred *c, struct lsm_export *l);
-	int (*kernel_act_as)(struct cred *new, u32 secid);
+	int (*kernel_act_as)(struct cred *new, struct lsm_export *l);
 	int (*kernel_create_files_as)(struct cred *new, struct inode *inode);
 	int (*kernel_module_request)(char *kmod_name);
 	int (*kernel_load_data)(enum kernel_load_data_id id);
diff --git a/security/security.c b/security/security.c
index 802557ff6f60..3a766755b722 100644
--- a/security/security.c
+++ b/security/security.c
@@ -742,6 +742,15 @@ static inline void lsm_export_secid(struct lsm_export *data, u32 *secid)
 	}
 }
 
+static inline void lsm_export_to_all(struct lsm_export *data, u32 secid)
+{
+	data->selinux = secid;
+	data->smack = secid;
+	data->apparmor = secid;
+	data->flags = LSM_EXPORT_SELINUX | LSM_EXPORT_SMACK |
+		      LSM_EXPORT_APPARMOR;
+}
+
 /* Security operations */
 
 int security_binder_set_context_mgr(struct task_struct *mgr)
@@ -1647,7 +1656,11 @@ EXPORT_SYMBOL(security_cred_getsecid);
 
 int security_kernel_act_as(struct cred *new, u32 secid)
 {
-	return call_int_hook(kernel_act_as, 0, new, secid);
+	struct lsm_export data = { .flags = LSM_EXPORT_NONE };
+
+	lsm_export_to_all(&data, secid);
+
+	return call_int_hook(kernel_act_as, 0, new, &data);
 }
 
 int security_kernel_create_files_as(struct cred *new, struct inode *inode)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c82108793fb5..8d4334f68a65 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -222,6 +222,14 @@ static inline void selinux_export_secid(struct lsm_export *l, u32 secid)
 	l->flags |= LSM_EXPORT_SELINUX;
 }
 
+static inline void selinux_import_secid(struct lsm_export *l, u32 *secid)
+{
+	if (l->flags | LSM_EXPORT_SELINUX)
+		*secid = l->selinux;
+	else
+		*secid = SECSID_NULL;
+}
+
 /*
  * get the security ID of a set of credentials
  */
@@ -3773,19 +3781,22 @@ static void selinux_cred_getsecid(const struct cred *c, struct lsm_export *l)
  * set the security data for a kernel service
  * - all the creation contexts are set to unlabelled
  */
-static int selinux_kernel_act_as(struct cred *new, u32 secid)
+static int selinux_kernel_act_as(struct cred *new, struct lsm_export *l)
 {
 	struct task_security_struct *tsec = selinux_cred(new);
+	u32 nsid;
 	u32 sid = current_sid();
 	int ret;
 
+	selinux_import_secid(l, &nsid);
+
 	ret = avc_has_perm(&selinux_state,
-			   sid, secid,
+			   sid, nsid,
 			   SECCLASS_KERNEL_SERVICE,
 			   KERNEL_SERVICE__USE_AS_OVERRIDE,
 			   NULL);
 	if (ret == 0) {
-		tsec->sid = secid;
+		tsec->sid = nsid;
 		tsec->create_sid = 0;
 		tsec->keycreate_sid = 0;
 		tsec->sockcreate_sid = 0;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 13ac3045a388..da85d607d40a 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -475,6 +475,14 @@ static inline void smack_export_secid(struct lsm_export *l, u32 secid)
 	l->flags |= LSM_EXPORT_SMACK;
 }
 
+static inline void smack_import_secid(struct lsm_export *l, u32 *secid)
+{
+	if (l->flags | LSM_EXPORT_SMACK)
+		*secid = l->smack;
+	else
+		*secid = 0;
+}
+
 /*
  * LSM hooks.
  * We he, that is fun!
@@ -1997,10 +2005,12 @@ static void smack_cred_getsecid(const struct cred *cred, struct lsm_export *l)
  *
  * Set the security data for a kernel service.
  */
-static int smack_kernel_act_as(struct cred *new, u32 secid)
+static int smack_kernel_act_as(struct cred *new, struct lsm_export *l)
 {
+	u32 secid;
 	struct task_smack *new_tsp = smack_cred(new);
 
+	smack_import_secid(l, &secid);
 	new_tsp->smk_task = smack_from_secid(secid);
 	return 0;
 }
-- 
2.19.1

