Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00763C28CC2
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCDB825725
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qVZneM/X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfEaXc5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:32:57 -0400
Received: from sonic310-28.consmr.mail.gq1.yahoo.com ([98.137.69.154]:36622
        "EHLO sonic310-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727012AbfEaXcy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559345573; bh=vW0GJVqmcxCQIdr1rEmD04j1RR8RMpPnwmmtYdzFYRA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=qVZneM/XIBhxtPyUpTxOG6xwBVTeqgkdiucjyqssg+6doVPk7Ix8nA7zJc1UrCC7/sGXihkoApkkdMhwsQhG+EXlPrdDBSWKEFMARYb0nR86bO/gDfYUQlD65Jlju0nLyD9JMUkX6SFxEs8+eZTyrr8PjtGaA9d/sivIbB29EzcMsyqNCwLsJyR4DcVT5fnVG8eMLJuKJtefbWDr2APz0nf40WfTswwMG6BBEgVtvabdnjwtlWRrVjLizeog306CeOvU07xFX2mx5Ph7t3xvsVbyHNzuDy0cCSeOj+I0FOP03+k4OW7bHehJ5rHXT3mu2RVpKU965ODsMMc4v8eNoQ==
X-YMail-OSG: rXQ9trwVM1mHpKscoTCVlI2xeDs8snL9wS1Y_yH77mwF8etHqF2AQOr78MFBaQA
 h3xyOqgVwyU5921eLAeqYQEKJN4P.RJVy2DPlTqblosS4bTfnxk9Y9l66gCuPOFUb2S_wWGF0WBX
 HgnvpKxJjM1Q9M0RXOAfA9vFAkZMK4vXfbrMbF7JI2PNpA9E7nW3Mt1XpQ4SjgJ8PXEtpdk4iufO
 BLy26d1an7V1BJ8MpWLi9dhB1lYCaLqQHPR7K.C4_BpmUG3hS6QQ3N2Ry5fmW3qTm3FiDimTXGcc
 MfJSVeucv5XQqcaW5lnach9PK2ykIjpCXQzd1yDGCQgvEt5NVThp4xrXw3ULp_97NoXRPIo_mGjJ
 h5.MEmSq1ttcvyHQIEwNSvtdXPs8ub5isvyRQNqH2wHeRaG84bdTuIAiWPnalH09loIrJ5VwWHma
 f8_zrSRlMr6ByvQj3w9aR8B8erpHvfLwxQxtihCwdnuhGQIJVKl_TvD3fzdm1VcS3e4hu2vl8YJN
 thMNrM2c9nCTrypm4toV6Td_q_EzJfraGHMZoZEBUYEgezoFhQlQacCrNd4yZtccDbthyDBVZZPA
 OmM1JQ6AWBnx7v8Qi7dc51LnsigxEQ0BrV74UgQKk9pC2loU7OUa35pQTu3EchkAN4KcnqOj_lU2
 CkEGCHc_tjif882wITnl7fncdwng9TCVokVhpjwnwy0hzUj0O6DthZ1xJjxtgRbEX3AD0non_UzD
 RttxpVaXl.iTtFJZ89cIHywkAxtY86_JJgNoYKrxN4cMfO92_Xd67F.njo77cz5r6vCdeBuuZoIg
 1D15nRFJMFH7vWN5RyuzgSi.R2VdmVngDYxSbB5LF.IYAd_jEvpn4oYRzwXwTsBi2HvabLG4E6r5
 fb6ENJxgGXt3mSPk8bV5zUbEZoFC4MZP8i9EOtnvq2eWO3i_hadQzr0p7nXn54z1bwiy6WQ5PAro
 neRj65OZ4Dg9dcahxglFjOeqzqUibE_JdrnCZh080tjOX0ORb8wCmdkdqnDkYI9mNy1kcg1HghFu
 dQvXuNyhnNWJLcUvCVX0TMaQPHIktMmsAB3bbE27xqybXGh8wna0wd.aP5ccYlQumIsDLkCf6xGT
 PKM_NOQuoXQH3wdbPZHlA9.Rn8iH0qwKwrVcZRBJMGzCgsy4J1ox8hNGl4DaF6nShHF7aiD9hRP.
 E8iNwbNcujXzpntA01BsIBSFC.qlM9KYLE53SiPfkBDEo5.5Hr2O6IcnugTSVJRc_lAFWO1G5VOC
 YnUpJeEw25kuRL8lHpAIh2f6pPkk.Fjx6CRWlYxgWyYYgu5El9T92VCI-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Fri, 31 May 2019 23:32:53 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0aed19b0f4054920f56ab546d7f94096;
          Fri, 31 May 2019 23:32:51 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 08/58] LSM: Use lsm_export in the kernel_ask_as hooks
Date:   Fri, 31 May 2019 16:30:59 -0700
Message-Id: <20190531233149.715-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531233149.715-1-casey@schaufler-ca.com>
References: <20190531233149.715-1-casey@schaufler-ca.com>
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

