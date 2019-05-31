Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCAAC04AB6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C782A26FE4
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="VIjX0lo9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfEaXL1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:11:27 -0400
Received: from sonic310-31.consmr.mail.ne1.yahoo.com ([66.163.186.212]:45467
        "EHLO sonic310-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726450AbfEaXL1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344286; bh=dwbKmDfRWBch8TA3RWmr5v6f3rBIx/+49c84tS3OSyo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=VIjX0lo9WPpa2HtM1EwRPh8HrbaDO5kiT7cygD0PeAwUC8mVptYjoGDzbYuCq/EpyIT8adS7/1AoKjL8KyM1Dynt9ZplypPXxHxsp641TYYsyYh7K+u3gx2aEi3CWQPQWZSsp7bW9E1rdepUNwrUJ6NdZMyIGoQuSbKHTgAGyEYHqUkuHQHC/ihGds3jAgDOfZTzswAQLMtOVegiS+SHnpXWl95xsm7PnWI5vN3xVenClpz0C+B9pvmAJJBUslnE5XiYGJEzVDsOIVpQmHrmRUny9BE/vwDBQzfHuoA0g6zbtDaLbmsq/2S9hNw+n/SnAOyJsPJy0cGF7c2G9rXCRg==
X-YMail-OSG: Nf.qSi0VM1nsloG9iNdrJdw6H0kk5pR5HzMfMrmtWiBXTeEFusODgKh0.BHl1XW
 tYLxabsNHLkWmebEOgFajM.asHxQ8vyvmsjnc2AZVTN8NnifE4w7AgnEHiKHWA5W1kq4e0.zyXMH
 R9owG8QW.m7ZJaSpol5_rlGF9QzsvMpoCwGw8uBVe6i2xyeNLWDBKVyS.wOK_0Lv57zYf.5XfXsn
 xpS5UJsma_LcZ3emfMagbtkSbkVfwaMtK6m2742MmchlhqbONoBnFkrfY7JkVraSaBiRgHRf12AE
 QzblS9cQEe8frcB5NjCRaVKCNY1J8iMnDu4MjsbfgBwJcrbw9FBhOMkSjLjPnvVOEV2ciX9JSZCA
 0.yKRieIrR6t6VCS8nofME5uy.P3H0jXzzOfruksCjXPM6L.kTW1nqdbID7eD88wLUWtgUsKZHpI
 2DuHbqdZAiaqpESj9GCouqVOibQBp_Y770tA_lvayQYyHHaQvWyCpdbomwUpdiw70ifs2IVrDUZw
 SDmKFt5zrRpjUJH9pGW3MGjFY_EIJxu8AmM7DIJIcAaBkJvYeBkvdAc244cD96LPG_32eUJODD5E
 C5eC8YpzEWf8DL8V0_5sXQ9dujEXBxFfwy_QUBZcwJ09mLaZZv2MCC9pfFCbjyzRDg4ZO83Xss_N
 MHdjRPDelwyo8_P6MPx4Z.adC2xe.CO9ed9CIPjbwmINm5IPOnejeK_8h3cUS7H5fEzarFHmyw9b
 OK3OtazFZDZpoiVxJ2G7Qo4uqfaoLA3h_iEhng20pRIe7WMSpfqsWuUvMm57CX9e327oVepitmZH
 OoCYx5_TzfRj.YO7RWBgE_OsyL_gHSQKvJCkNVrvBd42MJ.xy3wrrXtCRnQWqsfo5KkJb9hwvohB
 UbptNOpgshNt6.q1JzZlNPoflELkoLwy7nJ2RjHDSSuHsUfLtleeoTDsjPU5OtJaMbEV0Eoka7pt
 JSpTj6IBU7MbHrTdqXXU_YKWHS0xQxrICyFBJHPJ7WQzvghZAJXZryxU1_S62INBQVUntnD8q4pU
 z7Njs8jVYnusDNPeQY2oguZwbdb6NytfuhYq0gMDcqYzu_PMqrGm7vQ6rjRD.5UTD4z6iwKjsZKe
 cdZj6MeV1FSIf4ZLWalDZF1Z9bFNXAbYyl9WOjBVtx006NY1hlIcaqZP7aJbYamhDgZ8kla.YF7U
 s7evs4HEE4N_yLqyU9XEV6ycRcwzzz.htgzwte5wfGjVkhMTzIU7q08lqDiXm8p590IDvvMbjV9p
 Em2gdXnvcDShHb_YInSuI3CcO5aFYbVQ6PnQ_uuVHMQIUtTPZLE1IRg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 31 May 2019 23:11:26 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp414.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9f21a7219dc461799002936560934de0;
          Fri, 31 May 2019 23:11:21 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 06/58] LSM: Use lsm_export in the cred_getsecid hooks
Date:   Fri, 31 May 2019 16:09:28 -0700
Message-Id: <20190531231020.628-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
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
index 09573c55e535..0f9d4174bb6e 100644
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
@@ -1596,7 +1597,7 @@ union security_list_options {
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

