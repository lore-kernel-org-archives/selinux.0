Return-Path: <SRS0=kEwY=UU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEDBC48BE0
	for <selinux@archiver.kernel.org>; Fri, 21 Jun 2019 18:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2982075E
	for <selinux@archiver.kernel.org>; Fri, 21 Jun 2019 18:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mA8stSB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfFUSw6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Jun 2019 14:52:58 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:43120
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726314AbfFUSw5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Jun 2019 14:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561143176; bh=A47bndcPrdIkwuDKlZiS7KhWCRcVduzYUwB1mHIhe1o=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=mA8stSB/XKbzLSfzcr234ZxVpJ58c8g5HZO/kCzbnZdv5WgacpCnlnIzLuXiOQic7HSpat/S3dcaM830RGq7Ies+qbDDyVZ+adL3/+ZMV2UB+2L+swEko4Dw0XopC5cxTPIRXCqHjkVsBg/CbUtRTy/pBORxKWLr9iMI0MxPd2ewr3ZmKum8Ul5OX3mbsHIgsjKMc33MLKaKGqulUmd7yqJ3pmaB6OX0MCC1y7O7HHIwjNeuob/QViSotqtR5JPnpmJHBtqoL/QG1oEt1YKEIDpuaBZLY20+akZoSIUK5THmRk7p7EKQOhAIhBUFoIwN0eqpwHiofbjEGnJfQBf1WQ==
X-YMail-OSG: zs8.3DYVM1nAoK9oSeAUahrIpci2sf5j4GyZmTcxhDBy2Qr9ApQn3AGkFb4Xlso
 Zh3BqgjR9zOSkj4A9maEDj_gcSGcNQKwB6KUKTWz_zdGEq9wWeFTa3yhbVaLJ_yatcfYqiD81lHw
 TUxi_8iel35lzoCXqmD25Q.0QU4BCAFElx8bM1aZ0o77cyhKxOEy9qpY7PF8.PXIWCbIYy654.rs
 3OhhX8347dKC8LyR9lFJ0ByMkAJdANhVEMTRNEbH_ALfvQzsG3veeJsScQKC_F3pA49A5WzU3Xl2
 7geZ6gpU_F_QfDm9kP9MMMVcA2JZzU2kArCfke4qiPCmlrUGBrGY2GbDB_YDNSXHi26fYrkX.boo
 .AQRN4UzC577N383E5Ag61ms0zg76Jydn_t2TOrl.LRD_6Jv_VG3bOWj19TVsdcrENMrOiIvpLzR
 HuDxvEkUlzBkNpcEpuK5KV7mWSZQBA6VkC2kWoDbdvApVvK9u11GtjW51xpdOHgHIIeHpZNPw5ye
 jCucOMHkVPGx8vwg8u0UHXKUOfI4XcraBjHRh1LIhriH6ym5LihWi4jLDWnsHTH3LNLgoKtOvMJX
 Kt3W.I8Oym7Kv3x4X6LCdGKMGuyEgM8nLNwwXxYRxCvnEEQXDjvwqat_wUlCsjsx0.tX1lM6S6TV
 vT8nSVCinJB9CTwGk1dClaTbLBndPajqz2.hc27mxBmmkka6tWh430QW_lHEKn9cSgHpTekWF5Oo
 IbRHzsb1iHZ1lUg8K95bAWdmzLK05ihbCWxFxgOSMFuaFqAFXqmDhsrokL8LtM32oS2Ud01UIuo4
 .aw3KUoo8WfxCzjNHPNev7HLtvvRssMs34ni42xlqrOHZDlKzKw5G5VLPFZnUfhqNJ3dzq982jzS
 FFdD9ZcZvbAD0DHhnKXsristhzS6H9qmsaXvt0oC6SFtTJ.aVbCQHr5kKFSx6p7wAxPFDJfGvErB
 dUHUUP66Nte033Qia97DyFtKJweMdQC13i.5K6KHD_KAjp5i7kJHHG2OMQnk8pYeytEyWst16WAQ
 y5AC3Hs.F4YbCI19n_FBKeuZNrZpenGUXMvkwCj88AZ36n6r9w78pIivCqCt30tot3fOHOIzSFaC
 xjtLBmFcNd.164otYe9xDfR8eCbimQH4iYwLnBpTeg9pffk.lpzwCJ3qxh_6kfMy2ovKWOAHyWvN
 QDaPO45.cIeYpYOj_ivR_wigWYHdQ6Jui0w13xFL2Tla8AMX4AJf1h8QYoTpPEy7GQ4iAvaPsBTT
 rzTCBTuaALUMzBT.dvYo9vgIJKHrF52qCCV38BQJtNGHs
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Fri, 21 Jun 2019 18:52:56 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp416.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 1d10864c45a2fe45d2b5b4a73ef7e245;
          Fri, 21 Jun 2019 18:52:51 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v3 06/24] LSM: Use lsmblob in security_kernel_act_as
Date:   Fri, 21 Jun 2019 11:52:15 -0700
Message-Id: <20190621185233.6766-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621185233.6766-1-casey@schaufler-ca.com>
References: <20190621185233.6766-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the security_kernel_act_as interface to use a lsmblob
structure in place of the single u32 secid in support of
module stacking. Change it's only caller, set_security_override,
to do the same. Change that one's only caller,
set_security_override_from_ctx, to call it with the new
parameter type.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/cred.h     |  3 ++-
 include/linux/security.h |  5 +++--
 kernel/cred.c            | 10 ++++++----
 security/security.c      | 12 ++++++++++--
 4 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index efb6edf32de7..9a21c376ed97 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -22,6 +22,7 @@
 
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
index 52d89c4a9594..4a78516cc74a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -384,7 +384,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id);
@@ -967,7 +967,8 @@ static inline void security_transfer_creds(struct cred *new,
 {
 }
 
-static inline int security_kernel_act_as(struct cred *cred, u32 secid)
+static inline int security_kernel_act_as(struct cred *cred,
+					 struct lsmblob *blob)
 {
 	return 0;
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index 45d77284aed0..71c14dda107e 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -701,14 +701,14 @@ EXPORT_SYMBOL(prepare_kernel_cred);
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
 
@@ -724,6 +724,7 @@ EXPORT_SYMBOL(set_security_override);
  */
 int set_security_override_from_ctx(struct cred *new, const char *secctx)
 {
+	struct lsmblob blob;
 	u32 secid;
 	int ret;
 
@@ -731,7 +732,8 @@ int set_security_override_from_ctx(struct cred *new, const char *secctx)
 	if (ret < 0)
 		return ret;
 
-	return set_security_override(new, secid);
+	lsmblob_init(&blob, secid);
+	return set_security_override(new, &blob);
 }
 EXPORT_SYMBOL(set_security_override_from_ctx);
 
diff --git a/security/security.c b/security/security.c
index 4692f44718c6..43f8018b9e13 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1646,9 +1646,17 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
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
+		rc = hp->hook.kernel_act_as(new, blob->secid[hp->slot]);
+		if (rc != 0)
+			return rc;
+	}
+	return 0;
 }
 
 int security_kernel_create_files_as(struct cred *new, struct inode *inode)
-- 
2.20.1

