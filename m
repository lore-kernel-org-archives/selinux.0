Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95114C28CC5
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB3A27982
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="iX7QJZd4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfFBQvj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:51:39 -0400
Received: from sonic303-8.consmr.mail.bf2.yahoo.com ([74.6.131.47]:39545 "EHLO
        sonic303-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726892AbfFBQvi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494297; bh=vW0GJVqmcxCQIdr1rEmD04j1RR8RMpPnwmmtYdzFYRA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=iX7QJZd4DFDtpm0CMgkGaFU2Ua2EKQ7dt+71SUu83Ccswd0bFBFeHHdsNb4qOwbxJh/e4JoAtQng5eihyFmEqK7hYQnFgMIB4794V0PY+jpX88LkFmeOsuQXyYOutjDaK2sBFQkiBp0KkMkbN6c9DDpY6wMXX5KGLC999A0Yrd9KpBXt+tGI5derYr40Gy2D4xZEChc7vzydWby+H4+69GCAAv2SEeBijQ1KLSpLvZjNPORUmdaUY8TsgNGsszVB6UzjukaROO0eoatSXxmexAn/UUWeZTBBtBbaHrF/ruS/N+g8kag6N8KUdlR3a+jF/LRsSJCc7EPgCfWdKjrz5A==
X-YMail-OSG: Zs11AKUVM1nmvZbxv5TY4SdBZOh274Y8fp4W5rssC8HkHLhl4UQQ0_zS8UfkQba
 EYUsofjySMHVm13INmFKAVg_jUCMVP_XJFTRXL.DBg.qLfSpEzaIq6yw0rFOPmlSF3RnGlMD4U3z
 .YSmrjTmULjtYXniAXK7Y0ltCwzW2rOFQe7osmgAZDXvmNtg.gB9_NwtPDgqydBY59TnLZli5TQy
 8m.q3FjAVegIt.i8GaPsjf8WMKWDy.JAcZ8rrDs0iED2RMCvTUZptP6vbzSojYih506D9Wx24Uc2
 ujdBQdBFVQnvJyWUjCsJlC_uyoPxh8uI7H9ggEP77hs1JDiKA6RynEthjwaxP0Ga3mMUXT8HN0Xt
 o0rl9DYzE8tf7BpBSKnJmW_VU8i_q1RSEOMYdZjj6ZM10hbcy61t0jcoNifrLqchTLfYTeghHTfW
 uraZvi_kHqmKWZ5tDBWpOZqDYm2cOT9rJ9hnfUyNz2w6h9MCDSHoX8oKsyoVBEuYvbmPjKWKdW0W
 P_JULw4z56EwITpSKt9m20yZysfAvS.EXIxTMET0tvTx3EDFcZAmrVACexVtASOzQeS6VQ6.NplD
 AE7ScRsyRcbPej4bcP2_SBf3FLtDfqR1x9Cv0pkt4KVM8cI2ZrR6RjsaBYr7ETQp7gQU2g0oTrgB
 8XKmgOuIHQFsDy6iWgBuMM8plndGAlLbf4ModgFApDlUWB67BcCcz2EgW2bO2V8h3eyjRjcc880q
 _ccV1lz87GX5uqpRUuZah5Pp6lrr.uHgIGUOnBosVwwA4k4vILAto2dNVIH.Wpk9PEdreOwukg8K
 CcLTJeIlD0iQT1_60k8xnlCtmBtvAg4DoT6RU8T_21XfsmbJKoJnthng4TnjO.S3iNE14oqIh0UJ
 VVWRBYmvF.2t96nXdbwmYN9hNW54MqSofrHu2isD5m2cYUrBmTtjujfC_NN91U8PsciyUmk..jeZ
 QPt.5B64uCFqprGaaJ0hJ5naBLVvoFiRRucz9QWSpHDlwvkTI7QI06PrWnqCyGlOXIzVDkwaZXk7
 jGPGQt1bs7uFI7KH5yUBI8Vedh6U.W2WcIXzUhQsT2MoE30AV9phpmYMks0wNj3b0UAb0pivjZmD
 rxRDNtEW1GbW40xGlNfd6asv.4cmxCg46p6hk_0FWUBmUjSN6wRtO8IpTk3zJmnD9f1yUgGFBS0S
 5bq53_v9j2afPAciKdt.79p1hMMk5Cr15S8HYHBDdBJ_kPfviO.G1F6AhsKrMDqecxjFDL2GiyyU
 l8I7FaAMtmT4.RWACy3X7a3gK3TbBkXeqCBQjRPioN_uG8A--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Sun, 2 Jun 2019 16:51:37 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp413.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b3a8ad7d79501e3c392fdc3d79d8fa55;
          Sun, 02 Jun 2019 16:51:35 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 08/58] LSM: Use lsm_export in the kernel_ask_as hooks
Date:   Sun,  2 Jun 2019 09:50:11 -0700
Message-Id: <20190602165101.25079-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

