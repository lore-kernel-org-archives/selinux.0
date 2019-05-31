Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26ADC04AB6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9378526FE4
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jqY9LxRs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfEaXLi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:11:38 -0400
Received: from sonic310-31.consmr.mail.ne1.yahoo.com ([66.163.186.212]:37827
        "EHLO sonic310-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726483AbfEaXLi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344296; bh=vW0GJVqmcxCQIdr1rEmD04j1RR8RMpPnwmmtYdzFYRA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=jqY9LxRsUfZ6PQIjotKN8hy5YZj/N47e7EVzuJlHuWJX4Wtuvb6slXUjPiCB03BudlHNZNx808p2T6ry7rsP6PkDupPCqCTwxsY8/n//hJMVT+zWBPMJ8bwbSH6jCYk1+iq6Z5v9EaQebqMIN8v+rQfWfyVJkSvUQD1gM461sEmY5iafvl0Ckn04IBCkQcyFBKCmXznxVhNZohuz18wx+C9Td2jJtCrj/fW4ttMiPmNHd9oYdeAAqMRR7pXNeK9Qk7JeWHFEwpucx/uXjAnBGzwf580G4bvvgkZ26OrEcFYV930nfF1yHTY5Ie1GuJUqzdtF4FuVeRsvrReTd+zHDA==
X-YMail-OSG: 25CpyDUVM1nOmObmTgjLv8EElB9Z0hkn0ObdS_JXE0ZgQ6zAlu8DzR3qbRRsT0c
 FOmNEXD5aDYyFfGl43Xky_VSF9iRq7yYVbIoNH9ke_rj42S9GnGhjYx2acrlkbwRJ1d8prIj4Q1p
 TxKlSCP3izcGX6CiUQtDLRZZm1XvhZ9LT4_tIdfpP7.AQ7LGhnMIj7tyUG50Om6WOmJb_pbQQkIk
 sH6PxvuSQRwgBAvjZ5OT5HPg6nT5qmlh8x.tcKXCSih.naRbHZ6JLGJ_QYHdZWmp5IKm.yyvLTtv
 7VDy3Z5CzYrQrg62LGLy8W_vCg_WYtk2X3oArU56gzux0amorrP3cxQeCE1ceZCNPvPM5cYmd2qF
 4gGXgbOyAKT9qa8BM4pUeou2KdDYGxgTW5K6jWOBEnvrwvH0RitjadFYd6OzQMTckTfYh4vPDzHE
 k2Nsgw_.YdOQfUYe7FXHCQwzwMkEiyjWmy6pKYwC9r_f9Zq24FqWdKJw.eWUqa6COH8liHc91p4H
 p4kgdJBcXBLL_5G6odcdiJ5BgHxZ3idnCfzemde30sehImvhoX.uifDWUBO.eN8Zp9a8QI9gCMtq
 Gx4OeMrdFNbkzPoY7TWSQPGbO1r9PwLLHJaTTZJIFqPudlE_sNew80RwHFbMkE93xe7eQjluQbot
 mzdLeW6ZUAGMTO5wzybGH0ATaCtfoOq45DRPgdx1DvDKAKpNN_mJAx7ptgEOOQwKmMfzSWKGR7v.
 oWc2eO7.BdMW516hbLmYXUa7o4ZWTIgftSE8GO5ETGw9JhgtS4xI5_IAfTpKdjA_se70Gs8BuPGx
 S4eb0sZg2Bb9XsPWkdY09J77lGkPSg9vC6jUFANXrSuJYMFVI4TvCWSiLsWEjq1t5uAahJknVEob
 .SR.gPFvVuQHeox32JRrX44v0TpNXuHf.qia326eG6DEdqTyx5xvP0yFr.lP6OOuHQ6pGkS1c84q
 UOnyq0z8NJqEVBNRsRtoQZHXbEDErbdleaqiWzROY0gzYI.hAF6AJKN.hcbN2GLZSMrr_37a2ku9
 Kv2wKFDimnE9h6kcRWJG7ViPMv3zPCyoFFtefCd32nZNfe0GpHvsY4IgyWrS_ro416EoQBeJ3Svw
 c.Ix9.FUQ16zV9YFmkd3MF7HLtPgyKPxAs.zo1_ksO9bTfzO8I02jVAxCo_bFmD7P2KOB9xz.kDn
 LV6LyLtdJFKv8m.inza.cq_bvp6LnXwu63dLK_ZX7LIQu7KVS9TclEUSNHKu8bgHaylbfkXD.5Al
 zd0F68g8SJsyVCxe1sokMYPCWvhWH6KNRuC0NJx75jq7PFNtHAGq1q54wNg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 31 May 2019 23:11:36 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp415.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 3476acdfa7cd8f6c2fbf806b530ae11f;
          Fri, 31 May 2019 23:11:36 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 08/58] LSM: Use lsm_export in the kernel_ask_as hooks
Date:   Fri, 31 May 2019 16:09:30 -0700
Message-Id: <20190531231020.628-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
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
index 62783a923136..800040050032 100644
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
@@ -1598,7 +1598,7 @@ union security_list_options {
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
index c82108793fb5..b88a51b6ca41 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -222,6 +222,14 @@ static inline void selinux_export_secid(struct lsm_export *l, u32 secid)
 	l->flags |= LSM_EXPORT_SELINUX;
 }
 
+static inline void selinux_import_secid(struct lsm_export *l, u32 *secid)
+{
+	if (l->flags & LSM_EXPORT_SELINUX)
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
index 13ac3045a388..3b77a0324c3d 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -475,6 +475,14 @@ static inline void smack_export_secid(struct lsm_export *l, u32 secid)
 	l->flags |= LSM_EXPORT_SMACK;
 }
 
+static inline void smack_import_secid(struct lsm_export *l, u32 *secid)
+{
+	if (l->flags & LSM_EXPORT_SMACK)
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

