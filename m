Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7AFC282DA
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369EB2084B
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="YnubYGcA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfDIUAa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:00:30 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:41668
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726836AbfDIUAa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 16:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554840028; bh=DXZobVlHba7NLExIjhRRZRkmastZlDIkiPrs42J8njM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=YnubYGcAZopfMSo/XOCaB7g2UfyLS4unYkkRSqdvWmvvSmSAokfLcX3S+i2qcWWJyDKUm+xj+lK1p1arNzXP7bQJUGrnK+nmnwozZqCykZ9+NFipdlGvlKVV7lUmfx+5Oae9noJ5NIw82tPL0zGD4XpwS23g8jQ0v+Y5edMLJfOyKJOeMwQXN65Xxs8kTorZUVAUGZffT2mSbsMt/e4bOC9p+F6Wr0LASiDrFPsFB2PfkIRhIqOWCGjfeSPzMvLZyqn0T4lA+gJ8+X1hr7v2ve64RazEv5zCsC1MpKGhbpN1eBGgpQ81Hpaa767HgI2eOJmjBAvnlzqA64oVSFwGVA==
X-YMail-OSG: LNvfwXEVM1kU4XwBkpDcb.ka4TmenpTCi5d99eRiML2Ud1etYTGM0uz5eTKgYCr
 w833iA49KqKrSs.VuL6qCYzDrqAi51i_Ae9RIQff2NeTi1F7SLZhqko_NJUMD0IbPJLXg6jLeWvG
 8MalXDprege7ibXKPFDAwafTwG5RbNuNzqfxVVM85kjztZjEexmPedJ0Iu6qbg43jQ227YTmr8is
 p_BcowLPKRek.rXTWGIqhxmmh2yugywFLIXoGoaXGewEEvbWa.2ds.sNSTQSSKIyl_EtJLlUG5v0
 bgBNtTsNZGhO6huRAHa7J0UB9za_h.9o48u6rXxQyWOuPCajtmWkiOf46VVWX171S1b019EO3c.5
 ixRnP_PnIgTeNVnYToOSeNyNx3AsV0zsET7dYTGA3AXARJ5q8BrEBRJpvI1ZDIPGWP1TePBv.Z2y
 il8fOctD.cSwj5cWQX7XIAnFOkW0Trzjy.UvXocuEWnz9wQFIxi9u1Kk1r2YQf9mb_wvBVvcJE7t
 D1ubqIugFtSi5US_c3bT39JoSzW.K_ke5Fh3S8nt.qKl3bIjpS2Z9kMxpSrTb7wRU2JJmi1QDVRx
 t0amT3KEuUzEjl8xmPoRAgH1lgYL0UeUd8VgoswVuRM2tVGoN1fpepQFk6JV5mOeHDQx3Ntsbbu2
 fqrQYU7Gd9Jgp9eNeQ3FFmqSxQdjpAr0zSaWM.oyu9TWkA1d3HI_DpeXJc.h0GLxuCmFqDlyobb.
 .4EEiv1QMhI1hp_AQJO45UQIEP9wqW05lC49KeRTtt4nxA8JRvASEjt61SGCtlgs6HqvIl36ko__
 fuIfzYMZm8X0dPRzfqGb2uemHfPxaA5rNycManaXBpI2YsQ51VY01XJSGTxaXvMYntKZy63JrT93
 7neXzKnkilwu_BLb.fjHb4EFDyuiQArZxBbTjPpcJXhCT9Znoy7xyIrjnwzBZhldtSvhCmpCJN5z
 YfEvfGeJptRfqJ4bOVvgtSAEX2HXYSMVs8yzBhzDIdzsse91eG7XNJ504UrlRCddOfvdYyW8OBoj
 TQzaoR9Z0CMocf64iqnzNse1UVUbQAr_NVyd4Rze2ZVOGZ6Y3TzqQKGCMBCjvgtGhz.L13pa6oza
 KqxMxczUZMhVjagbx0U0m0BYTMxYSdhRKcLJkP9BQ43btFLWnfmdcPbvfcHp8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 20:00:28 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp425.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 102fe805e930c993b64b67f47c5c2e96;
          Tue, 09 Apr 2019 20:00:24 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 28/59] NET: Remove scaffolding on secmarks
Date:   Tue,  9 Apr 2019 12:58:53 -0700
Message-Id: <20190409195924.1509-29-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409195924.1509-1-casey@schaufler-ca.com>
References: <20190409195924.1509-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Replace the lsm_export scaffolding in xt_SECMARK.c
This raises an issue, in that Smack users have been
using SECMARK_MODE_SEL, which is suppoed to be exclusively
for SELinux. This is worked around in the code, but not
fully addressed.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 net/netfilter/xt_SECMARK.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/xt_SECMARK.c b/net/netfilter/xt_SECMARK.c
index 2def8d8898e6..9a2a97c200a2 100644
--- a/net/netfilter/xt_SECMARK.c
+++ b/net/netfilter/xt_SECMARK.c
@@ -55,6 +55,7 @@ static int checkentry_lsm(struct xt_secmark_target_info *info)
 	info->secctx[SECMARK_SECCTX_MAX - 1] = '\0';
 	info->secid = 0;
 
+	lsm_export_init(&le);
 	err = security_secctx_to_secid(info->secctx, strlen(info->secctx), &le);
 	if (err) {
 		if (err == -EINVAL)
@@ -63,7 +64,12 @@ static int checkentry_lsm(struct xt_secmark_target_info *info)
 		return err;
 	}
 
-	lsm_export_secid(&le, &info->secid);
+	/* Smack is cheating, using SECMARK_MODE_SEL */
+	if (le.selinux)
+		info->secid = le.selinux;
+	else
+		info->secid = le.smack;
+
 	if (!info->secid) {
 		pr_info_ratelimited("unable to map security context \'%s\'\n",
 				    info->secctx);
-- 
2.19.1

