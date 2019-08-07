Return-Path: <SRS0=LK0T=WD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55644C32754
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 19:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF4121EF2
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 19:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QMzYbY2L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388976AbfHGToa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Aug 2019 15:44:30 -0400
Received: from sonic317-26.consmr.mail.gq1.yahoo.com ([98.137.66.152]:42605
        "EHLO sonic317-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727213AbfHGToa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Aug 2019 15:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565207069; bh=pBDl/1vQPZOTGhA3y1ZBLm/3xBXXHuqBGnmdEc2nJIk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=QMzYbY2LbVh1nLkNx9X/3Y/n9Rh9QEr3jFTxZVVbjGBTeWeiZ33Q4OBMBjccRzqn3ZS1lz8E846ZoWb3TzgcGSt12C+mowrnCxSM0/BwU83LTzipRx0p0+F38WX/a515KUOU990TflsmLtn8DpqNQjXUPDswgfjrFmvfBBqPGWItI2jcAeOWTQqGBn+dv0GySY4b4USwXDQrKZhhI0X8K4FUJ0sugtWzfbw6HQBO+SkAg6neLoy3JwhNnllNIoDA5/hoIH4VV8HMjP+6kvtBJMwXVStPxueTkp3X6aTWZ2hzsqtH5oe5LRWQ5PoYFjHshj7WB3JHRzhTRT+2C7RAYw==
X-YMail-OSG: uBwcETsVM1kYWUm1Q6Po0anzZ0eVmly0xV.WAHNjL2HtwZjWjlFd9uPdihlmwjw
 x.Q.D746O0b6iMPhnh2HR66AFfs0Xu2fBD2CUAvCvU2KEZmbUROGTZCjA9KD8UH7DYHOLuQ0wP41
 N.tnb87poO85_8Zepwj335AHR4TDzNWSISJfL5LjHVnSfXGAgRhH6H4TfjVjmU.UFALNOjYN0_BC
 1GDbjsnBcOTV9MFc4kVwqiRal.2RTKdnu49elTU4ug4viaj1eHpXJcgY7bLzc0AAG68dFz4YSyGn
 mxAQYXuJhB8PWOmyrce2x2Sf9_83VAOyiqeUPhHERmxwZ_wf2mLRA7Z18WR3tBA8Q6FtgJlSGuhK
 hnF.zGp5vH.ryqYkjF4MehGSLhnlVP0uzvay.oR7SgGvAhe2HHQ.8DGVl8B8rpkLub6I_LfFcmOP
 BTe3k0Zs8S2MUr_yM5l3Ynrtv2CyfglY9EXevLuzBSAQcyDTTbxOsgdJTkdzzuEs006tTNHgJ0_W
 61wmSBSsFSDjjhPp3Ny9_dZUgaC3HhmfIsh4sNVfs1FpMcZPQOgSdLwftCVs7BISOoihmPiAH72W
 9eIEGw2kULDG9pKtreZpx50xpjtLqpW_EYl6C7ZPe7Wl.77RXD_etPdf.QvCkDxO7uNFUPB9_igB
 gofEvY5ohOBNiU2UQ5KAfoe0wo1Oj6GUOYJQ9KJtXlMbXBtmglhOXN3gsq.6BhKFAGnUoj7CwSNr
 vDNackhhrqPcVV8p2L9GpWzCD3rZDiyE_tqehX1fJHgZRn1x0IlTWJM5WWQChZW_PvGOumEuRJpk
 TDXptEfRHYX.jqhjrdsRJPkCl7oz1kp_TdTR2ldM1sE8ZtzKEI16m6pNmsz3cQM81aHOoMubxc9w
 wmp34vO9nnMIZlfhMeKuX3yznKx9oq.5BoWPJkCU8IS5cfKr9co0pVrNFt8OphUTibQOpp2zrlqr
 joL.kYwiENak9g19cE1ovyAhDE2rWKO9uApZktpsPF447b3ocXdJEsAlTGHm6AW0SKq1G8bNvyQK
 lmC6M.omVABo5uJkJu8aaZlESYIjDcWFeSUbKJVfhrC4ifY4ZfmkZdvdqMBZoJo2r1IFfDCiPKYz
 PkP8in8dcpz3D9QkAJ12RCEuCRoLjpB6PISL2r0YvB.52nwngBCKhyidAup6.XY4JMejggTmtDXu
 jqLJLX4kr7c44_V2fZxOyyuoHrl45gtD6r7_Nf_GzbVNKlIFEyz6k5UCskEyuoo_kXIodqGbwg2X
 _vhZ6SaFMhzAhtKYGY1DHF3DFql0vcu02rdNmpjmlv6n.sDTwrP2YsVjWyVyavUyveAPKAHZjWEM
 FqAnKqw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.gq1.yahoo.com with HTTP; Wed, 7 Aug 2019 19:44:29 +0000
Received: by smtp403.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 58c279a944991d666e27c38577be4792;
          Wed, 07 Aug 2019 19:44:25 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v7 06/28] LSM: Use lsmblob in security_kernel_act_as
Date:   Wed,  7 Aug 2019 12:43:48 -0700
Message-Id: <20190807194410.9762-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807194410.9762-1-casey@schaufler-ca.com>
References: <20190807194410.9762-1-casey@schaufler-ca.com>
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

