Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0B7C282E2
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2838921736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="bTA3a3Sw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfDSArl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:47:41 -0400
Received: from sonic308-9.consmr.mail.bf2.yahoo.com ([74.6.130.48]:37414 "EHLO
        sonic308-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726876AbfDSArl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634859; bh=XFEQORQN/Rrt9xNIMHTY8NF01S7CWObpcTiWCO3b0pw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=bTA3a3SwmozGfpls9EtgEbCOyghTeMsz4AEaJ1fw6qIExxK1tKjXH3XI/Fq5uQMNrOVQLV0eNTIACjNeId9bQ6WX6t/3DoAM6xay/3zl+v1yC7z1qGC6pKO6Q90orG9/3OxVAQqkrksfs/cAtVmyrhOqNLsV0EfymilxH1QqO3eaZcXv/4K2AlS6wTgH0D3HRYxIiY9193B4J7UL4gfbqLmAFlfKDWPrhjiJir7OIhvmA9O/M7sfIh9L20zaNepR526l4C/Ol13yHMCfPEwSqkAq8zo0u2fD/Fj2cCWVtDH11JhMfJifuflkE2v2saN/PEYLIjFEhs6n3Yd1VY/tCQ==
X-YMail-OSG: GJXHARYVM1l0C0XtOK51jlK1JyNeMVs8EHtqEkTSI5.IqkCDjFarTR4jL42ZHrg
 d8262WxaL2kWckPMCq0ylDhghMzuR2OjWGfUzB0C11bE68TsqsiiBHSk_lmzekcgtrS1PLevIJQ5
 _jOltIyZUIzPTBfoZMrOlgBm__eH25VfaBbkv76U7gG_zh4ceky3aiItt2juCjx4EkY8fRmpU9HT
 ZGyYH4iVdIy5WYWp1eyKkos96aj8WXcc6mHkVZsopU4IUwyCZ5SUFxQN8MpPwhxpm9uvtL26ZOzn
 0lS1SfxYlmm4DYH9H7GiMCa6zjBYRZaEcJqJSlVCY.jOKKJf3LOznbBc.gQU1wGggwPOjGcM3jYf
 bEssGTp9pxh4iz5tQuCaHBYiIjOqRwHF_aHQ.hZBSAGY0sIj3osK1VAEUq1l9j_9MkB_tJQQ_jOy
 _srGa_qbY0PHdX15n0vqS4qxEJ.nARFngmSNFCN44_sNueRH82I1mnXYvqqpOBpCkVscjdaF1f4r
 68q8xD.s7cgI17StbTwOaUR0AvcDnUz8.VwuUo3z8VUlejngvuD9owxKYfxGBbeODMTCyrmfcE_x
 yGrBORSqkCa5e0p247E6H7s5alLk5iZsCgGR3MBhYcwdOjbu99GJt0acZkc.6vWfbb0od68A_m6b
 vfwemeZcf_xF8hxH.VvZxcrMjMQSFrKATAZHOSWA0M1D3zZ3_5fc6U54IyXUkSYc6wVoynn2uwL.
 wRlEUkb86Lz3rhDd2BymbXFrd53n5LBU7QptM2oawQZYdrrr3yt6at2YQbYXQLe4bPj.8MJW7mKw
 h6y5myFPb4901yiqayITYka0VzUJ5NJizyFnfic3E3yBsVoXm8aIarwWx.QRd56zFO26d8_LQUpm
 wKwYmjJSUAeOLMb83noZfg4EA0L.snwBvJ7hAV2vWmvIsOCxJiDa2ngbEy81J7zrASnoTUcIoXIa
 YbLYMOEgFTvSH0u.dlmBVJ.GQO9sSsmXQo3JTJ25S0tK453UhKDpv8PJvemqzFakvQFYFi7KsQpG
 bd49fzonQD7OYX7Dq3YhkkIf38k1yR.yRb5fcQkAIWJ3wMTps6vm_knDAeOkYF_VTW75eIXWYFXA
 vo3IuPiA24iIVp8f3x_FihIDVzMSet944UW23cjMEXe72XC4nkkZ0XDTez10nkagrEamg9zVySmj
 EBd72rIPdU6F0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:47:39 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp416.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 3136423b19635411d73e92b6945decf9;
          Fri, 19 Apr 2019 00:47:36 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 34/90] Smack: Restore the release_secctx hook
Date:   Thu, 18 Apr 2019 17:45:21 -0700
Message-Id: <20190419004617.64627-35-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
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

