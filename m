Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552ADC6783C
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18EAA20672
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="XCOxahJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18EAA20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbeLKWrl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:47:41 -0500
Received: from sonic316-27.consmr.mail.ne1.yahoo.com ([66.163.187.153]:37035
        "EHLO sonic316-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726382AbeLKWng (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Dec 2018 17:43:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544568215; bh=s3bZKV11sZggNmL9RhvMLR7DbZb+NtVw3kVGbBewWPs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=XCOxahJb9WcE7eeyaQetdB9FrvZOlI6zuesGUDsIRbGK8fYewE/PrCYO5zlKkxxs48DVHMsKyjyDFZaxAlaA5DRJ+LQhXPfaqKyArgOCn9o/1KzoEoFBDkyWDzCHHNwpt8B93RZ2QS9/svD1iAv5LXwhJiCif7lHYP6ahlCT+YMqY+OGfviECH48LJ9+C+oq2I3+OH1X4g1yOtrNwG9RR/5pPXb/QWW2PT5CGGE5Iy914gtkWjujlvO8v1TwM3+zzxaYVBuf4MqE7WYho581QAhc/nxkpmNcWpvcC38LMYBoqlVObKTPEdcw6lmgmBqHWujnskA+A7kj61ulP1DfoQ==
X-YMail-OSG: Z5DXUWIVM1mQvgEES8C0a6yzaFqkbtdD_81wagclgPtfwrD.Dc9WHrn6a_.wu56
 aMgeCCyalDnYH4jQrkZrFsEhm5AD.Lgns7GY7LoqXThp_ZPUGZoETK3zQuQSvg2tDlWUHowhaGcU
 85Gafpn7MHeWRyh6SLI3X1z3ox1WknPJBY6r1UsFE92Rp2J0RvnMmEKK1R7vwTck8CbH_AgMj0rm
 dHLjCfL3heRBMALdRV61jwMSSyiaMTvhi69sttvxsoo5sk1nOytrjrNyRhCz508cOq8OEjiQDao3
 PcCjMSSSD7Dwrz4Ybo5tu0C6hXPjvhUt2OcAgckEmDFMZvh3Dl8Omj7l_VtjL0mefe68jRKOjd1H
 9wd8b1DZNG02xEU2gDm0dGXjABk72dr.wAYRwtV_GUE1VkKG29W4GZ.hil59N8hQx8_nUJC4WaxI
 CucVitDt1Q8LHOi02gZaAaGEhwGr3HlTuO9t0Q9NeBWfP_g7OSErq3Rp0ygdTyhBf5zCwRk._.CV
 ZeeBvhp.S45EI2llmsyfXNiHYIxjSJI9ci7eKPPXU3sok8harW9EbRmIOUITwysUVT_WfkS82Hu_
 7c407MqllaMGxAjvxZCi7N7NaAoT1ffUEInQfamX7zkbNJ6pjFWkoeZecoMfP_It5lYDPxwWOgaN
 _TCfEKCJ9Sj.hkQP6OvSqqldWeU_SFueS8k_yOTXsIOx6GCKyvE.uTgc.1_eO1lbcxDa0EpeWFW8
 bmXQSJm1ZLHnplATWFrzcVWSteptnZvXzsbFpBF5GpSdX8L6of_9QJXwgNMFsTXP0a6extml3AmW
 23usUolHMGrMOyzB9608P.cRPWM7AewEhJ1yM_8ndiQ_SBmJOAiBuGq7p9TpNPDUjl5TFYh9iZ21
 Bw9_JZlX79x49JFfWXhbw8Feojt5NM7SOdMW55MtMDvaINequEnMy3IGVPo2hM54B6LVovIgJUFc
 T6U4H.QOroveteblcKT4xSu9nlLFniLKto7A2X8im.az7AlXH9zTNSUe49d2s5pi3YzECIz9xl6E
 JjXttIEXHyZXX6doSYQSu_6aaOcBzQ5D1aLiBL.hN3.evKY2qccCT_JBAipWUid20Pwubw9hMzEw
 1UCKBssHoCpoVP14GphtuOkBfU.yiDwY6PgAgCg229Si6uRJnwaA-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Dec 2018 22:43:35 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp422.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID db48327a3d58729724c38eee90dbab73;
          Tue, 11 Dec 2018 22:43:32 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Cc:     john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, sds@tycho.nsa.gov,
        adobriyan@gmail.com, mic@digikod.net, s.mesoraca16@gmail.com,
        casey@schaufler-ca.com
Subject: [PATCH v5 09/38] LSM: Prepare for reorganizing "security=" logic
Date:   Tue, 11 Dec 2018 14:42:45 -0800
Message-Id: <20181211224314.22412-10-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181211224314.22412-1-casey@schaufler-ca.com>
References: <20181211224314.22412-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

This moves the string handling for "security=" boot parameter into
a stored pointer instead of a string duplicate. This will allow
easier handling of the string when switching logic to use the coming
enable/disable infrastructure.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
---
 security/security.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/security/security.c b/security/security.c
index ea760d625af6..f4a7b7d52d71 100644
--- a/security/security.c
+++ b/security/security.c
@@ -34,9 +34,6 @@
 
 #define MAX_LSM_EVM_XATTR	2
 
-/* Maximum number of letters for an LSM name string */
-#define SECURITY_NAME_MAX	10
-
 /* How many LSMs were built into the kernel? */
 #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
 
@@ -45,9 +42,8 @@ static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
 
 char *lsm_names;
 /* Boot-time LSM user choice */
-static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
-	CONFIG_DEFAULT_SECURITY;
 static __initdata const char *chosen_lsm_order;
+static __initdata const char *chosen_major_lsm;
 
 static __initconst const char * const builtin_lsm_order = CONFIG_LSM;
 
@@ -138,7 +134,7 @@ static bool __init lsm_allowed(struct lsm_info *lsm)
 		return true;
 
 	/* Disabled if this LSM isn't the chosen one. */
-	if (strcmp(lsm->name, chosen_lsm) != 0)
+	if (strcmp(lsm->name, chosen_major_lsm) != 0)
 		return false;
 
 	return true;
@@ -168,6 +164,9 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	struct lsm_info *lsm;
 	char *sep, *name, *next;
 
+	if (!chosen_major_lsm)
+		chosen_major_lsm = CONFIG_DEFAULT_SECURITY;
+
 	sep = kstrdup(order, GFP_KERNEL);
 	next = sep;
 	/* Walk the list, looking for matching LSMs. */
@@ -257,12 +256,12 @@ int __init security_init(void)
 }
 
 /* Save user chosen LSM */
-static int __init choose_lsm(char *str)
+static int __init choose_major_lsm(char *str)
 {
-	strncpy(chosen_lsm, str, SECURITY_NAME_MAX);
+	chosen_major_lsm = str;
 	return 1;
 }
-__setup("security=", choose_lsm);
+__setup("security=", choose_major_lsm);
 
 /* Explicitly choose LSM initialization order. */
 static int __init choose_lsm_order(char *str)
-- 
2.14.5

