Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E23C10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D3120833
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="YskVN6I+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfDIT7s (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:59:48 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:41278
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726529AbfDIT7s (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554839986; bh=+cOk5EbWObSrJ4n/q5EXan1kjg10sH4/KzvjAQgXLT4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=YskVN6I+JuZJ9tCUQJs9DIpFqWmXu5EC82CCB4g3CRcSHe9hvaAbI5hI4KeetChSBLO1kaOdJa8mWMKtiMPYb+FT/DXePUj/h3VWlflAYKVN8ZoXS0uxbn5qtH9qnbEvWt8MXPdLTzqtDnoahcEE7iGwJax37NREqOONBJSBdQUy166haFla5OgDwGhAgNBuOjEZDVVLeeF8gV8TZU/EMfyT2CC3ntZ7vTszCNNH93+TcbNJk9eBCHhyomDpwBsvqK0H3wj8GProo44F833er0Lk2k2u3my3VA/UfKZZKsLGFiBMzr7xfdK0qW1RH0+sgVwBUsa8iuroBBhKPpLTHQ==
X-YMail-OSG: HQl82joVM1leHwPLoDF6HRc..5AMe4V5Xzo6JZnyJ.RKwLwE7AH4tcRu4wlts4m
 6UKoLbGAYy9UUpMck.2LsN9NzMEOU7bVNhHJElYPLenPg6FVxeGHvelgFvPaaUp1HQgoaKSlMgfQ
 tAQSaZo2Deq48duaJAJDCY3M1KRgrawgO4Eloe8iZfZEiVkwUO0vhGlH06_fGgo2mGAbGsgUsRM7
 luwPAO9dhp9bkgzBZi9yPv83sCptl5K_10FOGZtkI0_uJ0td3Hn6lL3nG9QPihQEN6NBoqTj4K8I
 cFZX.Q0N7Z5qb4lWxfiRLR.86usoXsDf4azquRJOx29oKxlmXs9fCo0467RccKb31es2rdym40Z9
 rZpBlH3tg7a_mPe.pfY1qXtsX3_9CIamzc8UkHwfLbv_Pu0Uu3eDqoxZ4Tu4yHllONxfrMtGj.J9
 FK4sEZc6Bt1CvQ.hgMOm0lNY1C9NokSx0Atao1r9l3U.gtsS_RAWH4MazWatuMBUDgCh3utIyz9u
 tZiI8q5U58uyjkAIwezCzMDgvpprHYk0fKKVmJMRu19V7MShCpT.e84HuO9BJMVgigr.5wY2uFdj
 R8lcCAzvda1HZZlwU8RNnuLIEbd2qnblSQaUL0ApL8ibVwmID6_f0k9TANb7or3EyrFz3AjXOHab
 XDMCV5oKXgFqZjVTwflsmkZS3EqkjLl9HR7VL7vM4DHOmySp_bedND_X5Jfoc9pf5Sy.ekkc5gsH
 WLX5o31CpBl1tepYcCJ6sit4yJtr1iV8QIADE338uy3cOl3Dmr.rTBNEoDJO8nYWVN2e8e8CmQtw
 e7hWK5BAj2Irw4VxDJjrus0pkIAxnAT9FOJek9iJLkXrTmRiPBy9UGrw3NHAs_wx54WoZ8WiV3AR
 .n96VgaNAGd7oJGAIqIA0TAzSQoGhHGu7XXIpv8lc8zIwJ_EVJFH5ErfeV_kEQFo_.penNMqP5f2
 ZjZXE3FJZNJVez1jR5XTq7EtZryQO_FclWpphIQkFuMRPBKfaQB2.H_FDxs3zp5tmVDrgfp3hynr
 MqNQZwhbsvZNXkOVafRmrbeeqdZe.wGRtrcIOR54SKh1XK_afSCLyDz3PIstPUjF2r6tWTef4gZY
 y6ItUMJ20QJbkth8KW7FANWyhjinjUmRvC1GgJuJyII4AKvW.B5rB_3348M12
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:59:46 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp410.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 353dc739e5c49befbce16148938a824a;
          Tue, 09 Apr 2019 19:59:44 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 06/59] LSM: Use lsm_export in the cred_getsecid hooks
Date:   Tue,  9 Apr 2019 12:58:31 -0700
Message-Id: <20190409195924.1509-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409195924.1509-1-casey@schaufler-ca.com>
References: <20190409195924.1509-1-casey@schaufler-ca.com>
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
index baeb83ef487d..2fe54dff3efa 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -572,7 +572,8 @@
  *	Transfer data from original creds to new creds
  * @cred_getsecid:
  *	Retrieve the security identifier of the cred structure @c
- *	@c contains the credentials, secid will be placed into @secid.
+ *	@c contains the credentials
+ *	@l contains a pointer to the location where result will be saved.
  *	In case of failure, @secid will be set to zero.
  * @kernel_act_as:
  *	Set the credentials for a kernel service to act as (subjective context).
@@ -1604,7 +1605,7 @@ union security_list_options {
 	int (*cred_prepare)(struct cred *new, const struct cred *old,
 				gfp_t gfp);
 	void (*cred_transfer)(struct cred *new, const struct cred *old);
-	void (*cred_getsecid)(const struct cred *c, u32 *secid);
+	void (*cred_getsecid)(const struct cred *c, struct lsm_export *l);
 	int (*kernel_act_as)(struct cred *new, u32 secid);
 	int (*kernel_create_files_as)(struct cred *new, struct inode *inode);
 	int (*kernel_module_request)(char *kmod_name);
diff --git a/security/security.c b/security/security.c
index a1f28a5e582b..ca485a777ca1 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1638,8 +1638,10 @@ void security_transfer_creds(struct cred *new, const struct cred *old)
 
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
index 0e31be22d9bb..f97dd414ac8d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3764,9 +3764,9 @@ static void selinux_cred_transfer(struct cred *new, const struct cred *old)
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
index 5e345122ccb1..15579bdd7244 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1980,13 +1980,13 @@ static void smack_cred_transfer(struct cred *new, const struct cred *old)
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
2.19.1

