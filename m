Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B011C04AB6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2BFC26FE4
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="IStbCO8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfEaXOl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:14:41 -0400
Received: from sonic302-9.consmr.mail.bf2.yahoo.com ([74.6.135.48]:46834 "EHLO
        sonic302-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726643AbfEaXOl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344480; bh=n7o8QGFhmUAYfuuVtS2cjj7dSkuQxOxyGbWYP+SBOLg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=IStbCO8bdnEF/XKvB2atYwP/fVraaxtTrR/UpnVpTbrE//RJh4DSiNrKEopQLz2ZDfXhV5HZz7dc9HzxWOIvdYtLOiT/9YdRUNCX1wS1peNCKbWhUqLFJI7YHh3LxqUAd1uLwZumVVAHlKh52612ooXLXPvU/wShpXl2EzHwMQ7XIBNfKucBZQ3N3mjCN6TCfFniBGROPhDwCM/skGvcB1zso5E5glwyZepsouKFAmjdmttiOLyDTEbaC/lVtAY10C9x6Lj90YBG52PlVLCqqjs1Bvg/q8WEdhutPkPB5PnHtCZ82tjNPWEz1xjYFglhwLe8tMKoi30FNHzEakba0Q==
X-YMail-OSG: YIF4_fwVM1kUCVz17cTqD8HXQ5tm9gS6P1jyEX1dDogKja5Du2dhVOFfDi_XUCg
 bUYRREeWYng_FH89uJHAXNP8X.etXFNQnCJqklRRaTC3DwgVpKHUbwmcILyw6kD12JzH_UGeSzBm
 Gl7tXWByxRQcarKh6q2MzDBs.mGvbu1h8rZ3gub15d..StgUiWKJm_KSehhum_BO4.YhqH7PYFuz
 .5FtCzhHkvHZuT.6t1YwHqRX5YrRvpY_4JAt7ioKcJRrDDsHPhfbA8kFY7gCKcMF7Zs9kIuDguqQ
 kMtJTXYwN4DVChaHIFsYKDdjHKwLdQVHZgbgWs5Maw7aqLWykbTm0u9G1O3kx0ZGUl41NSVv6G4.
 9m6mID9qXj_kesD_wNXDyuvdOk5Mc0kZagc0HURxkVbH8_HtluiJA5UQhlKhWxL9MsuMUKWVBWVS
 .d6lxDfPT63xC8pl5tIt2GFw7QpRDZS4xatxtlyvf9zKHRQxziCozj8Nsp76Bj8zTU_8brYfDnJu
 w8Rcx96S9Zu_oe3uwiN9oGTSnrxieOcAMSDQFI5rHeG71rsBVr1jrWi_KvCzbu2i9BtiV0Mf4_d3
 NR8Qe3Hyxa.62pQOWzgH37pNhZEFjBo71DuOTfTth1XjCkkQkkmUJQ7EzUN4YWYk0M1wcPDJdwX8
 DcyBFLXxIcK2n2vz6zCIZHZHLWivLy_BpGpcEPkSsNgIw39ctVvKlrzxD8yv.8dWKctoADouOQxT
 pF0sBEuGttekbJUNJBnQWt0W3lvewojVytvfqzv7HWJaQKzzIGZLlg2NS_y8GX1TuN6jwBSxsvpG
 qUTlJ51ZJjGPYwsXkAvtAncnOF2lV_NmQ9FZGibntt86epNdbIel1A_4C0OV9c47hEg4qp41HRtB
 .ulbXFCf8Cm7X0W5G.xOZwRTfJggolRQtfkDEI_pvZ90efnBh9psCcXOIzViR79LcCto2Ixu0E.R
 bYGgGeSABfgcW5vya9xQYiCfzb6N.sotRoPBQmf_prQ.cWKeLpnko.461IZf0VfV_XKH5MeX0Ovy
 uwZIurq5f_aSRzSZQSZV7Ueh2lPu_ZKTK3al5FQKpNHZ8G9lDd5QE3pcPnDJHlXUYIw09kuD2X4z
 KOlVxtkarr.lRc_4kQrH4VQE_BnGYgaKH7QdlruxHhXCEEr3qJ8LlZnJHo_meuyqEEtECVw0tzZI
 KZTrybAKrANJqvlimCPSsxD13qlJxoDLlbeqZC0rEc7qYvKFX.lsavsnfyUyh9cu5zuy3P6cIY4D
 BoKBpTQiPouH_JJevP1KOI6WTGptX1iTwK6nnL6GwXIHZ7KzDUIjDHc2v
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Fri, 31 May 2019 23:14:40 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp418.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0d7978b7ccfb88ed7fd120b8f1db518f;
          Fri, 31 May 2019 23:14:39 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 28/58] NET: Remove scaffolding on new secmarks
Date:   Fri, 31 May 2019 16:09:50 -0700
Message-Id: <20190531231020.628-29-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Replace the lsm_export scaffolding in nft_meta.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 net/netfilter/nft_meta.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index 598bea8e4799..a1d3dab5bc25 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -580,11 +580,17 @@ static int nft_secmark_compute_secid(struct nft_secmark *priv)
 	u32 tmp_secid = 0;
 	int err;
 
+	lsm_export_init(&le);
 	err = security_secctx_to_secid(priv->ctx, strlen(priv->ctx), &le);
 	if (err)
 		return err;
 
-	lsm_export_secid(&le, &tmp_secid);
+	/* Use the "best" secid */
+	if (le.selinux)
+		tmp_secid = le.selinux;
+	else
+		tmp_secid = le.smack;
+
 	if (!tmp_secid)
 		return -ENOENT;
 
-- 
2.19.1

