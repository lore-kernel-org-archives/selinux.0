Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34379C432C3
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 18:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7C3206E1
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 18:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="q239mXOD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfKMSTx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Nov 2019 13:19:53 -0500
Received: from sonic306-27.consmr.mail.ne1.yahoo.com ([66.163.189.89]:45276
        "EHLO sonic306-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728344AbfKMSTx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Nov 2019 13:19:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573669191; bh=eVAcx7o8q0AFLreBS98x3GgYwdFEcr7jaVdmiN42/p8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=q239mXODyfdyLWwiph9dW1wkX3gaIpLYOCpyt8tcdI4Fx65T2GtlxTSVrrcrf5xlNp+swO2yU8lyVTDkZ16QnLhw97fWR+UdJ8N0Krlcr6a9gdsdS1KLOiqgRB5yfdyUsSHA/4OpFuSNPDhrG3EySPKBBc6VsL3tjf3BsZeMpJy/8MeerDjBr6dQ8R6sGTRoONYu/8DxZfIWCp/IbQkEMxvZbkNZfFXw9297IwXeQ72JlPcsJIWTjxsJGjdl6PGCrPNXTUu06LnhbICZvs0SexLF4SJtPfanBfREiW6uTaO9xPi5w3BFh16KCRG4s7zvqntKffGhWGZRqnWXvVQaWw==
X-YMail-OSG: ukjg1LcVM1mbgbGE9YwmWECW2PO3qNsC38ZQ.lRhA5GMhKYN4P_cqgjyRsi6.eX
 AuA_udZ9Ax1EbeY122YGkLAsPvPmdH.2uBlqr2D8c6xMJRtW6CxxKk7lDW2sTkeM.W7E1KmY9bPK
 ec7hD8tXxJsjCxGUcoUZHOCcUw7Jez6J06qg2mxvh6nDvp_WX16CmjuWAQ5OC.6w_KlqtC5ZMekN
 gPJVlt67lihN8WUk28yPKwXfrh2yidqiaKnFghOjnaCsgPsfh3fM5Zf.yVtZiAvgKPePI7Bp8Bze
 AxKc3_CddaRwO120CPeWjYxotrcCJQGToQp0Igdq3eooEqbkw888Puf.ReGtxhHhLjhYhS69B59f
 I6A7KXrHpDeAQVIDbPW9VTDjOvG0q4RTzZ3PuSUe2ZueH.Jo6dRRfOR3A5VlDgSKvhR.8DxV3WyI
 661bH2ptU1SzjxJS_PepaNLrg9iGtQ6mkUIfudxoILRHTGBN7sgKGUx1TPyaIYcH2lSwOMYmUw1t
 HVAr6szZ9BqG1fQ3JRjSQZPwerTjm4882Qkpy64R18DNv9GuPm0je72f3xc3Iy7qTTggfiIOkve6
 pub.w6vBJb8GfJTnLEc0SPDOqKUonjm3hN6sNqMD0LsYy2PpbDXhtEw3qvXu7kPCgsVNfH_.848l
 DZ3jOFliugd2tX7h1HiJeJaOaEBoHfaq75SpZNxraH6AxOsE30V.PkPNKeNurDzbiA49LXsPd0Zb
 gJs17bpg5ycfLrjULNqSNL52aZ31KsJtHOytbSmTDDQqQn7rIB6ipNBk2UgZ7qfE5xc6fYZZFqmr
 1z4ZoGh_GqBzzS9robIF8wjtR11wJdpyKHIB2NkkzwTjQn1kei.8nTgCYvk5H3QuZaV1hxYaUYF9
 7pt5EfNdiJsULkbs0xVp.vd8oOOVcCxFQnMDEy4j9Ny9NICgnxwpj41UrEEm0.m5XLAHSlbSXUw9
 G6ds6iEJHYkHWuPI5NevicA1arc.lLQ1egrAU3AFKn7bhOAP1Jp1wIPPvnjM.BQOMCDqC.DKc1w1
 _Amhfjho5hMaUz0ot6KXkAmJwYumC9D32aNY1civ3Ee9u9Ardh7WIlg8SCTJmS6Oh_xQBieItIqQ
 O3kqSqe7V6XqUBteBtugf74GAUaWe2rGD_tgq8fI3T_mVQI2irbJ6svriFnr6fuXVtev_i35bIvp
 .3NKenAF9S8fcS34ZhuwGnvNGJHrqVz8mknFpJ7hx.r6dGiVuPTycM968lAQ8hC6GJwj9jMxwps1
 KAl5GlfuL76kKJKhFDJl46o3TVB0LVpf.Dd4Rgb.Q9RXy79fiSweyCCfDovL81IDrJMT9yCTAIrZ
 jqh.ePsJ6HlLgdTIemeY0z5rnLGQUya_alyFUYCE4.XmG3PxJ.J5PDhnjtAk7e7TPIFWjOaoU3da
 WY.8Q_wHAuiCp0HRmfeJl4TazbEuTYzdYoDCmV7KvuP61imVosmcouecjUa66141JRjBs
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 18:19:51 +0000
Received: by smtp424.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 4b8701f92a83437184b73c262f5acc93;
          Wed, 13 Nov 2019 18:19:46 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v11 04/25] LSM: Use lsmblob in security_kernel_act_as
Date:   Wed, 13 Nov 2019 10:19:04 -0800
Message-Id: <20191113181925.2437-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113181925.2437-1-casey@schaufler-ca.com>
References: <20191113181925.2437-1-casey@schaufler-ca.com>
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
index 2df58448f1f2..2b0ab47cfb26 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -435,7 +435,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id);
@@ -1041,7 +1041,8 @@ static inline void security_transfer_creds(struct cred *new,
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
index 7c386cbe4cf3..dd6f212e11af 100644
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

