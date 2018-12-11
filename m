Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8DEC67839
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B1E20672
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="czdQvtVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B1E20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbeLKWrl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:47:41 -0500
Received: from sonic316-27.consmr.mail.ne1.yahoo.com ([66.163.187.153]:44840
        "EHLO sonic316-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726390AbeLKWng (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Dec 2018 17:43:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544568215; bh=Ee+OIrtC52fs0hnnYhQRoVR6eH14n59kkCRb0pJ9B+w=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=czdQvtVFBndqUoQavuhhLfwMSFH2McPQ9lS7r4lVmOE4+MCzJJSp526HYhSwYYdc6UNIacWc90cxdn0IkALAnwgZIvPtxA2UkH78m/RG+gdtz0lzTxxZ2+VzyWj9nT+BRqdGihv/vtLbJBEZ9KWjkVqskDuprg2uyRBpl/KKGTxc5N5v55WeQ7JMsYrX6bMDVmJWXqM4k/ww97tpsPj16CBeLUGr8QgBdr/GI3s27PuUE/FQS8BrkDAzpnXyKMQp564TI8YBbNOaoTyKUFc8znFlUeN1usHXaKJoteSqHEo2hamaUT9APjzmwfWySiROE2PkZx7lwM9+j8gQLpZ3Xg==
X-YMail-OSG: Z5.381wVM1l9z1GANV51bbD.jpR3mAIBgfGfJdFlP_3NnxNuF1Z6MDNn2UfS8Ta
 50Ryu2SFVJ4F4ScwXLlUGZ8JkJ_vw263AuW4uprnRjdrAFp5tnjk4huT_gHq_ThPe32.x6D10qBl
 5Bq4fYvFyDKfAvMPcpdPOz6Y7HZqAFoT7qW35T8tJI_CcbV8h.sP2uSY4SzJwRo5MjIYcANy5b1Y
 mxaYjSBcTVGDXJESDfxCkxmG01CRuJD_Dq8jEET2asS6uzHZGvZ037RIok0XVm9Kt_Pp43LfDqI0
 7t7f6LZkVwUPaajPuRKDGPRI_yFPqq50luAr4rNTubesjCVovVJxbZKML0YmkdEGS3BLHuJTm1uc
 eJtL05pjSAf6v1SVPUc0RhTpmfUNErnFWx4hWv_EGOJGspL12Hw71F92qmsR94eSYs62hkNVnMFN
 oQsTa5_ZQCyFzLuGxVOojZc.rnjEt9yySWDIpdWEVLWzvEeSlaZxJKxEm6mVkTnnaEn1gmfqMLT6
 xs5uMH7TXO8bZOiDD_xHiAcJP.RBAAhAiG6IdCCYSJCMCJV7QA4ja_XubPc2uvabCOOqkfx70314
 SF5OHFL6BcqRpmvBow89xM7FugPIIRTTs4p4h0wtmL0Y6M6NjAWgyQ5hhu84SfLk8HVV5cBAq_g_
 _jjjVyqPJyTzGOS1ubdU3zc0Qm.dwRI5YJMO5BsXFUzZ16TYNdgYfomdf3BxNX0LzSzhffeUpkNI
 7l3hwMAW3GnEhWALx28kBDxBn25ZR_KwpFOFglrEgHA1of7mJr3guh5IExWa4mnsQaOIhFY.AsO9
 fBVMxi5TPr_4jB0MoxNoZMn1bLNys19fXoH.zb0PoaTYFWwgoRq4FmP.XIPwjyAOXCmXSzpK8OMa
 PiPak3RvNjfIH6nxI._juoZ5pUCSc339tSajYisQUICvi4MP8NXsAbS3k.RwBbg_Wr2L3BBCWL1B
 9MBXnqkVlNmrUiCwajpSidt1ME69krxheoYAV8wBpIWP5VI6NbG2O8KatilQzgO5wO6u_Ie6DZBR
 YtYsAs_u0Ty94XhzwGCtcBLeo1hqVbi1oHlBoTCUA6PCpwa8.MYvu9APzHMW1aIxy8jj66ztDwr7
 bo3FjQKzcTW6uLGaTGEH.wIZY0Vx0nEUbg.Y3YXk2.Xk-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Dec 2018 22:43:35 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp408.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d92a2db682ecd2e464273bda9352fd0e;
          Tue, 11 Dec 2018 22:43:34 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Cc:     john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, sds@tycho.nsa.gov,
        adobriyan@gmail.com, mic@digikod.net, s.mesoraca16@gmail.com,
        casey@schaufler-ca.com
Subject: [PATCH v5 10/38] LSM: Refactor "security=" in terms of enable/disable
Date:   Tue, 11 Dec 2018 14:42:46 -0800
Message-Id: <20181211224314.22412-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181211224314.22412-1-casey@schaufler-ca.com>
References: <20181211224314.22412-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

For what are marked as the Legacy Major LSMs, make them effectively
exclusive when selected on the "security=" boot parameter, to handle
the future case of when a previously major LSMs become non-exclusive
(e.g. when TOMOYO starts blob-sharing).

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/security/security.c b/security/security.c
index f4a7b7d52d71..a7889885585e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -129,14 +129,6 @@ static bool __init lsm_allowed(struct lsm_info *lsm)
 	if (!is_enabled(lsm))
 		return false;
 
-	/* Skip major-specific checks if not a major LSM. */
-	if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
-		return true;
-
-	/* Disabled if this LSM isn't the chosen one. */
-	if (strcmp(lsm->name, chosen_major_lsm) != 0)
-		return false;
-
 	return true;
 }
 
@@ -164,8 +156,28 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	struct lsm_info *lsm;
 	char *sep, *name, *next;
 
+	/* Process "security=", if given. */
 	if (!chosen_major_lsm)
 		chosen_major_lsm = CONFIG_DEFAULT_SECURITY;
+	if (chosen_major_lsm) {
+		struct lsm_info *major;
+
+		/*
+		 * To match the original "security=" behavior, this
+		 * explicitly does NOT fallback to another Legacy Major
+		 * if the selected one was separately disabled: disable
+		 * all non-matching Legacy Major LSMs.
+		 */
+		for (major = __start_lsm_info; major < __end_lsm_info;
+		     major++) {
+			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
+			    strcmp(major->name, chosen_major_lsm) != 0) {
+				set_enabled(major, false);
+				init_debug("security=%s disabled: %s\n",
+					   chosen_major_lsm, major->name);
+			}
+		}
+	}
 
 	sep = kstrdup(order, GFP_KERNEL);
 	next = sep;
-- 
2.14.5

