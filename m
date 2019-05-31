Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78571C04AB6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5038926FE6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LIwN7w55"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfEaXP4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:15:56 -0400
Received: from sonic303-9.consmr.mail.bf2.yahoo.com ([74.6.131.48]:33288 "EHLO
        sonic303-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726520AbfEaXPx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344551; bh=XFEQORQN/Rrt9xNIMHTY8NF01S7CWObpcTiWCO3b0pw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=LIwN7w55dz42RE6UmMDr+E4rsa/HlJ893CQoa4Ij/eGJCZ92ryAi6z4nT5gMGMNW/DNznSy3i647bWsasNJ9FTyToJaV8zLSr6Qs5OsnxlPpnT1k2dHnFywwFOK3DDFL2k3t5SQsYXgT30cOhfxJpxbXQ07AT02v8mEUVEYtovbtPuWOBnO44/txDQ0fPZIJcOfSL2xjzhNzC+dwt53QBhDGUzIugb1VbpwXQAYSOkP5Fjlgyhhpr9789zg90vNV0LsmJX7zfuM+xEH4ZNIbZSKtjss4FF5Wvq5BM+/zDEBX9PY+z1tvfjl0yDUh/RVbNh7Ytb9BNCLBSmI44muz0g==
X-YMail-OSG: SdkwCM8VM1m_eaGR8yW0FV2JQYi3U9hNb4WI2M4Zim6PZbUPZGq_fK0yOudtCV9
 FPcvo_qaFEkfmGBJ6ZBdzVWFzP9OKp3UVSjmvc6dIxvYmE_BGa7Lqv_zs9wnmRT5F4iskMiVCOqC
 piSjKDtQUi3ST6Has4c_XpEEpOMxJIVgqzUzGk9nrnl8mOpo6w7W_c52O9VujVbWGUzrzLHWnWmZ
 laRduDr3mJqsY7jBqq7sUWkkIXF_EOBV7CNAcf2cOdVbe2hmYiKqYy.oz9fXv08jKcwX.8rfAyCX
 9HoYsEfsrxYyWhPRqjihtotf9nORE7l.inQ8WtqxGlrMw.VsaZdQMI9G4UmOXl29m4ynZTrP32gY
 c0KHSG2DP5FPxeBcn.8QHNT3o.d_TXvvsg64EjwzgWS42BX11NyR9QTPq3MUYOfj7o9m1jVbDx13
 ygayEC8oSL.c1DIX3vz4U4nMSWLqQP0EWe_Ak_y1kFgrQdvc8UHMQwyThOvTFuhFudxF_cKUAVBH
 ofw.jMi5v5vh4TXlFGfkKcKMJNvAPTbPv8m80ZCIwN9vSHztffwmro6G8qKCYNc8j1yLYg231kc7
 wozGxnLjOo0Zh3fVlMxvX5i0Z4MleWUnaM7LISlNYrmP7qr4j4yl16yNBSnNAcTbtlglpWP5PrYa
 zOWCi.kWF2RwWeMQrZ6xbWISJ5kZsaI82U4MxRz9xmAEISDmVZRwvMAAHdo4P1vnwVQXU0MhSns5
 G2_ts5de1pzoMOalB5P5QocaEu.QZUy0kxXKH6EI2hIijoP_RTznElFzqdyB_LlPKW5GxOJLq8hs
 YyWiu_irHX1P1HAz5eg42.EMeW7Ky078VEEBrR01lBnpfmC7fbslWYqLDCC.gRpyFgw7.MxW.gXt
 areoAQWzzmMO39UxZby.4gTHfr_drgXQP.G_JWQpmI2y4tDS7d0G42FvQcdmfCADUbHTwN0dd4lj
 Snz97BHznBCB2uegeNt7MMdxGjr8xgqbkYN3rfXVwYIfwCT88WNGeDxxQv3SkPynk6fs1qNmdXDb
 DUk0XNP05V_vmuTY4xRqLvyi6VBSmv.hOKxaCNYAc4GH1Q62SEfKmNdgp1X.kEjMg61Ohu8Pxxt_
 QqnCiP16zIfZcm8qDQCLKLUDFkR6I.Y3Gg47JMdlTOvrrQtjzV08q4yZBvdDFJTnRF_KLb3ICFrc
 cV_aj0qAu0gF1_CtGIi.RVZeALXjn.Kj3ChZPp0DJHK5aXtFuPhYrUKVaiuromWaAT_9SGyr.pC4
 uQpFg4tOL6GF8IeR8hxWgxWCxPJUvyLvftY1GuH58QbnXvKQBcDWWHxZF
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Fri, 31 May 2019 23:15:51 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp419.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 4dedb584d5bfc5b80f3c45100d9ad329;
          Fri, 31 May 2019 23:15:50 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 33/58] Smack: Restore the release_secctx hook
Date:   Fri, 31 May 2019 16:09:55 -0700
Message-Id: <20190531231020.628-34-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The secid_to_secctx() hook has to be balanced with a release_secctx
hook for stacking. This hook does nothing.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack_lsm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 38ea48d22547..a837af153ed9 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4470,10 +4470,11 @@ static int smack_secctx_to_secid(const char *secdata, u32 seclen,
 }
 
 /*
- * There used to be a smack_release_secctx hook
- * that did nothing back when hooks were in a vector.
- * Now that there's a list such a hook adds cost.
+ * There smack_release_secctx hook does nothing
  */
+static void smack_release_secctx(char *secdata, u32 seclen)
+{
+}
 
 static int smack_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
 {
@@ -4713,6 +4714,7 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ismaclabel, smack_ismaclabel),
 	LSM_HOOK_INIT(secid_to_secctx, smack_secid_to_secctx),
 	LSM_HOOK_INIT(secctx_to_secid, smack_secctx_to_secid),
+	LSM_HOOK_INIT(release_secctx, smack_release_secctx),
 	LSM_HOOK_INIT(inode_notifysecctx, smack_inode_notifysecctx),
 	LSM_HOOK_INIT(inode_setsecctx, smack_inode_setsecctx),
 	LSM_HOOK_INIT(inode_getsecctx, smack_inode_getsecctx),
-- 
2.19.1

