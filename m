Return-Path: <SRS0=MX5b=5W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FFCC2BA1A
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 20:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22797206C3
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 20:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qhlAepJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgDFUvK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Apr 2020 16:51:10 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:38839
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726399AbgDFUvK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Apr 2020 16:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1586206269; bh=WJCVOWYYuSJXpVEiT7a5PyQ02j71B6bFCC0MlNxEBBU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=qhlAepJWi8kwflKZg9Zs2M6hLDCju2xD8b3yBurrwA2YavjJylW2Z4HsLPmv9QNHiekZcYofgzKUpTxaKTGncQADNCLyLg2FSPOUZi3ZY+yXSqGYfUKazqLOakPXDxMxg8nspTAwV+VQHEHhZLl4hn4d0ga3IL2NpdSz8VkTiTRkyNXO2FuwNtln2xn2xjUg4Mx2ErXtlznjvd06qyjkKqdt9vbuE2BYmb+veMPHaSx7F9WXkiOmIipYERP22XoE4ti2rjlhVLh/n0i9rqBC5vnMODk+K6HwfQWS1yQm6G9drIdL4yddAVlbmjTLqBDgfNciy51Sp+BIYX90wnvj2A==
X-YMail-OSG: Z9fiPBoVM1nabexXH_RY7dJIf5f3GCpvdTOoKee2QRBH584312DlqcAUKDZ6.tw
 HivrWhcuAndt81SOmDDCsOFxMD7dQCSkUEMUH0hri.miuMBBwYgrE6fSo49BBgmZSbDd3n.Q8Mjt
 U4o6CJ4OmQ_oznuS4R7W3rH.iP9YVkf_7lF6W3YwD43NpZ9oGgq.7tSpNW5GrDxUpIDbB1VeqwW5
 RKzuSGlgTwMphaBrBgSpokyp3sgNFNbeKL15IS1RrQVoWkoGAWqvLt2h2nH8c6JCksI3I398KRUn
 TfPwCDaHa.6tMbeQCue.rD.ZEBE_Q4iYdSBW5QXG4YmW5lcRK5mdOUcLaJmVnZ8pZWHiYg8WFhMw
 YDYFQ8wVtLoAbcxhMrSafM_28rcAekDu2a6VzGDF_Utu0Ho6NBNKx1O9m6Pc9F4gA5u_QRCUgtOs
 cYqVUxbMrvsdOfWdnf7ABedKiIhYBjV0UcNEa6OkURWwgIz1WmM_8N0hhgsvRzB9MXYGI36T11ZF
 Q70WIcxX4_4lIEfxTNKxvhP5.IMit9904rP_GcFYY1gRxT_Thgg9.adthm9ayj8AYY03hGsGTiEi
 FAD9YgAJgzz5JNWfLybTXGBWICNWMIfejysfk.5pjE2Xui3YRCMqJiq2gEtW371A98EN9klVWA1l
 bMr7Paiuvgoi1AWRvPCI_JGYSc6kUWU3nooPgGqx6jCyV9X1kAtJnMj7hnWZU4kur.SDFVijkpHY
 q.GZIb.7YmYDfbuhGa6_fsn30LS4YY9gdCRv.jNAk5xoFSeZjKA4qF.LILHpqwwE1zvvzZdfkT0w
 UI7FdXYSeUaaYOhxBT2dE0IQ9J1a6eAlwKrWVDoEUHg.nhlU3r7T6W8HekT7nP6e70bf4APl2TK0
 zJ3sULgZsQ25XQcsGQcPyteCVdAC4zrbBWSMJ70k150WUu3EAofYKR3.bhuFd2l2bY9wNLF56F7i
 k8Gra5xVT21sTT1F0t5BvZoBwtYbPppOMHTYkdHb49b.kKhknI2srfpWkRd3IX1h7PfR8ppubh_X
 _uxvw5CfgERxSzX5RdztBkLZoCzi2vJpPVNCqsUduUfGnQNhIoEKSH1VYsp2SUdw3b9mq2w2rhVU
 CbIxUeT0vnKPCx0XuDodU2ZM8t1gXSoNhEgS2a9QYaoDng3PyYb5eMMospHCyW1SIHCvAC_m5N4X
 YoEolfjEbI0NRP9U.WTnSY_RumfnjsovSotfOCj3v5aGuY7lJRm6yChU1KrJDWrLbRwxB07nifMy
 EmroXnSVwxxAv.eZv57erIuUdh2ogMLll5TjXfHkiux9WW9G2wJzAkiSBzsV1bRB3LvPrqFBnq8_
 EU9.vAkJqoGLQuiFl9Fo7Pb1xPSkzLoQZ.tcD1zCbRkadAzfvKdp1GTh8HoBsMxZXrTIcCe0WWjL
 JKqxP9or4BjuTqmyCt38WiwbM9o8XyVIPE7GdjpEwyR8tMxfVG1zW0FiJlxx92Rc-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 6 Apr 2020 20:51:09 +0000
Received: by smtp417.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2eb94594504b5b7128e51d68e6c17b33;
          Mon, 06 Apr 2020 20:51:06 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v16 04/23] LSM: Use lsmblob in security_kernel_act_as
Date:   Mon,  6 Apr 2020 13:50:04 -0700
Message-Id: <20200406205023.42338-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200406205023.42338-1-casey@schaufler-ca.com>
References: <20200406205023.42338-1-casey@schaufler-ca.com>
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

