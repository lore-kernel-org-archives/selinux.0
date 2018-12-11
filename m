Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10350C6783B
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7FCB20672
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WCL6SN0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7FCB20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbeLKWn1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:43:27 -0500
Received: from sonic316-27.consmr.mail.ne1.yahoo.com ([66.163.187.153]:39397
        "EHLO sonic316-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726208AbeLKWn0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Dec 2018 17:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544568205; bh=WT5A35EHIXDk4c6XxSfr7BOxdAICWJo3sRrzhtAFt40=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=WCL6SN0ed/rykvI+CC53zp6lYNEw7acT6UsZ8wv/Ai6R3qB8719/I8rlvAfNtOjTSBz10UGkFVDOjNbPg33brC+4E1PDXTyRf2tGvXSGARbXlwGUKy85KmejGDy0SlrpOUaQChg011yxoDjEr+OFY8jouqOUyS0WIXrBrwV8C8moCA9+9CNM9HsV54z46B0e4E5FCBntc9gXru+il8TRi1XvAxpyhntjej/4pNsmm6OvuKgGb8MW3k8b81moA6bujNtPKLKg1YZOq5u2wRt+eeHbgJOtiPtdi3v5R9PGAwrMUnGtJcPWpUee1Vi73cfUlca4WDc1MNXMmJO5iazFNQ==
X-YMail-OSG: 6zt4hPoVM1ljIDxM4Z0xkdmtw0fRx4cgUSfmtnnCOBvLBqd8tXdlRE0nNzMYQFY
 NwMz_kR5Wxb4PHnepdXiplWkXPJEVld_Bwl3.2D0Dhpwj2WjRQPrmspCvdsnVzlfyCte94wSTXsY
 61jlgF9Hi6UACMxQNgafHgrzWYqKNSnqTUw8Ke2Itj6jGEtMbnRmC7yiHAjmcvfs8fgW3a2Jpef8
 E1VPusijMjbWa.tm3FOLLAr.xURE6D_rgMcwEBHRedrfV8RGKzfTlRBbjouWNr9lQWCwQAkA9Uwh
 rdZBB5VeFDVfIh2zkH37VCyobWsn_ke3JwvWyUq_T9JKfSTEIxFa2AlgUI4hUPYnAVP.Xc_Q9dEu
 0JpQVV82eI8FA93IGsnkoX9Zzn_7FfuK6S8nXHy9VxM525vjxBQUqqepmNTgE2di7AMNWyGvbRVL
 8eBOhhM0937U2DWIFUMNNThNPVI4Vi0W4PrWrfIsYSThGWEeLaAd7NfZXdmqirFyOFjrcArAvjJg
 SlA48QaC2qQIh4cff9tqd6jsxnUhBFai0vf1BiN8zlEk8zlQq1voyow79xgA5wjUm02POl.NasVV
 9aHtRJgIaLTkLGRbGQWUIFRqb2luywe5YrCqmalqeetBl1k674chB.RcTaDH53xWNy1kC5q958JB
 fiEOsLLORvqO.5ztFCE5fQ2mbJ7ckjhbMOadxISAXQmjv76tCdqXrbdRO6Voqy3KOwjHWv2jDsHZ
 HKkpQPJJwveqUq63n.FfHtn1qSFZNLLaMSl.UIG0WMGC73T.BrLYtr3oUR9op0EdC1fnxZmGZtt9
 1wUFjhZSM01s0L8wNTI9238bmOLKUpBStovPqQ4.xLqMI5qrZoT3SnHJ7qe9mvdT5ybnRbIoJkt_
 3NFjeFx1mjBcsoPlbUn4hwrtUNPax7jhJr2CpWioiF3WuygaypjNyjlt8ssclnnU9fJEiTuRhHXj
 9PvrMG3Yg3i31PjmtU2xXQJYnF41MljDMsjlNqWU0JcE1uewYjxvEeHXYEmCUf.z1S3J5Nd57rsT
 cY4YZa..Bop_aZH6SRb7nOFXmW1rTTkcQS9DfVd..SaKrr_DObc3JRCT17Vb4P6f953mBcwPEpW8
 RyISazgIf5OTkpg6pTbh7O9ChWofSfOpnNlr3YvID
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Dec 2018 22:43:25 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp422.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID db48327a3d58729724c38eee90dbab73;
          Tue, 11 Dec 2018 22:43:25 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Cc:     john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, sds@tycho.nsa.gov,
        adobriyan@gmail.com, mic@digikod.net, s.mesoraca16@gmail.com,
        casey@schaufler-ca.com
Subject: [PATCH v5 01/38] LSM: Introduce LSM_FLAG_LEGACY_MAJOR
Date:   Tue, 11 Dec 2018 14:42:37 -0800
Message-Id: <20181211224314.22412-2-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181211224314.22412-1-casey@schaufler-ca.com>
References: <20181211224314.22412-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

This adds a flag for the current "major" LSMs to distinguish them when
we have a universal method for ordering all LSMs. It's called "legacy"
since the distinction of "major" will go away in the blob-sharing world.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
---
 include/linux/lsm_hooks.h  | 3 +++
 security/apparmor/lsm.c    | 1 +
 security/selinux/hooks.c   | 1 +
 security/smack/smack_lsm.c | 1 +
 security/tomoyo/tomoyo.c   | 1 +
 5 files changed, 7 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index aaeb7fa24dc4..63c0e102de20 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2039,8 +2039,11 @@ extern char *lsm_names;
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
 				char *lsm);
 
+#define LSM_FLAG_LEGACY_MAJOR	BIT(0)
+
 struct lsm_info {
 	const char *name;	/* Required. */
+	unsigned long flags;	/* Optional: flags describing LSM */
 	int (*init)(void);	/* Required. */
 };
 
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 42446a216f3b..2edd35ca5044 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1728,5 +1728,6 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.init = apparmor_init,
 };
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7ce683259357..56c6f1849c80 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7209,6 +7209,7 @@ void selinux_complete_init(void)
    all processes and objects when they are created. */
 DEFINE_LSM(selinux) = {
 	.name = "selinux",
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.init = selinux_init,
 };
 
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 81fb4c1631e9..3639e55b1f4b 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4891,5 +4891,6 @@ static __init int smack_init(void)
  */
 DEFINE_LSM(smack) = {
 	.name = "smack",
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.init = smack_init,
 };
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 1b5b5097efd7..09f7af130d3a 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -552,5 +552,6 @@ static int __init tomoyo_init(void)
 
 DEFINE_LSM(tomoyo) = {
 	.name = "tomoyo",
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.init = tomoyo_init,
 };
-- 
2.14.5

