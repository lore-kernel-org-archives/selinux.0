Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE76C10F00
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A082133D
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="J2EFwnGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbfB1WUE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:04 -0500
Received: from sonic315-15.consmr.mail.gq1.yahoo.com ([98.137.65.39]:42294
        "EHLO sonic315-15.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729725AbfB1WUC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392401; bh=tPfjNLF8Rut7laLw6/UejSwyv6D6+KBG0Il9a0Y2lyo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=J2EFwnGNKSYoAJhrWn7E3u6QkYbc9wnMJxFWp+yT6eO5xyzfFEbsOLx8Ksefy7VIgNTswcn8cdYHJmOzoCYmi40gexTcr+PJ74pQQ7zb+kY8EUXoQ4bQUfa1/vAAqzwcqt6eWMKHyGRq/b3RfIPo4yVidKT7SVXfjb8FBDS1MQC7tM7lbCrThyeyjTzTRMLhJUdXXNy/P3oTTH8RXUvl9h1BvE0qA5GMA50YJ6qo1GMHBvf+7Rwgngvr80bKCJZumiK3EyxcwD++sYJZnHa5r8Nmib/CbdZQK7ipvR/sFGLD2VNScHb9NR8nfFzPHZab/JwDlVFzknvm8yHwm/wP5Q==
X-YMail-OSG: 9q_dgJEVM1nxVvFXGAorNjH9fW4G4G7xUN1Qs.Y57MApq3Nxlgx5N9QZk.cVBOB
 g7Py4LQgPw_D6Dr9xLJTFuBBvtOGj9kz6IO6sQYLA3ma3_Jx3huowqfLheoJXaF.Uig.XccCxRS4
 LFBbxSyvT6EU.j24rfNBc7Lhcm3BBN7JRt741QE97DAxyAOVbaEDtRElWY0IUeMYT_fLYjb7BiKo
 fHhYq9pRP8lrKjMN7T8NomO8qx4ineIKpWm4GFKTEcfuPBV92qVePWyNGeyV1eK_5qvm6rxBsHeu
 afWq_pMegIm_fCtKXZfKw7wuWpQ_JLxnUtgeOzuH.ioJckDgmZOSXKp9eI69vET4BIn5GEiMFAfu
 x2Bqw60fgGhiVxgcs6wXBAMwQdwKhWsfXovVXSnKdi2KhABU8uVRttIBTO18Z9WgsH4HPyWgeLzl
 7B1wX7Eb9_bFlky.98wlV1SF1BczVsRiUatdweM6F1g_1cauYk2xgC2Wc4llFjVJ5hNV.GgP8N9V
 0RPwJUwuTip0ltyUSY.lJSzU71oKDa.sNH3xMozr9geRdZ85w0yqOCCOvhMUPrKTysVwDtuNHneq
 Dttr894M0WZHCBiNAAqE9NsJZWahhdkMbaRvfqyhUYcI7nhxLdH5030LWdJDvpkdacQ6Up8TO0fW
 fMcGAFvzdh1W78rQ6QtQfWG82prFQGXGLRIQPK0Hq3HZbzcWverC7aKtmNQaJYzDyTuqVGEGYT_f
 spdUZ3yN1Y6z0RheN8MK887RkDfb_efTcozoYsLmvbvxH2UhSezcuJsQHZQnH5zXXHVItvykubyE
 bHJyqdKyfK43FfBHiwB5Z19NBaZoC5qThWurma1LT2kZJuNCOVN09_Woc77fZ6vuVtHywIJu3wlL
 hbRoZx1edGYhbVrKF7tSIO1JPuRX1XAh7.Ivru0eeL.Mt7HWtysCL6fsElQaMeRX45RkVL8GhEQ0
 .pk7wGdiXIZ7IPsI0AkX7wWTsnSynx.nKLa.rfDda9MIuuAXxixs.0nWzguXBXTfKYimKeEFDR7F
 fmxZ7uKRQQvwaPOpNACAnc4kni.KYQEBTpPJttPQyKcJDVyNlUJAnHtxMC.aQg1w0DwzwXEfeZ5k
 vOazRISVw0It0cEhg4IzTUo0SfFwB._Awf.R0Vp8.bIAFEOU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:01 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5c7d685bea94a92cc9d12c4cc22f1f0e;
          Thu, 28 Feb 2019 22:19:58 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 24/97] LSM: FIXUP - security_secctx_to_secid
Date:   Thu, 28 Feb 2019 14:18:20 -0800
Message-Id: <20190228221933.2551-25-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Initialize l in security_secctx_to_secid

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/security.c b/security/security.c
index a0767f8d7822..66f8ee392af5 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1948,6 +1948,7 @@ EXPORT_SYMBOL(security_secid_to_secctx);
 int security_secctx_to_secid(const char *secdata, u32 seclen,
 			     struct lsm_export *l)
 {
+	lsm_export_init(l);
 	return call_int_hook(secctx_to_secid, 0, secdata, seclen, l);
 }
 EXPORT_SYMBOL(security_secctx_to_secid);
-- 
2.17.0

