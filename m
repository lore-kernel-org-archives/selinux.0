Return-Path: <SRS0=MX5b=5W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEA9C2BB54
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 20:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4EEF2072A
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 20:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="bb5VHC9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgDFUl2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Apr 2020 16:41:28 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:44151
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726246AbgDFUl1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Apr 2020 16:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1586205686; bh=WJCVOWYYuSJXpVEiT7a5PyQ02j71B6bFCC0MlNxEBBU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=bb5VHC9SswV+K0+l5zKHOpiSjCcc5eEaejFsSfkKGQRrfZXeuwiaZkLjKjS9zluKmZc0ObNBLj+bqYhwQiNJ4kkslQyP7TcrROSCo86P1YxT+GEb+ycMuSLY1kg1xLvUm0tijmmtpZWiX8TH7C3+BYE2q9m4TBWHQ7V2dWQnOxxYL5GWiv8SVmWtduhnRvkM6VW4I/51k5CSnUngQprkXUOkvvvb61mqtwUnzH5c+W3jXL/ZOVDaw3S9aXDIT8Y4s1loOivKbAYWgS246arqcdi7V9NV7c6ZfsxED/sr4IWaaY/+76g70hokQ/q7wdwkUKCuCQhkzJYENpLmMkEIKQ==
X-YMail-OSG: LyW6jBkVM1nYeS8z4BK6dUUhM2Eorm5SC13LKuJoKgQn4gpZDYq8z98P8D_2Z3b
 YrCgXvA4Ij4arFP5C8sjLOqFYi01cfm0filRN7bYGrE0nbxq11iF33_dqEIKdFtaqvD3kqiCRiIi
 jK8MkiHPNW7zNVO3ASc4AxWy6G7O4B7XzHR7y1HC3yYsYM4jQBiKQXbVpWwZScqCKnCiUY.Vvvs0
 hvccrcMb4KGZcEq90UWlB4qI5funNfHl5sLU50AQVMtm8Z_6AIDZG05jJVC1Vz6XHSVcCM.zTnKi
 ruCidMX25.t3wUN0zBimc064g8WTBuwecih7flnjHXyC7f6Cs3vLd.GeWWgRac0OEPeiEFdzYue3
 0IAgBY1vprgk0yk18VeLDNq05iygziaMzu4rDt1OVt767zRFTmAG3VoT01mlG3SrhQtJCo0DyYor
 FeTNG3WNrLheLSPtCuI1AQJ8C6uMvbPJYak5DWUwNhCgopFxscT6Y04J1CPm9NvE3IQ3FOjCz9r9
 dC8wH7IHd_HeCUWW78qlfF.c7abmiepc4ZvAb.QHgY3JPtVsjw_0pvCAp9g7860QUFJ9ZlkXc68s
 44pwU9lCGqXw3cqK_LoHJ5vqWrUVaAmOAbfXmwUqcN01XXaFqBYLFMEX689_MrB_VuNos3YNnrvF
 RlPkXpHz0_A1368kbMUpSDPXLFTszMeT8nKm1yaay7MjXKDc5PH4XdvFi2Vpe1Q1JjlEx5oXQJxU
 NmG6ZaFI7OpvmOD_WsUVZWRVWvRpoYxK19I21TmmCKdtTTAdaE_df4g_9U9CODEHs4o9AP_Goycv
 S9783Sg7BhhpdrQj5SL4cTEIUVPpgdFCf5mwyV7PsgGZea9m25f_5MSbqFnVvgc0JsfPdiwNssVs
 m373cGHyykMQHghDDTgyADoL3JjEPbW_C8CT5Kh60RIRhjs7MrajHXZznxgndLbxAPX8JRyged2i
 V7H9.4wG5v6dF__1LYwFL9cG4oLD4Q7L2Wuo7zTI3uvlM189EZKzIQhsEvZN.cxwAc9Eyzzuu9Re
 GJf8AiGgZi2yRxlUqW3FZyovkNrN_womOE22DUKP_aOAkejDjR8BuxJRezH17JxQZvEuqJmgx1CB
 buYuECkDGJr..kOF8hbVEyE9zrALmANJjMCoKH3kkFHDIok.1ML3bp.1cFGbWYGP5sSq5I3_LpnM
 rtiSuqxA7rCBS.YcrnUI21tbM8I5HfFh6MT26S8e2QgrGpL7Ytz4XY4uO5R8qmGjrGfoEUAFkHzW
 eV_FS4GpP9pXetn_Vv92DzclrBHvxgfc5V_aW1xEDIzrr8Txr.oeQcIM1T9N8f31vDydwLa75_n9
 pKT7CppQUH2zM.NCzIG9aR9l_Hd0ljiy6eHZopjxGoDs6uDuB8MXRspMnUa_oeslwF.DIuBrkna1
 w08tsLrvtThzHZac3SX5zuVBhdZsfgVrMBL7iNFNlAz8JjAIBnwcfIVTd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 6 Apr 2020 20:41:26 +0000
Received: by smtp421.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID eac70c79f4175a564e746280ba268c3f;
          Mon, 06 Apr 2020 20:41:20 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, linux-audit@redhat.com
Subject: [PATCH v16 04/23] LSM: Use lsmblob in security_kernel_act_as
Date:   Mon,  6 Apr 2020 13:40:18 -0700
Message-Id: <20200406204037.42262-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200406204037.42262-1-casey@schaufler-ca.com>
References: <20200406204037.42262-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the security_kernel_act_as interface to use a lsmblob
structure in place of the single u32 secid in support of
module stacking. Change its only caller, set_security_override,
to do the same. Change that one's only caller,
set_security_override_from_ctx, to call it with the new
parameter type.

The security module hook is unchanged, still taking a secid.
The infrastructure passes the correct entry from the lsmblob.
lsmblob_init() is used to fill the lsmblob structure, however
this will be removed later in the series when security_secctx_to_secid()
is undated to provide a lsmblob instead of a secid.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/cred.h     |  3 ++-
 include/linux/security.h |  5 +++--
 kernel/cred.c            | 10 ++++++----
 security/security.c      | 14 ++++++++++++--
 4 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 18639c069263..03ae0182cba6 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -18,6 +18,7 @@
 
 struct cred;
 struct inode;
+struct lsmblob;
 
 /*
  * COW Supplementary groups list
@@ -165,7 +166,7 @@ extern const struct cred *override_creds(const struct cred *);
 extern void revert_creds(const struct cred *);
 extern struct cred *prepare_kernel_cred(struct task_struct *);
 extern int change_create_files_as(struct cred *, struct inode *);
-extern int set_security_override(struct cred *, u32);
+extern int set_security_override(struct cred *, struct lsmblob *);
 extern int set_security_override_from_ctx(struct cred *, const char *);
 extern int set_create_files_as(struct cred *, struct inode *);
 extern int cred_fscmp(const struct cred *, const struct cred *);
diff --git a/include/linux/security.h b/include/linux/security.h
index 9d83c6832bae..1bfaf9ece13e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -439,7 +439,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id);
@@ -1045,7 +1045,8 @@ static inline void security_transfer_creds(struct cred *new,
 {
 }
 
-static inline int security_kernel_act_as(struct cred *cred, u32 secid)
+static inline int security_kernel_act_as(struct cred *cred,
+					 struct lsmblob *blob)
 {
 	return 0;
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index 809a985b1793..fae63c0a1b36 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -732,14 +732,14 @@ EXPORT_SYMBOL(prepare_kernel_cred);
 /**
  * set_security_override - Set the security ID in a set of credentials
  * @new: The credentials to alter
- * @secid: The LSM security ID to set
+ * @blob: The LSM security information to set
  *
  * Set the LSM security ID in a set of credentials so that the subjective
  * security is overridden when an alternative set of credentials is used.
  */
-int set_security_override(struct cred *new, u32 secid)
+int set_security_override(struct cred *new, struct lsmblob *blob)
 {
-	return security_kernel_act_as(new, secid);
+	return security_kernel_act_as(new, blob);
 }
 EXPORT_SYMBOL(set_security_override);
 
@@ -755,6 +755,7 @@ EXPORT_SYMBOL(set_security_override);
  */
 int set_security_override_from_ctx(struct cred *new, const char *secctx)
 {
+	struct lsmblob blob;
 	u32 secid;
 	int ret;
 
@@ -762,7 +763,8 @@ int set_security_override_from_ctx(struct cred *new, const char *secctx)
 	if (ret < 0)
 		return ret;
 
-	return set_security_override(new, secid);
+	lsmblob_init(&blob, secid);
+	return set_security_override(new, &blob);
 }
 EXPORT_SYMBOL(set_security_override_from_ctx);
 
diff --git a/security/security.c b/security/security.c
index b3fab8fdbb57..914aecd89822 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1647,9 +1647,19 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
 }
 EXPORT_SYMBOL(security_cred_getsecid);
 
-int security_kernel_act_as(struct cred *new, u32 secid)
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob)
 {
-	return call_int_hook(kernel_act_as, 0, new, secid);
+	struct security_hook_list *hp;
+	int rc;
+
+	hlist_for_each_entry(hp, &security_hook_heads.kernel_act_as, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		rc = hp->hook.kernel_act_as(new, blob->secid[hp->lsmid->slot]);
+		if (rc != 0)
+			return rc;
+	}
+	return 0;
 }
 
 int security_kernel_create_files_as(struct cred *new, struct inode *inode)
-- 
2.24.1

