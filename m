Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30FAC43381
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6452133D
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="GoMHch8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbfB1WTw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:19:52 -0500
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:36895
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729444AbfB1WTv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:19:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392390; bh=i1PttAKZCuhgesoh/f1kuby1GmIoq4buaBK1bUoKrs4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=GoMHch8nX66t3QO6G1oGqGrcF/0A3Ubd1CmAq++KISSwv1Iq0CjrJOGvTr6tOCc1LkFVtQtR2gBWd5sYFwTIPs22Uhj1ZPA/nezXrCKGxkJTpaH41FwKEpREwjKtTLCN9zVQns51qVX6qfvOvkMtYc0Ml/IiXl8GGjrcELSKH93r8ddjKSUB69t2pTwPwdMhhtPDUjr5WR2V3PdGn10b62iE8i6BlB6DQFTLtOiLvGdU3S74ODvQj8Nmp/yCMiqTa/WgZpOBHPAP/QeKUQG+3BFR5q01QD6vANqOJFOXRiNQpr/tf8FzWFETFFcLbI25r5axMMYGWBt4jOgqu4IoEQ==
X-YMail-OSG: F.mgOY8VM1l.4nofvuJCkKrekIeV1DL7En0Md7jZD4zu1qkUFOPBatFWESVYwWI
 O7Uad._QlvqKptn3BePn5mgQwFtyK24XqmKCsd6gzo2Wl.zECBSt0kDBPcHYTtJ102HxOHVwdojc
 mfVGIouxBGE7Hv_AxqlMyEzIl5NrmuPVhDxfYpxm76GYJxaTOFL1rRhYEoqbWuZ4KLjWM3o3PfZ_
 wvo2hxEu2.xByLZUAXiGIQs77BOAXxxnFeigqFWUpsOOUT6EqCn0BYtInLXpSuhXZv9FK6eOrbKI
 DZ4lRYVGsg47rX_ZiprDN94zWpWs2g5qa7HucDBIYq1ans6Uz_fxRT5BdQVkW_8XoFDxnqXWSKfh
 vhHrFJrDgQOAZWHlBVEFrVkBSzfqnSeosEbsiHCVg5LiPKoZMDSk3SMVc_77RgC8kLPkmAPXd5n2
 by7syrJfshm7N0mJKlSFyVdaZieKodL8UmYbTp5AA4j3_ZMIbf7QQqGwon7IEtfkqt5HSRZXD2FH
 fgUmACUJbtAZSskLG_9aF4UBXKrdxmnYIm5Nw41XmnkKSz4YTbt3MsAFmPQ5.mggnfzbIC.7t_Bx
 TVf4FOIv83y6JlOhOrn37tYmnyglIEunXRD02EkZX7o6cZbGnCzxxwuV1KDEzms11ZqvGpwvV2Qw
 2HM2WAEi2Z_DwOPuhNOGwgxAxWf7kkZs6sg_t3tUi4kT7OluXxBrl3zEY.JITMAM185fwXxtc9_g
 Y3hlKdtCYnEi7oyiJU09UWpObrr8gY8eYtYJ6vIKY8DP2EqR5A2Ox6VDrASiYFfVQ4MEmzLeQTAQ
 xhuzUW6WBTgxxVKhh9wQcU_TcVJE7gbJjrTu2o559oeAZ7euROmZqyHgl7QI1ZY1A2fDRY8vTIdx
 6429uTth2kvSqgQ1V4IYTQihAKxrif5bg7M3Mqfwm5kLeICAzJYx7wdQ3QoSkOBdWqcn8iLNkFxR
 rm1v_mh94KSYhz8L8fGZhSgRUOirEKGQHCdyajJgN29IOko0KFNdjYmwQFuI2ztO.zov0eCv5iYG
 WUO05aBzNsh8CBu7mY7oQDKJQnUvpLPed6oGcPqJZogmG4QtjKIIpTuqnuJae_eYCPPcJthg5fQn
 DhD9EZjy61giSY4IpzM3K42Jh6pOqY8K0ZfjWask-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:19:50 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp403.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID eca90f2e660dab57d5d3726b0a8f0373;
          Thu, 28 Feb 2019 22:19:47 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 08/97] LSM: Use lsm_export in the cred_getsecid hooks
Date:   Thu, 28 Feb 2019 14:18:04 -0800
Message-Id: <20190228221933.2551-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert the cred_getsecid hooks to use the lsm_export
structure instead of a u32 secid. There is some scaffolding
involved that will be removed when security_cred_getsecid()
is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  | 5 +++--
 security/security.c        | 6 ++++--
 security/selinux/hooks.c   | 4 ++--
 security/smack/smack_lsm.c | 4 ++--
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index ff97f57a87bb..2e8516447bfd 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -556,7 +556,8 @@
  *	Transfer data from original creds to new creds
  * @cred_getsecid:
  *	Retrieve the security identifier of the cred structure @c
- *	@c contains the credentials, secid will be placed into @secid.
+ *	@c contains the credentials
+ *	@l contains a pointer to the location where result will be saved.
  *	In case of failure, @secid will be set to zero.
  * @kernel_act_as:
  *	Set the credentials for a kernel service to act as (subjective context).
@@ -1586,7 +1587,7 @@ union security_list_options {
 	int (*cred_prepare)(struct cred *new, const struct cred *old,
 				gfp_t gfp);
 	void (*cred_transfer)(struct cred *new, const struct cred *old);
-	void (*cred_getsecid)(const struct cred *c, u32 *secid);
+	void (*cred_getsecid)(const struct cred *c, struct lsm_export *l);
 	int (*kernel_act_as)(struct cred *new, u32 secid);
 	int (*kernel_create_files_as)(struct cred *new, struct inode *inode);
 	int (*kernel_module_request)(char *kmod_name);
diff --git a/security/security.c b/security/security.c
index 5bee7e0b0bf3..9c10d9aae83f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1624,8 +1624,10 @@ void security_transfer_creds(struct cred *new, const struct cred *old)
 
 void security_cred_getsecid(const struct cred *c, u32 *secid)
 {
-	*secid = 0;
-	call_void_hook(cred_getsecid, c, secid);
+	struct lsm_export data = { .flags = LSM_EXPORT_NONE };
+
+	call_void_hook(cred_getsecid, c, &data);
+	lsm_export_secid(&data, secid);
 }
 EXPORT_SYMBOL(security_cred_getsecid);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index cbf7bf3fa4af..d9179b75acb7 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3660,9 +3660,9 @@ static void selinux_cred_transfer(struct cred *new, const struct cred *old)
 	*tsec = *old_tsec;
 }
 
-static void selinux_cred_getsecid(const struct cred *c, u32 *secid)
+static void selinux_cred_getsecid(const struct cred *c, struct lsm_export *l)
 {
-	*secid = cred_sid(c);
+	selinux_export_secid(l, cred_sid(c));
 }
 
 /*
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index a9277a942ca2..e3639d6f1b62 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1893,13 +1893,13 @@ static void smack_cred_transfer(struct cred *new, const struct cred *old)
  *
  * Sets the secid to contain a u32 version of the smack label.
  */
-static void smack_cred_getsecid(const struct cred *cred, u32 *secid)
+static void smack_cred_getsecid(const struct cred *cred, struct lsm_export *l)
 {
 	struct smack_known *skp;
 
 	rcu_read_lock();
 	skp = smk_of_task(smack_cred(cred));
-	*secid = skp->smk_secid;
+	smack_export_secid(l, skp->smk_secid);
 	rcu_read_unlock();
 }
 
-- 
2.17.0

