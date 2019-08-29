Return-Path: <SRS0=Y9t7=WZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15865C3A5A3
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 23:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20F02173E
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 23:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="VC87Umaz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfH2X3v (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Aug 2019 19:29:51 -0400
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:45815
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727522AbfH2X3u (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Aug 2019 19:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1567121389; bh=pBDl/1vQPZOTGhA3y1ZBLm/3xBXXHuqBGnmdEc2nJIk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=VC87UmazrUBVMSm2Vmz/vC38xd4Ws3sPO9/QuEEZ2jJIOeUhaMSmIFDtkoZJRDuInPRJ2f8MwGGKsvA3cpahPYDyLMW1TOfTiiDKFNa9W1HK6017EQ4adGx91w9xOZ4aJqcSt81RQ5MSIEBGl1KgLD28uHwnBvV7qBIBE10p0+mkBQ4qh5U3Fl+2QIxhIFaPeR3+y7UpXCdEG2TR4Qtyf7+WmAQzktb6ukbYxx/jO8K3YLT46ld31jE2SLsG3czVkC7gCokIKhHRTRESIqBpB7RbxfQMfaomPS4nAQoUeKol1TxfjJ3xt8bd8Kf4ZYmB5IVvng1YadJtYHVk7Tl4lQ==
X-YMail-OSG: d1li1tIVM1lYiojYCV00XIT2qJomg8n9N6WiWjGtfYBZHPq62KMMZb4gI9F_L1O
 .umAnpNqphLzA_zhIy7RQL3qouG3TFPUKbCqL.DxnJM6GUetezXPKM53lfvDb4fd_Z6L8v1D2.Wn
 lQmws.mUkf6DRfD2iQ9sD6LcSmBu0fJ2rBXmJY3D7_YfYN2MbcgzX90IfF.bYpnPj0dLPiiYGCGX
 MseO3._PFIp8pIPWnTqd3YR_TZBTmSWAyF4H.vy8D5hQgeLyhiWHaup0tMfzP243ySPC5.VI92Kb
 FZEAZWS0PpjgPXuR26kaCfRQMub_U46R8RIIwNYGkn6C9BqPO6hUg0eFaAMMST6RwUMrVVJejy_1
 dxlX_nI0r47FuqifXYf7A97ffG9Wh8gWN9Kbf_6LPnW3idO47pr6Br_LpklYoXPOVk12f4W96PTE
 h0f5CQ.M6jyK18jC6RdxZW8w8cIUMIfpgeNeSq_amoQvqGdyfdzloX3joqD.aek2pWLoww.5o7Hi
 zEKt1zWi6jsOjKoGJmMtIcNgPZ3rUEmbNtG9G3BksgHy0S5Mp6G5oL2aKr9nyPmHQ5DM5UjgTOi9
 cORRI9gviwEIosZH0hQ.6zn5iszjUY.PFUOHGgFzg1X13N8wqxVItpGoMCi3M7sTGvqjj7Uhrp2.
 O8Q7PFd0H1Paf.gBdNJOXqEW8tcI1KLo9ldYgkeRevwUfkh9pF2itW_ec.dCtUJ9QP6n4Ywd1V3v
 dSbjDoBZFAxm1ZMR2RAyr7m00p61KVveRpQWuugDoPKbHKg2.dHvA3.9LCmHEp5nOrviir1lTKlz
 AJoJRmbqEKjGlZYQldIS4KYQEh97k4vs.wx7becEKJELpKce9lRKsvMNLrDBSiSh8uLv1ck03ovP
 FoVYoe5eg.K679krV84thIreSpSbhPRopbG7530BC2UORD6kH5yB9EsrRmqGcynQE6hosw9RF_XL
 7zB4VOF8X_jKiPJ87A4JbaOxcePCs6OVKco30A2EKOZ_HNfGodeOnSD5OmusU0X3XMDt14EDbtos
 vTHNn7Vqi0I9UhQjN1Y_I6wYmjncF6INReQZolMQT4Cn5zOrvJMdJ5kZ1Le74StHUrB7dBcRGGq6
 6TV2nfEfrIVdENim9SZVgZke3Nu2OS.JJecXCAUF9H4bhBjee2FHvogZh8907FgOAMcRykWZb8_s
 yWBY2VG3EPHJaL7Vzu7Gnw.DUgG7sgpnVZjjLcIokp7zmpOp201Rl9pC1OImGTGZ3RqiW.GyYuBn
 00Z1mTCbisgdihPmmmweCMaobS36g15ozsF0TW2HLWby9bHjYSWz9QasCFJXGGkFyZ.0J2AsaL9G
 niD0Qzco-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Thu, 29 Aug 2019 23:29:49 +0000
Received: by smtp412.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ded9e12cc42d2f561e2af538140d1439;
          Thu, 29 Aug 2019 23:29:44 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v8 06/28] LSM: Use lsmblob in security_kernel_act_as
Date:   Thu, 29 Aug 2019 16:29:13 -0700
Message-Id: <20190829232935.7099-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829232935.7099-1-casey@schaufler-ca.com>
References: <20190829232935.7099-1-casey@schaufler-ca.com>
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
index 4f8b478bc3a1..313e45a3cac3 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -388,7 +388,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id);
@@ -971,7 +971,8 @@ static inline void security_transfer_creds(struct cred *new,
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
index fa6e425e6f29..fa7ab1334f22 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1627,9 +1627,19 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
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

