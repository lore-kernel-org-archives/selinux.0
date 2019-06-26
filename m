Return-Path: <SRS0=8O8t=UZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C835C48BD6
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 19:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63BAE216FD
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 19:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="iWOiHENz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfFZTWw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jun 2019 15:22:52 -0400
Received: from sonic308-13.consmr.mail.gq1.yahoo.com ([98.137.68.37]:33880
        "EHLO sonic308-13.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726420AbfFZTWw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jun 2019 15:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561576971; bh=TZBusq2zGIDBSe2zXLBHwJLZvI/3lHi3oCzveuJcYh0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=iWOiHENz7FkLQ57HgKVDGPUUNJsdzFz99kuZzgYZUij8ohKHimp22qCjhiqWPcGumD6wFBM6qB4Y6sre7RYRG8Lu/BIV0d8TC/3sRQqtuUr6JrawbD0mFUm6W4Wb/tUgzBaPYq1Sk+FBEqtlaJa3jNLFcfhh9bV3XqSqrT9VtMjsggDw5LIbovtupWWtdmtIeO0uKGeUAstqMs2K25UR2MiRUQIy50OjUXIe7Z/j1HNr1WHIBDP3AIpNsFXc7qxOrekLXza6Az87VWNq1dIOYc0v4WxVriM8/QZqwM8jtIEoI/+su1HU92bJ+8IGtrxAn3QLFHuLizHgDaLprHLoTA==
X-YMail-OSG: eyX0Z9wVM1liL58SAjCo8hwAkluCIZY8JlsGklGK5ng0YLQb2blxkHOybtJvM43
 oKu3_k4E0u_F7a41hBkP78uUwqBrztOusi25Um1nPA3s13UiBkLC0hq5k8D5hcQrbOYRytpxeZ1i
 KNt4XHIDnZ77WFTBtviwjMafp7KhASoAF.r3IcgfKzPAgVgaa2q6Dij.EnHYpgVbyrEe8r3G6j4g
 avNtdj_OPkUvx6t9zkwFuf_u.GEG0MXw.9IxlnqFnsS1fMDYNc0KW6t5d1.sCGmo3BmBLuwdhYQU
 TyhPPqbECH8O.g1b0nR9lOMl7QPXzbcGSvv0tbANVwm.h1zbjYM_xOMTg426j4lLl5zkEAuc8mR2
 cPFBHoLM73uCSIigA8SKXttjyK179QjujYTK2xcOKGjxXaXPKodHFB7CxerYx9w443SkL1.67lK4
 dl4xFxpiDksix.9o8phIIm6rHYRtZDAeVytO6bzWHNbB3LMxT1ayyn3L6ifUlb5qVCDtlrQCyhdW
 aZ.eyQGWZ2ZMQlK90Me7VELEo2CHzcybibGbt2P8SL0ylWwZQ7MHDaJxYb75eKfaJjx9O7udzmc_
 gsoZdf9fGf0StcdYVWryHYna2OoLfRSA9TNGlXvmj8LuxfWdWH6zhuU6taMfNeFO6gOUTfmeFLgu
 W.fiyYPHpLXVXApD8a1amAx9w0thy.dwJCLvH3Yq96IE5P8xala78WYcoGbOCf8gdoQUsQLlBx4D
 5SHH7Gdo2ppT_7OdlU3bw_8Xy.jE1heAYBLmV6DtFV26RA3R8zaHJ5j7phNh4Wk5Rq23AYjTIlfc
 JPUe01J25.b__WmXDrvGMCycMQlBta.oVgLG2MZEpXTJixLcXBf.v9NkCwHB2nUOwkTwm_IyC7hk
 oN1tu26UuszFQpanJjItvjeL0FgK74OyDNlP5lpEaIaSHV3u9gnB0kSmUL__JSXFE8R7ZwUZy5uD
 eknxf7hC9bUWbtc3epX8fmGatri.P3uvAVPcnxcLOmOTGYkTR5cOHh3W1mWFaxucvOPVQZWDbLKj
 3e_0_g7rE.i5iO8ZOJ1HvovfLcAKS16PJUwiVEpY7rFXbaaEsffsKZ3Ys2aeVLwVNeonlyLjPLWu
 me2V9YXFyu.QddGB1lHftnMYT7Lt2ovvT4lRZ0yGV3uTqsY4pHj98l_w2kBSWyRSGwa5P0bAmsRy
 LWkOnYAXYfjiGZrmyI9WHAH9PkHVk44oKiW7ubzJG4O3UMFLDqZzhrZi_y49aK1RkC93Z.NvgxpM
 LMshJpCCJgXEDZESoENXaWsy68ItPiWVWnkhwT7cwAg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Wed, 26 Jun 2019 19:22:51 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp425.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID c714fa5cf5fc340fbb5c59821a30e7c3;
          Wed, 26 Jun 2019 19:22:49 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v4 06/23] LSM: Use lsmblob in security_kernel_act_as
Date:   Wed, 26 Jun 2019 12:22:17 -0700
Message-Id: <20190626192234.11725-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626192234.11725-1-casey@schaufler-ca.com>
References: <20190626192234.11725-1-casey@schaufler-ca.com>
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
index 46ca4b85ad96..f9c8e1926a0b 100644
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

