Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12460C10F14
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E2E21736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ZAa7n1p+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfDSAr0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:47:26 -0400
Received: from sonic308-9.consmr.mail.bf2.yahoo.com ([74.6.130.48]:34647 "EHLO
        sonic308-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726835AbfDSAr0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634844; bh=DXZobVlHba7NLExIjhRRZRkmastZlDIkiPrs42J8njM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ZAa7n1p+STwlFVNBqWo9Y4OB7Z2nx4IE7YKFrIJutjojG/3deJ/qMl4vYxmo6dudcaTC3Tvdsfyr+R/DFk4iqVY/S/la4YJIeMzx0Fm/WEKbyq6vVoUHmgLFH/LP13GJSmCgAd8JV1BD7R4BoqK9YSG+Q3oH7vveg1DmC8TAIZO6xK91azY8OuCRJUKi/jn+1HGtn7HkEyP7a2Cktyn25ZNsnRo5cAT2HN7KNEZo5XxlUaaKyF2MfuZN3zU8gXZBWTdlOlXsejGFiSVTcNyFIN4y8PLC1U5cSojEI2pwbFJw035YtUEY65nJnniYiYuCK7PQc5iTI0QXbP7e6r/MQw==
X-YMail-OSG: 29drDCUVM1m9ueTQf2X0F3Ac.SKutwBfdjQkkrpegJlraiOnSy0.qNwTBGUk020
 RmcbEUNdOMyXbfN7n8HSMXZZwNjRnzKCsAcEUeNKoTXIEut9Ahfl9jwsgs89eYNGiFh_IFBU6BeB
 wF0R_Mc0sN6265WHjzKawqcwSIbIp_Y0i_Cxmq8BA_WgAQZAsAzHTgOIaUdpzdHnD9PjFP4lFb0g
 ubOzrKMGfhAwSAiN4SRDJwcuhjO0szzGoaCyrPBHsGr8OoFSjCYLwRkPi3NRR4y4HG5mViSgnawe
 KziziAwPCGbjWy8JkcrWMpjPQJvZrb6nNTT0qRveBQluUXXEqJ2snHvYzqiNbce2E.xHwH2xcFcv
 li27AyYIVN_0jEDWrAAH_HtlpLcSd6c8X6UXH46hgkaK0fiEjg7mXFQ12msgLsshud59qyiWEBSe
 Pj5_u5TJFTapf8fl2XiWPI_aDVXnjNzEGcg6u6JVOUa41klmByA5ceALQeyhaeNu.I2unQcTOBx8
 46GKz8imPtpEV6mAr8YU_0r4J1o12.E2Ql6ItooNdzAEigYuUfX_QxKL6d6EBmLq4Kkn7lF02WSv
 Kqf.NTMfL44xcb0okn8FKggtIwjRknNMCs0MNKW62sJAswVWJ7nsXAhCtRgcKGx5YMvhWytbtlzr
 .EwL0ftd5xR0De3fxVs7LPHiFSGGRckGVt34FSTETp1TEi59Le7EhKMeOV5xMd8vLTU2llsb_sl9
 _5IxtsVI2.YVwFJT30tJRNwRH.UCkhvSiXF.We8K0WlbHKkD.sVPXWe4oQZOQ7FH2Qv.ZIZSi0KX
 7Zj9BG6ciQNI54jPQ_slUY_80whGD2MyR1cUhr25GWIzPqSGZDySfanvy2OR.MvWEGMS6hqhh6Mg
 ikEFuOai57RoJDy3.G17_FnW6rlNnac1DJUQL5w.OC7fpPihJ5WsLbJuzYacbcjzJQMkIlQy88ba
 8WGkLnEaopo785xMqm3mzx5WQA98MuJhrVTZ3ktU7TrbZVGaV0EryTvYgITys95Qn3eyx.yiJ2bE
 nUfAI7XJzeIq12mp8fOYTVLam42K1ewlH2BS1DG2Ltk28JMYXj7GunlFzekU7_wfiqq2.Qje5Xp9
 XCOi2EYPE0AYv3jmulaj.MFbyG5hLrnSdRYq21Q8KAlGe7EL8UeTNwZLHzcvcRA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:47:24 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp428.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5d780a730ba98836fa707a31546db6ad;
          Fri, 19 Apr 2019 00:47:24 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 28/90] NET: Remove scaffolding on secmarks
Date:   Thu, 18 Apr 2019 17:45:15 -0700
Message-Id: <20190419004617.64627-29-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
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

