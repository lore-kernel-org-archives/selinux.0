Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8BCC282DE
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9BAD2147C
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="IfHJKBu+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfDIUAa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:00:30 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:37261
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726849AbfDIUA3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 16:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554840028; bh=n7o8QGFhmUAYfuuVtS2cjj7dSkuQxOxyGbWYP+SBOLg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=IfHJKBu+07ybro5ScLaa2i9hXZrBcirL7GGk8gL7eSzr34jgakYNfMIeSlxqJzOsn8alL91jkbU9Ii2g78ET3y/cs7f1o+nGvlaTGegXN8KnLHMey9qcsmHgTpq2pQv+gUDD3/G+3AtdE/8kAB448+QFw88sZBKRu6DgSbI9OufmeWNXGYiHZ9G7fPgKmHE+MNkf9Dkru1jpF7H7/yOLsvFqQS47BU8TaOQzrN+QB3BhifwOOJj8jk9R5zj9SKQVddOEe4IG7YRCZKqpZVWzp5ayLUya1D9vOR0uOiWzAqN96DlafAjwdI1k5FOI905uQiweiaWtGSNyfdPH7EIPvg==
X-YMail-OSG: fwffysgVM1nSPWCNOZfv1z1pn2L4tIArrwBzEabKZ_RxxXrtWXsNKdbRfmrkn7d
 5CMyTiRsVYYYbScm_aZ7TtvXz3ofsa1WwDBYauDXf85xQt_4ReoRw_VkW85ZouaecKw1TVyftaXw
 CD8zphHhP0sFyi6i5ZQg4eNt1XrsMVMGVXxG_.kgHreOn2EQwHQF83682_1VnguumlzHKOBurNBF
 1UYCyGOG0NxSXADMUvQBlO9H2e6.owUe2YbZmWjVroXLb20isWB1KtHzA1t8q9_mrX3QaEZ6utOl
 zwclownRGnu.XWK4PF1M1o0F52NsnV_PgX3n6dcEHyjrW0ZbZih5p_P0Hlw8oO.TmsrRyQnrMPKa
 yeVj_nHIGIQUrZ0qrD.ZNI22RJIPLfgOvK45e6b61WJh3SJwvG3KewHCRF_j8OYnJ2bmVgSVl01W
 5rIixA5yNGnKf8XWW1s9RGuAGWP9PKH58dapyjXyiVlBGRGWCfUKS_ToiZkx.ZYyqNOl_GbDMcCn
 bkKaoE25kRHMIxp3kPJ_euDW1MFU2fcSin398kJBflNYMeq50UAdbH9RNpk1X9ZwI3jWJlQ_AFqR
 PXrJ8hjkAeXHdNing44gZJbdeHFrjwWcSn4ZiBFpn0bWO8snCGPR7Fuu6auJPLdjPc.FoKSAR82R
 9lrQhLNFkVFvRlMztJjrMlWLRIL5FtX4jV2W5X7I988yWjpGHfSqvUpbCXUiwJ3mmcFRHhyGpds4
 kP9UWCNKGY2zrEFeTXRBab5pkNrix_7SvL6mu7OZhWCJi_I9XTn.e8Ls8202I9v5sUEmokqAMI5h
 gjtANbKIot2Plyfshk03NqBE8JFUMaSWuasAr2mpnnkCfeENlCGzPOfD7FfCVyBSufQDxmLY_Txb
 ARcTK1KG3eR6LLc2NxITnI4tUzxpsp.85DJcxojONLKef4Ve81oDew30rSN0vp68CfesnIDdw8b1
 Ikw80qo5ekYFymgWj3yJvR9vnTvWvU4g1fW.0HIKmM9mOLtbQ6VWZVVyNbA3gGop2yzWn9I6WnVh
 qDxqdniZ7zstTFS9GZ87iOvXXYu.5ZJqytVvKsch2if_JBnLt_pFw9ZNMZ6kuJH4Sheut_xd4uCZ
 7Sdho85owHr.mQKkAEA0CzQwJ.FiT36YIfknO43qA_A2dBm6lx9.ebrilFf4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 20:00:28 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp425.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 102fe805e930c993b64b67f47c5c2e96;
          Tue, 09 Apr 2019 20:00:26 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 29/59] NET: Remove scaffolding on new secmarks
Date:   Tue,  9 Apr 2019 12:58:54 -0700
Message-Id: <20190409195924.1509-30-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409195924.1509-1-casey@schaufler-ca.com>
References: <20190409195924.1509-1-casey@schaufler-ca.com>
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

