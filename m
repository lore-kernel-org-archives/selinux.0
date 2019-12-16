Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02A2C2D0CD
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5EAB21835
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ksh+ukQ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfLPWeL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:34:11 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:42062
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726948AbfLPWeK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 17:34:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576535648; bh=/tjZqQ3eFg6RGmAZKeaCUxadHu2YVRy2b3KPUAFCwsc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ksh+ukQ9/ef2yZ6M64xfzxV5gYnyvATxDqer1YdfL5FOgGrxBJBkqtzO+GqQWwAKH9fKxwfssYHI6E1jN1kyIP14CB4cfuZeAONPktVNWia4Ht+eFxzpJrF17/w3JDMIbvc2ZZRN5JsT6QZ1RUuzeDJZFt02MB5MVKRljA0qtbXhd0q+HDJV5Sx//9gdQ8g+ATnFMisUw+DslX3qCjrkvWr/WI5Cb5Pv43i5H7Z7B0/qUBjJVbXxDciV+N3QzHYRrX/ywwsQthEe31sk+2jkgqZwcc5OcaF2v1rFxIgIanYctn9HdH09BfhKdtX2o8B93n85WTPy+0HMSWHVEfiIzw==
X-YMail-OSG: h7jdypYVM1l4PHWoGgIc2wyZXqKOnjb7vESJfEqPOEDKVxauW3J7gKXLpsh9egV
 EqCQ.O04fCPLFBzTXv5zd5cuP.WFsy0d.R116bpl4JUJLVzPW8JNYisugz5.VROd7bqLQXmEwVM2
 uvFs3WMgF3Lc7rSMuU6PXcVjd6nU_LwvmYKeUn18Q3IOlPaulqRnxhEC89k8wH8YEimrYD087opH
 O7b2NXXlaz6w7vND93BflUoSLjkkuT1JZr8WDPlAPUGUy4pZbt.UbSYviKpTgTsy0yl4eO.CZuMe
 Tk1TGx5sst_dB0mw1dmpLUkX7FcBdEpakpT_P06onqc5GmvvzvnoAoyp.UtOAiBF.b9Fv94Edwih
 roiJufCN0GktGW.MYHpRTWrzgzJVkupyxNUQaECPvujV5WEhpajo8CYpfGpML7TOvVbl.7dvMzdj
 Yw6vT8MgWBLwi0z2ncqLwL60eH0he8DWeuNTKD6DUm.Bgk3mAM6Oz7a0xtBXuOGN7CKXku5kdgOs
 lYYWSBeXkrZ24K6x2smOM.HKSampaP5yLbH_aYTbIQaFqhMBh7BIUOslq70Ja9_BTUBxrcryn69e
 wRS7n7zsLIw8vk9svM2ltwCSDWF08ldT9yd0a1sULM0DyZvRv8AR_vbpVJWZTSbg5cnoewvcPCF_
 XXx0TlPe5FWFuCZLvm5ZmqKMH5dzlQKlRh6ct0WbvH2D11ODvqHBQkkNQWdDHUyUL2n46QJVeJ7A
 _Md29sLgqX5Czmxh1r9BdH_ds8RSqdGha2lbOEY4gaVHUkFwh9hM3mqi3xyBsEiR.tbT.Pc_JOv.
 tH0IKfBodv1Vr5BG60OiPygAmOPPcJ5ibHe2YY_2TDGdmXYRA6Pob0HOtpQaWIkbEQy_2Vn8RMYf
 .tOMr6OJiA_n8.jlp6ntFN3PwOpvxy9AVQ8INvlJGf.MVzMD_Se4RaD7UMABXG6htQwy4Wn4SE7x
 TZ.1vTtEbAFnw6UJSuJKNExty7N472BJbgd__lVgVqA_io4BvjVR9iu6uFK2qmyptPQsKxH_aJjW
 dqClGuxq8aVWwLHgACzdcn9wmI77SB9qNNHY6qeD.TTOtgWURNPV9SF4WRFV0Fb.R1uST1VN9RLD
 SuFuV6K7Chp6amq9lHnWh_uYomXuMKKWuOC1I.jkNzfwj4iVoyk1yS61289RxGFrXZu1SO1FkM7N
 xURud8Y5sPgnTpVDqeOMxoa04614ZazIMeWF9Um_ujCtBBt4abJySkIRmZUEVGnzb8BAaFQLEhUP
 obh4LrIxQpm6g1zamFL_OjOWYz1pLLsVKiwf6nG9XiOlgmRc7aZUamzwFdNWe4HARoXPF9NbZ0Dj
 PnoDFZ3Kjlg9TffLPhbsWWEcr3Sms5v02x01QYgTC4YUEmUcgemojEfQ9cladhXrS8H3pEVXlc09
 IecTXAj0vMUk8SmnFsRASN7oPVMGmJE0jr3Z8Yj8_tDlcgJGgEMbE1SzASNoLehVn9Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Mon, 16 Dec 2019 22:34:08 +0000
Received: by smtp426.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID c9d34065d35cf5052e1c371e78fe445d;
          Mon, 16 Dec 2019 22:34:03 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v12 04/25] LSM: Use lsmblob in security_kernel_act_as
Date:   Mon, 16 Dec 2019 14:33:24 -0800
Message-Id: <20191216223345.5066-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216223345.5066-1-casey@schaufler-ca.com>
References: <20191216223345.5066-1-casey@schaufler-ca.com>
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

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
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
index 9c6dbe248eaf..322ed9622819 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -437,7 +437,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id);
@@ -1043,7 +1043,8 @@ static inline void security_transfer_creds(struct cred *new,
 {
 }
 
-static inline int security_kernel_act_as(struct cred *cred, u32 secid)
+static inline int security_kernel_act_as(struct cred *cred,
+					 struct lsmblob *blob)
 {
 	return 0;
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index c0a4c12d38b2..846ac4b23c16 100644
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
index bfea9739c084..cee032b5ce29 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1615,9 +1615,19 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
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
2.20.1

