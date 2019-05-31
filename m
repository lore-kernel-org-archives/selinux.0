Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F624C04AB6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319A2259B8
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="CSfN4CeB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfEaXdg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:33:36 -0400
Received: from sonic316-13.consmr.mail.gq1.yahoo.com ([98.137.69.37]:40171
        "EHLO sonic316-13.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726643AbfEaXdg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559345615; bh=kPEVpSTXbzStzk2RRdBr0uzp0UqHYw8ZEJtQ2z8HYS0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=CSfN4CeBPzEMzyo+r88CnDPR/fp+CdfVgkwo9LVZc7hWYwYTdGTveJxGa9OGx//1fCSK3HphLtvYmUN4TM1/pYkM996LDh8GWVXEpf5LTXgaRHgpJg4TGBGgKvXk/YXUfZH4C/QFZBpSckJZ6+xhRdB4JfoeScL9zMsxMqICFGFqaU+uchWweDBRjhp2sD1mwfQFCwDoMs/lZSnqjj1mohzcm+A3T7MBNtkcxFS24FYO2vtU79TQh9PTv1ymNCJi/TnJlBGKVegUIzPhecxOF74fiApI2VqBb5jbiV+Pzi9uXSOKCOy71eYXPm18qsQY1EWgag1IvCI4POVt1iBZtQ==
X-YMail-OSG: AFk426cVM1m0qzDNDgAAQtSgNOHiQGCYSj9qjH3FQAow0jqP9R2YZYl01tKZzpr
 WP2xCnYnCw4XWep7qIvpCLb8ArCcN5fPBLbFiPAgDTafy4nMJpxYPcgpXGUk6jtl8giakWcAEPb6
 EOXHWbNiE5.lJGsinyh9KAdXRVqNFnJDFseWO9cC4aeB16av5tXnAJPM94LVyMmMZvqV0RzT.h24
 2nY3VjpvXsv3lbO1obdLJFGNw5O51kWkRX5Jlw4TmmgA6yLiTzHHtRBiv6q4qABb4e_x3h8eUfcJ
 7NaQRGqgtjWdz_3rWKL_D50t3SQOYj7qpliH8pje_tVdjf3G1gMp67Fp.7MT42x6td7snqEHlWxo
 e7DVPXf4clTt4edqn3JFL57xoEZ2YVxWqUy1w4IoUqBvWoNNIUSKUj7YBUONdq_AiHqnzQBG3IyY
 YhJVRElV4qoT1.9RHKVE2UwSDILb1h8yKk7Uqi5jH4NgJTMUd.CGBKBQ21RCp2Ga6EGDHX.iDMmy
 Q.viLa399neATLey9eieHUTfDWnP5vOkMNIFOv4psn4AKiEQgTHJuiFDrghPo1iiMQwATGhJTaF8
 42Pz.m2vk78GZJR6S8d2QUO3JJ5zxhkfF_s_NGjxjAGfmbqmxM9BUgzYbeMdKwUNTzm328u3DAam
 a0XACbgKi_ndrzcVH_1lFpXRhD5QjQOdc1KEgONItO5PJppRv2.NVE0nCiCD_ZTwpCjDEJJ7LMVN
 LEe8.H7lRua7ONSsfHw7wMcD0GovjwpsoAWfe_i2O0VwDlW3zZveWh6Y22m5cBjF0388Y8trKtm7
 ugvBfu_GDUa9Wsb41Y4obyno0N7NeJK9b.L5ypIu9g15hF3gGCZWHF_UrKVf04E1O9FbBLcAptIv
 5Rj9j4APsRO881P9Y2tgpGnSLXJXScL0K5mK.bfXDuBkvvuf912tic.zwbyeYmFYcceQbzi4Wh0g
 iEycwrKOisIubDSlt6p.CLNPoPUrJahlbLjxF44utxSW8lG7iGterzMP3Wo4cv9qCpif08hHVDVQ
 7cqvL3LvGnIdWyG.uINlLsWnm5ApjT6KMg6AXeCuxhoOjcni1Sw.WaO8tlLigf90ezQ5Grri5OJy
 WwO6Vc.YlR5gEUXHx6ILeopdAd4wYOh9LFtWY5T3KY0gAZc5naABjcFyYey.GF.8mbj3kTUJgxZ1
 YXZM_Mz2qqSh0jKbGcmOPKY0zYnLAbNpsQjOgnBGmBWVUHGjJdk_dtNaxX4FrO_dd8Fhri._cUps
 wUWse.Wid1.UDhkejcZGYC.oeWdBHw7gPxoWrkVp2fiuFxQmzsWBB0kI-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Fri, 31 May 2019 23:33:35 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp404.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ddbbc57c2db67044df9793aa98e74179;
          Fri, 31 May 2019 23:33:34 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 14/58] LSM: Use lsm_export in security_kernel_act_as
Date:   Fri, 31 May 2019 16:31:05 -0700
Message-Id: <20190531233149.715-15-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531233149.715-1-casey@schaufler-ca.com>
References: <20190531233149.715-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Casey Schaufler <cschaufler@schaufler-ca.com>

Convert security_kernel_act_as to use the lsm_export structure
instead of a u32 secid. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/cred.h     |  3 ++-
 include/linux/security.h |  5 +++--
 kernel/cred.c            | 10 ++++++----
 security/security.c      |  8 ++------
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index efb6edf32de7..9305298eca17 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -22,6 +22,7 @@
 
 struct cred;
 struct inode;
+struct lsm_export;
 
 /*
  * COW Supplementary groups list
@@ -165,7 +166,7 @@ extern const struct cred *override_creds(const struct cred *);
 extern void revert_creds(const struct cred *);
 extern struct cred *prepare_kernel_cred(struct task_struct *);
 extern int change_create_files_as(struct cred *, struct inode *);
-extern int set_security_override(struct cred *, u32);
+extern int set_security_override(struct cred *, struct lsm_export *);
 extern int set_security_override_from_ctx(struct cred *, const char *);
 extern int set_create_files_as(struct cred *, struct inode *);
 extern int cred_fscmp(const struct cred *, const struct cred *);
diff --git a/include/linux/security.h b/include/linux/security.h
index ea2c6c4e88db..7369cdc3a681 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -378,7 +378,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsm_export *l);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id);
@@ -961,7 +961,8 @@ static inline void security_transfer_creds(struct cred *new,
 {
 }
 
-static inline int security_kernel_act_as(struct cred *cred, u32 secid)
+static inline int security_kernel_act_as(struct cred *cred,
+					 struct lsm_export *l)
 {
 	return 0;
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index 45d77284aed0..40a3fde22667 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -701,14 +701,14 @@ EXPORT_SYMBOL(prepare_kernel_cred);
 /**
  * set_security_override - Set the security ID in a set of credentials
  * @new: The credentials to alter
- * @secid: The LSM security ID to set
+ * @l: The LSM security information to set
  *
  * Set the LSM security ID in a set of credentials so that the subjective
  * security is overridden when an alternative set of credentials is used.
  */
-int set_security_override(struct cred *new, u32 secid)
+int set_security_override(struct cred *new, struct lsm_export *l)
 {
-	return security_kernel_act_as(new, secid);
+	return security_kernel_act_as(new, l);
 }
 EXPORT_SYMBOL(set_security_override);
 
@@ -724,6 +724,7 @@ EXPORT_SYMBOL(set_security_override);
  */
 int set_security_override_from_ctx(struct cred *new, const char *secctx)
 {
+	struct lsm_export le;
 	u32 secid;
 	int ret;
 
@@ -731,7 +732,8 @@ int set_security_override_from_ctx(struct cred *new, const char *secctx)
 	if (ret < 0)
 		return ret;
 
-	return set_security_override(new, secid);
+	lsm_export_to_all(&le, secid);
+	return set_security_override(new, &le);
 }
 EXPORT_SYMBOL(set_security_override_from_ctx);
 
diff --git a/security/security.c b/security/security.c
index 1e819ecf26ff..edaaaef54239 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1615,13 +1615,9 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
 }
 EXPORT_SYMBOL(security_cred_getsecid);
 
-int security_kernel_act_as(struct cred *new, u32 secid)
+int security_kernel_act_as(struct cred *new, struct lsm_export *l)
 {
-	struct lsm_export data = { .flags = LSM_EXPORT_NONE };
-
-	lsm_export_to_all(&data, secid);
-
-	return call_int_hook(kernel_act_as, 0, new, &data);
+	return call_int_hook(kernel_act_as, 0, new, l);
 }
 
 int security_kernel_create_files_as(struct cred *new, struct inode *inode)
-- 
2.19.1

