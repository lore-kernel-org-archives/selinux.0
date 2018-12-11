Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F67C67869
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0657A20672
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="nhvf5EmY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0657A20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbeLKWrT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:47:19 -0500
Received: from sonic308-17.consmr.mail.ne1.yahoo.com ([66.163.187.40]:34942
        "EHLO sonic308-17.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726450AbeLKWnm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Dec 2018 17:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544568221; bh=/Zci3rWg5UF8hGpyuPO01UM8s4zhurIZ4pddwS3UViI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=nhvf5EmYIL3UlXtPuDhR1+E1BSXAQXf1B2WxxNSXxu+GN40c3TSSZ27vwD+DW7HEc9cidax5TzFJ7lWZFq6r2qzvQ4D1DGOa7cb/OG7xPK7NCUh+YGIR5UUkBQWriujFHhxuCbU5863HQZUtJ/u8ksDtjKHg1lp1WL2RgEGB5sgratKE9aCNQoctxQilpJHtTbqLbKiRgbI4QfyHfpYh5YxBWVGP66UgZ5mu4gS10JYi/UBnjVHQxKKc4fYEKGcXkP9+kctpQFyxa4EUEiAxRLBFx+v8Hd1JCTdSpMzWHbG9tCcjoJt6BDRF0keyU4oVCNHmaEYs7Fe4dmdRHBhEDg==
X-YMail-OSG: rmA4qi8VM1lSiBJWHF0PN_ageUgbCmh5AKJfd9aGVlPOJDa0Xia_0gu2vmXg..d
 pgj.qxOe8U3oOk0aOa3JcFxUJxy5tbcmZmtZ8WPijn6f2eRt1OhK6TymKxRPWhu3uklmOO5VE1A3
 YPxuGmekb3bQtvWj9WvRSp8l.rf.ADECeTMBUPswPN18G1CPDNGotaCPYoEwJ9NH_9LCflNmRP8z
 EIQJU0F5mwtUPWXZyxKZOZuX_M3XWVirA.G.NDbvAx1R7tE9KqrvYaOWF2ezLiDE2H6s7JYCEYVB
 A52Yy.QxV9Ihc1RB3tUO7TM3q1dTHjzC4ldKLa46pcLCUjCDjSv7K8a0iMAmzUymkAffp9asyLY0
 aQUiqWhQVBAhxhrDY8ReXI6DpkPe7QRcyshyL.2Pd6SrnIuDMsZ6pGHklggfoSGbWBTONJc6KHEe
 vC0mJnDNbx20PaClXxEPQv9CxDCQ8h.MCflJV0c.2TvB0veu3PMX8HyHzpLu6G0Z.coCvnLuNtAP
 fJYEFoyBpFpgBYhYJVXIQCqnyF_yCmmWgisNGlUjnmm9bh.mWT0wE1SlJOigsmiRCHhywhQUVq4a
 WDrHiABuQDtixnn.zA9I6KOGSevpkhokubQ.vT7uuKTT2yAe0hIS9cMyghjmUqZ2LIwIsuFSbSML
 II6kNJcuUGFUOiHBXFoWXMko28_Uk8FyPHbVXzl8mobxQhAhaDJ1IMT2ge4pGPjyiQjyGyU0o8OD
 i8nZnH8BujqCWCWJWno7D6dRT8qen5JZ6k62w0Cot5FgvholovB1y_u6skPI4_0FGKK7sIHF05nf
 bt6.A1FyVmw.XFgpL2fmTtXbvFsIGFPijjWkG7yYWuliFLTvhx5eX40JlxhxJdPrHO5M6f0ADWN0
 ye4NgMzPk8DnFSFPA87kYEZj09vPDxqR2uVR0bzkdqquR6B1gv0SaFMA6onhqmcrBOngrr6R15tv
 Q3ApSXp2lVjDwVikTXN6Qpo_pRwzMiVpUrybe98EAJtUVIhIRtT7WV5S7T6AWq9qUVz_hlkE.w_Q
 2EE_YfdEWEau1Rgw9sdluWwgQ8sobsEujdUwa_x7jsJ6mPWhyXI_D0NE0hZdyIA1bq1OU3owqg5d
 s0S_yQSFbQ7LksXq5APHrz6qeOdSJZ8YhRI4TRwmit.E-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Dec 2018 22:43:41 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp408.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d92a2db682ecd2e464273bda9352fd0e;
          Tue, 11 Dec 2018 22:43:39 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Cc:     john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, sds@tycho.nsa.gov,
        adobriyan@gmail.com, mic@digikod.net, s.mesoraca16@gmail.com,
        casey@schaufler-ca.com
Subject: [PATCH v5 15/38] LSM: Split LSM preparation from initialization
Date:   Tue, 11 Dec 2018 14:42:51 -0800
Message-Id: <20181211224314.22412-16-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181211224314.22412-1-casey@schaufler-ca.com>
References: <20181211224314.22412-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

Since we already have to do a pass through the LSMs to figure out if
exclusive LSMs should be disabled after the first one is seen as enabled,
this splits the logic up a bit more cleanly. Now we do a full "prepare"
pass through the LSMs (which also allows for later use by the blob-sharing
code), before starting the LSM initialization pass.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/security.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/security/security.c b/security/security.c
index df71b54c1ba4..3fac0ff39944 100644
--- a/security/security.c
+++ b/security/security.c
@@ -139,22 +139,28 @@ static bool __init lsm_allowed(struct lsm_info *lsm)
 	return true;
 }
 
-/* Check if LSM should be initialized. */
-static void __init maybe_initialize_lsm(struct lsm_info *lsm)
+/* Prepare LSM for initialization. */
+static void __init prepare_lsm(struct lsm_info *lsm)
 {
 	int enabled = lsm_allowed(lsm);
 
 	/* Record enablement (to handle any following exclusive LSMs). */
 	set_enabled(lsm, enabled);
 
-	/* If selected, initialize the LSM. */
+	/* If enabled, do pre-initialization work. */
 	if (enabled) {
-		int ret;
-
 		if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
 			exclusive = lsm;
 			init_debug("exclusive chosen: %s\n", lsm->name);
 		}
+	}
+}
+
+/* Initialize a given LSM, if it is enabled. */
+static void __init initialize_lsm(struct lsm_info *lsm)
+{
+	if (is_enabled(lsm)) {
+		int ret;
 
 		init_debug("initializing %s\n", lsm->name);
 		ret = lsm->init();
@@ -240,7 +246,10 @@ static void __init ordered_lsm_init(void)
 		ordered_lsm_parse(builtin_lsm_order, "builtin");
 
 	for (lsm = ordered_lsms; *lsm; lsm++)
-		maybe_initialize_lsm(*lsm);
+		prepare_lsm(*lsm);
+
+	for (lsm = ordered_lsms; *lsm; lsm++)
+		initialize_lsm(*lsm);
 
 	kfree(ordered_lsms);
 }
-- 
2.14.5

