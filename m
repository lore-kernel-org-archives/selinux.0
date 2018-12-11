Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869B4C6783B
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA8520672
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="FW7/aqRE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA8520672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbeLKWnh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:43:37 -0500
Received: from sonic308-17.consmr.mail.ne1.yahoo.com ([66.163.187.40]:42818
        "EHLO sonic308-17.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726395AbeLKWnh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Dec 2018 17:43:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544568216; bh=FyXN+RPGRSY7iHAtehf0GPLHsDlIKRVAkJnwc7UagKo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=FW7/aqREgtWpRcAbu0X9r+55vVRIFULAq79X77ufaUFDD98yW4voTjYz14Cjff8uwt2vUpcvuaum6EwiE9DKz/4gK/WvjnX+iuc2O6eukC9zqrtGHjOilzKKHDFpZ++fJw5XYe5MfHuTHkOORt5/BJwG6U7fcR2ZyHV4X7w/UVFG+6/MqF1XkCLW1IjBalEb0FeRm1LiXH33gLQBJF7lvdXX+QDWuUHKgYgxtyhKr41LoyuDM8/Z+ZPiHQKlw0mdk+OFUA5VygG9N5+u5ms/zuXtvB1uqtmyVL0DqiglL2GOAuOHk8lRfYBxs3bZGyUhDy0AIlNmStCUg+Vcsba3Ww==
X-YMail-OSG: kKLgvY8VM1mjA16c0p7x7S2r51ZNEuM8.Tdp8FUIqH70NPy8AQ4ZHpD4Qf56I3e
 ZFgdJMZ1HBFj7RpEzDa.SdVbgdCX..iVbtzmbsq5qrm71MDvirzcuuv1LPSpjFK5HMcvF9nCLo69
 Jqj1LJdnaWj69vG67xIqFuvsDb7qOH84p0TwG_KhDZldUou1PY4TZCbQlR1Zm6pyPQrfVTBbxdUT
 V0BFbyIoGPNqh3U3QliDpc2YJPJn6UVtO4JUL_DY2IXHtiK9goUkVDyCdJ00kOhZbbFykovfjm1x
 KgSLQIeYTYBDPelHlNp1ntBKcCoRjPPbez79XEtdjz9hDlaPetQx5xeIz701BGGeOd3uCbKKtbY7
 HuIlQIFqhXYPXIlPQP9hXgmXxvGGS_2sy7O_KQf19nGZp9GRE2FgTbhk.lPOUx72IElMF8PeIuwV
 bmbf2N43O1qKLm9YGLSpSTfsIFiuJ_WG4obgNnfe.3e.9nzdnyTkm0zHQuCEB69sEYIUfOIOu5sp
 GYp2dcxbzHfiYETOdgT.Ekt.d4xQVjyc8k15W50Uf3p3k.4Dq6NoQXzdnuahFJL2pYzd14NCCf7z
 O5uQwotTYlSmX_Ynkp7CctaHjaXnizea9hGuSeIhq6DME_bV0Xb3QTBvGVAxvxqrTZEs6dnEer6t
 pipoT8bD4dZAVkTeWNX0DglTlxsKKfRgrcP.rOjd4LDChce82YEzYA1YZkRAgF5QdE1GiYP9D4fc
 .Zdjxc7AWzhYaBAdFBAFIDGzpY.Duq6YWpjcCBbscKXWHA15723RkPZpFz7qAzFRS0NOK8aQHKlG
 8Io3WGtzzKzAILStDZaL2Ont9GqV8gWHBwqdormaW224YFdvJDLcRmyWNB8dOuziJ2N5r9j3a.Iv
 buIPUzGYnhLdQnfedqFVhYcyQhghadMm9kw_h1fZMBPlzFqN_pF438MGwjC5SP3.BIcckXkr62c5
 wCD3tNhC7oBs8WahjI1JvfrZ4OEp2WTvXwpmysiEDGiH9JqfmFcUUPKmlVhIxyk5f7NMPwSm8ow8
 AVkO6brwww5ynsJDuUITCK6rUx5W44VgKiY3pLXHkKVXnwsrdiQYeHgVTZcyyHkxT8Y34SZJPZjP
 _CJJZGNZWNwSnfUi8D8kRHkYsQdJ90bVsERHMGg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Dec 2018 22:43:36 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp422.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID db48327a3d58729724c38eee90dbab73;
          Tue, 11 Dec 2018 22:43:31 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Cc:     john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, sds@tycho.nsa.gov,
        adobriyan@gmail.com, mic@digikod.net, s.mesoraca16@gmail.com,
        casey@schaufler-ca.com
Subject: [PATCH v5 08/38] LSM: Tie enabling logic to presence in ordered list
Date:   Tue, 11 Dec 2018 14:42:44 -0800
Message-Id: <20181211224314.22412-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181211224314.22412-1-casey@schaufler-ca.com>
References: <20181211224314.22412-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

Until now, any LSM without an enable storage variable was considered
enabled. This inverts the logic and sets defaults to true only if the
LSM gets added to the ordered initialization list. (And an exception
continues for the major LSMs until they are integrated into the ordered
initialization in a later patch.)

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h |  2 +-
 security/security.c       | 14 +++++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index dabd2761acfc..272791fdd26e 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2044,7 +2044,7 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
 struct lsm_info {
 	const char *name;	/* Required. */
 	unsigned long flags;	/* Optional: flags describing LSM */
-	int *enabled;		/* Optional: NULL means enabled. */
+	int *enabled;		/* Optional: controlled by CONFIG_LSM */
 	int (*init)(void);	/* Required. */
 };
 
diff --git a/security/security.c b/security/security.c
index 38fc436e8b4b..ea760d625af6 100644
--- a/security/security.c
+++ b/security/security.c
@@ -63,10 +63,10 @@ static __initdata bool debug;
 
 static bool __init is_enabled(struct lsm_info *lsm)
 {
-	if (!lsm->enabled || *lsm->enabled)
-		return true;
+	if (!lsm->enabled)
+		return false;
 
-	return false;
+	return *lsm->enabled;
 }
 
 /* Mark an LSM's enabled flag. */
@@ -117,7 +117,11 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
 	if (WARN(last_lsm == LSM_COUNT, "%s: out of LSM slots!?\n", from))
 		return;
 
+	/* Enable this LSM, if it is not already set. */
+	if (!lsm->enabled)
+		lsm->enabled = &lsm_enabled_true;
 	ordered_lsms[last_lsm++] = lsm;
+
 	init_debug("%s ordering: %s (%sabled)\n", from, lsm->name,
 		   is_enabled(lsm) ? "en" : "dis");
 }
@@ -210,6 +214,10 @@ static void __init major_lsm_init(void)
 		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
 			continue;
 
+		/* Enable this LSM, if it is not already set. */
+		if (!lsm->enabled)
+			lsm->enabled = &lsm_enabled_true;
+
 		maybe_initialize_lsm(lsm);
 	}
 }
-- 
2.14.5

