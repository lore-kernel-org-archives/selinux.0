Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C038C10F10
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2778120851
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qAruiHwe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbfB1WUN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:13 -0500
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:36591
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730004AbfB1WUM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392410; bh=9aC2ZQuekvXACUyP08KCqpIfMBnwka+hADHn9g2gxyI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=qAruiHweg0chtcklrAUbyyjsB2M02uLIrxX06Cboba6gfPZqCZHbDfrzS7KTjZ3ii1eV10JbJl/gkvK2InTQRtTm2zxd8thADjxHjHEfSo0Ff0I7JZSbjIr1L28RlxsWfuN29HCJDTpGX1mRR2MwRUUHcf59lRJx2kEJD0A17nQ2hynrOg2x8tKe3SWOawZiLZ5GunDf18ivh/68fe9eY2z4Jr5JTbkLbc2jMze1DTE/HYfsPNh43PfGWJKZe6zo0IJI760+R6iRyU0SFW168qWnyBHT5dYKBYow8r9wYoO9uW+t2Pjr1Z1jVGhQox76WrTYwa4rZzIza/zTRAzYig==
X-YMail-OSG: wI_1JFAVM1niThMPXwyuq5tvKWU_rHAVa9dCajkdBCwBuQ7Wxw8_OuKpWNEtFHo
 XRA6WHWu7VbTfKmWXyfubtR3NpRRyI4xHcmbXpUp8HnDKLVM.koRWOj05x0.JvOCIdjxajRw0.lc
 JhOe1GAv_xnXuBaoilxmYeelww73hFRxF06TltNjIrG2.l6yuNi.oYd3U2poISGqwDk7mbLV6k0a
 NcHaaRG5MaHzwprvdFYOkHAd5JuPl7HPTdH3AaWwb.EVhel3wZEj8sPnK1euQZ5qMO07IgpX0LTO
 2VCh9NDJLXkdUHCs_l6nk5CXrjSbA6JPlsI117gMr3S_PyIejIE7e_eel.J39ltB573Xd.Aqj5zP
 nHjcTYwUs_KXOyrGX5jigJoGz_ytjKIKdcC.VixGfeuhsUWvf6DMwJy4amyTLsh2lWur.bnCQ.hL
 mz3l.HsT0RXja2Ep4i76eEmj8NoOyg0Qddj56MjIel0MtTAOGwsrqiM1Qlgxjyqo4NKXpnlkMs_W
 pPHgtUM1nuBakBm756FdSVQbwzvtrMOrCfXXndw4LYdIT5pNcPUexlb.E.1xTFjKGh5zCDCEKN3g
 .PBOagI3XKYxRl5AG3PiEtD8nd8uJCginXkHHC31awFysFb8PjVxZLdyaqQjuvTK_fes17UUcz58
 SYWY4X43OzpU4daRQvYc9Q33MAOs9k3TYnG_SaOv8BXUaRFQ1Ml0gs3vEv429hSet3ZLMULpbWb0
 pWMmnPvDCfH8O5SQ2tZrtf7gT7TGbcl38dxb3xL1Hnqje0oakS4zH3pc7uF0QQcNmGaHlsVUnSXI
 FvQnzhkb494k79bSNoooyqljSGisqcj6hvNsheqKGkKVRg0CR4LkUZKwL8AOBvRoVF.LDDpnW1R0
 Cx73DLmHg.K_LSPE9usEJp6qVb69rwiTR_WYcc.17QCKyEw609iHheEX9118sAWQ_rRWTVr.TCkC
 DQ0m8O60Znvs5VvF3WVncvkNlQL9bjGojEHjM7WC2BQEy.1nXJEh16XwcEE9BRjCf8Vefgfr56y4
 rnuUaQ0DDz96VTL0f6TL8ycF7TUHXIplint2dBjbYjdPsD1IF2.YUOpXUDFO.FOwncU3_BeplbOr
 5Pi.LGBuqt3yk8_I9HvBjPR7oKL2KzLTPIEyWpuyX5T0SWfJb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:10 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp430.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e588ca5e0935b1286f019b02cb065c6f;
          Thu, 28 Feb 2019 22:20:08 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 40/97] Smack: Restore the release_secctx hook
Date:   Thu, 28 Feb 2019 14:18:36 -0800
Message-Id: <20190228221933.2551-41-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
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
index 37b0ef6ca767..2695bd373752 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4385,10 +4385,11 @@ static int smack_secctx_to_secid(const char *secdata, u32 seclen,
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
@@ -4625,6 +4626,7 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ismaclabel, smack_ismaclabel),
 	LSM_HOOK_INIT(secid_to_secctx, smack_secid_to_secctx),
 	LSM_HOOK_INIT(secctx_to_secid, smack_secctx_to_secid),
+	LSM_HOOK_INIT(release_secctx, smack_release_secctx),
 	LSM_HOOK_INIT(inode_notifysecctx, smack_inode_notifysecctx),
 	LSM_HOOK_INIT(inode_setsecctx, smack_inode_setsecctx),
 	LSM_HOOK_INIT(inode_getsecctx, smack_inode_getsecctx),
-- 
2.17.0

