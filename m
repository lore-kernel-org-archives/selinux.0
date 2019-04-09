Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCA0C282CE
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D6D2082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gB06Fa0Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfDIVkK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:40:10 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:41452
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726671AbfDIVkJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846008; bh=bnhiZa2kx1PJdglKUm2qCM3rIeOnoh8kwEckh5gvzqc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=gB06Fa0QMAcsuml4RI8uu5WCrA1zfrteG020hPMsMSWrB+tBbk5ZQFR4cWRUAHNtIBa13NqMWnufoXa7GSDEPcOEI3Jr5FLndLwzvBiaxLaCh+djA4gqgCkLb26RSFADIUDEyM90gMw0B2nnbXfaDBrR0naIsqOYaIiH6Ew4jnpaHGd+kwLEmlSDXzR93CtSUEe1+Mgb5cpz4Dzk7WJ3ceDjQalv3KVRn8CO/UXkFHST2NNrQCeGbx2RZcncOHN1taoW0O4+uMB1ejO7xS4pUIyyg7AXedq4+GSPTZAvRY4G3FDMRTAnqntB1ivbJ7a32YPr0uHLW2KMCpcths0agg==
X-YMail-OSG: YKw6R84VM1k0FCWcTp72.ycJ1EwOudTV2uQxVPEGILym8CbcNRfd8ZlNRmm4enT
 eWF2xEgiOthU6XdkcgxVNHOQ.wOpUpyrgdPLRoAQ7B18hWAs.JiuSla5FeEFSmwlNLHiSmEI6npu
 OaE25SXfbsXoqhrp1TIuRA4R4xsjpGUtkN_ZW9CqKP9vkdX2IUCDFVWh94jHheMFkQrZ2IgYOUPo
 5W2Evi5RYGyiBQBWJU1RCSYTeS.bj2fOBUtG.av1GHCKcOCyIZc9H0zC2uK5SEKzYAeMQ.pzr_gq
 wHz5ecuXaGYMQ0G_LSfMKMktr8yAKvACQGiqdkwad0s3NegAAQ07wiW4.oc4yMw850gUEFd8qo_V
 cDMAyPg6.PwZxSgw2dgSFEGlqym4cXq8UXKVYswEB3HDST6cBlnNtvzA165viHajty5p2JUWMErU
 A_XimzVHkHvBJZBHILniOt2JnO50tZukdi5U7gbwdm2F1YSSGh9PHmFPypzmar3TNLdC6hqPd33v
 kY7desXQS2ve7wQBVgDkANip1qUX8SzmfjnFX1HruZ_VCsHEgtbM.jilRKfzBDp2pn.kAaeiVV8Q
 oJSehycIa5jf26UUJ00BaKt.uwyzCwM6jmEOc_yAKD.gRnlNmCNTbIZd_JpF8WBQNmlvHRyjWJRU
 .DSPQPg2985nN036jm6ijXcT5B.8PJTFLuJ_yEdA0o.gzkHj0EcgP13mLNzXEAKD7XD7ThwoH1TP
 0iF50ZT7ukGgxCGr8xwbpH6Dtsrxwo_MkLRI_zAaD1I.OHZiw8ovtv8fATFqXXIXYau67CeGzvsc
 govJbvA9eTKr3BZLwgyOq32ODjX8nGhEOW0Js5.ZcLWl9ajRyY1rU3NNVwCnMFki3NjsiFVNGOu7
 olQ5ai14DelcRWxjmmKgwf41KSjAe7v7vSf59EjviDa6fDOk.rW.F42OXjAK8IxB2bzKUDFMmjUX
 kGSMYDtKxBN72I4y0CdIPFHiAQBR8LJW.0mWJ47zPplb9qWKAcoBmijBYFLLtbdgdVHJ.LRhnq.f
 vqxlQP.Af0Cavd_DFZJPqyJ3y7QvwLvereh.5cWjzmcdJbVTSfL_Ik6YtEjmzHEUId6koUwoCVdP
 QyudFxMNoAD3pv3XNG1p1wQ7hQXH36k1ie1mShBuXQyEYjTsBxLkO9y60
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:40:08 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp427.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 41cfc07a55038469dc17a23ac993d21e;
          Tue, 09 Apr 2019 21:40:03 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 08/59] LSM: Use lsm_export in the kernel_ask_as hooks
Date:   Tue,  9 Apr 2019 14:38:55 -0700
Message-Id: <20190409213946.1667-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
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

