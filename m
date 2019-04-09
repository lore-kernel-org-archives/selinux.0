Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AD1C10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547932084B
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="nq1CZHyx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfDIUAk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:00:40 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:41032
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726874AbfDIUAj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 16:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554840038; bh=XFEQORQN/Rrt9xNIMHTY8NF01S7CWObpcTiWCO3b0pw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=nq1CZHyxwMAX4SjwI8YaQzkL7m88OawfLIq5j1gnOwYaJ1DDUQAOAWEsXBPN/yiid54IjgpZMkH7PPO/BeNZsniUxpViWUXeWNY0P/FtbjVQNi5HZKM7/Gr7lkRZUGeh2CHLxPAGOWjIe9W0iEKJS8QfDbiqkXFpqo9SWOZAx6v4TItga5j68Jvbo7N/UPD1fXva7RWiSgTP13Kvn2jexdDVxWB5n2zt4dAy+hMweLcAIxQ1uGfYcyg+YBSdE5++ajeoFi8PyLF+Sg4o8ecmK7CbVk33GvMWxqrCtQi8IxJwPYkxfdrKafwcwWIJPmazj0iFYMVuh/mo60A+AkMUww==
X-YMail-OSG: 3mIwDQ4VM1nPBg7k0zcgE5fQiZsSygNV32hke3OPjg0C_bgdFQqvhA7IgCQJWtx
 MO_PEes.8owAuusGFROvjIZ1dkmFjjKkXGfLJMWmrRntozUJ1ROp_VLPVZmxBxBsSpNTw_8EDF.F
 _0xGNRjJ4K_utvHQgq4Ui4HYtb4lAV4P8DmAv764HPiRvw8Dx_Vf0iztYebeEC2830GNgk3BfX.r
 NApkAalNmuDfSniOJWNmyb7rZWN7WG6pbLLIHzwBlokGwGY9pDQoZInoIZHyst6uR0HKxndXdvZX
 wnExT371Efejls4XpCZoEMg2N1V90uCKqeKJ.yk8cGeBh3L4MUoWOU1qXnbkHo.gbvkk0F_CCufc
 gfl8uSQanztU2hsZkcVwpf_P62_PrEVifA.kgzfLLOixnKX_tok2hJ.xKAxQRsMjkq6Xr6E0.mri
 6hPi5FoZ.zWgNfZwgygTZXNltPyJTQdSbceJQkIR8Sxi_X5pbiAyLEE4GC_c.wHGB5Y0qEFEcruj
 YwfLpBV8xWmU_I7YqAxPRO8Mqa6ONZ12dOJSVjDr8.W36LqPSkHaStR5Z8GtW_H76ISnqHLj3DzQ
 0WwEDEqmLl.WURB8LkX4COf2zRw_MfGR97977ValhFHTowSRHo0rxuAhQVGXuebR2RUMdHi58_TM
 IyguWmvfvCxXPYJjVZr_fn3M7hk3NlrY8Ls5KpWTvxWXS8xM1W6AVb82ss6PC0tbrSWl246sXkfU
 N9lS_R4AeORSHzDWKT7yG3ehFbiNqFJhT0_6QkDaddLc2Bu2FN5hKM_pgI7p5odLkCeaWDb3SPBU
 U0GhlfPWup4EzvyopOOLAr5bB0FpbBwgt91aTCM0kuIq21D_OWM18qoq6DcfGfxJ2zMW7ZYE.gT9
 7n5tWVVKuiwhc1_haYVtjhNP1IR0kdWgXN_gTfsJJXv7tn83nlRbcAEYDA0Kiq0InQWsn6pENxQ.
 JyDTmg8eoGeCIW17qT6kiEmZ9mibGNK_rHLWl7DXIC7QiROUiFPe8.CUe5tJxaIMQSwDhPzJ1Fui
 ViEl0aKZKhRLn.TIwugUySuGHRWZl.xwWfGlijlqq6dOEkPDgzI9GXuIO8uR3yKCHLU9kCGbwII9
 _CeGN_6xW1iv3zNsVAF2yxRSJN93cq9t2dvBlrVbQwvdqEmrAgBcLWwnsF5Q-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 20:00:38 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp428.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID dd207be9b16b6375049b46b06443493a;
          Tue, 09 Apr 2019 20:00:35 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 34/59] Smack: Restore the release_secctx hook
Date:   Tue,  9 Apr 2019 12:58:59 -0700
Message-Id: <20190409195924.1509-35-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409195924.1509-1-casey@schaufler-ca.com>
References: <20190409195924.1509-1-casey@schaufler-ca.com>
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

