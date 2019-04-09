Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56F2C10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E46620833
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="OnkZfWsm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfDIT7y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:59:54 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:44219
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726635AbfDIT7y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554839991; bh=bnhiZa2kx1PJdglKUm2qCM3rIeOnoh8kwEckh5gvzqc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=OnkZfWsmn8fJ9RiKj+YlBLkXXWFzm8NY9qARjH9HQ/g5rspBns9bThBHFeUqty3aMt+FzqCr2igtYHVXwOtpefF+3tOqQSCr3AqibKwskB2jfp/8oZfuRNXo7199zu39AB/CVp1vWjn3UnQrmrRld0V7xPzOWezvgfc+NN86lJKJqUqgekgRaoRo1xBEA+U6O2YdXy17LeWD1eTzMg9r+J7lcGufPAmdkSg+UhbpTO2FjaWO65lNcSDM7MnY4G65FM8PWoCUbIFA40s4JNarVFbRWdpILvVSm+TwtvCOOsJJzVxJKLUl6O8He7GDQmtAs7fomR/CBZi42bM/nrXUAw==
X-YMail-OSG: mT1HGmsVM1krtMiO4gp3KHU6GvnOLXqs5ecC.HmIUD6kb.g7SdM_JVw4XwVV_bA
 oShbfSLJaaXe387gbEkQaM575YfCPXPY8ygXHQlJqjB9ikW4ie5JRUraRW8O9.jA.wy2b6_9UYt7
 i6qNpr0e1p17rSRZtjXWxomWaitjSpwqZ7A5OZ5kea3twL.aNeiujRjWhTsT6RfRd.M42zm3zzYK
 n6JHwh0ugr5vOZjdYrxss8_bBEhz80cAdfnOl.kz_7A1sKCCMiZXVJ0UIhF8r4MmLx7L6qmCQ65b
 JilliBrk1NU3dOTmQ89.QVzreMuDTY.VGKUvV4b3wKBfvCvrDnoJzK_RtPl5Ps1qZXoDxKJZXdnF
 qj2U.Zp8bc8DonmQLsrJatwNFCPc1y_R8wjw9rgec2.A_qtcDVK98q8SvSW.12zT9zQ9hv1xdzZn
 u3TaVH3b0h1CFBwgWqValVVR8TFCnFGM6ZcajYU0MfqtDW583mAyIpjDpASR2LAugnjQ0BsjSmp3
 zJUsQMUcdkLZpFAr_h6x3sC6B5YjLzOrIeRN26XQpfTioN3IxX8rUcQYW_vvv4bv.IB9oveJgVwT
 nlphSf.oVOF6V6bTbEO4aa3Go8357hsy1F_cLAJeCq77Kj9RQYf7Hgyn759iejkD0Z0SSG2SHBbQ
 mbRW_yz9RfrJMrYccJVQOIm0BIlh46bdw7J_Ab0L.0CYBWtcjKrp9NZpmgDXh_6XgXwWSQq3Qb5J
 aYHVA9RAEYeQjCinKCWBavfG1Mb6Xr.vQwkYYgj2ozwgjFbcHUkW0TmvPtMW8CeF2kKFKf53.Ra4
 01Y0k9OuOuHVGLLAzP0ainbRAm9fEkuHWDQri76OA8HEM1aZxNeMv15Xfi.rIyiUcjls684PEYBG
 Z7Wc9pjlHwyylPxiUwKwBQSvIu1eGea35SBupCzz9Ye0nPZk3Dzmp7_mIetC1jRCLrYI7nMXpUsC
 .KvjOZTNQRy_vv3XdaHjekYTkrSuT2ocR09s.d7BQ5OPHp11hzbkekOdmiFgDM6IP8jb.mgsm2kV
 JZsugF5M8zm5GRv8r7jzYtwzkxHMlE9WEdinDf8TFHrTQDxWGJkhyxw.yA06_E7sycKy6j3UCc_A
 98r_S0cNE.1aHD5UJPdzAFdBwP6O_94LRdlpEbj5K3HRZd82ItmqrWawgeNeH
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:59:51 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp430.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 552806e231f63bbc1dbaec1014ade557;
          Tue, 09 Apr 2019 19:59:49 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 08/59] LSM: Use lsm_export in the kernel_ask_as hooks
Date:   Tue,  9 Apr 2019 12:58:33 -0700
Message-Id: <20190409195924.1509-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409195924.1509-1-casey@schaufler-ca.com>
References: <20190409195924.1509-1-casey@schaufler-ca.com>
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

